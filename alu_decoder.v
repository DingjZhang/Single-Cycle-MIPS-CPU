`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:11 04/23/2016 
// Design Name: 
// Module Name:    alu_decoder 
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
module alu_decoder(
	input [1:0]ALUOp,
	output reg [4:0]ALUControl
);

	always @ (*)
	begin
		if(ALUOp == 2'b01)
		begin
			ALUControl = 5'h1;
		end
		else
		begin
			ALUControl = 5'h0;
		end
	end


endmodule
