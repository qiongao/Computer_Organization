`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:49 12/13/2017 
// Design Name: 
// Module Name:    controller_M 
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
`define cal_r_op 6'b000000
`define addu_f 6'b100001
`define subu_f 6'b100011
`define ori 6'b001101
`define lw 6'b100011
`define sw 6'b101011
`define beq 6'b000100
`define lui 6'b001111
`define j 6'b000010
`define jal 6'b000011
`define jr_f 6'b001000
module controller_M(
	 input [31:0] instr_M,
	 output RegWrite,
	 output MemWrite,
	 output [1:0] Mem2Reg
    );
	 
	 
	 assign Mem2Reg[1] = (instr_M[`op] === `jal)?1:0;
	 assign Mem2Reg[0] = (instr_M[`op] === `lw)?1:0;
	 assign MemWrite = (instr_M[`op] === 6'b101011)?1:0;
	 assign RegWrite = ((instr_M[`op] === 6'b000000 && (instr_M[`funct] === 6'b100001 || 
								instr_M[`funct] === 6'b100011)) || instr_M[`op] === 6'b001101 || 
								instr_M[`op] === 6'b100011 || instr_M[`op] === 6'b001111 || instr_M[`op] === 6'b000011)?1:0;


endmodule
