`timescale 1ns/1ps

module tb_door_warning;

    // Must match the DELAY the design was built with (default 8).
    localparam DELAY  = 8;
    localparam SETTLE = DELAY + 12;

    reg  clk = 0, rst_n = 0;
    reg  door_open = 0, ignition = 0, moving = 0;
    wire warn_led, buzzer;

    integer errors = 0;
    integer tests  = 0;
    reg     ever_warn = 0;

    door_warning dut (
        .clk(clk), .rst_n(rst_n),
        .door_open(door_open), .ignition(ignition), .moving(moving),
        .warn_led(warn_led), .buzzer(buzzer)
    );

    always #5 clk = ~clk;

    initial begin
`ifdef GLS
        $dumpfile("door_warning_gls.vcd");
        $display("MODE: gate-level (-DGLS)");
    `ifdef FUNCTIONAL
        $display("FUNCTIONAL macro: defined");
    `else
        $display("WARNING: FUNCTIONAL macro NOT defined - cell models will give x");
    `endif
`else
        $dumpfile("door_warning_rtl.vcd");
        $display("MODE: RTL");
`endif
        $dumpvars(0, tb_door_warning);
    end

    task wait_cycles(input integer n);
        integer i;
        begin
            for (i = 0; i < n; i = i + 1) @(negedge clk);
        end
    endtask

    task check(input exp_led, input exp_buz, input [8*40-1:0] name);
        begin
            tests = tests + 1;
            if (warn_led !== exp_led || buzzer !== exp_buz) begin
                errors = errors + 1;
                $display("FAIL: %0s | led=%b (exp %b) buzzer=%b (exp %b) @%0t",
                         name, warn_led, exp_led, buzzer, exp_buz, $time);
            end else
                $display("PASS: %0s", name);
        end
    endtask

    // Any output that is not a clean 0 counts as a warning (so x also fails)
    always @(negedge clk)
        if (warn_led !== 1'b0 || buzzer !== 1'b0) ever_warn <= 1'b1;

    task door_pulse_expect_ignored(input integer n, input [8*40-1:0] name);
        begin
            ever_warn = 0;
            wait_cycles(1);
            door_open = 1;
            wait_cycles(n);
            door_open = 0;
            wait_cycles(SETTLE);
            tests = tests + 1;
            if (ever_warn) begin
                errors = errors + 1;
                $display("FAIL: %0s (output not clean 0)", name);
            end else
                $display("PASS: %0s", name);
        end
    endtask

    initial begin
        // 1. reset
        wait_cycles(3);
        check(0, 0, "reset: outputs low");
        rst_n = 1;
        wait_cycles(2);
        check(0, 0, "idle after reset");

        // 2. door open, ignition off -> no warning
        door_open = 1;
        wait_cycles(SETTLE);
        check(0, 0, "door open, ignition off");

        // 3. ignition on, stopped -> LED only
        ignition = 1;
        wait_cycles(SETTLE);
        check(1, 0, "door open, ign on, stopped: LED");

        // 4. moving -> LED + buzzer
        moving = 1;
        wait_cycles(SETTLE);
        check(1, 1, "door open, moving: LED + buzzer");

        // 5. stop -> buzzer off, LED stays
        moving = 0;
        wait_cycles(SETTLE);
        check(1, 0, "stopped again: buzzer off");

        // 6. close door -> all clear
        door_open = 0;
        wait_cycles(SETTLE);
        check(0, 0, "door closed: clear");

        // 7. moving with door closed -> no warning
        moving = 1;
        wait_cycles(SETTLE);
        check(0, 0, "moving, door closed: no warning");
        moving = 0;
        wait_cycles(SETTLE);

        // 8. flicker shorter than DELAY, and pulse of exactly DELAY: ignored
        door_pulse_expect_ignored(DELAY - 1, "flicker of DELAY-1 cycles ignored");
        door_pulse_expect_ignored(DELAY,     "pulse of DELAY cycles ignored");

        // 9. door opens while already moving -> straight to alarm
        moving = 1;
        door_open = 1;
        wait_cycles(SETTLE);
        check(1, 1, "door opens while moving: alarm");

        // 10. ignition off while alarm -> clear
        ignition = 0;
        wait_cycles(SETTLE);
        check(0, 0, "ignition off: clear");

        // 11. reset in the middle of an alarm
        ignition = 1;
        wait_cycles(SETTLE);
        check(1, 1, "alarm active again");
        rst_n = 0;
        wait_cycles(2);
        check(0, 0, "reset during alarm: clear");
        rst_n = 1;
        door_open = 0; moving = 0; ignition = 0;
        wait_cycles(SETTLE);
        check(0, 0, "idle after reset");

        $display("-----------------------------------------");
        if (errors == 0) $display("ALL %0d CHECKS PASSED", tests);
        else             $display("%0d of %0d CHECKS FAILED", errors, tests);
        $finish;
    end

    initial begin
        #200000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
