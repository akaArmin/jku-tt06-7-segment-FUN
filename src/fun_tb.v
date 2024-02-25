`timescale 1ns / 1ps

module fun_tb;

    // Inputs
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    reg enable_module;
    reg clk;
    reg rst_n;

    // Button simulation signals
    reg simulate_btn_incAni;
    reg simulate_btn_decAni;
    reg simulate_btn_incSpeed;
    reg simulate_btn_decSpeed;

    // Outputs
    wire [7:0] seven_segment_output;
    wire [7:0] bidirectional_output;
    wire [7:0] bidirectional_output_enable;

    // Instantiate the Unit Under Test (UUT)
    tt_um_seven_segment_fun1 uut (
        .ui_in(ui_in),    
        .uo_out(seven_segment_output),  
        .uio_in(uio_in),   
        .uio_out(bidirectional_output),
        .uio_oe(bidirectional_output_enable),  
        .ena(enable_module),      
        .clk(clk),      
        .rst_n(rst_n)     
    );

    // Clock generation (10 MHz)
    always #50 clk = ~clk; // Toggle every 50ns, creating a 10MHz clock

    // Initialize button simulation signals
    initial begin
        simulate_btn_incAni = 0;
        simulate_btn_decAni = 0;
        simulate_btn_incSpeed = 0;
        simulate_btn_decSpeed = 0;
    end

    // Test procedure
    initial begin
        $dumpfile ("fun_tb.vcd"); 
        $dumpvars (0, fun_tb);   

        // Initialize Inputs
        clk = 0;
        rst_n = 1;
        ui_in = 8'b0;
        uio_in = 8'b0;

        // Reset the system
        #100; 
        rst_n = 0;
        #100;
        rst_n = 1;
        #100;

        // Simulate button presses
        /*
        repeat (10) begin
            simulate_btn_incAni = 1; 
            ui_in[0] = simulate_btn_incAni;
            #100000;
            simulate_btn_incAni = 0;
            ui_in[0] = simulate_btn_incAni;
            #100000;
	end
	#1000000;
	repeat (10) begin
            simulate_btn_decAni = 1;
            ui_in[1] = simulate_btn_decAni;
            #100000;
            simulate_btn_decAni = 0;
            ui_in[1] = simulate_btn_decAni;
            #100000;
	end
        */ 
        
        repeat (10) begin
            simulate_btn_incAni = 1; 
            ui_in[0] = simulate_btn_incAni;
            #100000;
            simulate_btn_incAni = 0;
            ui_in[0] = simulate_btn_incAni;
            #100000;
	end
	
	#2000000;
	/*
        repeat (10) begin
            simulate_btn_incSpeed = 1;
            ui_in[2] = simulate_btn_incSpeed;
            #100000;
            simulate_btn_incSpeed = 0;
            ui_in[2] = simulate_btn_incSpeed;
            #100000;
	end   
        
          
	*/
	repeat (6) begin
            simulate_btn_decSpeed = 1;
            ui_in[3] = simulate_btn_decSpeed;
            #100000;
            simulate_btn_decSpeed = 0;
            ui_in[3] = simulate_btn_decSpeed;
            #100000;
	end 
         
	#40000000;
	
        // Finish simulation
        $finish;
    end
      
endmodule
