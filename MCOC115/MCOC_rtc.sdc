#Created Clock
create_clock -name clk -period 40 -waveform {0 20} [get_ports {clk}]
create_clock -name clk32k -period 15200 -waveform {0 7600} [get_nets {rtc/clk32k}]

#Set False Path
set_false_path  -from [get_clocks {clk}] -to [get_clocks {clk32k}]
set_false_path  -from [get_clocks {clk32k}] -to [get_clocks {clk}]

