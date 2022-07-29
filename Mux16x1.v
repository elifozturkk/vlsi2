`timescale 1ns / 1ps


module Mux16x1(
    input [1:0] in1,
    input [1:0] in2,
    input [1:0] in3,
    input [1:0] in4,
    input [1:0] in5,
    input [1:0] in6,
    input [1:0] in7,
    input [1:0] in8,
    input [1:0] in9,
    input [1:0] in10,
    input [1:0] in11,
    input [1:0] in12,
    input [1:0] in13,
    input [1:0] in14,
    input [1:0] in15,
    input [1:0] in16,
    input [3:0] select,
    output reg [1:0] out);

    always @(*) begin
        case(select)
            4'd0: out <= in1;
            4'd1: out <= in2;
            4'd2: out <= in3;
            4'd3: out <= in4;
            4'd4: out <= in5;
            4'd5: out <= in6;
            4'd6: out <= in7;
            4'd7: out <= in8;    
            4'd8: out <= in9;
            4'd9: out <= in10;
            4'd10: out <= in11;
            4'd11: out <= in12;
            4'd12: out <= in13;
            4'd13: out <= in14;
            4'd14: out <= in15;
            4'd15: out <= in16;       
        endcase
end
                    
endmodule

