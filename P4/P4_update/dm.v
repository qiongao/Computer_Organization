`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:40 11/27/2017 
// Design Name: 
// Module Name:    dm 
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
module dm(
    input clk,
    input reset,
	 input MemWrite,
	 input DM_Sel,
    input [31:0] addr,
    input [31:0] WD, //write data
	 input [31:0] address,
    output [31:0] RD //read data
    );
	 
	 integer i;
	 reg [31:0] datam;
	 reg [31:0] DataMem [1023:0];
	 //assign RD = DataMem[addr[11:2]];
	 assign RD = datam;
	 initial begin
		datam <= 0;
		for(i=0;i<=1023;i=i+1)	DataMem[i] = 32'b0;
	 end
	 //always@(posedge clk)begin
	 always@(negedge clk)begin
		if(reset)begin
			for(i=0;i<=1023;i=i+1)	DataMem[i] = 32'b0;
		end
		else begin
			if(DM_Sel)begin
				if(addr[1])begin
					datam <= {{16{DataMem[addr[11:2]][31]}},DataMem[addr[11:2]][31:16]};
				end
				else begin
					datam <= {{16{DataMem[addr[11:2]][15]}},DataMem[addr[11:2]][15:0]};
				end
			end
			else	datam <= DataMem[addr[11:2]];
			
			if(MemWrite)begin
				DataMem[addr[11:2]] <= WD;
				$display("@%h: *%h <= %h",address,addr,WD);
			end
		end
	 end
endmodule