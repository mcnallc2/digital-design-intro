## This file is a .xdc for the LFSR sequence detector

# Clock signal
set_property PACKAGE_PIN W5 [get_ports top_CCLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports top_CCLK]

# Switches
set_property PACKAGE_PIN V17 [get_ports top_reset]					
	set_property IOSTANDARD LVCMOS33 [get_ports top_reset]
set_property PACKAGE_PIN R2 [get_ports choose_freq]					
    set_property IOSTANDARD LVCMOS33 [get_ports choose_freq]

# LEDs
set_property PACKAGE_PIN L1 [get_ports seq_detection]					
	set_property IOSTANDARD LVCMOS33 [get_ports seq_detection]
set_property PACKAGE_PIN U16 [get_ports pause_clk]					
    set_property IOSTANDARD LVCMOS33 [get_ports pause_clk]
	
#7 segment display
set_property PACKAGE_PIN W7 [get_ports {seven_seg[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[6]}]
set_property PACKAGE_PIN W6 [get_ports {seven_seg[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[5]}]
set_property PACKAGE_PIN U8 [get_ports {seven_seg[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[4]}]
set_property PACKAGE_PIN V8 [get_ports {seven_seg[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seven_seg[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[2]}]
set_property PACKAGE_PIN V5 [get_ports {seven_seg[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[1]}]
set_property PACKAGE_PIN U7 [get_ports {seven_seg[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[0]}]

set_property PACKAGE_PIN V7 [get_ports {seven_seg[7]}]							
	set_property IOSTANDARD LVCMOS33 [get_ports {seven_seg[7]}]

set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]