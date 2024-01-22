`timescale 1ns / 1ps
module fun_tb;

    // Inputs
    

    	
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    reg ena;
    reg clk;
    reg rst_n;
    
    wire btn1_incAni;
    wire btn2_decAni;
    wire btn3_incSpeed;
    wire btn4_decSpeed;
    
    reg btn1_incAni = ui_in[0];
    reg btn2_decAni = ui_in[1];
    reg btn3_incSpeed = ui_in[2];
    reg btn4_decSpeed = ui_in[3];
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
        $dumpvars (0, fun_tb);   

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
            btn1_incAni = 1; // Simulate button press for incAni
            #1000;
            btn1_incAni = 0;
            #1000;

            btn2_decAni = 1; // Simulate button press for decAni
            #1000;
            btn2_decAni = 0;
            #1000;

            btn3_incSpeed[2] = 1; // Simulate button press for incSpeed
            #1000;
            btn3_incSpeed[2] = 0;
            #1000;

            btn4_decSpeed= 1; // Simulate button press for decSpeed
            #1000;
            btn4_decSpeed = 0;
            #1000;
        end

        // Finish simulation
        $finish;
    end
      
endmodule
