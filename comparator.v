`timescale 1ns / 1ps

module comparator(
    input [31:0] A,
    input [31:0] B,
    output reg BEQ,BNE,BLT,BGE,BLTU,BGEU
    );
       
always @(*) begin
    if(A == B) begin
         BEQ <= 1'b1;
         BNE <= 1'b0;
         BLT <= 1'b0;
         BGE <= 1'b1;
    end else if (A < B) begin
         BEQ <= 1'b0;
         BNE <= 1'b1;
         BLT <= 1'b1;
         BGE <= 1'b0;  
    end else if (A > B) begin
         BEQ <= 1'b0;
         BNE <= 1'b1;
         BLT <= 1'b0;
         BGE <= 1'b1;
    end
    //UNSIGNED İÇİN
    if (A[31]==1'b1 & B[31]==1'b0) begin
         BLTU <= 1'b0;
         BGEU <= 1'b1;    
    end else if (A[31]==1'b0 & B[31]==1'b1) begin
         BLTU <= 1'b1;
         BGEU <= 1'b0;
    end else if ((A[31]==1'b0 & B[31]==1'b0)|(A[31]==1'b1 & B[31]==1'b1)) begin
        if(A == B) begin
             BLTU <= 1'b0;
             BGEU <= 1'b1;
        end else if (A < B) begin
             BLTU <= 1'b1;
             BGEU <= 1'b0;  
        end else if (A > B) begin
             BLTU <= 1'b0;
             BGEU <= 1'b1;
        end    
    end 
end

endmodule

