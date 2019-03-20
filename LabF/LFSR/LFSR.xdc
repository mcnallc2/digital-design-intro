## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports top_CCLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports top_CCLK]
	#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
# Switches
set_property PACKAGE_PIN V17 [get_ports {top_reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_reset}]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {top_lfsr_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[0]}]
set_property PACKAGE_PIN E19 [get_ports {top_lfsr_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[1]}]
set_property PACKAGE_PIN U19 [get_ports {top_lfsr_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[2]}]
set_property PACKAGE_PIN V19 [get_ports {top_lfsr_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[3]}]
set_property PACKAGE_PIN W18 [get_ports {top_lfsr_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[4]}]
set_property PACKAGE_PIN U15 [get_ports {top_lfsr_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[5]}]
set_property PACKAGE_PIN U14 [get_ports {top_lfsr_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[6]}]
set_property PACKAGE_PIN V14 [get_ports {top_lfsr_out[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[7]}]
set_property PACKAGE_PIN V13 [get_ports {top_lfsr_out[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[8]}]
set_property PACKAGE_PIN V3 [get_ports {top_lfsr_out[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[9]}]
set_property PACKAGE_PIN W3 [get_ports {top_lfsr_out[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[10]}]
set_property PACKAGE_PIN U3 [get_ports {top_lfsr_out[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[11]}]
set_property PACKAGE_PIN P3 [get_ports {top_lfsr_out[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[12]}]
set_property PACKAGE_PIN N3 [get_ports {top_lfsr_out[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_lfsr_out[13]}]
set_property PACKAGE_PIN P1 [get_ports {top_max_tick_reg}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_max_tick_reg}]
set_property PACKAGE_PIN L1 [get_ports {top_clk}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {top_clk}]
