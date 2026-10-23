read_liberty $::env(LIB)
read_verilog door_warning_net.v
link_design door_warning
read_sdc door_warning.sdc
puts "########## CORNER: $::env(CORNER) ##########"
puts "===== SETUP (max) ====="
report_checks -path_delay max -format full
puts "===== HOLD (min) ====="
report_checks -path_delay min -format full
puts "===== SUMMARY ====="
report_worst_slack -max
report_worst_slack -min
report_tns
exit
