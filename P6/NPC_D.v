`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:41 12/13/2017 
// Design Name: 
// Module Name:    NPC_D 
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
module NPC_D(
	 input [31:0] instr_D,
	 input [31:0] PC_D,
	 input [31:0] D1,
	 output [31:0] NPC_J,
	 output [31:0] NPC_JR
    );
	 
	 assign NPC_J = {PC_D[31:28],instr_D[25:0],2'b00};
	 assign NPC_JR = D1;


endmodule
