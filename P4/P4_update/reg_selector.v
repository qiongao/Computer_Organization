`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:05 11/27/2017 
// Design Name: 
// Module Name:    reg_selector 
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
module reg_selector(
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] result,
    input [31:0] RData,
    input [31:0] adder,
    input RegA,
    input [1:0] RegDst,
    input [1:0] Mem2Reg,
    output [4:0] A1,
    output [4:0] A2,
    output [4:0] A3,
    output [31:0] wdata
    );
	 
	 reg [4:0] d1,d2,d3;
	 reg [31:0] wd;
	 parameter state0 = 2'b00;
	 parameter state1 = 2'b01;
	 parameter state2 = 2'b10;
	 
	 initial begin
		d1 <= 5'b0;
		d2 <= 5'b0;
		d3 <= 5'b0;
		wd <= 32'b0;
	 end
	 
	 assign A1 = d1;
	 assign A2 = d2;
	 assign A3 = d3;
	 assign wdata = wd;
	 always@(rs,rt,rd,result,RData,adder,RegA,RegDst,Mem2Reg)begin
		d1 <= (RegA)?5'd31:rs;		
		d2 <= rt;
		
		case(RegDst)
		state0 : d3 <= rt;
		state1 : d3 <= rd;
		state2 : d3 <= 5'd31;
		endcase
		
		case(Mem2Reg)
		state0 : wd <= result;
		state1 : wd <= RData;
		state2 : wd <= adder;
		endcase
	 end
endmodule
