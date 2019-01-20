##################
# input clocks   #
##################
create_clock -period 27Mhz -name clock [get_ports clock]
create_generated_clock -multiply_by 11 -divide_by 2 -name data_clock -source {pll|pll|altpll_component|auto_generated|pll1|inclk[0]} {pll|pll|altpll_component|auto_generated|pll1|clk[0]}
create_generated_clock -multiply_by 11 -divide_by 2 -phase 0 -name output_clock -source {pll|pll|altpll_component|auto_generated|pll1|inclk[0]} {pll|pll|altpll_component|auto_generated|pll1|clk[1]}

##################
# internal clock #
##################
create_clock -name int_osc_clk -period 55MHz [get_pins -compatibility {control_clock_gen|int_osc_0|oscillator_dut|clkout}]
create_generated_clock -name pll_reconfig_clock -source [get_pins -compatibility {control_clock_gen|int_osc_0|oscillator_dut|clkout}] -divide_by 2 -multiply_by 1 "pll_main:pll|control_clock_2"  

derive_pll_clocks
derive_clock_uncertainty

##################
# false paths    #
##################
set_false_path -from [get_ports {RES_CONFIG*}]
set_clock_groups -exclusive -group data_clock -group int_osc_clk

##################
# output delays  #
##################
set tSU 1.5
set tH 1.6
set adv_clock_delay 0.0
set dvi_outputs [get_ports {DVI_RED* DVI_GREEN* DVI_BLUE* DVI_DE DVI_HSYNC DVI_VSYNC}]
set_output_delay -clock output_clock -reference_pin [get_ports DVI_CLOCK] -max [expr $tSU - $adv_clock_delay] $dvi_outputs
set_output_delay -clock output_clock -reference_pin [get_ports DVI_CLOCK] -min [expr 0 - $tH - $adv_clock_delay ] $dvi_outputs
set_false_path -setup -rise_from [get_clocks data_clock] -fall_to [get_clocks output_clock]
set_false_path -setup -fall_from [get_clocks data_clock] -rise_to [get_clocks output_clock]
set_false_path -hold -rise_from [get_clocks data_clock] -rise_to [get_clocks output_clock]
set_false_path -hold -fall_from [get_clocks data_clock] -fall_to [get_clocks output_clock]
set_false_path -to [remove_from_collection [all_outputs] "$dvi_outputs"]
