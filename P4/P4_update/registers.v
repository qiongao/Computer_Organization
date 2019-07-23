`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:45:48 11/29/2017 
// Design Name: 
// Module Name:    registers 
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
module registers(
	 input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] wdata,
	 input [31:0] address,
    input clk,
    input reset,
	 input RegWrite,
    output [31:0] rdata1,
    output [31:0] rdata2
    );
	 
	 integer i;
	 
	 reg [31:0] r1,r2;
	 reg [31:0] registers[31:0];
	 initial begin
		registers[0] <= 32'b0;
		//for(i=0;i<=31;i=i+1)begin
		//	registers[i] <= 32'b0;
		//end
		r1 <= 32'b0;
		r2 <= 32'b0;
	 end
	 
	 assign rdata1 = registers[A1];
	 assign rdata2 = registers[A2];
	 always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<=31;i=i+1)begin
				registers[i] <= 32'b0;
			end			
		end
		else begin
			if(RegWrite && A3 != 5'b0)begin
				registers[A3] <= wdata;
				$display("@%h: $%d <= %h",address,A3,wdata);
			end
		end
	 end


endmodule
