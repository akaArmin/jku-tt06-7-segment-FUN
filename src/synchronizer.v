//`timescale 1ns / 1ps

module synchronizer(
    input wire clk,           // Clock input
    input wire async_signal,  // Asynchronous signal input
    output reg sync_signal    // Synchronized signal output
);

    reg [1:0] intermediate;

    always @(posedge clk) begin
        intermediate[0] <= async_signal;     // First stage of synchronization
        intermediate[1] <= intermediate[0];  // Second stage of synchronization
        sync_signal <= intermediate[1];      // Third stage of synchronization
    end

endmodule
