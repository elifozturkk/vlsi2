`timescale 1ns / 1ps

module Function_Unit
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [5:0] FS,
    output [WIDTH-1:0] F,
    output V,
    output C,
    output N,
    output Z,
    output Less_U   
    );
   
   wire Cout;
   wire [WIDTH-1:0] Less, LessU;
   wire [WIDTH-1:0] G,H;
   
   ALU arithmetic_logic_unit( A,B,FS[3:1],FS[0],G,Cout,V); 
   Shifter shifter(A,B[4:0],FS[1:0],H); 
   
   assign Less = {31'b0000000000000000000000000000000, ( G[31] ^ V)};
   
   SLTU SLTU1(.a(A[31]), .b(B[31]), .C(G[31]), .SLU(LessU));
 
   MUX4x1 mux(.i0(G),.i1(H),.i2(Less),.i3(LessU),.S(FS[5:4]),.G(F));
   zero_detect zerodetect(.in_32(F),.Z(Z));
   assign C = Cout; 
   assign N = G[31]; 
   assign Less_U = LessU;
//   assign BEQ = F ? 0:1; 
//   assign BNE = F ? 1:0; 
//   assign BLT = Less[0];// F[31]
//   assign BGE = ~Less[0];
//   assign BLTU = LessU[0];
//   assign BGEU = ~LessU[0];//U?
   
endmodule


module zero_detect(
input [31:0] in_32,
output reg Z
);

always @(*)
begin
if(in_32 == 32'd0) Z <= 1'b1;
else Z <= 1'b0;
end
endmodule

