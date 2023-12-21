module changing(
    input wire [4:0] animation,
    output wire [4:0] limit
);

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
                (animation == 5'b10111) ? 3 :   // ani23,
                (animation == 5'b11000) ? 3 :   // ani24,
                (animation == 5'b11001) ? 3 :   // ani25,
                (animation == 5'b11010) ? 3 :   // ani26,
                (animation == 5'b11011) ? 3 :   // ani27,
                (animation == 5'b11100) ? 3 :   // ani28,
                (animation == 5'b11101) ? 3 :   // ani29,
                (animation == 5'b11110) ? 3 :   // ani30,
                (animation == 5'b11111) ? 3 ;   // ani31,
                5'b11111;  // default

endmodule
