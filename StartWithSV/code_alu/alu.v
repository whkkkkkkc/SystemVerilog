`timescale 1ns / 1ps
`include "define.v"
//******************************************************************

// Author:
// Date: 2019/10/26
// Version: v1.0
// Module Name: alu_dut
// Project Name: SystemVerilog Lab1

//*******************************************************************
module alu_dut(
    clock,reset_n,aluin1,aluin2,operation,opselect,enable_arith,enable_shift,aluout
);

input           clock,reset_n,enable_arith,enable_shift;//reset_n低电平复位
input   [31:0]   aluin1;
input   [31:0]   aluin2;
input   [2:0]    operation;
input   [2:0]    opselect;
output  [31:0]   aluout;
//**********************Please add your code below ******************S



//========================================================================\
// =========== Define Parameter and Internal signals =========== 
//========================================================================/
wire	[31:0]	aluout_arith,aluout_shift;
reg		mux_ctrl;
//=============================================================================
//****************************     Main Code    *******************************
//=============================================================================
//produce mux signal to choose the correct output
always @(posedge clock or posedge reset_n) begin
	if (reset_n) begin
		mux_ctrl	<=	1'b0;		
	end
	else begin
		mux_ctrl	<=	enable_arith;
	end
end
assign aluout = mux_ctrl?aluout_arith:aluout_shift;
//instance arith alu module
arith_alu ARITH_ALU(	.clock(clock),
						.reset(reset_n),
						.enable(enable_arith),
						.aluin1(aluin1),
						.aluin2(aluin2),
						.aluopselect(opselect),
						.aluoperation(operation),
						.aluout(aluout_arith));
//instance shift alu module
shift_alu SHIFT_ALU(	.clock(clock),
						.reset(reset_n),
						.enable(enable_shift),
						.in(aluin1),
						.shift_operation(opselect),
						.shift(operation),
						.aluout(aluout_shift));



endmodule