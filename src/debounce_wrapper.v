// This module instantiates 5 debounce modules and connects them to the buttons and results logics.

module debounce_wrapper(
    input wire clk,                 // The clock signal
    input wire rst_n,               // The reset signal
    input wire [4:0] buttons,       // A 5-bit wide wire to hold the states of 5 buttons
    output wire [4:0] results       // A 5-bit wide wire to hold the debounced results
);

    generate                        // Generate 5 debounce instances (This is one of the few good places to use a for loop in System Verilog)
        genvar i;                   // Declare a generate variable, this is used to index the for loop to quickly instantiate multiple modules
        for (i = 0; i < 5; i = i + 1) begin: debounce_instances
            // Instantiate the debounce module
            debounce #(25000000, 10) generic_debounce (
                .clk(clk),              // Connect the clock signal to the debounce module
                .button(buttons[i]),    // Connect the ith button to the ith debounce module
                .reset_n(rst_n),        // Connect the reset signal to the debounce module
                .result(results[i])     // Connect the ith result to the ith debounce module
            );
        end
    endgenerate
    
endmodule
