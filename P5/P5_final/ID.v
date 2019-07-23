`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:42:42 12/13/2017 
// Design Name: 
// Module Name:    ID 
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
`include "RegFile.v"
`include "ID_MUX.v"
`include "EXT.v"
`include "CMP.v"
`include "controller_D.v"
`include "Equ.v"
`include "NPC_D.v"

module ID(
    input clk,
    input reset,
	 input RegWrite_WD,
	 input [1:0] ForwardRSD,
	 input [1:0] ForwardRTD,
	 input [4:0] WRegAdd_D,
    input [31:0] instr_D,
	 input [31:0] PC_D,
	 input [31:0] PC_WD,
	 input [31:0] PC4_D,
	 input [31:0] PC8_WD,
	 input [31:0] ALUout_M,
	 input [31:0] ReadData_W,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] RD1_E,
	 
	 output [1:0] nPC_Sel_D,
	 output [1:0] PCSrc_D,
	 output [31:0] D1,
	 output [31:0] D2,
	 output [31:0] NPC_B,
	 output [31:0] NPC_J,
	 output [31:0] NPC_JR,
	 output [31:0] EXTout
    );
	 
	 wire zero;
	 wire [1:0] ExtOp;
	 wire [31:0] Data1,Data2,GPR_rs;
	 CMP CMP(D1,D2,zero);
	 EXT EXT(instr_D,PC4_D,ExtOp,EXTout,NPC_B);
	 ID_MUX ID_MUX(ForwardRSD,ForwardRTD,result_W,result_WD,Data1,Data2,ALUout_M,D1,D2);
	 RegFile RegFile(clk,reset,RegWrite_WD,PC_WD,instr_D,WRegAdd_D,result_WD,Data1,Data2);
	 controller_D controller_D(instr_D,ExtOp,nPC_Sel_D);
	 Equ Equ(zero,nPC_Sel_D,PCSrc_D);
	 NPC_D NPC_D(instr_D,PC_D,D1,NPC_J,NPC_JR);


endmodule
