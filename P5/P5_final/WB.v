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
`include "controller_W.v"
module WB(
	 input [31:0] instr_W,
	 input [31:0] ReadData_W,
	 input [31:0] ALUout_W,
	 input [31:0] PC8_W,
	 output RegWrite_W,
	 output [1:0] Mem2Reg_W,
	 output [31:0] result_W
    );
	 
	 parameter ALUO = 2'b00;
	 parameter DMO = 2'b01;
	 parameter PCP8 = 2'b10;

	 controller_W controller_W(instr_W,Mem2Reg_W,RegWrite_W);
	 assign result_W = 
		(Mem2Reg_W === ALUO)?ALUout_W:
		(Mem2Reg_W === DMO)?ReadData_W:
		(Mem2Reg_W === PCP8)?PC8_W:0;


endmodule
