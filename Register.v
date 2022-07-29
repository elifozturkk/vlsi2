`timescale 1ns / 1ps

module Register(
    input clk,
    input rst,
    input[31:0] Rin,
    input Load,
    output reg [31:0] Rout
    );  
    
    always @(negedge clk) 
    begin
    if (rst==1'b1)
        Rout <= 32'd0; 
    else if (Load == 1'b1)
       Rout <= Rin; 
    end 

endmodule 


