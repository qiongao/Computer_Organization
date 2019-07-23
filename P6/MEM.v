`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:47 12/13/2017 
// Design Name: 
// Module Name:    MEM 
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
/*`include "controller_M.v"
`include "DataMem.v"
`include "MEM_MUX.v"
*/
module MEM(
	 input clk,
	 input reset,
	 input [1:0] ForwardRTM,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] instr_M,
	 input [31:0] ALUout_M,
	 input [31:0] WriteData_M,
	 input [31:0] PC_M,
	 input [31:0] PC8_M,
	 output RegWrite_M,
	 output Write_M,
	 output [1:0] Mem2Reg_M,
	 output [31:0] DisA_M,
	 output [31:0] DisWD_M,
	 output [31:0] ReadData_M
    );
	 
	 //wire MemWrite;
	 wire [3:0] BE;
	 wire [31:0] WD;
	 
	 controller_M controller_M(instr_M,RegWrite_M,MemWrite_M,Mem2Reg_M);
	 DataMem DataMem(clk,reset,BE,PC_M,PC8_M,ALUout_M,WD,MemWrite_M,Write_M,DisA_M,DisWD_M,ReadData_M);
	 MEM_MUX MEM_MUX(ForwardRTM,instr_M,ALUout_M,result_W,result_WD,WriteData_M,BE,WD);

endmodule
