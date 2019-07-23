`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:37:34 12/13/2017 
// Design Name: 
// Module Name:    RegFile 
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

module RegFile(
    input clk,
	 input reset,
	 input RegWrite,
	 input [31:0] PC_WD,
	 input [31:0] instr_D,
    input [4:0] WRegAdd,
    input [31:0] RegData,
	 output [31:0] Data1,
	 output [31:0] Data2
    );
	 
	 reg [31:0] GRF [31:0];
	 integer i;
	 initial begin
		for(i=0;i<=31;i=i+1)begin
			GRF[i] <= 32'b0;
		end
	 end
	 
	 assign Data1 = GRF[instr_D[`rs]];
	 assign Data2 = GRF[instr_D[`rt]];
	 always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<=31;i=i+1)begin
				GRF[i] <= 32'b0;
			end			
		end
		else begin
			if(RegWrite && WRegAdd != 5'b0)begin
				GRF[WRegAdd] <= RegData;
				$display("%d@%h: $%d <= %h",$time,PC_WD,WRegAdd,RegData); 
			end
		end
	 end

endmodule
