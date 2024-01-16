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

    reg debounced_btn1, next_debo_btn1;     // Debounce register Button 1
    reg debounced_btn2, next_debo_btn2;     // Debounce register Button 2
    reg debounced_btn3, next_debo_btn3;     // Debounce register Button 3
    reg debounced_btn4, next_debo_btn4;     // Debounce register Button 4

    reg [11:0] btn1_cnt, next_btn1_cnt;     // Initializing a count for Button 1
    reg [11:0] btn2_cnt, next_btn2_cnt;     // Initializing a count for Button 2
    reg [11:0] btn3_cnt, next_btn3_cnt;     // Initializing a count for Button 3
    reg [11:0] btn4_cnt, next_btn4_cnt;     // Initializing a count for Button 4

    wire [6:0] led_out;             // 7-Segment output
    assign uo_out[6:0] = led_out;   // Assign Pins
    assign uo_out[7] = 1'b0;        // Default set to low

    // Use bidirectionals as outputs
    assign uio_oe = 8'b11111111;

    // Put bottom 8 bits of second counter out on the bidirectional gpio
    assign uio_out = second_counter[7:0];

    // External clock is 10MHz, so need 24 bit counter
    reg [23:0] second_counter;
    reg [4:0] digit;
    wire [4:0] counterMAX;

    // FSM states - Animation
    localparam ST_ANI0   = 6'b000000;
    localparam ST_ANImax = 6'b111111;

    parameter STATE_BITS = 6;
    reg [STATE_BITS-1:0] currState;
    reg [STATE_BITS-1:0] nextState;
    reg [STATE_BITS-1:0] prevState;

    // Counter compare value
    reg [23:0] compare = 10_000_000;  // Default 1 sek at 10MHz
    reg [23:0] next_compare = 10_000_000;
    localparam comMax = 19_000_000;   // Maximum value for compare
    localparam comMin = 1_000_000;    // Minimum value for compare
    localparam comInc = 1_000_000;    // Stepsize

    // Counter
    always @(posedge clk or posedge reset) begin
        // If reset, set counter to 0
        if (reset) begin
            second_counter <= 0;
            digit <= 0;
            compare <= 10_000_000;
        end else begin
            compare <= next_compare;
            // If secound_counter equals the value of compare
            if (second_counter == compare) begin
                second_counter <= 0;    // Reset the secound_counter
                digit <= digit + 1'b1;  // Increment digit
                if (digit >= counterMAX)
                    digit <= 0;
            end else
                second_counter <= second_counter + 1'b1; // Increment secound_counter
        end
    end

    // Switching the states with debounced Button
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            currState <= ST_ANI0;
            nextState <= ST_ANI0 + 6'b000001;
            prevState <= ST_ANImax;
        end else if (debounced_btn1) begin
            if (nextState != ST_ANImax) begin
                prevState <= currState;
                currState <= nextState;
                nextState <= nextState + 6'b000001;
            end else begin
                prevState <= currState;
                currState <= nextState;
                nextState <= ST_ANI0;
            end
        end else if (debounced_btn2) begin
            if (prevState != ST_ANI0) begin
                nextState <= currState;
                currState <= prevState;
                prevState <= prevState - 6'b000001;
            end else begin
                nextState <= currState;
                currState <= prevState;
                prevState <= ST_ANImax;
            end
        end
    end

    // Changing the speed with decounced button
    always @(*) begin
        next_compare = compare;
        if (reset)
            next_compare = 10_000_000;
        else if (debounced_btn3 && (compare <= comMax))
            next_compare = compare + comInc;
        else if (debounced_btn4 && (compare >= comMin))
            next_compare = compare - comInc;
    end

    // Debouncing - Button 1
    always @(*) begin
        next_btn1_cnt = btn1_cnt;
        if (btn1_incAni == 1'b1) begin
            next_btn1_cnt = btn1_cnt + 1;  // Increments count if button is pressed
            if (btn1_cnt == 4)
                debounced_btn1 = 1'b1;     // Debounced button
        end else begin
            btn1_cnt = 1'b0;               // Reset count if button is not pressed
            debounced_btn1 = 1'b0;         // Reset debounced button if button is not pressed
            // next_btn1_cnt = 1'b0; ?
        end
    end

    // Debouncing - Button 2
    always @(*) begin
        next_btn2_cnt = btn2_cnt;
        if (btn2_decAni == 1'b1) begin
            next_btn2_cnt = btn2_cnt + 1;  // Increments count if button is pressed
            if (btn2_cnt == 12'h1FF)
                debounced_btn2 = 1'b1;     // Debounced button
        end else begin
            btn2_cnt = 1'b0;               // Reset count if button is not pressed
            debounced_btn2 = 1'b0;         // Reset debounced button if button is not pressed
            // next_btn2_cnt = 1'b0; ?
        end
    end

    // Debouncing - Button 3
    always @(*) begin
        next_btn3_cnt = btn3_cnt;
        if (btn3_incSpeed == 1'b1) begin
            next_btn3_cnt = btn3_cnt + 1;   // Increments count if button is pressed
            if (btn3_cnt == 12'h1FF)
                debounced_btn3 = 1'b1;      // Debounced button
        end else begin
            btn3_cnt = 1'b0;                // Reset count if button is not pressed
            debounced_btn3 = 1'b0;          // Reset debounced button if button is not pressed
            // next_btn3_cnt = 1'b0; ?
        end
    end

    // Debouncing - Button 4
    always @(*) begin
        next_btn4_cnt = btn4_cnt;
        if (btn4_decSpeed == 1'b1) begin
            next_btn4_cnt = btn4_cnt + 1;   // Increments count if button is pressed
            if (btn4_cnt == 12'h1FF)
                debounced_btn4 = 1'b1;      // Debounced button
        end else begin
            btn4_cnt = 1'b0;                // Reset count if button is not pressed
            debounced_btn4 = 1'b0;          // Reset debounced button if button is not pressed
            // next_btn4_cnt = 1'b0; ?
        end
    end

    // Instantiate segment display
    seg7 seg7(.counter(digit), .animation(currState), .segments(led_out));

    // Instantiate changing module
    changing changing(.animation(currState), .limit(counterMAX));

endmodule
