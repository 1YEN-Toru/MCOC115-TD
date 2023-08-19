#Created Clock
create_clock -name clk -period 40 -waveform {0 20} [get_ports {clk}]
create_clock -name clk16m -period 60 -waveform {0 30} [get_nets {adc/clk16m}]

#Set False Path
set_false_path  -from [get_clocks {clk}] -to [get_clocks {clk16m}]
set_false_path  -from [get_clocks {clk16m}] -to [get_clocks {clk}]

