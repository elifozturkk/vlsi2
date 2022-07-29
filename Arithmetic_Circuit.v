`timescale 1ns / 1ps
module Arithmetic_Circuit
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [1:0] S,
    input Cin,
    output [WIDTH-1:0] G,
    output Cout,
    output V
    );
    
    wire [WIDTH-1:0] Y;
      
    B_input_logic b_inp_logic(.B(B),.S(S),.Y(Y));
    adder parallel_Adder(.x(A),.y(Y),.ci(Cin),.cout(Cout),.s(G),.V(V));
    
endmodule

module B_input_logic
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0] B,
    input [1:0] S,
    output [WIDTH-1:0] Y
    );
    
    wire [WIDTH-1:0] B_not,and1_out,and2_out;
    
     genvar i;
      generate
         for (i=0; i < WIDTH; i=i+1)
         begin
              NOT_module NOT_Gate (.a(B[i]), .r(B_not[i])); 
              AND_module AND_Gate (.a(B[i]), .b(S[0]), .r(and1_out[i]));
              AND_module AND_Gate2 (.a(B_not[i]), .b(S[1]), .r(and2_out[i]));
              OR_module OR_Gate (.a(and1_out[i]), .b(and2_out[i]), .r(Y[i]));  
         end
      endgenerate
               
    
endmodule

module parametric_RCA
#(parameter SIZE = 32 )
(
        input [SIZE-1:0] x,
        input [SIZE-1:0] y,
        input ci,
        output cout,
        output [SIZE-1:0] s,
        output V
        );
        
wire [SIZE:0] w;

assign w[0] = ci;


    genvar i;
    generate 
        for(i=0;i<SIZE;i=i+1)
        begin
            FA full_adder( .x(x[i]), .y(y[i]),.cin(w[i]), .cout(w[i+1]), .s(s[i]));
        end 
    endgenerate

assign cout = w[SIZE];
//assign V = w[SIZE-1]^w[SIZE-2];
assign V = (~x[SIZE-1]&~y[SIZE-1]&w[SIZE-2])|(x[SIZE-1]&y[SIZE-1]&~w[SIZE-2]);
endmodule

module HA(
        input x,
        input y,
        output cout,
        output s);

AND_module AND_Gate (.a(x), .b(y), .r(cout));
XOR_module XOR_Gate (.a(x), .b(y), .r(s));

endmodule


module FA(
        input x,
        input y,
        input cin,
        output cout,
        output s);
        
wire w1,w2,w3;

HA half_adder( .x(x), .y(y), .cout(w1), .s(w3));
HA half_adder2( .x(cin), .y(w3), .cout(w2), .s(s));
OR_module or_gate( .a(w1), .b(w2), .r(cout));

endmodule

module adder
#(parameter SIZE = 32 )
(
        input [SIZE-1:0] x,
        input [SIZE-1:0] y,
        input ci,
        output cout,
        output [SIZE-1:0] s,
        output V
        );
wire [12:0] Cout; 
wire [12:0] v; 
wire [31:0] sw1,sw2;
wire C1,C3,C6,C10,C16,C23;
        
 parametric_RCA #(.SIZE(2)) adder_1_0(.x(x[1:0]),.y(y[1:0]),.ci(ci),.cout(C1),.s(s[1:0]),.V(v[0]));
 
 parametric_RCA #(.SIZE(2)) adder_2_0(.x(x[3:2]),.y(y[3:2]),.ci(0),.cout(Cout[0]),.s(sw1[3:2]),.V(v[1]));
 parametric_RCA #(.SIZE(2)) adder_2_1(.x(x[3:2]),.y(y[3:2]),.ci(1),.cout(Cout[1]),.s(sw2[3:2]),.V(v[2]));
 
 MUX4x2 #(.SIZE(2)) mux1(sw1[3:2],sw2[3:2],Cout[0],Cout[1],C1,C3,s[3:2]);
 
 parametric_RCA #(.SIZE(3)) adder_3_0(.x(x[6:4]),.y(y[6:4]),.ci(0),.cout(Cout[2]),.s(sw1[6:4]),.V(v[3]));
 parametric_RCA #(.SIZE(3)) adder_3_1(.x(x[6:4]),.y(y[6:4]),.ci(1),.cout(Cout[3]),.s(sw2[6:4]),.V(v[4]));
 
 MUX4x2 #(.SIZE(3)) mux2(sw1[6:4],sw2[6:4],Cout[2],Cout[3],C3,C6,s[6:4]);
 
 parametric_RCA #(.SIZE(4)) adder_4_0(.x(x[10:7]),.y(y[10:7]),.ci(0),.cout(Cout[4]),.s(sw1[10:7]),.V(v[5]));
 parametric_RCA #(.SIZE(4)) adder_4_1(.x(x[10:7]),.y(y[10:7]),.ci(1),.cout(Cout[5]),.s(sw2[10:7]),.V(v[6]));
 
 MUX4x2 #(.SIZE(4)) mux3(sw1[10:7],sw2[10:7],Cout[4],Cout[5],C6,C10,s[10:7]);
 
 parametric_RCA #(.SIZE(6)) adder_5_0(.x(x[16:11]),.y(y[16:11]),.ci(0),.cout(Cout[6]),.s(sw1[16:11]),.V(v[7]));
 parametric_RCA #(.SIZE(6)) adder_5_1(.x(x[16:11]),.y(y[16:11]),.ci(1),.cout(Cout[7]),.s(sw2[16:11]),.V(v[8]));
 
 MUX4x2 #(.SIZE(6)) mux4(sw1[16:11],sw2[16:11],Cout[6],Cout[7],C10,C16,s[16:11]);
 
 parametric_RCA #(.SIZE(7)) adder_6_0(.x(x[23:17]),.y(y[23:17]),.ci(0),.cout(Cout[8]),.s(sw1[23:17]),.V(v[9]));
 parametric_RCA #(.SIZE(7)) adder_6_1(.x(x[23:17]),.y(y[23:17]),.ci(1),.cout(Cout[9]),.s(sw2[23:17]),.V(v[10]));
 
 MUX4x2 #(.SIZE(7)) mux5(sw1[23:17],sw2[23:17],Cout[8],Cout[9],C16,C23,s[23:17]);
 
 parametric_RCA #(.SIZE(8)) adder_7_0(.x(x[31:24]),.y(y[31:24]),.ci(0),.cout(Cout[10]),.s(sw1[31:24]),.V(v[11]));
 parametric_RCA #(.SIZE(8)) adder_7_1(.x(x[31:24]),.y(y[31:24]),.ci(1),.cout(Cout[11]),.s(sw2[31:24]),.V(v[12]));
 
 MUX6x3_w_V #(.SIZE(8)) mux6(sw1[31:24],sw2[31:24],Cout[8],Cout[9],v[11],v[12],C23,cout,V,s[31:24]);
       
endmodule

module MUX4x2
#(parameter SIZE = 2)(
    input [SIZE-1:0] i0,
    input [SIZE-1:0] i1,
    input  co1,
    input  co2,
    input  S,
    output reg cout,
    output reg [SIZE-1:0] G
    );
    
    always @(*)
          case (S)
             1'b0: begin G = i0; cout = co1; end
             1'b1: begin G = i1; cout = co2; end
          endcase
    endmodule
    
module MUX6x3_w_V
    #(parameter SIZE = 2)(
        input [SIZE-1:0] i0,
        input [SIZE-1:0] i1,
        input  co1,
        input  co2,
        input  V1,
        input  V2,
        input  S,
        output reg cout,
        output reg V,
        output reg [SIZE-1:0] G
        );
        
        always @(*)
              case (S)
                 1'b0: begin G = i0; cout = co1; V = V1; end
                 1'b1: begin G = i1; cout = co2; V = V2; end
              endcase
        endmodule

module NOT_module(

    input  a,
    output r
    );
    assign r = ~a ;
endmodule

module AND_module(
    input  a,
    input  b,
    output  r
    );
    assign r = a & b;
endmodule

module OR_module(
    input  a,
    input  b,
    output  r
    );
    assign r = a | b;
endmodule
module XOR_module(
    input  a,
    input  b,
    output  r
    );
    assign r = a ^ b;
endmodule

