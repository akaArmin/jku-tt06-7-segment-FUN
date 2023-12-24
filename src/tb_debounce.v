`default_nettype none
`timescale 1ns/1ps

/*
iverilog -g2005 -o FUN tb.v tt_um_seven_segment_fun_akaArmin.v decoder.v
vvp FUN
gtkwave tb.vcd
*/

// testbench is controlled by test.py
module tb_debounce;

    // TB Signals
    reg clk = 0;        // Clock
    reg rst_n = 1;      // Reset (activ low)
    reg ena = 1;        // Enable
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    reg [6:0] uo_out;

    wire [6:0] segments = uo_out[6:0];
    
    reg btn1_incAni = ui_in[0];
    reg btn2_decAni = ui_in[1];
    reg btn3_incSpeed = ui_in[2];
    reg btn4_decSpeed = ui_in[3];
     
    
    // Instantiate the Unit Under Test -> UUT
    tt_um_seven_segment_fun1 uut (
        .ui_in      (ui_in),    // Dedicated inputs
        .uo_out     (uo_out),   // Dedicated outputs
        .uio_in     (uio_in),   // IOs: Input path
        .uio_out    (uio_out),  // IOs: Output path
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena        (ena),      // enable - goes high when design is selected
        .clk        (clk),      // clock
        .rst_n      (rst_n)     // not reset
    );

    // Clock Generation -> 10MHz = 50ns
    always #50 clk = ~clk;
    
    initial begin
        $dumpfile ("tb_fun.vcd");
        $dumpvars (0, tb);
        
        // Reset
        rst_n = 0;
        #20;
        rst_n = 1;
        #40;

        btn1_incAni = 1; #100;
        btn1_incAni = 0; #100;
        btn1_incAni = 1; #100;
        btn1_incAni = 0; #100;
        btn1_incAni = 1; #100;
        btn1_incAni = 0; #100;
        btn1_incAni = 1; #100;
        btn1_incAni = 0; #100;
        btn1_incAni = 0;

        btn2_decAni = 1; #100;
        btn2_decAni = 0; #100;
        btn2_decAni = 1; #100;
        btn2_decAni = 0; #100;
        btn2_decAni = 1; #100;
        btn2_decAni = 0; #100;
        btn2_decAni = 1; #100;
        btn2_decAni = 0; #100;
        btn2_decAni = 0;

        btn3_incSpeed = 1; #100;
        btn3_incSpeed = 0; #100;
        btn3_incSpeed = 1; #100;
        btn3_incSpeed = 0; #100;
        btn3_incSpeed = 1; #100;
        btn3_incSpeed = 0; #100;
        btn3_incSpeed = 1; #100;
        btn3_incSpeed = 0; #100;
        btn3_incSpeed = 0;

        btn4_decSpeed = 1; #100;
        btn4_decSpeed = 0; #100;
        btn4_decSpeed = 1; #100;
        btn4_decSpeed = 0; #100;
        btn4_decSpeed = 1; #100;
        btn4_decSpeed = 0; #100;
        btn4_decSpeed = 1; #100;
        btn4_decSpeed = 0; #100;
        btn4_decSpeed = 0;

        $finish;
    end

    /*
    task perform_test;
        for (integer i = 0; i < 250; i++) begin
            data_in = i;    // Generate 10-bit test data
            strobe_in = 1;  // Strobe signal active
            #20;
            strobe_in = 0;  // Strobe signal inactive
            #20;
        end
    endtask
    */
endmodule
