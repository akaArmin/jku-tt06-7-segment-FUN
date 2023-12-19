`default_nettype none

module tt_um_seven_segment_fun1 #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire reset = ! rst_n;
    wire [6:0] led_out;
    assign uo_out[6:0] = led_out;
    assign uo_out[7] = 1'b0;

    // use bidirectionals as outputs
    assign uio_oe = 8'b11111111;

    // put bottom 8 bits of second counter out on the bidirectional gpio
    assign uio_out = second_counter[7:0];

    // external clock is 10MHz, so need 24 bit counter ?? 50MHz ??
    reg [23:0] second_counter;
    reg [3:0] digit;

    parameter STATE_BITS = 6;
    reg [STATE_BITS-1:0]currState;
    reg [STATE_BITS-1:0]nextState;

    parameter counterMAX = 0;

    // FSM states
    reg [2:0]State;
    localparam ST_IDLE = 2'b0000;
    localparam ST_ANI1 = 2'b0001;
    localparam ST_ANI2 = 2'b0010;
    localparam ST_ANI3 = 2'b0011;
    localparam ST_ANI4 = 2'b0100;
    localparam ST_ANI5 = 2'b0101;

    // if external inputs are set then use that as compare count
    // otherwise use the hard coded MAX_COUNT
    wire [23:0] compare = ui_in == 0 ? MAX_COUNT: {6'b0, ui_in[7:0], 10'b0};

    always @(posedge clk) begin
        // if reset, set counter to 0
        if (reset) begin
            second_counter <= 0;
            digit <= 0;
            counterMAX <= 0;
            currState <= ST_IDLE;
            nextState <= ST_IDLE;
            end 

        else begin
            currState <= nextState;
            case (currState)
                ST_IDLE:    // 0 to 9
                    begin
                        counterMAX <= 9;
                        nextState <= ST_ANI1;
                    end

                ST_ANI1:
                    begin
                        counterMAX <= 6;
                        nextState <= ST_ANI2;
                    end

                ST_ANI2:
                    begin
                        counterMAX <= 6;
                        nextState <= ST_ANI3;
                    end

                ST_ANI3:
                    begin
                        counterMAX <= 6;
                        nextState <= ST_ANI4;
                    end
                
                ST_ANI4:
                    begin
                        counterMAX <= 5;
                        nextState <= ST_ANI5;
                    end

                ST_ANI5:
                    begin
                        counterMAX <= 5;
                        nextState <= ST_IDLE;
                    end

                default:
                   begin
                        currState <= ST_IDLE;
                   end         
            endcase

            // if up to 16e6
            if (second_counter == compare) begin
                // reset
                second_counter <= 0;

                // increment digit
                digit <= digit + 1'b1;

                // only count from 0 to counterMAX
                if (digit == counterMAX)
                    digit <= 0;

            end else
                // increment counter
                second_counter <= second_counter + 1'b1;
        end
    
        // instantiate segment display
        case (currState)
            ST_IDLE: seg7 seg7(.counter(digit), .segments(led_out));

            ST_ANI1: ani1 ani1(.counter(digit), .segments(led_out));
    
            ST_ANI2: ani2 ani2(.counter(digit), .segments(led_out));

            ST_ANI3: ani3 ani3(.counter(digit), .segments(led_out));
        
            ST_ANI4: ani4 ani4(.counter(digit), .segments(led_out));
    
            ST_ANI5: ani5 ani5(.counter(digit), .segments(led_out));
    
            default: seg7 seg7(.counter(digit), .segments(led_out));
            
        endcase
    end
    
endmodule
