`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:11 12/13/2017 
// Design Name: 
// Module Name:    PCSrc_D 
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
module Equ(
    input bmove,
    input [1:0] nPC_Sel,
    output [1:0] PCSrc_D
    );
	 
	 assign PCSrc_D = 
		(nPC_Sel === 2'b00)?2'b00:
		(nPC_Sel === 2'b01 && bmove)?2'b01:
		(nPC_Sel === 2'b10)?2'b10:
		(nPC_Sel === 2'b11)?2'b11:2'b00;
		


endmodule
