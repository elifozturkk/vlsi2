`timescale 1ns / 1ps

module forward_mem(
    input [4:0] rd_MEMWB,
    input [4:0] rs2_EXMEM,
    input store_flag_EXMEM,
    input load_flag_MEMWB,
    output reg forward_mem
    );
    
    always @(*) begin
    
        if((store_flag_EXMEM == 1'b1) & (load_flag_MEMWB == 1'b1) & (rd_MEMWB != 5'b00000) & (rs2_EXMEM == rd_MEMWB)) begin
            forward_mem = 1'b1;
        end else begin
            forward_mem = 1'b0;
        end
        
    end
    
endmodule

