`timescale 1ns / 1ps
module processor(
    input clk,
    input rst    
    );
    
    wire [31:0] pc_in, pc_out, adder1_out,adder2_out, instruction,inst_new,mem_inp_data;
    wire RegWrite;
    wire [31:0] ReadData2,ReadData1,WriteDataReg,compA,compB;
    wire [31:0] extend_out,alu_mux_out,alu_mux_outA,alu_mux_outB,ALU_result,Read_Data,DatatoMem,extend_shifted;
    wire ALUSrc, V, C, Z, N, Less_U, MemtoReg;
    wire ALUSrcDelayed, MemtoRegDelayed;
    wire [5:0] ALU_op;
    wire [5:0] ALU_opDelayed;
    wire [3:0] write_enable,MemRead_IDEX;
    wire [3:0] write_enableDelayed,write_enable_MEMWB,write_enable_IDEX;
    wire [1:0] WriteDataSelect;
    wire [1:0] PCSrc;
    wire [1:0] WriteDataSelectDelayed;
    wire [3:0] BranchControl;
    wire [3:0] BranchControlDelayed;
    wire [95:0] IFID_out;
    wire [68:0] MEMWB_out;
    wire [164:0] IDEX_out;
    wire [169:0] EXMEM_out;
    wire RegWriteDelayed,RegWrite_IDEX,RegWrite_EXMEM,RegWrite_MEMWB;
    wire [4:0] rs1_IDEX,rs2_IDEX,rd_IDEX,rd_EXMEM,rd_MEMWB,rs2_EXMEM;
    wire [1:0] forwardA,forwardB,forwardC,forwardD;
    wire PCWrite,IFIDWrite,cont_signal_rst,forward_mem;
    wire [20:0] control_signals;
    wire BEQ,BNE,BLT,BGE,BLTU,BGEU;
    wire IDControlBranch,IF_Flush,cont_signal_rst_IFID,IFIDWrite_IFID,IDControlBranch_forward;
    
    MUX4x1 mux_pc(.i0(adder1_out),.i1(adder2_out),.i2(EXMEM_out[137:106]),.i3(32'd0),.S(PCSrc),.G(pc_in));    //i1=EXMEM_out[100:69]
    
    PC_register pc_reg(
        .clk(clk),
        .rst(rst),
        .en(PCWrite),
        .Rin(pc_in),
        .Rout(pc_out)
        );
        
    Instruction_memory inst_mem( rst,pc_out, instruction);      
    
    MUX2x1 mux_inst_rst(.i0(instruction),.i1(32'd0),.S(control_signals[1]),.G(inst_new));  
     
    adder adder1 (
          .x(pc_out),
          .y(32'd4),
          .ci(1'b0),
          .s(adder1_out)
          );    
    
    IF_ID_pipeline IFID(
          .clk(clk),
          .rst((rst|IF_Flush)),
          .Load(1'b1),//IFIDWrite
          .Din({adder1_out,pc_out,inst_new}),
          .Dout(IFID_out)
              );
    
    hazard_detection_unit hazard_det(
          .Rs1_IFID(inst_new[19:15]),//IFID_out[19:15]
          .Rs2_IFID(inst_new[24:20]),//IFID_out[24:20]
          .Rd_IDEX(IFID_out[11:7]),//rd_IDEX
          .MemRead_IDEX((write_enable[3]|write_enable[2])), //(MemRead_IDEX[3]|MemRead_IDEX[2]) 
          .IDControlBranch(control_signals[19]),
          .PCWrite(PCWrite),
          .IFIDWrite(IFIDWrite),
          .cont_mux_sel(cont_signal_rst),
          .IF_Flush(IF_Flush));
    
    Register_File RF(
          .clk(clk),
          .rst(rst),
          .A_address(IFID_out[19:15]),
          .B_address(IFID_out[24:20]),
          .Write(RegWriteDelayed),
          .D_data(DatatoMem),
          .D_address(MEMWB_out[68:64]),
          .A_data(ReadData1),
          .B_data(ReadData2)
              );
     
    extend_block extend(
          .inst(IFID_out[31:0]),
          .data_out(extend_out));
    
    //assign extend_shifted = extend_out << 1;
          
    adder adder2 (
          .x(IFID_out[63:32]), //IDEX_out[127:96]
          .y(extend_out), //IDEX_out[31:0]
          .ci(1'b0),
          .s(adder2_out));

     Branch_Control Branch_Cont(
          .inst(IFID_out[31:0]),
          .BEQ(BEQ),
          .BNE(BNE),
          .BLT(BLT),
          .BGE(BGE),
          .BLTU(BLTU),
          .BGEU(BGEU),
          .select_mode(BranchControl),
          .IDControlBranch(IDControlBranch),
          .IDControlBranch_forward(IDControlBranch_forward),
          .Branch_Control_output(PCSrc));

    MUX4x1 mux_compA(.i0(ReadData1),.i1(ALU_result),.i2(Read_Data),.i3(32'd0),.S(forwardC),.G(compA)); //ALU_RESULT
    MUX4x1 mux_compB(.i0(ReadData2),.i1(ALU_result),.i2(Read_Data),.i3(32'd0),.S(forwardD),.G(compB));
    
    comparator comparator_(compA,compB,BEQ,BNE,BLT,BGE,BLTU,BGEU);    
    
    ID_EX_pipeline IDEX(
            .clk(clk),
            .rst(rst),
            .Load(1'b1),
            .Din({IFID_out[95:64],IFID_out[11:7],IFID_out[63:32],ReadData1,ReadData2,extend_out}),
            .Dout(IDEX_out));
  
    ForwardingUnit forward_unit(
            .rs1_IDEX(rs1_IDEX),
            .rs2_IDEX(rs2_IDEX),
            .rs1_IFID(IFID_out[19:15]),
            .rs2_IFID(IFID_out[24:20]),
            .rs1_inst(inst_new[19:15]),
            .rs2_inst(inst_new[24:20]),
            .Rd_IDEX(rd_IDEX),
            .Rd_EXMEM(rd_EXMEM),
            .Rd_MEMWB(rd_MEMWB),
            .Regwrite_EXMEM(RegWrite_EXMEM),
            .Regwrite_MEMWB(RegWrite_MEMWB),
            .IDControlBranch(control_signals[20]),
            .forwardA(forwardA),
            .forwardB(forwardB),
            .forwardC(forwardC),
            .forwardD(forwardD));
   
    MUX4x1 mux_alu_src_A(.i0(IDEX_out[95:64]),.i1(DatatoMem),.i2(EXMEM_out[137:106]),.i3(32'd0),.S(forwardA),.G(alu_mux_outA));   
//    MUX2x1 mux_alu_src_B(.i0(IDEX_out[63:32]),.i1(IDEX_out[31:0]),.S(ALUSrcDelayed),.G(alu_mux_out));   
//    MUX4x1 mux_alu_src_B2(.i0(alu_mux_out),.i1(DatatoMem),.i2(EXMEM_out[137:106]),.i3(32'd0),.S(forwardB),.G(alu_mux_outB));   

    MUX2x1 mux_alu_src_B(.i0(alu_mux_out),.i1(IDEX_out[31:0]),.S(ALUSrcDelayed),.G(alu_mux_outB));   
    MUX4x1 mux_alu_src_B2(.i0(IDEX_out[63:32]),.i1(DatatoMem),.i2(EXMEM_out[137:106]),.i3(32'd0),.S(forwardB),.G(alu_mux_out));
    
    Function_Unit FU(
        .A(alu_mux_outA),
        .B(alu_mux_outB),
        .FS(ALU_opDelayed),
        .F(ALU_result),
        .V(V),
        .C(C),
        .N(N),
        .Z(Z),
        .Less_U(Less_U)   
        );
    //adder2 out geciktir
     MUX4x1 mux_WriteDataSelect(.i0(ALU_result),.i1(IDEX_out[164:133]),.i2(adder2_out),.i3(32'd0),.S(WriteDataSelectDelayed),.G(WriteDataReg)); 
               
     EX_MEM_pipeline EXMEM(
          .clk(clk),
          .rst(rst),
          .Load(1'b1),
          .Din({mem_inp_data,ALU_result,IDEX_out[132:128],adder2_out,V,C,N,Z,Less_U,WriteDataReg,IDEX_out[63:32]}),
          .Dout(EXMEM_out));          
     
     forward_mem forward_memory(
          .rd_MEMWB(rd_MEMWB),
          .rs2_EXMEM(rs2_EXMEM),
          .store_flag_EXMEM(((write_enable_IDEX[0]|write_enable_IDEX[1]))&(~(write_enable_IDEX[2]|write_enable_IDEX[3]))),//delayed=exmem
          .load_flag_MEMWB(write_enable_MEMWB[2]|write_enable_MEMWB[3]),
          .forward_mem(forward_mem));
     
     MUX2x1 mux_mem(.i0(EXMEM_out[31:0]),.i1(MEMWB_out[63:32]),.S(forward_mem),.G(mem_inp_data)); 
               
     DataMem data_memory(clk, rst, EXMEM_out[169:138] , EXMEM_out[63:32] , write_enableDelayed, Read_Data); 
     
     MEM_WB_pipeline MEMWB(
          .clk(clk),
          .rst(rst),
          .Load(1'b1),
          .Din({EXMEM_out[105:101] ,Read_Data,EXMEM_out[63:32]}),
          .Dout(MEMWB_out));  
     
     MUX2x1 mux_mem_to_reg(.i0(MEMWB_out[31:0]),.i1(MEMWB_out[63:32]),.S(MemtoRegDelayed),.G(DatatoMem));   //WriteDataReg
     

 //kontrol sinyalleri ayrı ayrı geçiktirilmiştir     
    Control_Unit CU(
      .inst(IFID_out[31:0]),
      .Load_Reg(RegWrite),
      .Pc_to_RF(WriteDataSelect),
      .MB(ALUSrc),
      .FS(ALU_op),
      .MD(MemtoReg),
      .DataMem_Mode(write_enable),
      .Branch_Control(BranchControl));
      
       MUX2x1 #(.WIDTH(21)) mux_pc_rst (.i0({IDControlBranch_forward,IDControlBranch,BranchControl,write_enable,MemtoReg,ALU_op,ALUSrc,WriteDataSelect,RegWrite}),.i1(19'd0),.S(cont_signal_rst_IFID),.G(control_signals));   //WriteDataReg
     
     //kontrol sinyallerini delayleme 
      register_3 #(.SIZE(1)) reg_reg_write(clk,(rst), control_signals[0], RegWriteDelayed ); 
      register_1 #(.SIZE(2)) reg_write_data_sel(clk,(rst), control_signals[2:1], WriteDataSelectDelayed ); 
      register_1 #(.SIZE(1)) reg_alusrc(clk, (rst),control_signals[3], ALUSrcDelayed ); 
      register_1 #(.SIZE(6)) reg_aluop(clk, (rst),control_signals[9:4], ALU_opDelayed ); 
      register_3 #(.SIZE(1)) reg_MemtoReg(clk,(rst), control_signals[10], MemtoRegDelayed ); 
      register_2 #(.SIZE(4)) reg_write_enable(clk,(rst), control_signals[14:11], write_enableDelayed ); 
      register_1 #(.SIZE(4)) reg_write_enableIDEX(clk,(rst), control_signals[14:11], write_enable_IDEX ); 
      register_1 #(.SIZE(4)) reg_write_enable_memwb(clk,(rst), write_enableDelayed, write_enable_MEMWB ); 
//      register_2 #(.SIZE(4)) reg_BranchControl(clk, (rst),control_signals[18:15], BranchControlDelayed );     
     
//     //hazard detection unit için control sonuna sıfırlama muxu koymak yerine o sinyali registerların resetine orladım 
//    register_3 #(.SIZE(1)) reg_reg_write(clk,(rst), RegWrite, RegWriteDelayed ); 
//    register_1 #(.SIZE(2)) reg_write_data_sel(clk,(rst), WriteDataSelect, WriteDataSelectDelayed ); 
//    register_1 #(.SIZE(1)) reg_alusrc(clk, (rst),ALUSrc, ALUSrcDelayed ); 
//    register_1 #(.SIZE(6)) reg_aluop(clk, (rst),ALU_op, ALU_opDelayed ); 
//    register_3 #(.SIZE(1)) reg_MemtoReg(clk,(rst), MemtoReg, MemtoRegDelayed ); 
//    register_2 #(.SIZE(4)) reg_write_enable(clk,(rst), write_enable, write_enableDelayed ); 
//    register_2 #(.SIZE(4)) reg_BranchControl(clk, (rst),BranchControl, BranchControlDelayed ); 
      
    //forward unit için geçiktirilmeler
    register_1 #(.SIZE(5)) reg_rs1(clk,rst, IFID_out[19:15], rs1_IDEX );               
    register_1 #(.SIZE(5)) reg_rs2(clk,rst, IFID_out[24:20], rs2_IDEX );               
    register_1 #(.SIZE(5)) reg_rs2EXMEM(clk,rst, rs2_IDEX, rs2_EXMEM );               
    register_1 #(.SIZE(5)) reg_rd_idex(clk,rst, IFID_out[11:7], rd_IDEX );               
    register_1 #(.SIZE(5)) reg_rd_exmem(clk,rst, rd_IDEX, rd_EXMEM );               
    register_1 #(.SIZE(5)) reg_rd_memwb(clk,rst, rd_EXMEM, rd_MEMWB );               
    register_1 #(.SIZE(1)) reg_reg_write2(clk,rst, RegWrite, RegWrite_IDEX );               
    register_1 #(.SIZE(1)) reg_reg_write3(clk,rst, RegWrite_IDEX, RegWrite_EXMEM );               
    register_1 #(.SIZE(1)) reg_reg_write4(clk,rst, RegWrite_EXMEM, RegWrite_MEMWB );               
    register_1 #(.SIZE(4)) reg_write_enable_IDEX(clk,rst, write_enable, MemRead_IDEX );     
    register_1 #(.SIZE(1)) reg_cont_rst(clk,rst, cont_signal_rst, cont_signal_rst_IFID );                
    register_1 #(.SIZE(1)) reg_IFIDWrite(clk,rst, IFIDWrite, IFIDWrite_IFID );                
endmodule

