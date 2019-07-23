`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:20:38 11/27/2017 
// Design Name: 
// Module Name:    im 
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
module im(
    input [31:0] address,
	 output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] immediate,
	 output [25:0] instr_index,
    output [5:0] funct
    );

	 integer i=0;
	 reg [31:0] instr;
	 reg [31:0] im[1023:0];
	 initial begin
		$readmemh("code.txt",im);
		instr <= 32'b0;
	 end
	 assign op = instr[31:26];
	 assign rs = instr[25:21];
	 assign rt = instr[20:16];
	 assign rd = instr[15:11];
	 assign immediate = instr[15:0];
	 assign instr_index = instr[25:0];
	 assign funct = instr[5:0];
	 assign instruction = instr;
	 always@(address)begin
		instr <= im[address[11:2]];
	 end
endmodule