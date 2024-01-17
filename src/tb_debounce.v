// `default_nettype none 
`timescale 1ms/1ns
`include "seg7.v"
`include "changing.v"

/* 
iverilog -g2005 -o FUN tb.v tt_um_seven_segment_fun_akaArmin.v decoder.v 
vvp FUN 
gtkwave tb.vcd 
*/ 

// testbench is controlled by test.py
module tb_debounce; 

    // TB Signals 
    reg clk = 0;        // Clock 
    reg rst_n = 0;      // Reset

    reg [7:0] ui_in; 
    reg [7:0] uio_in; 
    wire [7:0] uo_out; 
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
 
    wire [6:0] segments = uo_out[6:0]; 

    wire btn1 = ui_in[0]; 
    wire btn2 = ui_in[1]; 
    wire btn3 = ui_in[2]; 
    wire btn4 = ui_in[3]; 
        

    // Instantiate the Unit Under Test -> UUT
    tt_um_seven_segment_fun1 tt_um_seven_segment_fun1 ( 
        .ui_in      (ui_in),    // Dedicated inputs 
        .uo_out     (uo_out),   // Dedicated outputs 
        .uio_in     (uio_in),   // IOs: Input path 
        .uio_out    (uio_out),  // IOs: Output path 
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output) 
        .ena        (ena),      // enable - goes high when design is selected 
        .clk        (clk),      // clock 
        .rst_n      (rst_n)     // not reset 
    ); 

    // Clock Generation -> 10MHz = 1 / 0.0001ms
    /* verilator lint_off STMTDLY */ 
    always #0.0001 clk = ~clk; 
    /* verilator lint_on STMTDLY */

    initial begin 
        $dumpfile ("tb_debounce.vcd"); 
        $dumpvars (0, tb_debounce);        
	
        /* verilator lint_off STMTDLY */
        ui_in[0] = 0;
        ui_in[1] = 0;
        ui_in[2] = 0;
        ui_in[3] = 0;
	
        // Reset 
        #10 rst_n = 1; 
        #10 rst_n = 0;

        #20 ui_in[0] = 0;
        #10 ui_in[0] = 1;
        #100 ui_in[0] = 0;
        #10 ui_in[0] = 1;
        #200 ui_in[0] = 0;
        #10 ui_in[0] = 1;
        #20 ui_in[0] = 0;
        #100 ui_in[0] = 1;
        #10 ui_in[0] = 0; 

        #500;

        ui_in[1] = 0;
        #10 ui_in[1] = 1;
        #100 ui_in[1] = 0;
        #10 ui_in[1] = 1;
        #200 ui_in[1] = 0;
        #10 ui_in[1] = 1;
        #20 ui_in[1] = 0;
        #100 ui_in[1] = 1;
        #10 ui_in[1] = 0;  

        #500;

        ui_in[2] = 0;
        #10 ui_in[2] = 1;
        #100 ui_in[2] = 0;
        #10 ui_in[2] = 1;
        #200 ui_in[2] = 0;
        #10 ui_in[2] = 1;
        #20 ui_in[2] = 0;
        #100 ui_in[2] = 1;
        #10 ui_in[2] = 0;  

        #500;

        ui_in[3] = 0;
        #10 ui_in[3] = 1;
        #100 ui_in[3] = 0;
        #10 ui_in[3] = 1;
        #200 ui_in[3] = 0;
        #10 ui_in[3] = 1;
        #20 ui_in[3] = 0;
        #100 ui_in[3] = 1;
        #10 ui_in[3] = 0;  

        #1000;
        $finish; 

        /* verilator lint_on STMTDLY */
    end 
endmodule 
