`timescale 1ns / 1ps


module Decoder32(
    input [4:0] RegAdd,
    output [31:0] DecOut
    );
    
    assign DecOut[0]=  (~RegAdd[4]) & (~RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[1]=  (~RegAdd[4]) &  (~RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (RegAdd[0]);
    assign DecOut[2]=  (~RegAdd[4]) &  (~RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[3]=  (~RegAdd[4]) &  (~RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);
    assign DecOut[4]=  (~RegAdd[4]) &  (~RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[5]=  (~RegAdd[4]) &  (~RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1])  & (RegAdd[0]);
    assign DecOut[6]=  (~RegAdd[4]) &  (~RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (~RegAdd[0]);
    assign DecOut[7]=  (~RegAdd[4]) &  (~RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);
    assign DecOut[8]=  (~RegAdd[4]) &  (RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[9]=  (~RegAdd[4]) &  (RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (RegAdd[0]);
    assign DecOut[10]= (~RegAdd[4]) & (RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[11]= (~RegAdd[4]) & (RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);
    assign DecOut[12]= (~RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[13]= (~RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1])  & (RegAdd[0]);
    assign DecOut[14]= (~RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (~RegAdd[0]);
    assign DecOut[15]= (~RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);
    
    assign DecOut[16]= (RegAdd[4]) & (~RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[17]= (RegAdd[4]) & (~RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (RegAdd[0]);
    assign DecOut[18]= (RegAdd[4]) & (~RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[19]= (RegAdd[4]) & (~RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);
    assign DecOut[20]= (RegAdd[4]) & (~RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[21]= (RegAdd[4]) & (~RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1])  & (RegAdd[0]);
    assign DecOut[22]= (RegAdd[4]) & (~RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (~RegAdd[0]);
    assign DecOut[23]= (RegAdd[4]) & (~RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);
    assign DecOut[24]= (RegAdd[4]) & (RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[25]= (RegAdd[4]) & (RegAdd[3]) & (~RegAdd[2]) & (~RegAdd[1]) & (RegAdd[0]);
    assign DecOut[26]= (RegAdd[4]) & (RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[27]= (RegAdd[4]) & (RegAdd[3]) & (~RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);
    assign DecOut[28]= (RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1]) & (~RegAdd[0]);
    assign DecOut[29]= (RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (~RegAdd[1])  & (RegAdd[0]);
    assign DecOut[30]= (RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (~RegAdd[0]);
    assign DecOut[31]= (RegAdd[4]) & (RegAdd[3]) & (RegAdd[2]) & (RegAdd[1])  & (RegAdd[0]);  
endmodule

