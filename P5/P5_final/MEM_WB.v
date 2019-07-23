`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:35 12/13/2017 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
	 input clk,
	 inout reset,
	 input [31:0] instr_M,
	 input [31:0] ReadData_M,
	 input [31:0] ALUout_M,
	 input [31:0] PC_M,
	 input [31:0] PC8_M,
	 input [4:0] WRegAdd_M,
	 output [31:0] instr_W,
	 output [31:0] ReadData_W,
	 output [31:0] ALUout_W,
	 output [31:0] PC_W,
	 output [31:0] PC8_W,
	 output [4:0] WRegAdd_W
    );
	 
	 reg [4:0] wra;
	 reg [31:0] in,rd,alu,pc,pc8;
	 
	 initial begin
		wra <= 0;
		in <= 0;
		rd <= 0;
		alu <= 0;
		pc <= 32'h0000_3000;
		pc8 <= 32'h0000_3000;
	 end
	 
	 assign WRegAdd_W = wra;
	 assign instr_W = in;
	 assign ReadData_W = rd;
	 assign ALUout_W = alu;
	 assign PC_W = pc;
	 assign PC8_W = pc8;
	 always@(posedge clk)begin
		if(reset)begin
			wra <= 0;
			in <= 0;
			rd <= 0;
			alu <= 0;
			pc <= 32'h0000_3000;
			pc8 <= 32'h0000_3000;
		end
		else begin
			wra <= WRegAdd_M;
			in <= instr_M;
			rd <= ReadData_M;
			alu <= ALUout_M;
			pc <= PC_M;
			pc8 <= PC8_M;
		end
	 end


endmodule
