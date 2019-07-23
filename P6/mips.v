`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:04:51 12/13/2017 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "IF.v"
`include "IF_ID.v"
`include "ID.v"
`include "ID_EX.v"
`include "EX.v"
`include "EX_MEM.v"
`include "MEM.v"
`include "MEM_WB.v"
`include "WB.v"
`include "WB_ID.v"
`include "Conflict.v"

`include "RegFile.v"
`include "ID_MUX.v"
`include "EXT.v"
`include "CMP.v"
`include "controller_D.v"
`include "Equ.v"
`include "NPC_D.v"

`include "ALU.v"
`include "EX_MUX.v"
`include "controller_E.v"
`include "MUL_DIV.v"

`include "controller_M.v"
`include "DataMem.v"
`include "MEM_MUX.v"

`include "controller_W.v"
`include "DataExtend.v"

 module mips(
	 input clk,
	 input reset
    );
	 wire stall,Flush_E,RegWrite_E,RegWrite_M,RegWrite_W,RegWrite_WD,Write_M,Write_W;
	 wire [1:0] ForwardRTM,PCSrc_D,Mem2Reg_E,Mem2Reg_M,Mem2Reg_W,Mem2Reg_WD,nPC_Sel_D;
	 wire [2:0] ForwardRSD,ForwardRTD,ForwardRSE,ForwardRTE;
	 wire [4:0] WRegAdd_D,WRegAdd_E,WRegAdd_M,WRegAdd_W,WRegAdd_WD,Rs_D,Rt_D,Rd_D,Rs_E,Rt_E,Rd_E;
	 wire [31:0] instr_F,instr_D,instr_E,instr_M,instr_W,instr_WD;
	 wire [31:0] PC_F,PC_D,PC_E,PC_W,PC_WD,PC_M,PC4_F,PC4_D,PC8_F,PC8_D,PC8_E,PC8_M,PC8_W,PC8_WD,NPC;
	 wire [31:0] result_W,result_WD,ALUout_M,ALUout_E,ALUout_W,RD1_D,RD2_D,RD1_E,RD2_E;
	 wire [31:0] EXTout_D,EXTout_E,WriteData_E,WriteData_M,MDout_E,MDout_M,MDout_W;
	 wire [31:0] ReadData_M,ReadData_W,NPC_B,NPC_J,NPC_JR,test,DisA_M,DisWD_M,DisA_W,DisWD_W;
	 
	 IF IF(clk,reset,stall,PCSrc_D,NPC_B,NPC_J,NPC_JR,instr_F,PC_F,PC4_F,PC8_F); //
	 IF_ID IF_ID(clk,reset,stall,instr_F,PC_F,PC4_F,PC8_F,instr_D,PC_D,PC4_D,PC8_D); //
	 ID ID(clk,reset,RegWrite_WD,ForwardRSD,ForwardRTD,WRegAdd_WD,instr_D,PC_D,PC_WD,PC4_D,PC8_E,PC8_M,ALUout_M,MDout_M,ReadData_W,result_W,result_WD,RD1_E,nPC_Sel_D,PCSrc_D,RD1_D,RD2_D,NPC_B,NPC_J,NPC_JR,EXTout_D); //
	 ID_EX ID_EX(clk,reset,EXTout_D,RD1_D,RD2_D,instr_D,PC_D,PC8_D,Flush_E,Rs_E,Rt_E,Rd_E,instr_E,PC_E,PC8_E,RD1_E,RD2_E,EXTout_E);  //
	 EX EX(clk,reset,ForwardRSE,ForwardRTE,Rt_E,Rd_E,instr_E,RD1_E,RD2_E,EXTout_E,result_W,result_WD,ALUout_M,MDout_M,start,Busy,RegWrite_E,Mem2Reg_E,WRegAdd_E,MDout_E,ALUout_E,WriteData_E); //
	 EX_MEM EX_MEM(clk,reset,MDout_E,instr_E,ALUout_E,WriteData_E,PC_E,PC8_E,WRegAdd_E,MDout_M,instr_M,ALUout_M,WriteData_M,PC_M,PC8_M,WRegAdd_M); //
	 MEM MEM(clk,reset,ForwardRTM,result_W,result_WD,instr_M,ALUout_M,WriteData_M,PC_M,PC8_M,RegWrite_M,Write_M,Mem2Reg_M,DisA_M,DisWD_M,ReadData_M); //
	 MEM_WB MEM_WB(clk,reset,Write_M,DisA_M,DisWD_M,MDout_M,instr_M,ReadData_M,ALUout_M,PC_M,PC8_M,WRegAdd_M,Write_W,DisA_W,DisWD_W,MDout_W,instr_W,ReadData_W,ALUout_W,PC_W,PC8_W,WRegAdd_W); //
	 WB WB(MDout_W,instr_W,ReadData_W,ALUout_W,PC8_W,RegWrite_W,Mem2Reg_W,result_W); //
	 WB_ID WB_ID(clk,reset,RegWrite_W,Write_W,Mem2Reg_W,WRegAdd_W,DisA_W,DisWD_W,instr_W,result_W,PC_W,PC8_WD,RegWrite_WD,Mem2Reg_WD,WRegAdd_WD,instr_WD,result_WD,PC_WD,PC8_WD); //
	 Conflict Conflict(clk,Busy,start,RegWrite_E,RegWrite_M,RegWrite_W,RegWrite_WD,nPC_Sel_D,Mem2Reg_E,Mem2Reg_M,Mem2Reg_W,Mem2Reg_WD,WRegAdd_E,WRegAdd_M,WRegAdd_W,WRegAdd_WD,instr_F,instr_D,instr_E,instr_M,instr_W,instr_WD,ForwardRSD,ForwardRTD,ForwardRSE,ForwardRTE,ForwardRTM,stall,Flush_E);
	
endmodule
