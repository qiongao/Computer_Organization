`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:45:10 12/13/2017 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
	 input [2:0] CMPOp,
    input [31:0] A,
    input [31:0] B,
    output bmove
    );

	 //assign zero = (D1 === D2)?1:0;
	 assign bmove = (CMPOp === 0)?((A===B)?1:0):
						 (CMPOp === 1)?((A!=B)?1:0):
						 (CMPOp === 2)?(($signed(A)<=0)?1:0):
						 (CMPOp === 3)?(($signed(A)>0)?1:0):
						 (CMPOp === 4)?(($signed(A)<0)?1:0):
						 (CMPOp === 5)?(($signed(A)>=0)?1:0):0;

endmodule
