
`timescale 1ns / 1ps
module fontjp  // rtl/fontjp.v(1)
  (
  badr,
  bcmdb,
  bcmdr,
  bcmdw,
  bcs_fnjp_n,
  bdatw,
  brdy,
  clk,
  fnjp_dat,
  rst_n,
  bdatr,
  fnjp_adr
  );
//
//	Japanese font ROM unit
//		(c) 2021	1YEN Toru
//
//
//	2021/10/16	ver.1.00
//		Japanese KANJI level-1 and 2 included
//

  input [3:0] badr;  // rtl/fontjp.v(25)
  input bcmdb;  // rtl/fontjp.v(21)
  input bcmdr;  // rtl/fontjp.v(23)
  input bcmdw;  // rtl/fontjp.v(22)
  input bcs_fnjp_n;  // rtl/fontjp.v(24)
  input [15:0] bdatw;  // rtl/fontjp.v(26)
  input brdy;  // rtl/fontjp.v(20)
  input clk;  // rtl/fontjp.v(18)
  input [63:0] fnjp_dat;  // rtl/fontjp.v(29)
  input rst_n;  // rtl/fontjp.v(19)
  output [15:0] bdatr;  // rtl/fontjp.v(27)
  output [12:0] fnjp_adr;  // rtl/fontjp.v(30)

  wire [15:0] bdatr_fctl;  // rtl/fontjp.v(46)
  wire [15:0] bdatr_fdat;  // rtl/fontjp.v(47)
  wire [15:0] \fcod/codk_2 ;  // rtl/fontjp.v(538)
  wire [12:0] \fcod/codkt_1 ;  // rtl/fontjp.v(541)
  wire [15:0] \fcod/codt_2 ;  // rtl/fontjp.v(533)
  wire [15:0] \fcod/codt_3 ;  // rtl/fontjp.v(535)
  wire [15:0] \fcod/codt_4 ;  // rtl/fontjp.v(537)
  wire [15:0] \fcod/fnjpcod ;  // rtl/fontjp.v(501)
  wire [1:0] \fcod/n17 ;
  wire [7:0] \fctl/fnjpctl ;  // rtl/fontjp.v(262)
  wire [63:0] \fdat/fdat_1 ;  // rtl/fontjp.v(426)
  wire [63:0] \fdat/fdat_5 ;  // rtl/fontjp.v(454)
  wire [63:0] \fdat/finv/n0 ;
  wire [15:0] \fdat/n0 ;
  wire [15:0] \fdat/n1 ;
  wire [15:0] \fdat/n2 ;
  wire [7:0] \fdbl/fnjpdbl ;  // rtl/fontjp.v(584)
  wire [6:0] n0;
  wire [8:0] n1;
  wire [9:0] n2;
  wire [10:0] n3;
  wire [1:0] n4;
  wire _al_u100_o;
  wire _al_u101_o;
  wire _al_u103_o;
  wire _al_u104_o;
  wire _al_u107_o;
  wire _al_u109_o;
  wire _al_u110_o;
  wire _al_u111_o;
  wire _al_u112_o;
  wire _al_u114_o;
  wire _al_u116_o;
  wire _al_u117_o;
  wire _al_u119_o;
  wire _al_u122_o;
  wire _al_u123_o;
  wire _al_u126_o;
  wire _al_u127_o;
  wire _al_u130_o;
  wire _al_u131_o;
  wire _al_u132_o;
  wire _al_u134_o;
  wire _al_u136_o;
  wire _al_u138_o;
  wire _al_u139_o;
  wire _al_u145_o;
  wire _al_u150_o;
  wire _al_u152_o;
  wire _al_u154_o;
  wire _al_u155_o;
  wire _al_u157_o;
  wire _al_u159_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u164_o;
  wire _al_u166_o;
  wire _al_u168_o;
  wire _al_u174_o;
  wire _al_u177_o;
  wire _al_u180_o;
  wire _al_u181_o;
  wire _al_u182_o;
  wire _al_u183_o;
  wire _al_u186_o;
  wire _al_u189_o;
  wire _al_u191_o;
  wire _al_u192_o;
  wire _al_u194_o;
  wire _al_u196_o;
  wire _al_u198_o;
  wire _al_u201_o;
  wire _al_u202_o;
  wire _al_u203_o;
  wire _al_u204_o;
  wire _al_u205_o;
  wire _al_u206_o;
  wire _al_u211_o;
  wire _al_u213_o;
  wire _al_u214_o;
  wire _al_u216_o;
  wire _al_u217_o;
  wire _al_u218_o;
  wire _al_u219_o;
  wire _al_u220_o;
  wire _al_u224_o;
  wire _al_u227_o;
  wire _al_u228_o;
  wire _al_u22_o;
  wire _al_u231_o;
  wire _al_u232_o;
  wire _al_u233_o;
  wire _al_u234_o;
  wire _al_u235_o;
  wire _al_u236_o;
  wire _al_u237_o;
  wire _al_u238_o;
  wire _al_u243_o;
  wire _al_u245_o;
  wire _al_u247_o;
  wire _al_u249_o;
  wire _al_u24_o;
  wire _al_u250_o;
  wire _al_u251_o;
  wire _al_u252_o;
  wire _al_u253_o;
  wire _al_u254_o;
  wire _al_u255_o;
  wire _al_u256_o;
  wire _al_u257_o;
  wire _al_u259_o;
  wire _al_u261_o;
  wire _al_u262_o;
  wire _al_u263_o;
  wire _al_u264_o;
  wire _al_u265_o;
  wire _al_u266_o;
  wire _al_u267_o;
  wire _al_u268_o;
  wire _al_u270_o;
  wire _al_u272_o;
  wire _al_u275_o;
  wire _al_u276_o;
  wire _al_u277_o;
  wire _al_u278_o;
  wire _al_u279_o;
  wire _al_u280_o;
  wire _al_u281_o;
  wire _al_u283_o;
  wire _al_u284_o;
  wire _al_u285_o;
  wire _al_u286_o;
  wire _al_u287_o;
  wire _al_u288_o;
  wire _al_u290_o;
  wire _al_u293_o;
  wire _al_u294_o;
  wire _al_u296_o;
  wire _al_u297_o;
  wire _al_u298_o;
  wire _al_u300_o;
  wire _al_u301_o;
  wire _al_u303_o;
  wire _al_u304_o;
  wire _al_u305_o;
  wire _al_u307_o;
  wire _al_u30_o;
  wire _al_u310_o;
  wire _al_u311_o;
  wire _al_u312_o;
  wire _al_u313_o;
  wire _al_u314_o;
  wire _al_u315_o;
  wire _al_u316_o;
  wire _al_u318_o;
  wire _al_u321_o;
  wire _al_u322_o;
  wire _al_u324_o;
  wire _al_u326_o;
  wire _al_u328_o;
  wire _al_u32_o;
  wire _al_u330_o;
  wire _al_u331_o;
  wire _al_u332_o;
  wire _al_u333_o;
  wire _al_u334_o;
  wire _al_u336_o;
  wire _al_u337_o;
  wire _al_u338_o;
  wire _al_u340_o;
  wire _al_u341_o;
  wire _al_u342_o;
  wire _al_u343_o;
  wire _al_u344_o;
  wire _al_u345_o;
  wire _al_u346_o;
  wire _al_u347_o;
  wire _al_u348_o;
  wire _al_u349_o;
  wire _al_u350_o;
  wire _al_u36_o;
  wire _al_u38_o;
  wire _al_u40_o;
  wire _al_u42_o;
  wire _al_u46_o;
  wire _al_u48_o;
  wire _al_u50_o;
  wire _al_u52_o;
  wire _al_u54_o;
  wire _al_u56_o;
  wire _al_u58_o;
  wire _al_u60_o;
  wire _al_u65_o;
  wire _al_u67_o;
  wire _al_u69_o;
  wire _al_u74_o;
  wire _al_u76_o;
  wire _al_u78_o;
  wire _al_u79_o;
  wire _al_u81_o;
  wire _al_u85_o;
  wire _al_u87_o;
  wire _al_u89_o;
  wire _al_u90_o;
  wire _al_u92_o;
  wire _al_u94_o;
  wire _al_u95_o;
  wire _al_u96_o;
  wire _al_u98_o;
  wire \fcod/fcod_ascii_1_lutinv ;  // rtl/fontjp.v(511)
  wire \fcod/fcod_ascii_2_lutinv ;  // rtl/fontjp.v(512)
  wire \fcod/fcod_sjis ;  // rtl/fontjp.v(525)
  wire \fcod/lt0_c0 ;
  wire \fcod/lt0_c1 ;
  wire \fcod/lt0_c2 ;
  wire \fcod/lt0_c3 ;
  wire \fcod/lt0_c4 ;
  wire \fcod/lt0_c5 ;
  wire \fcod/lt0_c6 ;
  wire \fcod/lt0_c7 ;
  wire \fcod/lt0_c8 ;
  wire \fcod/lt10_2_c0 ;
  wire \fcod/lt10_2_c1 ;
  wire \fcod/lt10_2_c2 ;
  wire \fcod/lt10_2_c3 ;
  wire \fcod/lt10_2_c4 ;
  wire \fcod/lt10_2_c5 ;
  wire \fcod/lt10_2_c6 ;
  wire \fcod/lt10_2_c7 ;
  wire \fcod/lt10_2_c8 ;
  wire \fcod/lt10_2_c9 ;
  wire \fcod/lt1_c0 ;
  wire \fcod/lt1_c1 ;
  wire \fcod/lt1_c2 ;
  wire \fcod/lt1_c3 ;
  wire \fcod/lt1_c4 ;
  wire \fcod/lt1_c5 ;
  wire \fcod/lt1_c6 ;
  wire \fcod/lt1_c7 ;
  wire \fcod/lt1_c8 ;
  wire \fcod/lt2_c0 ;
  wire \fcod/lt2_c1 ;
  wire \fcod/lt2_c2 ;
  wire \fcod/lt2_c3 ;
  wire \fcod/lt2_c4 ;
  wire \fcod/lt2_c5 ;
  wire \fcod/lt2_c6 ;
  wire \fcod/lt2_c7 ;
  wire \fcod/lt2_c8 ;
  wire \fcod/lt3_c0 ;
  wire \fcod/lt3_c1 ;
  wire \fcod/lt3_c2 ;
  wire \fcod/lt3_c3 ;
  wire \fcod/lt3_c4 ;
  wire \fcod/lt3_c5 ;
  wire \fcod/lt3_c6 ;
  wire \fcod/lt3_c7 ;
  wire \fcod/lt3_c8 ;
  wire \fcod/lt4_c0 ;
  wire \fcod/lt4_c1 ;
  wire \fcod/lt4_c2 ;
  wire \fcod/lt4_c3 ;
  wire \fcod/lt4_c4 ;
  wire \fcod/lt4_c5 ;
  wire \fcod/lt4_c6 ;
  wire \fcod/lt4_c7 ;
  wire \fcod/lt4_c8 ;
  wire \fcod/lt5_c0 ;
  wire \fcod/lt5_c1 ;
  wire \fcod/lt5_c2 ;
  wire \fcod/lt5_c3 ;
  wire \fcod/lt5_c4 ;
  wire \fcod/lt5_c5 ;
  wire \fcod/lt5_c6 ;
  wire \fcod/lt5_c7 ;
  wire \fcod/lt5_c8 ;
  wire \fcod/lt6_c0 ;
  wire \fcod/lt6_c1 ;
  wire \fcod/lt6_c2 ;
  wire \fcod/lt6_c3 ;
  wire \fcod/lt6_c4 ;
  wire \fcod/lt6_c5 ;
  wire \fcod/lt6_c6 ;
  wire \fcod/lt6_c7 ;
  wire \fcod/lt6_c8 ;
  wire \fcod/lt7_c0 ;
  wire \fcod/lt7_c1 ;
  wire \fcod/lt7_c2 ;
  wire \fcod/lt7_c3 ;
  wire \fcod/lt7_c4 ;
  wire \fcod/lt7_c5 ;
  wire \fcod/lt7_c6 ;
  wire \fcod/lt7_c7 ;
  wire \fcod/lt7_c8 ;
  wire \fcod/lt8_c0 ;
  wire \fcod/lt8_c1 ;
  wire \fcod/lt8_c10 ;
  wire \fcod/lt8_c11 ;
  wire \fcod/lt8_c12 ;
  wire \fcod/lt8_c13 ;
  wire \fcod/lt8_c14 ;
  wire \fcod/lt8_c15 ;
  wire \fcod/lt8_c16 ;
  wire \fcod/lt8_c2 ;
  wire \fcod/lt8_c3 ;
  wire \fcod/lt8_c4 ;
  wire \fcod/lt8_c5 ;
  wire \fcod/lt8_c6 ;
  wire \fcod/lt8_c7 ;
  wire \fcod/lt8_c8 ;
  wire \fcod/lt8_c9 ;
  wire \fcod/lt9_c0 ;
  wire \fcod/lt9_c1 ;
  wire \fcod/lt9_c2 ;
  wire \fcod/lt9_c3 ;
  wire \fcod/lt9_c4 ;
  wire \fcod/lt9_c5 ;
  wire \fcod/lt9_c6 ;
  wire \fcod/lt9_c7 ;
  wire \fcod/lt9_c8 ;
  wire \fcod/mux4_b10_sel_is_2_o ;
  wire \fcod/n11 ;
  wire \fcod/n12 ;
  wire \fcod/n14 ;
  wire \fcod/n15 ;
  wire \fcod/n16 ;
  wire \fcod/n2 ;
  wire \fcod/n3 ;
  wire \fcod/n5 ;
  wire \fcod/n6 ;
  wire \fcod/n8 ;
  wire \fcod/n9 ;
  wire \fcod/sub1/c0 ;
  wire \fcod/sub1/c1 ;
  wire \fcod/sub1/c10 ;
  wire \fcod/sub1/c11 ;
  wire \fcod/sub1/c12 ;
  wire \fcod/sub1/c13 ;
  wire \fcod/sub1/c14 ;
  wire \fcod/sub1/c15 ;
  wire \fcod/sub1/c2 ;
  wire \fcod/sub1/c3 ;
  wire \fcod/sub1/c4 ;
  wire \fcod/sub1/c5 ;
  wire \fcod/sub1/c6 ;
  wire \fcod/sub1/c7 ;
  wire \fcod/sub1/c8 ;
  wire \fcod/sub1/c9 ;
  wire \fcod/sub2/c0 ;
  wire \fcod/sub2/c1 ;
  wire \fcod/sub2/c2 ;
  wire \fcod/sub2/c3 ;
  wire \fcod/sub2/c4 ;
  wire \fcod/sub2/c5 ;
  wire \fcod/sub2/c6 ;
  wire \fcod/sub2/c7 ;
  wire \fcod/sub2/c8 ;
  wire \fcod/sub3/c0 ;
  wire \fcod/sub3/c1 ;
  wire \fcod/sub3/c10 ;
  wire \fcod/sub3/c11 ;
  wire \fcod/sub3/c12 ;
  wire \fcod/sub3/c2 ;
  wire \fcod/sub3/c3 ;
  wire \fcod/sub3/c4 ;
  wire \fcod/sub3/c5 ;
  wire \fcod/sub3/c6 ;
  wire \fcod/sub3/c7 ;
  wire \fcod/sub3/c8 ;
  wire \fcod/sub3/c9 ;
  wire \fcod/sub4/c0 ;
  wire \fcod/sub4/c1 ;
  wire \fcod/sub4/c2 ;
  wire \fcod/sub4/c3 ;
  wire \fcod/sub4/c4 ;
  wire \fcod/sub4/c5 ;
  wire \fcod/sub4/c6 ;
  wire \fcod/sub4/c7 ;
  wire \fcod/sub4/c8 ;
  wire \fcod/sub4/c9 ;
  wire \fctl/fnjpctl_rd ;  // rtl/fontjp.v(215)
  wire \fctl/fnjpctl_wr ;  // rtl/fontjp.v(254)
  wire \fctl/n12 ;
  wire \fctl/n17 ;
  wire \fctl/n22 ;
  wire \fctl/n27 ;
  wire \fctl/n32 ;
  wire \fctl/n6 ;
  wire \fctl/n9 ;
  wire fctl_flp_h;  // rtl/fontjp.v(74)
  wire fctl_flp_v;  // rtl/fontjp.v(75)
  wire fctl_inv;  // rtl/fontjp.v(73)
  wire fctl_ktc;  // rtl/fontjp.v(72)
  wire fctl_rot_2_lutinv;  // rtl/fontjp.v(78)
  wire fnjpcod_rd;  // rtl/fontjp.v(64)
  wire fnjpcod_wr;  // rtl/fontjp.v(70)
  wire fnjpdata_rd;  // rtl/fontjp.v(66)
  wire fnjpdatb_rd;  // rtl/fontjp.v(67)
  wire fnjpdatc_rd;  // rtl/fontjp.v(68)
  wire fnjpdatd_rd;  // rtl/fontjp.v(69)
  wire fnjpdbl_rd;  // rtl/fontjp.v(65)
  wire fnjpdbl_wr;  // rtl/fontjp.v(71)
  wire \u1/c0 ;
  wire \u1/c1 ;
  wire \u1/c2 ;
  wire \u1/c3 ;
  wire \u1/c4 ;
  wire \u1/c5 ;
  wire \u1/c6 ;
  wire \u2/c0 ;
  wire \u2/c1 ;
  wire \u2/c2 ;
  wire \u2/c3 ;
  wire \u2/c4 ;
  wire \u2/c5 ;
  wire \u2/c6 ;
  wire \u2/c7 ;
  wire \u2/c8 ;
  wire \u3/c0 ;
  wire \u3/c1 ;
  wire \u3/c2 ;
  wire \u3/c3 ;
  wire \u3/c4 ;
  wire \u3/c5 ;
  wire \u3/c6 ;
  wire \u3/c7 ;
  wire \u3/c8 ;
  wire \u3/c9 ;
  wire \u4/c0 ;
  wire \u4/c1 ;
  wire \u4/c10 ;
  wire \u4/c2 ;
  wire \u4/c3 ;
  wire \u4/c4 ;
  wire \u4/c5 ;
  wire \u4/c6 ;
  wire \u4/c7 ;
  wire \u4/c8 ;
  wire \u4/c9 ;
  wire \u5/c0 ;
  wire \u5/c1 ;
  wire \u5/c10 ;
  wire \u5/c11 ;
  wire \u5/c2 ;
  wire \u5/c3 ;
  wire \u5/c4 ;
  wire \u5/c5 ;
  wire \u5/c6 ;
  wire \u5/c7 ;
  wire \u5/c8 ;
  wire \u5/c9 ;

  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u100 (
    .a(\fdat/fdat_1 [62]),
    .b(\fdat/fdat_1 [15]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u100_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u101 (
    .a(fctl_flp_h),
    .b(fnjp_dat[6]),
    .c(fnjp_dat[1]),
    .o(_al_u101_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u102 (
    .a(_al_u101_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[62]),
    .e(fnjp_dat[57]),
    .o(\fdat/fdat_1 [1]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u103 (
    .a(_al_u100_o),
    .b(\fdat/fdat_1 [1]),
    .c(\fctl/fnjpctl [1]),
    .o(_al_u103_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u104 (
    .a(fctl_flp_h),
    .b(fnjp_dat[55]),
    .c(fnjp_dat[48]),
    .o(_al_u104_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u105 (
    .a(_al_u104_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[15]),
    .e(fnjp_dat[8]),
    .o(\fdat/fdat_1 [48]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u106 (
    .a(\fctl/fnjpctl [0]),
    .b(\fctl/fnjpctl [1]),
    .o(fctl_rot_2_lutinv));
  AL_MAP_LUT5 #(
    .EQN("(D*(E@(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)))"),
    .INIT(32'h3a00c500))
    _al_u107 (
    .a(_al_u103_o),
    .b(\fdat/fdat_1 [48]),
    .c(fctl_rot_2_lutinv),
    .d(fnjpdata_rd),
    .e(fctl_inv),
    .o(_al_u107_o));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~A*~(D*C))"),
    .INIT(16'hfeee))
    _al_u108 (
    .a(_al_u95_o),
    .b(_al_u107_o),
    .c(fnjpdbl_rd),
    .d(\fdbl/fnjpdbl [7]),
    .o(bdatr[14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u109 (
    .a(\fdat/fdat_1 [13]),
    .b(\fdat/fdat_1 [17]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u109_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u110 (
    .a(\fdat/fdat_1 [46]),
    .b(\fdat/fdat_1 [50]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u110_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u111 (
    .a(_al_u109_o),
    .b(_al_u110_o),
    .c(\fctl/fnjpctl [1]),
    .o(_al_u111_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u112 (
    .a(fctl_flp_h),
    .b(fnjp_dat[29]),
    .c(fnjp_dat[26]),
    .o(_al_u112_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u113 (
    .a(_al_u112_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[37]),
    .e(fnjp_dat[34]),
    .o(\fdat/fdat_1 [29]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u114 (
    .a(fctl_flp_h),
    .b(fnjp_dat[37]),
    .c(fnjp_dat[34]),
    .o(_al_u114_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u115 (
    .a(_al_u114_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[29]),
    .e(fnjp_dat[26]),
    .o(\fdat/fdat_1 [34]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u116 (
    .a(\fdat/fdat_1 [29]),
    .b(\fdat/fdat_1 [34]),
    .c(\fctl/fnjpctl [1]),
    .o(_al_u116_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u117 (
    .a(fctl_flp_h),
    .b(fnjp_dat[20]),
    .c(fnjp_dat[19]),
    .o(_al_u117_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u118 (
    .a(_al_u117_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[44]),
    .e(fnjp_dat[43]),
    .o(\fdat/fdat_1 [19]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u119 (
    .a(fctl_flp_h),
    .b(fnjp_dat[44]),
    .c(fnjp_dat[43]),
    .o(_al_u119_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u120 (
    .a(_al_u119_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[20]),
    .e(fnjp_dat[19]),
    .o(\fdat/fdat_1 [44]));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(D)+~A*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(D)+~(~A)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*D+~A*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*D)"),
    .INIT(32'h0faa33aa))
    _al_u121 (
    .a(_al_u116_o),
    .b(\fdat/fdat_1 [19]),
    .c(\fdat/fdat_1 [44]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [29]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E)"),
    .INIT(32'h3a3fc5cf))
    _al_u122 (
    .a(_al_u111_o),
    .b(\fdat/finv/n0 [29]),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u122_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u123 (
    .a(fctl_flp_h),
    .b(fnjp_dat[45]),
    .c(fnjp_dat[42]),
    .o(_al_u123_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u124 (
    .a(_al_u123_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[21]),
    .e(fnjp_dat[18]),
    .o(\fdat/fdat_1 [45]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u125 (
    .a(_al_u123_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[21]),
    .e(fnjp_dat[18]),
    .o(\fdat/fdat_1 [21]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u126 (
    .a(\fdat/fdat_1 [45]),
    .b(\fdat/fdat_1 [21]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u126_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u127 (
    .a(fctl_flp_h),
    .b(fnjp_dat[21]),
    .c(fnjp_dat[18]),
    .o(_al_u127_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u128 (
    .a(_al_u127_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[45]),
    .e(fnjp_dat[42]),
    .o(\fdat/fdat_1 [42]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u129 (
    .a(_al_u127_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[45]),
    .e(fnjp_dat[42]),
    .o(\fdat/fdat_1 [18]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u130 (
    .a(_al_u126_o),
    .b(\fdat/fdat_1 [42]),
    .c(\fdat/fdat_1 [18]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u130_o));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'hca3a))
    _al_u131 (
    .a(_al_u122_o),
    .b(_al_u130_o),
    .c(fnjpdatb_rd),
    .d(fctl_inv),
    .o(_al_u131_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u132 (
    .a(fctl_flp_h),
    .b(fnjp_dat[23]),
    .c(fnjp_dat[16]),
    .o(_al_u132_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u133 (
    .a(_al_u132_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[47]),
    .e(fnjp_dat[40]),
    .o(\fdat/fdat_1 [23]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u134 (
    .a(fctl_flp_h),
    .b(fnjp_dat[61]),
    .c(fnjp_dat[58]),
    .o(_al_u134_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u135 (
    .a(_al_u134_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[5]),
    .e(fnjp_dat[2]),
    .o(\fdat/fdat_1 [61]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u136 (
    .a(fctl_flp_h),
    .b(fnjp_dat[5]),
    .c(fnjp_dat[2]),
    .o(_al_u136_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u137 (
    .a(_al_u136_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[61]),
    .e(fnjp_dat[58]),
    .o(\fdat/fdat_1 [2]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfff0aacc))
    _al_u138 (
    .a(\fdat/fdat_1 [23]),
    .b(\fdat/fdat_1 [61]),
    .c(\fdat/fdat_1 [2]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u138_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u139 (
    .a(fctl_flp_h),
    .b(fnjp_dat[47]),
    .c(fnjp_dat[40]),
    .o(_al_u139_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u140 (
    .a(_al_u139_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[23]),
    .e(fnjp_dat[16]),
    .o(\fdat/fdat_1 [40]));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*~B)))"),
    .INIT(16'h758a))
    _al_u141 (
    .a(_al_u138_o),
    .b(\fdat/fdat_1 [40]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(\fdat/fdat_5 [61]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'hffc5c5c5))
    _al_u142 (
    .a(_al_u131_o),
    .b(\fdat/fdat_5 [61]),
    .c(fnjpdata_rd),
    .d(fnjpdbl_rd),
    .e(\fdbl/fnjpdbl [6]),
    .o(bdatr[13]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u143 (
    .a(_al_u104_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[15]),
    .e(fnjp_dat[8]),
    .o(\fdat/fdat_1 [8]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u144 (
    .a(_al_u98_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[55]),
    .e(fnjp_dat[48]),
    .o(\fdat/fdat_1 [55]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u145 (
    .a(\fdat/fdat_1 [8]),
    .b(\fdat/fdat_1 [55]),
    .c(\fctl/fnjpctl [1]),
    .o(_al_u145_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u146 (
    .a(_al_u101_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[62]),
    .e(fnjp_dat[57]),
    .o(\fdat/fdat_1 [57]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u147 (
    .a(_al_u96_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[6]),
    .e(fnjp_dat[1]),
    .o(\fdat/fdat_1 [6]));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(D)+~A*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(D)+~(~A)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*D+~A*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*D)"),
    .INIT(32'h0faa33aa))
    _al_u148 (
    .a(_al_u145_o),
    .b(\fdat/fdat_1 [57]),
    .c(\fdat/fdat_1 [6]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C@A))"),
    .INIT(8'h84))
    _al_u149 (
    .a(\fdat/finv/n0 [8]),
    .b(fnjpdatd_rd),
    .c(fctl_inv),
    .o(\fdat/n0 [8]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u150 (
    .a(fctl_flp_h),
    .b(fnjp_dat[60]),
    .c(fnjp_dat[59]),
    .o(_al_u150_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u151 (
    .a(_al_u150_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[4]),
    .e(fnjp_dat[3]),
    .o(\fdat/fdat_1 [59]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u152 (
    .a(fctl_flp_h),
    .b(fnjp_dat[31]),
    .c(fnjp_dat[24]),
    .o(_al_u152_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u153 (
    .a(_al_u152_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[39]),
    .e(fnjp_dat[32]),
    .o(\fdat/fdat_1 [24]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u154 (
    .a(\fdat/fdat_1 [59]),
    .b(\fdat/fdat_1 [24]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u154_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u155 (
    .a(fctl_flp_h),
    .b(fnjp_dat[4]),
    .c(fnjp_dat[3]),
    .o(_al_u155_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u156 (
    .a(_al_u155_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[60]),
    .e(fnjp_dat[59]),
    .o(\fdat/fdat_1 [4]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u157 (
    .a(fctl_flp_h),
    .b(fnjp_dat[39]),
    .c(fnjp_dat[32]),
    .o(_al_u157_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u158 (
    .a(_al_u157_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[31]),
    .e(fnjp_dat[24]),
    .o(\fdat/fdat_1 [39]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u159 (
    .a(_al_u154_o),
    .b(\fdat/fdat_1 [4]),
    .c(\fdat/fdat_1 [39]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u159_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D@B))*~(C)+A*(D@B)*~(C)+~(A)*(D@B)*C+A*(D@B)*C)"),
    .INIT(16'h3aca))
    _al_u160 (
    .a(\fdat/n0 [8]),
    .b(_al_u159_o),
    .c(fnjpdatc_rd),
    .d(fctl_inv),
    .o(\fdat/n1 [8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u161 (
    .a(\fdat/fdat_1 [61]),
    .b(\fdat/fdat_1 [40]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u161_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u162 (
    .a(_al_u161_o),
    .b(\fdat/fdat_1 [23]),
    .c(\fdat/fdat_1 [2]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u162_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D@B))*~(C)+A*(D@B)*~(C)+~(A)*(D@B)*C+A*(D@B)*C)"),
    .INIT(16'h3aca))
    _al_u163 (
    .a(\fdat/n1 [8]),
    .b(_al_u162_o),
    .c(fnjpdatb_rd),
    .d(fctl_inv),
    .o(\fdat/n2 [8]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u164 (
    .a(fctl_flp_h),
    .b(fnjp_dat[63]),
    .c(fnjp_dat[56]),
    .o(_al_u164_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u165 (
    .a(_al_u164_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[7]),
    .e(fnjp_dat[0]),
    .o(\fdat/fdat_1 [63]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u166 (
    .a(fctl_flp_h),
    .b(fnjp_dat[63]),
    .c(fnjp_dat[56]),
    .o(_al_u166_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u167 (
    .a(_al_u166_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[7]),
    .e(fnjp_dat[0]),
    .o(\fdat/fdat_1 [56]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u168 (
    .a(\fdat/fdat_1 [63]),
    .b(\fdat/fdat_1 [56]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u168_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u169 (
    .a(_al_u164_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[7]),
    .e(fnjp_dat[0]),
    .o(\fdat/fdat_1 [7]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u170 (
    .a(_al_u166_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[7]),
    .e(fnjp_dat[0]),
    .o(\fdat/fdat_1 [0]));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'h0f335555))
    _al_u171 (
    .a(_al_u168_o),
    .b(\fdat/fdat_1 [7]),
    .c(\fdat/fdat_1 [0]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [56]));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'hca3a))
    _al_u172 (
    .a(\fdat/n2 [8]),
    .b(\fdat/finv/n0 [56]),
    .c(fnjpdata_rd),
    .d(fctl_inv),
    .o(bdatr_fdat[8]));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~(E*D)*~(C*A))"),
    .INIT(32'hffececec))
    _al_u173 (
    .a(fnjp_adr[8]),
    .b(bdatr_fdat[8]),
    .c(fnjpcod_rd),
    .d(fnjpdbl_rd),
    .e(\fdbl/fnjpdbl [4]),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u174 (
    .a(fnjp_adr[9]),
    .b(fnjpcod_rd),
    .c(fnjpdbl_rd),
    .d(\fdbl/fnjpdbl [4]),
    .o(_al_u174_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u175 (
    .a(_al_u79_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[30]),
    .e(fnjp_dat[25]),
    .o(\fdat/fdat_1 [25]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u176 (
    .a(_al_u74_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[52]),
    .e(fnjp_dat[51]),
    .o(\fdat/fdat_1 [51]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u177 (
    .a(\fdat/fdat_1 [25]),
    .b(\fdat/fdat_1 [51]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u177_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u178 (
    .a(_al_u81_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[12]),
    .e(fnjp_dat[11]),
    .o(\fdat/fdat_1 [12]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u179 (
    .a(_al_u76_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[38]),
    .e(fnjp_dat[33]),
    .o(\fdat/fdat_1 [38]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u180 (
    .a(_al_u177_o),
    .b(\fdat/fdat_1 [12]),
    .c(\fdat/fdat_1 [38]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u180_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u181 (
    .a(\fdat/fdat_1 [9]),
    .b(\fdat/fdat_1 [49]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u181_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u182 (
    .a(_al_u181_o),
    .b(\fdat/fdat_1 [14]),
    .c(\fdat/fdat_1 [54]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u182_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hacaf535f))
    _al_u183 (
    .a(_al_u180_o),
    .b(_al_u182_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u183_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u184 (
    .a(_al_u92_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[46]),
    .e(fnjp_dat[41]),
    .o(\fdat/fdat_1 [41]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u185 (
    .a(_al_u85_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[53]),
    .e(fnjp_dat[50]),
    .o(\fdat/fdat_1 [53]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u186 (
    .a(\fdat/fdat_1 [41]),
    .b(\fdat/fdat_1 [53]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u186_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u187 (
    .a(_al_u90_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[13]),
    .e(fnjp_dat[10]),
    .o(\fdat/fdat_1 [10]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u188 (
    .a(_al_u87_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[22]),
    .e(fnjp_dat[17]),
    .o(\fdat/fdat_1 [22]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u189 (
    .a(_al_u186_o),
    .b(\fdat/fdat_1 [10]),
    .c(\fdat/fdat_1 [22]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u189_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'h35c5))
    _al_u190 (
    .a(_al_u183_o),
    .b(_al_u189_o),
    .c(fnjpdatb_rd),
    .d(fctl_inv),
    .o(\fdat/n2 [9]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff330f55))
    _al_u191 (
    .a(\fdat/fdat_1 [57]),
    .b(\fdat/fdat_1 [6]),
    .c(\fdat/fdat_1 [55]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u191_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*B)))"),
    .INIT(16'hd52a))
    _al_u192 (
    .a(_al_u191_o),
    .b(\fdat/fdat_1 [8]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(_al_u192_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D))"),
    .INIT(16'h5fdd))
    _al_u193 (
    .a(_al_u174_o),
    .b(\fdat/n2 [9]),
    .c(_al_u192_o),
    .d(fnjpdata_rd),
    .o(bdatr[9]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u194 (
    .a(fctl_flp_h),
    .b(fnjp_dat[28]),
    .c(fnjp_dat[27]),
    .o(_al_u194_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u195 (
    .a(_al_u194_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[36]),
    .e(fnjp_dat[35]),
    .o(\fdat/fdat_1 [28]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u196 (
    .a(fctl_flp_h),
    .b(fnjp_dat[36]),
    .c(fnjp_dat[35]),
    .o(_al_u196_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u197 (
    .a(_al_u196_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[28]),
    .e(fnjp_dat[27]),
    .o(\fdat/fdat_1 [27]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u198 (
    .a(\fdat/fdat_1 [28]),
    .b(\fdat/fdat_1 [27]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u198_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u199 (
    .a(_al_u196_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[28]),
    .e(fnjp_dat[27]),
    .o(\fdat/fdat_1 [35]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u20 (
    .a(\fcod/n14 ),
    .b(\fcod/fnjpcod [14]),
    .o(n4[0]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u200 (
    .a(_al_u194_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[36]),
    .e(fnjp_dat[35]),
    .o(\fdat/fdat_1 [36]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u201 (
    .a(_al_u198_o),
    .b(\fdat/fdat_1 [35]),
    .c(\fdat/fdat_1 [36]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u201_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u202 (
    .a(\fdat/fdat_1 [25]),
    .b(\fdat/fdat_1 [12]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u202_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u203 (
    .a(_al_u202_o),
    .b(\fdat/fdat_1 [51]),
    .c(\fdat/fdat_1 [38]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u203_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hacaf535f))
    _al_u204 (
    .a(_al_u201_o),
    .b(_al_u203_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u204_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u205 (
    .a(\fdat/fdat_1 [29]),
    .b(\fdat/fdat_1 [44]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u205_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u206 (
    .a(_al_u205_o),
    .b(\fdat/fdat_1 [19]),
    .c(\fdat/fdat_1 [34]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u206_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'h35c5))
    _al_u207 (
    .a(_al_u204_o),
    .b(_al_u206_o),
    .c(fnjpdatb_rd),
    .d(fctl_inv),
    .o(\fdat/n2 [12]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u208 (
    .a(_al_u157_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[31]),
    .e(fnjp_dat[24]),
    .o(\fdat/fdat_1 [31]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u209 (
    .a(_al_u150_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[4]),
    .e(fnjp_dat[3]),
    .o(\fdat/fdat_1 [3]));
  AL_MAP_LUT3 #(
    .EQN("~(C@(~B*A))"),
    .INIT(8'h2d))
    _al_u21 (
    .a(\fcod/n14 ),
    .b(\fcod/fnjpcod [14]),
    .c(\fcod/fnjpcod [15]),
    .o(n4[1]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u210 (
    .a(_al_u155_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[60]),
    .e(fnjp_dat[59]),
    .o(\fdat/fdat_1 [60]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*~(B)*~(E)+(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*B*~(E)+~((C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D))*B*E+(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*B*E)"),
    .INIT(32'h3333550f))
    _al_u211 (
    .a(\fdat/fdat_1 [31]),
    .b(\fdat/fdat_1 [3]),
    .c(\fdat/fdat_1 [60]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u211_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u212 (
    .a(_al_u152_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[39]),
    .e(fnjp_dat[32]),
    .o(\fdat/fdat_1 [32]));
  AL_MAP_LUT4 #(
    .EQN("(D@~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(16'hc53a))
    _al_u213 (
    .a(_al_u211_o),
    .b(\fdat/fdat_1 [32]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(_al_u213_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(C)*~(E)+~B*C*~(E)+~(~B)*C*E+~B*C*E)*~(D*A))"),
    .INIT(32'h50f01133))
    _al_u214 (
    .a(fnjp_adr[12]),
    .b(\fdat/n2 [12]),
    .c(_al_u213_o),
    .d(fnjpcod_rd),
    .e(fnjpdata_rd),
    .o(_al_u214_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u215 (
    .a(_al_u214_o),
    .b(fnjpdbl_rd),
    .c(\fdbl/fnjpdbl [6]),
    .o(bdatr[12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u216 (
    .a(\fdat/fdat_1 [27]),
    .b(\fdat/fdat_1 [35]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u216_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u217 (
    .a(_al_u216_o),
    .b(\fdat/fdat_1 [28]),
    .c(\fdat/fdat_1 [36]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u217_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u218 (
    .a(\fdat/fdat_1 [11]),
    .b(\fdat/fdat_1 [33]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u218_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u219 (
    .a(_al_u218_o),
    .b(\fdat/fdat_1 [30]),
    .c(\fdat/fdat_1 [52]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u219_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u22 (
    .a(bcmdb),
    .b(bcmdr),
    .c(bcs_fnjp_n),
    .o(_al_u22_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hacaf535f))
    _al_u220 (
    .a(_al_u217_o),
    .b(_al_u219_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u220_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u221 (
    .a(_al_u119_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[20]),
    .e(fnjp_dat[19]),
    .o(\fdat/fdat_1 [20]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u222 (
    .a(_al_u117_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[44]),
    .e(fnjp_dat[43]),
    .o(\fdat/fdat_1 [43]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u223 (
    .a(_al_u112_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[37]),
    .e(fnjp_dat[34]),
    .o(\fdat/fdat_1 [37]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffaaf0cc))
    _al_u224 (
    .a(\fdat/fdat_1 [20]),
    .b(\fdat/fdat_1 [43]),
    .c(\fdat/fdat_1 [37]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u224_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u225 (
    .a(_al_u114_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[29]),
    .e(fnjp_dat[26]),
    .o(\fdat/fdat_1 [26]));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*~B)))"),
    .INIT(16'h758a))
    _al_u226 (
    .a(_al_u224_o),
    .b(\fdat/fdat_1 [26]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(\fdat/fdat_5 [43]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff550f33))
    _al_u227 (
    .a(\fdat/fdat_1 [4]),
    .b(\fdat/fdat_1 [59]),
    .c(\fdat/fdat_1 [39]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u227_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*B)))"),
    .INIT(16'hd52a))
    _al_u228 (
    .a(_al_u227_o),
    .b(\fdat/fdat_1 [24]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(_al_u228_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*~(C)*~(D)+~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*C*~(D)+~(~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E))*C*D+~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*C*D)"),
    .INIT(32'h0fcc0f55))
    _al_u229 (
    .a(_al_u220_o),
    .b(\fdat/fdat_5 [43]),
    .c(_al_u228_o),
    .d(fnjpdata_rd),
    .e(fnjpdatb_rd),
    .o(bdatr_fdat[11]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u23 (
    .a(_al_u22_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\fctl/n6 ));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~(E*D)*~(C*A))"),
    .INIT(32'hffececec))
    _al_u230 (
    .a(fnjp_adr[11]),
    .b(bdatr_fdat[11]),
    .c(fnjpcod_rd),
    .d(fnjpdbl_rd),
    .e(\fdbl/fnjpdbl [5]),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u231 (
    .a(fnjp_adr[10]),
    .b(fnjpcod_rd),
    .c(fnjpdbl_rd),
    .d(\fdbl/fnjpdbl [5]),
    .o(_al_u231_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u232 (
    .a(\fdat/fdat_1 [41]),
    .b(\fdat/fdat_1 [10]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u232_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u233 (
    .a(_al_u232_o),
    .b(\fdat/fdat_1 [53]),
    .c(\fdat/fdat_1 [22]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u233_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u234 (
    .a(\fdat/fdat_1 [43]),
    .b(\fdat/fdat_1 [26]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u234_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u235 (
    .a(_al_u234_o),
    .b(\fdat/fdat_1 [20]),
    .c(\fdat/fdat_1 [37]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u235_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hcacf353f))
    _al_u236 (
    .a(_al_u233_o),
    .b(_al_u235_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u236_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u237 (
    .a(\fdat/fdat_1 [45]),
    .b(\fdat/fdat_1 [42]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u237_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u238 (
    .a(_al_u237_o),
    .b(\fdat/fdat_1 [21]),
    .c(\fdat/fdat_1 [18]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u238_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'h35c5))
    _al_u239 (
    .a(_al_u236_o),
    .b(_al_u238_o),
    .c(fnjpdatb_rd),
    .d(fctl_inv),
    .o(\fdat/n2 [10]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u24 (
    .a(bcmdb),
    .b(bcmdw),
    .c(bcs_fnjp_n),
    .d(brdy),
    .o(_al_u24_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u240 (
    .a(_al_u132_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[47]),
    .e(fnjp_dat[40]),
    .o(\fdat/fdat_1 [47]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u241 (
    .a(_al_u134_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[5]),
    .e(fnjp_dat[2]),
    .o(\fdat/fdat_1 [5]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u242 (
    .a(_al_u136_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[61]),
    .e(fnjp_dat[58]),
    .o(\fdat/fdat_1 [58]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*~(B)*~(E)+(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*B*~(E)+~((C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D))*B*E+(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*B*E)"),
    .INIT(32'h3333550f))
    _al_u243 (
    .a(\fdat/fdat_1 [47]),
    .b(\fdat/fdat_1 [5]),
    .c(\fdat/fdat_1 [58]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u243_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u244 (
    .a(_al_u139_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[23]),
    .e(fnjp_dat[16]),
    .o(\fdat/fdat_1 [16]));
  AL_MAP_LUT4 #(
    .EQN("(D@~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(16'hc53a))
    _al_u245 (
    .a(_al_u243_o),
    .b(\fdat/fdat_1 [16]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(_al_u245_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D))"),
    .INIT(16'h5fdd))
    _al_u246 (
    .a(_al_u231_o),
    .b(\fdat/n2 [10]),
    .c(_al_u245_o),
    .d(fnjpdata_rd),
    .o(bdatr[10]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff0f3355))
    _al_u247 (
    .a(\fdat/fdat_1 [31]),
    .b(\fdat/fdat_1 [3]),
    .c(\fdat/fdat_1 [32]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u247_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u248 (
    .a(_al_u247_o),
    .b(\fdat/fdat_1 [60]),
    .c(fctl_rot_2_lutinv),
    .o(\fdat/finv/n0 [31]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u249 (
    .a(\fdat/fdat_1 [15]),
    .b(\fdat/fdat_1 [1]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u249_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u25 (
    .a(_al_u24_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\fctl/fnjpctl_wr ));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u250 (
    .a(_al_u249_o),
    .b(\fdat/fdat_1 [62]),
    .c(\fdat/fdat_1 [48]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u250_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h5c5fa3af))
    _al_u251 (
    .a(\fdat/finv/n0 [31]),
    .b(_al_u250_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u251_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u252 (
    .a(\fdat/fdat_1 [47]),
    .b(\fdat/fdat_1 [5]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u252_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u253 (
    .a(_al_u252_o),
    .b(\fdat/fdat_1 [58]),
    .c(\fdat/fdat_1 [16]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u253_o));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'hca3a))
    _al_u254 (
    .a(_al_u251_o),
    .b(_al_u253_o),
    .c(fnjpdatb_rd),
    .d(fctl_inv),
    .o(_al_u254_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*D)*~(C*B*~A))"),
    .INIT(32'h00bfbfbf))
    _al_u255 (
    .a(\fcod/fcod_sjis ),
    .b(_al_u42_o),
    .c(fnjpcod_rd),
    .d(fnjpdbl_rd),
    .e(\fdbl/fnjpdbl [7]),
    .o(_al_u255_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff0f3355))
    _al_u256 (
    .a(\fdat/fdat_1 [63]),
    .b(\fdat/fdat_1 [7]),
    .c(\fdat/fdat_1 [0]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u256_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*B)))"),
    .INIT(16'hd52a))
    _al_u257 (
    .a(_al_u256_o),
    .b(\fdat/fdat_1 [56]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(_al_u257_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'h3f77))
    _al_u258 (
    .a(_al_u254_o),
    .b(_al_u255_o),
    .c(_al_u257_o),
    .d(fnjpdata_rd),
    .o(bdatr[15]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff55330f))
    _al_u259 (
    .a(\fdat/fdat_1 [41]),
    .b(\fdat/fdat_1 [10]),
    .c(\fdat/fdat_1 [22]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u259_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u26 (
    .a(_al_u24_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(fnjpdbl_wr));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u260 (
    .a(_al_u259_o),
    .b(\fdat/fdat_1 [53]),
    .c(fctl_rot_2_lutinv),
    .o(\fdat/finv/n0 [22]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u261 (
    .a(\fdat/fdat_1 [8]),
    .b(\fdat/fdat_1 [6]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u261_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u262 (
    .a(_al_u261_o),
    .b(\fdat/fdat_1 [57]),
    .c(\fdat/fdat_1 [55]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u262_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h5c5fa3af))
    _al_u263 (
    .a(\fdat/finv/n0 [22]),
    .b(_al_u262_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u263_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u264 (
    .a(\fdat/fdat_1 [12]),
    .b(\fdat/fdat_1 [38]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u264_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u265 (
    .a(_al_u264_o),
    .b(\fdat/fdat_1 [25]),
    .c(\fdat/fdat_1 [51]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u265_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*(~A*~((E@B))*~(D)+~A*(E@B)*~(D)+~(~A)*(E@B)*D+~A*(E@B)*D))"),
    .INIT(32'h03050c05))
    _al_u266 (
    .a(_al_u263_o),
    .b(_al_u265_o),
    .c(fnjpdata_rd),
    .d(fnjpdatb_rd),
    .e(fctl_inv),
    .o(_al_u266_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff55330f))
    _al_u267 (
    .a(\fdat/fdat_1 [9]),
    .b(\fdat/fdat_1 [14]),
    .c(\fdat/fdat_1 [54]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u267_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(E@(A*~(C*B))))"),
    .INIT(32'h2a00d500))
    _al_u268 (
    .a(_al_u267_o),
    .b(\fdat/fdat_1 [49]),
    .c(fctl_rot_2_lutinv),
    .d(fnjpdata_rd),
    .e(fctl_inv),
    .o(_al_u268_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~(D*C)*~(B*A)))"),
    .INIT(32'hf8880000))
    _al_u269 (
    .a(\fcod/n8 ),
    .b(\fcod/n9 ),
    .c(\fcod/n11 ),
    .d(\fcod/n12 ),
    .e(\fctl/fnjpctl_rd ),
    .o(bdatr_fctl[6]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u27 (
    .a(_al_u22_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\fctl/n12 ));
  AL_MAP_LUT5 #(
    .EQN("(~D*~C*~B*~(E*A))"),
    .INIT(32'h00010003))
    _al_u270 (
    .a(fnjp_adr[6]),
    .b(_al_u266_o),
    .c(_al_u268_o),
    .d(bdatr_fctl[6]),
    .e(fnjpcod_rd),
    .o(_al_u270_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u271 (
    .a(_al_u270_o),
    .b(fnjpdbl_rd),
    .c(\fdbl/fnjpdbl [3]),
    .o(bdatr[6]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u272 (
    .a(\fdat/fdat_1 [3]),
    .b(\fdat/fdat_1 [60]),
    .c(\fctl/fnjpctl [1]),
    .o(_al_u272_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E))*~(D)+~A*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*~(D)+~(~A)*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*D+~A*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*D)"),
    .INIT(32'h33aa0faa))
    _al_u273 (
    .a(_al_u272_o),
    .b(\fdat/fdat_1 [31]),
    .c(\fdat/fdat_1 [32]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [3]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(A)*~(E)+(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A*~(E)+~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*A*E+(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A*E)"),
    .INIT(32'h55550f33))
    _al_u274 (
    .a(_al_u205_o),
    .b(\fdat/fdat_1 [19]),
    .c(\fdat/fdat_1 [34]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [19]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E)"),
    .INIT(32'h353fcacf))
    _al_u275 (
    .a(\fdat/finv/n0 [3]),
    .b(\fdat/finv/n0 [19]),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u275_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u276 (
    .a(\fdat/fdat_1 [35]),
    .b(\fdat/fdat_1 [36]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u276_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u277 (
    .a(_al_u276_o),
    .b(\fdat/fdat_1 [28]),
    .c(\fdat/fdat_1 [27]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u277_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*(~A*~((E@B))*~(D)+~A*(E@B)*~(D)+~(~A)*(E@B)*D+~A*(E@B)*D))"),
    .INIT(32'h03050c05))
    _al_u278 (
    .a(_al_u275_o),
    .b(_al_u277_o),
    .c(fnjpdata_rd),
    .d(fnjpdatb_rd),
    .e(fctl_inv),
    .o(_al_u278_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff330f55))
    _al_u279 (
    .a(\fdat/fdat_1 [51]),
    .b(\fdat/fdat_1 [12]),
    .c(\fdat/fdat_1 [38]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u279_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u28 (
    .a(_al_u22_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\fctl/n9 ));
  AL_MAP_LUT5 #(
    .EQN("(D*~(E@(A*~(C*B))))"),
    .INIT(32'h2a00d500))
    _al_u280 (
    .a(_al_u279_o),
    .b(\fdat/fdat_1 [25]),
    .c(fctl_rot_2_lutinv),
    .d(fnjpdata_rd),
    .e(fctl_inv),
    .o(_al_u280_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u281 (
    .a(\fctl/fnjpctl_rd ),
    .b(fnjpdbl_rd),
    .c(fctl_flp_h),
    .d(\fdbl/fnjpdbl [1]),
    .o(_al_u281_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~C*~B*~(E*A))"),
    .INIT(32'hfefffcff))
    _al_u282 (
    .a(fnjp_adr[3]),
    .b(_al_u278_o),
    .c(_al_u280_o),
    .d(_al_u281_o),
    .e(fnjpcod_rd),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u283 (
    .a(\fctl/fnjpctl_rd ),
    .b(fnjpdbl_rd),
    .c(fctl_inv),
    .d(\fdbl/fnjpdbl [2]),
    .o(_al_u283_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u284 (
    .a(fnjp_adr[4]),
    .b(_al_u283_o),
    .c(fnjpcod_rd),
    .o(_al_u284_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u285 (
    .a(\fdat/fdat_1 [4]),
    .b(\fdat/fdat_1 [24]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u285_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u286 (
    .a(_al_u285_o),
    .b(\fdat/fdat_1 [59]),
    .c(\fdat/fdat_1 [39]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u286_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~B*(D@A))"),
    .INIT(16'h1020))
    _al_u287 (
    .a(_al_u286_o),
    .b(fnjpdatc_rd),
    .c(fnjpdatd_rd),
    .d(fctl_inv),
    .o(_al_u287_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u288 (
    .a(\fdat/fdat_1 [20]),
    .b(\fdat/fdat_1 [26]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u288_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'h0f335555))
    _al_u289 (
    .a(_al_u288_o),
    .b(\fdat/fdat_1 [43]),
    .c(\fdat/fdat_1 [37]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [20]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u29 (
    .a(_al_u24_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(fnjpcod_wr));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C@A))"),
    .INIT(8'h84))
    _al_u290 (
    .a(\fdat/finv/n0 [20]),
    .b(fnjpdatc_rd),
    .c(fctl_inv),
    .o(_al_u290_o));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'h5555330f))
    _al_u291 (
    .a(_al_u216_o),
    .b(\fdat/fdat_1 [28]),
    .c(\fdat/fdat_1 [36]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [36]));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~A)*~((E@C))*~(D)+(~B*~A)*(E@C)*~(D)+~((~B*~A))*(E@C)*D+(~B*~A)*(E@C)*D)"),
    .INIT(32'hf0ee0fee))
    _al_u292 (
    .a(_al_u287_o),
    .b(_al_u290_o),
    .c(\fdat/finv/n0 [36]),
    .d(fnjpdatb_rd),
    .e(fctl_inv),
    .o(\fdat/n2 [4]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff55330f))
    _al_u293 (
    .a(\fdat/fdat_1 [11]),
    .b(\fdat/fdat_1 [30]),
    .c(\fdat/fdat_1 [52]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u293_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*B)))"),
    .INIT(16'hd52a))
    _al_u294 (
    .a(_al_u293_o),
    .b(\fdat/fdat_1 [33]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(_al_u294_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D))"),
    .INIT(16'h5fdd))
    _al_u295 (
    .a(_al_u284_o),
    .b(\fdat/n2 [4]),
    .c(_al_u294_o),
    .d(fnjpdata_rd),
    .o(bdatr[4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u296 (
    .a(\fdat/fdat_1 [42]),
    .b(\fdat/fdat_1 [18]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u296_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u297 (
    .a(_al_u296_o),
    .b(\fdat/fdat_1 [45]),
    .c(\fdat/fdat_1 [21]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u297_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u298 (
    .a(\fdat/fdat_1 [40]),
    .b(\fdat/fdat_1 [2]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u298_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'h330f5555))
    _al_u299 (
    .a(_al_u298_o),
    .b(\fdat/fdat_1 [23]),
    .c(\fdat/fdat_1 [61]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u30 (
    .a(badr[3]),
    .b(badr[2]),
    .c(bcmdr),
    .d(bcs_fnjp_n),
    .o(_al_u30_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'ha3af5c5f))
    _al_u300 (
    .a(_al_u297_o),
    .b(\fdat/finv/n0 [2]),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u300_o));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'h5555330f))
    _al_u301 (
    .a(\fdat/fdat_1 [29]),
    .b(\fdat/fdat_1 [44]),
    .c(\fdat/fdat_1 [34]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u301_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'h3a))
    _al_u302 (
    .a(_al_u301_o),
    .b(\fdat/fdat_1 [19]),
    .c(fctl_rot_2_lutinv),
    .o(\fdat/finv/n0 [34]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(A*~((E@B))*~(D)+A*(E@B)*~(D)+~(A)*(E@B)*D+A*(E@B)*D))"),
    .INIT(32'h0c050305))
    _al_u303 (
    .a(_al_u300_o),
    .b(\fdat/finv/n0 [34]),
    .c(fnjpdata_rd),
    .d(fnjpdatb_rd),
    .e(fctl_inv),
    .o(_al_u303_o));
  AL_MAP_LUT5 #(
    .EQN("(C*(E@(B*~(A)*~(D)+B*A*~(D)+~(B)*A*D+B*A*D)))"),
    .INIT(32'h5030a0c0))
    _al_u304 (
    .a(_al_u109_o),
    .b(_al_u110_o),
    .c(fnjpdata_rd),
    .d(\fctl/fnjpctl [1]),
    .e(fctl_inv),
    .o(_al_u304_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u305 (
    .a(\fctl/fnjpctl_rd ),
    .b(fnjpdbl_rd),
    .c(fctl_flp_v),
    .d(\fdbl/fnjpdbl [1]),
    .o(_al_u305_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~C*~B*~(E*A))"),
    .INIT(32'hfefffcff))
    _al_u306 (
    .a(fnjp_adr[2]),
    .b(_al_u303_o),
    .c(_al_u304_o),
    .d(_al_u305_o),
    .e(fnjpcod_rd),
    .o(bdatr[2]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u307 (
    .a(\fdat/fdat_1 [5]),
    .b(\fdat/fdat_1 [58]),
    .c(\fctl/fnjpctl [1]),
    .o(_al_u307_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E))*~(D)+~A*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*~(D)+~(~A)*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*D+~A*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*D)"),
    .INIT(32'h33aa0faa))
    _al_u308 (
    .a(_al_u307_o),
    .b(\fdat/fdat_1 [47]),
    .c(\fdat/fdat_1 [16]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [5]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(A)*~(E)+(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A*~(E)+~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*A*E+(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A*E)"),
    .INIT(32'h55550f33))
    _al_u309 (
    .a(_al_u237_o),
    .b(\fdat/fdat_1 [21]),
    .c(\fdat/fdat_1 [18]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [21]));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(~D*C))"),
    .INIT(16'h2202))
    _al_u31 (
    .a(_al_u30_o),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmdb),
    .o(\fctl/n27 ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E)"),
    .INIT(32'h353fcacf))
    _al_u310 (
    .a(\fdat/finv/n0 [5]),
    .b(\fdat/finv/n0 [21]),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u310_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u311 (
    .a(\fdat/fdat_1 [20]),
    .b(\fdat/fdat_1 [37]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u311_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u312 (
    .a(_al_u311_o),
    .b(\fdat/fdat_1 [43]),
    .c(\fdat/fdat_1 [26]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u312_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*(~A*~((E@B))*~(D)+~A*(E@B)*~(D)+~(~A)*(E@B)*D+~A*(E@B)*D))"),
    .INIT(32'h03050c05))
    _al_u313 (
    .a(_al_u310_o),
    .b(_al_u312_o),
    .c(fnjpdata_rd),
    .d(fnjpdatb_rd),
    .e(fctl_inv),
    .o(_al_u313_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u314 (
    .a(\fdat/fdat_1 [53]),
    .b(\fdat/fdat_1 [22]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u314_o));
  AL_MAP_LUT5 #(
    .EQN("(C*(E@(B*~(A)*~(D)+B*A*~(D)+~(B)*A*D+B*A*D)))"),
    .INIT(32'h5030a0c0))
    _al_u315 (
    .a(_al_u232_o),
    .b(_al_u314_o),
    .c(fnjpdata_rd),
    .d(\fctl/fnjpctl [1]),
    .e(fctl_inv),
    .o(_al_u315_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u316 (
    .a(\fctl/fnjpctl_rd ),
    .b(fnjpdbl_rd),
    .c(fctl_ktc),
    .d(\fdbl/fnjpdbl [2]),
    .o(_al_u316_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~C*~B*~(E*A))"),
    .INIT(32'hfefffcff))
    _al_u317 (
    .a(fnjp_adr[5]),
    .b(_al_u313_o),
    .c(_al_u315_o),
    .d(_al_u316_o),
    .e(fnjpcod_rd),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u318 (
    .a(fnjp_adr[1]),
    .b(fnjpcod_rd),
    .c(fnjpdbl_rd),
    .d(\fdbl/fnjpdbl [0]),
    .o(_al_u318_o));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'h5555330f))
    _al_u319 (
    .a(_al_u100_o),
    .b(\fdat/fdat_1 [48]),
    .c(\fdat/fdat_1 [1]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u32 (
    .a(badr[3]),
    .b(badr[2]),
    .c(bcmdr),
    .d(bcs_fnjp_n),
    .o(_al_u32_o));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'h5555330f))
    _al_u320 (
    .a(_al_u89_o),
    .b(\fdat/fdat_1 [50]),
    .c(\fdat/fdat_1 [17]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [17]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E)"),
    .INIT(32'h353fcacf))
    _al_u321 (
    .a(\fdat/finv/n0 [1]),
    .b(\fdat/finv/n0 [17]),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u321_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffccf0aa))
    _al_u322 (
    .a(\fdat/fdat_1 [33]),
    .b(\fdat/fdat_1 [30]),
    .c(\fdat/fdat_1 [52]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u322_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*~B)))"),
    .INIT(16'h758a))
    _al_u323 (
    .a(_al_u322_o),
    .b(\fdat/fdat_1 [11]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(\fdat/fdat_5 [33]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffccf0aa))
    _al_u324 (
    .a(\fdat/fdat_1 [49]),
    .b(\fdat/fdat_1 [14]),
    .c(\fdat/fdat_1 [54]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u324_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*~B)))"),
    .INIT(16'h758a))
    _al_u325 (
    .a(_al_u324_o),
    .b(\fdat/fdat_1 [9]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(\fdat/fdat_5 [49]));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*~(C)*~(D)+(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*C*~(D)+~((~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E))*C*D+(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*C*D)"),
    .INIT(32'h0f330faa))
    _al_u326 (
    .a(_al_u321_o),
    .b(\fdat/fdat_5 [33]),
    .c(\fdat/fdat_5 [49]),
    .d(fnjpdata_rd),
    .e(fnjpdatb_rd),
    .o(_al_u326_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*A*~(D*C))"),
    .INIT(16'hf777))
    _al_u327 (
    .a(_al_u318_o),
    .b(_al_u326_o),
    .c(\fctl/fnjpctl_rd ),
    .d(\fctl/fnjpctl [1]),
    .o(bdatr[1]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffccf0aa))
    _al_u328 (
    .a(\fdat/fdat_1 [7]),
    .b(\fdat/fdat_1 [56]),
    .c(\fdat/fdat_1 [0]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u328_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(C*~B)))"),
    .INIT(16'h758a))
    _al_u329 (
    .a(_al_u328_o),
    .b(\fdat/fdat_1 [63]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(\fdat/fdat_5 [7]));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(~D*C))"),
    .INIT(16'h2202))
    _al_u33 (
    .a(_al_u32_o),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmdb),
    .o(\fctl/n17 ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u330 (
    .a(\fdat/fdat_1 [23]),
    .b(\fdat/fdat_1 [2]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u330_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u331 (
    .a(_al_u330_o),
    .b(\fdat/fdat_1 [61]),
    .c(\fdat/fdat_1 [40]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u331_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*A)*~((E@B))*~(C)+(D*A)*(E@B)*~(C)+~((D*A))*(E@B)*C+(D*A)*(E@B)*C)"),
    .INIT(32'hc5cf353f))
    _al_u332 (
    .a(\fdat/fdat_5 [7]),
    .b(_al_u331_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u332_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u333 (
    .a(\fdat/fdat_1 [4]),
    .b(\fdat/fdat_1 [39]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u333_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u334 (
    .a(_al_u333_o),
    .b(\fdat/fdat_1 [59]),
    .c(\fdat/fdat_1 [24]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u334_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'h35c5))
    _al_u335 (
    .a(_al_u332_o),
    .b(_al_u334_o),
    .c(fnjpdatb_rd),
    .d(fctl_inv),
    .o(\fdat/n2 [7]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'h5555330f))
    _al_u336 (
    .a(\fdat/fdat_1 [8]),
    .b(\fdat/fdat_1 [6]),
    .c(\fdat/fdat_1 [55]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u336_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(16'hc53a))
    _al_u337 (
    .a(_al_u336_o),
    .b(\fdat/fdat_1 [57]),
    .c(fctl_rot_2_lutinv),
    .d(fctl_inv),
    .o(_al_u337_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*~(D*~C))"),
    .INIT(32'hc0cc5055))
    _al_u338 (
    .a(\fdat/n2 [7]),
    .b(_al_u337_o),
    .c(_al_u36_o),
    .d(\fctl/fnjpctl_rd ),
    .e(fnjpdata_rd),
    .o(_al_u338_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(E*D)*~(C*A))"),
    .INIT(32'hffb3b3b3))
    _al_u339 (
    .a(fnjp_adr[7]),
    .b(_al_u338_o),
    .c(fnjpcod_rd),
    .d(fnjpdbl_rd),
    .e(\fdbl/fnjpdbl [3]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(~D*C))"),
    .INIT(16'h8808))
    _al_u34 (
    .a(_al_u32_o),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmdb),
    .o(\fctl/n22 ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u340 (
    .a(\fdat/fdat_1 [56]),
    .b(\fdat/fdat_1 [0]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u340_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u341 (
    .a(_al_u340_o),
    .b(\fdat/fdat_1 [63]),
    .c(\fdat/fdat_1 [7]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u341_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u342 (
    .a(\fdat/fdat_1 [58]),
    .b(\fdat/fdat_1 [16]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u342_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u343 (
    .a(_al_u342_o),
    .b(\fdat/fdat_1 [47]),
    .c(\fdat/fdat_1 [5]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u343_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hcacf353f))
    _al_u344 (
    .a(_al_u341_o),
    .b(_al_u343_o),
    .c(fnjpdatc_rd),
    .d(fnjpdatd_rd),
    .e(fctl_inv),
    .o(_al_u344_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u345 (
    .a(\fdat/fdat_1 [60]),
    .b(\fdat/fdat_1 [32]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u345_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'hf0ccaaaa))
    _al_u346 (
    .a(_al_u345_o),
    .b(\fdat/fdat_1 [31]),
    .c(\fdat/fdat_1 [3]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u346_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*(~A*~((E@B))*~(D)+~A*(E@B)*~(D)+~(~A)*(E@B)*D+~A*(E@B)*D))"),
    .INIT(32'h03050c05))
    _al_u347 (
    .a(_al_u344_o),
    .b(_al_u346_o),
    .c(fnjpdata_rd),
    .d(fnjpdatb_rd),
    .e(fctl_inv),
    .o(_al_u347_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff33550f))
    _al_u348 (
    .a(\fdat/fdat_1 [62]),
    .b(\fdat/fdat_1 [15]),
    .c(\fdat/fdat_1 [48]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u348_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(E@(A*~(C*B))))"),
    .INIT(32'h2a00d500))
    _al_u349 (
    .a(_al_u348_o),
    .b(\fdat/fdat_1 [1]),
    .c(fctl_rot_2_lutinv),
    .d(fnjpdata_rd),
    .e(fctl_inv),
    .o(_al_u349_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(~D*C))"),
    .INIT(16'h8808))
    _al_u35 (
    .a(_al_u30_o),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmdb),
    .o(\fctl/n32 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u350 (
    .a(\fctl/fnjpctl_rd ),
    .b(fnjpdbl_rd),
    .c(\fctl/fnjpctl [0]),
    .d(\fdbl/fnjpdbl [0]),
    .o(_al_u350_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~C*~B*~(E*A))"),
    .INIT(32'hfefffcff))
    _al_u351 (
    .a(fnjp_adr[0]),
    .b(_al_u347_o),
    .c(_al_u349_o),
    .d(_al_u350_o),
    .e(fnjpcod_rd),
    .o(bdatr[0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u352 (
    .a(\fcod/n16 ),
    .o(\fcod/n17 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u36 (
    .a(\fcod/n2 ),
    .b(\fcod/n3 ),
    .c(\fcod/n5 ),
    .d(\fcod/n6 ),
    .o(_al_u36_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(E*D)*~(C*B)))"),
    .INIT(32'h55404040))
    _al_u37 (
    .a(_al_u36_o),
    .b(\fcod/n8 ),
    .c(\fcod/n9 ),
    .d(\fcod/n11 ),
    .e(\fcod/n12 ),
    .o(\fcod/fcod_sjis ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u38 (
    .a(\fcod/fnjpcod [4]),
    .b(\fcod/fnjpcod [5]),
    .c(\fcod/fnjpcod [6]),
    .d(\fcod/fnjpcod [7]),
    .o(_al_u38_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u39 (
    .a(_al_u38_o),
    .b(\fcod/fnjpcod [0]),
    .c(\fcod/fnjpcod [1]),
    .d(\fcod/fnjpcod [2]),
    .e(\fcod/fnjpcod [3]),
    .o(\fcod/fcod_ascii_1_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u40 (
    .a(\fcod/fnjpcod [10]),
    .b(\fcod/fnjpcod [11]),
    .c(\fcod/fnjpcod [12]),
    .d(\fcod/fnjpcod [13]),
    .o(_al_u40_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u41 (
    .a(_al_u40_o),
    .b(\fcod/fnjpcod [14]),
    .c(\fcod/fnjpcod [15]),
    .d(\fcod/fnjpcod [8]),
    .e(\fcod/fnjpcod [9]),
    .o(\fcod/fcod_ascii_2_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u42 (
    .a(\fcod/fcod_ascii_1_lutinv ),
    .b(\fcod/fcod_ascii_2_lutinv ),
    .c(fctl_ktc),
    .o(_al_u42_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(C*~(B*A)))"),
    .INIT(32'h8f008f8f))
    _al_u43 (
    .a(\fcod/codkt_1 [9]),
    .b(\fcod/fcod_sjis ),
    .c(_al_u42_o),
    .d(\fcod/fnjpcod [9]),
    .e(fctl_ktc),
    .o(fnjp_adr[9]));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(C*~(B*A)))"),
    .INIT(32'h8f008f8f))
    _al_u44 (
    .a(\fcod/codkt_1 [8]),
    .b(\fcod/fcod_sjis ),
    .c(_al_u42_o),
    .d(\fcod/fnjpcod [8]),
    .e(fctl_ktc),
    .o(fnjp_adr[8]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u45 (
    .a(\fcod/fcod_sjis ),
    .b(\fcod/fcod_ascii_1_lutinv ),
    .c(\fcod/fcod_ascii_2_lutinv ),
    .o(\fcod/mux4_b10_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u46 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [15]),
    .c(\fcod/fnjpcod [7]),
    .o(_al_u46_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u47 (
    .a(\fcod/codkt_1 [7]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(_al_u46_o),
    .d(\fcod/fnjpcod [7]),
    .e(fctl_ktc),
    .o(fnjp_adr[7]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u48 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [14]),
    .c(\fcod/fnjpcod [6]),
    .o(_al_u48_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u49 (
    .a(\fcod/codkt_1 [6]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(_al_u48_o),
    .d(\fcod/fnjpcod [6]),
    .e(fctl_ktc),
    .o(fnjp_adr[6]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u50 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [13]),
    .c(\fcod/fnjpcod [5]),
    .o(_al_u50_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u51 (
    .a(\fcod/codkt_1 [5]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(_al_u50_o),
    .d(\fcod/fnjpcod [5]),
    .e(fctl_ktc),
    .o(fnjp_adr[5]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u52 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [12]),
    .c(\fcod/fnjpcod [4]),
    .o(_al_u52_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u53 (
    .a(\fcod/codkt_1 [4]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(_al_u52_o),
    .d(\fcod/fnjpcod [4]),
    .e(fctl_ktc),
    .o(fnjp_adr[4]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u54 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [11]),
    .c(\fcod/fnjpcod [3]),
    .o(_al_u54_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u55 (
    .a(\fcod/codkt_1 [3]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(_al_u54_o),
    .d(\fcod/fnjpcod [3]),
    .e(fctl_ktc),
    .o(fnjp_adr[3]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u56 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [10]),
    .c(\fcod/fnjpcod [2]),
    .o(_al_u56_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u57 (
    .a(\fcod/codkt_1 [2]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(_al_u56_o),
    .d(\fcod/fnjpcod [2]),
    .e(fctl_ktc),
    .o(fnjp_adr[2]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u58 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [1]),
    .c(\fcod/fnjpcod [9]),
    .o(_al_u58_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u59 (
    .a(\fcod/codkt_1 [1]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(_al_u58_o),
    .d(\fcod/fnjpcod [1]),
    .e(fctl_ktc),
    .o(fnjp_adr[1]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u60 (
    .a(_al_u42_o),
    .b(\fcod/fnjpcod [0]),
    .c(\fcod/fnjpcod [8]),
    .o(_al_u60_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D)*~(~C*~(B*A)))"),
    .INIT(32'hf800f8f8))
    _al_u61 (
    .a(\fcod/mux4_b10_sel_is_2_o ),
    .b(\fcod/codt_4 [0]),
    .c(_al_u60_o),
    .d(\fcod/fnjpcod [0]),
    .e(fctl_ktc),
    .o(fnjp_adr[0]));
  AL_MAP_LUT4 #(
    .EQN("((B*A)*~(C)*~(D)+(B*A)*C*~(D)+~((B*A))*C*D+(B*A)*C*D)"),
    .INIT(16'hf088))
    _al_u62 (
    .a(\fcod/codkt_1 [12]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(\fcod/fnjpcod [12]),
    .d(fctl_ktc),
    .o(fnjp_adr[12]));
  AL_MAP_LUT4 #(
    .EQN("((B*A)*~(C)*~(D)+(B*A)*C*~(D)+~((B*A))*C*D+(B*A)*C*D)"),
    .INIT(16'hf088))
    _al_u63 (
    .a(\fcod/codkt_1 [11]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(\fcod/fnjpcod [11]),
    .d(fctl_ktc),
    .o(fnjp_adr[11]));
  AL_MAP_LUT4 #(
    .EQN("((B*A)*~(C)*~(D)+(B*A)*C*~(D)+~((B*A))*C*D+(B*A)*C*D)"),
    .INIT(16'hf088))
    _al_u64 (
    .a(\fcod/codkt_1 [10]),
    .b(\fcod/mux4_b10_sel_is_2_o ),
    .c(\fcod/fnjpcod [10]),
    .d(fctl_ktc),
    .o(fnjp_adr[10]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u65 (
    .a(fctl_flp_h),
    .b(fnjp_dat[54]),
    .c(fnjp_dat[49]),
    .o(_al_u65_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u66 (
    .a(_al_u65_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[14]),
    .e(fnjp_dat[9]),
    .o(\fdat/fdat_1 [9]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u67 (
    .a(fctl_flp_h),
    .b(fnjp_dat[14]),
    .c(fnjp_dat[9]),
    .o(_al_u67_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u68 (
    .a(_al_u67_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[54]),
    .e(fnjp_dat[49]),
    .o(\fdat/fdat_1 [14]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u69 (
    .a(\fdat/fdat_1 [9]),
    .b(\fdat/fdat_1 [14]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u69_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u70 (
    .a(_al_u65_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[14]),
    .e(fnjp_dat[9]),
    .o(\fdat/fdat_1 [49]));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u71 (
    .a(_al_u67_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[54]),
    .e(fnjp_dat[49]),
    .o(\fdat/fdat_1 [54]));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'h0f335555))
    _al_u72 (
    .a(_al_u69_o),
    .b(\fdat/fdat_1 [49]),
    .c(\fdat/fdat_1 [54]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [14]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C@A))"),
    .INIT(8'h84))
    _al_u73 (
    .a(\fdat/finv/n0 [14]),
    .b(fnjpdatd_rd),
    .c(fctl_inv),
    .o(\fdat/n0 [14]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u74 (
    .a(fctl_flp_h),
    .b(fnjp_dat[12]),
    .c(fnjp_dat[11]),
    .o(_al_u74_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u75 (
    .a(_al_u74_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[52]),
    .e(fnjp_dat[51]),
    .o(\fdat/fdat_1 [11]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u76 (
    .a(fctl_flp_h),
    .b(fnjp_dat[30]),
    .c(fnjp_dat[25]),
    .o(_al_u76_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u77 (
    .a(_al_u76_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[38]),
    .e(fnjp_dat[33]),
    .o(\fdat/fdat_1 [30]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u78 (
    .a(\fdat/fdat_1 [11]),
    .b(\fdat/fdat_1 [30]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u78_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u79 (
    .a(fctl_flp_h),
    .b(fnjp_dat[38]),
    .c(fnjp_dat[33]),
    .o(_al_u79_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u80 (
    .a(_al_u79_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[30]),
    .e(fnjp_dat[25]),
    .o(\fdat/fdat_1 [33]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u81 (
    .a(fctl_flp_h),
    .b(fnjp_dat[52]),
    .c(fnjp_dat[51]),
    .o(_al_u81_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u82 (
    .a(_al_u81_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[12]),
    .e(fnjp_dat[11]),
    .o(\fdat/fdat_1 [52]));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(E)+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(E)+~(A)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E+A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*E)"),
    .INIT(32'h0f335555))
    _al_u83 (
    .a(_al_u78_o),
    .b(\fdat/fdat_1 [33]),
    .c(\fdat/fdat_1 [52]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(\fdat/finv/n0 [30]));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~((D@B))*~(C)+~A*(D@B)*~(C)+~(~A)*(D@B)*C+~A*(D@B)*C)"),
    .INIT(16'hca3a))
    _al_u84 (
    .a(\fdat/n0 [14]),
    .b(\fdat/finv/n0 [30]),
    .c(fnjpdatc_rd),
    .d(fctl_inv),
    .o(\fdat/n1 [14]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u85 (
    .a(fctl_flp_h),
    .b(fnjp_dat[13]),
    .c(fnjp_dat[10]),
    .o(_al_u85_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u86 (
    .a(_al_u85_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[53]),
    .e(fnjp_dat[50]),
    .o(\fdat/fdat_1 [13]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u87 (
    .a(fctl_flp_h),
    .b(fnjp_dat[46]),
    .c(fnjp_dat[41]),
    .o(_al_u87_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u88 (
    .a(_al_u87_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[22]),
    .e(fnjp_dat[17]),
    .o(\fdat/fdat_1 [46]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u89 (
    .a(\fdat/fdat_1 [13]),
    .b(\fdat/fdat_1 [46]),
    .c(\fctl/fnjpctl [0]),
    .o(_al_u89_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u90 (
    .a(fctl_flp_h),
    .b(fnjp_dat[53]),
    .c(fnjp_dat[50]),
    .o(_al_u90_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u91 (
    .a(_al_u90_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[13]),
    .e(fnjp_dat[10]),
    .o(\fdat/fdat_1 [50]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u92 (
    .a(fctl_flp_h),
    .b(fnjp_dat[22]),
    .c(fnjp_dat[17]),
    .o(_al_u92_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u93 (
    .a(_al_u92_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[46]),
    .e(fnjp_dat[41]),
    .o(\fdat/fdat_1 [17]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*~(E)+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E)+~(A)*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E+A*(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*E)"),
    .INIT(32'hccf0aaaa))
    _al_u94 (
    .a(_al_u89_o),
    .b(\fdat/fdat_1 [50]),
    .c(\fdat/fdat_1 [17]),
    .d(\fctl/fnjpctl [0]),
    .e(\fctl/fnjpctl [1]),
    .o(_al_u94_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*(A*~((E@B))*~(D)+A*(E@B)*~(D)+~(A)*(E@B)*D+A*(E@B)*D))"),
    .INIT(32'h030a0c0a))
    _al_u95 (
    .a(\fdat/n1 [14]),
    .b(_al_u94_o),
    .c(fnjpdata_rd),
    .d(fnjpdatb_rd),
    .e(fctl_inv),
    .o(_al_u95_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u96 (
    .a(fctl_flp_h),
    .b(fnjp_dat[62]),
    .c(fnjp_dat[57]),
    .o(_al_u96_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u97 (
    .a(_al_u96_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[6]),
    .e(fnjp_dat[1]),
    .o(\fdat/fdat_1 [62]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u98 (
    .a(fctl_flp_h),
    .b(fnjp_dat[15]),
    .c(fnjp_dat[8]),
    .o(_al_u98_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(~A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'hddd11d11))
    _al_u99 (
    .a(_al_u98_o),
    .b(fctl_flp_v),
    .c(fctl_flp_h),
    .d(fnjp_dat[55]),
    .e(fnjp_dat[48]),
    .o(\fdat/fdat_1 [15]));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_0  (
    .a(1'b1),
    .b(\fcod/fnjpcod [8]),
    .c(\fcod/lt0_c0 ),
    .o({\fcod/lt0_c1 ,open_n0}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_1  (
    .a(1'b0),
    .b(\fcod/fnjpcod [9]),
    .c(\fcod/lt0_c1 ),
    .o({\fcod/lt0_c2 ,open_n1}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_2  (
    .a(1'b0),
    .b(\fcod/fnjpcod [10]),
    .c(\fcod/lt0_c2 ),
    .o({\fcod/lt0_c3 ,open_n2}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_3  (
    .a(1'b0),
    .b(\fcod/fnjpcod [11]),
    .c(\fcod/lt0_c3 ),
    .o({\fcod/lt0_c4 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_4  (
    .a(1'b0),
    .b(\fcod/fnjpcod [12]),
    .c(\fcod/lt0_c4 ),
    .o({\fcod/lt0_c5 ,open_n4}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_5  (
    .a(1'b0),
    .b(\fcod/fnjpcod [13]),
    .c(\fcod/lt0_c5 ),
    .o({\fcod/lt0_c6 ,open_n5}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_6  (
    .a(1'b0),
    .b(\fcod/fnjpcod [14]),
    .c(\fcod/lt0_c6 ),
    .o({\fcod/lt0_c7 ,open_n6}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_7  (
    .a(1'b1),
    .b(\fcod/fnjpcod [15]),
    .c(\fcod/lt0_c7 ),
    .o({\fcod/lt0_c8 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt0_cin  (
    .a(1'b1),
    .o({\fcod/lt0_c0 ,open_n10}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt0_c8 ),
    .o({open_n11,\fcod/n2 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_0  (
    .a(1'b0),
    .b(\fcod/codt_3 [0]),
    .c(\fcod/lt10_2_c0 ),
    .o({\fcod/lt10_2_c1 ,open_n12}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_1  (
    .a(1'b1),
    .b(\fcod/codt_3 [1]),
    .c(\fcod/lt10_2_c1 ),
    .o({\fcod/lt10_2_c2 ,open_n13}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_2  (
    .a(1'b1),
    .b(\fcod/codt_3 [2]),
    .c(\fcod/lt10_2_c2 ),
    .o({\fcod/lt10_2_c3 ,open_n14}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_3  (
    .a(1'b1),
    .b(\fcod/codt_3 [3]),
    .c(\fcod/lt10_2_c3 ),
    .o({\fcod/lt10_2_c4 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_4  (
    .a(1'b1),
    .b(\fcod/codt_3 [4]),
    .c(\fcod/lt10_2_c4 ),
    .o({\fcod/lt10_2_c5 ,open_n16}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_5  (
    .a(1'b0),
    .b(\fcod/codt_3 [5]),
    .c(\fcod/lt10_2_c5 ),
    .o({\fcod/lt10_2_c6 ,open_n17}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_6  (
    .a(1'b1),
    .b(\fcod/codt_3 [6]),
    .c(\fcod/lt10_2_c6 ),
    .o({\fcod/lt10_2_c7 ,open_n18}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_7  (
    .a(1'b0),
    .b(\fcod/codt_3 [7]),
    .c(\fcod/lt10_2_c7 ),
    .o({\fcod/lt10_2_c8 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_8  (
    .a(1'b0),
    .b(\fcod/codt_3 [15]),
    .c(\fcod/lt10_2_c8 ),
    .o({\fcod/lt10_2_c9 ,open_n20}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt10_2_cin  (
    .a(1'b0),
    .o({\fcod/lt10_2_c0 ,open_n23}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt10_2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt10_2_c9 ),
    .o({open_n24,\fcod/n16 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_0  (
    .a(\fcod/fnjpcod [8]),
    .b(1'b1),
    .c(\fcod/lt1_c0 ),
    .o({\fcod/lt1_c1 ,open_n25}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_1  (
    .a(\fcod/fnjpcod [9]),
    .b(1'b1),
    .c(\fcod/lt1_c1 ),
    .o({\fcod/lt1_c2 ,open_n26}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_2  (
    .a(\fcod/fnjpcod [10]),
    .b(1'b1),
    .c(\fcod/lt1_c2 ),
    .o({\fcod/lt1_c3 ,open_n27}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_3  (
    .a(\fcod/fnjpcod [11]),
    .b(1'b1),
    .c(\fcod/lt1_c3 ),
    .o({\fcod/lt1_c4 ,open_n28}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_4  (
    .a(\fcod/fnjpcod [12]),
    .b(1'b1),
    .c(\fcod/lt1_c4 ),
    .o({\fcod/lt1_c5 ,open_n29}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_5  (
    .a(\fcod/fnjpcod [13]),
    .b(1'b0),
    .c(\fcod/lt1_c5 ),
    .o({\fcod/lt1_c6 ,open_n30}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_6  (
    .a(\fcod/fnjpcod [14]),
    .b(1'b0),
    .c(\fcod/lt1_c6 ),
    .o({\fcod/lt1_c7 ,open_n31}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_7  (
    .a(\fcod/fnjpcod [15]),
    .b(1'b1),
    .c(\fcod/lt1_c7 ),
    .o({\fcod/lt1_c8 ,open_n32}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt1_cin  (
    .a(1'b1),
    .o({\fcod/lt1_c0 ,open_n35}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt1_c8 ),
    .o({open_n36,\fcod/n3 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_0  (
    .a(1'b0),
    .b(\fcod/fnjpcod [8]),
    .c(\fcod/lt2_c0 ),
    .o({\fcod/lt2_c1 ,open_n37}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_1  (
    .a(1'b0),
    .b(\fcod/fnjpcod [9]),
    .c(\fcod/lt2_c1 ),
    .o({\fcod/lt2_c2 ,open_n38}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_2  (
    .a(1'b0),
    .b(\fcod/fnjpcod [10]),
    .c(\fcod/lt2_c2 ),
    .o({\fcod/lt2_c3 ,open_n39}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_3  (
    .a(1'b0),
    .b(\fcod/fnjpcod [11]),
    .c(\fcod/lt2_c3 ),
    .o({\fcod/lt2_c4 ,open_n40}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_4  (
    .a(1'b0),
    .b(\fcod/fnjpcod [12]),
    .c(\fcod/lt2_c4 ),
    .o({\fcod/lt2_c5 ,open_n41}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_5  (
    .a(1'b1),
    .b(\fcod/fnjpcod [13]),
    .c(\fcod/lt2_c5 ),
    .o({\fcod/lt2_c6 ,open_n42}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_6  (
    .a(1'b1),
    .b(\fcod/fnjpcod [14]),
    .c(\fcod/lt2_c6 ),
    .o({\fcod/lt2_c7 ,open_n43}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_7  (
    .a(1'b1),
    .b(\fcod/fnjpcod [15]),
    .c(\fcod/lt2_c7 ),
    .o({\fcod/lt2_c8 ,open_n44}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt2_cin  (
    .a(1'b1),
    .o({\fcod/lt2_c0 ,open_n47}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt2_c8 ),
    .o({open_n48,\fcod/n5 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_0  (
    .a(\fcod/fnjpcod [8]),
    .b(1'b0),
    .c(\fcod/lt3_c0 ),
    .o({\fcod/lt3_c1 ,open_n49}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_1  (
    .a(\fcod/fnjpcod [9]),
    .b(1'b1),
    .c(\fcod/lt3_c1 ),
    .o({\fcod/lt3_c2 ,open_n50}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_2  (
    .a(\fcod/fnjpcod [10]),
    .b(1'b0),
    .c(\fcod/lt3_c2 ),
    .o({\fcod/lt3_c3 ,open_n51}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_3  (
    .a(\fcod/fnjpcod [11]),
    .b(1'b1),
    .c(\fcod/lt3_c3 ),
    .o({\fcod/lt3_c4 ,open_n52}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_4  (
    .a(\fcod/fnjpcod [12]),
    .b(1'b0),
    .c(\fcod/lt3_c4 ),
    .o({\fcod/lt3_c5 ,open_n53}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_5  (
    .a(\fcod/fnjpcod [13]),
    .b(1'b1),
    .c(\fcod/lt3_c5 ),
    .o({\fcod/lt3_c6 ,open_n54}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_6  (
    .a(\fcod/fnjpcod [14]),
    .b(1'b1),
    .c(\fcod/lt3_c6 ),
    .o({\fcod/lt3_c7 ,open_n55}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_7  (
    .a(\fcod/fnjpcod [15]),
    .b(1'b1),
    .c(\fcod/lt3_c7 ),
    .o({\fcod/lt3_c8 ,open_n56}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt3_cin  (
    .a(1'b1),
    .o({\fcod/lt3_c0 ,open_n59}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt3_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt3_c8 ),
    .o({open_n60,\fcod/n6 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_0  (
    .a(1'b0),
    .b(\fcod/fnjpcod [0]),
    .c(\fcod/lt4_c0 ),
    .o({\fcod/lt4_c1 ,open_n61}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_1  (
    .a(1'b0),
    .b(\fcod/fnjpcod [1]),
    .c(\fcod/lt4_c1 ),
    .o({\fcod/lt4_c2 ,open_n62}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_2  (
    .a(1'b0),
    .b(\fcod/fnjpcod [2]),
    .c(\fcod/lt4_c2 ),
    .o({\fcod/lt4_c3 ,open_n63}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_3  (
    .a(1'b0),
    .b(\fcod/fnjpcod [3]),
    .c(\fcod/lt4_c3 ),
    .o({\fcod/lt4_c4 ,open_n64}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_4  (
    .a(1'b0),
    .b(\fcod/fnjpcod [4]),
    .c(\fcod/lt4_c4 ),
    .o({\fcod/lt4_c5 ,open_n65}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_5  (
    .a(1'b0),
    .b(\fcod/fnjpcod [5]),
    .c(\fcod/lt4_c5 ),
    .o({\fcod/lt4_c6 ,open_n66}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_6  (
    .a(1'b1),
    .b(\fcod/fnjpcod [6]),
    .c(\fcod/lt4_c6 ),
    .o({\fcod/lt4_c7 ,open_n67}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_7  (
    .a(1'b0),
    .b(\fcod/fnjpcod [7]),
    .c(\fcod/lt4_c7 ),
    .o({\fcod/lt4_c8 ,open_n68}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt4_cin  (
    .a(1'b1),
    .o({\fcod/lt4_c0 ,open_n71}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt4_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt4_c8 ),
    .o({open_n72,\fcod/n8 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_0  (
    .a(\fcod/fnjpcod [0]),
    .b(1'b0),
    .c(\fcod/lt5_c0 ),
    .o({\fcod/lt5_c1 ,open_n73}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_1  (
    .a(\fcod/fnjpcod [1]),
    .b(1'b1),
    .c(\fcod/lt5_c1 ),
    .o({\fcod/lt5_c2 ,open_n74}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_2  (
    .a(\fcod/fnjpcod [2]),
    .b(1'b1),
    .c(\fcod/lt5_c2 ),
    .o({\fcod/lt5_c3 ,open_n75}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_3  (
    .a(\fcod/fnjpcod [3]),
    .b(1'b1),
    .c(\fcod/lt5_c3 ),
    .o({\fcod/lt5_c4 ,open_n76}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_4  (
    .a(\fcod/fnjpcod [4]),
    .b(1'b1),
    .c(\fcod/lt5_c4 ),
    .o({\fcod/lt5_c5 ,open_n77}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_5  (
    .a(\fcod/fnjpcod [5]),
    .b(1'b1),
    .c(\fcod/lt5_c5 ),
    .o({\fcod/lt5_c6 ,open_n78}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_6  (
    .a(\fcod/fnjpcod [6]),
    .b(1'b1),
    .c(\fcod/lt5_c6 ),
    .o({\fcod/lt5_c7 ,open_n79}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_7  (
    .a(\fcod/fnjpcod [7]),
    .b(1'b0),
    .c(\fcod/lt5_c7 ),
    .o({\fcod/lt5_c8 ,open_n80}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt5_cin  (
    .a(1'b1),
    .o({\fcod/lt5_c0 ,open_n83}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt5_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt5_c8 ),
    .o({open_n84,\fcod/n9 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_0  (
    .a(1'b0),
    .b(\fcod/fnjpcod [0]),
    .c(\fcod/lt6_c0 ),
    .o({\fcod/lt6_c1 ,open_n85}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_1  (
    .a(1'b0),
    .b(\fcod/fnjpcod [1]),
    .c(\fcod/lt6_c1 ),
    .o({\fcod/lt6_c2 ,open_n86}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_2  (
    .a(1'b0),
    .b(\fcod/fnjpcod [2]),
    .c(\fcod/lt6_c2 ),
    .o({\fcod/lt6_c3 ,open_n87}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_3  (
    .a(1'b0),
    .b(\fcod/fnjpcod [3]),
    .c(\fcod/lt6_c3 ),
    .o({\fcod/lt6_c4 ,open_n88}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_4  (
    .a(1'b0),
    .b(\fcod/fnjpcod [4]),
    .c(\fcod/lt6_c4 ),
    .o({\fcod/lt6_c5 ,open_n89}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_5  (
    .a(1'b0),
    .b(\fcod/fnjpcod [5]),
    .c(\fcod/lt6_c5 ),
    .o({\fcod/lt6_c6 ,open_n90}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_6  (
    .a(1'b0),
    .b(\fcod/fnjpcod [6]),
    .c(\fcod/lt6_c6 ),
    .o({\fcod/lt6_c7 ,open_n91}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_7  (
    .a(1'b1),
    .b(\fcod/fnjpcod [7]),
    .c(\fcod/lt6_c7 ),
    .o({\fcod/lt6_c8 ,open_n92}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt6_cin  (
    .a(1'b1),
    .o({\fcod/lt6_c0 ,open_n95}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt6_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt6_c8 ),
    .o({open_n96,\fcod/n11 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_0  (
    .a(\fcod/fnjpcod [0]),
    .b(1'b0),
    .c(\fcod/lt7_c0 ),
    .o({\fcod/lt7_c1 ,open_n97}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_1  (
    .a(\fcod/fnjpcod [1]),
    .b(1'b0),
    .c(\fcod/lt7_c1 ),
    .o({\fcod/lt7_c2 ,open_n98}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_2  (
    .a(\fcod/fnjpcod [2]),
    .b(1'b1),
    .c(\fcod/lt7_c2 ),
    .o({\fcod/lt7_c3 ,open_n99}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_3  (
    .a(\fcod/fnjpcod [3]),
    .b(1'b1),
    .c(\fcod/lt7_c3 ),
    .o({\fcod/lt7_c4 ,open_n100}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_4  (
    .a(\fcod/fnjpcod [4]),
    .b(1'b1),
    .c(\fcod/lt7_c4 ),
    .o({\fcod/lt7_c5 ,open_n101}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_5  (
    .a(\fcod/fnjpcod [5]),
    .b(1'b1),
    .c(\fcod/lt7_c5 ),
    .o({\fcod/lt7_c6 ,open_n102}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_6  (
    .a(\fcod/fnjpcod [6]),
    .b(1'b1),
    .c(\fcod/lt7_c6 ),
    .o({\fcod/lt7_c7 ,open_n103}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_7  (
    .a(\fcod/fnjpcod [7]),
    .b(1'b1),
    .c(\fcod/lt7_c7 ),
    .o({\fcod/lt7_c8 ,open_n104}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt7_cin  (
    .a(1'b1),
    .o({\fcod/lt7_c0 ,open_n107}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt7_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt7_c8 ),
    .o({open_n108,\fcod/n12 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_0  (
    .a(1'b0),
    .b(\fcod/fnjpcod [0]),
    .c(\fcod/lt8_c0 ),
    .o({\fcod/lt8_c1 ,open_n109}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_1  (
    .a(1'b0),
    .b(\fcod/fnjpcod [1]),
    .c(\fcod/lt8_c1 ),
    .o({\fcod/lt8_c2 ,open_n110}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_10  (
    .a(1'b0),
    .b(\fcod/fnjpcod [10]),
    .c(\fcod/lt8_c10 ),
    .o({\fcod/lt8_c11 ,open_n111}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_11  (
    .a(1'b0),
    .b(\fcod/fnjpcod [11]),
    .c(\fcod/lt8_c11 ),
    .o({\fcod/lt8_c12 ,open_n112}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_12  (
    .a(1'b0),
    .b(\fcod/fnjpcod [12]),
    .c(\fcod/lt8_c12 ),
    .o({\fcod/lt8_c13 ,open_n113}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_13  (
    .a(1'b1),
    .b(\fcod/fnjpcod [13]),
    .c(\fcod/lt8_c13 ),
    .o({\fcod/lt8_c14 ,open_n114}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_14  (
    .a(1'b1),
    .b(\fcod/fnjpcod [14]),
    .c(\fcod/lt8_c14 ),
    .o({\fcod/lt8_c15 ,open_n115}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_15  (
    .a(1'b1),
    .b(\fcod/fnjpcod [15]),
    .c(\fcod/lt8_c15 ),
    .o({\fcod/lt8_c16 ,open_n116}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_2  (
    .a(1'b0),
    .b(\fcod/fnjpcod [2]),
    .c(\fcod/lt8_c2 ),
    .o({\fcod/lt8_c3 ,open_n117}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_3  (
    .a(1'b0),
    .b(\fcod/fnjpcod [3]),
    .c(\fcod/lt8_c3 ),
    .o({\fcod/lt8_c4 ,open_n118}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_4  (
    .a(1'b0),
    .b(\fcod/fnjpcod [4]),
    .c(\fcod/lt8_c4 ),
    .o({\fcod/lt8_c5 ,open_n119}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_5  (
    .a(1'b0),
    .b(\fcod/fnjpcod [5]),
    .c(\fcod/lt8_c5 ),
    .o({\fcod/lt8_c6 ,open_n120}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_6  (
    .a(1'b0),
    .b(\fcod/fnjpcod [6]),
    .c(\fcod/lt8_c6 ),
    .o({\fcod/lt8_c7 ,open_n121}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_7  (
    .a(1'b0),
    .b(\fcod/fnjpcod [7]),
    .c(\fcod/lt8_c7 ),
    .o({\fcod/lt8_c8 ,open_n122}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_8  (
    .a(1'b0),
    .b(\fcod/fnjpcod [8]),
    .c(\fcod/lt8_c8 ),
    .o({\fcod/lt8_c9 ,open_n123}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_9  (
    .a(1'b0),
    .b(\fcod/fnjpcod [9]),
    .c(\fcod/lt8_c9 ),
    .o({\fcod/lt8_c10 ,open_n124}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt8_cin  (
    .a(1'b1),
    .o({\fcod/lt8_c0 ,open_n127}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt8_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt8_c16 ),
    .o({open_n128,\fcod/n14 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_0  (
    .a(1'b1),
    .b(\fcod/fnjpcod [0]),
    .c(\fcod/lt9_c0 ),
    .o({\fcod/lt9_c1 ,open_n129}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_1  (
    .a(1'b1),
    .b(\fcod/fnjpcod [1]),
    .c(\fcod/lt9_c1 ),
    .o({\fcod/lt9_c2 ,open_n130}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_2  (
    .a(1'b1),
    .b(\fcod/fnjpcod [2]),
    .c(\fcod/lt9_c2 ),
    .o({\fcod/lt9_c3 ,open_n131}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_3  (
    .a(1'b1),
    .b(\fcod/fnjpcod [3]),
    .c(\fcod/lt9_c3 ),
    .o({\fcod/lt9_c4 ,open_n132}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_4  (
    .a(1'b1),
    .b(\fcod/fnjpcod [4]),
    .c(\fcod/lt9_c4 ),
    .o({\fcod/lt9_c5 ,open_n133}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_5  (
    .a(1'b1),
    .b(\fcod/fnjpcod [5]),
    .c(\fcod/lt9_c5 ),
    .o({\fcod/lt9_c6 ,open_n134}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_6  (
    .a(1'b1),
    .b(\fcod/fnjpcod [6]),
    .c(\fcod/lt9_c6 ),
    .o({\fcod/lt9_c7 ,open_n135}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_7  (
    .a(1'b0),
    .b(\fcod/fnjpcod [7]),
    .c(\fcod/lt9_c7 ),
    .o({\fcod/lt9_c8 ,open_n136}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \fcod/lt9_cin  (
    .a(1'b1),
    .o({\fcod/lt9_c0 ,open_n139}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \fcod/lt9_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\fcod/lt9_c8 ),
    .o({open_n140,\fcod/n15 }));
  reg_sr_as_w1 \fcod/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [0]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [1]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [10]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [11]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [12]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [13]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [14]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [15]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [2]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [3]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [4]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [5]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [6]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [7]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [8]));  // rtl/fontjp.v(508)
  reg_sr_as_w1 \fcod/reg0_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(fnjpcod_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fcod/fnjpcod [9]));  // rtl/fontjp.v(508)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u0  (
    .a(\fcod/fnjpcod [0]),
    .b(\fcod/n15 ),
    .c(\fcod/sub1/c0 ),
    .o({\fcod/sub1/c1 ,\fcod/codt_2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u1  (
    .a(\fcod/fnjpcod [1]),
    .b(1'b0),
    .c(\fcod/sub1/c1 ),
    .o({\fcod/sub1/c2 ,\fcod/codt_2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u10  (
    .a(\fcod/fnjpcod [10]),
    .b(1'b0),
    .c(\fcod/sub1/c10 ),
    .o({\fcod/sub1/c11 ,\fcod/codt_2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u11  (
    .a(\fcod/fnjpcod [11]),
    .b(1'b0),
    .c(\fcod/sub1/c11 ),
    .o({\fcod/sub1/c12 ,\fcod/codt_2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u12  (
    .a(\fcod/fnjpcod [12]),
    .b(1'b0),
    .c(\fcod/sub1/c12 ),
    .o({\fcod/sub1/c13 ,\fcod/codt_2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u13  (
    .a(\fcod/fnjpcod [13]),
    .b(1'b0),
    .c(\fcod/sub1/c13 ),
    .o({\fcod/sub1/c14 ,\fcod/codt_2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u14  (
    .a(n4[0]),
    .b(1'b0),
    .c(\fcod/sub1/c14 ),
    .o({\fcod/sub1/c15 ,\fcod/codt_2 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u15  (
    .a(n4[1]),
    .b(1'b0),
    .c(\fcod/sub1/c15 ),
    .o({open_n141,\fcod/codt_2 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u2  (
    .a(\fcod/fnjpcod [2]),
    .b(1'b0),
    .c(\fcod/sub1/c2 ),
    .o({\fcod/sub1/c3 ,\fcod/codt_2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u3  (
    .a(\fcod/fnjpcod [3]),
    .b(1'b0),
    .c(\fcod/sub1/c3 ),
    .o({\fcod/sub1/c4 ,\fcod/codt_2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u4  (
    .a(\fcod/fnjpcod [4]),
    .b(1'b0),
    .c(\fcod/sub1/c4 ),
    .o({\fcod/sub1/c5 ,\fcod/codt_2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u5  (
    .a(\fcod/fnjpcod [5]),
    .b(1'b0),
    .c(\fcod/sub1/c5 ),
    .o({\fcod/sub1/c6 ,\fcod/codt_2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u6  (
    .a(\fcod/fnjpcod [6]),
    .b(1'b0),
    .c(\fcod/sub1/c6 ),
    .o({\fcod/sub1/c7 ,\fcod/codt_2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u7  (
    .a(\fcod/fnjpcod [7]),
    .b(1'b0),
    .c(\fcod/sub1/c7 ),
    .o({\fcod/sub1/c8 ,\fcod/codt_2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u8  (
    .a(\fcod/fnjpcod [8]),
    .b(1'b0),
    .c(\fcod/sub1/c8 ),
    .o({\fcod/sub1/c9 ,\fcod/codt_2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub1/u9  (
    .a(\fcod/fnjpcod [9]),
    .b(1'b0),
    .c(\fcod/sub1/c9 ),
    .o({\fcod/sub1/c10 ,\fcod/codt_2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fcod/sub1/ucin  (
    .a(1'b0),
    .o({\fcod/sub1/c0 ,open_n144}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u0  (
    .a(\fcod/codt_2 [0]),
    .b(1'b1),
    .c(\fcod/sub2/c0 ),
    .o({\fcod/sub2/c1 ,\fcod/codt_3 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u1  (
    .a(\fcod/codt_2 [1]),
    .b(1'b1),
    .c(\fcod/sub2/c1 ),
    .o({\fcod/sub2/c2 ,\fcod/codt_3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u2  (
    .a(\fcod/codt_2 [2]),
    .b(1'b1),
    .c(\fcod/sub2/c2 ),
    .o({\fcod/sub2/c3 ,\fcod/codt_3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u3  (
    .a(\fcod/codt_2 [3]),
    .b(1'b1),
    .c(\fcod/sub2/c3 ),
    .o({\fcod/sub2/c4 ,\fcod/codt_3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u4  (
    .a(\fcod/codt_2 [4]),
    .b(1'b1),
    .c(\fcod/sub2/c4 ),
    .o({\fcod/sub2/c5 ,\fcod/codt_3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u5  (
    .a(\fcod/codt_2 [5]),
    .b(1'b1),
    .c(\fcod/sub2/c5 ),
    .o({\fcod/sub2/c6 ,\fcod/codt_3 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u6  (
    .a(\fcod/codt_2 [6]),
    .b(1'b0),
    .c(\fcod/sub2/c6 ),
    .o({\fcod/sub2/c7 ,\fcod/codt_3 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/u7  (
    .a(\fcod/codt_2 [7]),
    .b(1'b0),
    .c(\fcod/sub2/c7 ),
    .o({\fcod/sub2/c8 ,\fcod/codt_3 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fcod/sub2/ucin  (
    .a(1'b0),
    .o({\fcod/sub2/c0 ,open_n147}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub2/ucout  (
    .c(\fcod/sub2/c8 ),
    .o({open_n150,\fcod/codt_3 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u0  (
    .a(\fcod/codt_3 [0]),
    .b(1'b1),
    .c(\fcod/sub3/c0 ),
    .o({\fcod/sub3/c1 ,\fcod/codt_4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u1  (
    .a(\fcod/codt_3 [1]),
    .b(\fcod/n16 ),
    .c(\fcod/sub3/c1 ),
    .o({\fcod/sub3/c2 ,\fcod/codt_4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u10  (
    .a(\fcod/codt_3 [15]),
    .b(1'b0),
    .c(\fcod/sub3/c10 ),
    .o({\fcod/sub3/c11 ,\fcod/codt_4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u11  (
    .a(\fcod/codt_3 [15]),
    .b(1'b0),
    .c(\fcod/sub3/c11 ),
    .o({\fcod/sub3/c12 ,\fcod/codt_4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u12  (
    .a(\fcod/codt_3 [15]),
    .b(1'b0),
    .c(\fcod/sub3/c12 ),
    .o({open_n151,\fcod/codt_4 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u2  (
    .a(\fcod/codt_3 [2]),
    .b(\fcod/n16 ),
    .c(\fcod/sub3/c2 ),
    .o({\fcod/sub3/c3 ,\fcod/codt_4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u3  (
    .a(\fcod/codt_3 [3]),
    .b(\fcod/n16 ),
    .c(\fcod/sub3/c3 ),
    .o({\fcod/sub3/c4 ,\fcod/codt_4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u4  (
    .a(\fcod/codt_3 [4]),
    .b(\fcod/n16 ),
    .c(\fcod/sub3/c4 ),
    .o({\fcod/sub3/c5 ,\fcod/codt_4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u5  (
    .a(\fcod/codt_3 [5]),
    .b(1'b0),
    .c(\fcod/sub3/c5 ),
    .o({\fcod/sub3/c6 ,\fcod/codt_4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u6  (
    .a(\fcod/codt_3 [6]),
    .b(\fcod/n16 ),
    .c(\fcod/sub3/c6 ),
    .o({\fcod/sub3/c7 ,\fcod/codt_4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u7  (
    .a(\fcod/codt_3 [7]),
    .b(1'b0),
    .c(\fcod/sub3/c7 ),
    .o({\fcod/sub3/c8 ,\fcod/codt_4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u8  (
    .a(\fcod/codt_3 [15]),
    .b(1'b0),
    .c(\fcod/sub3/c8 ),
    .o({\fcod/sub3/c9 ,\fcod/codt_4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub3/u9  (
    .a(\fcod/codt_3 [15]),
    .b(1'b0),
    .c(\fcod/sub3/c9 ),
    .o({\fcod/sub3/c10 ,\fcod/codt_4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fcod/sub3/ucin  (
    .a(1'b0),
    .o({\fcod/sub3/c0 ,open_n154}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u0  (
    .a(1'b0),
    .b(\fcod/n16 ),
    .c(\fcod/sub4/c0 ),
    .o({\fcod/sub4/c1 ,\fcod/codk_2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u1  (
    .a(\fcod/codt_2 [8]),
    .b(\fcod/n17 [1]),
    .c(\fcod/sub4/c1 ),
    .o({\fcod/sub4/c2 ,\fcod/codk_2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u2  (
    .a(\fcod/codt_2 [9]),
    .b(1'b0),
    .c(\fcod/sub4/c2 ),
    .o({\fcod/sub4/c3 ,\fcod/codk_2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u3  (
    .a(\fcod/codt_2 [10]),
    .b(1'b0),
    .c(\fcod/sub4/c3 ),
    .o({\fcod/sub4/c4 ,\fcod/codk_2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u4  (
    .a(\fcod/codt_2 [11]),
    .b(1'b0),
    .c(\fcod/sub4/c4 ),
    .o({\fcod/sub4/c5 ,\fcod/codk_2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u5  (
    .a(\fcod/codt_2 [12]),
    .b(1'b0),
    .c(\fcod/sub4/c5 ),
    .o({\fcod/sub4/c6 ,\fcod/codk_2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u6  (
    .a(\fcod/codt_2 [13]),
    .b(1'b0),
    .c(\fcod/sub4/c6 ),
    .o({\fcod/sub4/c7 ,\fcod/codk_2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u7  (
    .a(\fcod/codt_2 [14]),
    .b(1'b0),
    .c(\fcod/sub4/c7 ),
    .o({\fcod/sub4/c8 ,\fcod/codk_2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/u8  (
    .a(\fcod/codt_2 [15]),
    .b(1'b0),
    .c(\fcod/sub4/c8 ),
    .o({\fcod/sub4/c9 ,\fcod/codk_2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fcod/sub4/ucin  (
    .a(1'b0),
    .o({\fcod/sub4/c0 ,open_n157}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fcod/sub4/ucout  (
    .c(\fcod/sub4/c9 ),
    .o({open_n160,\fcod/codk_2 [9]}));
  reg_sr_as_w1 \fctl/fnjpcod_rd_reg  (
    .clk(clk),
    .d(\fctl/n9 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fnjpcod_rd));  // rtl/fontjp.v(251)
  reg_sr_as_w1 \fctl/fnjpctl_rd_reg  (
    .clk(clk),
    .d(\fctl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fctl/fnjpctl_rd ));  // rtl/fontjp.v(251)
  reg_sr_as_w1 \fctl/fnjpdata_rd_reg  (
    .clk(clk),
    .d(\fctl/n17 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fnjpdata_rd));  // rtl/fontjp.v(251)
  reg_sr_as_w1 \fctl/fnjpdatb_rd_reg  (
    .clk(clk),
    .d(\fctl/n22 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fnjpdatb_rd));  // rtl/fontjp.v(251)
  reg_sr_as_w1 \fctl/fnjpdatc_rd_reg  (
    .clk(clk),
    .d(\fctl/n27 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fnjpdatc_rd));  // rtl/fontjp.v(251)
  reg_sr_as_w1 \fctl/fnjpdatd_rd_reg  (
    .clk(clk),
    .d(\fctl/n32 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fnjpdatd_rd));  // rtl/fontjp.v(251)
  reg_sr_as_w1 \fctl/fnjpdbl_rd_reg  (
    .clk(clk),
    .d(\fctl/n12 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fnjpdbl_rd));  // rtl/fontjp.v(251)
  reg_sr_as_w1 \fctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\fctl/fnjpctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fctl/fnjpctl [0]));  // rtl/fontjp.v(269)
  reg_sr_as_w1 \fctl/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\fctl/fnjpctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fctl/fnjpctl [1]));  // rtl/fontjp.v(269)
  reg_sr_as_w1 \fctl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\fctl/fnjpctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_flp_v));  // rtl/fontjp.v(269)
  reg_sr_as_w1 \fctl/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\fctl/fnjpctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_flp_h));  // rtl/fontjp.v(269)
  reg_sr_as_w1 \fctl/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\fctl/fnjpctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_inv));  // rtl/fontjp.v(269)
  reg_sr_as_w1 \fctl/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\fctl/fnjpctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ktc));  // rtl/fontjp.v(269)
  reg_sr_as_w1 \fdbl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [0]));  // rtl/fontjp.v(591)
  reg_sr_as_w1 \fdbl/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [1]));  // rtl/fontjp.v(591)
  reg_sr_as_w1 \fdbl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [2]));  // rtl/fontjp.v(591)
  reg_sr_as_w1 \fdbl/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [3]));  // rtl/fontjp.v(591)
  reg_sr_as_w1 \fdbl/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [4]));  // rtl/fontjp.v(591)
  reg_sr_as_w1 \fdbl/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [5]));  // rtl/fontjp.v(591)
  reg_sr_as_w1 \fdbl/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [6]));  // rtl/fontjp.v(591)
  reg_sr_as_w1 \fdbl/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(fnjpdbl_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdbl/fnjpdbl [7]));  // rtl/fontjp.v(591)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u0  (
    .a(\fcod/codk_2 [0]),
    .b(\fcod/codk_2 [2]),
    .c(\u1/c0 ),
    .o({\u1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u1  (
    .a(\fcod/codk_2 [3]),
    .b(\fcod/codk_2 [1]),
    .c(\u1/c1 ),
    .o({\u1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u2  (
    .a(\fcod/codk_2 [4]),
    .b(\fcod/codk_2 [2]),
    .c(\u1/c2 ),
    .o({\u1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u3  (
    .a(\fcod/codk_2 [5]),
    .b(\fcod/codk_2 [3]),
    .c(\u1/c3 ),
    .o({\u1/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u4  (
    .a(\fcod/codk_2 [6]),
    .b(\fcod/codk_2 [4]),
    .c(\u1/c4 ),
    .o({\u1/c5 ,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u5  (
    .a(1'b0),
    .b(1'b0),
    .c(\u1/c5 ),
    .o({\u1/c6 ,n0[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u6  (
    .a(1'b0),
    .b(\fcod/codk_2 [9]),
    .c(\u1/c6 ),
    .o({open_n161,n0[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u1/ucin  (
    .a(1'b0),
    .o({\u1/c0 ,open_n164}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u0  (
    .a(\fcod/codk_2 [0]),
    .b(\fcod/codk_2 [1]),
    .c(\u2/c0 ),
    .o({\u2/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u1  (
    .a(\fcod/codk_2 [2]),
    .b(\fcod/codk_2 [1]),
    .c(\u2/c1 ),
    .o({\u2/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u2  (
    .a(\fcod/codk_2 [3]),
    .b(\fcod/codk_2 [4]),
    .c(\u2/c2 ),
    .o({\u2/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u3  (
    .a(\fcod/codk_2 [5]),
    .b(\fcod/codk_2 [4]),
    .c(\u2/c3 ),
    .o({\u2/c4 ,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u4  (
    .a(\fcod/codk_2 [6]),
    .b(\fcod/codk_2 [5]),
    .c(\u2/c4 ),
    .o({\u2/c5 ,n1[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u5  (
    .a(\fcod/codk_2 [7]),
    .b(\fcod/codk_2 [6]),
    .c(\u2/c5 ),
    .o({\u2/c6 ,n1[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u6  (
    .a(\fcod/codk_2 [8]),
    .b(\fcod/codk_2 [7]),
    .c(\u2/c6 ),
    .o({\u2/c7 ,n1[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u7  (
    .a(\fcod/codk_2 [5]),
    .b(\fcod/codk_2 [8]),
    .c(\u2/c7 ),
    .o({\u2/c8 ,n1[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u8  (
    .a(\fcod/codk_2 [6]),
    .b(\fcod/codk_2 [8]),
    .c(\u2/c8 ),
    .o({open_n165,n1[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u2/ucin  (
    .a(1'b0),
    .o({\u2/c0 ,open_n168}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u0  (
    .a(\fcod/codk_2 [0]),
    .b(\fcod/codk_2 [1]),
    .c(\u3/c0 ),
    .o({\u3/c1 ,n2[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u1  (
    .a(\fcod/codk_2 [3]),
    .b(\fcod/codk_2 [2]),
    .c(\u3/c1 ),
    .o({\u3/c2 ,n2[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u2  (
    .a(\fcod/codk_2 [4]),
    .b(\fcod/codk_2 [3]),
    .c(\u3/c2 ),
    .o({\u3/c3 ,n2[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u3  (
    .a(\fcod/codk_2 [5]),
    .b(\fcod/codt_4 [6]),
    .c(\u3/c3 ),
    .o({\u3/c4 ,n2[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u4  (
    .a(\fcod/codk_2 [6]),
    .b(\fcod/codt_4 [7]),
    .c(\u3/c4 ),
    .o({\u3/c5 ,n2[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u5  (
    .a(\fcod/codk_2 [7]),
    .b(\fcod/codt_4 [8]),
    .c(\u3/c5 ),
    .o({\u3/c6 ,n2[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u6  (
    .a(\fcod/codk_2 [8]),
    .b(\fcod/codt_4 [9]),
    .c(\u3/c6 ),
    .o({\u3/c7 ,n2[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u7  (
    .a(\fcod/codk_2 [9]),
    .b(\fcod/codt_4 [10]),
    .c(\u3/c7 ),
    .o({\u3/c8 ,n2[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u8  (
    .a(\fcod/codk_2 [7]),
    .b(\fcod/codt_4 [11]),
    .c(\u3/c8 ),
    .o({\u3/c9 ,n2[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u3/u9  (
    .a(\fcod/codk_2 [9]),
    .b(\fcod/codt_4 [12]),
    .c(\u3/c9 ),
    .o({open_n169,n2[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u3/ucin  (
    .a(1'b0),
    .o({\u3/c0 ,open_n172}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u0  (
    .a(\fcod/codk_2 [0]),
    .b(\fcod/codk_2 [1]),
    .c(\u4/c0 ),
    .o({\u4/c1 ,n3[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u1  (
    .a(\fcod/codt_4 [3]),
    .b(\fcod/codk_2 [2]),
    .c(\u4/c1 ),
    .o({\u4/c2 ,n3[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u10  (
    .a(n0[6]),
    .b(n1[8]),
    .c(\u4/c10 ),
    .o({open_n173,n3[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u2  (
    .a(\fcod/codt_4 [4]),
    .b(n1[0]),
    .c(\u4/c2 ),
    .o({\u4/c3 ,n3[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u3  (
    .a(\fcod/codt_4 [5]),
    .b(n1[1]),
    .c(\u4/c3 ),
    .o({\u4/c4 ,n3[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u4  (
    .a(n0[0]),
    .b(n1[2]),
    .c(\u4/c4 ),
    .o({\u4/c5 ,n3[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u5  (
    .a(n0[1]),
    .b(n1[3]),
    .c(\u4/c5 ),
    .o({\u4/c6 ,n3[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u6  (
    .a(n0[2]),
    .b(n1[4]),
    .c(\u4/c6 ),
    .o({\u4/c7 ,n3[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u7  (
    .a(n0[3]),
    .b(n1[5]),
    .c(\u4/c7 ),
    .o({\u4/c8 ,n3[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u8  (
    .a(n0[4]),
    .b(n1[6]),
    .c(\u4/c8 ),
    .o({\u4/c9 ,n3[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u4/u9  (
    .a(n0[5]),
    .b(n1[7]),
    .c(\u4/c9 ),
    .o({\u4/c10 ,n3[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u4/ucin  (
    .a(1'b0),
    .o({\u4/c0 ,open_n176}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u0  (
    .a(\fcod/codt_4 [1]),
    .b(\fcod/codk_2 [0]),
    .c(\u5/c0 ),
    .o({\u5/c1 ,\fcod/codkt_1 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u1  (
    .a(\fcod/codt_4 [2]),
    .b(n3[0]),
    .c(\u5/c1 ),
    .o({\u5/c2 ,\fcod/codkt_1 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u10  (
    .a(n2[8]),
    .b(n3[9]),
    .c(\u5/c10 ),
    .o({\u5/c11 ,\fcod/codkt_1 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u11  (
    .a(n2[9]),
    .b(n3[10]),
    .c(\u5/c11 ),
    .o({open_n177,\fcod/codkt_1 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u2  (
    .a(n2[0]),
    .b(n3[1]),
    .c(\u5/c2 ),
    .o({\u5/c3 ,\fcod/codkt_1 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u3  (
    .a(n2[1]),
    .b(n3[2]),
    .c(\u5/c3 ),
    .o({\u5/c4 ,\fcod/codkt_1 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u4  (
    .a(n2[2]),
    .b(n3[3]),
    .c(\u5/c4 ),
    .o({\u5/c5 ,\fcod/codkt_1 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u5  (
    .a(n2[3]),
    .b(n3[4]),
    .c(\u5/c5 ),
    .o({\u5/c6 ,\fcod/codkt_1 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u6  (
    .a(n2[4]),
    .b(n3[5]),
    .c(\u5/c6 ),
    .o({\u5/c7 ,\fcod/codkt_1 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u7  (
    .a(n2[5]),
    .b(n3[6]),
    .c(\u5/c7 ),
    .o({\u5/c8 ,\fcod/codkt_1 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u8  (
    .a(n2[6]),
    .b(n3[7]),
    .c(\u5/c8 ),
    .o({\u5/c9 ,\fcod/codkt_1 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u5/u9  (
    .a(n2[7]),
    .b(n3[8]),
    .c(\u5/c9 ),
    .o({\u5/c10 ,\fcod/codkt_1 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u5/ucin  (
    .a(1'b0),
    .o({\u5/c0 ,open_n180}));

endmodule 

