/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** TD version	:	5.0.27252
\************************************************************/

`timescale 1ns / 1ps

module sfpu_dsp24 ( p, a, b );

	output [47:0] p;

	input  [23:0] a;
	input  [23:0] b;



	EG_LOGIC_MULT #( .INPUT_WIDTH_A(24),
				.INPUT_WIDTH_B(24),
				.OUTPUT_WIDTH(48),
				.INPUTFORMAT("UNSIGNED"),
				.INPUTREGA("DISABLE"),
				.INPUTREGB("DISABLE"),
				.OUTPUTREG("DISABLE"),
				.IMPLEMENT("AUTO")
			)
			inst(
				.a(a),
				.b(b),
				.p(p),
				.cea(1'b0),
				.ceb(1'b0),
				.cepd(1'b0),
				.clk(1'b0),
				.rstan(1'b0),
				.rstbn(1'b0),
				.rstpdn(1'b0)
			);


endmodule