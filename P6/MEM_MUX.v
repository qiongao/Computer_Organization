`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:27:36 12/14/2017 
// Design Name: 
// Module Name:    MEM_MUX 
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
`define SB instr[31:26] === 6'b101000
`define SH instr[31:26] === 6'b101001
`define SW instr[31:26] === 6'b101011
`define LB instr[31:26] === 6'b100000
`define LBU instr[31:26] === 6'b100100
`define LH instr[31:26] === 6'b100001
`define LHU instr[31:26] === 6'b100101
`define LW instr[31:26] === 6'b100011

module MEM_MUX(
	 input [1:0] ForwardRTM,
	 input [31:0] instr,
	 input [31:0] ALUout_M,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] WriteData_M,
	 output [3:0] BE,
	 output [31:0] WD
    );
	 
	 assign WD = (ForwardRTM===2'b00)?WriteData_M:
					 (ForwardRTM===2'b01)?result_W:
					 (ForwardRTM===2'b10)?result_WD:32'b0;
					 
	 assign BE = (`SW || `LW)?4'b1111:
					 (`SH || `LH || `LHU)?((ALUout_M[1])?4'b1100:4'b0011):
					 (`SB || `LB || `LBU)?((ALUout_M[1:0]===3)?4'b1000:
												  (ALUout_M[1:0]===2)?4'b0100:
												  (ALUout_M[1:0]===1)?4'b0010:
												  (ALUout_M[1:0]===0)?4'b0001:0):0;


endmodule
