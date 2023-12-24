`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py

iverilog -g2005 -o FUN tb.v tt_um_seven_segment_fun_akaArmin.v decoder.v
vvp FUN
gtkwave tb.vcd
*/

// testbench is controlled by test.py
module tb (
    input clk,
    input btn1_incAni,
    input btn2_decAni,
    input btn3_incSpeed,
    input btn4_decSpeed
);

    // TB Signals


    // Clock Generation -> ?? Hz
    always #10 clk = ~clk;
    
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
    reg  clk;
    reg  rst_n;
    reg  ena;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;

    wire [6:0] segments = uo_out[6:0];
    
    tt_um_seven_segment_fun1 tt_um_seven_segment_fun1 (
    // include power ports for the Gate Level test
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .ui_in      (ui_in),    // Dedicated inputs
        .uo_out     (uo_out),   // Dedicated outputs
        .uio_in     (uio_in),   // IOs: Input path
        .uio_out    (uio_out),  // IOs: Output path
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena        (ena),      // enable - goes high when design is selected
        .clk        (clk),      // clock
        .rst_n      (rst_n)     // not reset
        );

endmodule
