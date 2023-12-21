
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
    input wire [2:0] animation,
    output reg [6:0] segments
);
    always @(*) begin
        case(animation)
            0: // 0 to 9
                case(counter)
                    //                7654321
                    0:  segments = 7'b0111111; // 0
                    1:  segments = 7'b0000110; // 1
                    2:  segments = 7'b1011011; // 2
                    3:  segments = 7'b1001111; // 3
                    4:  segments = 7'b1100110; // 4
                    5:  segments = 7'b1101101; // 5
                    6:  segments = 7'b1111101; // 6
                    7:  segments = 7'b0000111; // 7
                    8:  segments = 7'b1111111; // 8
                    9:  segments = 7'b1101111; // 9
                default:
                        segments = 7'b0000000;
                endcase

            1: // Armin Hartl
                case(counter)
                    //                7654321
                    0:  segments = 7'b1110111;  // A
                    1:  segments = 7'b1010000;  // r
                    2:  segments = 7'b1010101;  // m
                    3:  segments = 7'b0010001;  // i
                    4:  segments = 7'b1010100;  // n
                    5:  segments = 7'b0000000;  
                    6:  segments = 7'b1110110;  // H
                    7:  segments = 7'b1110111;  // A
                    8:  segments = 7'b1010000;  // r
                    9:  segments = 7'b1111000;  // T
                    10:  segments = 7'b0111000; // L
                    11:  segments = 7'b0000000;
                default:
                        segments = 7'b0000000;
                endcase

            2: // Around clockwise
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000001;
                    1:  segments = 7'b0000010;
                    2:  segments = 7'b0000100;
                    3:  segments = 7'b0001000;
                    4:  segments = 7'b0010000;
                    5:  segments = 7'b0100000;
                default:
                        segments = 7'b0000000;
                endcase

            3: // Around anti-clockwise
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000001;
                    1:  segments = 7'b0100000;
                    2:  segments = 7'b0010000;
                    3:  segments = 7'b0001000;
                    4:  segments = 7'b0000100;
                    5:  segments = 7'b0000010;
                default:
                        segments = 7'b0000000;
                endcase

            4: // Pair do round anti-clockwise
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
            
            5: // Pair do round clockwise
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

            6: // Pair switcher
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000001;
                    1:  segments = 7'b0100010;
                    2:  segments = 7'b0010100;
                    3:  segments = 7'b1001000;
                    4:  segments = 7'b0010100;
                    5:  segments = 7'b0100010;
                default:
                        segments = 7'b0000000;
                endcase

            7: // Up & Dowen - Case
                case(counter)
                    //                7654321
                    0:  segments = 7'b0100011;
                    1:  segments = 7'b0011100;
                default:
                        segments = 7'b0000000;
                endcase

            8: // Up & Dowen - Streight
                case(counter)
                    //                7654321
                    0:  segments = 7'b0001000;
                    1:  segments = 7'b1000000;
                    2:  segments = 7'b0000001;
                    3:  segments = 7'b1000000;
                default:
                        segments = 7'b0000000;
                endcase

            9: // H |-| idk
                case(counter)
                    //                7654321
                    0:  segments = 7'b1110110;  // H
                    1:  segments = 7'b1001001;  
                    2:  segments = 7'b1000000;
                    3:  segments = 7'b0001001;
                default:
                        segments = 7'b0000000;
                endcase

            10: // Blinking
                case(counter)
                    //                7654321
                    0:  segments = 7'b1111111;
                    1:  segments = 7'b0000000;
                default:
                        segments = 7'b0000000;
                endcase

            11: // o & °
                case(counter)
                    //                7654321
                    0:  segments = 7'b1011100;
                    1:  segments = 7'b1100011;
                default:
                        segments = 7'b0000000;
                endcase
            
            default:    
                segments = 7'b0000000;
        endcase
    end
endmodule
