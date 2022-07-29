`timescale 1ns / 1ps

module ForwardingUnit(
    input [4:0] rs1_IDEX,
    input [4:0] rs2_IDEX,
    input [4:0] rs1_IFID,
    input [4:0] rs2_IFID,
    input [4:0] rs1_inst,
    input [4:0] rs2_inst,
    input [4:0] Rd_IDEX,
    input [4:0] Rd_EXMEM,
    input [4:0] Rd_MEMWB,
    input Regwrite_EXMEM,
    input Regwrite_MEMWB,
    input IDControlBranch,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB,
    output reg [1:0] forwardC,
    output reg [1:0] forwardD
    );
  
    always @(*)
    begin
    
        if((Regwrite_EXMEM == 1'b1) & (Rd_EXMEM != 5'b00000)  & (rs1_IDEX == Rd_EXMEM)) begin
            forwardA = 2'b10;
        end else begin
            forwardA = 2'b00;
        end
        if((Regwrite_EXMEM == 1'b1) & (Rd_EXMEM != 5'b00000)  & (rs2_IDEX == Rd_EXMEM)) begin
            forwardB = 2'b10;
        end else begin
            forwardB = 2'b00;
        end
        if((Regwrite_MEMWB == 1'b1) & (Rd_MEMWB != 5'b00000) &(~((Regwrite_EXMEM == 1'b1) & (Rd_EXMEM != 5'b00000)  & (rs1_IDEX == Rd_EXMEM)))  & (rs1_IDEX == Rd_MEMWB)) begin
            forwardA = 2'b01;
        end 
        if((Regwrite_MEMWB == 1'b1) & (Rd_MEMWB != 5'b00000) &(~((Regwrite_EXMEM == 1'b1) & (Rd_EXMEM != 5'b00000)  & (rs2_IDEX == Rd_EXMEM)))  & (rs2_IDEX == Rd_MEMWB)) begin
            forwardB = 2'b01;
        end 
        
        //alu + branch
        if((IDControlBranch == 1'b1) & (Rd_IDEX != 5'b00000)  & (rs1_IFID == Rd_IDEX)) begin
            forwardC = 2'b01;
        end else begin
            forwardC = 2'b00;
        end
        if((IDControlBranch == 1'b1) & (Rd_IDEX != 5'b00000)  & (rs2_IFID == Rd_IDEX)) begin
            forwardD = 2'b01;
        end else begin
            forwardD = 2'b00;
        end 
        //load + branch
        if((IDControlBranch == 1'b1) & (Rd_EXMEM != 5'b00000)  & (rs1_IFID == Rd_EXMEM)&(~(((IDControlBranch == 1'b1) & (Rd_IDEX != 5'b00000)  & (rs1_IFID == Rd_IDEX))))) begin
            forwardC = 2'b10;
        end 
        if((IDControlBranch == 1'b1) & (Rd_EXMEM != 5'b00000)  & (rs2_IFID == Rd_EXMEM) &(~(((IDControlBranch == 1'b1) & (Rd_IDEX != 5'b00000)  & (rs2_IFID == Rd_IDEX))))) begin
            forwardD = 2'b10;
        end 
 
    end
    
endmodule

