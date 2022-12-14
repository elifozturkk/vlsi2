`timescale 1ns / 1ps

module Instruction_memory #(parameter RAM_WIDTH = 8, RAM_ADDR_BITS = 32)
(rst, Address, Data_out); 

input rst;
input[RAM_ADDR_BITS-1:0] Address;
output reg [RAM_ADDR_BITS-1:0] Data_out;

reg [RAM_WIDTH-1:0] Memory  [79:0];

always @(*) begin
        if (rst == 1'b1) begin
                 /*
			Memory [0] <= 8'h00;
			Memory [1] <= 8'h00;
			Memory [2] <= 8'h00;
			Memory [3] <= 8'h00;
			Memory [4] <= 8'h00;
			Memory [5] <= 8'h00;
			Memory [6] <= 8'h00;
			Memory [7] <= 8'h00;
			Memory [8] <= 8'h00;
			Memory [9] <= 8'h00;
			Memory [10] <= 8'h00;
			Memory [11] <= 8'h00;*/

  
			Memory [0] <= 8'h02;
			Memory [1] <= 8'h00;
			Memory [2] <= 8'h80;
			Memory [3] <= 8'h93;
			Memory [4] <= 8'h00;
			Memory [5] <= 8'hA1;
			Memory [6] <= 8'h01;
			Memory [7] <= 8'h13;
			Memory [8] <= 8'h00;
			Memory [9] <= 8'hB1;
			Memory [10] <= 8'h81;
			Memory [11] <= 8'h93;
			Memory [12] <= 8'h00;
			Memory [13] <= 8'hC2;
			Memory [14] <= 8'h02;
			Memory [15] <= 8'h13;
			Memory [16] <= 8'h00;
			Memory [17] <= 8'h02;
			Memory [18] <= 8'h82;
			Memory [19] <= 8'h93;
			Memory [20] <= 8'h00;
			Memory [21] <= 8'h10;
			Memory [22] <= 8'h03;
			Memory [23] <= 8'h13;
			Memory [24] <= 8'hFF;
			Memory [25] <= 8'hF0;
			Memory [26] <= 8'h80;
			Memory [27] <= 8'h93;
			Memory [28] <= 8'h00;
			Memory [29] <= 8'h12;
			Memory [30] <= 8'h92;
			Memory [31] <= 8'h93;
			Memory [32] <= 8'h00;
			Memory [33] <= 8'h22;
			Memory [34] <= 8'hC4;
			Memory [35] <= 8'h63;
			Memory [36] <= 8'h40;
			Memory [37] <= 8'h22;
			Memory [38] <= 8'h82;
			Memory [39] <= 8'hB3;
			Memory [40] <= 8'h00;
			Memory [41] <= 8'h12;
			Memory [42] <= 8'h53;
			Memory [43] <= 8'hB3;
			Memory [44] <= 8'h00;
			Memory [45] <= 8'h63;
			Memory [46] <= 8'hF3;
			Memory [47] <= 8'hB3;
			Memory [48] <= 8'h00;
			Memory [49] <= 8'h63;
			Memory [50] <= 8'h94;
			Memory [51] <= 8'h63;
			Memory [52] <= 8'h00;
			Memory [53] <= 8'h32;
			Memory [54] <= 8'h82;
			Memory [55] <= 8'hB3;
			Memory [56] <= 8'h00;
			Memory [57] <= 8'h22;
			Memory [58] <= 8'hC4;
			Memory [59] <= 8'h63;
			Memory [60] <= 8'h40;
			Memory [61] <= 8'h22;
			Memory [62] <= 8'h82;
			Memory [63] <= 8'hB3;
			Memory [64] <= 8'hFC;
			Memory [65] <= 8'h00;
			Memory [66] <= 8'h9C;
			Memory [67] <= 8'hE3;
			Memory [68] <= 8'h00;
			Memory [69] <= 8'h22;
			Memory [70] <= 8'hC6;
			Memory [71] <= 8'h63;
			Memory [72] <= 8'h40;
			Memory [73] <= 8'h22;
			Memory [74] <= 8'h82;
			Memory [75] <= 8'hB3;
			Memory [76] <= 8'hFE;
			Memory [77] <= 8'h22;
			Memory [78] <= 8'hDE;
			Memory [79] <= 8'hE3;
/*
		
			Memory [0] <= 8'h01;
			Memory [1] <= 8'h40;
			Memory [2] <= 8'h80;
			Memory [3] <= 8'h93;
			Memory [4] <= 8'h01;
			Memory [5] <= 8'h41;
			Memory [6] <= 8'h81;
			Memory [7] <= 8'h93;
			Memory [8] <= 8'h00;
			Memory [9] <= 8'h51;
			Memory [10] <= 8'h01;
			Memory [11] <= 8'h13;
			Memory [12] <= 8'h01;
			Memory [13] <= 8'h93;
			Memory [14] <= 8'h03;
			Memory [15] <= 8'h13;
			Memory [16] <= 8'hFF;
			Memory [17] <= 8'hB5;
			Memory [18] <= 8'h05;
			Memory [19] <= 8'h13;
			Memory [20] <= 8'h00;
			Memory [21] <= 8'h61;
			Memory [22] <= 8'h66;
			Memory [23] <= 8'h33;
			Memory [24] <= 8'h00;
			Memory [25] <= 8'h66;
			Memory [26] <= 8'h45;
			Memory [27] <= 8'hB3;
			Memory [28] <= 8'h00;
			Memory [29] <= 8'h66;
			Memory [30] <= 8'h76;
			Memory [31] <= 8'hB3;
			Memory [32] <= 8'h00;
			Memory [33] <= 8'h16;
			Memory [34] <= 8'hC6;
			Memory [35] <= 8'hB3;
			Memory [36] <= 8'h00;
			Memory [37] <= 8'h16;
			Memory [38] <= 8'hF7;
			Memory [39] <= 8'h33;
			Memory [40] <= 8'h00;
			Memory [41] <= 8'h00;
			Memory [42] <= 8'h21;
			Memory [43] <= 8'h03;
			Memory [44] <= 8'h00;
			Memory [45] <= 8'h51;
			Memory [46] <= 8'h72;
			Memory [47] <= 8'h33;
			Memory [48] <= 8'h00;
			Memory [49] <= 8'h61;
			Memory [50] <= 8'h64;
			Memory [51] <= 8'h33;
			Memory [52] <= 8'h00;
			Memory [53] <= 8'h22;
			Memory [54] <= 8'h04;
			Memory [55] <= 8'hB3;
			Memory [56] <= 8'h01;
			Memory [57] <= 8'h00;
			Memory [58] <= 8'h02;
			Memory [59] <= 8'hEF;
			Memory [60] <= 8'h00;
			Memory [61] <= 8'h22;
			Memory [62] <= 8'h07;
			Memory [63] <= 8'h33;
			Memory [64] <= 8'h40;
			Memory [65] <= 8'h73;
			Memory [66] <= 8'h07;
			Memory [67] <= 8'hB3;
			Memory [68] <= 8'h00;
			Memory [69] <= 8'h61;
			Memory [70] <= 8'h66;
			Memory [71] <= 8'h33;
			Memory [72] <= 8'h00;
			Memory [73] <= 8'h61;
			Memory [74] <= 8'h76;
			Memory [75] <= 8'hB3;
			Memory [76] <= 8'h40;
			Memory [77] <= 8'h23;
			Memory [78] <= 8'h00;
			Memory [79] <= 8'hB3;
			Memory [80] <= 8'h00;
			Memory [81] <= 8'hA0;
			Memory [82] <= 8'hE8;
			Memory [83] <= 8'h63;
			Memory [84] <= 8'h00;
			Memory [85] <= 8'h51;
			Memory [86] <= 8'h76;
			Memory [87] <= 8'h33;
			Memory [88] <= 8'h00;
			Memory [89] <= 8'h61;
			Memory [90] <= 8'h66;
			Memory [91] <= 8'hB3;
			Memory [92] <= 8'h00;
			Memory [93] <= 8'h22;
			Memory [94] <= 8'h07;
			Memory [95] <= 8'h33;
			Memory [96] <= 8'h00;
			Memory [97] <= 8'h61;
			Memory [98] <= 8'h76;
			Memory [99] <= 8'hB3;
			Memory [100] <= 8'h00;
			Memory [101] <= 8'h40;
			Memory [102] <= 8'h25;
			Memory [103] <= 8'h03;
			Memory [104] <= 8'h00;
			Memory [105] <= 8'hA0;
			Memory [106] <= 8'h08;
			Memory [107] <= 8'h63;
			Memory [108] <= 8'h00;
			Memory [109] <= 8'h51;
			Memory [110] <= 8'h76;
			Memory [111] <= 8'h33;
			Memory [112] <= 8'h00;
			Memory [113] <= 8'h61;
			Memory [114] <= 8'h66;
			Memory [115] <= 8'hB3;
			Memory [116] <= 8'h00;
			Memory [117] <= 8'h22;
			Memory [118] <= 8'h07;
			Memory [119] <= 8'h33;
			Memory [120] <= 8'h40;
			Memory [121] <= 8'h73;
			Memory [122] <= 8'h07;
			Memory [123] <= 8'hB3;
			Memory [124] <= 8'h00;
			Memory [125] <= 8'h66;
			Memory [126] <= 8'h76;
			Memory [127] <= 8'hB3;
			Memory [128] <= 8'h00;
			Memory [129] <= 8'h00;
			Memory [130] <= 8'h20;
			Memory [131] <= 8'h83;
			Memory [132] <= 8'h00;
			Memory [133] <= 8'h10;
			Memory [134] <= 8'h22;
			Memory [135] <= 8'h23; */

			
        end else
                    Data_out <= {Memory[Address],Memory[Address +32'd1],Memory[Address+32'd2],Memory[Address+32'd3]};
    end
    
endmodule


