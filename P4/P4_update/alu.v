`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:01 11/27/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output zero,
	 output b_zero,
    output [31:0] result
    );
	 
	 reg [31:0] r;
	 parameter ADD = 3'b000;
	 parameter SUB = 3'b001;
	 parameter OR = 3'b010;
	 parameter CB = 3'b011;
	 parameter BZ = 3'b100;
	 parameter RML = 3'b101;
	 parameter XOR = 3'b110;
	 
	 initial begin
		r <= 32'b0;
	 end
	 
	 assign result = r;
	 assign zero = (r === 0)?1:0;
	 assign b_zero = (r > 0)?1:0;
	 always@(A,B,ALUOp)begin
		case(ALUOp)
		ADD : r <= A + B;
		SUB : r <= A - B;
		OR : r <= A | B;
		CB : r <= B;
		BZ : r <= A;
		RML : r <= (B >> A[4:0]);
		XOR : r <= (!A & B) | (A & !B);
		endcase
	 end
endmodule
