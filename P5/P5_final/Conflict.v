`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:05:07 12/13/2017 
// Design Name: 
// Module Name:    Conflict 
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
`define op 31:26
`define funct 5:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define beq 6'b000100
`define cal_r 6'b000000
`define ori 6'b001101
`define lui 6'b001111
`define sw 6'b101011
`define lw 6'b100011
`define j 6'b000010
`define jal 6'b000011
`define jr_f 6'b001000


module Conflict(
	 input clk,
	 input RegWrite_E,
	 input RegWrite_M,
	 input RegWrite_W,
	 input RegWrite_WD,
	 input [1:0] nPC_Sel_D,
	 input [1:0] Mem2Reg_E,
	 input [1:0] Mem2Reg_M,
	 input [1:0] Mem2Reg_W,
	 input [1:0] Mem2Reg_WD,
	 input [4:0] WRegAdd_E,
	 input [4:0] WRegAdd_M,
	 input [4:0] WRegAdd_W,
	 input [4:0] WRegAdd_WD,
	 input [31:0] instr_F,
	 input [31:0] instr_D,
	 input [31:0] instr_E,
	 input [31:0] instr_M,
	 input [31:0] instr_W,
	 input [31:0] instr_WD,
	 output [1:0] ForwardRSD,
	 output [1:0] ForwardRTD,
	 output [1:0] ForwardRSE,
	 output [1:0] ForwardRTE,
	 output [1:0] ForwardRTM,
	 output stall,
	 output Flush_E
    );
	 
	 wire loadstall,beqstall,jrstall,beqstall;
	 
	 assign stall = loadstall | beqstall | jrstall;
	 assign Flush_E = loadstall | beqstall | jrstall;
	 assign loadstall = (((instr_D[`rs] === instr_E[`rt])||(instr_D[`rt]===instr_E[`rt]))&&(Mem2Reg_E===2'b01));
	 assign beqstall = ((nPC_Sel_D===2'b01)&&(Mem2Reg_M===2'b01)&&((WRegAdd_M===instr_D[`rs])||(WRegAdd_M===instr_D[`rt]))) ||
							 ((nPC_Sel_D===2'b01)&&(RegWrite_E)&&((WRegAdd_E===instr_D[`rs])||(WRegAdd_E===instr_D[`rt])));
	 assign jrstall = ((nPC_Sel_D===2'b11)&&(Mem2Reg_M===2'b01)&&(WRegAdd_M===instr_D[`rs])) ||
							((nPC_Sel_D===2'b11)&&(RegWrite_E)&&(WRegAdd_E===instr_D[`rs]));
	 
	 assign ForwardRSD = ((instr_D[`rs]!=5'b0)&&(instr_D[`rs]===WRegAdd_M)&&RegWrite_M)?2'b01:
								((instr_D[`rs]!=5'b0)&&(instr_D[`rs]===WRegAdd_W)&&RegWrite_W)?2'b10:
								((instr_D[`rs]!=5'b0)&&(instr_D[`rs]===WRegAdd_WD)&&RegWrite_WD)?2'b11:2'b00;
								
	 assign ForwardRTD = ((instr_D[`rt]!=5'b0)&&(instr_D[`rt]===WRegAdd_M)&&RegWrite_M)?2'b01:
								((instr_D[`rt]!=5'b0)&&(instr_D[`rt]===WRegAdd_W)&&RegWrite_W)?2'b10:
								((instr_D[`rt]!=5'b0)&&(instr_D[`rt]===WRegAdd_WD)&&RegWrite_WD)?2'b11:2'b00;
								
	 assign ForwardRSE = ((instr_E[`rs]!=5'b0)&&(instr_E[`rs]===WRegAdd_M)&&RegWrite_M)?2'b01:
								((instr_E[`rs]!=5'b0)&&(instr_E[`rs]===WRegAdd_W)&&RegWrite_W)?2'b10:
								((instr_E[`rs]!=5'b0)&&(instr_E[`rs]===WRegAdd_WD)&&RegWrite_WD)?2'b11:2'b00;
	 
	 assign ForwardRTE = ((instr_E[`rt]!=5'b0)&&(instr_E[`rt]===WRegAdd_M)&&RegWrite_M)?2'b01:
								((instr_E[`rt]!=5'b0)&&(instr_E[`rt]===WRegAdd_W)&&RegWrite_W)?2'b10:
								((instr_E[`rt]!=5'b0)&&(instr_E[`rt]===WRegAdd_WD)&&RegWrite_WD)?2'b11:2'b00;
		
	 assign ForwardRTM = ((instr_M[`rt]!=5'b0)&&(instr_W[`rt]===WRegAdd_M)&&(Mem2Reg_W===2'b01))?2'b01:
								((instr_M[`rt]!=5'b0)&&(instr_WD[`rt]===WRegAdd_M)&&(Mem2Reg_WD===2'b01))?2'b10:2'b0;
	 

endmodule
