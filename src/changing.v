`default_nettype none 
//`timescale 1ns / 1ps

module changing (
    input wire [5:0] animation,
    output wire [5:0] limit
);

    assign limit = (animation == 6'b000000) ? 9 :  // ani0, 0 -> 9
                (animation == 6'b000001) ? 11 :  // ani1, Armin Hartl 
                (animation == 6'b000010) ? 5 :   // ani2, Around clockwise
                (animation == 6'b000011) ? 5 :   // ani3, Around anti-clockwise
                (animation == 6'b000100) ? 5 :   // ani4, Pair do round anti-clockwise
                (animation == 6'b000101) ? 5 :   // ani5, Pair do round clockwise
                (animation == 6'b000110) ? 5 :   // ani6, Pair switcher
                (animation == 6'b000111) ? 1 :   // ani7, Up & Down - Case Up & Down - Straight
                (animation == 6'b001000) ? 3 :   // ani8, Up & Down - Straight
                (animation == 6'b001001) ? 3 :   // ani9, H |-| idk
                (animation == 6'b001010) ? 1 :   // ani10, blinking
                (animation == 6'b001011) ? 1 :   // ani11, o & °
                (animation == 6'b001100) ? 1 :   // ani12, right & left
                (animation == 6'b001101) ? 1 :   // ani13, half H 1
                (animation == 6'b001110) ? 1 :   // ani14, half H 2
                (animation == 6'b001111) ? 3 :   // ani15, Circle down
                (animation == 6'b010000) ? 4 :   // ani16, Hello
                (animation == 6'b010001) ? 1 :   // ani17, Schräg
                (animation == 6'b010010) ? 6 :   // ani18, Random 1
                (animation == 6'b010011) ? 6 :   // ani19, Random 2
                (animation == 6'b010100) ? 6 :   // ani20, Random 3
                (animation == 6'b010101) ? 6 :   // ani21, Random 4
                (animation == 6'b010110) ? 6 :   // ani22, Random 5
                (animation == 6'b010111) ? 3 :   // ani23, Circle up
                (animation == 6'b011000) ? 15 :  // ani24, Random+ 1
                (animation == 6'b011001) ? 15 :  // ani25, Random+ 2
                (animation == 6'b011010) ? 15 :  // ani26, Random+ 3
                (animation == 6'b011011) ? 15 :  // ani27, Random Numbers
                (animation == 6'b011100) ? 31 :  // ani28, Random Numbers+
                (animation == 6'b011101) ? 3 :   // ani29, Pulse
                (animation == 6'b011110) ? 10 :  // ani30, Birthday
                (animation == 6'b011111) ? 31 :  // ani31, Random++
               // New animations ST_ANI32 to ST_ANI50
                (animation == 6'b100000) ? 4 :   // ani32, Pulse
                (animation == 6'b100001) ? 8 :   // ani33, Online try
            /*    (animation == 6'b100010) ? 4 :   // ani34
                (animation == 6'b100011) ? 4 :   // ani35
                (animation == 6'b100100) ? 4 :   // ani36
                (animation == 6'b100101) ? 4 :   // ani37
                (animation == 6'b100110) ? 4 :   // ani38
                (animation == 6'b100111) ? 4 :   // ani39
                (animation == 6'b101000) ? 4 :   // ani40
                (animation == 6'b101001) ? 4 :   // ani41
                (animation == 6'b101010) ? 4 :   // ani42
                (animation == 6'b101011) ? 4 :   // ani43
                (animation == 6'b101100) ? 4 :   // ani44
                (animation == 6'b101101) ? 4 :   // ani45
                (animation == 6'b101110) ? 4 :   // ani46
                (animation == 6'b101111) ? 4 :   // ani47
                (animation == 6'b110000) ? 4 :   // ani48
                (animation == 6'b110001) ? 4 :   // ani49
                (animation == 6'b110010) ? 4 :   // ani50
                (animation == 6'b110011) ? 2 :   // ani51
                (animation == 6'b110100) ? 2 :   // ani52
                (animation == 6'b110101) ? 2 :   // ani53
                (animation == 6'b110110) ? 2 :   // ani54
                (animation == 6'b110111) ? 2 :   // ani55
                (animation == 6'b111000) ? 2 :   // ani56
                (animation == 6'b111001) ? 2 :   // ani57
                (animation == 6'b111010) ? 2 :   // ani58
                (animation == 6'b111011) ? 2 :   // ani59
                (animation == 6'b111100) ? 2 :   // ani60
                (animation == 6'b111101) ? 2 :   // ani61
                (animation == 6'b111110) ? 2 :   // ani62
                (animation == 6'b111111) ? 2 :   // ani63
            */  6'b111111;  // default

endmodule
