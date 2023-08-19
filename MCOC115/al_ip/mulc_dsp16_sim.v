// Verilog netlist created by TD v4.6.18154

`timescale 1ns / 1ps
module mulc_dsp16  // al_ip/mulc_dsp16.v(14)
  (
  a,
  b,
  p
  );

  input [16:0] a;  // al_ip/mulc_dsp16.v(18)
  input [16:0] b;  // al_ip/mulc_dsp16.v(19)
  output [33:0] p;  // al_ip/mulc_dsp16.v(16)


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
    .SIGNEDAMUX("1"),
    .SIGNEDBMUX("1"))
    inst_ (
    .a({a[16],a}),
    .b({b[16],b}),
    .p({open_n130,open_n131,p}));

endmodule 

