`timescale 1ns / 1ps

module Logic_Circuit
#(parameter WIDTH = 32)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [1:0] S,
    output [WIDTH-1:0] G
    );
    
    wire [WIDTH-1:0] and_out,or_out,xor_out,not_out;
  
    AND32 AND_Gate (.a(A), .b(B), .r(and_out));
    OR32 OR_Gate (.a(A), .b(B), .r(or_out));  
    XOR32 XOR_Gate (.a(A), .b(B), .r(xor_out));
    NOT32 NOT_Gate (.a(A), .r(not_out));
    
    MUX4x1 mux(.i0(and_out),.i1(or_out),.i2(xor_out),.i3(not_out),.S(S),.G(G));
     
endmodule

module AND32
#(parameter WIDTH = 32)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] r
    );
    
    assign r = a & b;
    
endmodule

module OR32
#(parameter WIDTH = 32)(
    input [WIDTH-1:0]  a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] r
    );
    assign r = a | b;
endmodule

module XOR32
#(parameter WIDTH = 32)(
    input [WIDTH-1:0]  a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] r
    );
    assign r = a ^ b;
endmodule

module NOT32
#(parameter WIDTH = 32)(
    input [WIDTH-1:0] a,
    output [WIDTH-1:0] r
    );
    assign r = ~a;
endmodule

module MUX4x1
#(parameter WIDTH = 32)(
    input [WIDTH-1:0] i0,
    input [WIDTH-1:0] i1,
    input [WIDTH-1:0] i2,
    input [WIDTH-1:0] i3,
    input [1:0] S,
    output reg [WIDTH-1:0] G
    );
    
    always @(*)
          case (S)
             2'b00: G = i0;
             2'b01: G = i1;
             2'b10: G = i2;
             2'b11: G = i3;
          endcase
    
    endmodule
