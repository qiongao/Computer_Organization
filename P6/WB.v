`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:23 12/13/2017 
// Design Name: 
// Module Name:    WB 
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
//`include "controller_W.v"
//`include "DataExtend.v"
module WB(
	 input [31:0] MDout_W,
	 input [31:0] instr_W,
	 input [31:0] ReadData_W,
	 input [31:0] ALUout_W,
	 input [31:0] PC8_W,
	 output RegWrite_W,
	 //output MemWrite_W,
	 output [1:0] Mem2Reg_W,
	 output [31:0] result_W
    );
	 
	 wire [2:0] MemExtOp;
	 wire [31:0] DExtout;
	 
	 DataExtend DataExtend(ALUout_W[1:0],MemExtOp,ReadData_W,DExtout);
	 controller_W controller_W(instr_W,RegWrite_W,Mem2Reg_W,MemExtOp);
	 assign result_W = 
		(Mem2Reg_W === 0)?ALUout_W:
		(Mem2Reg_W === 1)?DExtout:
		(Mem2Reg_W === 2)?PC8_W:
		(Mem2Reg_W === 3)?MDout_W:0;


endmodule
