`timescale 1ns / 1ps

module IF_ID_pipeline(
input clk,
input rst,
input Load,
input [95:0] Din,
output reg [95:0] Dout
    );
    
    always @(posedge clk) 
    begin
    if (rst==1'b1)
        Dout <= 96'd0; 
    else if (Load == 1'b1)
        Dout <= Din; 
    end 
    
endmodule

