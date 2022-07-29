`timescale 1ns / 1ps

module MUX32x1(
    input [31:0] In1,
    input [31:0] In2,
    input [31:0] In3,
    input [31:0] In4,
    input [31:0] In5,
    input [31:0] In6,
    input [31:0] In7,
    input [31:0] In8,
    input [31:0] In9,
    input [31:0] In10,
    input [31:0] In11,
    input [31:0] In12,
    input [31:0] In13,
    input [31:0] In14,
    input [31:0] In15,
    input [31:0] In16,
    input [31:0] In17,
    input [31:0] In18,
    input [31:0] In19,
    input [31:0] In20,
    input [31:0] In21,
    input [31:0] In22,
    input [31:0] In23,
    input [31:0] In24,
    input [31:0] In25,
    input [31:0] In26,
    input [31:0] In27,
    input [31:0] In28,
    input [31:0] In29,
    input [31:0] In30,
    input [31:0] In31,
    input [31:0] In32,
    input [4:0] sel,
    output [31:0] Out
    );
    reg [31:0] out1; 
    always @ (In1 or In2 or In3 or In4 or In5 or In6 or In7 or In8 or In9 or In10 or In11 or In12 or In13 or In14 or In15 or In16 or In17
              or In18 or In19 or In20 or In21 or In22 or In23 or In24 or In25 or In26 or In27 or In28 or In29 or In30 or In31 or In32 or sel) 
    begin 
        case (sel) 
        5'b00000 : out1 = In1; 
        5'b00001 : out1 = In2; 
        5'b00010 : out1 = In3; 
        5'b00011 : out1 = In4; 
        5'b00100 : out1 = In5; 
        5'b00101 : out1 = In6; 
        5'b00110 : out1 = In7; 
        5'b00111 : out1 = In8;
        5'b01000 : out1 = In9; 
        5'b01001 : out1 = In10; 
        5'b01010 : out1 = In11; 
        5'b01011 : out1 = In12; 
        5'b01100 : out1 = In13; 
        5'b01101 : out1 = In14; 
        5'b01110 : out1 = In15; 
        5'b01111 : out1 = In16;
        5'b10000 : out1 = In17; 
        5'b10001 : out1 = In18; 
        5'b10010 : out1 = In19; 
        5'b10011 : out1 = In20; 
        5'b10100 : out1 = In21; 
        5'b10101 : out1 = In22; 
        5'b10110 : out1 = In23; 
        5'b10111 : out1 = In24;
        5'b11000 : out1 = In25; 
        5'b11001 : out1 = In26; 
        5'b11010 : out1 = In27; 
        5'b11011 : out1 = In28; 
        5'b11100 : out1 = In29; 
        5'b11101 : out1 = In30; 
        5'b11110 : out1 = In31; 
        5'b11111 : out1 = In32;  
        default : out1 = 32'bx; 
        endcase 
    end  
    assign Out = out1;
endmodule

