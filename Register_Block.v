`timescale 1ns / 1ps

module Register_File(
    input clk,
    input rst,
    input[4:0] A_address,
    input[4:0] B_address,
    input Write,
    input[31:0] D_data,
    input[4:0] D_address,
    output[31:0] A_data,
    output[31:0] B_data
    );
    
    wire[31:0] Load, Dec_out;
    wire[31:0] Reg_Out0, Reg_Out1, Reg_Out2, Reg_Out3, Reg_Out4, Reg_Out5, Reg_Out6, Reg_Out7, Reg_Out8, Reg_Out9, Reg_Out10,
    Reg_Out11, Reg_Out12, Reg_Out13, Reg_Out14, Reg_Out15, Reg_Out16, Reg_Out17, Reg_Out18, Reg_Out19, Reg_Out20, Reg_Out21,
    Reg_Out22, Reg_Out23, Reg_Out24, Reg_Out25, Reg_Out26, Reg_Out27, Reg_Out28, Reg_Out29, Reg_Out30, Reg_Out31;
    
    Decoder32 DEC(D_address, Dec_out);
    
    assign Load[0] = Write & Dec_out[0];
    assign Load[1] = Write & Dec_out[1];
    assign Load[2] = Write & Dec_out[2];
    assign Load[3] = Write & Dec_out[3];
    assign Load[4] = Write & Dec_out[4];
    assign Load[5] = Write & Dec_out[5];
    assign Load[6] = Write & Dec_out[6];
    assign Load[7] = Write & Dec_out[7];
    assign Load[8] = Write & Dec_out[8];
    assign Load[9] = Write & Dec_out[9];
    assign Load[10] = Write & Dec_out[10];
    assign Load[11] = Write & Dec_out[11];
    assign Load[12] = Write & Dec_out[12];
    assign Load[13] = Write & Dec_out[13];
    assign Load[14] = Write & Dec_out[14];
    assign Load[15] = Write & Dec_out[15];
    assign Load[16] = Write & Dec_out[16];
    assign Load[17] = Write & Dec_out[17];
    assign Load[18] = Write & Dec_out[18];
    assign Load[19] = Write & Dec_out[19];
    assign Load[20] = Write & Dec_out[20];
    assign Load[21] = Write & Dec_out[21];
    assign Load[22] = Write & Dec_out[22];
    assign Load[23] = Write & Dec_out[23];
    assign Load[24] = Write & Dec_out[24];
    assign Load[25] = Write & Dec_out[25];
    assign Load[26] = Write & Dec_out[26];
    assign Load[27] = Write & Dec_out[27];
    assign Load[28] = Write & Dec_out[28];
    assign Load[29] = Write & Dec_out[29];
    assign Load[30] = Write & Dec_out[30];
    assign Load[31] = Write & Dec_out[31];
    
    assign Reg_Out0 = 32'h00000000;
    Register regx1(clk,rst, D_data, Load[1], Reg_Out1);
    Register regx2(clk,rst, D_data, Load[2], Reg_Out2);
    Register regx3(clk,rst, D_data, Load[3], Reg_Out3);
    Register regx4(clk,rst, D_data, Load[4], Reg_Out4);
    Register regx5(clk,rst, D_data, Load[5], Reg_Out5);
    Register regx6(clk,rst, D_data, Load[6], Reg_Out6);
    Register regx7(clk,rst, D_data, Load[7], Reg_Out7);
    Register regx8(clk,rst, D_data, Load[8], Reg_Out8);
    Register regx9(clk,rst, D_data, Load[9], Reg_Out9);
    Register regx10(clk,rst, D_data, Load[10], Reg_Out10);
    Register regx11(clk,rst, D_data, Load[11], Reg_Out11);
    Register regx12(clk,rst, D_data, Load[12], Reg_Out12);
    Register regx13(clk,rst, D_data, Load[13], Reg_Out13);
    Register regx14(clk,rst, D_data, Load[14], Reg_Out14);
    Register regx15(clk,rst, D_data, Load[15], Reg_Out15);
    Register regx16(clk,rst, D_data, Load[16], Reg_Out16);
    Register regx17(clk,rst, D_data, Load[17], Reg_Out17);
    Register regx18(clk,rst, D_data, Load[18], Reg_Out18);
    Register regx19(clk,rst, D_data, Load[19], Reg_Out19);
    Register regx20(clk,rst, D_data, Load[20], Reg_Out20);
    Register regx21(clk,rst, D_data, Load[21], Reg_Out21);
    Register regx22(clk,rst, D_data, Load[22], Reg_Out22);
    Register regx23(clk,rst, D_data, Load[23], Reg_Out23);
    Register regx24(clk,rst, D_data, Load[24], Reg_Out24);
    Register regx25(clk,rst, D_data, Load[25], Reg_Out25);
    Register regx26(clk,rst, D_data, Load[26], Reg_Out26);
    Register regx27(clk,rst, D_data, Load[27], Reg_Out27);
    Register regx28(clk,rst, D_data, Load[28], Reg_Out28);
    Register regx29(clk,rst, D_data, Load[29], Reg_Out29);
    Register regx30(clk,rst, D_data, Load[30], Reg_Out30);
    Register regx31(clk,rst, D_data, Load[31], Reg_Out31);
    
    MUX32x1 MUXA(Reg_Out0, Reg_Out1, Reg_Out2, Reg_Out3, Reg_Out4, Reg_Out5, Reg_Out6, Reg_Out7,
                 Reg_Out8, Reg_Out9, Reg_Out10, Reg_Out11, Reg_Out12, Reg_Out13, Reg_Out14, Reg_Out15,
                 Reg_Out16, Reg_Out17, Reg_Out18, Reg_Out19, Reg_Out20, Reg_Out21, Reg_Out22, Reg_Out23,
                 Reg_Out24, Reg_Out25, Reg_Out26, Reg_Out27, Reg_Out28, Reg_Out29, Reg_Out30, Reg_Out31,
                 A_address, A_data);
    
    MUX32x1 MUXB(Reg_Out0, Reg_Out1, Reg_Out2, Reg_Out3, Reg_Out4, Reg_Out5, Reg_Out6, Reg_Out7,
                 Reg_Out8, Reg_Out9, Reg_Out10, Reg_Out11, Reg_Out12, Reg_Out13, Reg_Out14, Reg_Out15,
                 Reg_Out16, Reg_Out17, Reg_Out18, Reg_Out19, Reg_Out20, Reg_Out21, Reg_Out22, Reg_Out23,
                 Reg_Out24, Reg_Out25, Reg_Out26, Reg_Out27, Reg_Out28, Reg_Out29, Reg_Out30, Reg_Out31,
                 B_address, B_data); 
endmodule

