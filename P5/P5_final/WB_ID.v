`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:16:20 12/13/2017 
// Design Name: 
// Module Name:    WB_ID 
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
module WB_ID(
	 input clk,
	 input reset,
	 input RegWrite_W,
	 input [1:0] Mem2Reg_W,
	 input [4:0] WRegAdd_W,
	 input [31:0] instr_W,
	 input [31:0] result_W,
	 input [31:0] PC_W,
	 input [31:0] PC8_W,
	 output RegWrite_WD,
	 output [1:0] Mem2Reg_WD,
	 output [4:0] WRegAdd_D,
	 output [31:0] instr_WD,
	 output [31:0] result_WD,
	 output [31:0] PC_WD,
	 output [31:0] PC8_WD
    );
	 
	 reg rw;
	 reg [4:0] wra;
	 reg [31:0] in,r,pc;
	 
	 initial begin
		rw <= 0;
		wra <= 0;
		in <= 0;
		r <= 0;
		pc <= 32'h0000_3000;
	 end
	 
	 assign RegWrite_WD = rw;
	 assign WRegAdd_D = wra;
	 assign instr_WD = in;
	 assign result_WD = r;
	 assign PC_WD = pc;
	 always@(posedge clk)begin
		if(reset)begin
			rw <= 0;
			wra <= 0;
			in <= 0;
			r <= 0;
			pc <= 32'h0000_3000;
		end
		else begin
			rw <= RegWrite_W;
			wra <= WRegAdd_W;
			in <= instr_W;
			r <= result_W;
			pc <= PC_W;
		end
	 end


endmodule
