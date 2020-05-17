// *********************************************************************************
// Project Name : test_io
// Email        : weihong_Yan@sjtu.edu.cn
// Website      : https://github.com/whkkkkkkc
// Create Time  : 201// 
// File Name    : .v
// Module Name  : 
// Abstract     :
// editor		: sublime text 3
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 2019/11/12    Vayhoon           1.0                     Original
//  
// *********************************************************************************
//`timescale      1ns/1ns
`timescale      1ns/1ps
interface alu_io(input bit clock);
	parameter data_width = 32;
	parameter op_width = 3;
	logic reset;
	logic [data_width-1:0] data_1,data_2;
	logic [op_width-1:0] op;
	logic [op_width-1:0] sel;
	logic arith,shift;
	logic [data_width-1:0] data_out;
//clocking block except reset signal	
	clocking cb @(posedge clock);
		default input #1 output #1;
		output data_1;
		output data_2;
		output op;
		output sel;
		output arith;
		output shift;
		input data_out;
	endclocking

	modport TB(clocking cb, output reset);
endinterface