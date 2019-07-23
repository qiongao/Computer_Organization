`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:38 12/13/2017 
// Design Name: 
// Module Name:    ID_MUX 
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
module ID_MUX(
	 input [1:0] ForwardRSD,
	 input [1:0] ForwardRTD,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] Data1,
	 input [31:0] Data2,
	 input [31:0] ALUout_M,
	 output [31:0] D1,
	 output [31:0] D2
    );

	 assign D1 = 
		(ForwardRSD === 2'b00)?Data1:
		(ForwardRSD === 2'b01)?ALUout_M:
		(ForwardRSD === 2'b10)?result_W:
		(ForwardRSD === 2'b11)?result_WD:0;
		
	 assign D2 = 
		(ForwardRTD === 2'b00)?Data2:
		(ForwardRTD === 2'b01)?ALUout_M:
		(ForwardRTD === 2'b10)?result_W:
		(ForwardRTD === 2'b11)?result_WD:0;


endmodule
