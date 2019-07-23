`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:27 11/27/2017 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input clk,
    input reset,
    input zero,
	 input b_zero,
	 input [2:0] nPC_Sel,
	 input [25:0] instr_index,
	 input [15:0] immediate,
	 input [31:0] rdata1,
    output [31:0] address, //address of updata pc
	 output [31:0] adder, //address of pc + 4
	 output reg [31:0] P //address of pc before
    );
	 
	 reg [31:0] pc;
	 assign address = pc;
	 assign adder = pc + 32'd4;
	 initial begin
		pc <= 32'h0000_3000;
	 end
	 always@(posedge clk)begin
		if(reset)begin
			pc <= 32'h0000_3000;
		end
		else begin
			P <= pc;
			case(nPC_Sel)
			3'b000 : pc <= pc + 4;
			3'b001 : begin
				if(zero)	begin
					if(immediate[15]===1)begin
						pc <= pc + 4 + {14'b1111_1111_1111_11,immediate,2'b00};
					end
					else	pc <= pc + 4 + {14'b0,immediate,2'b00};
				end
				else pc <= pc + 4;			
			end
			3'b010 : begin
				pc <= {pc[31:28],instr_index,2'b00};	
			end
			3'b011 : pc <= rdata1;
			3'b100 : begin
				if(b_zero)begin
					if(immediate[15]===1)begin
						pc <= pc + 4 + {14'b1111_1111_1111_11,immediate,2'b00};
					end
					else	pc <= pc + 4 + {14'b0,immediate,2'b00};					
				end
				else pc <= pc + 4;
			end
			3'b101 : pc <= {pc[31:28],instr_index,2'b00};
			default:pc <= 32'h0000_3000;
			endcase
		end
	 end
endmodule
