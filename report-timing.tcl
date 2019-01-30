project_open lagtester

create_timing_netlist -model slow
read_sdc
update_timing_netlist

check_timing -include {latches loops}

report_timing \
    -setup \
    -npaths 2000 \
    -detail full_path \
    -panel_name {Report Timing} \
    -multi_corner \
    -file "output_files/worst_case_setup_paths.rpt"

report_min_pulse_width \
    -nworst 2000 \
    -detail full_path \
    -panel_name {Report Timing} \
    -multi_corner \
    -file "output_files/worst_case_min_pulse_width.rpt"

set domain_list [get_clock_fmax_info]
foreach domain $domain_list {
    set name [lindex $domain 0]
    set fmax [lindex $domain 1]
    set restricted_fmax [lindex $domain 2]
puts "Clock $name : Fmax = $fmax (Restricted Fmax = \
 $restricted_fmax)"
}

project_close
