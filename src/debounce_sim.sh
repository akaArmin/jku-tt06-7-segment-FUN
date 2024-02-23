iverilog -g2005 FUN debouncer_tb.v debouncer.v

vvp FUN 

gtkwave debouncer_tb.vcd

#iverilog -g2005 -o FUN tb_debounce.v tt_um_seven_segment_fun1.v seg7.v changing.v button.v button_to_pulse.v debouncer.v synchronizer.v

#

