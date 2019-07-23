`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:04:23 12/13/2017 
// Design Name: 
// Module Name:    Controller 
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
`define CAL_R instr[31:26] === 6'b00000
`define ADD instr[31:26] === 6'b000000 && instr[5:0] === 6'b100000
`define ADDU instr[31:26] === 6'b000000 && instr[5:0] === 6'b100001
`define SUB instr[31:26] === 6'b000000 && instr[5:0] === 6'b100010
`define SUBU instr[31:26] === 6'b000000 && instr[5:0] === 6'b100011
`define AND instr[31:26] === 6'b000000 && instr[5:0] === 6'b100100
`define OR instr[31:26] === 6'b000000 && instr[5:0] === 6'b100101
`define XOR instr[31:26] === 6'b000000 && instr[5:0] === 6'b100110
`define NOR instr[31:26] === 6'b000000 && instr[5:0] === 6'b100111
`define SLL instr[31:26] === 6'b000000 && instr[5:0] === 6'b000000
`define SLLV instr[31:26] === 6'b000000 && instr[5:0] === 6'b000100
`define SRA instr[31:26] === 6'b000000 && instr[5:0] === 6'b000011
`define SRAV instr[31:26] === 6'b000000 && instr[5:0] === 6'b000111
`define SRL instr[31:26] === 6'b000000 && instr[5:0] === 6'b000010
`define SRLV instr[31:26] === 6'b000000 && instr[5:0] === 6'b000110
`define SLT instr[31:26] === 6'b000000 && instr[5:0] === 6'b101010
`define SLTU instr[31:26] === 6'b000000 && instr[5:0] === 6'b101011
`define MFLO instr[31:26] === 6'b000000 && instr[5:0] === 6'b010010
`define MFHI instr[31:26] === 6'b000000 && instr[5:0] === 6'b010000
`define MTHI instr[31:26] === 6'b000000 && instr[5:0] === 6'b010001
`define MTLO instr[31:26] === 6'b000000 && instr[5:0] === 6'b010011
`define MULT instr[31:26] === 6'b000000 && instr[5:0] === 6'b011000
`define MULTU instr[31:26] === 6'b000000 && instr[5:0] === 6'b011001
`define DIV instr[31:26] === 6'b000000 && instr[5:0] === 6'b011010
`define DIVU instr[31:26] === 6'b000000 && instr[5:0] === 6'b011011
`define LB instr[31:26] === 6'b100000
`define LBU instr[31:26] === 6'b100100
`define LH instr[31:26] === 6'b100001
`define LHU instr[31:26] === 6'b100101
`define LW instr[31:26] === 6'b100011
`define SB instr[31:26] === 6'b101000
`define SH instr[31:26] === 6'b101001
`define SW instr[31:26] === 6'b101011
`define ORI instr[31:26] === 6'b001101
`define ADDI instr[31:26] === 6'b001000
`define ADDIU instr[31:26] === 6'b001001
`define ANDI instr[31:26] === 6'b001100
`define LUI instr[31:26] === 6'b001111
`define XORI instr[31:26] === 6'b001110
`define SLTI instr[31:26] === 6'b001010
`define SLTIU instr[31:26] === 6'b001011
`define BEQ instr[31:26] === 6'b000100
`define BNE instr[31:26] === 6'b000101
`define BLEZ instr[31:26] === 6'b000110
`define BGTZ instr[31:26] === 6'b000111
`define BLTZ instr[31:26] === 6'b000001 && instr[20:16] === 5'b00000
`define BGEZ instr[31:26] === 6'b000001 && instr[20:16] === 5'b00001
`define JR instr[31:26] === 6'b000000 && instr[5:0] === 6'b001000
`define JALR instr[31:26] === 6'b000000 && instr[5:0] === 6'b001001
`define J instr[31:26] === 6'b000010
`define JAL instr[31:26] === 6'b000011
`define NOP instr === 32'b0

module controller_D(
	 input [31:0] instr,
	 output [1:0] ExtOp,
	 output [1:0] nPC_Sel,
	 output [2:0] CMPOp
    );

	 assign ExtOp = (`BEQ || `BNE || `BLEZ || `BGTZ || `BLTZ || `BGEZ)?3:
						 (`LB || `LBU || `LH || `LHU  || `LW || `SB || `SH || `SW || `ADDI || `ADDIU || `SLTI || `SLTIU)?2:
						 (`LUI)?1:0;
	 assign nPC_Sel = (`JR || `JALR)?3:
							(`J || `JAL)?2:
							(`BEQ || `BNE || `BLEZ || `BGTZ || `BLTZ || `BGEZ)?1:0;
							
	 assign CMPOp = (`BGEZ)?5:
						 (`BLTZ)?4:
						 (`BGTZ)?3:
						 (`BLEZ)?2:
						 (`BNE)?1:0;

endmodule
