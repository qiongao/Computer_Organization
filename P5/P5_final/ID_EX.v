`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:58 12/13/2017 
// Design Name: 
// Module Name:    ID_EX 
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
`define rs 25:21
`define rt 20:16
`define rd 15:11

module ID_EX(
	 input clk,
	 input reset, //
	 input [31:0] EXTout_D,
	 input [31:0] RD1_D,
	 input [31:0] RD2_D,
	 input [31:0] instr_D,
	 input [31:0] PC_D,
	 input [31:0] PC8_D,
	 input Flush_E,
	 output [4:0] Rs_E,
	 output [4:0] Rt_E,
	 output [4:0] Rd_E,
	 output [31:0] instr_E,
	 output [31:0] PC_E,
	 output [31:0] PC8_E,
	 output [31:0] RD1_E,
	 output [31:0] RD2_E,
	 output [31:0] EXTout_E
    );
	 
	 reg [4:0] rs,rt,rd;
	 reg [31:0] in,r1,r2,ext,pc,pc8;
	 
	 initial begin
		rs <= 0;
		rt <= 0;
		rd <= 0;
		in <= 0;
		r1 <= 0;
		r2 <= 0;
		ext <= 0;
		pc <= 32'h0000_3000;
		pc8 <= 32'h0000_3000;
	 end
	 
	 assign Rs_E = rs;
	 assign Rt_E = rt;
	 assign Rd_E = rd;
	 assign instr_E = in;
	 assign RD1_E = r1;
	 assign RD2_E = r2;
	 assign EXTout_E = ext;
	 assign PC_E = pc;
	 assign PC8_E = pc8;
	 always@(posedge clk)begin
		if(reset || Flush_E)begin
			rs <= 0;
			rt <= 0;
			rd <= 0;
			in <= 0;
			r1 <= 0;
			r2 <= 0;
			ext <= 0;
			pc <= 32'h0000_3000;
			pc8 <= 32'h0000_3000;
		end
		else begin
			rs <= instr_D[`rs];
			rt <= instr_D[`rt];
			rd <= instr_D[`rd];
			in <= instr_D;
			r1 <= RD1_D;
			r2 <= RD2_D;
			ext <= EXTout_D;
			pc <= PC_D;
			pc8 <= PC8_D;
		end

	 end


endmodule
