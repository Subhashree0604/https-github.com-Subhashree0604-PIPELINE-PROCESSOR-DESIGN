@echo off
iverilog -o fir_sim fir_filter.v tb_fir_filter.v
vvp fir_sim
gtkwave fir_wave.vcd
pause
