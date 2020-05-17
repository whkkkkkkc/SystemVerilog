// *********************************************************************************
// Project Name : ALU
// Email        : weihong_Yan@sjtu.edu.cn
// Website      : 
// Create Time  : 201// 
// File Name    : .v
// Module Name  : 
// Abstract     :
// editor		: sublime text 3
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 201//    Vayhoon           1.0                     Original
//  
// *********************************************************************************
`timescale      1ns/1ps
`include "define.v"

module  shift_alu(
	//system signals
	input		wire	clock,reset,enable		, 
	input		wire	signed     [31:0]	in		,
	input 		wire	[2:0]	shift			,
	input		wire 	[2:0]	shift_operation	,	
	//output
	output 		wire	signed   [31:0]	aluout
);
//========================================================================\
// =========== Define Parameter and Internal signals =========== 
//========================================================================/
reg	signed	[31:0]	out_reg;
wire    signed  [39:0]  in_prefix;
assign aluout =	out_reg;
//expand the sign bit to help do the shift right operation below
assign in_prefix = in[31]?{8'hff,in}:{8'b0,in};
//=============================================================================
//****************************     Main Code    *******************************
//=============================================================================
//choose the operation depends on size signal
always @(posedge clock or posedge reset) begin
                	if (reset) begin
                		// reset
                		out_reg	<=	32'b0;
                	end
                	else if (enable) begin
                		case (shift_operation) 
                		    `SHLEFTLOG:
                		        out_reg	<=	in<<shift    ;
                		    `SHLEFTART:
                		        out_reg	<=	in<<shift    ;
                		    `SHRGHTLOG:
                		    	out_reg	<=	in>>shift    ;
                		    `SHRGHTART:
                		    	out_reg	<=	in_prefix>>shift;
                		    default:
                		        out_reg	<=	in    ;
                		endcase
                	end
                        else
                                out_reg <= out_reg;
                end                
endmodule