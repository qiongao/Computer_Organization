`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:24 12/20/2017 
// Design Name: 
// Module Name:    MUL_DIV 
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
module MUL_DIV(
	 input clk,
	 input reset,
	 input start,
	 input [3:0] MDOp,
	 input [31:0] D1,
	 input [31:0] D2,
	 output Busy,
	 output [31:0] MDout
    );
	 
	 integer cm = 0;//count_mul = 0;
	 integer cmu = 0;//count_mulu = 0;
	 integer cd = 0;//count_div = 0;
	 integer cdu = 0;//count_divu = 0;
	 reg b;
	 reg [31:0] out;
	 reg [31:0] HI,LO;
	 reg [31:0] h,l;
	 
	 initial begin
		HI <= 0;
		LO <= 0;
		b <= 0;
		out <= 0;
		h <= 0;
		l <= 0;
	 end
	 
	 assign Busy = b;
	 assign MDout = (MDOp===5)?LO:
						 (MDOp===6)?HI:0;
	 always@(posedge clk)begin	//1
		if(reset)begin	//1.1
			HI <= 0;
			LO <= 0;
			b <= 0;
		end	//1.1
		else begin	//1.2
			case(MDOp)
			1:begin	//1.2.1
				cmu <= 1;
				b <= 1;
				{h,l} <= D1 * D2;
			end	//1.2.1
			2:begin	//1.2.2
				cm <= 1;
				b <= 1;
				{h,l} <= $signed(D1) * $signed(D2);
			end	//1.2.2
			3:begin	//1.2.3
				cd <= 1;
				b <= 1;
				h <= D1 % D2;
				l <= D1 / D2;				
			end	//1.2.3
			4:begin	//1.2.4
				cdu <= 1;
				b <= 1;
				h <= $signed(D1) % $signed(D2);
				l <= $signed(D1) / $signed(D2);				
			end	//1.2.4
			//5:out <= LO;
			//6:out <= HI;
			7:HI <= D1;
			8:LO <= D1;
			endcase
			
			if(cmu === 5)begin
				b <= 0;
				//{HI,LO} <= D1 * D2;
				HI <= h;
				LO <= l;
				cmu <= 0;
			end
			else if(cmu != 0)begin
				cmu <= cmu + 1;
				b <= 1;
			end
			
			if(cm === 5)begin
				b <= 0;
				//{HI,LO} <= $signed(D1) * $signed(D2);
				HI <= h;
				LO <= l;
				cm <= 0;
			end
			else if(cm != 0)begin
				cm <= cm + 1;
				b <= 1;
			end
			
			if(cd === 10)begin
				b <= 0;
				//HI <= D1 % D2;
				//LO <= D1 / D2;
				HI <= h;
				LO <= l;
				cd <= 0;
			end
			else if(cd != 0)begin
				cd <= cd + 1;
				b <= 1;
			end
			
			if(cdu === 10)begin
				b <= 0;
				//HI <= $signed(D1) % $signed(D2);
				//LO <= $signed(D1) / $signed(D2);
				HI <= h;
				LO <= l;
				cdu <= 0;
			end
			else if(cdu != 0)begin
				cdu <= cdu + 1;
				b <= 1;
			end
			
		end	//1.2
	 end	//1
endmodule
