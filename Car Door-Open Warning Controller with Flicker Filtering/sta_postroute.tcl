read_liberty -min $::env(LIB)
read_liberty -max $::env(LIB)
read_verilog /home/vsduser/Desktop/work/tools/openlane_working_dir/openlane/designs/door_warning/runs/run1/results/lvs/door_warning.lvs.powered.v
link_design door_warning
read_sdc door_warning.sdc
read_spef /home/vsduser/Desktop/work/tools/openlane_working_dir/openlane/designs/door_warning/runs/run1/results/routing/door_warning.spef
set_propagated_clock [all_clocks]
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
