`timescale 1ns / 1ps

//******************************************************************

// Author:Yan Vayhoon
// Date: 2019/10/26
// Version: v1.0
// Module Name: alu_dut
// Project Name: SystemVerilog Lab1

//*******************************************************************
module  arith_alu (
	//system signals
	input		wire	clock,reset,enable						,
	//
	input		wire	signed 	[31:0]	aluin1,aluin2,
	input		wire	[2:0]	aluopselect,
	input		wire	[2:0]	aluoperation,
	//output
	output		wire	signed 	[31:0]	aluout);
`include "define.v"
//========================================================================\
// =========== Define Parameter and Internal signals =========== 
//========================================================================/
reg		signed 	[31:0]	out_reg;
wire	signed	[31:0]	add_1,add_2,add_result;
//mux data to choose the correct data and send it to adder
assign add_1 = 	(aluoperation==`HADD)?{16'b0,aluin1[15:0]}:aluin1;
assign add_2 = 	(aluoperation==`HADD)?{16'b0,aluin2[15:0]}:
				(aluoperation==`SUB)?(-aluin2):aluin2;
//only use one adder, the result will be chosen by mux
assign add_result = add_1	+	add_2;
assign aluout = out_reg;
//=============================================================================
//****************************     Main Code    *******************************
//=============================================================================
always @(posedge clock or posedge reset) begin
	if (reset) begin
		out_reg	<=	32'b0;
	end
	else if (enable&&(aluopselect==`ARITH_LOGIC)) begin
		case (aluoperation) 
		    `ADD:
		        out_reg	<=	add_result;
		    `HADD:
		        out_reg	<=	{16'b0,add_result[15:0]};
		    `SUB:
		    	out_reg	<=	add_result;
		    `NOT:
		    	out_reg	<=	~aluin2;
		    `AND:
		    	out_reg	<=	aluin1&aluin2;
		    `OR:
		    	out_reg	<=	aluin1|aluin2;
		    `XOR:
		    	out_reg	<=	aluin1^aluin2;
		    `LHG:
		    	out_reg	<=	{aluin2[15:0],16'h0};
		    default:
		    	out_reg	<=	out_reg;
		endcase
	end
end


endmodule