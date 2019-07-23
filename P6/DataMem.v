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
	 input [3:0] BE,
	 input [31:0] PC_M,
	 input [31:0] PC8_M,
    input [31:0] A,
    input [31:0] WD,
    input MemWrite,
	 output Write,
	 output [31:0] DisA_M,	//
	 output [31:0] DisWD_M,	//
    output [31:0] RD
    );
	 
	 reg [31:0] r,da,dw,wr;
	 reg [7:0] DM0[4095:0];
	 reg [7:0] DM1[4095:0];
	 reg [7:0] DM2[4095:0];
	 reg [7:0] DM3[4095:0];
	 integer i;
	 initial begin
		for(i=0;i<=4096;i=i+1)begin
			DM0[i] <= 8'b0;
			DM1[i] <= 8'b0;
			DM2[i] <= 8'b0;
			DM3[i] <= 8'b0;
		end
		r <= 0;
		da <= 0;
		dw <= 0;
		wr <= 0;
	 end
	 
	 //assign b = (BE === 4'b1000)?(DM3[A[14:2]]):
		//			(BE === 4'b0100)?(DM2[A[14:2]]):
			//		(BE === 4'b0010)?(DM1[A[14:2]]):
				//	(BE === 4'b0001)?(DM0[A[14:2]]):0;
					
	 //assign h = (BE === 4'b1100)?{DM3[A[14:2]],DM2[A[14:2]]}:
					//(BE === 4'b0011)?{DM1[A[14:2]],DM0[A[14:2]]}:0;
	 
	 //assign RD = {DM3[A[14:2]],DM2[A[14:2]],DM1[A[14:2]],DM0[A[14:2]]};
	 assign RD = {DM3[A[11:2]],DM2[A[11:2]],DM1[A[11:2]],DM0[A[11:2]]};
	 assign DisA_M = da;
	 assign DisWD_M = dw;
	 assign Write = wr;
	 
	 always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<=1023;i=i+1)begin
				DM0[i] <= 8'b0;
				DM1[i] <= 8'b0;
				DM2[i] <= 8'b0;
				DM3[i] <= 8'b0;
			end
			r <= 0;
			da <= 0;
			dw <= 0;
			wr <= 0;			
		end
		else begin
			wr <= MemWrite;
			if(MemWrite)begin
				////DM[A[14:2]] <= WD;
				////$display("%d@%h: *%h <= %h",$time,PC_M,A,WD);
				case(BE)
				4'b1111:begin
					DM3[A[14:2]] <= WD[31:24];
					DM2[A[14:2]] <= WD[23:16];
					DM1[A[14:2]] <= WD[15:8];
					DM0[A[14:2]] <= WD[7:0];
					$display("%d@%h: *%h <= %h",$time,PC_M,A,WD);
					da <= A;
					dw <= WD;
				end
				4'b1100:begin
					DM3[A[14:2]] <= WD[15:8];
					DM2[A[14:2]] <= WD[7:0];
					$display("%d@%h: *%h <= %h",$time,PC_M,{A[31:2],2'b0},{WD[15:0],DM1[A[14:2]],DM0[A[14:2]]});
					da <= {A[31:2],2'b0};
					dw <= {WD[15:0],DM1[A[14:2]],DM0[A[14:2]]};
				end
				4'b0011:begin
					DM1[A[14:2]] <= WD[15:8];
					DM0[A[14:2]] <= WD[7:0];
					$display("%d@%h: *%h <= %h",$time,PC_M,{A[31:2],2'b0},{DM3[A[14:2]],DM2[A[14:2]],WD[15:0]});
					da <= {A[31:2],2'b0};
					dw <= {DM3[A[14:2]],DM2[A[14:2]],WD[15:0]};
				end
				4'b1000:begin
					DM3[A[14:2]] <= WD[7:0];
					$display("%d@%h: *%h <= %h",$time,PC_M,{A[31:2],2'b0},{WD[7:0],DM2[A[14:2]],DM1[A[14:2]],DM0[A[14:2]]});
					da <= {A[31:2],2'b0};
					dw <= {WD[7:0],DM2[A[14:2]],DM1[A[14:2]],DM0[A[14:2]]};
				end
				4'b0100:begin
					DM2[A[14:2]] <= WD[7:0];
					$display("%d@%h: *%h <= %h",$time,PC_M,{A[31:2],2'b0},{DM3[A[14:2]],WD[7:0],DM1[A[14:2]],DM0[A[14:2]]});
					da <= {A[31:2],2'b0};
					dw <= {DM3[A[14:2]],WD[7:0],DM1[A[14:2]],DM0[A[14:2]]};
				end
				4'b0010:begin
					DM1[A[14:2]] <= WD[7:0];
					$display("%d@%h: *%h <= %h",$time,PC_M,{A[31:2],2'b0},{DM3[A[14:2]],DM2[A[14:2]],WD[7:0],DM0[A[14:2]]});
					da <= {A[31:2],2'b0};
					dw <= {DM3[A[14:2]],DM2[A[14:2]],WD[7:0],DM0[A[14:2]]};
				end
				4'b0001:begin
					DM0[A[14:2]] <= WD[7:0];
					$display("%d@%h: *%h <= %h",$time,PC_M,{A[31:2],2'b0},{DM3[A[14:2]],DM2[A[14:2]],DM1[A[14:2]],WD[7:0]});
					da <= {A[31:2],2'b0};
					dw <= {DM3[A[14:2]],DM2[A[14:2]],DM1[A[14:2]],WD[7:0]};
				end
				default:begin
					DM3[A[14:2]] <= DM3[A[14:2]];
					DM2[A[14:2]] <= DM2[A[14:2]];
					DM1[A[14:2]] <= DM1[A[14:2]];
					DM0[A[14:2]] <= DM0[A[14:2]];
				end
				endcase
			end
		end
	 end

endmodule
