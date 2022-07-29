`timescale 1ns / 1ps

module extend_block(
input [31:0] inst,
output reg [31:0] data_out
);

always @(*) begin
    case(inst[6:0]) 
    7'b0110111: data_out <= {inst[31:12], 12'd0}; // LUI
    7'b0010111: data_out <=  {inst[31:12], 12'd0}; // AUIPC    
    7'b1101111: data_out <= inst[31] ? {12'hfff,inst[19:12], inst[20], inst[30:25], inst[24:21],1'b0}:{12'd0,inst[19:12], inst[20], inst[30:25], inst[24:21],1'b0};// jal
    7'b1100111: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]};// jalr
    7'b1100011: data_out <= inst[31] ? {20'hfffff,inst[7],inst[30:25], inst[11:8], 1'b0} : {20'd0,inst[7],inst[30:25], inst[11:8], 1'b0};  // BRANCH
    7'b0000011: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]}; // LB LH LW LBU LBHU
    7'b0100011: data_out <= inst[31] ? {22'h3fffff, inst[30:25], inst[11:8], inst[7]}:{22'd0, inst[30:25], inst[11:8], inst[7]};   // SB SH SW                                                     
    7'b0010011: begin
        case(inst[14:12])
            3'b000: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]};
            3'b010: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]};
            3'b011: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]};
            3'b100: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]};
            3'b110: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]};
            3'b111: data_out <= inst[31] ? {22'h3fffff,inst[30:20]} : {22'd0, inst[30:20]};
            3'b001: data_out <= {27'd0, inst[24:20]};
            3'b101: data_out <= {27'd0, inst[24:20]};
        endcase
    end 
    endcase
end
endmodule

