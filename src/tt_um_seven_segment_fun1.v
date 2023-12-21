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
    localparam ST_ANI0   = 6'b000000;
    localparam ST_ANI1   = 6'b000001;
    localparam ST_ANI2   = 6'b000010;
    localparam ST_ANI3   = 6'b000011;
    localparam ST_ANI4   = 6'b000100;
    localparam ST_ANI5   = 6'b000101;
    localparam ST_ANI6   = 6'b000110;
    localparam ST_ANI7   = 6'b000111;
    localparam ST_ANI8   = 6'b001000;
    localparam ST_ANI9   = 6'b001001;
    localparam ST_ANI10  = 6'b001010;
    localparam ST_ANI11  = 6'b001011;
    localparam ST_ANI12  = 6'b001100;
    localparam ST_ANI13  = 6'b001101;
    localparam ST_ANI14  = 6'b001110;
    localparam ST_ANI15  = 6'b001111;
    localparam ST_ANI16  = 6'b010000;
    localparam ST_ANI17  = 6'b010001;
    localparam ST_ANI18  = 6'b010010;
    localparam ST_ANI19  = 6'b010011;
    localparam ST_ANI20  = 6'b010100;
    localparam ST_ANI21  = 6'b010101;
    localparam ST_ANI22  = 6'b010110;
    localparam ST_ANI23  = 6'b010111;
    localparam ST_ANI24  = 6'b011000;
    localparam ST_ANI25  = 6'b011001;
    localparam ST_ANI26  = 6'b011010;
    localparam ST_ANI27  = 6'b011011;
    localparam ST_ANI28  = 6'b011100;
    localparam ST_ANI29  = 6'b011101;
    localparam ST_ANI30  = 6'b011110;
    localparam ST_ANI31  = 6'b011111;
    localparam ST_ANI32  = 6'b100000;
    localparam ST_ANI33  = 6'b100001;
    localparam ST_ANI34  = 6'b100010;
    localparam ST_ANI35  = 6'b100011;
    localparam ST_ANI36  = 6'b100100;
    localparam ST_ANI37  = 6'b100101;
    localparam ST_ANI38  = 6'b100110;
    localparam ST_ANI39  = 6'b100111;
    localparam ST_ANI40  = 6'b101000;
    localparam ST_ANI41  = 6'b101001;
    localparam ST_ANI42  = 6'b101010;
    localparam ST_ANI43  = 6'b101011;
    localparam ST_ANI44  = 6'b101100;
    localparam ST_ANI45  = 6'b101101;
    localparam ST_ANI46  = 6'b101110;
    localparam ST_ANI47  = 6'b101111;
    localparam ST_ANI48  = 6'b110000;
    localparam ST_ANI49  = 6'b110001;
    localparam ST_ANI50  = 6'b110010;


    parameter STATE_BITS = 6;
    reg [STATE_BITS-1:0]currState;
    reg [STATE_BITS-1:0]nextState;
    reg [STATE_BITS-1:0]prevState;

    reg [23:0] compare = 10_000_000;  // Default 1 sek at 10MHz
    localparam comMax = 19_000_000;   // Maximum value for compare
    localparam comMin = 1_000_000;    // Minimum value for compare
    localparam comInc = 1_000_000;    // Stepsize

    always @(posedge clk) begin
        // If reset, set counter to 0
        if (reset) begin
            second_counter <= 0;
            digit <= 0;
            // compare <= 10_000_000;

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
        if (reset) begin
            currState <= ST_ANI0;
            nextState <= ST_ANI1;
            prevState <= ST_ANI50;

        end else if (debounced_btn1) begin
            if (nextState != ST_ANI50) begin
                prevState <= currState;
                currState <= nextState;
                nextState <= nextState + 4'b0001;
            end else begin // If nextState is ST_ANI50
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
                prevState <= ST_ANI50;
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
        if (btn2_decAni == 1'b1) begin
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
        if (btn3_incSpeed == 1'b1) begin
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
        if (btn4_decSpeed == 1'b1) begin
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
