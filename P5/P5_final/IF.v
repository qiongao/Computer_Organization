`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:42 12/13/2017 
// Design Name: 
// Module Name:    IF 
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
module IF(
    input clk,
    input reset,
	 input stall,
    input [1:0] PCSrc_D,
    input [31:0] NPC_B,
	 input [31:0] NPC_J,
	 input [31:0] NPC_JR,
    output [31:0] instr_F,
	 output [31:0] PC_F,
    output [31:0] PC4_F,
	 output [31:0] PC8_F
    );
	 
	 parameter CAL_R = 2'b00;
	 parameter BEQ = 2'b01;
	 parameter J_JAL = 2'b10;
	 parameter JR = 2'b11;
	 
	 reg [31:0] PC;
	 reg [31:0] IM [1023:0];
	 initial begin
		PC <= 32'h0000_3000;
		$readmemh("code.txt",IM);
	 end
	 
	 assign instr_F = IM[PC_F[11:2]];
	 assign PC_F = PC;
	 assign PC4_F = PC + 4;
	 assign PC8_F = PC + 8;
	 always@(posedge clk)begin
		if(reset)begin
			PC <= 32'h0000_3000;
		end
		else begin
			if(stall)	PC <= PC;
			else begin
				case(PCSrc_D)
				CAL_R : PC <= PC + 4;
				BEQ : PC <= NPC_B;
				J_JAL : PC <= NPC_J;
				JR : PC <= NPC_JR;
				endcase					
			end
		end
	 end
	 
endmodule
