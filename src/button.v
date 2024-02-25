// `timescale 1ns / 1ps
// `include "debouncer.v"
// `include "synchronizer.v"
// `include "button_to_pulse.v"

module button(
    input wire clk, 
    input wire reset, 
    input wire button_in,
    output wire one_shot_pulse  // One-shot pulse output
);

    // Output of the debouncer
    wire debounced_out;

    // Instantiate the debouncer
    debouncer my_debouncer(
        .clk(clk), 
        .reset(reset), 
        .button_in(button_in), 
        .debounced_out(debounced_out)
    );

    // Output of the synchronizer
    wire sync_out;

    // Instantiate the synchronizer
    synchronizer my_synchronizer(
        .clk(clk), 
        .async_signal(debounced_out), 
        .sync_signal(sync_out)
    );

    // Instantiate the button to one-shot pulse module
    button_to_pulse my_button_to_pulse(
        .clk(clk), 
        .reset(reset), 
        .button_in(sync_out),  // Input is the synchronized debounced signal
        .one_shot_pulse(one_shot_pulse)
    );

endmodule
