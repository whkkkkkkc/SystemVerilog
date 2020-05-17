// *********************************************************************************
// Project Name : test_top
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
// 201//    Vayhoon           1.0                     Original
//  
// *********************************************************************************
//`timescale      1ns/1ns
`timescale      1ns/1ps
module alu_test_top;
	parameter clock_cycle = 10;
//clock siganl
	reg tb_clk;
	alu_io top_io(tb_clk);
	alu_test test(top_io);
	alu_dut ALU_DUT(
		            .clock(top_io.clock),
		            .reset_n(top_io.reset),
		            .aluin1(top_io.data_1),
		            .aluin2(top_io.data_2),
		            .operation(top_io.op),
		            .opselect(top_io.sel),
		            .enable_arith(top_io.arith),
		            .enable_shift(top_io.shift),
		            .aluout(top_io.data_out)
		            );
	initial begin
//produce clock
		tb_clk = 0;
		forever begin
			#(clock_cycle/2) tb_clk = ~tb_clk;
		end
	end


endmodule