module changing(
    input wire [2:0] animation,
    output wire [4:0] limit
);

    assign limit = (animation == 3'b000) ? 10 :  // ani0, 0 -> 9
                (animation == 3'b001) ? 7 :  // ani1, 
                (animation == 3'b010) ? 7 :  // ani2,
                // (animation == 3'b011) ? 7 :  // ani3,
                // (animation == 3'b100) ? 6 :  // ani4,
                // (animation == 3'b101) ? 6 :  // ani5,
                //(animation == 3'b110) ? 11 :  // ani6,
                //(animation == 3'b111) ? 11 :  // ani7,
                5'b11111;  // default

endmodule

