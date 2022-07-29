`timescale 1ns / 1ps

module ALU
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [2:0] S,
    input Cin,
    output [WIDTH-1:0] G,
    output Cout,
    output V
    );
    
    wire [WIDTH-1:0] G1,G2;
    
    Logic_Circuit logic_circuit(
        .A(A),
        .B(B),
        .S({S[0],Cin}),
        .G(G1)
        );
   
    Arithmetic_Circuit arith_cir(
        .A(A),
        .B(B),
        .S(S[1:0]),
        .Cin(Cin),
        .G(G2),
        .Cout(Cout),
        .V(V));
    
    MUX2x1 mux(.i0(G2),.i1(G1),.S(S[2]),.G(G));
    
endmodule

module MUX2x1
#(parameter WIDTH = 32)(
    input [WIDTH-1:0] i0,
    input [WIDTH-1:0] i1,
    input  S,
    output reg [WIDTH-1:0] G
    );
    
    always @(*)
          case (S)
             1'b0: G = i0;
             1'b1: G = i1;
             default: G = i0;
          endcase
    
    endmodule
