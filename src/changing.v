module changing(
    input wire [3:0] animation,
    output wire [4:0] limit
);

    assign limit = (animation == 4'b0000) ? 10 :  // ani0, 0 -> 9
                (animation == 4'b0001) ? 12 : // ani1, Armin Hartl 
                (animation == 4'b0010) ? 6 :  // ani2, Around clockwise
                (animation == 4'b0011) ? 6 :  // ani3, Around anti-clockwise
                (animation == 4'b0100) ? 6 :  // ani4, Pair do round anti-clockwise
                (animation == 4'b0101) ? 6 :  // ani5, Pair do round clockwise
                (animation == 4'b0110) ? 6 :  // ani6, Pair switcher
                (animation == 4'b0111) ? 2 :  // ani7, Up & Dowen - Case Up & Dowen - Streight
                (animation == 4'b1000) ? 4 :  // ani8, Up & Dowen - Streight
                (animation == 4'b1001) ? 4 :  // ani9, H |-| idk
                (animation == 4'b1010) ? 2 :  // ani10, blinking
                (animation == 4'b1011) ? 2 :  // ani11, o & °
                5'b11111;  // default

endmodule
