`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:56:52 11/27/2017 
// Design Name: 
// Module Name:    alu_selector 
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
module alu_selector(
    input [31:0] rdata,
    input [31:0] ext,
    input ALUSrc,
    output [31:0] out
    );
	 
	 reg [31:0] o;
	 initial begin
		o <= 32'b0;
	 end
	 
	 assign out = o;
	 always@(rdata,ext,ALUSrc)begin
		o <= (ALUSrc)?ext:rdata;
	 end
endmodule
