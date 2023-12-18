
/*
      -- 1 --
     |       |
     6       2
     |       |
      -- 7 --
     |       |
     5       3
     |       |
      -- 4 --
*/

module seg7 (
    input wire [3:0] counter,
    output reg [6:0] segments
);
    always @(*) begin
        case(counter)
            //                7654321
            0:  segments = 7'b0111111;
            1:  segments = 7'b0000110;
            2:  segments = 7'b1011011;
            3:  segments = 7'b1001111;
            4:  segments = 7'b1100110;
            5:  segments = 7'b1101101;
            6:  segments = 7'b1111101;
            7:  segments = 7'b0000111;
            8:  segments = 7'b1111111;
            9:  segments = 7'b1101111;
	    default:
                segments = 7'b0000000;
        endcase
    end
endmodule


module ani4(
    input wire [3:0] counter, // ??
    output reg [6:0] segments
);
    always @(*) begin
        case(counter)
            //                7654321
            0:  segments = 7'b0000000;
            1:  segments = 7'b0000000;
            2:  segments = 7'b0000000;
            3:  segments = 7'b0000000;
            4:  segments = 7'b0000000;
            5:  segments = 7'b0000000;
            6:  segments = 7'b0000000;
	    default:
                segments = 7'b0000000;
        endcase
    end
endmodule


module ani1(
    input wire [3:0] counter, // ??
    output reg [6:0] segments
);
    always @(*) begin
        case(counter)
            //                7654321
            0:  segments = 7'b0000001;
            1:  segments = 7'b0000010;
            2:  segments = 7'b0000100;
            3:  segments = 7'b0001000;
            4:  segments = 7'b0010000;
            5:  segments = 7'b0100000;
            6:  segments = 7'b1000000;
	    default:
                segments = 7'b0000000;
        endcase
    end
endmodule


module ani2(
    input wire [3:0] counter, // ??
    output reg [6:0] segments
);
    always @(*) begin
        case(counter)
            //                7654321
            0:  segments = 7'b1000001;
            1:  segments = 7'b0100010;
            2:  segments = 7'b0010100;
            3:  segments = 7'b0001000;
            4:  segments = 7'b0010100;
            5:  segments = 7'b0100010;
            6:  segments = 7'b1000001;
	    default:
                segments = 7'b0000000;
        endcase
    end
endmodule


module ani3(
    input wire [3:0] counter, // ??
    output reg [6:0] segments
);
    always @(*) begin
        case(counter)
            //                7654321
            0:  segments = 7'b1000001;
            1:  segments = 7'b0100010;
            2:  segments = 7'b0010100;
            3:  segments = 7'b0001000;
            4:  segments = 7'b0000100;
            5:  segments = 7'b0000010;
            6:  segments = 7'b0000001;
	    default:
                segments = 7'b0000000;
        endcase
    end
endmodule


module ani4(
    input wire [3:0] counter, // ??
    output reg [6:0] segments
);
    always @(*) begin
        case(counter)
            //                7654321
            0:  segments = 7'b0001100;
            1:  segments = 7'b0000110;
            2:  segments = 7'b0000011;
            3:  segments = 7'b0100001;
            4:  segments = 7'b0110000;
            5:  segments = 7'b0011000;
	    default:
                segments = 7'b0000000;
        endcase
    end
endmodule


module ani4(
    input wire [3:0] counter, // ??
    output reg [6:0] segments
);
    always @(*) begin
        case(counter)
            //                7654321
            0:  segments = 7'b0001100;
            1:  segments = 7'b0011000;
            2:  segments = 7'b0110000;
            3:  segments = 7'b0100001;
            4:  segments = 7'b0000011;
            5:  segments = 7'b0000110;
	    default:
                segments = 7'b0000000;
        endcase
    end
endmodule
