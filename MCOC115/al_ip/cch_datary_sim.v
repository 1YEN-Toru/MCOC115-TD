// Verilog netlist created by TD v4.6.18154

`timescale 1ns / 1ps
module cch_datary  // al_ip/cch_datary.v(14)
  (
  addra,
  addrb,
  cea,
  ceb,
  clka,
  clkb,
  dia,
  dib,
  wea,
  web,
  doa,
  dob
  );

  input [10:0] addra;  // al_ip/cch_datary.v(25)
  input [9:0] addrb;  // al_ip/cch_datary.v(26)
  input cea;  // al_ip/cch_datary.v(29)
  input ceb;  // al_ip/cch_datary.v(30)
  input clka;  // al_ip/cch_datary.v(31)
  input clkb;  // al_ip/cch_datary.v(32)
  input [15:0] dia;  // al_ip/cch_datary.v(23)
  input [31:0] dib;  // al_ip/cch_datary.v(24)
  input [1:0] wea;  // al_ip/cch_datary.v(27)
  input [3:0] web;  // al_ip/cch_datary.v(28)
  output [15:0] doa;  // al_ip/cch_datary.v(19)
  output [31:0] dob;  // al_ip/cch_datary.v(20)

  wire [0:0] addra_piped;
  wire inst_doa_i0_000;
  wire inst_doa_i0_001;
  wire inst_doa_i0_002;
  wire inst_doa_i0_003;
  wire inst_doa_i0_004;
  wire inst_doa_i0_005;
  wire inst_doa_i0_006;
  wire inst_doa_i0_007;
  wire inst_doa_i0_008;
  wire inst_doa_i0_009;
  wire inst_doa_i0_010;
  wire inst_doa_i0_011;
  wire inst_doa_i0_012;
  wire inst_doa_i0_013;
  wire inst_doa_i0_014;
  wire inst_doa_i0_015;
  wire inst_doa_i1_000;
  wire inst_doa_i1_001;
  wire inst_doa_i1_002;
  wire inst_doa_i1_003;
  wire inst_doa_i1_004;
  wire inst_doa_i1_005;
  wire inst_doa_i1_006;
  wire inst_doa_i1_007;
  wire inst_doa_i1_008;
  wire inst_doa_i1_009;
  wire inst_doa_i1_010;
  wire inst_doa_i1_011;
  wire inst_doa_i1_012;
  wire inst_doa_i1_013;
  wire inst_doa_i1_014;
  wire inst_doa_i1_015;

  reg_ar_as_w1 addra_pipe (
    .clk(clka),
    .d(addra[0]),
    .en(cea),
    .reset(1'b0),
    .set(1'b0),
    .q(addra_piped));
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  // address_offset=0;data_offset=0;depth=1024;width=8;num_section=1;width_per_section=8;section_size=16;working_depth=1024;working_width=9;address_step=2;bytes_in_per_section=1;
  EG_PHY_BRAM #(
    .CSA0("INV"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("1"),
    .DATA_WIDTH_A("9"),
    .DATA_WIDTH_B("9"),
    .MODE("DP8K"),
    .OCEAMUX("0"),
    .OCEBMUX("0"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("SYNC"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    inst_2048x16_sub_000000_000 (
    .addra({addra[10:1],3'b111}),
    .addrb({addrb,3'b111}),
    .cea(cea),
    .ceb(ceb),
    .clka(clka),
    .clkb(clkb),
    .csa({open_n47,open_n48,addra[0]}),
    .dia({open_n52,dia[7:0]}),
    .dib({open_n53,dib[7:0]}),
    .wea(wea[0]),
    .web(web[0]),
    .doa({open_n58,inst_doa_i0_007,inst_doa_i0_006,inst_doa_i0_005,inst_doa_i0_004,inst_doa_i0_003,inst_doa_i0_002,inst_doa_i0_001,inst_doa_i0_000}),
    .dob({open_n59,dob[7:0]}));
  // address_offset=0;data_offset=8;depth=1024;width=8;num_section=1;width_per_section=8;section_size=16;working_depth=1024;working_width=9;address_step=2;bytes_in_per_section=1;
  EG_PHY_BRAM #(
    .CSA0("INV"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("1"),
    .DATA_WIDTH_A("9"),
    .DATA_WIDTH_B("9"),
    .MODE("DP8K"),
    .OCEAMUX("0"),
    .OCEBMUX("0"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("SYNC"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    inst_2048x16_sub_000000_008 (
    .addra({addra[10:1],3'b111}),
    .addrb({addrb,3'b111}),
    .cea(cea),
    .ceb(ceb),
    .clka(clka),
    .clkb(clkb),
    .csa({open_n60,open_n61,addra[0]}),
    .dia({open_n65,dia[15:8]}),
    .dib({open_n66,dib[15:8]}),
    .wea(wea[1]),
    .web(web[1]),
    .doa({open_n71,inst_doa_i0_015,inst_doa_i0_014,inst_doa_i0_013,inst_doa_i0_012,inst_doa_i0_011,inst_doa_i0_010,inst_doa_i0_009,inst_doa_i0_008}),
    .dob({open_n72,dob[15:8]}));
  // address_offset=1;data_offset=0;depth=1024;width=8;num_section=1;width_per_section=8;section_size=16;working_depth=1024;working_width=9;address_step=2;bytes_in_per_section=1;
  EG_PHY_BRAM #(
    .CSA0("SIG"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("1"),
    .DATA_WIDTH_A("9"),
    .DATA_WIDTH_B("9"),
    .MODE("DP8K"),
    .OCEAMUX("0"),
    .OCEBMUX("0"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("SYNC"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    inst_2048x16_sub_000001_000 (
    .addra({addra[10:1],3'b111}),
    .addrb({addrb,3'b111}),
    .cea(cea),
    .ceb(ceb),
    .clka(clka),
    .clkb(clkb),
    .csa({open_n73,open_n74,addra[0]}),
    .dia({open_n78,dia[7:0]}),
    .dib({open_n79,dib[23:16]}),
    .wea(wea[0]),
    .web(web[2]),
    .doa({open_n84,inst_doa_i1_007,inst_doa_i1_006,inst_doa_i1_005,inst_doa_i1_004,inst_doa_i1_003,inst_doa_i1_002,inst_doa_i1_001,inst_doa_i1_000}),
    .dob({open_n85,dob[23:16]}));
  // address_offset=1;data_offset=8;depth=1024;width=8;num_section=1;width_per_section=8;section_size=16;working_depth=1024;working_width=9;address_step=2;bytes_in_per_section=1;
  EG_PHY_BRAM #(
    .CSA0("SIG"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("1"),
    .DATA_WIDTH_A("9"),
    .DATA_WIDTH_B("9"),
    .MODE("DP8K"),
    .OCEAMUX("0"),
    .OCEBMUX("0"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("SYNC"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    inst_2048x16_sub_000001_008 (
    .addra({addra[10:1],3'b111}),
    .addrb({addrb,3'b111}),
    .cea(cea),
    .ceb(ceb),
    .clka(clka),
    .clkb(clkb),
    .csa({open_n86,open_n87,addra[0]}),
    .dia({open_n91,dia[15:8]}),
    .dib({open_n92,dib[31:24]}),
    .wea(wea[1]),
    .web(web[3]),
    .doa({open_n97,inst_doa_i1_015,inst_doa_i1_014,inst_doa_i1_013,inst_doa_i1_012,inst_doa_i1_011,inst_doa_i1_010,inst_doa_i1_009,inst_doa_i1_008}),
    .dob({open_n98,dob[31:24]}));
  AL_MUX \inst_doa_mux_b0/al_mux_b0_0_0  (
    .i0(inst_doa_i0_000),
    .i1(inst_doa_i1_000),
    .sel(addra_piped),
    .o(doa[0]));
  AL_MUX \inst_doa_mux_b1/al_mux_b0_0_0  (
    .i0(inst_doa_i0_001),
    .i1(inst_doa_i1_001),
    .sel(addra_piped),
    .o(doa[1]));
  AL_MUX \inst_doa_mux_b10/al_mux_b0_0_0  (
    .i0(inst_doa_i0_010),
    .i1(inst_doa_i1_010),
    .sel(addra_piped),
    .o(doa[10]));
  AL_MUX \inst_doa_mux_b11/al_mux_b0_0_0  (
    .i0(inst_doa_i0_011),
    .i1(inst_doa_i1_011),
    .sel(addra_piped),
    .o(doa[11]));
  AL_MUX \inst_doa_mux_b12/al_mux_b0_0_0  (
    .i0(inst_doa_i0_012),
    .i1(inst_doa_i1_012),
    .sel(addra_piped),
    .o(doa[12]));
  AL_MUX \inst_doa_mux_b13/al_mux_b0_0_0  (
    .i0(inst_doa_i0_013),
    .i1(inst_doa_i1_013),
    .sel(addra_piped),
    .o(doa[13]));
  AL_MUX \inst_doa_mux_b14/al_mux_b0_0_0  (
    .i0(inst_doa_i0_014),
    .i1(inst_doa_i1_014),
    .sel(addra_piped),
    .o(doa[14]));
  AL_MUX \inst_doa_mux_b15/al_mux_b0_0_0  (
    .i0(inst_doa_i0_015),
    .i1(inst_doa_i1_015),
    .sel(addra_piped),
    .o(doa[15]));
  AL_MUX \inst_doa_mux_b2/al_mux_b0_0_0  (
    .i0(inst_doa_i0_002),
    .i1(inst_doa_i1_002),
    .sel(addra_piped),
    .o(doa[2]));
  AL_MUX \inst_doa_mux_b3/al_mux_b0_0_0  (
    .i0(inst_doa_i0_003),
    .i1(inst_doa_i1_003),
    .sel(addra_piped),
    .o(doa[3]));
  AL_MUX \inst_doa_mux_b4/al_mux_b0_0_0  (
    .i0(inst_doa_i0_004),
    .i1(inst_doa_i1_004),
    .sel(addra_piped),
    .o(doa[4]));
  AL_MUX \inst_doa_mux_b5/al_mux_b0_0_0  (
    .i0(inst_doa_i0_005),
    .i1(inst_doa_i1_005),
    .sel(addra_piped),
    .o(doa[5]));
  AL_MUX \inst_doa_mux_b6/al_mux_b0_0_0  (
    .i0(inst_doa_i0_006),
    .i1(inst_doa_i1_006),
    .sel(addra_piped),
    .o(doa[6]));
  AL_MUX \inst_doa_mux_b7/al_mux_b0_0_0  (
    .i0(inst_doa_i0_007),
    .i1(inst_doa_i1_007),
    .sel(addra_piped),
    .o(doa[7]));
  AL_MUX \inst_doa_mux_b8/al_mux_b0_0_0  (
    .i0(inst_doa_i0_008),
    .i1(inst_doa_i1_008),
    .sel(addra_piped),
    .o(doa[8]));
  AL_MUX \inst_doa_mux_b9/al_mux_b0_0_0  (
    .i0(inst_doa_i0_009),
    .i1(inst_doa_i1_009),
    .sel(addra_piped),
    .o(doa[9]));

endmodule 

