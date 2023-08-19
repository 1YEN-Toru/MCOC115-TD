// Verilog netlist created by TD v4.6.18154

`timescale 1ns / 1ps
module hfpu_dsp11  // al_ip/hfpu_dsp11.v(14)
  (
  a,
  b,
  p
  );

  input [10:0] a;  // al_ip/hfpu_dsp11.v(18)
  input [10:0] b;  // al_ip/hfpu_dsp11.v(19)
  output [21:0] p;  // al_ip/hfpu_dsp11.v(16)


  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("0"))
    inst_ (
    .a({7'b0000000,a}),
    .b({7'b0000000,b}),
    .p({open_n130,open_n131,open_n132,open_n133,open_n134,open_n135,open_n136,open_n137,open_n138,open_n139,open_n140,open_n141,open_n142,open_n143,p}));

endmodule 

