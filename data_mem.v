`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:12 05/03/2016 
// Design Name: 
// Module Name:    data_mem 
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
module data_mem(
	input [4:0]a,
	input [31:0]d,
	input we,
	input clk,
	output [31:0]spo
);

reg [31:0]data_reg[31:0];

integer i;

initial 
begin
	for(i = 0; i < 32; i = i + 1)
	begin
		if(i < 2)
		begin
			data_reg[i] = 32'd3;
		end
		else if(i == 20)
		begin
			data_reg[i] = 32'd20;
		end
		else
		begin
			data_reg[i] = 32'd0;
		end
	end
end

assign spo = data_reg[a]; 

always @ (posedge clk)
begin
	if(we)
	begin
		data_reg[a] = d;
	end
	else
	begin
		data_reg[a] = data_reg[a];
	end
end


endmodule
