`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:19:30 04/23/2016 
// Design Name: 
// Module Name:    top 
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
//////////////////////////////////////////////////////////////////////////////////


module top(
	input clk,
	input rst_n
);

//mux_pc
wire [31:0]mux_a_pc;
wire [31:0]mux_b_pc;
wire select_pc;
wire [31:0]mux_out_pc;
mux mux_pc(
.mux_a(mux_a_pc),
.mux_b(mux_b_pc),
.select(select_pc),
.mux_out(mux_out_pc)
);
assign mux_b_pc = alu_out_shi;
assign mux_a_pc = alu_out_Imm;
assign select_pc = and_out;


//pc
wire [4:0]next_addr;
wire [4:0]addr;
PC pc(
	.clk(clk),
	.next_addr(next_addr),
	.addr(addr)
);
assign next_addr = mux_out_j[4:0];

//instruction_mem
wire [4:0]a_IR;
wire [31:0]IR_data;
wire [31:0]instruction;
instruction_mem IR(
	.a(a_IR),
	.d(IR_data),
	.clk(clk),
	.we(1'd1),
	.spo(instruction)
);
assign a_IR = addr;

wire [4:0]a1;
wire [4:0]a2;
wire [4:0]a3;
wire [31:0]wd3;
wire we3;
wire [31:0]rd1;
wire [31:0]rd2;
//reg_file
reg_file reg_file1(
	.clk(clk),
	.rst_n(rst_n),
	.r1_addr(a1),
	.r2_addr(a2),
	.r3_addr(a3),
	.r3_din(wd3),
	.r1_dout(rd1),
	.r2_dout(rd2),
	.r3_wr(we3)
);
assign a1 = instruction[25:21];
assign a2 = instruction[20:16];
assign a3 = mux_out_reg[4:0];
assign wd3 = mux_out_dm;
assign we3 = RegWrite;

//mux_alu
wire [31:0]mux_a_alu;
wire [31:0]mux_b_alu;
wire select_alu;
wire [31:0]mux_out_alu;
mux mux_alu(
	.mux_a(mux_a_alu),
	.mux_b(mux_b_alu),
	.select(select_alu),
	.mux_out(mux_out_alu)
);
assign mux_a_alu = rd2;
assign mux_b_alu = si_out;
assign select_alu = ALUSrc;

//alu
wire signed [31:0]alu_a;
wire signed [31:0]alu_b;
wire Zero;
wire [4:0]ALUControl;
wire [31:0]ALUResult;
alu alu_IR_dataMem(
	.alu_a(alu_a),
	.alu_b(alu_b),
	.alu_op(ALUControl),
	.alu_out(ALUResult),
	.Zero(Zero)
);
assign alu_a = rd1;
assign alu_b = mux_out_alu;
assign ALUControl = alu_control;

//data_mem
wire [31:0]rd;
wire [4:0]a;
wire [31:0]wd;
wire we_data;
data_mem dataMem(
	.a(a),
	.d(wd),
	.clk(clk),
	.we(we_data),
	.spo(rd)
);
assign a = ALUResult[4:0];
assign wd = rd2;
assign we_data = MemWrite;

//mux
wire [31:0]mux_a_dm;
wire [31:0]mux_b_dm;
wire [31:0]mux_out_dm;
wire select_dm;

mux mux_dataMem(
	.mux_a(mux_a_dm),
	.mux_b(mux_b_dm),
	.select(select_dm),
	.mux_out(mux_out_dm)
);
assign mux_a_dm = ALUResult;
assign mux_b_dm = rd;
assign select_dm = MemtoReg;

//mux
wire [31:0]mux_a_reg;
wire [31:0]mux_b_reg;
wire [31:0]mux_out_reg;
wire select_reg;
mux mux_reg_file(
	.mux_a(mux_a_reg),
	.mux_b(mux_b_reg),
	.select(select_reg),
	.mux_out(mux_out_reg)
);
assign mux_a_reg = {27'b0, instruction[20:16]};
assign mux_b_reg = {27'b0, instruction[15:11]};
assign select_reg = RegDst;

//sign_extend
wire [15:0]si_in;
wire [31:0]si_out;
sign_extend siEx(
	.si_in(si_in),
	.si_out(si_out)
);
assign si_in = instruction[15:0];

/*
//shift
wire [31:0]shift_before;
wire [31:0]shift_after;
shift shifter(
	.shift_before(shift_before),
	.shift_after(shift_after)
);
assign shift_before = si_out;
*/

//adder
wire signed [31:0]alu_a_shi;
wire signed [31:0]alu_b_shi;
wire [31:0]alu_out_shi;
alu_w_z alu_shifter(
	.alu_a(alu_a_shi),
	.alu_b(alu_b_shi),
	.alu_op(5'b1),
	.alu_out(alu_out_shi)
);
assign alu_a_shi = si_out;
assign alu_b_shi = alu_out_Imm;

//control_union
wire [5:0]Op;
wire [1:0]ALUOp;
wire MemtoReg;
wire MemWrite;
wire Branch;
wire ALUSrc;
wire RegDst;
wire RegWrite;
wire jump;
control_unit CU(
	.op(Op),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.Branch(Branch),
	.ALUOp(ALUOp),
	.ALUSrc(ALUSrc),
	.RegDst(RegDst),
	.jump(jump),
	.RegWrite(RegWrite)
);
assign Op = instruction[31:26];

wire [1:0]op_alu;
wire [4:0]alu_control;
//alu_control
alu_decoder Ctrl_alu(
	.ALUOp(op_alu),
	.ALUControl(alu_control)
);
assign op_alu = ALUOp;

//adder
wire signed [31:0]alu_a_Imm;
wire signed [31:0]alu_out_Imm;
alu_w_z alu_Imm(
	.alu_a(alu_a_Imm),
	.alu_b(32'b1),
	.alu_op(5'b1),
	.alu_out(alu_out_Imm)
);
assign alu_a_Imm = addr;

wire and_a;
wire and_b;
wire and_out;
and_gate gate(
	.and_a(and_a),
	.and_b(and_b),
	.and_out(and_out)
);
assign and_a = Branch;
assign and_b = Zero;

wire [31:0]mux_a_j;
wire [31:0]mux_b_j;
wire select_j;
wire [31:0]mux_out_j;
mux mux_j(
	.mux_a(mux_a_j),
	.mux_b(mux_b_j),
	.select(select_j),
	.mux_out(mux_out_j)
);
assign mux_a_j = mux_out_pc;
assign mux_b_j = {6'b0, instruction[25:0]};
assign select_j = jump;

/*
wire [31:0]shi_in;
wire [31:0]shi_out;
shift shifter_2(
	.shift_before(shi_in),
	.shift_after(shi_out)
);
assign shi_in = {6'b0, instruction[25:0]};
*/
endmodule


