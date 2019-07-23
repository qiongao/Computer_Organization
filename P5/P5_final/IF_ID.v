`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:50 12/13/2017 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	 input clk,
	 input reset, //
	 input stall,
	 input [31:0] instr_F,
	 input [31:0] PC_F,
	 input [31:0] PC4_F,
	 input [31:0] PC8_F,
	 
	 output [31:0] instr_D,
	 output [31:0] PC_D,
	 output [31:0] PC4_D,
	 output [31:0] PC8_D
    );
	 
	 reg [31:0] in,pc,p4,p8;
	 assign instr_D = in;
	 assign PC_D = pc;
	 assign PC4_D = p4;
	 assign PC8_D = p8;
	 
	 initial begin
		in <= 0;
		pc <= 32'h0000_3000;
		p4 <= 32'h0000_3000;
		p8 <= 32'h0000_3000;		
	 end
	 always@(posedge clk)begin
		if(reset)begin
			in <= 32'h0000_3000;
			pc <= 32'h0000_3000;
			p4 <= 32'h0000_3000;
			p8 <= 32'h0000_3000;
		end
		else begin
			if(stall)begin
				in <= in;
				pc <= pc;
				p4 <= p4;
				p8 <= p8;
			end
			else begin
				in <= instr_F;
				pc <= PC_F;
				p4 <= PC4_F;
				p8 <= PC8_F;
			end
		end
	 end

endmodule
