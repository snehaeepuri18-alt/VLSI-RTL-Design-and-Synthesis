read_liberty -min $::env(LIB)
read_liberty -max $::env(LIB)
read_verilog door_warning_net.v
link_design door_warning
read_sdc door_warning.sdc
puts "CORNER: $::env(CORNER)"
puts "===== report_checks (setup, max) ====="
report_checks
puts "===== report_checks (hold, min) ====="
report_checks -path_delay min
puts "===== report_wns ====="
report_wns
puts "===== report_tns ====="
report_tns
exit
