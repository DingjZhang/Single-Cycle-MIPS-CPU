`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:01 04/23/2016 
// Design Name: 
// Module Name:    control_unit 
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
module control_unit(
	input [5:0]op,
	output reg MemtoReg,
	output reg MemWrite,
	output reg Branch,
	output reg ALUSrc,
	output reg RegDst,
	output reg RegWrite,
	output reg jump,
	output reg [1:0]ALUOp
);

always @ (*)
begin
	case(op)
		//addi
		6'b001000:
		begin
			MemtoReg <= 0;
			MemWrite <= 0;
			Branch <= 0;
			ALUSrc <= 1;
			RegDst <= 0;
			RegWrite <= 1;
			jump <= 0;
			ALUOp <= 2'b01;
		end
		//add
		6'b000000:
		begin
			MemtoReg <= 0;
			MemWrite <= 0;
			Branch <= 0;
			ALUSrc <= 0;
			RegDst <= 1;
			RegWrite <= 1;
			jump <= 0;
			ALUOp <= 2'b01;
		end
		//lw
		6'b100011:
		begin
			MemtoReg <= 1;
			MemWrite <= 0;
			Branch <= 0;
			ALUSrc <= 1;
			RegDst <= 0;
			RegWrite <= 1;
			jump <= 0;
			ALUOp <= 2'b01;
		end
		//sw
		6'b101011:
		begin
			MemtoReg <= 0;
			MemWrite <= 1;
			Branch <= 0;
			ALUSrc <= 1;
			RegDst <= 1;
			RegWrite <= 0;
			jump <= 0;
			ALUOp <= 2'b01;
		end
		//bgtz
		6'b000111:
		begin
			MemtoReg <= 0;
			MemWrite <= 0;
			Branch <= 1;
			ALUSrc <= 0;
			RegDst <= 1;
			RegWrite <= 0;
			jump <= 0;
			ALUOp <= 2'b01;
		end
		//j
		6'b000010:
		begin
			MemtoReg <= 0;
			MemWrite <= 0;
			Branch <= 1;
			ALUSrc <= 0;
			RegDst <= 1;
			RegWrite <= 0;
			jump <= 1;
			ALUOp <= 2'b01;
		end
		default:
		begin
			MemtoReg <= 0;
			MemWrite <= 0;
			Branch <= 0;
			ALUSrc <= 0;
			RegDst <= 0;
			RegWrite <= 0;
			jump <= 0;
			ALUOp <= 2'b00;
		end
	endcase
end


endmodule
