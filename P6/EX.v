`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:32 12/13/2017 
// Design Name: 
// Module Name:    EX 
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
/*
`include "ALU.v"
`include "EX_MUX.v"
`include "controller_E.v"
`include "MUL_DIV.v"
*/
module EX(
	 input clk, 
	 input reset,
	 input [2:0] ForwardRSE,
	 input [2:0] ForwardRTE,
	 input [4:0] Rt_E,
	 input [4:0] Rd_E,
	 input [31:0] instr_E,
	 input [31:0] RD1_E,
	 input [31:0] RD2_E,
	 input [31:0] EXTout_E,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] ALUout_M,
	 input [31:0] MDout_M,
	 output start,
	 output Busy,
	 output RegWrite_E,
	 output [1:0] Mem2Reg,
	 output [4:0] WRegAdd_E,
	 output [31:0] MDout_E,
	 output [31:0] ALUout_E,
	 output [31:0] WriteData_E
    );
	 
	 wire ALUSrc;
	 wire [1:0] RegDst;
	 wire [3:0] MDOp;
	 wire [3:0] ALUOp;
	 wire [31:0] SrcA_E,SrcB_E;

	 ALU ALU(instr_E[10:6],SrcA_E,SrcB_E,ALUOp,ALUout_E);
	 EX_MUX EX_MUX(ALUSrc,ForwardRSE,ForwardRTE,RegDst,Rt_E,Rd_E,EXTout_E,RD1_E,RD2_E,result_W,result_WD,ALUout_M,MDout_M,WRegAdd_E,SrcA_E,SrcB_E,WriteData_E);
	 controller_E controller_E(instr_E,start,ALUSrc,RegWrite_E,RegDst,Mem2Reg,MDOp,ALUOp);
	 MUL_DIV MUL_DIV(clk,reset,start,MDOp,SrcA_E,SrcB_E,Busy,MDout_E);

endmodule
