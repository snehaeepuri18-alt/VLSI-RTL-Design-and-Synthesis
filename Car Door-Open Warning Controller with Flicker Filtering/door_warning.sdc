create_clock -name clk -period 10 [get_ports clk]
set_input_delay  2 -clock clk [get_ports {door_open ignition moving}]
set_input_delay  5 -clock clk [get_ports rst_n]
set_output_delay 2 -clock clk [get_ports {warn_led buzzer}]
