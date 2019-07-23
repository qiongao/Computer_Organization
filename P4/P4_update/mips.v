`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:03:01 11/25/2017 
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
`include "controller.v"
`include "datapath.v"

module mips(clk,reset);
	input clk;
	input reset;
	
	wire [5:0] Op,funct;
	wire [2:0] nPC_Sel,ALUOp;
	wire [1:0] RegDst,Mem2Reg,ExtOp;
	wire RegA,ALUSrc,RegWrite,MemWrite;

	controller controller(Op,funct,RegA,ALUSrc,RegWrite,MemWrite,DM_Sel,RegDst,Mem2Reg,ExtOp,nPC_Sel,ALUOp); //
	datapath datapath(clk,reset,Op,funct,RegA,ALUSrc,RegWrite,MemWrite,DM_Sel,RegDst,Mem2Reg,ExtOp,nPC_Sel,ALUOp);
	
endmodule
