
`timescale 1ns / 1ps
module dac121  // rtl/dac121.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_dacu_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  bdatr,
  dac_pdmo,
  dac_pdmo_enb
  );
//
// 12 bit delta-sigma D/A converter unit
//		(c) 2023	1YEN Toru
//
//
//	2023/01/21	ver.1.00
//		12 bit delta-sigma DAC, 1 channel, digital front end
//

  input [3:0] badr;  // rtl/dac121.v(21)
  input bcmdr;  // rtl/dac121.v(19)
  input bcmdw;  // rtl/dac121.v(18)
  input bcs_dacu_n;  // rtl/dac121.v(20)
  input [15:0] bdatw;  // rtl/dac121.v(22)
  input brdy;  // rtl/dac121.v(17)
  input clk;  // rtl/dac121.v(15)
  input rst_n;  // rtl/dac121.v(16)
  output [15:0] bdatr;  // rtl/dac121.v(25)
  output dac_pdmo;  // rtl/dac121.v(23)
  output dac_pdmo_enb;  // rtl/dac121.v(24)

  wire [11:0] dacdat;  // rtl/dac121.v(41)
  wire [2:0] dctl_bitw;  // rtl/dac121.v(38)
  wire [3:0] dctl_clks;  // rtl/dac121.v(39)
  wire [11:0] ddat_dat;  // rtl/dac121.v(42)
  wire [12:0] \dlsg/delt ;  // rtl/dac121.v(227)
  wire [12:0] \dlsg/n18 ;
  wire [3:0] \dlsg/n4 ;
  wire [3:0] \dlsg/prescl ;  // rtl/dac121.v(232)
  wire [12:0] \dlsg/sgma ;  // rtl/dac121.v(228)
  wire [6:0] n0;
  wire _al_u54_o;
  wire _al_u61_o;
  wire \dctl/n3_lutinv ;
  wire \dctl/n4 ;
  wire \dctl/n5_lutinv ;
  wire \dctl/n6 ;
  wire \dctl/rd_dacctl ;  // rtl/dac121.v(122)
  wire \dctl/rd_dacdat ;  // rtl/dac121.v(123)
  wire \dctl/wr_dacctl ;  // rtl/dac121.v(139)
  wire \dlsg/add0/c0 ;
  wire \dlsg/add0/c1 ;
  wire \dlsg/add0/c2 ;
  wire \dlsg/add0/c3 ;
  wire \dlsg/dac_pdmo_nx ;  // rtl/dac121.v(266)
  wire \dlsg/dac_pdmo_nx_d ;
  wire \dlsg/dac_pdmo_nx_en ;
  wire \dlsg/lt0_c0 ;
  wire \dlsg/lt0_c1 ;
  wire \dlsg/lt0_c10 ;
  wire \dlsg/lt0_c11 ;
  wire \dlsg/lt0_c12 ;
  wire \dlsg/lt0_c13 ;
  wire \dlsg/lt0_c2 ;
  wire \dlsg/lt0_c3 ;
  wire \dlsg/lt0_c4 ;
  wire \dlsg/lt0_c5 ;
  wire \dlsg/lt0_c6 ;
  wire \dlsg/lt0_c7 ;
  wire \dlsg/lt0_c8 ;
  wire \dlsg/lt0_c9 ;
  wire \dlsg/n19 ;
  wire \dlsg/n2 ;
  wire \dlsg/n3 ;
  wire \dlsg/ps_ovfl_lutinv ;  // rtl/dac121.v(233)
  wire \u1/c0 ;
  wire \u1/c1 ;
  wire \u1/c2 ;
  wire \u1/c3 ;
  wire \u1/c4 ;
  wire \u1/c5 ;
  wire \u1/c6 ;
  wire \u2/c0 ;
  wire \u2/c1 ;
  wire \u2/c10 ;
  wire \u2/c11 ;
  wire \u2/c12 ;
  wire \u2/c2 ;
  wire \u2/c3 ;
  wire \u2/c4 ;
  wire \u2/c5 ;
  wire \u2/c6 ;
  wire \u2/c7 ;
  wire \u2/c8 ;
  wire \u2/c9 ;
  wire wr_dacdat;  // rtl/dac121.v(57)

  assign bdatr[15] = 1'b0;
  assign bdatr[14] = 1'b0;
  assign bdatr[13] = 1'b0;
  assign bdatr[12] = 1'b0;
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u41 (
    .a(dac_pdmo_enb),
    .b(rst_n),
    .o(\dlsg/n2 ));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u42 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dctl_clks[0]),
    .d(dacdat[0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u43 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dctl_clks[1]),
    .d(dacdat[1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u44 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dctl_clks[2]),
    .d(dacdat[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u45 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dctl_clks[3]),
    .d(dacdat[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u46 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dctl_bitw[0]),
    .d(dacdat[4]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u47 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dctl_bitw[1]),
    .d(dacdat[5]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u48 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dctl_bitw[2]),
    .d(dacdat[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u49 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dac_pdmo_enb),
    .d(dacdat[7]),
    .o(bdatr[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u50 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dacdat[9]),
    .o(bdatr[9]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u51 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dacdat[8]),
    .o(bdatr[8]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u52 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dacdat[11]),
    .o(bdatr[11]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u53 (
    .a(\dctl/rd_dacctl ),
    .b(\dctl/rd_dacdat ),
    .c(dacdat[10]),
    .o(bdatr[10]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u54 (
    .a(badr[3]),
    .b(badr[2]),
    .o(_al_u54_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u55 (
    .a(_al_u54_o),
    .b(badr[1]),
    .c(badr[0]),
    .o(\dctl/n3_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u56 (
    .a(\dctl/n3_lutinv ),
    .b(bcmdr),
    .c(bcs_dacu_n),
    .o(\dctl/n4 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u57 (
    .a(\dctl/n3_lutinv ),
    .b(bcmdw),
    .c(bcs_dacu_n),
    .d(brdy),
    .o(\dctl/wr_dacctl ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u58 (
    .a(_al_u54_o),
    .b(badr[1]),
    .c(badr[0]),
    .o(\dctl/n5_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u59 (
    .a(\dctl/n5_lutinv ),
    .b(bcmdr),
    .c(bcs_dacu_n),
    .o(\dctl/n6 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u60 (
    .a(\dctl/n5_lutinv ),
    .b(bcmdw),
    .c(bcs_dacu_n),
    .d(brdy),
    .o(wr_dacdat));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u61 (
    .a(dctl_clks[2]),
    .b(dctl_clks[3]),
    .c(\dlsg/prescl [2]),
    .d(\dlsg/prescl [3]),
    .o(_al_u61_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u62 (
    .a(_al_u61_o),
    .b(dctl_clks[0]),
    .c(dctl_clks[1]),
    .d(\dlsg/prescl [0]),
    .e(\dlsg/prescl [1]),
    .o(\dlsg/ps_ovfl_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u63 (
    .a(\dlsg/ps_ovfl_lutinv ),
    .b(\dlsg/n2 ),
    .o(\dlsg/n3 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u64 (
    .a(\dlsg/ps_ovfl_lutinv ),
    .b(dac_pdmo_enb),
    .o(\dlsg/n19 ));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(E*D*C*B))"),
    .INIT(32'heaaaaaaa))
    _al_u65 (
    .a(\dlsg/ps_ovfl_lutinv ),
    .b(dctl_bitw[0]),
    .c(dctl_bitw[1]),
    .d(dctl_bitw[2]),
    .e(dac_pdmo_enb),
    .o(\dlsg/dac_pdmo_nx_en ));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(E*D*C*B))"),
    .INIT(32'heaaaaaaa))
    _al_u66 (
    .a(\dlsg/dac_pdmo_nx ),
    .b(dctl_bitw[0]),
    .c(dctl_bitw[1]),
    .d(dctl_bitw[2]),
    .e(dac_pdmo_enb),
    .o(\dlsg/dac_pdmo_nx_d ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u67 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dac_pdmo),
    .o(\dlsg/n18 [12]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u68 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dacdat[11]),
    .o(ddat_dat[11]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*(B@A))"),
    .INIT(16'h6000))
    _al_u69 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dacdat[10]),
    .o(ddat_dat[10]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u70 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dac_pdmo),
    .o(\dlsg/n18 [11]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u71 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dac_pdmo),
    .o(\dlsg/n18 [10]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~(B*A))"),
    .INIT(16'h7000))
    _al_u72 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dacdat[9]),
    .o(ddat_dat[9]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u73 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dac_pdmo),
    .o(\dlsg/n18 [9]));
  AL_MAP_LUT4 #(
    .EQN("(D*(C@(B*A)))"),
    .INIT(16'h7800))
    _al_u74 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dacdat[8]),
    .o(ddat_dat[8]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u75 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dac_pdmo),
    .o(\dlsg/n18 [8]));
  AL_MAP_LUT4 #(
    .EQN("(D*(~(A)*B*~(C)+A*B*~(C)+~(A)*~(B)*C+A*~(B)*C+~(A)*B*C))"),
    .INIT(16'h7c00))
    _al_u76 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dacdat[7]),
    .o(ddat_dat[7]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u77 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dac_pdmo),
    .o(\dlsg/n18 [7]));
  AL_MAP_LUT4 #(
    .EQN("(D*(~(A)*~(B)*~(C)+A*B*C))"),
    .INIT(16'h8100))
    _al_u78 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dac_pdmo),
    .o(\dlsg/n18 [6]));
  AL_MAP_LUT4 #(
    .EQN("(D*(A*~(B)*~(C)+~(A)*B*~(C)+A*B*~(C)+~(A)*~(B)*C+A*~(B)*C+~(A)*B*C))"),
    .INIT(16'h7e00))
    _al_u79 (
    .a(dctl_bitw[0]),
    .b(dctl_bitw[1]),
    .c(dctl_bitw[2]),
    .d(dacdat[6]),
    .o(ddat_dat[6]));
  reg_sr_as_w1 \dctl/rd_dacctl_reg  (
    .clk(clk),
    .d(\dctl/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/rd_dacctl ));  // rtl/dac121.v(136)
  reg_sr_as_w1 \dctl/rd_dacdat_reg  (
    .clk(clk),
    .d(\dctl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/rd_dacdat ));  // rtl/dac121.v(136)
  reg_sr_as_w1 \dctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dctl_clks[0]));  // rtl/dac121.v(150)
  reg_sr_as_w1 \dctl/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dctl_clks[1]));  // rtl/dac121.v(150)
  reg_sr_as_w1 \dctl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dctl_clks[2]));  // rtl/dac121.v(150)
  reg_sr_as_w1 \dctl/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dctl_clks[3]));  // rtl/dac121.v(150)
  reg_sr_as_w1 \dctl/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dctl_bitw[0]));  // rtl/dac121.v(150)
  reg_sr_as_w1 \dctl/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dctl_bitw[1]));  // rtl/dac121.v(150)
  reg_sr_as_w1 \dctl/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dctl_bitw[2]));  // rtl/dac121.v(150)
  reg_sr_as_w1 \dctl/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(\dctl/wr_dacctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(dac_pdmo_enb));  // rtl/dac121.v(150)
  reg_sr_as_w1 \ddat/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[0]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[1]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[10]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[11]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[2]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[3]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[4]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[5]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[6]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[7]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[8]));  // rtl/dac121.v(202)
  reg_sr_as_w1 \ddat/reg0_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(wr_dacdat),
    .reset(~rst_n),
    .set(1'b0),
    .q(dacdat[9]));  // rtl/dac121.v(202)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dlsg/add0/u0  (
    .a(\dlsg/prescl [0]),
    .b(1'b1),
    .c(\dlsg/add0/c0 ),
    .o({\dlsg/add0/c1 ,\dlsg/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dlsg/add0/u1  (
    .a(\dlsg/prescl [1]),
    .b(1'b0),
    .c(\dlsg/add0/c1 ),
    .o({\dlsg/add0/c2 ,\dlsg/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dlsg/add0/u2  (
    .a(\dlsg/prescl [2]),
    .b(1'b0),
    .c(\dlsg/add0/c2 ),
    .o({\dlsg/add0/c3 ,\dlsg/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dlsg/add0/u3  (
    .a(\dlsg/prescl [3]),
    .b(1'b0),
    .c(\dlsg/add0/c3 ),
    .o({open_n0,\dlsg/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \dlsg/add0/ucin  (
    .a(1'b0),
    .o({\dlsg/add0/c0 ,open_n3}));
  reg_sr_as_w1 \dlsg/dac_pdmo_reg  (
    .clk(clk),
    .d(\dlsg/dac_pdmo_nx_d ),
    .en(\dlsg/dac_pdmo_nx_en ),
    .reset(\dlsg/n2 ),
    .set(1'b0),
    .q(dac_pdmo));  // rtl/dac121.v(276)
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_0  (
    .a(1'b0),
    .b(\dlsg/delt [0]),
    .c(\dlsg/lt0_c0 ),
    .o({\dlsg/lt0_c1 ,open_n4}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_1  (
    .a(1'b0),
    .b(\dlsg/delt [1]),
    .c(\dlsg/lt0_c1 ),
    .o({\dlsg/lt0_c2 ,open_n5}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_10  (
    .a(1'b0),
    .b(\dlsg/delt [10]),
    .c(\dlsg/lt0_c10 ),
    .o({\dlsg/lt0_c11 ,open_n6}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_11  (
    .a(1'b0),
    .b(\dlsg/delt [11]),
    .c(\dlsg/lt0_c11 ),
    .o({\dlsg/lt0_c12 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_12  (
    .a(\dlsg/delt [12]),
    .b(1'b0),
    .c(\dlsg/lt0_c12 ),
    .o({\dlsg/lt0_c13 ,open_n8}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_2  (
    .a(1'b0),
    .b(\dlsg/delt [2]),
    .c(\dlsg/lt0_c2 ),
    .o({\dlsg/lt0_c3 ,open_n9}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_3  (
    .a(1'b0),
    .b(\dlsg/delt [3]),
    .c(\dlsg/lt0_c3 ),
    .o({\dlsg/lt0_c4 ,open_n10}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_4  (
    .a(1'b0),
    .b(\dlsg/delt [4]),
    .c(\dlsg/lt0_c4 ),
    .o({\dlsg/lt0_c5 ,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_5  (
    .a(1'b0),
    .b(\dlsg/delt [5]),
    .c(\dlsg/lt0_c5 ),
    .o({\dlsg/lt0_c6 ,open_n12}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_6  (
    .a(1'b0),
    .b(\dlsg/delt [6]),
    .c(\dlsg/lt0_c6 ),
    .o({\dlsg/lt0_c7 ,open_n13}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_7  (
    .a(1'b0),
    .b(\dlsg/delt [7]),
    .c(\dlsg/lt0_c7 ),
    .o({\dlsg/lt0_c8 ,open_n14}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_8  (
    .a(1'b0),
    .b(\dlsg/delt [8]),
    .c(\dlsg/lt0_c8 ),
    .o({\dlsg/lt0_c9 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_9  (
    .a(1'b0),
    .b(\dlsg/delt [9]),
    .c(\dlsg/lt0_c9 ),
    .o({\dlsg/lt0_c10 ,open_n16}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \dlsg/lt0_cin  (
    .a(1'b1),
    .o({\dlsg/lt0_c0 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \dlsg/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\dlsg/lt0_c13 ),
    .o({open_n20,\dlsg/dac_pdmo_nx }));
  reg_sr_as_w1 \dlsg/reg0_b0  (
    .clk(clk),
    .d(\dlsg/delt [0]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [0]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b1  (
    .clk(clk),
    .d(\dlsg/delt [1]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [1]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b10  (
    .clk(clk),
    .d(\dlsg/delt [10]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [10]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b11  (
    .clk(clk),
    .d(\dlsg/delt [11]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [11]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b12  (
    .clk(clk),
    .d(\dlsg/delt [12]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [12]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b2  (
    .clk(clk),
    .d(\dlsg/delt [2]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [2]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b3  (
    .clk(clk),
    .d(\dlsg/delt [3]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [3]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b4  (
    .clk(clk),
    .d(\dlsg/delt [4]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [4]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b5  (
    .clk(clk),
    .d(\dlsg/delt [5]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [5]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b6  (
    .clk(clk),
    .d(\dlsg/delt [6]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [6]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b7  (
    .clk(clk),
    .d(\dlsg/delt [7]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [7]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b8  (
    .clk(clk),
    .d(\dlsg/delt [8]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [8]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg0_b9  (
    .clk(clk),
    .d(\dlsg/delt [9]),
    .en(\dlsg/n19 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dlsg/sgma [9]));  // rtl/dac121.v(263)
  reg_sr_as_w1 \dlsg/reg1_b0  (
    .clk(clk),
    .d(\dlsg/n4 [0]),
    .en(1'b1),
    .reset(\dlsg/n3 ),
    .set(1'b0),
    .q(\dlsg/prescl [0]));  // rtl/dac121.v(240)
  reg_sr_as_w1 \dlsg/reg1_b1  (
    .clk(clk),
    .d(\dlsg/n4 [1]),
    .en(1'b1),
    .reset(\dlsg/n3 ),
    .set(1'b0),
    .q(\dlsg/prescl [1]));  // rtl/dac121.v(240)
  reg_sr_as_w1 \dlsg/reg1_b2  (
    .clk(clk),
    .d(\dlsg/n4 [2]),
    .en(1'b1),
    .reset(\dlsg/n3 ),
    .set(1'b0),
    .q(\dlsg/prescl [2]));  // rtl/dac121.v(240)
  reg_sr_as_w1 \dlsg/reg1_b3  (
    .clk(clk),
    .d(\dlsg/n4 [3]),
    .en(1'b1),
    .reset(\dlsg/n3 ),
    .set(1'b0),
    .q(\dlsg/prescl [3]));  // rtl/dac121.v(240)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u0  (
    .a(ddat_dat[6]),
    .b(\dlsg/n18 [6]),
    .c(\u1/c0 ),
    .o({\u1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u1  (
    .a(ddat_dat[7]),
    .b(\dlsg/n18 [7]),
    .c(\u1/c1 ),
    .o({\u1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u2  (
    .a(ddat_dat[8]),
    .b(\dlsg/n18 [8]),
    .c(\u1/c2 ),
    .o({\u1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u3  (
    .a(ddat_dat[9]),
    .b(\dlsg/n18 [9]),
    .c(\u1/c3 ),
    .o({\u1/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u4  (
    .a(ddat_dat[10]),
    .b(\dlsg/n18 [10]),
    .c(\u1/c4 ),
    .o({\u1/c5 ,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u5  (
    .a(ddat_dat[11]),
    .b(\dlsg/n18 [11]),
    .c(\u1/c5 ),
    .o({\u1/c6 ,n0[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u6  (
    .a(1'b0),
    .b(\dlsg/n18 [12]),
    .c(\u1/c6 ),
    .o({open_n21,n0[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \u1/ucin  (
    .a(1'b0),
    .o({\u1/c0 ,open_n24}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u0  (
    .a(\dlsg/sgma [0]),
    .b(dacdat[0]),
    .c(\u2/c0 ),
    .o({\u2/c1 ,\dlsg/delt [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u1  (
    .a(\dlsg/sgma [1]),
    .b(dacdat[1]),
    .c(\u2/c1 ),
    .o({\u2/c2 ,\dlsg/delt [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u10  (
    .a(\dlsg/sgma [10]),
    .b(n0[4]),
    .c(\u2/c10 ),
    .o({\u2/c11 ,\dlsg/delt [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u11  (
    .a(\dlsg/sgma [11]),
    .b(n0[5]),
    .c(\u2/c11 ),
    .o({\u2/c12 ,\dlsg/delt [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u12  (
    .a(\dlsg/sgma [12]),
    .b(n0[6]),
    .c(\u2/c12 ),
    .o({open_n25,\dlsg/delt [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u2  (
    .a(\dlsg/sgma [2]),
    .b(dacdat[2]),
    .c(\u2/c2 ),
    .o({\u2/c3 ,\dlsg/delt [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u3  (
    .a(\dlsg/sgma [3]),
    .b(dacdat[3]),
    .c(\u2/c3 ),
    .o({\u2/c4 ,\dlsg/delt [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u4  (
    .a(\dlsg/sgma [4]),
    .b(dacdat[4]),
    .c(\u2/c4 ),
    .o({\u2/c5 ,\dlsg/delt [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u5  (
    .a(\dlsg/sgma [5]),
    .b(dacdat[5]),
    .c(\u2/c5 ),
    .o({\u2/c6 ,\dlsg/delt [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u6  (
    .a(\dlsg/sgma [6]),
    .b(n0[0]),
    .c(\u2/c6 ),
    .o({\u2/c7 ,\dlsg/delt [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u7  (
    .a(\dlsg/sgma [7]),
    .b(n0[1]),
    .c(\u2/c7 ),
    .o({\u2/c8 ,\dlsg/delt [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u8  (
    .a(\dlsg/sgma [8]),
    .b(n0[2]),
    .c(\u2/c8 ),
    .o({\u2/c9 ,\dlsg/delt [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u9  (
    .a(\dlsg/sgma [9]),
    .b(n0[3]),
    .c(\u2/c9 ),
    .o({\u2/c10 ,\dlsg/delt [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u2/ucin  (
    .a(1'b0),
    .o({\u2/c0 ,open_n28}));

endmodule 

