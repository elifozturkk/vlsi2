`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2021 00:11:43
// Design Name: 
// Module Name: IF_ID_pipeline
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB_pipeline(
input clk,
input rst,
input Load,
input [68:0] Din,
output reg [68:0] Dout
    );
    
    always @(posedge clk) 
    begin
    if (rst==1'b1)
        Dout <= 69'd0; 
    else if (Load == 1'b1)
        Dout <= Din; 
    end 
    
endmodule

