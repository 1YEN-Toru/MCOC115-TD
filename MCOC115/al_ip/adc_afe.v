/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** TD version	:	4.6.18154
\************************************************************/

`timescale 1ns / 1ps

module adc_afe ( eoc, dout, clk, pd, s, soc );
	output 		 eoc;
	output  		[11:0] dout;

	input  		clk;
	input  		pd;
	input  		[2:0] s;
	input  		soc;

	EG_PHY_ADC #(
		.CH3("ENABLE"),
		.CH2("ENABLE"),
		.CH1("ENABLE"),
		.CH0("ENABLE"))
		adc (
		.clk(clk),
		.pd(pd),
		.s(s),
		.soc(soc),
		.eoc(eoc),
		.dout(dout));

endmodule
