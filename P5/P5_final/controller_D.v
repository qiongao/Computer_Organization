`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:04:23 12/13/2017 
// Design Name: 
// Module Name:    Controller 
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
module controller_D(
	 input [31:0] instr_D,
	 output [1:0] ExtOp,
	 output [1:0] nPC_Sel
    );

	 assign ExtOp[1] = (instr_D[`op] === `beq || instr_D[`op] === `sw || instr_D[`op] === `lw)?1:0;
	 assign ExtOp[0] = (instr_D[`op] === `beq || instr_D[`op] === `lui)?1:0;
	 assign nPC_Sel[1] = (instr_D[`op] === `j || instr_D[`op] === `jal || (instr_D[`op] === `cal_r_op && instr_D[`funct] === `jr_f))?1:0;
	 assign nPC_Sel[0] = (instr_D[`op] === `beq || (instr_D[`op] === `cal_r_op && instr_D[`funct] === `jr_f))?1:0;

endmodule
