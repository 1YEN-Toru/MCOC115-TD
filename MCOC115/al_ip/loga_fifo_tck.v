/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** TD version	:	4.6.18154
\************************************************************/

`timescale 1ns / 1ps

module loga_fifo_tck (
	rst,
	di, clk, we,
	do, re,
	empty_flag,
	full_flag 
);

	input rst;
	input [15:0] di;
	input clk, we;
	input re;

	output [15:0] do;
	output empty_flag;
	output full_flag;

EG_LOGIC_FIFO #(
 	.DATA_WIDTH_W(16),
	.DATA_WIDTH_R(16),
	.DATA_DEPTH_W(2048),
	.DATA_DEPTH_R(2048),
	.ENDIAN("BIG"),
	.RESETMODE("SYNC"),
	.E(0),
	.F(2048),
	.ASYNC_RESET_RELEASE("SYNC"))
logic_fifo(
	.rst(rst),
	.di(di),
	.clkw(clk),
	.we(we),
	.csw(3'b111),
	.do(do),
	.clkr(clk),
	.re(re),
	.csr(3'b111),
	.ore(1'b0),
	.empty_flag(empty_flag),
	.aempty_flag(),
	.full_flag(full_flag),
	.afull_flag()

);

endmodule
