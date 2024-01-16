`default_nettype none

`include "seg7.v"
`include "changing.v"

module tt_um_seven_segment_fun1 (
    input wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input1=output)
    input wire ena,      // will go high when the design is enabled
    input wire clk,      // clock
    input wire rst_n     // reset_n - low to reset
);

    // Pin assignment
    // wire clk = io_in[0]           // Input Clock -> 10MHz
    wire reset = !rst_n;            // Reset
    wire btn1_incAni = ui_in[0];     // Switch forward to the next Animation
    wire btn2_decAni = ui_in[1];     // Switch backwards to the previous Animation
    wire btn3_incSpeed = ui_in[2];   // Increase the speed of the Animation
    wire btn4_decSpeed = ui_in[3];   // Decrease the speed of the Animation

    // assign ui_in[7:4] = 1'bz;
    // assign uio_in[7:0] = 1'bz;

    // Debouncing:
    parameter DEBOUNCE_BIT = 16;
    parameter DEBOUNCE_VAL = 20000;         // equals 20 ms at 10 MHz clk

    reg [DEBOUNCE_BIT-1:0] btn1_cnt, next_btn1_cnt;     // Initializing the counter for Button 1
    reg [DEBOUNCE_BIT-1:0] btn2_cnt, next_btn2_cnt;     // Initializing the counter for Button 2
    reg [DEBOUNCE_BIT-1:0] btn3_cnt, next_btn3_cnt;     // Initializing the counter for Button 3
    reg [DEBOUNCE_BIT-1:0] btn4_cnt, next_btn4_cnt;     // Initializing the counter for Button 4

    reg debo_btn1, next_debo_btn1;     // Debounce register Button 1
    reg debo_btn2, next_debo_btn2;     // Debounce register Button 2
    reg debo_btn3, next_debo_btn3;     // Debounce register Button 3
    reg debo_btn4, next_debo_btn4;     // Debounce register Button 4


   // 7-Segment-Display:
    wire [6:0] led_out;             // 7-Segment output
    assign uo_out[6:0] = led_out;   // Assign Pins
    assign uo_out[7] = 1'b0;        // Default set to low

    // Use bidirectionals as outputs
    assign uio_oe = 8'b11111111;

    // Put bottom 8 bits of second counter out on the bidirectional gpio
    assign uio_out = counter[7:0];

    // External clock is 10MHz, so need 24 bit counter
    parameter COUNTER_BIT = 24;
    reg [COUNTER_BIT-1:0] counter, next_counter;
    reg [4:0] digit, next_digit;
    wire [4:0] counterMAX;

    // FSM states - Animation
    localparam ST_ANI0   = 6'b000000;
    localparam ST_ANImax = 6'b111111;

    parameter STATE_BITS = 6;
    reg [STATE_BITS-1:0] currState;
    reg [STATE_BITS-1:0] nextState, next_nextState;
    reg [STATE_BITS-1:0] prevState, next_prevState;

    // Counter  value
    reg [COUNTER_BIT-1:0] compare = 10_000_000;      // Default 1 sek at 10MHz
    reg [COUNTER_BIT-1:0] next_compare = 10_000_000;

    localparam comMax = 19_000_000;   // Maximum value for compare
    localparam comMin = 1_000_000;    // Minimum value for compare
    localparam comInc = 1_000_000;    // Stepsize

    // Counter:
    always @(posedge clk or posedge reset) begin: register_process_counter
        if (reset) begin                    // If reset, set counter to 0
            counter <= {COUNTER_BIT{1'b0}};
            digit <= 5'b00000;
            compare <= 10_000_000;
        end else begin
            counter <= next_counter;
            digit <= next_digit;
            compare <= next_compare;
        end
    end

    always @(*) begin: combinatoric_counter
    	next_counter = counter;
        if (counter == compare) begin       // If secound_counter equals the value of compare
            next_counter = 0; // Reset the secound_counter
            next_digit = digit + 1;     // Increment digit
            if (digit >= counterMAX) begin
                next_digit = 0;
            end
        end else begin
            next_counter = counter + 1;  // Increment secound_counter
        end
    end

    // Changing the speed with decounced button
    always @(*) begin: combinatoric_compare
        next_compare = compare;

        if (debo_btn3 && (compare <= comMax)) begin
            next_compare = compare + comInc;
        end else if (debo_btn4 && (compare >= comMin)) begin
            next_compare = compare - comInc;
        end
    end

    // Switching the states with debounced Button:
    always @(posedge clk or posedge reset) begin: register_process_state
        if (reset) begin
            currState <= ST_ANI0;
            nextState <= ST_ANI0 + 6'b000001;
            prevState <= ST_ANImax;
        end else begin
            nextState <= next_nextState;
            prevState <= next_prevState;
        end
    end

    always @(*) begin: combinatoric_state
        if (debo_btn1) begin
            next_nextState = nextState;
            if (nextState != ST_ANImax) begin
                prevState = currState;
                currState = nextState;
                next_nextState = nextState + 6'b000001;
            end else begin
                prevState = currState;
                currState = nextState;
                nextState = ST_ANI0;
            end
        end else if (debo_btn2) begin
            next_prevState = prevState;
            if (prevState != ST_ANI0) begin
                nextState = currState;
                currState = prevState;
                next_prevState = prevState - 6'b000001;
            end else begin
                next_nextState = currState;
                currState = prevState;
                next_prevState = ST_ANImax;
            end
        end
    end

    // Debouncing Section
    always @(posedge clk or posedge reset) begin: register_process_buttons
        if (reset) begin
            btn1_cnt <= 0;
            btn2_cnt <= 0;
            btn3_cnt <= 0;
            btn4_cnt <= 0;

            debo_btn1 <= 1'b0;
            debo_btn2 <= 1'b0;
            debo_btn3 <= 1'b0;
            debo_btn4 <= 1'b0;

        end else begin
            btn1_cnt <= next_btn1_cnt;
            btn2_cnt <= next_btn2_cnt;
            btn3_cnt <= next_btn3_cnt;
            btn4_cnt <= next_btn4_cnt;

            debo_btn1 <= next_debo_btn1;
            debo_btn2 <= next_debo_btn2;
            debo_btn3 <= next_debo_btn3;
            debo_btn4 <= next_debo_btn4;
        end
    end

    always @(*) begin: combinatoric_btn1
    
        next_btn1_cnt = btn1_cnt;
        next_debo_btn1 = debo_btn1;
        
        if (btn1_incAni) begin
            next_btn1_cnt = btn1_cnt + 1;      // Increments count if button is pressed
            if (btn1_cnt == DEBOUNCE_VAL) begin
                next_debo_btn1 = 1'b1;                 // Debounced button high
            end
        end else begin
            next_btn1_cnt = 0; // Reset count if button is not pressed
            next_debo_btn1 = 1'b0;                // Reset debounced button if button is not pressed
        end
    end

    always @(*) begin: combinatoric_btn2
    
        next_btn2_cnt = btn2_cnt;
        next_debo_btn2 = debo_btn2;
        
        if (btn2_decAni) begin
            next_btn2_cnt = btn2_cnt + 1;      // Increments count if button is pressed
            if (btn2_cnt == DEBOUNCE_VAL) begin
                next_debo_btn2 = 1'b1;                 // Debounced button high
            end
        end else begin
            next_btn2_cnt = 0; // Reset count if button is not pressed
            next_debo_btn2 = 1'b0;                // Reset debounced button if button is not pressed
        end
    end

    always @(*) begin: combinatoric_btn3
    
        next_btn3_cnt = btn3_cnt;
        next_debo_btn3 = debo_btn3;
        
        if (btn3_incSpeed) begin
            next_btn3_cnt = btn3_cnt + 1;      // Increments count if button is pressed
            if (btn3_cnt == DEBOUNCE_VAL) begin
                next_debo_btn3 = 1'b1;                 // Debounced button high
            end
        end else begin
            next_btn3_cnt = 0; // Reset count if button is not pressed
            next_debo_btn3 = 1'b0;                // Reset debounced button if button is not pressed
        end
    end

    always @(*) begin: combinatoric_btn4
    
        next_btn4_cnt = btn4_cnt;
        next_debo_btn4 = debo_btn4;
        
        if (btn4_decSpeed) begin
            next_btn4_cnt = btn4_cnt + 1;      // Increments count if button is pressed
            if (btn4_cnt == DEBOUNCE_VAL) begin
                next_debo_btn4 = 1'b1;                 // Debounced button high
            end
        end else begin
            next_btn4_cnt = 0; 			// Reset count if button is not pressed
            next_debo_btn4 = 1'b0;                // Reset debounced button if button is not pressed
        end
    end

    // Instantiate segment display
    seg7 seg7(  
    .counter(digit), 
    .animation(currState), 
    .segments(led_out)
    );

    // Instantiate changing module
    changing changing(
    .animation(currState),
    .limit(counterMAX)
     );

endmodule
