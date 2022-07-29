`timescale 1ns / 1ps

module PC_register(
    input clk,
    input rst,
    input en,
    input[31:0] Rin,
    output reg[31:0] Rout
    );
    
    always @(posedge clk) 
    begin
        if(rst == 1'b1)
            Rout <= 32'd0;
        else if (en == 1'b1) 
            Rout <= Rin; 
    end
    
endmodule
