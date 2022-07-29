`timescale 1ns / 1ps
// boyutu  ????
module DataMem #(parameter RAM_WIDTH = 8,RAM_ADDR_BITS = 8)
(clk, rst, Data_in, Address, write_enable, Data_out); 

input clk;
input rst;
input [3:0] write_enable;    
input[RAM_ADDR_BITS-1:0] Address;
input[32-1:0] Data_in; 
output reg [32-1:0] Data_out;

reg[RAM_WIDTH-1:0] Memory[11:0];

always @(*) begin
        if (rst == 1'b1) begin
                    
			Memory [0] <= 8'h00;
			Memory [1] <= 8'h00;
			Memory [2] <= 8'h00;
			Memory [3] <= 8'h04;
			Memory [4] <= 8'h00;
			Memory [5] <= 8'h00;
			Memory [6] <= 8'h00;
			Memory [7] <= 8'h00;
			Memory [8] <= 8'h00;
			Memory [9] <= 8'h00;
			Memory [10] <= 8'h00;
			Memory [11] <= 8'h00;

end else begin

	case (write_enable)
		4'b0001:begin// SW
				Memory[Address] <= Data_in[31:24];
				Memory[Address+8'b1] <= Data_in[23:16];
				Memory[Address+8'b10] <= Data_in[15:8];
				Memory[Address+8'b11] <= Data_in[7:0];
				end
		4'b0010:begin// SH 
				Memory[Address] <= Data_in[15:8];
				Memory[Address+8'b1] <= Data_in[7:0];			
				end
		4'b0011:Memory[Address] <= Data_in[7:0];// Sb
		4'b0100:Data_out <= {Memory[Address], Memory[Address+8'b1], Memory[Address+8'b10], Memory[Address+8'b11]};//LW
		4'b0101:Data_out <= Memory[Address][7] ? {16'hffff, Memory[Address], Memory[Address+8'b1]} : {16'h0000, Memory[Address], Memory[Address+8'b1]};// LH
		4'b0110:Data_out <= Memory[Address][7] ? {24'hffffff, Memory[Address]} : {24'h0000, Memory[Address]}; //LB
		4'b0111:Data_out <= {16'h0000, Memory[Address], Memory[Address + 8'b1]};// LHU
		4'b1000:Data_out <= {24'h0000, Memory[Address]};// LBU
	endcase
end
end    
endmodule
