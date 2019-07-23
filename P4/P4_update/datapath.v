`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:15:14 12/04/2017 
// Design Name: 
// Module Name:    datapath 
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
`include "Ext.v"
`include "alu.v"
`include "alu_selector.v"
`include "dm.v"
`include "registers.v"
`include "im.v"
`include "pc.v"
`include "reg_selector.v"
module datapath(
	 input clk,
	 input reset,
	 input [5:0] Op,
	 input [5:0] funct,
	 input RegA,
	 input ALUSrc,
	 input RegWrite,
	 input MemWrite,
	 input DM_Sel,
	 input [1:0] RegDst,
	 input [1:0] Mem2Reg,
	 input [1:0] ExtOp,
	 input [2:0] nPC_Sel,
	 input [2:0] ALUOp
    );
	 
	wire [4:0] A1,A2,A3,rs,rt,rd;
	wire [31:0] P,extend,A,B,result,rdata1,rdata2,out,RData,wdata,address,adder;
	wire [15:0] immediate;
	wire [25:0] instr_index;
	wire zero;
	
	pc pc(clk,reset,zero,b_zero,nPC_Sel,instr_index,immediate,rdata1,address,adder,P); //
	im im(address,Op,rs,rt,rd,immediate,instr_index,funct); //
	reg_selector reg_selector(rs,rt,rd,result,RData,adder,RegA,RegDst,Mem2Reg,A1,A2,A3,wdata); //
	registers registers(A1,A2,A3,wdata,address,clk,reset,RegWrite,rdata1,rdata2); //
	alu_selector alu_selector(rdata2,extend,ALUSrc,out); //	
	alu alu(rdata1,out,ALUOp,zero,b_zero,result); //
	dm dm(clk,reset,MemWrite,DM_Sel,result,rdata2,address,RData); //
	Ext Ext(immediate,instr_index,ExtOp,P,extend);


endmodule
