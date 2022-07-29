`timescale 1ns / 1ps

module hazard_detection_unit(
    input [4:0] Rs1_IFID,
    input [4:0] Rs2_IFID,
    input [4:0] Rd_IDEX,
    input MemRead_IDEX,
    input IDControlBranch,
    output reg PCWrite,
    output reg IFIDWrite,
    output reg cont_mux_sel,
    output reg IF_Flush
    );
    
    always @(*)
        begin
        
            if((MemRead_IDEX == 1'b1) &  ((Rs2_IFID == Rd_IDEX) | (Rs1_IFID == Rd_IDEX))) begin
                PCWrite = 1'b0;
                IFIDWrite = 1'b0;
                cont_mux_sel = 1'b1;
            end else begin
                PCWrite = 1'b1;
                IFIDWrite = 1'b1;
                cont_mux_sel = 1'b0;
            end
            
            if(IDControlBranch == 1'b1) IF_Flush = 1'b1;
            else IF_Flush = 1'b0;
                  
        end
    
endmodule

