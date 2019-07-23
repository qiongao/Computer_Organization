`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:01 12/13/2017 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
	 input clk,
	 input reset,
	 input [31:0] instr_E,
	 input [31:0] ALUout_E,
	 input [31:0] WriteData_E,
	 input [31:0] PC_E,
	 input [31:0] PC8_E,
	 input [4:0] WRegAdd_E,
	 output [31:0] instr_M,
	 output [31:0] ALUout_M,
	 output [31:0] WriteData_M,
	 output [31:0] PC_M,
	 output [31:0] PC8_M,
	 output [4:0] WRegAdd_M
    );
	 
	 reg [31:0] in,alu,wd,wra,pc,pc8;
	 
	 initial begin
		in <= 0;
		alu <= 0;
		wd <= 0;
		wra <= 0;
		pc <= 32'h0000_3000;
		pc8 <= 32'h0000_3000;
	 end
	 
	 assign instr_M = in;
	 assign ALUout_M = alu;
	 assign WriteData_M = wd;
	 assign WRegAdd_M =wra;
	 assign PC_M = pc;
	 assign PC8_M = pc8;
	 always@(posedge clk)begin
		if(reset)begin
			in <= 0;
			alu <= 0;
			wd <= 0;
			wra <= 0;
			pc <= 32'h0000_3000;
			pc8 <= 32'h0000_3000;
		end
		else begin
			in <= instr_E;
			alu <= ALUout_E;
			wd <= WriteData_E;
			wra <= WRegAdd_E;
			pc <= PC_E;
			pc8 <= PC8_E;
		end
	 end
	 


endmodule
