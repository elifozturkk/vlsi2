`timescale 1ns / 1ps


module SLTU(
    input a,b,C,
    output[31:0] SLU
    );
    wire LessU;
    
    assign LessU = ((~a) & C) | ((~a) & b) | (b & C);
    assign SLU = {31'b0000000000000000000000000000000, LessU}; 
endmodule

