`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:30 04/23/2016 
// Design Name: 
// Module Name:    PC 
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
//
//////////////////////////////////////////////////////////////////////////////////
module PC(
	input clk,
	output reg [4:0]addr,
	input [4:0]next_addr
);

initial addr = 5'b0;
always @ (posedge clk)
begin
	addr = next_addr;
end


endmodule
