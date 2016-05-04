`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:22 04/23/2016 
// Design Name: 
// Module Name:    mux 
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
module mux(
	input [31:0]mux_a,
	input [31:0]mux_b,
	output reg [31:0]mux_out,
	input select
);

always @ (*)
begin
	case(select)
		0: mux_out = mux_a;
		1: mux_out = mux_b;
		default: mux_out = 32'b0;
	endcase
	
end


endmodule
