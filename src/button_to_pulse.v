//`timescale 1ns / 1ps

module button_to_pulse (
    input wire clk,            // Clock input
    input wire reset,          // Reset input
    input wire button_in,      // Button input signal
    output reg one_shot_pulse  // One-shot pulse output
);

    reg last_button_state;  // To store the last state of the button

    // Detect rising edge and assign output concurrently
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            last_button_state <= 0;
            one_shot_pulse <= 0;
        end else begin
            last_button_state <= button_in;
            one_shot_pulse <= button_in && !last_button_state;
        end
    end

endmodule
