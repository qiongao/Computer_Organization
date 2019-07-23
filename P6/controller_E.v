`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:27 12/13/2017 
// Design Name: 
// Module Name:    controller_E 
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

module controller_E(
	 input [31:0] instr,
	 output start,
	 output ALUSrc,
	 output RegWrite,
	 output [1:0] RegDst,
	 output [1:0] Mem2Reg,
	 output [3:0] MDOp,
	 output [3:0] ALUOp
    );
	 
	 assign start = (`MULT || `MULTU || `DIV || `DIVU)?1:0;
	 assign ALUSrc = (`LB || `LBU || `LH || `LHU || `LW || `SB || `SH || `SW || `ORI || `ADDI || `ADDIU || `ANDI || 
							`LUI || `XORI || `SLTI || `SLTIU)?1:0;
							
	 assign RegWrite = (~(`NOP) && (`ADD || `ADDU || `SUB || `SUBU || `AND || `OR || `XOR || `NOR || `SLL || `SLLV || `SRA || 
								`SRAV || `SRL || `SRLV || `SLT || `SLTU || `MFLO || `MFHI || `LB || `LBU || `LH || `LHU || 
								`LW || `JALR || `JAL || `ORI || `ADDI || `ADDIU || `ANDI || `LUI || `XORI ||`SLTI || `SLTIU))?1:0;
								
	 assign RegDst = (`JAL)?2:
						  (`ADD || `ADDU || `SUB || `SUBU || `AND || `OR || `XOR || `NOR || `SLL || `SLLV || `SRA || 
								`SRAV || `SRL || `SRLV || `SLT || `SLTU || `MFLO || `MFHI || `JALR)?1:0;
	 assign Mem2Reg = (`MFLO || `MFHI)?3:
							(`JALR || `JAL)?2:
							(`LB || `LBU || `LH || `LHU || `LW)?1:0;
							
	 assign MDOp = (`MTLO)?8:
						(`MTHI)?7:
						(`MFHI)?6:
						(`MFLO)?5:
						(`DIV)?4:
						(`DIVU)?3:
						(`MULT)?2: 
						(`MULTU)?1:0;
							
	 assign ALUOp = (`SLTU || `SLTIU)?14:
						 (`SLT || `SLTI)?13:
						 (`SRLV)?12:
						 (`SRL)?11:
						 (`SRAV)?10:
						 (`SRA)?9:
						 (`SLLV)?8:
						 (`SLL)?7:
						 (`NOR)?6:
						 (`XOR || `XORI)?5:
						 (`AND || `ANDI)?4:
						 (`LUI)?3:
						 (`OR || `ORI)?2:
						 (`SUB || `SUBU)?1:0;
	  

endmodule
