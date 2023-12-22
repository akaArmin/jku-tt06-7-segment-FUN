`timescale 1ns / 1ps 

  

module tb_fun; 

  

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

  

    // Clock generation 

    initial begin 

        clk = 0; 

        forever #50 clk = ~clk;  // Generate a clock with 100ns period (10MHz) 

    end 

  

    // Test sequence 

    initial begin 

        // Initialize Inputs 

        ui_in = 0; 

        uio_in = 0; 

        ena = 0; 

        rst_n = 0; 

  

        // Reset the module 

        #20; 

        rst_n = 1; 

  

        // Enable the module 

        #20; 

        ena = 1; 

  

        // Stimulate the inputs to test the module functionality 

        // Example: Increment animation state and increase speed 

        #100;  

        ui_in[0] = 1;  // Press button to increment animation 

        #20;  

        ui_in[0] = 0;  // Release button 

        #100; 

        ui_in[2] = 1;  // Press button to increase speed 

        #20;  

        ui_in[2] = 0;  // Release button 


        #500; 

        $stop; 

    end 

       

endmodule 

 
