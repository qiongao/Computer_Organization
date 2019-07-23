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
    input [4:0] s,
	 input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
    output [31:0] C
    );
	 
	 assign C = 
		(ALUOp === 0)?(A+B):
		(ALUOp === 1)?(A-B):
		(ALUOp === 2)?(A|B):
		(ALUOp === 3)?B:
		(ALUOp === 4)?(A&B):
		(ALUOp === 5)?(A^B):
		(ALUOp === 6)?(~(A|B)):
		(ALUOp === 7)?(B<<s):
		(ALUOp === 8)?(B<<A[4:0]):
		(ALUOp === 9)?($signed(($signed(B))>>>s)):
		(ALUOp === 10)?($signed(($signed(B))>>>A[4:0])):
		(ALUOp === 11)?(B>>s):
		(ALUOp === 12)?(B>>A[4:0]):
		(ALUOp === 13)?((($signed(A))<($signed(B)))?1:0):
		(ALUOp === 14)?((A<B)?1:0):0;
		

endmodule
