// *********************************************************************************
// Project Name : alu_test
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
`timescale      1ns/1ps
program alu_test(alu_io.TB ALU_execute);
	parameter data_width = 32;

	reg flag;

	int run_n_times;
	initial begin
		run_n_times = 20;
		reset();
		//repeat random operation to test the circuit
		repeat(run_n_times) begin
			reset();
			test_SHLEFTLOG();
			test_SHLEFTART();
			test_SHRGHTLOG();
			test_SHRGHTART();
			//
			test_arith_ADD();
			test_arith_HADD();
			test_arith_SUB();
			test_arith_NOT();
			test_arith_AND();
			test_arith_OR();
			test_arith_XOR();
			test_arith_LHG();
		end
	end
//reset the signal
	task reset();
		$display("reset start at",$time);
		ALU_execute.reset <= 1'b1;
		ALU_execute.cb.arith <= 1'b0;
		ALU_execute.cb.shift <= 1'b0;
		repeat(5) @(ALU_execute.cb);
		ALU_execute.reset <= 1'b0;
		$display("reset end",$time);
	endtask : reset
//task test shift operation
	//test SHLEFTLOG operation
	task test_SHLEFTLOG();
		$display("test_SHLEFTLOG start",$time);
		ALU_execute.cb.shift <= 1'b1;
		ALU_execute.cb.arith <= 1'b0;
		ALU_execute.cb.op <= $random;
		ALU_execute.cb.sel<= 3'b000;
		ALU_execute.cb.data_1<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==ALU_execute.cb.data_1<<ALU_execute.cb.op)
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_SHLEFTLOG end",$time);
	endtask: test_SHLEFTLOG
	//test SHLEFTART operation
	task test_SHLEFTART();
		$display("test_SHLEFTART start",$time);
		ALU_execute.cb.shift <= 1'b1;
		ALU_execute.cb.arith <= 1'b0;
		ALU_execute.cb.op <= $random;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==ALU_execute.cb.data_1<<ALU_execute.cb.op)
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_SHLEFTART end",$time);
	endtask: test_SHLEFTART
	//test SHRGHTLOG operation
	task test_SHRGHTLOG();
		$display("test_SHRGHTLOG start",$time);
		ALU_execute.cb.shift <= 1'b1;
		ALU_execute.cb.arith <= 1'b0;
		ALU_execute.cb.op <= $random;
		ALU_execute.cb.sel<= 3'b010;
		ALU_execute.cb.data_1<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==ALU_execute.cb.data_1>>ALU_execute.cb.op)
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_SHRGHTLOG end",$time);
	endtask: test_SHRGHTLOG
	//test SHRGHTART operation
	task test_SHRGHTART();
		$display("test_SHRGHTART start",$time);
		ALU_execute.cb.shift <= 1'b1;
		ALU_execute.cb.arith <= 1'b0;
		ALU_execute.cb.op <= 3'b010;
		ALU_execute.cb.sel<= 3'b011;
		ALU_execute.cb.data_1<= 32'hffffffff;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==32'hffffffff)
			flag <= 1'b0;
		else
			flag <= 1'b1;	
		$display("test_SHRGHTART end",$time);	
	endtask : test_SHRGHTART


//task test arith operation
	//tesy ADD operation
	task test_arith_ADD();
		$display("test_ADD start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b000;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==ALU_execute.cb.data_1+ALU_execute.cb.data_2)
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_ADD end",$time);
	endtask : test_arith_ADD
	//test HADD operation
	reg [15:0]temp;
	task test_arith_HADD();
		$display("test_HADD start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b001;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		temp <= ALU_execute.cb.data_1[15:0]+ALU_execute.cb.data_2[15:0];
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==temp)
			flag <= 1'b0;
		else
			flag <= 1'b1;		
		$display("test_HADD end",$time);
	endtask : test_arith_HADD
	//test SUB operation
	task test_arith_SUB();
		$display("test_SUB start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b010;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==ALU_execute.cb.data_1-ALU_execute.cb.data_2)
			flag <= 1'b0;
		else
			flag <= 1'b1;		
		$display("test_SUB end",$time);
	endtask : test_arith_SUB
	//test NOT operation
	task test_arith_NOT();
		$display("test_NOT start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b011;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out== ~ALU_execute.cb.data_2)
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_NOT end",$time);
	endtask : test_arith_NOT
	//test AND operation
	task test_arith_AND();
		$display("test_AND start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b100;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==(ALU_execute.cb.data_1&ALU_execute.cb.data_2))
			flag <= 1'b0;
		else
			flag <= 1'b1;

		$display("test_AND end",$time);
	endtask : test_arith_AND
	//test OR operation
	task test_arith_OR();
		$display("test_OR start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b101;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==ALU_execute.cb.data_1|ALU_execute.cb.data_2)
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_OR end",$time);
	endtask : test_arith_OR
	//test XOR operation
	task test_arith_XOR();
		$display("test_XOR start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b110;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out==ALU_execute.cb.data_1^ALU_execute.cb.data_2)
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_XOR end",$time);
	endtask : test_arith_XOR
	//test LHG operation
	task test_arith_LHG();
		$display("test_LHG start",$time);
		ALU_execute.cb.arith <= 1'b1;
		ALU_execute.cb.shift <= 1'b0;
		ALU_execute.cb.op <= 3'b111;
		ALU_execute.cb.sel<= 3'b001;
		ALU_execute.cb.data_1<= $random;
		ALU_execute.cb.data_2<= $random;
		repeat(2) @(ALU_execute.cb);
		if(ALU_execute.cb.data_out=={ALU_execute.cb.data_2[15:0],16'b0})
			flag <= 1'b0;
		else
			flag <= 1'b1;
		$display("test_LHG end",$time);
	endtask : test_arith_LHG

endprogram