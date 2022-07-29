`timescale 1ns / 1ps

module register_3 #(parameter SIZE = 1)(
    input clk,
    input rst,
    input [SIZE-1:0] Rin,
    output reg [SIZE-1:0]  Rout
    );  
    reg [SIZE-1:0] Rout_1;
    reg [SIZE-1:0] Rout_2;
    
    always @(posedge clk) 
    begin
    if (rst==1) begin
       Rout <= {SIZE{1'd0}};      
    end else begin
       Rout_1 <= Rin; 
       Rout_2 <= Rout_1; 
       Rout <= Rout_2; 
    end 
    end

endmodule 


