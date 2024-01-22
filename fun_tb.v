`timescale 1ns / 1ps
`include "tt_um_seven_segment_fun.v"
module tt_um_seven_segment_fun1_tb;

    // Inputs
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    reg ena;
    reg clk;
    reg rst_n;

    // Outputs
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Instantiate the Unit Under Test (UUT)
    tt_um_seven_segment_fun1 uut (
        .ui_in(ui_in),    
        .uo_out(uo_out),  
        .uio_in(uio_in),   
        .uio_out(uio_out),
        .uio_oe(uio_oe),  
        .ena(ena),      
        .clk(clk),      
        .rst_n(rst_n)     
    );

    // Clock generation (10 MHz)
    always #50 clk = ~clk; // Toggle every 50ns, creating a 10MHz clock

    // Test procedure
    initial begin
        $dumpfile ("tt_um_seven_segment_fun1_tb.vcd"); 
        $dumpvars (0, tt_um_seven_segment_fun1_tb);   

        // Initialize Inputs
        clk = 0;
        rst_n = 0;
        ena = 0;
        ui_in = 8'b0;
        uio_in = 8'b0;

        // Reset the system
        #100; 
        rst_n = 1;
        #100;
        rst_n = 0;
        #100;

        // Enable the module
        ena = 1;

        // Simulate button presses
        // Assuming each button press increments or decrements the counter
        repeat (10) begin
            ui_in[0] = 1; // Simulate button press for incAni
            #200;
            ui_in[0] = 0;
            #200;

            ui_in[1] = 1; // Simulate button press for decAni
            #200;
            ui_in[1] = 0;
            #200;

            ui_in[2] = 1; // Simulate button press for incSpeed
            #200;
            ui_in[2] = 0;
            #200;

            ui_in[3] = 1; // Simulate button press for decSpeed
            #200;
            ui_in[3] = 0;
            #200;
        end

        // Finish simulation
        $finish;
    end
      
endmodule
