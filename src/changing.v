module changing(
    input wire [5:0] animation,
    output wire [4:0] limit
);
/*
    assign limit = (animation == 5'b00000) ? 10 :  // ani0, 0 -> 9
                (animation == 5'b00001) ? 12 :  // ani1, Armin Hartl 
                (animation == 5'b00010) ? 6 :   // ani2, Around clockwise
                (animation == 5'b00011) ? 6 :   // ani3, Around anti-clockwise
                (animation == 5'b00100) ? 6 :   // ani4, Pair do round anti-clockwise
                (animation == 5'b00101) ? 6 :   // ani5, Pair do round clockwise
                (animation == 5'b00110) ? 6 :   // ani6, Pair switcher
                (animation == 5'b00111) ? 2 :   // ani7, Up & Down - Case Up & Down - Straight
                (animation == 5'b01000) ? 4 :   // ani8, Up & Down - Straight
                (animation == 5'b01001) ? 4 :   // ani9, H |-| idk
                (animation == 5'b01010) ? 2 :   // ani10, blinking
                (animation == 5'b01011) ? 2 :   // ani11, o & °
                (animation == 5'b01100) ? 2 :   // ani12, right & left
                (animation == 5'b01101) ? 2 :   // ani13, half H 1
                (animation == 5'b01110) ? 2 :   // ani14, half H 2
                (animation == 5'b01111) ? 4 :   // ani15, Circle down
                (animation == 5'b10000) ? 6 :   // ani16, Hello
                (animation == 5'b10001) ? 2 :   // ani17, Schräg
                (animation == 5'b10010) ? 7 :   // ani18, Randome 1
                (animation == 5'b10011) ? 7 :   // ani19, Randome 2
                (animation == 5'b10100) ? 7 :   // ani20, Randome 3
                (animation == 5'b10101) ? 7 :   // ani21, Randome 4
                (animation == 5'b10110) ? 7 :   // ani22, Randome 5
                (animation == 5'b10111) ? 4 :   // ani23, Cuircle up
                (animation == 5'b11000) ? 16 :   // ani24, Randome+ 1
                (animation == 5'b11001) ? 16 :   // ani25, Randome+ 2
                (animation == 5'b11010) ? 16 :   // ani26, Randome+ 3
                (animation == 5'b11011) ? 16 :   // ani27, Randome Numbers
                (animation == 5'b11100) ? 32 :   // ani28, Randome Numbers+
                (animation == 5'b11101) ? 5 :   // ani29, Puls
                (animation == 5'b11110) ? 11 :   // ani30, Birthday
                (animation == 5'b11111) ? 32 :   // ani31, Randome++
                5'b11111;  // default
*/
    assign limit = (animation == 6'b000000) ? 10 :  // ani0, 0 -> 9
                (animation == 6'b000001) ? 12 :  // ani1, Armin Hartl 
                (animation == 6'b000010) ? 6 :   // ani2, Around clockwise
                (animation == 6'b000011) ? 6 :   // ani3, Around anti-clockwise
                (animation == 6'b000100) ? 6 :   // ani4, Pair do round anti-clockwise
                (animation == 6'b000101) ? 6 :   // ani5, Pair do round clockwise
                (animation == 6'b000110) ? 6 :   // ani6, Pair switcher
                (animation == 6'b000111) ? 2 :   // ani7, Up & Down - Case Up & Down - Straight
                (animation == 6'b001000) ? 4 :   // ani8, Up & Down - Straight
                (animation == 6'b001001) ? 4 :   // ani9, H |-| idk
                (animation == 6'b001010) ? 2 :   // ani10, blinking
                (animation == 6'b001011) ? 2 :   // ani11, o & °
                (animation == 6'b001100) ? 2 :   // ani12, right & left
                (animation == 6'b001101) ? 2 :   // ani13, half H 1
                (animation == 6'b001110) ? 2 :   // ani14, half H 2
                (animation == 6'b001111) ? 4 :   // ani15, Circle down
                (animation == 6'b010000) ? 6 :   // ani16, Hello
                (animation == 6'b010001) ? 2 :   // ani17, Schräg
                (animation == 6'b010010) ? 7 :   // ani18, Random 1
                (animation == 6'b010011) ? 7 :   // ani19, Random 2
                (animation == 6'b010100) ? 7 :   // ani20, Random 3
                (animation == 6'b010101) ? 7 :   // ani21, Random 4
                (animation == 6'b010110) ? 7 :   // ani22, Random 5
                (animation == 6'b010111) ? 4 :   // ani23, Circle up
                (animation == 6'b011000) ? 16 :  // ani24, Random+ 1
                (animation == 6'b011001) ? 16 :  // ani25, Random+ 2
                (animation == 6'b011010) ? 16 :  // ani26, Random+ 3
                (animation == 6'b011011) ? 16 :  // ani27, Random Numbers
                (animation == 6'b011100) ? 32 :  // ani28, Random Numbers+
                (animation == 6'b011101) ? 5 :   // ani29, Pulse
                (animation == 6'b011110) ? 11 :  // ani30, Birthday
                (animation == 6'b011111) ? 32 :  // ani31, Random++
               // New animations ST_ANI32 to ST_ANI50
                (animation == 6'b100000) ? 5 :   // ani32
                (animation == 6'b100001) ? 5 :   // ani33
                (animation == 6'b100010) ? 5 :   // ani34
                (animation == 6'b100011) ? 5 :   // ani35
                (animation == 6'b100100) ? 5 :   // ani36
                (animation == 6'b100101) ? 5 :   // ani37
                (animation == 6'b100110) ? 5 :   // ani38
                (animation == 6'b100111) ? 5 :   // ani39
                (animation == 6'b101000) ? 5 :   // ani40
                (animation == 6'b101001) ? 5 :   // ani41
                (animation == 6'b101010) ? 5 :   // ani42
                (animation == 6'b101011) ? 5 :   // ani43
                (animation == 6'b101100) ? 5 :   // ani44
                (animation == 6'b101101) ? 5 :   // ani45
                (animation == 6'b101110) ? 5 :   // ani46
                (animation == 6'b101111) ? 5 :   // ani47
                (animation == 6'b110000) ? 5 :   // ani48
                (animation == 6'b110001) ? 5 :   // ani49
                (animation == 6'b110010) ? 5 :   // ani50
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
                6'b111111;  // default

endmodule
