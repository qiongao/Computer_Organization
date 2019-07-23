`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:27:36 12/14/2017 
// Design Name: 
// Module Name:    MEM_MUX 
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
module MEM_MUX(
	 input [1:0] ForwardRTM,
	 input [31:0] result_W,
	 input [31:0] result_WD,
	 input [31:0] WriteData_M,
	 output [31:0] WD
    );
	 
	 assign WD = (ForwardRTM===2'b00)?WriteData_M:
					 (ForwardRTM===2'b01)?result_W:
					 (ForwardRTM===2'b10)?result_WD:32'b0;


endmodule
