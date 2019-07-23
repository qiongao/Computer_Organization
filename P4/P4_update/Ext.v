`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:02:31 11/27/2017 
// Design Name: 
// Module Name:    Ext 
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
module Ext(
    input [15:0] imm,
    input [25:0] instr_index,
    input [1:0] ExtOp,
	 input [31:0] P,
    output [31:0] extend
    );
	 
	 reg [31:0] ex;
	 parameter unsign_rext = 2'b00;
	 parameter unsign_lext = 2'b01;
	 parameter link = 2'b10;
	 parameter sign_rext = 2'b11;
	 
	 initial begin
		ex <= 32'b0;
	 end

	 assign extend = ex;
	 always@(imm,instr_index,ExtOp,P)begin
		case(ExtOp)
		unsign_rext : ex <= {16'b0,imm};
		unsign_lext : ex <= {imm,16'b0};
		link : ex <= {P[31:28],instr_index,2'b00};
		sign_rext : begin
			if(imm[15] === 1)	ex <= {16'hffff,imm};
			else	ex <= {16'b0,imm};
		end
		endcase
	 end
endmodule
