`timescale 1ns / 1ps

module debouncer_tb;

    // Inputs
    reg clk;
    reg reset;
    reg button_in;

    // Outputs
    wire debounced_out;

    // Instantiate the Unit Under Test (UUT)
    debouncer uut (
        .clk(clk), 
        .reset(reset), 
        .button_in(button_in), 
        .debounced_out(debounced_out)
    );

    // Clock generation (50 MHz)
    always #10 clk = ~clk; // Toggle every 10ns, creating a 50MHz clock

    // Test procedure
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        button_in = 0;

        // Reset the system
        #100; 
        reset = 0;
        #100;
        reset = 1;
        #100;

        // Simulate button press and release
        // Assuming DEBOUNCE_TIME is long enough to filter out these bounces
        repeat (5) begin
            button_in = 1;
            #20;    // Button press
            button_in = 0;
            #20;    // Button release
        end

        // Simulate a long button press
        #100;
        button_in = 1;
        #100000; // Hold button for a longer period
        button_in = 0;
        #100;

        // Finish simulation
        $finish;
    end
      
endmodule
