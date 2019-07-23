`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:41 12/13/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] SrcA_E,
    input [31:0] SrcB_E,
    input [1:0] ALUOp,
    output [31:0] ALUout_E
    );

	 parameter ADD = 2'b00;
	 parameter SUB = 2'b01;
	 parameter OR = 2'b10;
	 parameter B = 2'b11;
	 
	 assign ALUout_E = 
		(ALUOp === ADD)?(SrcA_E+SrcB_E):
		(ALUOp === SUB)?(SrcA_E-SrcB_E):
		(ALUOp === OR)?(SrcA_E | SrcB_E):
		(ALUOp === B)?SrcB_E:0;
		

endmodule
