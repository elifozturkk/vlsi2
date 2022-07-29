`timescale 1ns / 1ps


module Shifter (
input [31:0]in,
input [4:0]sh,
input [1:0]shift_con,
output reg [31:0] out);

reg [32:0] in1;

always@*
    begin
        case(shift_con)
             2'b00:begin //left
                in1 <= 32'd0;
                 case(sh) 
                      5'd0: out = in;
                      5'd1: out = {in[30:0],in1[31]};
                      5'd2: out = {in[29:0],in1[31:30]};
                      5'd3: out = {in[28:0],in1[31:29]};
                      5'd4: out = {in[27:0],in1[31:28]};
                      5'd5: out = {in[26:0],in1[31:27]};
                      5'd6: out = {in[25:0],in1[31:26]};
                      5'd7: out = {in[24:0],in1[31:25]};
                      5'd8: out = {in[23:0],in1[31:24]};
                      5'd9: out = {in[22:0],in1[31:23]};
                      5'd10: out = {in[21:0],in1[31:22]};
                      5'd11: out = {in[20:0],in1[31:21]};
                      5'd12: out = {in[19:0],in1[31:20]};
                      5'd13: out = {in[18:0],in1[31:19]};
                      5'd14: out = {in[17:0],in1[31:18]};
                      5'd15: out = {in[16:0],in1[31:17]};
                      5'd16: out = {in[15:0],in1[31:16]};
                      5'd17: out = {in[14:0],in1[31:15]};
                      5'd18: out = {in[13:0],in1[31:14]};
                      5'd19: out = {in[12:0],in1[31:13]};
                      5'd20: out = {in[11:0],in1[31:12]};
                      5'd21: out = {in[10:0],in1[31:11]};
                      5'd22: out = {in[9:0],in1[31:10]};
                      5'd23: out = {in[8:0],in1[31:9]};
                      5'd24: out = {in[7:0],in1[31:8]};
                      5'd25: out = {in[6:0],in1[31:7]};
                      5'd26: out = {in[5:0],in1[31:6]};
                      5'd27: out = {in[4:0],in1[31:5]};
                      5'd28: out = {in[3:0],in1[31:4]};
                      5'd29: out = {in[2:0],in1[31:3]};
                      5'd30: out = {in[1:0],in1[31:2]};
                      5'd31: out = {in[0],in1[31:1]};
                      default: out = in;
                 endcase
             end 
             2'b01:begin //right
                in1 <= 32'd0;
                  case(sh)
                       5'd0: out = in;
                       5'd31: out = {in1[30:0],in[31]};
                       5'd30: out = {in1[29:0],in[31:30]};
                       5'd29: out = {in1[28:0],in[31:29]};
                       5'd28: out = {in1[27:0],in[31:28]};
                       5'd27: out = {in1[26:0],in[31:27]};
                       5'd26: out = {in1[25:0],in[31:26]};
                       5'd25: out = {in1[24:0],in[31:25]};
                       5'd24: out = {in1[23:0],in[31:24]};
                       5'd23: out = {in1[22:0],in[31:23]};
                       5'd22: out = {in1[21:0],in[31:22]};
                       5'd21: out = {in1[20:0],in[31:21]};
                       5'd20: out = {in1[19:0],in[31:20]};
                       5'd19: out = {in1[18:0],in[31:19]};
                       5'd18: out = {in1[17:0],in[31:18]};
                       5'd17: out = {in1[16:0],in[31:17]};
                       5'd16: out = {in1[15:0],in[31:16]};
                       5'd15: out = {in1[14:0],in[31:15]};
                       5'd14: out = {in1[13:0],in[31:14]};
                       5'd13: out = {in1[12:0],in[31:13]};
                       5'd12: out = {in1[11:0],in[31:12]};
                       5'd11: out = {in1[10:0],in[31:11]};
                       5'd10: out = {in1[9:0],in[31:10]};
                       5'd9: out = {in1[8:0],in[31:9]};
                       5'd8: out = {in1[7:0],in[31:8]};
                       5'd7: out = {in1[6:0],in[31:7]};
                       5'd6: out = {in1[5:0],in[31:6]};
                       5'd5: out = {in1[4:0],in[31:5]};
                       5'd4: out = {in1[3:0],in[31:4]};
                       5'd3: out = {in1[2:0],in[31:3]};
                       5'd2: out = {in1[1:0],in[31:2]};
                       5'd1: out = {in1[0],in[31:1]};
                       default: out = in;
                  endcase
              end 
             2'b10:begin //arithmetic right
                   if (in[31]==1'b1) in1 <= 32'hffffffff;
                   else    in1 <= 32'd0;
                   case(sh)
                       5'd0: out = in;
                       5'd31: out = {in1[30:0],in[31]};
                       5'd30: out = {in1[29:0],in[31:30]};
                       5'd29: out = {in1[28:0],in[31:29]};
                       5'd28: out = {in1[27:0],in[31:28]};
                       5'd27: out = {in1[26:0],in[31:27]};
                       5'd26: out = {in1[25:0],in[31:26]};
                       5'd25: out = {in1[24:0],in[31:25]};
                       5'd24: out = {in1[23:0],in[31:24]};
                       5'd23: out = {in1[22:0],in[31:23]};
                       5'd22: out = {in1[21:0],in[31:22]};
                       5'd21: out = {in1[20:0],in[31:21]};
                       5'd20: out = {in1[19:0],in[31:20]};
                       5'd19: out = {in1[18:0],in[31:19]};
                       5'd18: out = {in1[17:0],in[31:18]};
                       5'd17: out = {in1[16:0],in[31:17]};
                       5'd16: out = {in1[15:0],in[31:16]};
                       5'd15: out = {in1[14:0],in[31:15]};
                       5'd14: out = {in1[13:0],in[31:14]};
                       5'd13: out = {in1[12:0],in[31:13]};
                       5'd12: out = {in1[11:0],in[31:12]};
                       5'd11: out = {in1[10:0],in[31:11]};
                       5'd10: out = {in1[9:0],in[31:10]};
                       5'd9: out = {in1[8:0],in[31:9]};
                       5'd8: out = {in1[7:0],in[31:8]};
                       5'd7: out = {in1[6:0],in[31:7]};
                       5'd6: out = {in1[5:0],in[31:6]};
                       5'd5: out = {in1[4:0],in[31:5]};
                       5'd4: out = {in1[3:0],in[31:4]};
                       5'd3: out = {in1[2:0],in[31:3]};
                       5'd2: out = {in1[1:0],in[31:2]};
                       5'd1: out = {in1[0],in[31:1]};
                       default: out = in;
                   endcase
               end 
             default: out = in;
        endcase
    end
endmodule


