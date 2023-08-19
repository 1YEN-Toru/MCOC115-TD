#Created Clock
create_clock -name clk -period 41.6 -waveform {0 20.8} [get_ports {clk}]
create_clock -name clkmul4 -period 2.6 -waveform {0 1.3} [get_nets {sdram/clkmul4}]

create_clock -name clksdc -period 10.4 -waveform {5.2 10.4} [get_nets {clksdc}]	# X=180
#create_clock -name clksdc -period 10.4 -waveform {6.5 11.7} [get_nets {clksdc}]	# X=225

#create_clock -name clksdr -period 10.4 -waveform {0 5.2} [get_nets {sdram/clksdr}]		# Y=0
#create_clock -name clksdr -period 10.4 -waveform {1.3 6.5} [get_nets {sdram/clksdr}]	# Y=45
create_clock -name clksdr -period 10.4 -waveform {2.6 7.8} [get_nets {sdram/clksdr}]	# Y=90
#create_clock -name clksdr -period 10.4 -waveform {3.9 9.1} [get_nets {sdram/clksdr}]	# Y=135
#create_clock -name clksdr -period 10.4 -waveform {5.2 10.4} [get_nets {sdram/clksdr}]	# Y=180
#create_clock -name clksdr -period 10.4 -waveform {6.5 11.7} [get_nets {sdram/clksdr}]	# Y=225

#Set Multicycle Path
set_multicycle_path  -setup -end -from [get_clocks {clk}] -to [get_clocks {clksdc}] 2
set_multicycle_path  -hold -end -from [get_clocks {clk}] -to [get_clocks {clksdc}] 2
set_multicycle_path  -setup -end -from [get_clocks {clk}] -to [get_clocks {clksdc}] -through [get_nets {sdram/sdrc/ssys/tgl_clk}] 1
set_multicycle_path  -setup -start -from [get_clocks {clksdc}] -to [get_clocks {clk}] 4
set_multicycle_path  -hold -start -from [get_clocks {clksdc}] -to [get_clocks {clk}] 4
