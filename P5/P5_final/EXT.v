`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:51 12/13/2017 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [31:0] instr_D,
	 input [31:0] PC4_D,
    input [1:0] ExtOp,
    output [31:0] EXTout,
	 output [31:0] NPC_B
    );

	 reg [31:0] r;
	 
	 parameter unsign_low = 2'b00;
	 parameter unsign_high = 2'b01;
	 parameter sign_low = 2'b10;
	 parameter sign_shift = 2'b11;
	 
	 assign EXTout = 
		(ExtOp === unsign_low)?{16'b0,instr_D[15:0]}:
		(ExtOp === unsign_high)?{instr_D[15:0],16'b0}:
		(ExtOp === sign_low)?{{16{instr_D[15]}},instr_D[15:0]}:
		(ExtOp === sign_shift)?{{14{instr_D[15]}},instr_D[15:0],2'b00}:0;
		
	 assign NPC_B = 
		(ExtOp === unsign_low)?({16'b0,instr_D[15:0]}+PC4_D):
		(ExtOp === unsign_high)?({instr_D[15:0],16'b0}+PC4_D):
		(ExtOp === sign_low)?({{16{instr_D[15]}},instr_D[15:0]}+PC4_D):
		(ExtOp === sign_shift)?({{14{instr_D[15]}},instr_D[15:0],2'b00}+PC4_D):0;		

endmodule
