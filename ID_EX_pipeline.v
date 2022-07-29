`timescale 1ns / 1ps

module ID_EX_pipeline(
input clk,
input rst,
input Load,
input [164:0] Din,
output reg [164:0] Dout
    );
    
    always @(posedge clk) 
    begin
    if (rst==1'b1)
        Dout <= 165'd0; 
    else if (Load == 1'b1)
        Dout <= Din; 
    end 
    
endmodule

