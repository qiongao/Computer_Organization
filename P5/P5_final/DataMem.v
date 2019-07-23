`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:33 12/13/2017 
// Design Name: 
// Module Name:    DataMem 
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
module DataMem(
    input clk,
    input reset,
	 input [31:0] PC_M,
	 input [31:0] PC8_M,
    input [31:0] A,
    input [31:0] WD,
    input MemWrite,
    output [31:0] RD
    );
	 
	 reg [31:0] r;
	 reg [31:0] DM[1023:0];
	 integer i;
	 initial begin
		for(i=0;i<=1023;i=i+1)begin
			DM[i] <= 32'b0;
		end
		r <= 0;
	 end
	 
	 assign RD = DM[A[11:2]];
	 always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<=1023;i=i+1)begin
				DM[i] <= 32'b0;
			end		
		end
		else begin
			if(MemWrite)begin
				DM[A[11:2]] <= WD;
				$display("%d@%h: *%h <= %h",$time,PC_M,A,WD);
			end
		end
	 end


endmodule
