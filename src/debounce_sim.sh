iverilog -g2005 FUN debouncer_tb.v debouncer.v

vvp FUN 

gtkwave debouncer_tb.vcd
