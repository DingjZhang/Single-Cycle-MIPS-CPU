`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:48:43 04/17/2016 
// Design Name: 
// Module Name:    alu 
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
module alu(
	input signed [31:0]alu_a,
	input signed [31:0]alu_b,
	input [4:0]alu_op,
	output reg [31:0]alu_out,
	output reg Zero
);

parameter A_NOP = 5'h0;
parameter A_ADD = 5'h1;
parameter A_SUB = 5'h2;
parameter A_AND = 5'h3;
parameter A_OR = 5'h4;
parameter A_XOR = 5'h5;
parameter A_NOR = 5'h6;


always @ (*)
begin
	case(alu_op)
		A_NOP: alu_out  = 32'h0;
		A_ADD: 
		begin	
			alu_out = alu_a + alu_b;
			Zero = ((alu_a - alu_b) >= 0) ? 1 : 0;
		end
		A_SUB: alu_out = alu_a - alu_b;
		A_AND: alu_out = alu_a & alu_b;
		A_OR: alu_out = alu_a | alu_b;
		A_XOR: alu_out = alu_a ^ alu_b;
		A_NOR: alu_out = ~(alu_a | alu_b);
		default: alu_out = 32'h0;
	endcase
	
	
end
endmodule
