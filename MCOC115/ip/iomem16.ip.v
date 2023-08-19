
`timescale 1ns / 1ps
module iomem16  // rtl/iomem16.v(1)
  (
  badr,
  bcmd,
  bcs_iome_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  bdatr
  );
//
// I/O memory (16 bytes) unit
//		(c) 2023	1YEN Toru
//
//
//	2023/03/11	ver.1.00
//		I/O register area memory (16 bytes) unit
//		access: byte / word
//

  input [3:0] badr;  // rtl/iomem16.v(17)
  input [3:0] bcmd;  // rtl/iomem16.v(16)
  input bcs_iome_n;  // rtl/iomem16.v(15)
  input [15:0] bdatw;  // rtl/iomem16.v(18)
  input brdy;  // rtl/iomem16.v(14)
  input clk;  // rtl/iomem16.v(12)
  input rst_n;  // rtl/iomem16.v(13)
  output [15:0] bdatr;  // rtl/iomem16.v(19)

  wire [7:0] dat_h;  // rtl/iomem16.v(33)
  wire [7:0] dat_hf;  // rtl/iomem16.v(47)
  wire [7:0] dat_l;  // rtl/iomem16.v(34)
  wire [7:0] dat_lf;  // rtl/iomem16.v(48)
  wire drv_h;  // rtl/iomem16.v(45)
  wire drv_l;  // rtl/iomem16.v(46)
  wire n6;
  wire n7;
  wire wrt_h;  // rtl/iomem16.v(43)
  wire wrt_l;  // rtl/iomem16.v(44)

  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u0 (
    .a(drv_h),
    .b(dat_hf[0]),
    .o(bdatr[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1 (
    .a(drv_h),
    .b(dat_hf[1]),
    .o(bdatr[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u10 (
    .a(drv_l),
    .b(dat_lf[2]),
    .o(bdatr[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u11 (
    .a(drv_l),
    .b(dat_lf[3]),
    .o(bdatr[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u12 (
    .a(drv_l),
    .b(dat_lf[4]),
    .o(bdatr[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u13 (
    .a(drv_l),
    .b(dat_lf[5]),
    .o(bdatr[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u14 (
    .a(drv_l),
    .b(dat_lf[6]),
    .o(bdatr[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u15 (
    .a(drv_l),
    .b(dat_lf[7]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(B*~A))"),
    .INIT(16'h00b0))
    _al_u16 (
    .a(badr[0]),
    .b(bcmd[2]),
    .c(bcmd[1]),
    .d(bcs_iome_n),
    .o(wrt_l));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(B*A))"),
    .INIT(16'h0070))
    _al_u17 (
    .a(badr[0]),
    .b(bcmd[2]),
    .c(bcmd[1]),
    .d(bcs_iome_n),
    .o(wrt_h));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(B*~A))"),
    .INIT(16'h00b0))
    _al_u18 (
    .a(badr[0]),
    .b(bcmd[2]),
    .c(bcmd[0]),
    .d(bcs_iome_n),
    .o(n7));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(B*A))"),
    .INIT(16'h0070))
    _al_u19 (
    .a(badr[0]),
    .b(bcmd[2]),
    .c(bcmd[0]),
    .d(bcs_iome_n),
    .o(n6));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2 (
    .a(drv_h),
    .b(dat_hf[2]),
    .o(bdatr[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u3 (
    .a(drv_h),
    .b(dat_hf[3]),
    .o(bdatr[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u4 (
    .a(drv_h),
    .b(dat_hf[4]),
    .o(bdatr[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u5 (
    .a(drv_h),
    .b(dat_hf[5]),
    .o(bdatr[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u6 (
    .a(drv_h),
    .b(dat_hf[6]),
    .o(bdatr[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u7 (
    .a(drv_h),
    .b(dat_hf[7]),
    .o(bdatr[15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u8 (
    .a(drv_l),
    .b(dat_lf[0]),
    .o(bdatr[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u9 (
    .a(drv_l),
    .b(dat_lf[1]),
    .o(bdatr[1]));
  EG_LOGIC_DRAM16X4 \dath/dram_c0  (
    .di(bdatw[11:8]),
    .raddr({1'b0,badr[3:1]}),
    .waddr({1'b0,badr[3:1]}),
    .wclk(clk),
    .we(wrt_h),
    .do(dat_h[3:0]));
  EG_LOGIC_DRAM16X4 \dath/dram_c1  (
    .di(bdatw[15:12]),
    .raddr({1'b0,badr[3:1]}),
    .waddr({1'b0,badr[3:1]}),
    .wclk(clk),
    .we(wrt_h),
    .do(dat_h[7:4]));
  EG_LOGIC_DRAM16X4 \datl/dram_c0  (
    .di(bdatw[3:0]),
    .raddr({1'b0,badr[3:1]}),
    .waddr({1'b0,badr[3:1]}),
    .wclk(clk),
    .we(wrt_l),
    .do(dat_l[3:0]));
  EG_LOGIC_DRAM16X4 \datl/dram_c1  (
    .di(bdatw[7:4]),
    .raddr({1'b0,badr[3:1]}),
    .waddr({1'b0,badr[3:1]}),
    .wclk(clk),
    .we(wrt_l),
    .do(dat_l[7:4]));
  reg_sr_as_w1 drv_h_reg (
    .clk(clk),
    .d(n6),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(drv_h));  // rtl/iomem16.v(65)
  reg_sr_as_w1 drv_l_reg (
    .clk(clk),
    .d(n7),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(drv_l));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b0 (
    .clk(clk),
    .d(dat_h[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[0]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b1 (
    .clk(clk),
    .d(dat_h[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[1]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b2 (
    .clk(clk),
    .d(dat_h[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[2]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b3 (
    .clk(clk),
    .d(dat_h[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[3]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b4 (
    .clk(clk),
    .d(dat_h[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[4]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b5 (
    .clk(clk),
    .d(dat_h[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[5]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b6 (
    .clk(clk),
    .d(dat_h[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[6]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg0_b7 (
    .clk(clk),
    .d(dat_h[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_hf[7]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b0 (
    .clk(clk),
    .d(dat_l[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[0]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b1 (
    .clk(clk),
    .d(dat_l[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[1]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b2 (
    .clk(clk),
    .d(dat_l[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[2]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b3 (
    .clk(clk),
    .d(dat_l[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[3]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b4 (
    .clk(clk),
    .d(dat_l[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[4]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b5 (
    .clk(clk),
    .d(dat_l[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[5]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b6 (
    .clk(clk),
    .d(dat_l[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[6]));  // rtl/iomem16.v(65)
  reg_sr_as_w1 reg1_b7 (
    .clk(clk),
    .d(dat_l[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(dat_lf[7]));  // rtl/iomem16.v(65)

endmodule 

