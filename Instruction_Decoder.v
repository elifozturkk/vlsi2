`timescale 1ns / 1ps

module Control_Unit(
input [31:0] inst,
output reg Load_Reg,
output reg [1:0] Pc_to_RF,
output reg MB,
output reg [5:0] FS,
output reg MD,
output reg [3:0] DataMem_Mode,
output reg [3:0] Branch_Control);

always @(*) 
begin
    case(inst[6:0]) 
        7'b0000000: begin //nop
            Load_Reg <= 1'b0;
            Pc_to_RF <= 2'b00;
            MB <= 1'b0;
            FS <= 6'b000000;
            MD <= 1'b0;
            DataMem_Mode <= 4'b0000;
            Branch_Control <= 4'b0000;
           
        end 7'b0110111: begin //LUI
            Load_Reg <= 1'b1;
            Pc_to_RF <= 2'b00;
            MB <= 1'b1;
            FS <= 6'b000000;
            MD <= 1'b0;
            DataMem_Mode <= 4'b0000;
            Branch_Control <= 4'b0000;
       
        end 7'b0010111:begin // AUIPC
            Load_Reg <= 1'b1;
            Pc_to_RF <= 2'b10;
            MB <= 1'b0;
            FS <= 6'b000000;
            MD <= 1'b0;
            DataMem_Mode <= 4'b0000;
            Branch_Control <= 4'b0001;
           
        end 7'b1101111: begin // JAL
            Load_Reg <= 1'b1;
            Pc_to_RF <= 2'b01;
            MB <= 1'b0;
            FS <= 6'b000000;
            MD <= 1'b0;
            DataMem_Mode <= 4'b0000;
            Branch_Control <= 4'b0001;
             
        end 7'b1100111: begin //JALR
            Load_Reg <= 1'b1;
            Pc_to_RF <= 2'b01;
            MB <= 1'b0;
            FS <= 6'b000000;
            MD <= 1'b0;
            DataMem_Mode <= 4'b0000;
            Branch_Control <= 4'b0010;
             
        end 7'b1100011: begin
            case(inst[14:12])
                3'b000: begin // BEQ
                    Load_Reg <= 1'b0;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b0;
                    FS <= 6'b000000;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd5;
                    
            end 3'b001: begin // BNE
                    Load_Reg <= 1'b0;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b0;
                    FS <= 6'b000000;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd6;
                  
            end 3'b100: begin // BLT
                    Load_Reg <= 1'b0;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b0;
                    FS <= 6'b000000;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd3;
                  
            end 3'b101: begin // BGE
                        Load_Reg <= 1'b0;
                        Pc_to_RF <= 2'b00;
                        MB <= 1'b0;
                        FS <= 6'b000000;
                        MD <= 1'b0;
                        DataMem_Mode <= 4'b0000;
                        Branch_Control <= 4'd4;      
                                             
            end 3'b110: begin // BLTU
                            Load_Reg <= 1'b0;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b0;
                            FS <= 6'b000000;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd7; 
                         
            end 3'b111: begin // BGEU
                            Load_Reg <= 1'b0;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b0;
                            FS <= 6'b000000;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd8;
                                                         
           end  endcase
        end
        7'b0000011:begin
            case(inst[14:12])
                3'b000:begin // LB
                    Load_Reg <= 1'b1;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b000010;
                    MD <= 1'b1;
                    DataMem_Mode <= 4'b0110;
                    Branch_Control <= 4'd0;
                     
                 end 3'b001:begin // LH
                   Load_Reg <= 1'b1;
                   Pc_to_RF <= 2'b00;
                   MB <= 1'b1;
                   FS <= 6'b000010;
                   MD <= 1'b1;
                   DataMem_Mode <= 4'b0101;
                   Branch_Control <= 4'd0;
                     
                end 3'b010:begin // LW
                     Load_Reg <= 1'b1;
                     Pc_to_RF <= 2'b00;
                     MB <= 1'b1;
                     FS <= 6'b000010;
                     MD <= 1'b1;
                     DataMem_Mode <= 4'b0100;
                     Branch_Control <= 4'd0;
                      
                 end 3'b100:begin // LBU
                 Load_Reg <= 1'b1;
                 Pc_to_RF <= 2'b00;
                 MB <= 1'b1;
                 FS <= 6'b000010;
                 MD <= 1'b1;
                 DataMem_Mode <= 4'b1000;
                 Branch_Control <= 4'd0;
                  
                 end 3'b101:begin // LHU
                 Load_Reg <= 1'b1;
                 Pc_to_RF <= 2'b00;
                 MB <= 1'b1;
                 FS <= 6'b000010;
                 MD <= 1'b1;
                 DataMem_Mode <= 4'b0111;
                 Branch_Control <= 4'd0;
                  
                 end
          endcase
        end
        7'b0100011: begin
            case(inst[14:12])
                3'b000:begin // SB
                    Load_Reg <= 1'b0;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b000010;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0011;
                    Branch_Control <= 4'd0;
                     
                end
                3'b001:begin // SH
                    Load_Reg <= 1'b0;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b000010;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0010;
                    Branch_Control <= 4'd0;
                     
                end       
                3'b010:begin // SW
                    Load_Reg <= 1'b0;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b000010;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0001;
                    Branch_Control <= 4'd0;
                     
                end        
            endcase
        end
        7'b0010011: begin
            case(inst[14:12])
                3'b000: begin // ADDI
                    Load_Reg <= 1'b1;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b000010;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd0;
                     
                end
                 3'b010: begin // SLTI
                    Load_Reg <= 1'b1;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b100101;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd0;
                     
                end
                  3'b011: begin // SLTIU
                       Load_Reg <= 1'b1;
                       Pc_to_RF <= 2'b00;
                       MB <= 1'b1;
                       FS <= 6'b110101;
                       MD <= 1'b0;
                       DataMem_Mode <= 4'b0000;
                       Branch_Control <= 4'd0;
                        
               end
                  3'b100: begin // XORI
                    Load_Reg <= 1'b1;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b001010;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd0;
                     
            end                                     
                  3'b110: begin // ORI
                  Load_Reg <= 1'b1;
                  Pc_to_RF <= 2'b00;
                  MB <= 1'b1;
                  FS <= 6'b001001;
                  MD <= 1'b0;
                  DataMem_Mode <= 4'b0000;
                  Branch_Control <= 4'd0;
                   
            end           
                  3'b111: begin // ANDI
                    Load_Reg <= 1'b1;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b001000;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd0;
                     
            end  
                3'b001: begin // SLLI
                    Load_Reg <= 1'b1;
                    Pc_to_RF <= 2'b00;
                    MB <= 1'b1;
                    FS <= 6'b010000;
                    MD <= 1'b0;
                    DataMem_Mode <= 4'b0000;
                    Branch_Control <= 4'd0;   
                                     
                end
                 3'b101: begin
                    case(inst[30])
                        1'b0:begin //SRLI
                            Load_Reg <= 1'b1;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b1;
                            FS <= 6'b010001;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd0;     
                                                    
                        end
                        1'b1:begin // SRAI
                             Load_Reg <= 1'b1;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b1;
                            FS <= 6'b010010;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd0; 
                                                      
                        end
                        endcase
                   end
                endcase
                end
                7'b0110011: begin
                    case(inst[14:12])
                        3'b000: begin
                            case(inst[30])
                                1'b0:begin //ADD
                                    Load_Reg <= 1'b1;
                                    Pc_to_RF <= 2'b00;
                                    MB <= 1'b0;
                                    FS <= 6'b000010;
                                    MD <= 1'b0;
                                    DataMem_Mode <= 4'b0000;
                                    Branch_Control <= 4'd0;
                                     
                                end
                                 1'b1:begin //SUB
                                    Load_Reg <= 1'b1;
                                    Pc_to_RF <= 2'b00;
                                    MB <= 1'b0;
                                    FS <= 6'b000101;
                                    MD <= 1'b0;
                                    DataMem_Mode <= 4'b0000;
                                    Branch_Control <= 4'd0;
                                     
                                end                           
                            endcase
                        end
                        3'b001:begin // SLL
                            Load_Reg <= 1'b1;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b0;
                            FS <= 6'b010000;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd0;  
                                               
                        end
                        3'b010:begin // SLT
                        
                            Load_Reg <= 1'b1;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b0;
                            FS <= 6'b100101;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd0;    
                                      
                        end                        
                        3'b011: begin // SLTU
                             Load_Reg <= 1'b1;
                             Pc_to_RF <= 2'b00;
                             MB <= 1'b0;
                             FS <= 6'b110101;
                             MD <= 1'b0;
                             DataMem_Mode <= 4'b0000;
                             Branch_Control <= 4'd0; 
                                                         
                        end
                        3'b100:begin //XOR
                            Load_Reg <= 1'b1;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b0;
                            FS <= 6'b001010;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd0;
                             
                        end
                        3'b101:begin
                            case(inst[30])
                                1'b0: begin // SRL
                                    Load_Reg <= 1'b1;
                                    Pc_to_RF <= 2'b00;
                                    MB <= 1'b0;
                                    FS <= 6'b010001;
                                    MD <= 1'b0;
                                    DataMem_Mode <= 4'b0000;
                                    Branch_Control <= 4'd0; 
                                             
                                end
                                1'b1: begin //SRA
                                   Load_Reg <= 1'b1;
                                   Pc_to_RF <= 2'b00;
                                   MB <= 1'b0;
                                   FS <= 6'b010010;
                                   MD <= 1'b0;
                                   DataMem_Mode <= 4'b0000;
                                   Branch_Control <= 4'd0;   
                                     
                                end
                            endcase
                        end
                        3'b110:begin //Or
                            Load_Reg <= 1'b1;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b0;
                            FS <= 6'b001001;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd0;
                             
                        end
                        3'b111: begin //AND
                            Load_Reg <= 1'b1;
                            Pc_to_RF <= 2'b00;
                            MB <= 1'b0;
                            FS <= 6'b001000;
                            MD <= 1'b0;
                            DataMem_Mode <= 4'b0000;
                            Branch_Control <= 4'd0;
                             
                        end
                    endcase
                end
    endcase
 end

// DATAPATH
// load_enable => Register File Load
// pc_in_select => JALDA PC nin degerini RF ye yaz
// MB => B YA DA CONSTANT IN
// FS => BISEYLER BISEYLER
// MD => DATA IN ( YANI DATA MEMORYDEN GELEN) YA DA FU ÇIKIŞI

// DATAMEM
// 4 bitlik giris DATAMEMDEN BAK KOLAY

// BRANCH CONTROL GIRISLERI
// 4 bitlik giris kolay bak

endmodule

