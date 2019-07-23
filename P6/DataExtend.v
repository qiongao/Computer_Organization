`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:53 12/21/2017 
// Design Name: 
// Module Name:    MemExt 
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
module DataExtend(
	 input [1:0] A,
	 input [2:0] MemExtOp,
	 input [31:0] ReadData_W,
	 output [31:0] DExtout
    );
	 
	 /*
	 assign DExtout = (MemExt === 0)?{{16{h[15]}},h}:
					  (MemExt === 1)?{16'b0,h}:
					  (MemExt === 2)?{{24{b[7]}},b}:
					  (MemExt === 3)?{24'b0,b}:
					  (MemExt === 4)?data:0;
	*/
	///////////////////////waiting////////////////////////////
	 assign DExtout = (MemExtOp === 4)?((A[1])?{{16{ReadData_W[31]}},ReadData_W[31:16]}:{{16{ReadData_W[15]}},ReadData_W[15:0]}):
							(MemExtOp === 3)?((A[1])?{16'b0,ReadData_W[31:16]}:{16'b0,ReadData_W[15:0]}):
							(MemExtOp === 2)?((A===3)?{{24{ReadData_W[31]}},ReadData_W[31:24]}:
													(A===2)?{{24{ReadData_W[23]}},ReadData_W[23:16]}:
													(A===1)?{{24{ReadData_W[15]}},ReadData_W[15:8]}:{{24{ReadData_W[7]}},ReadData_W[7:0]}):
							(MemExtOp === 1)?((A===3)?{24'b0,ReadData_W[31:24]}:
													(A===2)?{24'b0,ReadData_W[23:16]}:
													(A===1)?{24'b0,ReadData_W[15:8]}:{24'b0,ReadData_W[7:0]}):ReadData_W;

endmodule
