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
	 input [2:0] ForwardRSD,
	 input [2:0] ForwardRTD,
	 input [31:0] PC8_E,
	 input [31:0] PC8_M,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] Data1,
	 input [31:0] Data2,
	 input [31:0] ALUout_M,
	 input [31:0] MDout_M,
	 output [31:0] D1,
	 output [31:0] D2
    );

	 assign D1 = 
		(ForwardRSD === 0)?Data1:
		(ForwardRSD === 1)?ALUout_M:
		//(ForwardRSD === 2)?MDout_M:
		(ForwardRSD === 2)?result_W:
		(ForwardRSD === 3)?result_WD:
		(ForwardRSD === 4)?PC8_E:
		(ForwardRSD === 5)?PC8_M:
		(ForwardRSD === 6)?MDout_M:0;
		
	 assign D2 = 
		(ForwardRTD === 0)?Data2:
		(ForwardRTD === 1)?ALUout_M:
		(ForwardRTD === 2)?result_W:
		(ForwardRTD === 3)?result_WD:
		(ForwardRTD === 4)?PC8_E:
		(ForwardRTD === 5)?PC8_M:
		(ForwardRTD === 6)?MDout_M:0;



endmodule
