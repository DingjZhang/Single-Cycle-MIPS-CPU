`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:55 04/23/2016 
// Design Name: 
// Module Name:    sign_extend 
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
module sign_extend(
	input [15:0]si_in,
	output reg [31:0]si_out
);
always @ (*)
begin
	if(si_in[15] == 1'b0)
	begin
		si_out = {16'b0, si_in};
	end
	else
	begin
		si_out = {16'hffff, si_in};
	end
end

endmodule
