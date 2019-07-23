`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:54 12/13/2017 
// Design Name: 
// Module Name:    EX_MUX 
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
module EX_MUX(
	 input ALUSrc,
	 input [1:0] ForwardRSE,
	 input [1:0] ForwardRTE,
	 input [1:0] RegDst,
	 input [4:0] Rt_E,
	 input [4:0] Rd_E,
	 input [31:0] EXTout_E,
	 input [31:0] RD1_E,
	 input [31:0] RD2_E,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] ALUout_M,
	 output [4:0] WRegADD_E,
	 output [31:0] SrcA_E,
	 output [31:0] SrcB_E,
	 output [31:0] WriteData_E
    );
	 
	 parameter RT = 2'b00;
	 parameter RD = 2'b01;
	 parameter JJ = 2'b10; //31
	 
	 
	 assign WRegADD_E = 
		(RegDst === RT)?Rt_E:
		(RegDst === RD)?Rd_E:
		(RegDst === JJ)?5'd31:0;
	 
	 assign SrcA_E = 
		(ForwardRSE === 2'b00)?RD1_E:
		(ForwardRSE === 2'b01)?ALUout_M:
		(ForwardRSE === 2'b10)?result_W:
		(ForwardRSE === 2'b11)?result_WD:0;
		
	 assign SrcB_E = 
		(ALUSrc)?EXTout_E:
		(ForwardRTE === 2'b00)?RD2_E:
		(ForwardRTE === 2'b01)?ALUout_M:
		(ForwardRTE === 2'b10)?result_W:
		(ForwardRTE === 2'b11)?result_WD:0;
	 
	 assign WriteData_E = 
		(ForwardRTE === 2'b00)?RD2_E:
		(ForwardRTE === 2'b01)?ALUout_M:
		(ForwardRTE === 2'b10)?result_W:
		(ForwardRTE === 2'b11)?result_WD:0;
	 
endmodule
