`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:52:29 11/27/2017 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input [5:0] Op,
    input [5:0] funct,
    output RegA,
	 output ALUSrc,
    output RegWrite,
    output MemWrite,
	 output DM_Sel,
    output [1:0] RegDst,
    output [1:0] Mem2Reg,
    output [1:0] ExtOp,
	 output [2:0] nPC_Sel,
    output [2:0] ALUOp
    );
	 
	 assign RegA = (Op === 6'b000000 && funct === 6'b001000)?1:0;
	 assign ALUSrc = (Op === 6'b001110 || Op === 6'b100001 || Op === 6'b001101 || Op === 6'b100011 || Op === 6'b101011 || Op === 6'b001111)?1:0;
	 assign RegWrite = (Op === 6'b001110 || Op === 6'b100001 || (Op === 6'b000000 && funct === 6'b000110) || (Op === 6'b000000 && funct === 6'b100001) || (Op === 6'b000000 && funct === 6'b100011) || Op === 6'b001101 || Op === 6'b100011 || Op === 6'b001111 || Op === 6'b000011)?1:0;
	 assign MemWrite = (Op === 6'b101011)?1:0;
	 assign DM_Sel = (Op === 6'b100001)?1:0;
	 assign RegDst[1] = (Op === 6'b000011)?1:0;
	 assign RegDst[0] = (Op === 6'b000000)?1:0;
	 assign Mem2Reg[1] = (Op === 6'b000011)?1:0;
	 assign Mem2Reg[0] = (Op === 6'b100001 || Op === 6'b100011)?1:0;
	 assign ExtOp[1] = (Op === 6'b100001 || Op === 6'b000011 || Op === 6'b101011)?1:0;
	 assign ExtOp[0] = (Op === 6'b100001 || Op === 6'b001111 || Op === 6'b101011)?1:0;
	 assign nPC_Sel[2] = (Op === 6'b000010 || Op === 6'b000111)?1:0;
	 assign nPC_Sel[1] = (Op === 6'b000011 || (Op === 6'b000000 && funct === 6'b001000))?1:0;
	 assign nPC_Sel[0] = (Op === 6'b000010 || Op === 6'b000100 || (Op === 6'b000000 && funct === 6'b001000))?1:0;
	 assign ALUOp[2] = (Op === 6'b001110 || (Op === 6'b000000 && funct === 6'b000110) || Op === 6'b000111)?1:0;
	 assign ALUOp[1] = (Op === 6'b001110 || Op === 6'b001101 || Op === 6'b001111)?1:0;
	 assign ALUOp[0] = ((Op === 6'b000000 && funct === 6'b000110) || Op === 6'b000100 || (Op === 6'b000000 && funct === 6'b100011))?1:0;
	 
endmodule
