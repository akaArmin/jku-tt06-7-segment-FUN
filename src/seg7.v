
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

`default_nettype none 
//`timescale 1ns / 1ps

module seg7 (
    input wire [5:0] counter,
    input wire [5:0] animation,
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
            
            12: // right & left
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000110;
                    1:  segments = 7'b0110000;
                default:
                        segments = 7'b0000000;
                endcase
            
            13: // half H 1
                case(counter)
                    //                7654321
                    0:  segments = 7'b1010010;
                    1:  segments = 7'b1100100;
                default:
                        segments = 7'b0000000;
                endcase
            
            14: // half H 2
                case(counter)
                    //                7654321
                    0:  segments = 7'b1010100;
                    1:  segments = 7'b1100010;
                default:
                        segments = 7'b0000000;
                endcase

            15: // Cuircle down
                case(counter)
                    //                7654321
                    0:  segments = 7'b0001000;
                    1:  segments = 7'b0000100;
                    2:  segments = 7'b1000000;
                    3:  segments = 7'b0010000;
                default:
                        segments = 7'b0000000;
                endcase
            
            16: // Hello
                case(counter)
                    //                7654321
                    0:  segments = 7'b1110110;
                    1:  segments = 7'b1111001;
                    2:  segments = 7'b0111000;
                    3:  segments = 7'b0111000;
                    4:  segments = 7'b0111111;
                    5:  segments = 7'b0000000;
                default:
                        segments = 7'b0000000;
                endcase

            17: // Schräg
                case(counter)
                    //                7654321
                    0:  segments = 7'b0010010;
                    1:  segments = 7'b0100100;
                    default:
                        segments = 7'b0000000;
                endcase

            18: // Randome 1
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000010; // Segment 2
                    1:  segments = 7'b0001000; // Segment 4
                    2:  segments = 7'b1000000; // Segment 7
                    3:  segments = 7'b0000001; // Segment 1
                    4:  segments = 7'b0010000; // Segment 5
                    5:  segments = 7'b0100000; // Segment 6
                    6:  segments = 7'b0000100; // Segment 3
                    default:
                        segments = 7'b0000000;
                endcase

            19: // Randome 2
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000100; // Segment 3
                    1:  segments = 7'b0001000; // Segment 4
                    2:  segments = 7'b0000010; // Segment 2
                    3:  segments = 7'b1000000; // Segment 7
                    4:  segments = 7'b0000001; // Segment 1
                    5:  segments = 7'b0010000; // Segment 5
                    6:  segments = 7'b0100000; // Segment 6
                    default:
                        segments = 7'b0000000;
                endcase

            20: // Randome 3
                case(counter)
                    //                7654321
                    0:  segments = 7'b0010000; // Segment 5
                    1:  segments = 7'b0001000; // Segment 4
                    2:  segments = 7'b0100000; // Segment 6
                    3:  segments = 7'b0000100; // Segment 3
                    4:  segments = 7'b0000010; // Segment 2
                    5:  segments = 7'b1000000; // Segment 7
                    6:  segments = 7'b0000001; // Segment 1
                    default:
                        segments = 7'b0000000;
                endcase

            21: // Randome 4
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000001; // Segment 1
                    1:  segments = 7'b0100000; // Segment 6
                    2:  segments = 7'b0000100; // Segment 3
                    3:  segments = 7'b1000000; // Segment 7
                    4:  segments = 7'b0001000; // Segment 4
                    5:  segments = 7'b0010000; // Segment 5
                    6:  segments = 7'b0000010; // Segment 2
                    default:
                        segments = 7'b0000000;
                endcase

            22: // Randome 5
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000; // Segment 7
                    1:  segments = 7'b0000100; // Segment 3
                    2:  segments = 7'b0000001; // Segment 1
                    3:  segments = 7'b0001000; // Segment 4
                    4:  segments = 7'b0100000; // Segment 6
                    5:  segments = 7'b0000010; // Segment 2
                    6:  segments = 7'b0010000; // Segment 5
                    default:
                        segments = 7'b0000000;
                endcase

            23: // Cuircle up
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b0000010;
                    2:  segments = 7'b0000001;
                    3:  segments = 7'b0100000;
                    default:
                        segments = 7'b0000000;
                endcase

            24: // Randome+ 1
                case(counter)
                    //                7654321
                    0:  segments = 7'b1010101; // Random pattern
                    1:  segments = 7'b0101010; 
                    2:  segments = 7'b0011001;
                    3:  segments = 7'b1100110;
                    4:  segments = 7'b1001100;
                    5:  segments = 7'b0110011;
                    6:  segments = 7'b0001111;
                    7:  segments = 7'b1111000;
                    8:  segments = 7'b1100001;
                    9:  segments = 7'b0011110;
                    10: segments = 7'b0111100;
                    11: segments = 7'b1000011;
                    12: segments = 7'b1101001;
                    13: segments = 7'b0010011;
                    14: segments = 7'b0110001;
                    15: segments = 7'b1001010;
                    default:
                        segments = 7'b0000000;
                endcase
   
            25: // Randome+ 2
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000001; // Segment 1
                    1:  segments = 7'b0000100; // Segment 3
                    2:  segments = 7'b0100000; // Segment 6
                    3:  segments = 7'b0010000; // Segment 5
                    4:  segments = 7'b0001000; // Segment 4
                    5:  segments = 7'b1000000; // Segment 7
                    6:  segments = 7'b0000010; // Segment 2
                    7:  segments = 7'b0000001; // Segment 1
                    8:  segments = 7'b0000010; // Segment 2
                    9:  segments = 7'b0001000; // Segment 4
                    10: segments = 7'b0100000; // Segment 6
                    11: segments = 7'b0010000; // Segment 5
                    12: segments = 7'b1000000; // Segment 7
                    13: segments = 7'b0000100; // Segment 3
                    14: segments = 7'b0000001; // Segment 1
                    15: segments = 7'b0000010; // Segment 2
                    default:
                        segments = 7'b0000000;
                endcase
   
            26: // Randome+ 3
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000010; // Segment 2
                    1:  segments = 7'b0000001; // Segment 1
                    2:  segments = 7'b0001000; // Segment 4
                    3:  segments = 7'b0100000; // Segment 6
                    4:  segments = 7'b0000100; // Segment 3
                    5:  segments = 7'b0010000; // Segment 5
                    6:  segments = 7'b1000000; // Segment 7
                    7:  segments = 7'b0000100; // Segment 3
                    8:  segments = 7'b0000001; // Segment 1
                    9:  segments = 7'b0000010; // Segment 2
                    10: segments = 7'b0010000; // Segment 5
                    11: segments = 7'b0100000; // Segment 6
                    12: segments = 7'b0001000; // Segment 4
                    13: segments = 7'b1000000; // Segment 7
                    14: segments = 7'b0000010; // Segment 2
                    15: segments = 7'b0000001; // Segment 1
                    default:
                        segments = 7'b0000000;
                endcase
   
            27: // Randome Numbers
                case(counter)
                    //                7654321
                    0:  segments = 7'b1100110; // 4
                    1:  segments = 7'b0111111; // 0
                    2:  segments = 7'b1111111; // 8
                    3:  segments = 7'b0000110; // 1
                    4:  segments = 7'b1001111; // 3
                    5:  segments = 7'b1101101; // 5
                    6:  segments = 7'b0000111; // 7
                    7:  segments = 7'b1101111; // 9
                    8:  segments = 7'b1011011; // 2
                    9:  segments = 7'b0111111; // 0
                    10: segments = 7'b1101101; // 5
                    11: segments = 7'b1111101; // 6
                    12: segments = 7'b0000110; // 1
                    13: segments = 7'b1100110; // 4
                    14: segments = 7'b1001111; // 3
                    15: segments = 7'b1111111; // 8
                    default:
                        segments = 7'b0000000;
                endcase
   
            28: // Randome Numbers+
                case(counter)
                    //                7654321
                    0:  segments = 7'b0111111; // 0
                    1:  segments = 7'b1100110; // 4
                    2:  segments = 7'b1011011; // 2
                    3:  segments = 7'b1001111; // 3
                    4:  segments = 7'b1111111; // 8
                    5:  segments = 7'b0000110; // 1
                    6:  segments = 7'b1101101; // 5
                    7:  segments = 7'b0000111; // 7
                    8:  segments = 7'b1101111; // 9
                    9:  segments = 7'b1111101; // 6
                    10: segments = 7'b0111111; // 0
                    11: segments = 7'b1100110; // 4
                    12: segments = 7'b1011011; // 2
                    13: segments = 7'b1001111; // 3
                    14: segments = 7'b1111111; // 8
                    15: segments = 7'b0000110; // 1
                    16: segments = 7'b1101101; // 5
                    17: segments = 7'b0000111; // 7
                    18: segments = 7'b1101111; // 9
                    19: segments = 7'b1111101; // 6
                    20: segments = 7'b0111111; // 0
                    21: segments = 7'b1100110; // 4
                    22: segments = 7'b1011011; // 2
                    23: segments = 7'b1001111; // 3
                    24: segments = 7'b1111111; // 8
                    25: segments = 7'b0000110; // 1
                    26: segments = 7'b1101101; // 5
                    27: segments = 7'b0000111; // 7
                    28: segments = 7'b1101111; // 9
                    29: segments = 7'b1111101; // 6
                    30: segments = 7'b0111111; // 0
                    31: segments = 7'b1100110; // 4
                    default:
                        segments = 7'b0000000;
                endcase
   
            29: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111111;
                    3:  segments = 7'b1110110;
                    default:
                        segments = 7'b0000000;
                endcase
   
            30: // Birthday
                case(counter)
                    //                7654321
                    0:  segments = 7'b1011011; // 2
                    1:  segments = 7'b0000110; // 1
                    2:  segments = 7'b0001000; // _
                    3:  segments = 7'b0111111; // 0
                    4:  segments = 7'b1100110; // 4
                    5:  segments = 7'b0001000; // _
                    6:  segments = 7'b1011011; // 2
                    7:  segments = 7'b0111111; // 0
                    8:  segments = 7'b0111111; // 0
                    9:  segments = 7'b0000110; // 1
                    10: segments = 7'b0000000;
                    default:
                        segments = 7'b0000000;
                endcase
   
            31: // Random++
                case(counter)
                    //                7654321
                    0:  segments = 7'b1010101;
                    1:  segments = 7'b0101010;
                    2:  segments = 7'b0011001;
                    3:  segments = 7'b1100110;
                    4:  segments = 7'b1001001;
                    5:  segments = 7'b0110010;
                    6:  segments = 7'b0001110;
                    7:  segments = 7'b1110000;
                    8:  segments = 7'b0111100;
                    9:  segments = 7'b1000011;
                    10: segments = 7'b1101001;
                    11: segments = 7'b0010110;
                    12: segments = 7'b1011010;
                    13: segments = 7'b0100101;
                    14: segments = 7'b1001100;
                    15: segments = 7'b0111001;
                    16: segments = 7'b0000011;
                    17: segments = 7'b1111100;
                    18: segments = 7'b0011111;
                    19: segments = 7'b1100001;
                    20: segments = 7'b0110111;
                    21: segments = 7'b1001000;
                    22: segments = 7'b1010011;
                    23: segments = 7'b0101100;
                    24: segments = 7'b1100010;
                    25: segments = 7'b0010101;
                    26: segments = 7'b0001101;
                    27: segments = 7'b1110010;
                    28: segments = 7'b0100011;
                    29: segments = 7'b1011100;
                    30: segments = 7'b0111010;
                    31: segments = 7'b1000111;
                    default:
                        segments = 7'b0000000;
                endcase
            
            32: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1101111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1010000;
                    default:
                        segments = 7'b0000000;
                endcase

            33: // Online try
                case(counter)
                    //                7654321
                    0:  segments = 7'b1101010;
                    1:  segments = 7'b1101100;
                    2:  segments = 7'b1110010;
                    3:  segments = 7'b1010000;
                    4:  segments = 7'b0011101;
                    5:  segments = 7'b0001010;
                    6:  segments = 7'b0110100;
                    7:  segments = 7'b1100101;
                    8:  segments = 7'b0101010;
                    default:
                        segments = 7'b0000000;
                endcase
/*
            34: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b0110110;
                    2:  segments = 7'b1111111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000010;
                    default:
                        segments = 7'b0000000;
                endcase

            35: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b1110010;
                    2:  segments = 7'b1011111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            36: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1100000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111011;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000100;
                    default:
                        segments = 7'b0000000;
                endcase

            37: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b1100110;
                    2:  segments = 7'b1111011;
                    3:  segments = 7'b1010110;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            38: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1011000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1100111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000100;
                    default:
                        segments = 7'b0000000;
                endcase

            39: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1001000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1001111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000001;
                    default:
                        segments = 7'b0000000;
                endcase

            40: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1011100;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111111;
                    3:  segments = 7'b1100010;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            41: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000010;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b0111111;
                    3:  segments = 7'b1010110;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            42: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1001000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1001000;
                    default:
                        segments = 7'b0000000;
                endcase

            43: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1110111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            44: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b0011111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1001100;
                    default:
                        segments = 7'b0000000;
                endcase

            45: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1001100;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1110011;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            46: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1001000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1001000;
                    default:
                        segments = 7'b0000000;
                endcase

            47: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b0010110;
                    2:  segments = 7'b1111011;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            48: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1010000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1001000;
                    default:
                        segments = 7'b0000000;
                endcase

            49: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1010000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111111;
                    3:  segments = 7'b1110110;
                    4:  segments = 7'b1000001;
                    default:
                        segments = 7'b0000000;
                endcase

            50: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1011000;
                    1:  segments = 7'b1110110;
                    2:  segments = 7'b1111001;
                    3:  segments = 7'b1010110;
                    4:  segments = 7'b1000000;
                    default:
                        segments = 7'b0000000;
                endcase

            51: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0100010;
                    1:  segments = 7'b0111001;
                    default:
                        segments = 7'b0000000;
                endcase

            52: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000001;
                    1:  segments = 7'b1101111;
                    default:
                        segments = 7'b0000000;
                endcase

            53: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1000000;
                    1:  segments = 7'b0110011;
                    default:
                        segments = 7'b0000000;
                endcase

            54: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0011000;
                    1:  segments = 7'b1101110;
                    default:
                        segments = 7'b0000000;
                endcase

            55: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000110;
                    1:  segments = 7'b1011101;
                    default:
                        segments = 7'b0000000;
                endcase

            56: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0110000;
                    1:  segments = 7'b1110111;
                    default:
                        segments = 7'b0000000;
                endcase 

            57: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1100000;
                    1:  segments = 7'b1110011;
                    default:
                        segments = 7'b0000000;
                endcase 

            58: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0011110;
                    1:  segments = 7'b1100111;
                    default:
                        segments = 7'b0000000;
                endcase

            59: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1110000;
                    1:  segments = 7'b1001111;
                    default:
                        segments = 7'b0000000;
                endcase

            60: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0010000;
                    1:  segments = 7'b0011111;
                    default:
                        segments = 7'b0000000;
                endcase
            
            61: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0000010;
                    1:  segments = 7'b1111001;
                    default:
                        segments = 7'b0000000;
                endcase

            62: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b0001000;
                    1:  segments = 7'b1101111;
                    default:
                        segments = 7'b0000000;
                endcase

            63: // Puls
                case(counter)
                    //                7654321
                    0:  segments = 7'b1010101;
                    1:  segments = 7'b0101010;
                    default:
                        segments = 7'b0000000;
                endcase
            */
            default:    
                segments = 7'b0000000;
        endcase
    end
endmodule
