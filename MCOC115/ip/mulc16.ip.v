
`timescale 1ns / 1ps
module mulc16  // rtl/mulc16.v(1)
  (
  abus,
  bbus,
  ccmd,
  clk,
  mulc_dsp_c,
  rst_n,
  cbus,
  crdy,
  mulc_dsp_a,
  mulc_dsp_b
  );
//
//	Multiply Co-processor (16*16=32 bits)
//		(c) 2021	1YEN Toru
//
//
//	2021/05/22	ver.1.00
//		16*16=32: 1 cycle operation (32 bit data transfer needs 2 cycles)
//

  input [15:0] abus;  // rtl/mulc16.v(18)
  input [15:0] bbus;  // rtl/mulc16.v(19)
  input [4:0] ccmd;  // rtl/mulc16.v(17)
  input clk;  // rtl/mulc16.v(15)
  input [33:0] mulc_dsp_c;  // rtl/mulc16.v(23)
  input rst_n;  // rtl/mulc16.v(16)
  output [15:0] cbus;  // rtl/mulc16.v(21)
  output crdy;  // rtl/mulc16.v(20)
  output [16:0] mulc_dsp_a;  // rtl/mulc16.v(24)
  output [16:0] mulc_dsp_b;  // rtl/mulc16.v(25)

  parameter MULH = 5'b00011;
  parameter MULS = 5'b00010;
  parameter MULU = 5'b00001;
  wire [15:0] mulh;  // rtl/mulc16.v(47)
  wire _al_u60_o;
  wire n2;
  wire n7_lutinv;

  assign crdy = 1'b1;
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u100 (
    .a(n2),
    .b(abus[7]),
    .o(mulc_dsp_a[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u101 (
    .a(n2),
    .b(abus[6]),
    .o(mulc_dsp_a[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u102 (
    .a(n2),
    .b(abus[5]),
    .o(mulc_dsp_a[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u103 (
    .a(n2),
    .b(abus[4]),
    .o(mulc_dsp_a[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u104 (
    .a(n2),
    .b(abus[3]),
    .o(mulc_dsp_a[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u105 (
    .a(n2),
    .b(abus[2]),
    .o(mulc_dsp_a[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u106 (
    .a(n2),
    .b(abus[1]),
    .o(mulc_dsp_a[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u107 (
    .a(n2),
    .b(abus[14]),
    .o(mulc_dsp_a[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u108 (
    .a(n2),
    .b(abus[13]),
    .o(mulc_dsp_a[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u109 (
    .a(n2),
    .b(abus[12]),
    .o(mulc_dsp_a[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u110 (
    .a(n2),
    .b(abus[11]),
    .o(mulc_dsp_a[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u111 (
    .a(n2),
    .b(abus[10]),
    .o(mulc_dsp_a[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u112 (
    .a(n2),
    .b(abus[0]),
    .o(mulc_dsp_a[0]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u60 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .o(_al_u60_o));
  AL_MAP_LUT3 #(
    .EQN("(A*(C@B))"),
    .INIT(8'h28))
    _al_u61 (
    .a(_al_u60_o),
    .b(ccmd[1]),
    .c(ccmd[0]),
    .o(n2));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u62 (
    .a(_al_u60_o),
    .b(bbus[15]),
    .c(ccmd[1]),
    .d(ccmd[0]),
    .o(mulc_dsp_b[16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u63 (
    .a(n2),
    .b(bbus[15]),
    .o(mulc_dsp_b[15]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u64 (
    .a(_al_u60_o),
    .b(abus[15]),
    .c(ccmd[1]),
    .d(ccmd[0]),
    .o(mulc_dsp_a[16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u65 (
    .a(n2),
    .b(abus[15]),
    .o(mulc_dsp_a[15]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u66 (
    .a(_al_u60_o),
    .b(ccmd[1]),
    .c(ccmd[0]),
    .o(n7_lutinv));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u67 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[9]),
    .d(mulc_dsp_c[9]),
    .o(cbus[9]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u68 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[8]),
    .d(mulc_dsp_c[8]),
    .o(cbus[8]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u69 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[7]),
    .d(mulc_dsp_c[7]),
    .o(cbus[7]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u70 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[6]),
    .d(mulc_dsp_c[6]),
    .o(cbus[6]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u71 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[5]),
    .d(mulc_dsp_c[5]),
    .o(cbus[5]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u72 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[4]),
    .d(mulc_dsp_c[4]),
    .o(cbus[4]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u73 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[3]),
    .d(mulc_dsp_c[3]),
    .o(cbus[3]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u74 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[2]),
    .d(mulc_dsp_c[2]),
    .o(cbus[2]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u75 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[15]),
    .d(mulc_dsp_c[15]),
    .o(cbus[15]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u76 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[14]),
    .d(mulc_dsp_c[14]),
    .o(cbus[14]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u77 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[13]),
    .d(mulc_dsp_c[13]),
    .o(cbus[13]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u78 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[12]),
    .d(mulc_dsp_c[12]),
    .o(cbus[12]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u79 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[11]),
    .d(mulc_dsp_c[11]),
    .o(cbus[11]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u80 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[10]),
    .d(mulc_dsp_c[10]),
    .o(cbus[10]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u81 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[1]),
    .d(mulc_dsp_c[1]),
    .o(cbus[1]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u82 (
    .a(n2),
    .b(n7_lutinv),
    .c(mulh[0]),
    .d(mulc_dsp_c[0]),
    .o(cbus[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u83 (
    .a(n2),
    .b(bbus[9]),
    .o(mulc_dsp_b[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u84 (
    .a(n2),
    .b(bbus[8]),
    .o(mulc_dsp_b[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u85 (
    .a(n2),
    .b(bbus[7]),
    .o(mulc_dsp_b[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u86 (
    .a(n2),
    .b(bbus[6]),
    .o(mulc_dsp_b[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u87 (
    .a(n2),
    .b(bbus[5]),
    .o(mulc_dsp_b[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u88 (
    .a(n2),
    .b(bbus[4]),
    .o(mulc_dsp_b[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u89 (
    .a(n2),
    .b(bbus[3]),
    .o(mulc_dsp_b[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u90 (
    .a(n2),
    .b(bbus[2]),
    .o(mulc_dsp_b[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u91 (
    .a(n2),
    .b(bbus[1]),
    .o(mulc_dsp_b[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u92 (
    .a(n2),
    .b(bbus[14]),
    .o(mulc_dsp_b[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u93 (
    .a(n2),
    .b(bbus[13]),
    .o(mulc_dsp_b[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u94 (
    .a(n2),
    .b(bbus[12]),
    .o(mulc_dsp_b[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u95 (
    .a(n2),
    .b(bbus[11]),
    .o(mulc_dsp_b[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u96 (
    .a(n2),
    .b(bbus[10]),
    .o(mulc_dsp_b[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u97 (
    .a(n2),
    .b(bbus[0]),
    .o(mulc_dsp_b[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u98 (
    .a(n2),
    .b(abus[9]),
    .o(mulc_dsp_a[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u99 (
    .a(n2),
    .b(abus[8]),
    .o(mulc_dsp_a[8]));
  reg_sr_as_w1 reg0_b0 (
    .clk(clk),
    .d(mulc_dsp_c[16]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[0]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b1 (
    .clk(clk),
    .d(mulc_dsp_c[17]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[1]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b10 (
    .clk(clk),
    .d(mulc_dsp_c[26]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[10]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b11 (
    .clk(clk),
    .d(mulc_dsp_c[27]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[11]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b12 (
    .clk(clk),
    .d(mulc_dsp_c[28]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[12]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b13 (
    .clk(clk),
    .d(mulc_dsp_c[29]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[13]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b14 (
    .clk(clk),
    .d(mulc_dsp_c[30]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[14]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b15 (
    .clk(clk),
    .d(mulc_dsp_c[31]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[15]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b2 (
    .clk(clk),
    .d(mulc_dsp_c[18]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[2]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b3 (
    .clk(clk),
    .d(mulc_dsp_c[19]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[3]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b4 (
    .clk(clk),
    .d(mulc_dsp_c[20]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[4]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b5 (
    .clk(clk),
    .d(mulc_dsp_c[21]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[5]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b6 (
    .clk(clk),
    .d(mulc_dsp_c[22]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[6]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b7 (
    .clk(clk),
    .d(mulc_dsp_c[23]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[7]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b8 (
    .clk(clk),
    .d(mulc_dsp_c[24]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[8]));  // rtl/mulc16.v(54)
  reg_sr_as_w1 reg0_b9 (
    .clk(clk),
    .d(mulc_dsp_c[25]),
    .en(n2),
    .reset(~rst_n),
    .set(1'b0),
    .q(mulh[9]));  // rtl/mulc16.v(54)

endmodule 

