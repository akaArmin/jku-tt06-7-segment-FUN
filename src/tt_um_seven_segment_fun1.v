`default_nettype none

/*
`include "seg7.v"
`include "changing.v"
`include "button.v"
`include "button_to_pulse.v"
`include "debouncer.v"
`include "synchronizer.v"*/

module tt_um_seven_segment_fun1 (
    input wire [7:0] ui_in,    
    output wire [7:0] uo_out,  
    input wire [7:0] uio_in,   
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,  
    input wire ena,      
    input wire clk,      
    input wire rst_n     
);
    // Debounced button signals
    wire debounced_btn1_incAni;
    wire debounced_btn2_decAni;
    wire debounced_btn3_incSpeed;
    wire debounced_btn4_decSpeed;

    // Pin assignment
    // wire clk = io_in[0]           // Input Clock -> 10MHz
    wire reset = !rst_n;            // Reset

    // Instantiate debouncer for each button
    button db_btn1(
    .clk(clk), 
    .reset(reset),
    .button_in(ui_in[0]), 
    .one_shot_pulse(debounced_btn1_incAni)
    );
    
    button db_btn2(
    .clk(clk), 
    .reset(reset), 
    .button_in(ui_in[1]), 
    .one_shot_pulse(debounced_btn2_decAni)
    );
    
    button db_btn3(
    .clk(clk), 
    .reset(reset), 
    .button_in(ui_in[2]), 
    .one_shot_pulse(debounced_btn3_incSpeed)
    );
    
    button db_btn4(
    .clk(clk), 
    .reset(reset), 
    .button_in(ui_in[3]), 
    .one_shot_pulse(debounced_btn4_decSpeed)
    );
    

   // 7-Segment-Display:
    wire [6:0] led_out;             // 7-Segment output
    assign uo_out[6:0] = led_out;   // Assign Pins
    assign uo_out[7] = 1'b0;        // Default set to low

    // Use bidirectionals as outputs
    assign uio_oe = 8'b11111111;

    // Put bottom 8 bits of the counter out on the bidirectional gpio
    assign uio_out = counter[7:0];

    // External clock is 10MHz, so need 24 bit counter
    parameter COUNTER_BIT = 25;
    reg [COUNTER_BIT-1:0] counter, next_counter;
    reg [5:0] digit, next_digit;
    wire [5:0] counterMAX;

    // FSM states - Animation
    localparam ST_ANI0   = 6'b000000;	// Animation 0
    localparam ST_ANImax = 6'b110010;	// Animation 50

    parameter ANI_BIT = 6;
    reg [ANI_BIT-1:0] animation;
    reg [ANI_BIT-1:0] next_animation;

    // Counter  value
    reg [COUNTER_BIT-1:0] compare = 10_000_000;      // Default 1 sek at 10MHz
    reg [COUNTER_BIT-1:0] next_compare = 10_000_000;


    localparam comMax = 25'b1001000011110101011000000;   // Maximum value for compare 19 Mio.
    localparam comMin = 1_000_000;    // Minimum value for compare
    localparam comInc = 1_000_000;    // Stepsize
/*
    // Testbench values!
    reg [COUNTER_BIT-1:0] compare = 10_000;      // tb value!
    reg [COUNTER_BIT-1:0] next_compare = 10_000;
    localparam comMax = 25'b0000000000100101000111000;   // tb value! 19k
    localparam comMin = 1_000;    // tb value!
    localparam comInc = 1_000;    // tb value!
*/   
    // Counter:
    always @(posedge clk or posedge reset) begin: register_process_counter
        if (reset) begin                    // If reset, set counter to 0
            counter <= {COUNTER_BIT{1'b0}};
            digit <= 0;
            compare <= 10_000_000;
            //compare <= 10_000;	// tb value!
        end else begin
            counter <= next_counter;
            digit <= next_digit;
            compare <= next_compare;
        end
    end

    always @(*) begin: combinatoric_counter
    	next_counter = counter;
        next_digit = digit;

        if (counter >= compare) begin       // If next_counter equals the value of compare
            next_counter = 0;               // Reset the next_counter
            next_digit = digit + 1;         // Increment digit
            if (digit >= counterMAX) begin
                next_digit = 0;
            end
        end else begin
            next_counter = counter + 1;     // Increment next_counter
        end
    end

    // Changing the speed with decounced button
    always @(*) begin: combinatoric_compare
        next_compare = compare;

        if (debounced_btn3_incSpeed && (compare <= comMax)) begin
            next_compare = compare + comInc;
        end else if (debounced_btn4_decSpeed && (compare >= comMin)) begin
            next_compare = compare - comInc;
        end
    end

    // Switching the states with debounced Button:
    always @(posedge clk or posedge reset) begin: register_process_animation
        if (reset) begin
            animation <= ST_ANI0;
        end else begin
            animation <= next_animation;
        end
    end

    always @(*) begin: combinatoric_animation
        next_animation = animation;
        if (debounced_btn1_incAni) begin
            if (animation == ST_ANImax) begin
                next_animation = ST_ANI0;
            end else begin
                next_animation = animation + 1;
            end
        end else if (debounced_btn2_decAni) begin
            if (animation == ST_ANI0) begin
                next_animation = ST_ANImax;
            end else begin
                next_animation = animation - 1;
            end
        end
    end

    // Instantiate segment display
    seg7 seg7(.counter(digit),.animation(animation),.segments(led_out));

    // Instantiate changing module
    changing changing(.animation(animation),.limit(counterMAX));

endmodule
