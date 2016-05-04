`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:16 05/03/2016 
// Design Name: 
// Module Name:    instruction_mem 
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
module instruction_mem(
	input [4:0]a,
	input [31:0]d,
	input we,
	input clk,
	output [31:0]spo
);

reg [31:0]ins_reg[31:0];

initial
begin
	ins_reg[0] <= {6'b100011, 5'b0, 5'b1, 16'd20};
	ins_reg[1] <= {6'b100011, 5'b0, 5'd3, 16'd0};
	ins_reg[2] <= {6'b100011, 5'b0, 5'd4, 16'd0};
	ins_reg[3] <= {6'b001000, 5'b1, 5'd1, 16'hfffe};
	ins_reg[4] <= {6'b100011, 5'd6, 5'b00011, 16'd0};
	ins_reg[5] <= {6'b100011, 5'd6, 5'b00100, 16'd1};
	ins_reg[6] <= {6'b000000, 5'b00011, 5'b00100, 5'b00010, 11'b00000100000};
	ins_reg[7] <= {6'b101011, 5'd6, 5'd2, 16'd2};
	ins_reg[8] <= {6'b001000, 5'd6, 5'd6, 16'd1};
	ins_reg[9] <= {6'b001000, 5'd1, 5'd1, 16'hffff};
	ins_reg[10] <= {6'b000111, 5'd1, 5'd0, 16'hfff9};
	ins_reg[11] <= {6'b000010, 26'd11};
end


integer i;

initial
begin
	for(i = 12; i < 32; i = i + 1)
	begin	
		ins_reg[i] <= 32'h0;
	end
end
assign spo = ins_reg[a];
always @ (posedge clk)
begin
	if(~we)
	begin
		ins_reg[a] = d;
	end
	else
	begin
		ins_reg[a] = ins_reg[a];
	end
end
endmodule
