`timescale 1ns/1ps
// Car door-open warning
//   door open (stable) + ignition on + car stopped -> warn_led
//   door open (stable) + ignition on + car moving  -> warn_led + buzzer
// A delay counter ignores short flicker on the door switch.

module door_warning #(
    parameter DELAY = 8                  // cycles the door must stay open
)(
    input  wire clk,
    input  wire rst_n,                   // active-low asynchronous reset
    input  wire door_open,
    input  wire ignition,
    input  wire moving,
    output wire warn_led,
    output wire buzzer
);

    localparam CW = $clog2(DELAY + 1);

    // 2-flop synchronizers
    reg [1:0] door_sync, ign_sync, mov_sync;
    wire door_s = door_sync[1];
    wire ign_s  = ign_sync[1];
    wire mov_s  = mov_sync[1];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            door_sync <= 2'b00;
            ign_sync  <= 2'b00;
            mov_sync  <= 2'b00;
        end else begin
            door_sync <= {door_sync[0], door_open};
            ign_sync  <= {ign_sync[0],  ignition};
            mov_sync  <= {mov_sync[0],  moving};
        end
    end

    // door-open delay counter
    reg [CW-1:0] cnt;
    wire door_stable = (cnt == DELAY);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt <= {CW{1'b0}};
        else if (!door_s)
            cnt <= {CW{1'b0}};
        else if (!door_stable)
            cnt <= cnt + 1'b1;
    end

    // FSM
    localparam [1:0] IDLE  = 2'b00,
                     WARN  = 2'b01,
                     ALARM = 2'b10;

    reg [1:0] state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else begin
            if (!(door_stable && door_s && ign_s))
                state <= IDLE;
            else if (mov_s)
                state <= ALARM;
            else
                state <= WARN;
        end
    end

    assign warn_led = (state != IDLE);
    assign buzzer   = (state == ALARM);

endmodule
