/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** TD version	:	4.6.18154
\************************************************************/

`timescale 1ns / 1ps

module hfpu_dsp11 ( p, a, b );

	output [21:0] p;

	input  [10:0] a;
	input  [10:0] b;



	EG_LOGIC_MULT #( .INPUT_WIDTH_A(11),
				.INPUT_WIDTH_B(11),
				.OUTPUT_WIDTH(22),
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
