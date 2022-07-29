`timescale 1ns / 1ps

module Branch_Control(
input [31:0] inst,
input BEQ,
input BNE,
input BLT,
input BGE,
input BLTU,
input BGEU,
input [3:0] select_mode,
output reg IDControlBranch,
output reg IDControlBranch_forward,
output reg [1:0] Branch_Control_output);

//wire BEQ,BNE,BLT,BGE,BLTU,BGEU;

//assign BEQ = Z; 
//assign BNE = ~Z; 

//assign BLT = ( N ^ V); 
//assign BGE = (~N && ~V) ||(N && V) ; 

//assign BLTU = LessU;
//assign BGEU = ~LessU;

always@(*) begin
case (select_mode)
4'b0000: Branch_Control_output <= 2'b00;
4'b0001: Branch_Control_output <= 2'b01;
4'b0010: Branch_Control_output <= 2'b10;
4'b0011: Branch_Control_output <= {1'b0,BLT};
4'b0100: Branch_Control_output <= {1'b0,BGE};
4'b0101: Branch_Control_output <= {1'b0,BEQ};
4'b0110: Branch_Control_output <= {1'b0,BNE};
4'b0111: Branch_Control_output <= {1'b0,BLTU};
4'b1000: Branch_Control_output <= {1'b0,BGEU};
4'b1001: Branch_Control_output <= 2'b00;
4'b1010: Branch_Control_output <= 2'b00;
4'b1011: Branch_Control_output <= 2'b00;
4'b1100: Branch_Control_output <= 2'b00;
4'b1101: Branch_Control_output <= 2'b00;
4'b1110: Branch_Control_output <= 2'b00;
4'b1111: Branch_Control_output <= 2'b00;
default: Branch_Control_output <= 2'b00;
endcase

    case(inst[6:0]) 
         7'b1100011: begin
            case(inst[14:12])
                3'b000: begin // BEQ
                    IDControlBranch_forward <= 1'b1;
                    if(BEQ==1'b1) IDControlBranch <= 1'b1;
                    else IDControlBranch <= 1'b0;
                end 3'b001: begin // BNE
                    IDControlBranch_forward <= 1'b1;
                    if(BNE==1'b1) IDControlBranch <= 1'b1; 
                    else IDControlBranch <= 1'b0; 
                end 3'b100: begin // BLT
                    IDControlBranch_forward <= 1'b1;
                    if(BLT==1'b1) IDControlBranch <= 1'b1; 
                    else IDControlBranch <= 1'b0;
                end 3'b101: begin // BGE
                    IDControlBranch_forward <= 1'b1;
                    if(BGE==1'b1) IDControlBranch <= 1'b1;  
                    else IDControlBranch <= 1'b0;  
                end 3'b110: begin // BLTU
                    IDControlBranch_forward <= 1'b1;
                    if(BLTU==1'b1) IDControlBranch <= 1'b1; 
                    else IDControlBranch <= 1'b0;
                end 3'b111: begin // BGEU
                    IDControlBranch_forward <= 1'b1;
                    if(BGEU==1'b1) IDControlBranch <= 1'b1; 
                    else IDControlBranch <= 1'b0;           
                end default: begin
                    IDControlBranch_forward <= 1'b0;
                    IDControlBranch <= 1'b0;     
                end endcase
    end default: begin
        IDControlBranch_forward <= 1'b0;
        IDControlBranch <= 1'b0;
    end endcase

end
//Mux16x1 mux16(2'b00, 2'b01, 2'b10, {1'b0,BLT}, {1'b0,BGE}, {1'b0,BEQ}, {1'b0,BNE}, {1'b0,BLTU}, //7
//{1'b0,BGEU}, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, select_mode,Branch_Control_output); 

//0-> count up
//01-> pc+imm>pc
//10 -> busA+imm>pc----jalr
endmodule
