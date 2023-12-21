`default_nettype none

module tt_um_seven_segment_fun1 #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Pin assignment
    // wire clk = io_in[0]           // Input Clock -> 10MHz
    wire reset = ! rst_n;            // Reset
    wire btn1_incAni = ui_in[0];     // Switch forward to the next Animation
    wire btn2_decAni = ui_in[1];     // Switch backwards to the previous Animation
    wire btn3_incSpeed = ui_in[2];   // Increase the speed of the Animation
    wire btn4_decSpeed = ui_in[3];   // Decrease the speed of the Animation


    reg debounced_btn1;     // Debounce register Button 1
    reg debounced_btn2;     // Debounce register Button 2
    reg debounced_btn3;     // Debounce register Button 3
    reg debounced_btn4;     // Debounce register Button 4

    reg [11:0] btn1_count = 12'h000;    // Initializing a count for Button 1
    reg [11:0] btn2_count = 12'h000;    // Initializing a count for Button 2
    reg [11:0] btn3_count = 12'h000;    // Initializing a count for Button 3
    reg [11:0] btn4_count = 12'h000;    // Initializing a count for Button 4
   
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

    // Which animation is displayed
    //wire [3:0] animation;       // Current Animation
    
    // FSM states
    localparam ST_ANI0 = 4'b0000;
    localparam ST_ANI1 = 4'b0001;
    localparam ST_ANI2 = 4'b0010;
    localparam ST_ANI3 = 4'b0011;
    localparam ST_ANI4 = 4'b0100;
    localparam ST_ANI5 = 4'b0101;
    localparam ST_ANI6 = 4'b0110;
    localparam ST_ANI7 = 4'b0111;
    localparam ST_ANI8 = 4'b1000;
    localparam ST_ANI9 = 4'b1001;
    localparam ST_ANI10 = 4'b1010;
    localparam ST_ANI11 = 4'b1011;


    parameter STATE_BITS = 4;
    reg [STATE_BITS-1:0]currState = ST_ANI0;
    reg [STATE_BITS-1:0]nextState = ST_ANI0;
    reg [STATE_BITS-1:0]prevState = ST_ANI0;

    reg [23:0] compare = 10_000_000;  // Default 1 sek at 10MHz
    localparam comMax = 19_000_000;   // Maximum value for compare
    localparam comMin = 1_000_000;    // Minimum value for compare
    localparam comInc = 1_000_000;    // Stepsize

    always @(posedge clk) begin
        // If reset, set counter to 0
        if (reset || (currState != prevState)) begin
            second_counter <= 0;
            digit <= 0;
            currState <= ST_ANI0;
            nextState <= ST_ANI1;
            prevState <= ST_ANI11;

        end else begin
            // If secound_counter equals the value of compare
            if (second_counter == compare) begin
                second_counter <= 0;    // Reset the secound_counter
                
                digit <= digit + 1'b1;  // Increment digit
                            
                if (digit >= counterMAX)// Only count from 0 to counterMAX
                    digit <= 0;

            end else begin
                second_counter <= second_counter + 1'b1; // Increment secound_counter
            end
        end
    end

    // Switching the states with debounced Button
    always @(posedge clk) begin
        if (debounced_btn1) begin
            if (nextState != ST_ANI11) begin
                prevState <= currState;
                currState <= nextState;
                nextState <= nextState + 4'b0001;
            end else begin // If nextState is ST_ANI11
                prevState <= currState;
                currState <= nextState;
                nextState <= ST_ANI0;
            end
        end else if (debounced_btn2) begin
            if (prevState != ST_ANI0) begin
                nextState <= currState;
                currState <= prevState;
                prevState <= prevState - 4'b0001;
            end else begin // If prevState is ST_ANI0
                nextState <= currState;
                currState <= prevState;
                prevState <= ST_ANI11;
            end
        end
    end


    // Changing the speed with decounced button
    always @(posedge clk) begin
        if (debounced_btn3 && (compare <= comMax)) begin
            compare <= compare + comInc;
        end else if (debounced_btn4 && (compare >= comMin)) begin
            compare <= compare - comInc;
        end
    end

    // Debouncing - Button 1
    always @(posedge clk) begin
        if (btn1_incAni == 1'b1) begin
            btn1_count <= btn1_count + 1;   // Increments count if button is pressed
            if (btn1_count == 12'h1FF) begin
                debounced_btn1 <= 1'b1;     // Debounced button
            end
        end else begin
            btn1_count <= 1'b0;             // Reset count if button is not pressed
            debounced_btn1 <= 1'b0;         // Reset debounced button if button is not pressed
        end
    end


    // Debouncing - Button 2
    always @(posedge clk) begin
        if (btn2_incAni == 1'b1) begin
            btn2_count <= btn2_count + 1;   // Increments count if button is pressed
            if (btn2_count == 12'h1FF) begin
                debounced_btn2 <= 1'b1;     // Debounced button
            end
        end else begin
            btn2_count <= 1'b0;             // Reset count if button is not pressed
            debounced_btn2 <= 1'b0;         // Reset debounced button if button is not pressed
        end
    end

    // Debouncing - Button 3
    always @(posedge clk) begin
        if (btn3_incAni == 1'b1) begin
            btn3_count <= btn3_count + 1;   // Increments count if button is pressed
            if (btn3_count == 12'h1FF) begin
                debounced_btn3 <= 1'b1;     // Debounced button
            end
        end else begin
            btn3_count <= 1'b0;             // Reset count if button is not pressed
            debounced_btn3 <= 1'b0;         // Reset debounced button if button is not pressed
        end
    end


    // Debouncing - Button 4
    always @(posedge clk) begin
        if (btn4_incAni == 1'b1) begin
            btn4_count <= btn4_count + 1;   // Increments count if button is pressed
            if (btn4_count == 12'h1FF) begin
                debounced_btn4 <= 1'b1;     // Debounced button
            end
        end else begin
            btn4_count <= 1'b0;             // Reset count if button is not pressed
            debounced_btn4 <= 1'b0;         // Reset debounced button if button is not pressed
        end
    end

    
    // Instantiate segment display
    seg7 seg7(.counter(digit), .animation(currState), .segments(led_out));

    changing changing(.animation(currState), .limit(counterMAX));
    
endmodule
