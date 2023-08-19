
`timescale 1ns / 1ps
module cache2w4k  // rtl/cache2w4k.v(1)
  (
  badr,
  bcmd,
  bcs_sdram_n,
  bcs_sdrc_n,
  bdatw,
  brdy,
  cch_da_datr,
  clk,
  rst_n,
  bdatr,
  cch_bcmd,
  cch_bst_adr,
  cch_da_adr,
  cch_da_ce,
  cch_da_datw,
  cch_da_we,
  cch_hit,
  cch_sdram_n
  );
//
//	cache memory controller
//		(c) 2022	1YEN Toru
//
//
//	2022/04/09	ver.1.02
//		cch_ioreg: inhibit cachtag and cachlfu i/o register read
//			to avoid critical false-path.
//
//	2022/03/12	ver.1.00
//		2 way set associative, write through
//		address: tag 13 bits, index 7 bits, line 4 bits
//		data array: 4K bytes (16 bytes/line)
//		read: 1(hit) / 4(miss) cycle
//		write: 2(hit) / 2(miss) cycle
//

  input [23:0] badr;  // rtl/cache2w4k.v(30)
  input [2:0] bcmd;  // rtl/cache2w4k.v(28)
  input bcs_sdram_n;  // rtl/cache2w4k.v(26)
  input bcs_sdrc_n;  // rtl/cache2w4k.v(27)
  input [15:0] bdatw;  // rtl/cache2w4k.v(29)
  input brdy;  // rtl/cache2w4k.v(25)
  input [15:0] cch_da_datr;  // rtl/cache2w4k.v(36)
  input clk;  // rtl/cache2w4k.v(23)
  input rst_n;  // rtl/cache2w4k.v(24)
  output [15:0] bdatr;  // rtl/cache2w4k.v(34)
  output [2:0] cch_bcmd;  // rtl/cache2w4k.v(33)
  output [7:0] cch_bst_adr;  // rtl/cache2w4k.v(39)
  output [10:0] cch_da_adr;  // rtl/cache2w4k.v(40)
  output cch_da_ce;  // rtl/cache2w4k.v(37)
  output [15:0] cch_da_datw;  // rtl/cache2w4k.v(41)
  output [1:0] cch_da_we;  // rtl/cache2w4k.v(38)
  output cch_hit;  // rtl/cache2w4k.v(31)
  output cch_sdram_n;  // rtl/cache2w4k.v(32)

  wire [31:0] cachcnt;  // rtl/cache2w4k.v(68)
  wire [31:0] cachhit;  // rtl/cache2w4k.v(69)
  wire [15:0] \iorg/n51 ;
  wire [6:0] iorg_la_radr;  // rtl/cache2w4k.v(67)
  wire [6:0] iorg_ta_radr;  // rtl/cache2w4k.v(65)
  wire [7:0] lfu_la_rdat;  // rtl/cache2w4k.v(61)
  wire [6:0] \lfuc/lfu_la_radr ;  // rtl/cache2w4k.v(634)
  wire [6:0] \lfuc/lfu_la_wadr ;  // rtl/cache2w4k.v(635)
  wire [7:0] \lfuc/lfu_la_wdat ;  // rtl/cache2w4k.v(636)
  wire  \lfuc/lfuary/dram_do_mux_b0/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b0/B0_2 ;
  wire  \lfuc/lfuary/dram_do_mux_b1/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b1/B0_2 ;
  wire  \lfuc/lfuary/dram_do_mux_b2/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b2/B0_2 ;
  wire  \lfuc/lfuary/dram_do_mux_b3/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b3/B0_2 ;
  wire  \lfuc/lfuary/dram_do_mux_b4/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b4/B0_2 ;
  wire  \lfuc/lfuary/dram_do_mux_b5/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b5/B0_2 ;
  wire  \lfuc/lfuary/dram_do_mux_b6/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b6/B0_2 ;
  wire  \lfuc/lfuary/dram_do_mux_b7/B0_0 ;
  wire  \lfuc/lfuary/dram_do_mux_b7/B0_2 ;
  wire [7:0] \lfuc/n14 ;
  wire [7:0] \lfuc/n16 ;
  wire [7:0] \lfuc/n22 ;
  wire [31:0] \lfuc/n23 ;
  wire [31:0] \lfuc/n25 ;
  wire [31:0] \lfuc/n26 ;
  wire [31:0] \lfuc/n29 ;
  wire [31:0] \lfuc/n31 ;
  wire [31:0] \lfuc/n32 ;
  wire [7:0] \lfuc/n8 ;
  wire  \way0/tary/dram_do_mux_b0/B0_1 ;
  wire  \way0/tary/dram_do_mux_b0/B0_3 ;
  wire  \way0/tary/dram_do_mux_b1/B0_0 ;
  wire  \way0/tary/dram_do_mux_b1/B0_2 ;
  wire  \way0/tary/dram_do_mux_b10/B0_0 ;
  wire  \way0/tary/dram_do_mux_b10/B0_2 ;
  wire  \way0/tary/dram_do_mux_b11/B0_0 ;
  wire  \way0/tary/dram_do_mux_b11/B0_2 ;
  wire  \way0/tary/dram_do_mux_b12/B0_0 ;
  wire  \way0/tary/dram_do_mux_b12/B0_2 ;
  wire  \way0/tary/dram_do_mux_b2/B0_0 ;
  wire  \way0/tary/dram_do_mux_b2/B0_2 ;
  wire  \way0/tary/dram_do_mux_b3/B0_0 ;
  wire  \way0/tary/dram_do_mux_b3/B0_2 ;
  wire  \way0/tary/dram_do_mux_b4/B0_0 ;
  wire  \way0/tary/dram_do_mux_b4/B0_2 ;
  wire  \way0/tary/dram_do_mux_b5/B0_0 ;
  wire  \way0/tary/dram_do_mux_b5/B0_2 ;
  wire  \way0/tary/dram_do_mux_b6/B0_1 ;
  wire  \way0/tary/dram_do_mux_b6/B0_3 ;
  wire  \way0/tary/dram_do_mux_b7/B0_1 ;
  wire  \way0/tary/dram_do_mux_b7/B0_3 ;
  wire  \way0/tary/dram_do_mux_b8/B0_1 ;
  wire  \way0/tary/dram_do_mux_b8/B0_3 ;
  wire  \way0/tary/dram_do_mux_b9/B0_0 ;
  wire  \way0/tary/dram_do_mux_b9/B0_2 ;
  wire [6:0] \way0/way_ta_radr ;  // rtl/cache2w4k.v(488)
  wire [6:0] \way0/way_ta_wadr ;  // rtl/cache2w4k.v(489)
  wire [12:0] \way0/way_ta_wdat ;  // rtl/cache2w4k.v(490)
  wire [12:0] way0_ta_rdat;  // rtl/cache2w4k.v(62)
  wire  \way1/tary/dram_do_mux_b0/B0_0 ;
  wire  \way1/tary/dram_do_mux_b0/B0_2 ;
  wire  \way1/tary/dram_do_mux_b1/B0_0 ;
  wire  \way1/tary/dram_do_mux_b1/B0_2 ;
  wire  \way1/tary/dram_do_mux_b10/B0_0 ;
  wire  \way1/tary/dram_do_mux_b10/B0_2 ;
  wire  \way1/tary/dram_do_mux_b11/B0_0 ;
  wire  \way1/tary/dram_do_mux_b11/B0_2 ;
  wire  \way1/tary/dram_do_mux_b12/B0_0 ;
  wire  \way1/tary/dram_do_mux_b12/B0_2 ;
  wire  \way1/tary/dram_do_mux_b2/B0_0 ;
  wire  \way1/tary/dram_do_mux_b2/B0_2 ;
  wire  \way1/tary/dram_do_mux_b3/B0_0 ;
  wire  \way1/tary/dram_do_mux_b3/B0_2 ;
  wire  \way1/tary/dram_do_mux_b4/B0_0 ;
  wire  \way1/tary/dram_do_mux_b4/B0_2 ;
  wire  \way1/tary/dram_do_mux_b5/B0_0 ;
  wire  \way1/tary/dram_do_mux_b5/B0_2 ;
  wire  \way1/tary/dram_do_mux_b6/B0_1 ;
  wire  \way1/tary/dram_do_mux_b6/B0_3 ;
  wire  \way1/tary/dram_do_mux_b7/B0_1 ;
  wire  \way1/tary/dram_do_mux_b7/B0_3 ;
  wire  \way1/tary/dram_do_mux_b8/B0_0 ;
  wire  \way1/tary/dram_do_mux_b8/B0_2 ;
  wire  \way1/tary/dram_do_mux_b9/B0_0 ;
  wire  \way1/tary/dram_do_mux_b9/B0_2 ;
  wire [6:0] \way1/way_ta_wadr ;  // rtl/cache2w4k.v(489)
  wire [12:0] \way1/way_ta_wdat ;  // rtl/cache2w4k.v(490)
  wire [12:0] way1_ta_rdat;  // rtl/cache2w4k.v(63)
  wire _al_u102_o;
  wire _al_u104_o;
  wire _al_u105_o;
  wire _al_u107_o;
  wire _al_u110_o;
  wire _al_u112_o;
  wire _al_u115_o;
  wire _al_u117_o;
  wire _al_u120_o;
  wire _al_u122_o;
  wire _al_u125_o;
  wire _al_u127_o;
  wire _al_u130_o;
  wire _al_u132_o;
  wire _al_u135_o;
  wire _al_u137_o;
  wire _al_u140_o;
  wire _al_u142_o;
  wire _al_u150_o;
  wire _al_u158_o;
  wire _al_u159_o;
  wire _al_u176_o;
  wire _al_u179_o;
  wire _al_u182_o;
  wire _al_u185_o;
  wire _al_u188_o;
  wire _al_u191_o;
  wire _al_u194_o;
  wire _al_u197_o;
  wire _al_u200_o;
  wire _al_u203_o;
  wire _al_u206_o;
  wire _al_u209_o;
  wire _al_u212_o;
  wire _al_u215_o;
  wire _al_u218_o;
  wire _al_u221_o;
  wire _al_u282_o;
  wire _al_u283_o;
  wire _al_u286_o;
  wire _al_u289_o;
  wire _al_u290_o;
  wire _al_u293_o;
  wire _al_u296_o;
  wire _al_u298_o;
  wire _al_u299_o;
  wire _al_u301_o;
  wire _al_u302_o;
  wire _al_u305_o;
  wire _al_u307_o;
  wire _al_u310_o;
  wire _al_u311_o;
  wire _al_u313_o;
  wire _al_u315_o;
  wire _al_u318_o;
  wire _al_u320_o;
  wire _al_u322_o;
  wire _al_u324_o;
  wire _al_u326_o;
  wire _al_u327_o;
  wire _al_u329_o;
  wire _al_u331_o;
  wire _al_u332_o;
  wire _al_u334_o;
  wire _al_u336_o;
  wire _al_u337_o;
  wire _al_u339_o;
  wire _al_u341_o;
  wire _al_u342_o;
  wire _al_u343_o;
  wire _al_u345_o;
  wire _al_u347_o;
  wire _al_u350_o;
  wire _al_u352_o;
  wire _al_u354_o;
  wire _al_u356_o;
  wire _al_u358_o;
  wire _al_u361_o;
  wire _al_u363_o;
  wire _al_u365_o;
  wire _al_u367_o;
  wire _al_u369_o;
  wire _al_u373_o;
  wire _al_u375_o;
  wire _al_u377_o;
  wire _al_u379_o;
  wire _al_u381_o;
  wire _al_u383_o;
  wire _al_u385_o;
  wire _al_u387_o;
  wire _al_u390_o;
  wire _al_u392_o;
  wire _al_u395_o;
  wire _al_u397_o;
  wire _al_u398_o;
  wire _al_u399_o;
  wire _al_u400_o;
  wire _al_u402_o;
  wire _al_u404_o;
  wire _al_u407_o;
  wire _al_u409_o;
  wire _al_u411_o;
  wire _al_u413_o;
  wire _al_u415_o;
  wire _al_u418_o;
  wire _al_u420_o;
  wire _al_u421_o;
  wire _al_u422_o;
  wire _al_u424_o;
  wire _al_u426_o;
  wire _al_u428_o;
  wire _al_u430_o;
  wire _al_u432_o;
  wire _al_u433_o;
  wire _al_u434_o;
  wire _al_u436_o;
  wire _al_u438_o;
  wire _al_u439_o;
  wire _al_u441_o;
  wire _al_u443_o;
  wire _al_u452_o;
  wire _al_u455_o;
  wire _al_u490_o;
  wire _al_u491_o;
  wire _al_u492_o;
  wire _al_u493_o;
  wire _al_u494_o;
  wire _al_u495_o;
  wire _al_u499_o;
  wire _al_u500_o;
  wire _al_u501_o;
  wire _al_u503_o;
  wire _al_u505_o;
  wire _al_u507_o;
  wire _al_u509_o;
  wire _al_u511_o;
  wire _al_u515_o;
  wire _al_u521_o;
  wire _al_u526_o;
  wire _al_u532_o;
  wire \dactl/n0_lutinv ;
  wire \dactl/n1 ;
  wire \iorg/n10 ;
  wire \iorg/n13 ;
  wire \iorg/n16 ;
  wire \iorg/n19 ;
  wire \iorg/n22 ;
  wire \iorg/n38 ;
  wire \iorg/n4 ;
  wire \iorg/n7 ;
  wire \iorg/rd_cachcnth ;  // rtl/cache2w4k.v(355)
  wire \iorg/rd_cachcntl ;  // rtl/cache2w4k.v(356)
  wire \iorg/rd_cachctl ;  // rtl/cache2w4k.v(352)
  wire \iorg/rd_cachhith ;  // rtl/cache2w4k.v(357)
  wire \iorg/rd_cachhitl ;  // rtl/cache2w4k.v(358)
  wire \iorg/wr_cachctl ;  // rtl/cache2w4k.v(384)
  wire \iorg/wr_cachlfu ;  // rtl/cache2w4k.v(386)
  wire \iorg/wr_cachtag ;  // rtl/cache2w4k.v(385)
  wire iorg_cche;  // rtl/cache2w4k.v(78)
  wire iorg_la_re;  // rtl/cache2w4k.v(113)
  wire iorg_la_we;  // rtl/cache2w4k.v(114)
  wire iorg_ta0_we;  // rtl/cache2w4k.v(111)
  wire iorg_ta1_we;  // rtl/cache2w4k.v(112)
  wire iorg_ta_re;  // rtl/cache2w4k.v(110)
  wire \lfu_la_rdat[7]_neg ;
  wire \lfuc/add0/c0 ;
  wire \lfuc/add0/c1 ;
  wire \lfuc/add0/c2 ;
  wire \lfuc/add0/c3 ;
  wire \lfuc/add0/c4 ;
  wire \lfuc/add0/c5 ;
  wire \lfuc/add0/c6 ;
  wire \lfuc/add0/c7 ;
  wire \lfuc/add1_2/c0 ;
  wire \lfuc/add1_2/c1 ;
  wire \lfuc/add1_2/c2 ;
  wire \lfuc/add1_2/c3 ;
  wire \lfuc/add1_2/c4 ;
  wire \lfuc/add1_2/c5 ;
  wire \lfuc/add1_2/c6 ;
  wire \lfuc/add1_2/c7 ;
  wire \lfuc/add2/c0 ;
  wire \lfuc/add2/c1 ;
  wire \lfuc/add2/c10 ;
  wire \lfuc/add2/c11 ;
  wire \lfuc/add2/c12 ;
  wire \lfuc/add2/c13 ;
  wire \lfuc/add2/c14 ;
  wire \lfuc/add2/c15 ;
  wire \lfuc/add2/c16 ;
  wire \lfuc/add2/c17 ;
  wire \lfuc/add2/c18 ;
  wire \lfuc/add2/c19 ;
  wire \lfuc/add2/c2 ;
  wire \lfuc/add2/c20 ;
  wire \lfuc/add2/c21 ;
  wire \lfuc/add2/c22 ;
  wire \lfuc/add2/c23 ;
  wire \lfuc/add2/c24 ;
  wire \lfuc/add2/c25 ;
  wire \lfuc/add2/c26 ;
  wire \lfuc/add2/c27 ;
  wire \lfuc/add2/c28 ;
  wire \lfuc/add2/c29 ;
  wire \lfuc/add2/c3 ;
  wire \lfuc/add2/c30 ;
  wire \lfuc/add2/c31 ;
  wire \lfuc/add2/c4 ;
  wire \lfuc/add2/c5 ;
  wire \lfuc/add2/c6 ;
  wire \lfuc/add2/c7 ;
  wire \lfuc/add2/c8 ;
  wire \lfuc/add2/c9 ;
  wire \lfuc/add3/c0 ;
  wire \lfuc/add3/c1 ;
  wire \lfuc/add3/c10 ;
  wire \lfuc/add3/c11 ;
  wire \lfuc/add3/c12 ;
  wire \lfuc/add3/c13 ;
  wire \lfuc/add3/c14 ;
  wire \lfuc/add3/c15 ;
  wire \lfuc/add3/c16 ;
  wire \lfuc/add3/c17 ;
  wire \lfuc/add3/c18 ;
  wire \lfuc/add3/c19 ;
  wire \lfuc/add3/c2 ;
  wire \lfuc/add3/c20 ;
  wire \lfuc/add3/c21 ;
  wire \lfuc/add3/c22 ;
  wire \lfuc/add3/c23 ;
  wire \lfuc/add3/c24 ;
  wire \lfuc/add3/c25 ;
  wire \lfuc/add3/c26 ;
  wire \lfuc/add3/c27 ;
  wire \lfuc/add3/c28 ;
  wire \lfuc/add3/c29 ;
  wire \lfuc/add3/c3 ;
  wire \lfuc/add3/c30 ;
  wire \lfuc/add3/c31 ;
  wire \lfuc/add3/c4 ;
  wire \lfuc/add3/c5 ;
  wire \lfuc/add3/c6 ;
  wire \lfuc/add3/c7 ;
  wire \lfuc/add3/c8 ;
  wire \lfuc/add3/c9 ;
  wire \lfuc/lfu_la_we_0_0_0 ;
  wire \lfuc/lfu_la_we_0_0_1 ;
  wire \lfuc/lfu_la_we_0_1_0 ;
  wire \lfuc/lfu_la_we_0_1_1 ;
  wire \lfuc/lfu_la_we_1_0_0 ;
  wire \lfuc/lfu_la_we_1_0_1 ;
  wire \lfuc/lfu_la_we_1_1_0 ;
  wire \lfuc/lfu_la_we_1_1_1 ;
  wire \lfuc/lfuary/dram_do_i0_000 ;
  wire \lfuc/lfuary/dram_do_i0_001 ;
  wire \lfuc/lfuary/dram_do_i0_002 ;
  wire \lfuc/lfuary/dram_do_i0_003 ;
  wire \lfuc/lfuary/dram_do_i0_004 ;
  wire \lfuc/lfuary/dram_do_i0_005 ;
  wire \lfuc/lfuary/dram_do_i0_006 ;
  wire \lfuc/lfuary/dram_do_i0_007 ;
  wire \lfuc/lfuary/dram_do_i1_000 ;
  wire \lfuc/lfuary/dram_do_i1_001 ;
  wire \lfuc/lfuary/dram_do_i1_002 ;
  wire \lfuc/lfuary/dram_do_i1_003 ;
  wire \lfuc/lfuary/dram_do_i1_004 ;
  wire \lfuc/lfuary/dram_do_i1_005 ;
  wire \lfuc/lfuary/dram_do_i1_006 ;
  wire \lfuc/lfuary/dram_do_i1_007 ;
  wire \lfuc/lfuary/dram_do_i2_000 ;
  wire \lfuc/lfuary/dram_do_i2_001 ;
  wire \lfuc/lfuary/dram_do_i2_002 ;
  wire \lfuc/lfuary/dram_do_i2_003 ;
  wire \lfuc/lfuary/dram_do_i2_004 ;
  wire \lfuc/lfuary/dram_do_i2_005 ;
  wire \lfuc/lfuary/dram_do_i2_006 ;
  wire \lfuc/lfuary/dram_do_i2_007 ;
  wire \lfuc/lfuary/dram_do_i3_000 ;
  wire \lfuc/lfuary/dram_do_i3_001 ;
  wire \lfuc/lfuary/dram_do_i3_002 ;
  wire \lfuc/lfuary/dram_do_i3_003 ;
  wire \lfuc/lfuary/dram_do_i3_004 ;
  wire \lfuc/lfuary/dram_do_i3_005 ;
  wire \lfuc/lfuary/dram_do_i3_006 ;
  wire \lfuc/lfuary/dram_do_i3_007 ;
  wire \lfuc/lfuary/dram_do_i4_000 ;
  wire \lfuc/lfuary/dram_do_i4_001 ;
  wire \lfuc/lfuary/dram_do_i4_002 ;
  wire \lfuc/lfuary/dram_do_i4_003 ;
  wire \lfuc/lfuary/dram_do_i4_004 ;
  wire \lfuc/lfuary/dram_do_i4_005 ;
  wire \lfuc/lfuary/dram_do_i4_006 ;
  wire \lfuc/lfuary/dram_do_i4_007 ;
  wire \lfuc/lfuary/dram_do_i5_000 ;
  wire \lfuc/lfuary/dram_do_i5_001 ;
  wire \lfuc/lfuary/dram_do_i5_002 ;
  wire \lfuc/lfuary/dram_do_i5_003 ;
  wire \lfuc/lfuary/dram_do_i5_004 ;
  wire \lfuc/lfuary/dram_do_i5_005 ;
  wire \lfuc/lfuary/dram_do_i5_006 ;
  wire \lfuc/lfuary/dram_do_i5_007 ;
  wire \lfuc/lfuary/dram_do_i6_000 ;
  wire \lfuc/lfuary/dram_do_i6_001 ;
  wire \lfuc/lfuary/dram_do_i6_002 ;
  wire \lfuc/lfuary/dram_do_i6_003 ;
  wire \lfuc/lfuary/dram_do_i6_004 ;
  wire \lfuc/lfuary/dram_do_i6_005 ;
  wire \lfuc/lfuary/dram_do_i6_006 ;
  wire \lfuc/lfuary/dram_do_i6_007 ;
  wire \lfuc/lfuary/dram_do_i7_000 ;
  wire \lfuc/lfuary/dram_do_i7_001 ;
  wire \lfuc/lfuary/dram_do_i7_002 ;
  wire \lfuc/lfuary/dram_do_i7_003 ;
  wire \lfuc/lfuary/dram_do_i7_004 ;
  wire \lfuc/lfuary/dram_do_i7_005 ;
  wire \lfuc/lfuary/dram_do_i7_006 ;
  wire \lfuc/lfuary/dram_do_i7_007 ;
  wire \lfuc/mux10_b16_sel_is_2_o ;
  wire \lfuc/mux14_b16_sel_is_2_o ;
  wire \lfuc/mux4_b0_sel_is_2_o ;
  wire \lfuc/n28 ;
  wire \mbif/rd_cachdat ;  // rtl/cache2w4k.v(262)
  wire \way0/eq0/xor_i0[0]_i1[0]_o_lutinv ;
  wire \way0/eq0/xor_i0[1]_i1[1]_o_lutinv ;
  wire \way0/eq0/xor_i0[4]_i1[4]_o_lutinv ;
  wire \way0/eq0/xor_i0[5]_i1[5]_o_lutinv ;
  wire \way0/eq0/xor_i0[6]_i1[6]_o_lutinv ;
  wire \way0/tary/dram_do_i0_000 ;
  wire \way0/tary/dram_do_i0_001 ;
  wire \way0/tary/dram_do_i0_002 ;
  wire \way0/tary/dram_do_i0_003 ;
  wire \way0/tary/dram_do_i0_004 ;
  wire \way0/tary/dram_do_i0_005 ;
  wire \way0/tary/dram_do_i0_006 ;
  wire \way0/tary/dram_do_i0_007 ;
  wire \way0/tary/dram_do_i0_008 ;
  wire \way0/tary/dram_do_i0_009 ;
  wire \way0/tary/dram_do_i0_010 ;
  wire \way0/tary/dram_do_i0_011 ;
  wire \way0/tary/dram_do_i0_012 ;
  wire \way0/tary/dram_do_i1_000 ;
  wire \way0/tary/dram_do_i1_001 ;
  wire \way0/tary/dram_do_i1_002 ;
  wire \way0/tary/dram_do_i1_003 ;
  wire \way0/tary/dram_do_i1_004 ;
  wire \way0/tary/dram_do_i1_005 ;
  wire \way0/tary/dram_do_i1_006 ;
  wire \way0/tary/dram_do_i1_007 ;
  wire \way0/tary/dram_do_i1_008 ;
  wire \way0/tary/dram_do_i1_009 ;
  wire \way0/tary/dram_do_i1_010 ;
  wire \way0/tary/dram_do_i1_011 ;
  wire \way0/tary/dram_do_i1_012 ;
  wire \way0/tary/dram_do_i2_000 ;
  wire \way0/tary/dram_do_i2_001 ;
  wire \way0/tary/dram_do_i2_002 ;
  wire \way0/tary/dram_do_i2_003 ;
  wire \way0/tary/dram_do_i2_004 ;
  wire \way0/tary/dram_do_i2_005 ;
  wire \way0/tary/dram_do_i2_006 ;
  wire \way0/tary/dram_do_i2_007 ;
  wire \way0/tary/dram_do_i2_008 ;
  wire \way0/tary/dram_do_i2_009 ;
  wire \way0/tary/dram_do_i2_010 ;
  wire \way0/tary/dram_do_i2_011 ;
  wire \way0/tary/dram_do_i2_012 ;
  wire \way0/tary/dram_do_i3_000 ;
  wire \way0/tary/dram_do_i3_001 ;
  wire \way0/tary/dram_do_i3_002 ;
  wire \way0/tary/dram_do_i3_003 ;
  wire \way0/tary/dram_do_i3_004 ;
  wire \way0/tary/dram_do_i3_005 ;
  wire \way0/tary/dram_do_i3_006 ;
  wire \way0/tary/dram_do_i3_007 ;
  wire \way0/tary/dram_do_i3_008 ;
  wire \way0/tary/dram_do_i3_009 ;
  wire \way0/tary/dram_do_i3_010 ;
  wire \way0/tary/dram_do_i3_011 ;
  wire \way0/tary/dram_do_i3_012 ;
  wire \way0/tary/dram_do_i4_000 ;
  wire \way0/tary/dram_do_i4_001 ;
  wire \way0/tary/dram_do_i4_002 ;
  wire \way0/tary/dram_do_i4_003 ;
  wire \way0/tary/dram_do_i4_004 ;
  wire \way0/tary/dram_do_i4_005 ;
  wire \way0/tary/dram_do_i4_006 ;
  wire \way0/tary/dram_do_i4_007 ;
  wire \way0/tary/dram_do_i4_008 ;
  wire \way0/tary/dram_do_i4_009 ;
  wire \way0/tary/dram_do_i4_010 ;
  wire \way0/tary/dram_do_i4_011 ;
  wire \way0/tary/dram_do_i4_012 ;
  wire \way0/tary/dram_do_i5_000 ;
  wire \way0/tary/dram_do_i5_001 ;
  wire \way0/tary/dram_do_i5_002 ;
  wire \way0/tary/dram_do_i5_003 ;
  wire \way0/tary/dram_do_i5_004 ;
  wire \way0/tary/dram_do_i5_005 ;
  wire \way0/tary/dram_do_i5_006 ;
  wire \way0/tary/dram_do_i5_007 ;
  wire \way0/tary/dram_do_i5_008 ;
  wire \way0/tary/dram_do_i5_009 ;
  wire \way0/tary/dram_do_i5_010 ;
  wire \way0/tary/dram_do_i5_011 ;
  wire \way0/tary/dram_do_i5_012 ;
  wire \way0/tary/dram_do_i6_000 ;
  wire \way0/tary/dram_do_i6_001 ;
  wire \way0/tary/dram_do_i6_002 ;
  wire \way0/tary/dram_do_i6_003 ;
  wire \way0/tary/dram_do_i6_004 ;
  wire \way0/tary/dram_do_i6_005 ;
  wire \way0/tary/dram_do_i6_006 ;
  wire \way0/tary/dram_do_i6_007 ;
  wire \way0/tary/dram_do_i6_008 ;
  wire \way0/tary/dram_do_i6_009 ;
  wire \way0/tary/dram_do_i6_010 ;
  wire \way0/tary/dram_do_i6_011 ;
  wire \way0/tary/dram_do_i6_012 ;
  wire \way0/tary/dram_do_i7_000 ;
  wire \way0/tary/dram_do_i7_001 ;
  wire \way0/tary/dram_do_i7_002 ;
  wire \way0/tary/dram_do_i7_003 ;
  wire \way0/tary/dram_do_i7_004 ;
  wire \way0/tary/dram_do_i7_005 ;
  wire \way0/tary/dram_do_i7_006 ;
  wire \way0/tary/dram_do_i7_007 ;
  wire \way0/tary/dram_do_i7_008 ;
  wire \way0/tary/dram_do_i7_009 ;
  wire \way0/tary/dram_do_i7_010 ;
  wire \way0/tary/dram_do_i7_011 ;
  wire \way0/tary/dram_do_i7_012 ;
  wire \way0/way_ta_wadr[5]_neg_lutinv ;
  wire \way0/way_ta_we_0_0_0 ;
  wire \way0/way_ta_we_0_0_1 ;
  wire \way0/way_ta_we_0_1_0 ;
  wire \way0/way_ta_we_0_1_1 ;
  wire \way0/way_ta_we_1_0_0 ;
  wire \way0/way_ta_we_1_0_1 ;
  wire \way0/way_ta_we_1_1_0 ;
  wire \way0/way_ta_we_1_1_1 ;
  wire way0_hit;  // rtl/cache2w4k.v(79)
  wire \way1/eq0/xor_i0[0]_i1[0]_o_lutinv ;
  wire \way1/eq0/xor_i0[10]_i1[10]_o_lutinv ;
  wire \way1/eq0/xor_i0[3]_i1[3]_o_lutinv ;
  wire \way1/eq0/xor_i0[6]_i1[6]_o_lutinv ;
  wire \way1/eq0/xor_i0[7]_i1[7]_o_lutinv ;
  wire \way1/eq0/xor_i0[8]_i1[8]_o_lutinv ;
  wire \way1/tary/dram_do_i0_000 ;
  wire \way1/tary/dram_do_i0_001 ;
  wire \way1/tary/dram_do_i0_002 ;
  wire \way1/tary/dram_do_i0_003 ;
  wire \way1/tary/dram_do_i0_004 ;
  wire \way1/tary/dram_do_i0_005 ;
  wire \way1/tary/dram_do_i0_006 ;
  wire \way1/tary/dram_do_i0_007 ;
  wire \way1/tary/dram_do_i0_008 ;
  wire \way1/tary/dram_do_i0_009 ;
  wire \way1/tary/dram_do_i0_010 ;
  wire \way1/tary/dram_do_i0_011 ;
  wire \way1/tary/dram_do_i0_012 ;
  wire \way1/tary/dram_do_i1_000 ;
  wire \way1/tary/dram_do_i1_001 ;
  wire \way1/tary/dram_do_i1_002 ;
  wire \way1/tary/dram_do_i1_003 ;
  wire \way1/tary/dram_do_i1_004 ;
  wire \way1/tary/dram_do_i1_005 ;
  wire \way1/tary/dram_do_i1_006 ;
  wire \way1/tary/dram_do_i1_007 ;
  wire \way1/tary/dram_do_i1_008 ;
  wire \way1/tary/dram_do_i1_009 ;
  wire \way1/tary/dram_do_i1_010 ;
  wire \way1/tary/dram_do_i1_011 ;
  wire \way1/tary/dram_do_i1_012 ;
  wire \way1/tary/dram_do_i2_000 ;
  wire \way1/tary/dram_do_i2_001 ;
  wire \way1/tary/dram_do_i2_002 ;
  wire \way1/tary/dram_do_i2_003 ;
  wire \way1/tary/dram_do_i2_004 ;
  wire \way1/tary/dram_do_i2_005 ;
  wire \way1/tary/dram_do_i2_006 ;
  wire \way1/tary/dram_do_i2_007 ;
  wire \way1/tary/dram_do_i2_008 ;
  wire \way1/tary/dram_do_i2_009 ;
  wire \way1/tary/dram_do_i2_010 ;
  wire \way1/tary/dram_do_i2_011 ;
  wire \way1/tary/dram_do_i2_012 ;
  wire \way1/tary/dram_do_i3_000 ;
  wire \way1/tary/dram_do_i3_001 ;
  wire \way1/tary/dram_do_i3_002 ;
  wire \way1/tary/dram_do_i3_003 ;
  wire \way1/tary/dram_do_i3_004 ;
  wire \way1/tary/dram_do_i3_005 ;
  wire \way1/tary/dram_do_i3_006 ;
  wire \way1/tary/dram_do_i3_007 ;
  wire \way1/tary/dram_do_i3_008 ;
  wire \way1/tary/dram_do_i3_009 ;
  wire \way1/tary/dram_do_i3_010 ;
  wire \way1/tary/dram_do_i3_011 ;
  wire \way1/tary/dram_do_i3_012 ;
  wire \way1/tary/dram_do_i4_000 ;
  wire \way1/tary/dram_do_i4_001 ;
  wire \way1/tary/dram_do_i4_002 ;
  wire \way1/tary/dram_do_i4_003 ;
  wire \way1/tary/dram_do_i4_004 ;
  wire \way1/tary/dram_do_i4_005 ;
  wire \way1/tary/dram_do_i4_006 ;
  wire \way1/tary/dram_do_i4_007 ;
  wire \way1/tary/dram_do_i4_008 ;
  wire \way1/tary/dram_do_i4_009 ;
  wire \way1/tary/dram_do_i4_010 ;
  wire \way1/tary/dram_do_i4_011 ;
  wire \way1/tary/dram_do_i4_012 ;
  wire \way1/tary/dram_do_i5_000 ;
  wire \way1/tary/dram_do_i5_001 ;
  wire \way1/tary/dram_do_i5_002 ;
  wire \way1/tary/dram_do_i5_003 ;
  wire \way1/tary/dram_do_i5_004 ;
  wire \way1/tary/dram_do_i5_005 ;
  wire \way1/tary/dram_do_i5_006 ;
  wire \way1/tary/dram_do_i5_007 ;
  wire \way1/tary/dram_do_i5_008 ;
  wire \way1/tary/dram_do_i5_009 ;
  wire \way1/tary/dram_do_i5_010 ;
  wire \way1/tary/dram_do_i5_011 ;
  wire \way1/tary/dram_do_i5_012 ;
  wire \way1/tary/dram_do_i6_000 ;
  wire \way1/tary/dram_do_i6_001 ;
  wire \way1/tary/dram_do_i6_002 ;
  wire \way1/tary/dram_do_i6_003 ;
  wire \way1/tary/dram_do_i6_004 ;
  wire \way1/tary/dram_do_i6_005 ;
  wire \way1/tary/dram_do_i6_006 ;
  wire \way1/tary/dram_do_i6_007 ;
  wire \way1/tary/dram_do_i6_008 ;
  wire \way1/tary/dram_do_i6_009 ;
  wire \way1/tary/dram_do_i6_010 ;
  wire \way1/tary/dram_do_i6_011 ;
  wire \way1/tary/dram_do_i6_012 ;
  wire \way1/tary/dram_do_i7_000 ;
  wire \way1/tary/dram_do_i7_001 ;
  wire \way1/tary/dram_do_i7_002 ;
  wire \way1/tary/dram_do_i7_003 ;
  wire \way1/tary/dram_do_i7_004 ;
  wire \way1/tary/dram_do_i7_005 ;
  wire \way1/tary/dram_do_i7_006 ;
  wire \way1/tary/dram_do_i7_007 ;
  wire \way1/tary/dram_do_i7_008 ;
  wire \way1/tary/dram_do_i7_009 ;
  wire \way1/tary/dram_do_i7_010 ;
  wire \way1/tary/dram_do_i7_011 ;
  wire \way1/tary/dram_do_i7_012 ;
  wire \way1/way_ta_wadr[5]_neg_lutinv ;
  wire \way1/way_ta_we_0_0_0 ;
  wire \way1/way_ta_we_0_0_1 ;
  wire \way1/way_ta_we_0_1_0 ;
  wire \way1/way_ta_we_0_1_1 ;
  wire \way1/way_ta_we_1_0_0 ;
  wire \way1/way_ta_we_1_0_1 ;
  wire \way1/way_ta_we_1_1_0 ;
  wire \way1/way_ta_we_1_1_1 ;
  wire way1_hit;  // rtl/cache2w4k.v(80)
  wire wr_cachcnth;  // rtl/cache2w4k.v(105)
  wire wr_cachhith;  // rtl/cache2w4k.v(107)

  assign cch_da_adr[10] = way1_hit;
  assign cch_da_adr[9] = badr[10];
  assign cch_da_adr[8] = badr[9];
  assign cch_da_adr[7] = badr[8];
  assign cch_da_adr[6] = badr[7];
  assign cch_da_adr[5] = badr[6];
  assign cch_da_adr[4] = badr[5];
  assign cch_da_adr[3] = badr[4];
  assign cch_da_adr[2] = badr[3];
  assign cch_da_adr[1] = badr[2];
  assign cch_da_adr[0] = badr[1];
  assign cch_da_datw[15] = bdatw[15];
  assign cch_da_datw[14] = bdatw[14];
  assign cch_da_datw[13] = bdatw[13];
  assign cch_da_datw[12] = bdatw[12];
  assign cch_da_datw[11] = bdatw[11];
  assign cch_da_datw[10] = bdatw[10];
  assign cch_da_datw[9] = bdatw[9];
  assign cch_da_datw[8] = bdatw[8];
  assign cch_da_datw[7] = bdatw[7];
  assign cch_da_datw[6] = bdatw[6];
  assign cch_da_datw[5] = bdatw[5];
  assign cch_da_datw[4] = bdatw[4];
  assign cch_da_datw[3] = bdatw[3];
  assign cch_da_datw[2] = bdatw[2];
  assign cch_da_datw[1] = bdatw[1];
  assign cch_da_datw[0] = bdatw[0];
  assign cch_hit = cch_da_ce;
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u100 (
    .a(iorg_la_re),
    .b(iorg_la_radr[2]),
    .c(badr[6]),
    .o(\lfuc/lfu_la_radr [2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u101 (
    .a(iorg_la_re),
    .b(iorg_la_radr[3]),
    .c(badr[7]),
    .o(\lfuc/lfu_la_radr [3]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u102 (
    .a(iorg_la_re),
    .b(iorg_la_radr[4]),
    .c(badr[8]),
    .o(_al_u102_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u103 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_007 ),
    .c(\lfuc/lfuary/dram_do_i5_007 ),
    .o(\lfuc/lfuary/dram_do_mux_b7/B0_2 ));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u104 (
    .a(iorg_la_re),
    .b(iorg_la_radr[5]),
    .c(badr[9]),
    .o(_al_u104_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u105 (
    .a(\lfuc/lfuary/dram_do_mux_b7/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_007 ),
    .e(\lfuc/lfuary/dram_do_i7_007 ),
    .o(_al_u105_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u106 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_007 ),
    .c(\lfuc/lfuary/dram_do_i1_007 ),
    .o(\lfuc/lfuary/dram_do_mux_b7/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u107 (
    .a(\lfuc/lfuary/dram_do_mux_b7/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_007 ),
    .e(\lfuc/lfuary/dram_do_i3_007 ),
    .o(_al_u107_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u108 (
    .a(_al_u105_o),
    .b(_al_u107_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u109 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_006 ),
    .c(\lfuc/lfuary/dram_do_i5_006 ),
    .o(\lfuc/lfuary/dram_do_mux_b6/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u110 (
    .a(\lfuc/lfuary/dram_do_mux_b6/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_006 ),
    .e(\lfuc/lfuary/dram_do_i7_006 ),
    .o(_al_u110_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u111 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_006 ),
    .c(\lfuc/lfuary/dram_do_i1_006 ),
    .o(\lfuc/lfuary/dram_do_mux_b6/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u112 (
    .a(\lfuc/lfuary/dram_do_mux_b6/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_006 ),
    .e(\lfuc/lfuary/dram_do_i3_006 ),
    .o(_al_u112_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u113 (
    .a(_al_u110_o),
    .b(_al_u112_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u114 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_005 ),
    .c(\lfuc/lfuary/dram_do_i5_005 ),
    .o(\lfuc/lfuary/dram_do_mux_b5/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u115 (
    .a(\lfuc/lfuary/dram_do_mux_b5/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_005 ),
    .e(\lfuc/lfuary/dram_do_i7_005 ),
    .o(_al_u115_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u116 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_005 ),
    .c(\lfuc/lfuary/dram_do_i1_005 ),
    .o(\lfuc/lfuary/dram_do_mux_b5/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u117 (
    .a(\lfuc/lfuary/dram_do_mux_b5/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_005 ),
    .e(\lfuc/lfuary/dram_do_i3_005 ),
    .o(_al_u117_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u118 (
    .a(_al_u115_o),
    .b(_al_u117_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u119 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_004 ),
    .c(\lfuc/lfuary/dram_do_i5_004 ),
    .o(\lfuc/lfuary/dram_do_mux_b4/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u120 (
    .a(\lfuc/lfuary/dram_do_mux_b4/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_004 ),
    .e(\lfuc/lfuary/dram_do_i7_004 ),
    .o(_al_u120_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u121 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_004 ),
    .c(\lfuc/lfuary/dram_do_i1_004 ),
    .o(\lfuc/lfuary/dram_do_mux_b4/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u122 (
    .a(\lfuc/lfuary/dram_do_mux_b4/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_004 ),
    .e(\lfuc/lfuary/dram_do_i3_004 ),
    .o(_al_u122_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u123 (
    .a(_al_u120_o),
    .b(_al_u122_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[4]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u124 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_003 ),
    .c(\lfuc/lfuary/dram_do_i5_003 ),
    .o(\lfuc/lfuary/dram_do_mux_b3/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u125 (
    .a(\lfuc/lfuary/dram_do_mux_b3/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_003 ),
    .e(\lfuc/lfuary/dram_do_i7_003 ),
    .o(_al_u125_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u126 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_003 ),
    .c(\lfuc/lfuary/dram_do_i1_003 ),
    .o(\lfuc/lfuary/dram_do_mux_b3/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u127 (
    .a(\lfuc/lfuary/dram_do_mux_b3/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_003 ),
    .e(\lfuc/lfuary/dram_do_i3_003 ),
    .o(_al_u127_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u128 (
    .a(_al_u125_o),
    .b(_al_u127_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u129 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_002 ),
    .c(\lfuc/lfuary/dram_do_i5_002 ),
    .o(\lfuc/lfuary/dram_do_mux_b2/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u130 (
    .a(\lfuc/lfuary/dram_do_mux_b2/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_002 ),
    .e(\lfuc/lfuary/dram_do_i7_002 ),
    .o(_al_u130_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u131 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_002 ),
    .c(\lfuc/lfuary/dram_do_i1_002 ),
    .o(\lfuc/lfuary/dram_do_mux_b2/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u132 (
    .a(\lfuc/lfuary/dram_do_mux_b2/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_002 ),
    .e(\lfuc/lfuary/dram_do_i3_002 ),
    .o(_al_u132_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u133 (
    .a(_al_u130_o),
    .b(_al_u132_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u134 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_001 ),
    .c(\lfuc/lfuary/dram_do_i5_001 ),
    .o(\lfuc/lfuary/dram_do_mux_b1/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u135 (
    .a(\lfuc/lfuary/dram_do_mux_b1/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_001 ),
    .e(\lfuc/lfuary/dram_do_i7_001 ),
    .o(_al_u135_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u136 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_001 ),
    .c(\lfuc/lfuary/dram_do_i1_001 ),
    .o(\lfuc/lfuary/dram_do_mux_b1/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u137 (
    .a(\lfuc/lfuary/dram_do_mux_b1/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_001 ),
    .e(\lfuc/lfuary/dram_do_i3_001 ),
    .o(_al_u137_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u138 (
    .a(_al_u135_o),
    .b(_al_u137_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u139 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i4_000 ),
    .c(\lfuc/lfuary/dram_do_i5_000 ),
    .o(\lfuc/lfuary/dram_do_mux_b0/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u140 (
    .a(\lfuc/lfuary/dram_do_mux_b0/B0_2 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i6_000 ),
    .e(\lfuc/lfuary/dram_do_i7_000 ),
    .o(_al_u140_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u141 (
    .a(_al_u102_o),
    .b(\lfuc/lfuary/dram_do_i0_000 ),
    .c(\lfuc/lfuary/dram_do_i1_000 ),
    .o(\lfuc/lfuary/dram_do_mux_b0/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u142 (
    .a(\lfuc/lfuary/dram_do_mux_b0/B0_0 ),
    .b(_al_u104_o),
    .c(_al_u102_o),
    .d(\lfuc/lfuary/dram_do_i2_000 ),
    .e(\lfuc/lfuary/dram_do_i3_000 ),
    .o(_al_u142_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+B*A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))+~(B)*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)+B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h55355333))
    _al_u143 (
    .a(_al_u140_o),
    .b(_al_u142_o),
    .c(iorg_la_re),
    .d(iorg_la_radr[6]),
    .e(badr[10]),
    .o(lfu_la_rdat[0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u144 (
    .a(bcmd[1]),
    .b(bcs_sdrc_n),
    .c(brdy),
    .o(\iorg/n38 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u145 (
    .a(\iorg/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_cachcnth));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u146 (
    .a(\iorg/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_cachhith));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u147 (
    .a(\iorg/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/wr_cachtag ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u148 (
    .a(\iorg/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/wr_cachlfu ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u149 (
    .a(\iorg/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/wr_cachctl ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u150 (
    .a(bcmd[0]),
    .b(bcs_sdrc_n),
    .o(_al_u150_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u151 (
    .a(_al_u150_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/n13 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u152 (
    .a(_al_u150_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/n19 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u153 (
    .a(_al_u150_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/n7 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u154 (
    .a(_al_u150_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/n22 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u155 (
    .a(_al_u150_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u156 (
    .a(_al_u150_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u157 (
    .a(_al_u150_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\iorg/n4 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u158 (
    .a(\iorg/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(_al_u158_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u159 (
    .a(iorg_cche),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(brdy),
    .o(_al_u159_o));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u160 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [9]),
    .c(_al_u159_o),
    .d(cachcnt[9]),
    .e(bdatw[9]),
    .o(\lfuc/n25 [9]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u161 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [8]),
    .c(_al_u159_o),
    .d(cachcnt[8]),
    .e(bdatw[8]),
    .o(\lfuc/n25 [8]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u162 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [7]),
    .c(_al_u159_o),
    .d(cachcnt[7]),
    .e(bdatw[7]),
    .o(\lfuc/n25 [7]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u163 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [6]),
    .c(_al_u159_o),
    .d(cachcnt[6]),
    .e(bdatw[6]),
    .o(\lfuc/n25 [6]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u164 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [5]),
    .c(_al_u159_o),
    .d(cachcnt[5]),
    .e(bdatw[5]),
    .o(\lfuc/n25 [5]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u165 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [4]),
    .c(_al_u159_o),
    .d(cachcnt[4]),
    .e(bdatw[4]),
    .o(\lfuc/n25 [4]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u166 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [3]),
    .c(_al_u159_o),
    .d(cachcnt[3]),
    .e(bdatw[3]),
    .o(\lfuc/n25 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u167 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [2]),
    .c(_al_u159_o),
    .d(cachcnt[2]),
    .e(bdatw[2]),
    .o(\lfuc/n25 [2]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u168 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [15]),
    .c(_al_u159_o),
    .d(cachcnt[15]),
    .e(bdatw[15]),
    .o(\lfuc/n25 [15]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u169 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [14]),
    .c(_al_u159_o),
    .d(cachcnt[14]),
    .e(bdatw[14]),
    .o(\lfuc/n25 [14]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u170 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [13]),
    .c(_al_u159_o),
    .d(cachcnt[13]),
    .e(bdatw[13]),
    .o(\lfuc/n25 [13]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u171 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [12]),
    .c(_al_u159_o),
    .d(cachcnt[12]),
    .e(bdatw[12]),
    .o(\lfuc/n25 [12]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u172 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [11]),
    .c(_al_u159_o),
    .d(cachcnt[11]),
    .e(bdatw[11]),
    .o(\lfuc/n25 [11]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u173 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [10]),
    .c(_al_u159_o),
    .d(cachcnt[10]),
    .e(bdatw[10]),
    .o(\lfuc/n25 [10]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)*~(A)+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*~(A)+~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*E*A+(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E*A)"),
    .INIT(32'hefea4540))
    _al_u174 (
    .a(_al_u158_o),
    .b(\lfuc/n23 [1]),
    .c(_al_u159_o),
    .d(cachcnt[1]),
    .e(bdatw[1]),
    .o(\lfuc/n25 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*~(E)*~(A)+(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*E*~(A)+~((D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))*E*A+(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*E*A)"),
    .INIT(32'hfbea5140))
    _al_u175 (
    .a(_al_u158_o),
    .b(_al_u159_o),
    .c(\lfuc/n23 [0]),
    .d(cachcnt[0]),
    .e(bdatw[0]),
    .o(\lfuc/n25 [0]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u176 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[0]),
    .d(cachhit[16]),
    .o(_al_u176_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u177 (
    .a(_al_u176_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[0]),
    .e(cachcnt[16]),
    .o(\iorg/n51 [0]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*D)*~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B))"),
    .INIT(32'hffe2e2e2))
    _al_u178 (
    .a(\iorg/n51 [0]),
    .b(\iorg/rd_cachctl ),
    .c(iorg_cche),
    .d(\mbif/rd_cachdat ),
    .e(cch_da_datr[0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u179 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[1]),
    .d(cachhit[17]),
    .o(_al_u179_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u180 (
    .a(_al_u179_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[1]),
    .e(cachcnt[17]),
    .o(\iorg/n51 [1]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u181 (
    .a(\iorg/n51 [1]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u182 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[10]),
    .d(cachhit[26]),
    .o(_al_u182_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u183 (
    .a(_al_u182_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[10]),
    .e(cachcnt[26]),
    .o(\iorg/n51 [10]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u184 (
    .a(\iorg/n51 [10]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[10]),
    .o(bdatr[10]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u185 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[11]),
    .d(cachhit[27]),
    .o(_al_u185_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u186 (
    .a(_al_u185_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[11]),
    .e(cachcnt[27]),
    .o(\iorg/n51 [11]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u187 (
    .a(\iorg/n51 [11]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[11]),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u188 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[12]),
    .d(cachhit[28]),
    .o(_al_u188_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u189 (
    .a(_al_u188_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[12]),
    .e(cachcnt[28]),
    .o(\iorg/n51 [12]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u190 (
    .a(\iorg/n51 [12]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[12]),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u191 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[13]),
    .d(cachhit[29]),
    .o(_al_u191_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u192 (
    .a(_al_u191_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[13]),
    .e(cachcnt[29]),
    .o(\iorg/n51 [13]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u193 (
    .a(\iorg/n51 [13]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[13]),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u194 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[14]),
    .d(cachhit[30]),
    .o(_al_u194_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u195 (
    .a(_al_u194_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[14]),
    .e(cachcnt[30]),
    .o(\iorg/n51 [14]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u196 (
    .a(\iorg/n51 [14]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[14]),
    .o(bdatr[14]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u197 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[15]),
    .d(cachhit[31]),
    .o(_al_u197_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u198 (
    .a(_al_u197_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[15]),
    .e(cachcnt[31]),
    .o(\iorg/n51 [15]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u199 (
    .a(\iorg/n51 [15]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[15]),
    .o(bdatr[15]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u200 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[18]),
    .d(cachhit[2]),
    .o(_al_u200_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u201 (
    .a(_al_u200_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[18]),
    .e(cachcnt[2]),
    .o(\iorg/n51 [2]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u202 (
    .a(\iorg/n51 [2]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u203 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[19]),
    .d(cachhit[3]),
    .o(_al_u203_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u204 (
    .a(_al_u203_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[19]),
    .e(cachcnt[3]),
    .o(\iorg/n51 [3]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u205 (
    .a(\iorg/n51 [3]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u206 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[20]),
    .d(cachhit[4]),
    .o(_al_u206_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u207 (
    .a(_al_u206_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[20]),
    .e(cachcnt[4]),
    .o(\iorg/n51 [4]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u208 (
    .a(\iorg/n51 [4]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[4]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u209 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[21]),
    .d(cachhit[5]),
    .o(_al_u209_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u210 (
    .a(_al_u209_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[21]),
    .e(cachcnt[5]),
    .o(\iorg/n51 [5]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u211 (
    .a(\iorg/n51 [5]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[5]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u212 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[22]),
    .d(cachhit[6]),
    .o(_al_u212_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u213 (
    .a(_al_u212_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[22]),
    .e(cachcnt[6]),
    .o(\iorg/n51 [6]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u214 (
    .a(\iorg/n51 [6]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u215 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[23]),
    .d(cachhit[7]),
    .o(_al_u215_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u216 (
    .a(_al_u215_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[23]),
    .e(cachcnt[7]),
    .o(\iorg/n51 [7]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u217 (
    .a(\iorg/n51 [7]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[7]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u218 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[24]),
    .d(cachhit[8]),
    .o(_al_u218_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u219 (
    .a(_al_u218_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[24]),
    .e(cachcnt[8]),
    .o(\iorg/n51 [8]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u220 (
    .a(\iorg/n51 [8]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[8]),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u221 (
    .a(\iorg/rd_cachhith ),
    .b(\iorg/rd_cachhitl ),
    .c(cachhit[25]),
    .d(cachhit[9]),
    .o(_al_u221_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u222 (
    .a(_al_u221_o),
    .b(\iorg/rd_cachcnth ),
    .c(\iorg/rd_cachcntl ),
    .d(cachcnt[25]),
    .e(cachcnt[9]),
    .o(\iorg/n51 [9]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(~B*A))"),
    .INIT(16'hf222))
    _al_u223 (
    .a(\iorg/n51 [9]),
    .b(\iorg/rd_cachctl ),
    .c(\mbif/rd_cachdat ),
    .d(cch_da_datr[9]),
    .o(bdatr[9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u224 (
    .a(\iorg/wr_cachlfu ),
    .b(bdatw[15]),
    .c(bdatw[14]),
    .o(iorg_la_we));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u225 (
    .a(iorg_la_we),
    .b(badr[7]),
    .c(bdatw[3]),
    .o(\lfuc/lfu_la_wadr [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u226 (
    .a(iorg_la_we),
    .b(badr[6]),
    .c(bdatw[2]),
    .o(\lfuc/lfu_la_wadr [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u227 (
    .a(iorg_la_we),
    .b(badr[5]),
    .c(bdatw[1]),
    .o(\lfuc/lfu_la_wadr [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u228 (
    .a(iorg_la_we),
    .b(badr[4]),
    .c(bdatw[0]),
    .o(\lfuc/lfu_la_wadr [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u229 (
    .a(\iorg/wr_cachtag ),
    .b(bdatw[15]),
    .c(bdatw[7]),
    .o(iorg_ta1_we));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u230 (
    .a(iorg_ta1_we),
    .b(badr[20]),
    .o(\way1/way_ta_wdat [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u231 (
    .a(iorg_ta1_we),
    .b(badr[19]),
    .o(\way1/way_ta_wdat [8]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u232 (
    .a(iorg_ta1_we),
    .b(badr[18]),
    .o(\way1/way_ta_wdat [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u233 (
    .a(iorg_ta1_we),
    .b(badr[17]),
    .o(\way1/way_ta_wdat [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u234 (
    .a(iorg_ta1_we),
    .b(badr[16]),
    .o(\way1/way_ta_wdat [5]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u235 (
    .a(iorg_ta1_we),
    .b(badr[15]),
    .o(\way1/way_ta_wdat [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u236 (
    .a(iorg_ta1_we),
    .b(badr[14]),
    .o(\way1/way_ta_wdat [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u237 (
    .a(iorg_ta1_we),
    .b(badr[13]),
    .o(\way1/way_ta_wdat [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u238 (
    .a(iorg_ta1_we),
    .b(badr[23]),
    .o(\way1/way_ta_wdat [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u239 (
    .a(iorg_ta1_we),
    .b(badr[22]),
    .o(\way1/way_ta_wdat [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u240 (
    .a(iorg_ta1_we),
    .b(badr[21]),
    .o(\way1/way_ta_wdat [10]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u241 (
    .a(iorg_ta1_we),
    .b(badr[12]),
    .o(\way1/way_ta_wdat [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u242 (
    .a(iorg_ta1_we),
    .b(badr[11]),
    .o(\way1/way_ta_wdat [0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u243 (
    .a(iorg_ta1_we),
    .b(badr[7]),
    .c(bdatw[3]),
    .o(\way1/way_ta_wadr [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u244 (
    .a(iorg_ta1_we),
    .b(badr[6]),
    .c(bdatw[2]),
    .o(\way1/way_ta_wadr [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u245 (
    .a(iorg_ta1_we),
    .b(badr[5]),
    .c(bdatw[1]),
    .o(\way1/way_ta_wadr [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u246 (
    .a(iorg_ta1_we),
    .b(badr[4]),
    .c(bdatw[0]),
    .o(\way1/way_ta_wadr [0]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u247 (
    .a(\iorg/wr_cachtag ),
    .b(bdatw[15]),
    .c(bdatw[7]),
    .o(iorg_ta0_we));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u248 (
    .a(iorg_ta0_we),
    .b(badr[20]),
    .o(\way0/way_ta_wdat [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u249 (
    .a(iorg_ta0_we),
    .b(badr[19]),
    .o(\way0/way_ta_wdat [8]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u250 (
    .a(iorg_ta0_we),
    .b(badr[18]),
    .o(\way0/way_ta_wdat [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u251 (
    .a(iorg_ta0_we),
    .b(badr[17]),
    .o(\way0/way_ta_wdat [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u252 (
    .a(iorg_ta0_we),
    .b(badr[16]),
    .o(\way0/way_ta_wdat [5]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u253 (
    .a(iorg_ta0_we),
    .b(badr[15]),
    .o(\way0/way_ta_wdat [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u254 (
    .a(iorg_ta0_we),
    .b(badr[14]),
    .o(\way0/way_ta_wdat [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u255 (
    .a(iorg_ta0_we),
    .b(badr[13]),
    .o(\way0/way_ta_wdat [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u256 (
    .a(iorg_ta0_we),
    .b(badr[23]),
    .o(\way0/way_ta_wdat [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u257 (
    .a(iorg_ta0_we),
    .b(badr[22]),
    .o(\way0/way_ta_wdat [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u258 (
    .a(iorg_ta0_we),
    .b(badr[21]),
    .o(\way0/way_ta_wdat [10]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u259 (
    .a(iorg_ta0_we),
    .b(badr[12]),
    .o(\way0/way_ta_wdat [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u260 (
    .a(iorg_ta0_we),
    .b(badr[11]),
    .o(\way0/way_ta_wdat [0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u261 (
    .a(iorg_ta0_we),
    .b(badr[7]),
    .c(bdatw[3]),
    .o(\way0/way_ta_wadr [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u262 (
    .a(iorg_ta0_we),
    .b(badr[6]),
    .c(bdatw[2]),
    .o(\way0/way_ta_wadr [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u263 (
    .a(iorg_ta0_we),
    .b(badr[5]),
    .c(bdatw[1]),
    .o(\way0/way_ta_wadr [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u264 (
    .a(iorg_ta0_we),
    .b(badr[4]),
    .c(bdatw[0]),
    .o(\way0/way_ta_wadr [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u265 (
    .a(_al_u158_o),
    .b(_al_u159_o),
    .o(\lfuc/mux10_b16_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u266 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [31]),
    .c(wr_cachcnth),
    .d(cachcnt[31]),
    .e(bdatw[15]),
    .o(\lfuc/n26 [31]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u267 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [30]),
    .c(wr_cachcnth),
    .d(cachcnt[30]),
    .e(bdatw[14]),
    .o(\lfuc/n26 [30]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u268 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [29]),
    .c(wr_cachcnth),
    .d(cachcnt[29]),
    .e(bdatw[13]),
    .o(\lfuc/n26 [29]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u269 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [28]),
    .c(wr_cachcnth),
    .d(cachcnt[28]),
    .e(bdatw[12]),
    .o(\lfuc/n26 [28]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u270 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [27]),
    .c(wr_cachcnth),
    .d(cachcnt[27]),
    .e(bdatw[11]),
    .o(\lfuc/n26 [27]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u271 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [26]),
    .c(wr_cachcnth),
    .d(cachcnt[26]),
    .e(bdatw[10]),
    .o(\lfuc/n26 [26]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u272 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [25]),
    .c(wr_cachcnth),
    .d(cachcnt[25]),
    .e(bdatw[9]),
    .o(\lfuc/n26 [25]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u273 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [24]),
    .c(wr_cachcnth),
    .d(cachcnt[24]),
    .e(bdatw[8]),
    .o(\lfuc/n26 [24]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u274 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [23]),
    .c(wr_cachcnth),
    .d(cachcnt[23]),
    .e(bdatw[7]),
    .o(\lfuc/n26 [23]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u275 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(\lfuc/n23 [22]),
    .c(wr_cachcnth),
    .d(cachcnt[22]),
    .e(bdatw[6]),
    .o(\lfuc/n26 [22]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u276 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(wr_cachcnth),
    .c(\lfuc/n23 [21]),
    .d(cachcnt[21]),
    .e(bdatw[5]),
    .o(\lfuc/n26 [21]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u277 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(wr_cachcnth),
    .c(\lfuc/n23 [20]),
    .d(cachcnt[20]),
    .e(bdatw[4]),
    .o(\lfuc/n26 [20]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u278 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(wr_cachcnth),
    .c(\lfuc/n23 [19]),
    .d(cachcnt[19]),
    .e(bdatw[3]),
    .o(\lfuc/n26 [19]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u279 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(wr_cachcnth),
    .c(\lfuc/n23 [18]),
    .d(cachcnt[18]),
    .e(bdatw[2]),
    .o(\lfuc/n26 [18]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u280 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(wr_cachcnth),
    .c(\lfuc/n23 [17]),
    .d(cachcnt[17]),
    .e(bdatw[1]),
    .o(\lfuc/n26 [17]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u281 (
    .a(\lfuc/mux10_b16_sel_is_2_o ),
    .b(wr_cachcnth),
    .c(\lfuc/n23 [16]),
    .d(cachcnt[16]),
    .e(bdatw[0]),
    .o(\lfuc/n26 [16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u282 (
    .a(_al_u159_o),
    .b(badr[10]),
    .o(_al_u282_o));
  AL_MAP_LUT5 #(
    .EQN("~((C*B)*~((E*D))*~(A)+(C*B)*(E*D)*~(A)+~((C*B))*(E*D)*A+(C*B)*(E*D)*A)"),
    .INIT(32'h15bfbfbf))
    _al_u283 (
    .a(iorg_la_we),
    .b(_al_u282_o),
    .c(badr[9]),
    .d(bdatw[6]),
    .e(bdatw[5]),
    .o(_al_u283_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h5410))
    _al_u284 (
    .a(_al_u283_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_1_1_1 ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h0145))
    _al_u285 (
    .a(_al_u283_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_1_1_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((~C*B)*~((~E*D))*~(A)+(~C*B)*(~E*D)*~(A)+~((~C*B))*(~E*D)*A+(~C*B)*(~E*D)*A)"),
    .INIT(32'hfbfb51fb))
    _al_u286 (
    .a(iorg_la_we),
    .b(_al_u282_o),
    .c(badr[9]),
    .d(bdatw[6]),
    .e(bdatw[5]),
    .o(_al_u286_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h5410))
    _al_u287 (
    .a(_al_u286_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_1_0_1 ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h0145))
    _al_u288 (
    .a(_al_u286_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_1_0_0 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u289 (
    .a(_al_u159_o),
    .b(badr[10]),
    .o(_al_u289_o));
  AL_MAP_LUT5 #(
    .EQN("~((C*B)*~((E*~D))*~(A)+(C*B)*(E*~D)*~(A)+~((C*B))*(E*~D)*A+(C*B)*(E*~D)*A)"),
    .INIT(32'hbf15bfbf))
    _al_u290 (
    .a(iorg_la_we),
    .b(_al_u289_o),
    .c(badr[9]),
    .d(bdatw[6]),
    .e(bdatw[5]),
    .o(_al_u290_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h5410))
    _al_u291 (
    .a(_al_u290_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_0_1_1 ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h0145))
    _al_u292 (
    .a(_al_u290_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_0_1_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((~C*B)*~((~E*~D))*~(A)+(~C*B)*(~E*~D)*~(A)+~((~C*B))*(~E*~D)*A+(~C*B)*(~E*~D)*A)"),
    .INIT(32'hfbfbfb51))
    _al_u293 (
    .a(iorg_la_we),
    .b(_al_u289_o),
    .c(badr[9]),
    .d(bdatw[6]),
    .e(bdatw[5]),
    .o(_al_u293_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h5410))
    _al_u294 (
    .a(_al_u293_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_0_0_1 ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h0145))
    _al_u295 (
    .a(_al_u293_o),
    .b(iorg_la_we),
    .c(badr[8]),
    .d(bdatw[4]),
    .o(\lfuc/lfu_la_we_0_0_0 ));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u296 (
    .a(iorg_ta_re),
    .b(iorg_ta_radr[4]),
    .c(badr[8]),
    .o(_al_u296_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u297 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_012 ),
    .c(\way1/tary/dram_do_i5_012 ),
    .o(\way1/tary/dram_do_mux_b12/B0_2 ));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u298 (
    .a(iorg_ta_re),
    .b(iorg_ta_radr[5]),
    .c(badr[9]),
    .o(_al_u298_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u299 (
    .a(\way1/tary/dram_do_mux_b12/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_012 ),
    .e(\way1/tary/dram_do_i7_012 ),
    .o(_al_u299_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u300 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_012 ),
    .c(\way1/tary/dram_do_i1_012 ),
    .o(\way1/tary/dram_do_mux_b12/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u301 (
    .a(\way1/tary/dram_do_mux_b12/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_012 ),
    .e(\way1/tary/dram_do_i3_012 ),
    .o(_al_u301_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u302 (
    .a(iorg_ta_re),
    .b(iorg_ta_radr[6]),
    .c(badr[10]),
    .o(_al_u302_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u303 (
    .a(_al_u299_o),
    .b(_al_u301_o),
    .c(_al_u302_o),
    .o(way1_ta_rdat[12]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u304 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_010 ),
    .c(\way1/tary/dram_do_i5_010 ),
    .o(\way1/tary/dram_do_mux_b10/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u305 (
    .a(\way1/tary/dram_do_mux_b10/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_010 ),
    .e(\way1/tary/dram_do_i7_010 ),
    .o(_al_u305_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u306 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_010 ),
    .c(\way1/tary/dram_do_i1_010 ),
    .o(\way1/tary/dram_do_mux_b10/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u307 (
    .a(\way1/tary/dram_do_mux_b10/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_010 ),
    .e(\way1/tary/dram_do_i3_010 ),
    .o(_al_u307_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u308 (
    .a(_al_u305_o),
    .b(_al_u307_o),
    .c(_al_u302_o),
    .d(badr[21]),
    .o(\way1/eq0/xor_i0[10]_i1[10]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*A*~(~C*~B))"),
    .INIT(32'h00a80000))
    _al_u309 (
    .a(iorg_cche),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .e(brdy),
    .o(\dactl/n0_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(C*~B*~(D*~A))"),
    .INIT(16'h2030))
    _al_u310 (
    .a(way1_ta_rdat[12]),
    .b(\way1/eq0/xor_i0[10]_i1[10]_o_lutinv ),
    .c(\dactl/n0_lutinv ),
    .d(badr[23]),
    .o(_al_u310_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u311 (
    .a(way1_ta_rdat[12]),
    .b(badr[23]),
    .o(_al_u311_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u312 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_005 ),
    .c(\way1/tary/dram_do_i5_005 ),
    .o(\way1/tary/dram_do_mux_b5/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u313 (
    .a(\way1/tary/dram_do_mux_b5/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_005 ),
    .e(\way1/tary/dram_do_i7_005 ),
    .o(_al_u313_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u314 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_005 ),
    .c(\way1/tary/dram_do_i1_005 ),
    .o(\way1/tary/dram_do_mux_b5/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u315 (
    .a(\way1/tary/dram_do_mux_b5/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_005 ),
    .e(\way1/tary/dram_do_i3_005 ),
    .o(_al_u315_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u316 (
    .a(_al_u313_o),
    .b(_al_u315_o),
    .c(_al_u302_o),
    .o(way1_ta_rdat[5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u317 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_000 ),
    .c(\way1/tary/dram_do_i5_000 ),
    .o(\way1/tary/dram_do_mux_b0/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u318 (
    .a(\way1/tary/dram_do_mux_b0/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_000 ),
    .e(\way1/tary/dram_do_i7_000 ),
    .o(_al_u318_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u319 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_000 ),
    .c(\way1/tary/dram_do_i1_000 ),
    .o(\way1/tary/dram_do_mux_b0/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u320 (
    .a(\way1/tary/dram_do_mux_b0/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_000 ),
    .e(\way1/tary/dram_do_i3_000 ),
    .o(_al_u320_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u321 (
    .a(_al_u318_o),
    .b(_al_u320_o),
    .c(_al_u302_o),
    .d(badr[11]),
    .o(\way1/eq0/xor_i0[0]_i1[0]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*A*~(~E*C))"),
    .INIT(32'h00220002))
    _al_u322 (
    .a(_al_u310_o),
    .b(_al_u311_o),
    .c(way1_ta_rdat[5]),
    .d(\way1/eq0/xor_i0[0]_i1[0]_o_lutinv ),
    .e(badr[16]),
    .o(_al_u322_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u323 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_011 ),
    .c(\way1/tary/dram_do_i5_011 ),
    .o(\way1/tary/dram_do_mux_b11/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u324 (
    .a(\way1/tary/dram_do_mux_b11/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_011 ),
    .e(\way1/tary/dram_do_i7_011 ),
    .o(_al_u324_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u325 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_011 ),
    .c(\way1/tary/dram_do_i1_011 ),
    .o(\way1/tary/dram_do_mux_b11/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u326 (
    .a(\way1/tary/dram_do_mux_b11/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_011 ),
    .e(\way1/tary/dram_do_i3_011 ),
    .o(_al_u326_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u327 (
    .a(_al_u324_o),
    .b(_al_u326_o),
    .c(_al_u302_o),
    .d(badr[22]),
    .o(_al_u327_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u328 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_002 ),
    .c(\way1/tary/dram_do_i5_002 ),
    .o(\way1/tary/dram_do_mux_b2/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u329 (
    .a(\way1/tary/dram_do_mux_b2/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_002 ),
    .e(\way1/tary/dram_do_i7_002 ),
    .o(_al_u329_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u330 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_002 ),
    .c(\way1/tary/dram_do_i1_002 ),
    .o(\way1/tary/dram_do_mux_b2/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u331 (
    .a(\way1/tary/dram_do_mux_b2/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_002 ),
    .e(\way1/tary/dram_do_i3_002 ),
    .o(_al_u331_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u332 (
    .a(_al_u329_o),
    .b(_al_u331_o),
    .c(_al_u302_o),
    .d(badr[13]),
    .o(_al_u332_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u333 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_009 ),
    .c(\way1/tary/dram_do_i5_009 ),
    .o(\way1/tary/dram_do_mux_b9/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u334 (
    .a(\way1/tary/dram_do_mux_b9/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_009 ),
    .e(\way1/tary/dram_do_i7_009 ),
    .o(_al_u334_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u335 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_009 ),
    .c(\way1/tary/dram_do_i1_009 ),
    .o(\way1/tary/dram_do_mux_b9/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u336 (
    .a(\way1/tary/dram_do_mux_b9/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_009 ),
    .e(\way1/tary/dram_do_i3_009 ),
    .o(_al_u336_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u337 (
    .a(_al_u334_o),
    .b(_al_u336_o),
    .c(_al_u302_o),
    .d(badr[20]),
    .o(_al_u337_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u338 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_001 ),
    .c(\way1/tary/dram_do_i5_001 ),
    .o(\way1/tary/dram_do_mux_b1/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u339 (
    .a(\way1/tary/dram_do_mux_b1/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_001 ),
    .e(\way1/tary/dram_do_i7_001 ),
    .o(_al_u339_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u340 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_001 ),
    .c(\way1/tary/dram_do_i1_001 ),
    .o(\way1/tary/dram_do_mux_b1/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u341 (
    .a(\way1/tary/dram_do_mux_b1/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_001 ),
    .e(\way1/tary/dram_do_i3_001 ),
    .o(_al_u341_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u342 (
    .a(_al_u339_o),
    .b(_al_u341_o),
    .c(_al_u302_o),
    .d(badr[12]),
    .o(_al_u342_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u343 (
    .a(_al_u322_o),
    .b(_al_u327_o),
    .c(_al_u332_o),
    .d(_al_u337_o),
    .e(_al_u342_o),
    .o(_al_u343_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u344 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_004 ),
    .c(\way1/tary/dram_do_i5_004 ),
    .o(\way1/tary/dram_do_mux_b4/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u345 (
    .a(\way1/tary/dram_do_mux_b4/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_004 ),
    .e(\way1/tary/dram_do_i7_004 ),
    .o(_al_u345_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u346 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_004 ),
    .c(\way1/tary/dram_do_i1_004 ),
    .o(\way1/tary/dram_do_mux_b4/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u347 (
    .a(\way1/tary/dram_do_mux_b4/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_004 ),
    .e(\way1/tary/dram_do_i3_004 ),
    .o(_al_u347_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u348 (
    .a(_al_u345_o),
    .b(_al_u347_o),
    .c(_al_u302_o),
    .o(way1_ta_rdat[4]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u349 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_003 ),
    .c(\way1/tary/dram_do_i5_003 ),
    .o(\way1/tary/dram_do_mux_b3/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u350 (
    .a(\way1/tary/dram_do_mux_b3/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_003 ),
    .e(\way1/tary/dram_do_i7_003 ),
    .o(_al_u350_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u351 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_003 ),
    .c(\way1/tary/dram_do_i1_003 ),
    .o(\way1/tary/dram_do_mux_b3/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u352 (
    .a(\way1/tary/dram_do_mux_b3/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_003 ),
    .e(\way1/tary/dram_do_i3_003 ),
    .o(_al_u352_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u353 (
    .a(_al_u350_o),
    .b(_al_u352_o),
    .c(_al_u302_o),
    .d(badr[14]),
    .o(\way1/eq0/xor_i0[3]_i1[3]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*~C)*~(~E*A))"),
    .INIT(32'h30331011))
    _al_u354 (
    .a(way1_ta_rdat[4]),
    .b(\way1/eq0/xor_i0[3]_i1[3]_o_lutinv ),
    .c(way1_ta_rdat[5]),
    .d(badr[16]),
    .e(badr[15]),
    .o(_al_u354_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u355 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i6_006 ),
    .c(\way1/tary/dram_do_i7_006 ),
    .o(\way1/tary/dram_do_mux_b6/B0_3 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u356 (
    .a(\way1/tary/dram_do_mux_b6/B0_3 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i4_006 ),
    .e(\way1/tary/dram_do_i5_006 ),
    .o(_al_u356_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u357 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i2_006 ),
    .c(\way1/tary/dram_do_i3_006 ),
    .o(\way1/tary/dram_do_mux_b6/B0_1 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u358 (
    .a(\way1/tary/dram_do_mux_b6/B0_1 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i0_006 ),
    .e(\way1/tary/dram_do_i1_006 ),
    .o(_al_u358_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u359 (
    .a(_al_u356_o),
    .b(_al_u358_o),
    .c(_al_u302_o),
    .d(badr[17]),
    .o(\way1/eq0/xor_i0[6]_i1[6]_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u360 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i6_007 ),
    .c(\way1/tary/dram_do_i7_007 ),
    .o(\way1/tary/dram_do_mux_b7/B0_3 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u361 (
    .a(\way1/tary/dram_do_mux_b7/B0_3 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i4_007 ),
    .e(\way1/tary/dram_do_i5_007 ),
    .o(_al_u361_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u362 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i2_007 ),
    .c(\way1/tary/dram_do_i3_007 ),
    .o(\way1/tary/dram_do_mux_b7/B0_1 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u363 (
    .a(\way1/tary/dram_do_mux_b7/B0_1 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i0_007 ),
    .e(\way1/tary/dram_do_i1_007 ),
    .o(_al_u363_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u364 (
    .a(_al_u361_o),
    .b(_al_u363_o),
    .c(_al_u302_o),
    .d(badr[18]),
    .o(\way1/eq0/xor_i0[7]_i1[7]_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u365 (
    .a(_al_u354_o),
    .b(\way1/eq0/xor_i0[6]_i1[6]_o_lutinv ),
    .c(\way1/eq0/xor_i0[7]_i1[7]_o_lutinv ),
    .o(_al_u365_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u366 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i4_008 ),
    .c(\way1/tary/dram_do_i5_008 ),
    .o(\way1/tary/dram_do_mux_b8/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u367 (
    .a(\way1/tary/dram_do_mux_b8/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i6_008 ),
    .e(\way1/tary/dram_do_i7_008 ),
    .o(_al_u367_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u368 (
    .a(_al_u296_o),
    .b(\way1/tary/dram_do_i0_008 ),
    .c(\way1/tary/dram_do_i1_008 ),
    .o(\way1/tary/dram_do_mux_b8/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u369 (
    .a(\way1/tary/dram_do_mux_b8/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way1/tary/dram_do_i2_008 ),
    .e(\way1/tary/dram_do_i3_008 ),
    .o(_al_u369_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u370 (
    .a(_al_u367_o),
    .b(_al_u369_o),
    .c(_al_u302_o),
    .d(badr[19]),
    .o(\way1/eq0/xor_i0[8]_i1[8]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~D*B*A*~(E*~C))"),
    .INIT(32'h00800088))
    _al_u371 (
    .a(_al_u343_o),
    .b(_al_u365_o),
    .c(way1_ta_rdat[4]),
    .d(\way1/eq0/xor_i0[8]_i1[8]_o_lutinv ),
    .e(badr[15]),
    .o(way1_hit));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u372 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_003 ),
    .c(\way0/tary/dram_do_i5_003 ),
    .o(\way0/tary/dram_do_mux_b3/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u373 (
    .a(\way0/tary/dram_do_mux_b3/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_003 ),
    .e(\way0/tary/dram_do_i7_003 ),
    .o(_al_u373_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u374 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_003 ),
    .c(\way0/tary/dram_do_i1_003 ),
    .o(\way0/tary/dram_do_mux_b3/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u375 (
    .a(\way0/tary/dram_do_mux_b3/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_003 ),
    .e(\way0/tary/dram_do_i3_003 ),
    .o(_al_u375_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u376 (
    .a(_al_u373_o),
    .b(_al_u375_o),
    .c(_al_u302_o),
    .o(way0_ta_rdat[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u377 (
    .a(way0_ta_rdat[3]),
    .b(badr[14]),
    .o(_al_u377_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u378 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_010 ),
    .c(\way0/tary/dram_do_i5_010 ),
    .o(\way0/tary/dram_do_mux_b10/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u379 (
    .a(\way0/tary/dram_do_mux_b10/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_010 ),
    .e(\way0/tary/dram_do_i7_010 ),
    .o(_al_u379_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u380 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_010 ),
    .c(\way0/tary/dram_do_i1_010 ),
    .o(\way0/tary/dram_do_mux_b10/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u381 (
    .a(\way0/tary/dram_do_mux_b10/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_010 ),
    .e(\way0/tary/dram_do_i3_010 ),
    .o(_al_u381_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u382 (
    .a(_al_u379_o),
    .b(_al_u381_o),
    .c(_al_u302_o),
    .o(way0_ta_rdat[10]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u383 (
    .a(way0_ta_rdat[10]),
    .b(badr[21]),
    .o(_al_u383_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u384 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_001 ),
    .c(\way0/tary/dram_do_i5_001 ),
    .o(\way0/tary/dram_do_mux_b1/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u385 (
    .a(\way0/tary/dram_do_mux_b1/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_001 ),
    .e(\way0/tary/dram_do_i7_001 ),
    .o(_al_u385_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u386 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_001 ),
    .c(\way0/tary/dram_do_i1_001 ),
    .o(\way0/tary/dram_do_mux_b1/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u387 (
    .a(\way0/tary/dram_do_mux_b1/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_001 ),
    .e(\way0/tary/dram_do_i3_001 ),
    .o(_al_u387_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u388 (
    .a(_al_u385_o),
    .b(_al_u387_o),
    .c(_al_u302_o),
    .d(badr[12]),
    .o(\way0/eq0/xor_i0[1]_i1[1]_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u389 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i6_000 ),
    .c(\way0/tary/dram_do_i7_000 ),
    .o(\way0/tary/dram_do_mux_b0/B0_3 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u390 (
    .a(\way0/tary/dram_do_mux_b0/B0_3 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i4_000 ),
    .e(\way0/tary/dram_do_i5_000 ),
    .o(_al_u390_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u391 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i2_000 ),
    .c(\way0/tary/dram_do_i3_000 ),
    .o(\way0/tary/dram_do_mux_b0/B0_1 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u392 (
    .a(\way0/tary/dram_do_mux_b0/B0_1 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i0_000 ),
    .e(\way0/tary/dram_do_i1_000 ),
    .o(_al_u392_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u393 (
    .a(_al_u390_o),
    .b(_al_u392_o),
    .c(_al_u302_o),
    .d(badr[11]),
    .o(\way0/eq0/xor_i0[0]_i1[0]_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u394 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i6_007 ),
    .c(\way0/tary/dram_do_i7_007 ),
    .o(\way0/tary/dram_do_mux_b7/B0_3 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u395 (
    .a(\way0/tary/dram_do_mux_b7/B0_3 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i4_007 ),
    .e(\way0/tary/dram_do_i5_007 ),
    .o(_al_u395_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u396 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i2_007 ),
    .c(\way0/tary/dram_do_i3_007 ),
    .o(\way0/tary/dram_do_mux_b7/B0_1 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u397 (
    .a(\way0/tary/dram_do_mux_b7/B0_1 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i0_007 ),
    .e(\way0/tary/dram_do_i1_007 ),
    .o(_al_u397_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u398 (
    .a(_al_u395_o),
    .b(_al_u397_o),
    .c(_al_u302_o),
    .d(badr[18]),
    .o(_al_u398_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*~A)"),
    .INIT(32'h00010000))
    _al_u399 (
    .a(_al_u377_o),
    .b(_al_u383_o),
    .c(\way0/eq0/xor_i0[1]_i1[1]_o_lutinv ),
    .d(\way0/eq0/xor_i0[0]_i1[0]_o_lutinv ),
    .e(_al_u398_o),
    .o(_al_u399_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u400 (
    .a(way0_ta_rdat[3]),
    .b(badr[14]),
    .o(_al_u400_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u401 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_011 ),
    .c(\way0/tary/dram_do_i5_011 ),
    .o(\way0/tary/dram_do_mux_b11/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u402 (
    .a(\way0/tary/dram_do_mux_b11/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_011 ),
    .e(\way0/tary/dram_do_i7_011 ),
    .o(_al_u402_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u403 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_011 ),
    .c(\way0/tary/dram_do_i1_011 ),
    .o(\way0/tary/dram_do_mux_b11/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u404 (
    .a(\way0/tary/dram_do_mux_b11/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_011 ),
    .e(\way0/tary/dram_do_i3_011 ),
    .o(_al_u404_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u405 (
    .a(_al_u402_o),
    .b(_al_u404_o),
    .c(_al_u302_o),
    .o(way0_ta_rdat[11]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u406 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i6_006 ),
    .c(\way0/tary/dram_do_i7_006 ),
    .o(\way0/tary/dram_do_mux_b6/B0_3 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u407 (
    .a(\way0/tary/dram_do_mux_b6/B0_3 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i4_006 ),
    .e(\way0/tary/dram_do_i5_006 ),
    .o(_al_u407_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u408 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i2_006 ),
    .c(\way0/tary/dram_do_i3_006 ),
    .o(\way0/tary/dram_do_mux_b6/B0_1 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u409 (
    .a(\way0/tary/dram_do_mux_b6/B0_1 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i0_006 ),
    .e(\way0/tary/dram_do_i1_006 ),
    .o(_al_u409_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u410 (
    .a(_al_u407_o),
    .b(_al_u409_o),
    .c(_al_u302_o),
    .d(badr[17]),
    .o(\way0/eq0/xor_i0[6]_i1[6]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(~D*B))"),
    .INIT(16'h0501))
    _al_u411 (
    .a(_al_u400_o),
    .b(way0_ta_rdat[11]),
    .c(\way0/eq0/xor_i0[6]_i1[6]_o_lutinv ),
    .d(badr[22]),
    .o(_al_u411_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u412 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_002 ),
    .c(\way0/tary/dram_do_i5_002 ),
    .o(\way0/tary/dram_do_mux_b2/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u413 (
    .a(\way0/tary/dram_do_mux_b2/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_002 ),
    .e(\way0/tary/dram_do_i7_002 ),
    .o(_al_u413_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u414 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_002 ),
    .c(\way0/tary/dram_do_i1_002 ),
    .o(\way0/tary/dram_do_mux_b2/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u415 (
    .a(\way0/tary/dram_do_mux_b2/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_002 ),
    .e(\way0/tary/dram_do_i3_002 ),
    .o(_al_u415_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u416 (
    .a(_al_u413_o),
    .b(_al_u415_o),
    .c(_al_u302_o),
    .o(way0_ta_rdat[2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u417 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_009 ),
    .c(\way0/tary/dram_do_i5_009 ),
    .o(\way0/tary/dram_do_mux_b9/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u418 (
    .a(\way0/tary/dram_do_mux_b9/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_009 ),
    .e(\way0/tary/dram_do_i7_009 ),
    .o(_al_u418_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u419 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_009 ),
    .c(\way0/tary/dram_do_i1_009 ),
    .o(\way0/tary/dram_do_mux_b9/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u420 (
    .a(\way0/tary/dram_do_mux_b9/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_009 ),
    .e(\way0/tary/dram_do_i3_009 ),
    .o(_al_u420_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u421 (
    .a(_al_u418_o),
    .b(_al_u420_o),
    .c(_al_u302_o),
    .d(badr[20]),
    .o(_al_u421_o));
  AL_MAP_LUT5 #(
    .EQN("(D*B*A*~(E@C))"),
    .INIT(32'h80000800))
    _al_u422 (
    .a(_al_u399_o),
    .b(_al_u411_o),
    .c(way0_ta_rdat[2]),
    .d(_al_u421_o),
    .e(badr[13]),
    .o(_al_u422_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u423 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_005 ),
    .c(\way0/tary/dram_do_i5_005 ),
    .o(\way0/tary/dram_do_mux_b5/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u424 (
    .a(\way0/tary/dram_do_mux_b5/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_005 ),
    .e(\way0/tary/dram_do_i7_005 ),
    .o(_al_u424_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u425 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_005 ),
    .c(\way0/tary/dram_do_i1_005 ),
    .o(\way0/tary/dram_do_mux_b5/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u426 (
    .a(\way0/tary/dram_do_mux_b5/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_005 ),
    .e(\way0/tary/dram_do_i3_005 ),
    .o(_al_u426_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u427 (
    .a(_al_u424_o),
    .b(_al_u426_o),
    .c(_al_u302_o),
    .d(badr[16]),
    .o(\way0/eq0/xor_i0[5]_i1[5]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(C*~B*~(D*~A))"),
    .INIT(16'h2030))
    _al_u428 (
    .a(way0_ta_rdat[10]),
    .b(\way0/eq0/xor_i0[5]_i1[5]_o_lutinv ),
    .c(\dactl/n0_lutinv ),
    .d(badr[21]),
    .o(_al_u428_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u429 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i6_008 ),
    .c(\way0/tary/dram_do_i7_008 ),
    .o(\way0/tary/dram_do_mux_b8/B0_3 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u430 (
    .a(\way0/tary/dram_do_mux_b8/B0_3 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i4_008 ),
    .e(\way0/tary/dram_do_i5_008 ),
    .o(_al_u430_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u431 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i2_008 ),
    .c(\way0/tary/dram_do_i3_008 ),
    .o(\way0/tary/dram_do_mux_b8/B0_1 ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'h11d11ddd))
    _al_u432 (
    .a(\way0/tary/dram_do_mux_b8/B0_1 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i0_008 ),
    .e(\way0/tary/dram_do_i1_008 ),
    .o(_al_u432_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u433 (
    .a(_al_u430_o),
    .b(_al_u432_o),
    .c(_al_u302_o),
    .d(badr[19]),
    .o(_al_u433_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u434 (
    .a(way0_ta_rdat[11]),
    .b(_al_u433_o),
    .c(badr[22]),
    .o(_al_u434_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u435 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_012 ),
    .c(\way0/tary/dram_do_i5_012 ),
    .o(\way0/tary/dram_do_mux_b12/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u436 (
    .a(\way0/tary/dram_do_mux_b12/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_012 ),
    .e(\way0/tary/dram_do_i7_012 ),
    .o(_al_u436_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u437 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_012 ),
    .c(\way0/tary/dram_do_i1_012 ),
    .o(\way0/tary/dram_do_mux_b12/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u438 (
    .a(\way0/tary/dram_do_mux_b12/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_012 ),
    .e(\way0/tary/dram_do_i3_012 ),
    .o(_al_u438_o));
  AL_MAP_LUT4 #(
    .EQN("(D@(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'h35ca))
    _al_u439 (
    .a(_al_u436_o),
    .b(_al_u438_o),
    .c(_al_u302_o),
    .d(badr[23]),
    .o(_al_u439_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u440 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i4_004 ),
    .c(\way0/tary/dram_do_i5_004 ),
    .o(\way0/tary/dram_do_mux_b4/B0_2 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u441 (
    .a(\way0/tary/dram_do_mux_b4/B0_2 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i6_004 ),
    .e(\way0/tary/dram_do_i7_004 ),
    .o(_al_u441_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u442 (
    .a(_al_u296_o),
    .b(\way0/tary/dram_do_i0_004 ),
    .c(\way0/tary/dram_do_i1_004 ),
    .o(\way0/tary/dram_do_mux_b4/B0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h44744777))
    _al_u443 (
    .a(\way0/tary/dram_do_mux_b4/B0_0 ),
    .b(_al_u298_o),
    .c(_al_u296_o),
    .d(\way0/tary/dram_do_i2_004 ),
    .e(\way0/tary/dram_do_i3_004 ),
    .o(_al_u443_o));
  AL_MAP_LUT4 #(
    .EQN("(D@~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca35))
    _al_u444 (
    .a(_al_u441_o),
    .b(_al_u443_o),
    .c(_al_u302_o),
    .d(badr[15]),
    .o(\way0/eq0/xor_i0[4]_i1[4]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u445 (
    .a(_al_u422_o),
    .b(_al_u428_o),
    .c(_al_u434_o),
    .d(_al_u439_o),
    .e(\way0/eq0/xor_i0[4]_i1[4]_o_lutinv ),
    .o(way0_hit));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u446 (
    .a(way1_hit),
    .b(way0_hit),
    .o(cch_da_ce));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u447 (
    .a(cch_da_ce),
    .b(_al_u159_o),
    .o(\lfuc/n28 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u448 (
    .a(\lfuc/n28 ),
    .b(bcs_sdram_n),
    .o(cch_sdram_n));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u449 (
    .a(cch_da_ce),
    .b(bcmd[1]),
    .o(\dactl/n1 ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u450 (
    .a(\dactl/n1 ),
    .b(badr[0]),
    .c(bcmd[2]),
    .o(cch_da_we[0]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u451 (
    .a(\dactl/n1 ),
    .b(badr[0]),
    .c(bcmd[2]),
    .o(cch_da_we[1]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u452 (
    .a(way0_hit),
    .b(way1_hit),
    .o(_al_u452_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    _al_u453 (
    .a(_al_u452_o),
    .b(_al_u159_o),
    .c(bcmd[1]),
    .o(cch_bcmd[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u454 (
    .a(\lfuc/n28 ),
    .b(bcmd[0]),
    .o(cch_bcmd[0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u455 (
    .a(\iorg/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(_al_u455_o));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u456 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [9]),
    .d(cachhit[9]),
    .e(bdatw[9]),
    .o(\lfuc/n31 [9]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u457 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [8]),
    .d(cachhit[8]),
    .e(bdatw[8]),
    .o(\lfuc/n31 [8]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u458 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [7]),
    .d(cachhit[7]),
    .e(bdatw[7]),
    .o(\lfuc/n31 [7]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u459 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [6]),
    .d(cachhit[6]),
    .e(bdatw[6]),
    .o(\lfuc/n31 [6]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u460 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [5]),
    .d(cachhit[5]),
    .e(bdatw[5]),
    .o(\lfuc/n31 [5]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u461 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [4]),
    .d(cachhit[4]),
    .e(bdatw[4]),
    .o(\lfuc/n31 [4]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u462 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [3]),
    .d(cachhit[3]),
    .e(bdatw[3]),
    .o(\lfuc/n31 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u463 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [2]),
    .d(cachhit[2]),
    .e(bdatw[2]),
    .o(\lfuc/n31 [2]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u464 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [15]),
    .d(cachhit[15]),
    .e(bdatw[15]),
    .o(\lfuc/n31 [15]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u465 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [14]),
    .d(cachhit[14]),
    .e(bdatw[14]),
    .o(\lfuc/n31 [14]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u466 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [13]),
    .d(cachhit[13]),
    .e(bdatw[13]),
    .o(\lfuc/n31 [13]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u467 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [12]),
    .d(cachhit[12]),
    .e(bdatw[12]),
    .o(\lfuc/n31 [12]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u468 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [11]),
    .d(cachhit[11]),
    .e(bdatw[11]),
    .o(\lfuc/n31 [11]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u469 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [10]),
    .d(cachhit[10]),
    .e(bdatw[10]),
    .o(\lfuc/n31 [10]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u470 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [1]),
    .d(cachhit[1]),
    .e(bdatw[1]),
    .o(\lfuc/n31 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u471 (
    .a(\lfuc/n28 ),
    .b(_al_u455_o),
    .c(\lfuc/n29 [0]),
    .d(cachhit[0]),
    .e(bdatw[0]),
    .o(\lfuc/n31 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u472 (
    .a(_al_u452_o),
    .b(_al_u455_o),
    .c(_al_u159_o),
    .o(\lfuc/mux14_b16_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u473 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [31]),
    .c(wr_cachhith),
    .d(cachhit[31]),
    .e(bdatw[15]),
    .o(\lfuc/n32 [31]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u474 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [30]),
    .c(wr_cachhith),
    .d(cachhit[30]),
    .e(bdatw[14]),
    .o(\lfuc/n32 [30]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u475 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [29]),
    .c(wr_cachhith),
    .d(cachhit[29]),
    .e(bdatw[13]),
    .o(\lfuc/n32 [29]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u476 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [28]),
    .c(wr_cachhith),
    .d(cachhit[28]),
    .e(bdatw[12]),
    .o(\lfuc/n32 [28]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u477 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [27]),
    .c(wr_cachhith),
    .d(cachhit[27]),
    .e(bdatw[11]),
    .o(\lfuc/n32 [27]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u478 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [26]),
    .c(wr_cachhith),
    .d(cachhit[26]),
    .e(bdatw[10]),
    .o(\lfuc/n32 [26]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u479 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [25]),
    .c(wr_cachhith),
    .d(cachhit[25]),
    .e(bdatw[9]),
    .o(\lfuc/n32 [25]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u480 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [24]),
    .c(wr_cachhith),
    .d(cachhit[24]),
    .e(bdatw[8]),
    .o(\lfuc/n32 [24]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u481 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [23]),
    .c(wr_cachhith),
    .d(cachhit[23]),
    .e(bdatw[7]),
    .o(\lfuc/n32 [23]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*~(E)*~(C)+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*~(C)+~((D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A))*E*C+(D*~(B)*~(A)+D*B*~(A)+~(D)*B*A+D*B*A)*E*C)"),
    .INIT(32'hfdf80d08))
    _al_u482 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(\lfuc/n29 [22]),
    .c(wr_cachhith),
    .d(cachhit[22]),
    .e(bdatw[6]),
    .o(\lfuc/n32 [22]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u483 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(wr_cachhith),
    .c(\lfuc/n29 [21]),
    .d(cachhit[21]),
    .e(bdatw[5]),
    .o(\lfuc/n32 [21]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u484 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(wr_cachhith),
    .c(\lfuc/n29 [20]),
    .d(cachhit[20]),
    .e(bdatw[4]),
    .o(\lfuc/n32 [20]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u485 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(wr_cachhith),
    .c(\lfuc/n29 [19]),
    .d(cachhit[19]),
    .e(bdatw[3]),
    .o(\lfuc/n32 [19]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u486 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(wr_cachhith),
    .c(\lfuc/n29 [18]),
    .d(cachhit[18]),
    .e(bdatw[2]),
    .o(\lfuc/n32 [18]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u487 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(wr_cachhith),
    .c(\lfuc/n29 [17]),
    .d(cachhit[17]),
    .e(bdatw[1]),
    .o(\lfuc/n32 [17]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*~(E)*~(B)+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*~(B)+~((D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))*E*B+(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A)*E*B)"),
    .INIT(32'hfdec3120))
    _al_u488 (
    .a(\lfuc/mux14_b16_sel_is_2_o ),
    .b(wr_cachhith),
    .c(\lfuc/n29 [16]),
    .d(cachhit[16]),
    .e(bdatw[0]),
    .o(\lfuc/n32 [16]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u489 (
    .a(_al_u159_o),
    .b(bcmd[2]),
    .o(cch_bcmd[2]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)*~(B)+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*~(B)+~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*A*B+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*B)"),
    .INIT(32'h47474477))
    _al_u490 (
    .a(\lfuc/n8 [7]),
    .b(cch_da_ce),
    .c(\lfuc/n14 [7]),
    .d(lfu_la_rdat[7]),
    .e(_al_u159_o),
    .o(_al_u490_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u491 (
    .a(lfu_la_rdat[5]),
    .b(lfu_la_rdat[4]),
    .c(lfu_la_rdat[3]),
    .d(lfu_la_rdat[2]),
    .o(_al_u491_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u492 (
    .a(_al_u491_o),
    .b(lfu_la_rdat[7]),
    .c(lfu_la_rdat[6]),
    .o(_al_u492_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u493 (
    .a(lfu_la_rdat[5]),
    .b(lfu_la_rdat[4]),
    .c(lfu_la_rdat[3]),
    .d(lfu_la_rdat[2]),
    .o(_al_u493_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u494 (
    .a(_al_u493_o),
    .b(lfu_la_rdat[7]),
    .c(lfu_la_rdat[6]),
    .o(_al_u494_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E)"),
    .INIT(32'h0fff5f33))
    _al_u495 (
    .a(way1_hit),
    .b(_al_u492_o),
    .c(_al_u494_o),
    .d(lfu_la_rdat[1]),
    .e(lfu_la_rdat[0]),
    .o(_al_u495_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*C*B))"),
    .INIT(16'haa2a))
    _al_u496 (
    .a(_al_u495_o),
    .b(way0_hit),
    .c(_al_u492_o),
    .d(lfu_la_rdat[1]),
    .o(\lfuc/mux4_b0_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u497 (
    .a(bdatw[14]),
    .b(bdatw[13]),
    .o(\lfuc/n22 [7]));
  AL_MAP_LUT5 #(
    .EQN("(~(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)*~(E)*~(D)+~(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)*E*~(D)+~(~(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B))*E*D+~(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)*E*D)"),
    .INIT(32'hff740074))
    _al_u498 (
    .a(_al_u490_o),
    .b(\lfuc/mux4_b0_sel_is_2_o ),
    .c(lfu_la_rdat[7]),
    .d(iorg_la_we),
    .e(\lfuc/n22 [7]),
    .o(\lfuc/lfu_la_wdat [7]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)*~(B)+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*~(B)+~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*A*B+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*B)"),
    .INIT(32'h47474477))
    _al_u499 (
    .a(\lfuc/n8 [6]),
    .b(cch_da_ce),
    .c(\lfuc/n14 [6]),
    .d(lfu_la_rdat[6]),
    .e(_al_u159_o),
    .o(_al_u499_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(~B*~A))"),
    .INIT(8'h0e))
    _al_u500 (
    .a(\lfuc/mux4_b0_sel_is_2_o ),
    .b(lfu_la_rdat[1]),
    .c(iorg_la_we),
    .o(_al_u500_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u501 (
    .a(\iorg/wr_cachlfu ),
    .b(bdatw[14]),
    .c(bdatw[13]),
    .o(_al_u501_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(B*~(C*A)))"),
    .INIT(16'hff4c))
    _al_u502 (
    .a(_al_u499_o),
    .b(_al_u500_o),
    .c(\lfuc/mux4_b0_sel_is_2_o ),
    .d(_al_u501_o),
    .o(\lfuc/lfu_la_wdat [6]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)*~(B)+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*~(B)+~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*A*B+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*B)"),
    .INIT(32'h47474477))
    _al_u503 (
    .a(\lfuc/n8 [5]),
    .b(cch_da_ce),
    .c(\lfuc/n14 [5]),
    .d(lfu_la_rdat[5]),
    .e(_al_u159_o),
    .o(_al_u503_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(B*~(C*A)))"),
    .INIT(16'hff4c))
    _al_u504 (
    .a(_al_u503_o),
    .b(_al_u500_o),
    .c(\lfuc/mux4_b0_sel_is_2_o ),
    .d(_al_u501_o),
    .o(\lfuc/lfu_la_wdat [5]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)*~(B)+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*~(B)+~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*A*B+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*B)"),
    .INIT(32'h47474477))
    _al_u505 (
    .a(\lfuc/n8 [4]),
    .b(cch_da_ce),
    .c(\lfuc/n14 [4]),
    .d(lfu_la_rdat[4]),
    .e(_al_u159_o),
    .o(_al_u505_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(B*~(C*A)))"),
    .INIT(16'hff4c))
    _al_u506 (
    .a(_al_u505_o),
    .b(_al_u500_o),
    .c(\lfuc/mux4_b0_sel_is_2_o ),
    .d(_al_u501_o),
    .o(\lfuc/lfu_la_wdat [4]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)*~(B)+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*~(B)+~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*A*B+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*B)"),
    .INIT(32'h47474477))
    _al_u507 (
    .a(\lfuc/n8 [3]),
    .b(cch_da_ce),
    .c(\lfuc/n14 [3]),
    .d(lfu_la_rdat[3]),
    .e(_al_u159_o),
    .o(_al_u507_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(B*~(C*A)))"),
    .INIT(16'hff4c))
    _al_u508 (
    .a(_al_u507_o),
    .b(_al_u500_o),
    .c(\lfuc/mux4_b0_sel_is_2_o ),
    .d(_al_u501_o),
    .o(\lfuc/lfu_la_wdat [3]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)*~(B)+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*~(B)+~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*A*B+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*B)"),
    .INIT(32'h47474477))
    _al_u509 (
    .a(\lfuc/n8 [2]),
    .b(cch_da_ce),
    .c(\lfuc/n14 [2]),
    .d(lfu_la_rdat[2]),
    .e(_al_u159_o),
    .o(_al_u509_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(B*~(C*A)))"),
    .INIT(16'hff4c))
    _al_u510 (
    .a(_al_u509_o),
    .b(_al_u500_o),
    .c(\lfuc/mux4_b0_sel_is_2_o ),
    .d(_al_u501_o),
    .o(\lfuc/lfu_la_wdat [2]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)*~(B)+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*~(B)+~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*A*B+(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A*B)"),
    .INIT(32'h47474477))
    _al_u511 (
    .a(\lfuc/n8 [1]),
    .b(cch_da_ce),
    .c(\lfuc/n14 [1]),
    .d(lfu_la_rdat[1]),
    .e(_al_u159_o),
    .o(_al_u511_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(B*~(C*A)))"),
    .INIT(16'hff4c))
    _al_u512 (
    .a(_al_u511_o),
    .b(_al_u500_o),
    .c(\lfuc/mux4_b0_sel_is_2_o ),
    .d(_al_u501_o),
    .o(\lfuc/lfu_la_wdat [1]));
  AL_MAP_LUT5 #(
    .EQN("(B*~((D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E))*~(A)+B*(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*~(A)+~(B)*(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A+B*(D*~(C)*~(E)+D*C*~(E)+~(D)*C*E+D*C*E)*A)"),
    .INIT(32'he4e4ee44))
    _al_u513 (
    .a(_al_u452_o),
    .b(\lfuc/n8 [0]),
    .c(\lfuc/n14 [0]),
    .d(lfu_la_rdat[0]),
    .e(_al_u159_o),
    .o(\lfuc/n16 [0]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~(~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)))"),
    .INIT(32'hffff00d8))
    _al_u514 (
    .a(\lfuc/mux4_b0_sel_is_2_o ),
    .b(\lfuc/n16 [0]),
    .c(lfu_la_rdat[0]),
    .d(iorg_la_we),
    .e(_al_u501_o),
    .o(\lfuc/lfu_la_wdat [0]));
  AL_MAP_LUT5 #(
    .EQN("~((D*B*A)*~(E)*~(C)+(D*B*A)*E*~(C)+~((D*B*A))*E*C+(D*B*A)*E*C)"),
    .INIT(32'h070ff7ff))
    _al_u515 (
    .a(_al_u452_o),
    .b(lfu_la_rdat[7]),
    .c(iorg_ta1_we),
    .d(_al_u282_o),
    .e(bdatw[6]),
    .o(_al_u515_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u516 (
    .a(iorg_ta1_we),
    .b(badr[9]),
    .c(bdatw[5]),
    .o(\way1/way_ta_wadr[5]_neg_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h11100100))
    _al_u517 (
    .a(_al_u515_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_1_1_1 ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00011011))
    _al_u518 (
    .a(_al_u515_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_1_1_0 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h44400400))
    _al_u519 (
    .a(_al_u515_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_1_0_1 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00044044))
    _al_u520 (
    .a(_al_u515_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_1_0_0 ));
  AL_MAP_LUT5 #(
    .EQN("(~(D*B*~A)*~(E)*~(C)+~(D*B*~A)*E*~(C)+~(~(D*B*~A))*E*C+~(D*B*~A)*E*C)"),
    .INIT(32'hfbff0b0f))
    _al_u521 (
    .a(cch_da_ce),
    .b(lfu_la_rdat[7]),
    .c(iorg_ta1_we),
    .d(_al_u289_o),
    .e(bdatw[6]),
    .o(_al_u521_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h11100100))
    _al_u522 (
    .a(_al_u521_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_0_1_1 ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00011011))
    _al_u523 (
    .a(_al_u521_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_0_1_0 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h44400400))
    _al_u524 (
    .a(_al_u521_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_0_0_1 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00044044))
    _al_u525 (
    .a(_al_u521_o),
    .b(\way1/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta1_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way1/way_ta_we_0_0_0 ));
  AL_MAP_LUT5 #(
    .EQN("~((D*~B*A)*~(E)*~(C)+(D*~B*A)*E*~(C)+~((D*~B*A))*E*C+(D*~B*A)*E*C)"),
    .INIT(32'h0d0ffdff))
    _al_u526 (
    .a(_al_u452_o),
    .b(lfu_la_rdat[7]),
    .c(iorg_ta0_we),
    .d(_al_u282_o),
    .e(bdatw[6]),
    .o(_al_u526_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u527 (
    .a(iorg_ta0_we),
    .b(badr[9]),
    .c(bdatw[5]),
    .o(\way0/way_ta_wadr[5]_neg_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h11100100))
    _al_u528 (
    .a(_al_u526_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_1_1_1 ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00011011))
    _al_u529 (
    .a(_al_u526_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_1_1_0 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h44400400))
    _al_u530 (
    .a(_al_u526_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_1_0_1 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00044044))
    _al_u531 (
    .a(_al_u526_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_1_0_0 ));
  AL_MAP_LUT5 #(
    .EQN("(~(D*~B*A)*~(E)*~(C)+~(D*~B*A)*E*~(C)+~(~(D*~B*A))*E*C+~(D*~B*A)*E*C)"),
    .INIT(32'hfdff0d0f))
    _al_u532 (
    .a(_al_u452_o),
    .b(lfu_la_rdat[7]),
    .c(iorg_ta0_we),
    .d(_al_u289_o),
    .e(bdatw[6]),
    .o(_al_u532_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h11100100))
    _al_u533 (
    .a(_al_u532_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_0_1_1 ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00011011))
    _al_u534 (
    .a(_al_u532_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_0_1_0 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h44400400))
    _al_u535 (
    .a(_al_u532_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_0_0_1 ));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00044044))
    _al_u536 (
    .a(_al_u532_o),
    .b(\way0/way_ta_wadr[5]_neg_lutinv ),
    .c(iorg_ta0_we),
    .d(badr[8]),
    .e(bdatw[4]),
    .o(\way0/way_ta_we_0_0_0 ));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u537 (
    .a(lfu_la_rdat[7]),
    .o(\lfu_la_rdat[7]_neg ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u94 (
    .a(iorg_ta_re),
    .b(iorg_ta_radr[0]),
    .c(badr[4]),
    .o(\way0/way_ta_radr [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u95 (
    .a(iorg_ta_re),
    .b(iorg_ta_radr[1]),
    .c(badr[5]),
    .o(\way0/way_ta_radr [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u96 (
    .a(iorg_ta_re),
    .b(iorg_ta_radr[2]),
    .c(badr[6]),
    .o(\way0/way_ta_radr [2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u97 (
    .a(iorg_ta_re),
    .b(iorg_ta_radr[3]),
    .c(badr[7]),
    .o(\way0/way_ta_radr [3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u98 (
    .a(iorg_la_re),
    .b(iorg_la_radr[0]),
    .c(badr[4]),
    .o(\lfuc/lfu_la_radr [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u99 (
    .a(iorg_la_re),
    .b(iorg_la_radr[1]),
    .c(badr[5]),
    .o(\lfuc/lfu_la_radr [1]));
  reg_sr_as_w1 \dactl/reg0_b0  (
    .clk(clk),
    .d(badr[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[0]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \dactl/reg0_b1  (
    .clk(clk),
    .d(badr[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[1]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \dactl/reg0_b2  (
    .clk(clk),
    .d(badr[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[2]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \dactl/reg0_b3  (
    .clk(clk),
    .d(badr[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[3]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \dactl/reg0_b4  (
    .clk(clk),
    .d(badr[8]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[4]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \dactl/reg0_b5  (
    .clk(clk),
    .d(badr[9]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[5]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \dactl/reg0_b6  (
    .clk(clk),
    .d(badr[10]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[6]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \dactl/reg0_b7  (
    .clk(clk),
    .d(lfu_la_rdat[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(cch_bst_adr[7]));  // rtl/cache2w4k.v(564)
  reg_sr_as_w1 \iorg/rd_cachcnth_reg  (
    .clk(clk),
    .d(\iorg/n13 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\iorg/rd_cachcnth ));  // rtl/cache2w4k.v(381)
  reg_sr_as_w1 \iorg/rd_cachcntl_reg  (
    .clk(clk),
    .d(\iorg/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\iorg/rd_cachcntl ));  // rtl/cache2w4k.v(381)
  reg_sr_as_w1 \iorg/rd_cachctl_reg  (
    .clk(clk),
    .d(\iorg/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\iorg/rd_cachctl ));  // rtl/cache2w4k.v(381)
  reg_sr_as_w1 \iorg/rd_cachhith_reg  (
    .clk(clk),
    .d(\iorg/n19 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\iorg/rd_cachhith ));  // rtl/cache2w4k.v(381)
  reg_sr_as_w1 \iorg/rd_cachhitl_reg  (
    .clk(clk),
    .d(\iorg/n22 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\iorg/rd_cachhitl ));  // rtl/cache2w4k.v(381)
  reg_sr_as_w1 \iorg/rd_cachlfu_reg  (
    .clk(clk),
    .d(\iorg/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_re));  // rtl/cache2w4k.v(381)
  reg_sr_as_w1 \iorg/rd_cachtag_reg  (
    .clk(clk),
    .d(\iorg/n7 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_re));  // rtl/cache2w4k.v(381)
  reg_sr_as_w1 \iorg/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\iorg/wr_cachctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_cche));  // rtl/cache2w4k.v(400)
  reg_sr_as_w1 \iorg/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\iorg/wr_cachtag ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_radr[0]));  // rtl/cache2w4k.v(411)
  reg_sr_as_w1 \iorg/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\iorg/wr_cachtag ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_radr[1]));  // rtl/cache2w4k.v(411)
  reg_sr_as_w1 \iorg/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\iorg/wr_cachtag ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_radr[2]));  // rtl/cache2w4k.v(411)
  reg_sr_as_w1 \iorg/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\iorg/wr_cachtag ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_radr[3]));  // rtl/cache2w4k.v(411)
  reg_sr_as_w1 \iorg/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\iorg/wr_cachtag ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_radr[4]));  // rtl/cache2w4k.v(411)
  reg_sr_as_w1 \iorg/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\iorg/wr_cachtag ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_radr[5]));  // rtl/cache2w4k.v(411)
  reg_sr_as_w1 \iorg/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\iorg/wr_cachtag ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_ta_radr[6]));  // rtl/cache2w4k.v(411)
  reg_sr_as_w1 \iorg/reg2_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\iorg/wr_cachlfu ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_radr[0]));  // rtl/cache2w4k.v(430)
  reg_sr_as_w1 \iorg/reg2_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\iorg/wr_cachlfu ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_radr[1]));  // rtl/cache2w4k.v(430)
  reg_sr_as_w1 \iorg/reg2_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\iorg/wr_cachlfu ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_radr[2]));  // rtl/cache2w4k.v(430)
  reg_sr_as_w1 \iorg/reg2_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\iorg/wr_cachlfu ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_radr[3]));  // rtl/cache2w4k.v(430)
  reg_sr_as_w1 \iorg/reg2_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\iorg/wr_cachlfu ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_radr[4]));  // rtl/cache2w4k.v(430)
  reg_sr_as_w1 \iorg/reg2_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\iorg/wr_cachlfu ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_radr[5]));  // rtl/cache2w4k.v(430)
  reg_sr_as_w1 \iorg/reg2_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\iorg/wr_cachlfu ),
    .reset(~rst_n),
    .set(1'b0),
    .q(iorg_la_radr[6]));  // rtl/cache2w4k.v(430)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u0  (
    .a(lfu_la_rdat[0]),
    .b(1'b1),
    .c(\lfuc/add0/c0 ),
    .o({\lfuc/add0/c1 ,\lfuc/n8 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u1  (
    .a(lfu_la_rdat[1]),
    .b(way0_hit),
    .c(\lfuc/add0/c1 ),
    .o({\lfuc/add0/c2 ,\lfuc/n8 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u2  (
    .a(lfu_la_rdat[2]),
    .b(way0_hit),
    .c(\lfuc/add0/c2 ),
    .o({\lfuc/add0/c3 ,\lfuc/n8 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u3  (
    .a(lfu_la_rdat[3]),
    .b(way0_hit),
    .c(\lfuc/add0/c3 ),
    .o({\lfuc/add0/c4 ,\lfuc/n8 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u4  (
    .a(lfu_la_rdat[4]),
    .b(way0_hit),
    .c(\lfuc/add0/c4 ),
    .o({\lfuc/add0/c5 ,\lfuc/n8 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u5  (
    .a(lfu_la_rdat[5]),
    .b(way0_hit),
    .c(\lfuc/add0/c5 ),
    .o({\lfuc/add0/c6 ,\lfuc/n8 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u6  (
    .a(lfu_la_rdat[6]),
    .b(way0_hit),
    .c(\lfuc/add0/c6 ),
    .o({\lfuc/add0/c7 ,\lfuc/n8 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add0/u7  (
    .a(lfu_la_rdat[7]),
    .b(way0_hit),
    .c(\lfuc/add0/c7 ),
    .o({open_n0,\lfuc/n8 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \lfuc/add0/ucin  (
    .a(1'b0),
    .o({\lfuc/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u0  (
    .a(lfu_la_rdat[0]),
    .b(1'b1),
    .c(\lfuc/add1_2/c0 ),
    .o({\lfuc/add1_2/c1 ,\lfuc/n14 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u1  (
    .a(lfu_la_rdat[1]),
    .b(\lfu_la_rdat[7]_neg ),
    .c(\lfuc/add1_2/c1 ),
    .o({\lfuc/add1_2/c2 ,\lfuc/n14 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u2  (
    .a(lfu_la_rdat[2]),
    .b(\lfu_la_rdat[7]_neg ),
    .c(\lfuc/add1_2/c2 ),
    .o({\lfuc/add1_2/c3 ,\lfuc/n14 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u3  (
    .a(lfu_la_rdat[3]),
    .b(\lfu_la_rdat[7]_neg ),
    .c(\lfuc/add1_2/c3 ),
    .o({\lfuc/add1_2/c4 ,\lfuc/n14 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u4  (
    .a(lfu_la_rdat[4]),
    .b(\lfu_la_rdat[7]_neg ),
    .c(\lfuc/add1_2/c4 ),
    .o({\lfuc/add1_2/c5 ,\lfuc/n14 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u5  (
    .a(lfu_la_rdat[5]),
    .b(\lfu_la_rdat[7]_neg ),
    .c(\lfuc/add1_2/c5 ),
    .o({\lfuc/add1_2/c6 ,\lfuc/n14 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u6  (
    .a(lfu_la_rdat[6]),
    .b(\lfu_la_rdat[7]_neg ),
    .c(\lfuc/add1_2/c6 ),
    .o({\lfuc/add1_2/c7 ,\lfuc/n14 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add1_2/u7  (
    .a(1'b0),
    .b(1'b1),
    .c(\lfuc/add1_2/c7 ),
    .o({open_n4,\lfuc/n14 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \lfuc/add1_2/ucin  (
    .a(1'b0),
    .o({\lfuc/add1_2/c0 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u0  (
    .a(cachcnt[0]),
    .b(1'b1),
    .c(\lfuc/add2/c0 ),
    .o({\lfuc/add2/c1 ,\lfuc/n23 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u1  (
    .a(cachcnt[1]),
    .b(1'b0),
    .c(\lfuc/add2/c1 ),
    .o({\lfuc/add2/c2 ,\lfuc/n23 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u10  (
    .a(cachcnt[10]),
    .b(1'b0),
    .c(\lfuc/add2/c10 ),
    .o({\lfuc/add2/c11 ,\lfuc/n23 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u11  (
    .a(cachcnt[11]),
    .b(1'b0),
    .c(\lfuc/add2/c11 ),
    .o({\lfuc/add2/c12 ,\lfuc/n23 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u12  (
    .a(cachcnt[12]),
    .b(1'b0),
    .c(\lfuc/add2/c12 ),
    .o({\lfuc/add2/c13 ,\lfuc/n23 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u13  (
    .a(cachcnt[13]),
    .b(1'b0),
    .c(\lfuc/add2/c13 ),
    .o({\lfuc/add2/c14 ,\lfuc/n23 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u14  (
    .a(cachcnt[14]),
    .b(1'b0),
    .c(\lfuc/add2/c14 ),
    .o({\lfuc/add2/c15 ,\lfuc/n23 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u15  (
    .a(cachcnt[15]),
    .b(1'b0),
    .c(\lfuc/add2/c15 ),
    .o({\lfuc/add2/c16 ,\lfuc/n23 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u16  (
    .a(cachcnt[16]),
    .b(1'b0),
    .c(\lfuc/add2/c16 ),
    .o({\lfuc/add2/c17 ,\lfuc/n23 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u17  (
    .a(cachcnt[17]),
    .b(1'b0),
    .c(\lfuc/add2/c17 ),
    .o({\lfuc/add2/c18 ,\lfuc/n23 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u18  (
    .a(cachcnt[18]),
    .b(1'b0),
    .c(\lfuc/add2/c18 ),
    .o({\lfuc/add2/c19 ,\lfuc/n23 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u19  (
    .a(cachcnt[19]),
    .b(1'b0),
    .c(\lfuc/add2/c19 ),
    .o({\lfuc/add2/c20 ,\lfuc/n23 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u2  (
    .a(cachcnt[2]),
    .b(1'b0),
    .c(\lfuc/add2/c2 ),
    .o({\lfuc/add2/c3 ,\lfuc/n23 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u20  (
    .a(cachcnt[20]),
    .b(1'b0),
    .c(\lfuc/add2/c20 ),
    .o({\lfuc/add2/c21 ,\lfuc/n23 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u21  (
    .a(cachcnt[21]),
    .b(1'b0),
    .c(\lfuc/add2/c21 ),
    .o({\lfuc/add2/c22 ,\lfuc/n23 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u22  (
    .a(cachcnt[22]),
    .b(1'b0),
    .c(\lfuc/add2/c22 ),
    .o({\lfuc/add2/c23 ,\lfuc/n23 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u23  (
    .a(cachcnt[23]),
    .b(1'b0),
    .c(\lfuc/add2/c23 ),
    .o({\lfuc/add2/c24 ,\lfuc/n23 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u24  (
    .a(cachcnt[24]),
    .b(1'b0),
    .c(\lfuc/add2/c24 ),
    .o({\lfuc/add2/c25 ,\lfuc/n23 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u25  (
    .a(cachcnt[25]),
    .b(1'b0),
    .c(\lfuc/add2/c25 ),
    .o({\lfuc/add2/c26 ,\lfuc/n23 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u26  (
    .a(cachcnt[26]),
    .b(1'b0),
    .c(\lfuc/add2/c26 ),
    .o({\lfuc/add2/c27 ,\lfuc/n23 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u27  (
    .a(cachcnt[27]),
    .b(1'b0),
    .c(\lfuc/add2/c27 ),
    .o({\lfuc/add2/c28 ,\lfuc/n23 [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u28  (
    .a(cachcnt[28]),
    .b(1'b0),
    .c(\lfuc/add2/c28 ),
    .o({\lfuc/add2/c29 ,\lfuc/n23 [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u29  (
    .a(cachcnt[29]),
    .b(1'b0),
    .c(\lfuc/add2/c29 ),
    .o({\lfuc/add2/c30 ,\lfuc/n23 [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u3  (
    .a(cachcnt[3]),
    .b(1'b0),
    .c(\lfuc/add2/c3 ),
    .o({\lfuc/add2/c4 ,\lfuc/n23 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u30  (
    .a(cachcnt[30]),
    .b(1'b0),
    .c(\lfuc/add2/c30 ),
    .o({\lfuc/add2/c31 ,\lfuc/n23 [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u31  (
    .a(cachcnt[31]),
    .b(1'b0),
    .c(\lfuc/add2/c31 ),
    .o({open_n8,\lfuc/n23 [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u4  (
    .a(cachcnt[4]),
    .b(1'b0),
    .c(\lfuc/add2/c4 ),
    .o({\lfuc/add2/c5 ,\lfuc/n23 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u5  (
    .a(cachcnt[5]),
    .b(1'b0),
    .c(\lfuc/add2/c5 ),
    .o({\lfuc/add2/c6 ,\lfuc/n23 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u6  (
    .a(cachcnt[6]),
    .b(1'b0),
    .c(\lfuc/add2/c6 ),
    .o({\lfuc/add2/c7 ,\lfuc/n23 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u7  (
    .a(cachcnt[7]),
    .b(1'b0),
    .c(\lfuc/add2/c7 ),
    .o({\lfuc/add2/c8 ,\lfuc/n23 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u8  (
    .a(cachcnt[8]),
    .b(1'b0),
    .c(\lfuc/add2/c8 ),
    .o({\lfuc/add2/c9 ,\lfuc/n23 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add2/u9  (
    .a(cachcnt[9]),
    .b(1'b0),
    .c(\lfuc/add2/c9 ),
    .o({\lfuc/add2/c10 ,\lfuc/n23 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \lfuc/add2/ucin  (
    .a(1'b0),
    .o({\lfuc/add2/c0 ,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u0  (
    .a(cachhit[0]),
    .b(1'b1),
    .c(\lfuc/add3/c0 ),
    .o({\lfuc/add3/c1 ,\lfuc/n29 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u1  (
    .a(cachhit[1]),
    .b(1'b0),
    .c(\lfuc/add3/c1 ),
    .o({\lfuc/add3/c2 ,\lfuc/n29 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u10  (
    .a(cachhit[10]),
    .b(1'b0),
    .c(\lfuc/add3/c10 ),
    .o({\lfuc/add3/c11 ,\lfuc/n29 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u11  (
    .a(cachhit[11]),
    .b(1'b0),
    .c(\lfuc/add3/c11 ),
    .o({\lfuc/add3/c12 ,\lfuc/n29 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u12  (
    .a(cachhit[12]),
    .b(1'b0),
    .c(\lfuc/add3/c12 ),
    .o({\lfuc/add3/c13 ,\lfuc/n29 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u13  (
    .a(cachhit[13]),
    .b(1'b0),
    .c(\lfuc/add3/c13 ),
    .o({\lfuc/add3/c14 ,\lfuc/n29 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u14  (
    .a(cachhit[14]),
    .b(1'b0),
    .c(\lfuc/add3/c14 ),
    .o({\lfuc/add3/c15 ,\lfuc/n29 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u15  (
    .a(cachhit[15]),
    .b(1'b0),
    .c(\lfuc/add3/c15 ),
    .o({\lfuc/add3/c16 ,\lfuc/n29 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u16  (
    .a(cachhit[16]),
    .b(1'b0),
    .c(\lfuc/add3/c16 ),
    .o({\lfuc/add3/c17 ,\lfuc/n29 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u17  (
    .a(cachhit[17]),
    .b(1'b0),
    .c(\lfuc/add3/c17 ),
    .o({\lfuc/add3/c18 ,\lfuc/n29 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u18  (
    .a(cachhit[18]),
    .b(1'b0),
    .c(\lfuc/add3/c18 ),
    .o({\lfuc/add3/c19 ,\lfuc/n29 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u19  (
    .a(cachhit[19]),
    .b(1'b0),
    .c(\lfuc/add3/c19 ),
    .o({\lfuc/add3/c20 ,\lfuc/n29 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u2  (
    .a(cachhit[2]),
    .b(1'b0),
    .c(\lfuc/add3/c2 ),
    .o({\lfuc/add3/c3 ,\lfuc/n29 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u20  (
    .a(cachhit[20]),
    .b(1'b0),
    .c(\lfuc/add3/c20 ),
    .o({\lfuc/add3/c21 ,\lfuc/n29 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u21  (
    .a(cachhit[21]),
    .b(1'b0),
    .c(\lfuc/add3/c21 ),
    .o({\lfuc/add3/c22 ,\lfuc/n29 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u22  (
    .a(cachhit[22]),
    .b(1'b0),
    .c(\lfuc/add3/c22 ),
    .o({\lfuc/add3/c23 ,\lfuc/n29 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u23  (
    .a(cachhit[23]),
    .b(1'b0),
    .c(\lfuc/add3/c23 ),
    .o({\lfuc/add3/c24 ,\lfuc/n29 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u24  (
    .a(cachhit[24]),
    .b(1'b0),
    .c(\lfuc/add3/c24 ),
    .o({\lfuc/add3/c25 ,\lfuc/n29 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u25  (
    .a(cachhit[25]),
    .b(1'b0),
    .c(\lfuc/add3/c25 ),
    .o({\lfuc/add3/c26 ,\lfuc/n29 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u26  (
    .a(cachhit[26]),
    .b(1'b0),
    .c(\lfuc/add3/c26 ),
    .o({\lfuc/add3/c27 ,\lfuc/n29 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u27  (
    .a(cachhit[27]),
    .b(1'b0),
    .c(\lfuc/add3/c27 ),
    .o({\lfuc/add3/c28 ,\lfuc/n29 [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u28  (
    .a(cachhit[28]),
    .b(1'b0),
    .c(\lfuc/add3/c28 ),
    .o({\lfuc/add3/c29 ,\lfuc/n29 [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u29  (
    .a(cachhit[29]),
    .b(1'b0),
    .c(\lfuc/add3/c29 ),
    .o({\lfuc/add3/c30 ,\lfuc/n29 [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u3  (
    .a(cachhit[3]),
    .b(1'b0),
    .c(\lfuc/add3/c3 ),
    .o({\lfuc/add3/c4 ,\lfuc/n29 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u30  (
    .a(cachhit[30]),
    .b(1'b0),
    .c(\lfuc/add3/c30 ),
    .o({\lfuc/add3/c31 ,\lfuc/n29 [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u31  (
    .a(cachhit[31]),
    .b(1'b0),
    .c(\lfuc/add3/c31 ),
    .o({open_n12,\lfuc/n29 [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u4  (
    .a(cachhit[4]),
    .b(1'b0),
    .c(\lfuc/add3/c4 ),
    .o({\lfuc/add3/c5 ,\lfuc/n29 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u5  (
    .a(cachhit[5]),
    .b(1'b0),
    .c(\lfuc/add3/c5 ),
    .o({\lfuc/add3/c6 ,\lfuc/n29 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u6  (
    .a(cachhit[6]),
    .b(1'b0),
    .c(\lfuc/add3/c6 ),
    .o({\lfuc/add3/c7 ,\lfuc/n29 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u7  (
    .a(cachhit[7]),
    .b(1'b0),
    .c(\lfuc/add3/c7 ),
    .o({\lfuc/add3/c8 ,\lfuc/n29 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u8  (
    .a(cachhit[8]),
    .b(1'b0),
    .c(\lfuc/add3/c8 ),
    .o({\lfuc/add3/c9 ,\lfuc/n29 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \lfuc/add3/u9  (
    .a(cachhit[9]),
    .b(1'b0),
    .c(\lfuc/add3/c9 ),
    .o({\lfuc/add3/c10 ,\lfuc/n29 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \lfuc/add3/ucin  (
    .a(1'b0),
    .o({\lfuc/add3/c0 ,open_n15}));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r0_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_0_0 ),
    .do({\lfuc/lfuary/dram_do_i0_003 ,\lfuc/lfuary/dram_do_i0_002 ,\lfuc/lfuary/dram_do_i0_001 ,\lfuc/lfuary/dram_do_i0_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r0_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_0_0 ),
    .do({\lfuc/lfuary/dram_do_i0_007 ,\lfuc/lfuary/dram_do_i0_006 ,\lfuc/lfuary/dram_do_i0_005 ,\lfuc/lfuary/dram_do_i0_004 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r1_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_0_1 ),
    .do({\lfuc/lfuary/dram_do_i1_003 ,\lfuc/lfuary/dram_do_i1_002 ,\lfuc/lfuary/dram_do_i1_001 ,\lfuc/lfuary/dram_do_i1_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r1_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_0_1 ),
    .do({\lfuc/lfuary/dram_do_i1_007 ,\lfuc/lfuary/dram_do_i1_006 ,\lfuc/lfuary/dram_do_i1_005 ,\lfuc/lfuary/dram_do_i1_004 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r2_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_1_0 ),
    .do({\lfuc/lfuary/dram_do_i2_003 ,\lfuc/lfuary/dram_do_i2_002 ,\lfuc/lfuary/dram_do_i2_001 ,\lfuc/lfuary/dram_do_i2_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r2_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_1_0 ),
    .do({\lfuc/lfuary/dram_do_i2_007 ,\lfuc/lfuary/dram_do_i2_006 ,\lfuc/lfuary/dram_do_i2_005 ,\lfuc/lfuary/dram_do_i2_004 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r3_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_1_1 ),
    .do({\lfuc/lfuary/dram_do_i3_003 ,\lfuc/lfuary/dram_do_i3_002 ,\lfuc/lfuary/dram_do_i3_001 ,\lfuc/lfuary/dram_do_i3_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r3_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_0_1_1 ),
    .do({\lfuc/lfuary/dram_do_i3_007 ,\lfuc/lfuary/dram_do_i3_006 ,\lfuc/lfuary/dram_do_i3_005 ,\lfuc/lfuary/dram_do_i3_004 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r4_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_0_0 ),
    .do({\lfuc/lfuary/dram_do_i4_003 ,\lfuc/lfuary/dram_do_i4_002 ,\lfuc/lfuary/dram_do_i4_001 ,\lfuc/lfuary/dram_do_i4_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r4_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_0_0 ),
    .do({\lfuc/lfuary/dram_do_i4_007 ,\lfuc/lfuary/dram_do_i4_006 ,\lfuc/lfuary/dram_do_i4_005 ,\lfuc/lfuary/dram_do_i4_004 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r5_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_0_1 ),
    .do({\lfuc/lfuary/dram_do_i5_003 ,\lfuc/lfuary/dram_do_i5_002 ,\lfuc/lfuary/dram_do_i5_001 ,\lfuc/lfuary/dram_do_i5_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r5_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_0_1 ),
    .do({\lfuc/lfuary/dram_do_i5_007 ,\lfuc/lfuary/dram_do_i5_006 ,\lfuc/lfuary/dram_do_i5_005 ,\lfuc/lfuary/dram_do_i5_004 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r6_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_1_0 ),
    .do({\lfuc/lfuary/dram_do_i6_003 ,\lfuc/lfuary/dram_do_i6_002 ,\lfuc/lfuary/dram_do_i6_001 ,\lfuc/lfuary/dram_do_i6_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r6_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_1_0 ),
    .do({\lfuc/lfuary/dram_do_i6_007 ,\lfuc/lfuary/dram_do_i6_006 ,\lfuc/lfuary/dram_do_i6_005 ,\lfuc/lfuary/dram_do_i6_004 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r7_c0  (
    .di(\lfuc/lfu_la_wdat [3:0]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_1_1 ),
    .do({\lfuc/lfuary/dram_do_i7_003 ,\lfuc/lfuary/dram_do_i7_002 ,\lfuc/lfuary/dram_do_i7_001 ,\lfuc/lfuary/dram_do_i7_000 }));
  EG_LOGIC_DRAM16X4 \lfuc/lfuary/dram_r7_c1  (
    .di(\lfuc/lfu_la_wdat [7:4]),
    .raddr(\lfuc/lfu_la_radr [3:0]),
    .waddr(\lfuc/lfu_la_wadr [3:0]),
    .wclk(clk),
    .we(\lfuc/lfu_la_we_1_1_1 ),
    .do({\lfuc/lfuary/dram_do_i7_007 ,\lfuc/lfuary/dram_do_i7_006 ,\lfuc/lfuary/dram_do_i7_005 ,\lfuc/lfuary/dram_do_i7_004 }));
  reg_sr_as_w1 \lfuc/reg0_b0  (
    .clk(clk),
    .d(\lfuc/n31 [0]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[0]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b1  (
    .clk(clk),
    .d(\lfuc/n31 [1]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[1]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b10  (
    .clk(clk),
    .d(\lfuc/n31 [10]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[10]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b11  (
    .clk(clk),
    .d(\lfuc/n31 [11]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[11]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b12  (
    .clk(clk),
    .d(\lfuc/n31 [12]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[12]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b13  (
    .clk(clk),
    .d(\lfuc/n31 [13]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[13]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b14  (
    .clk(clk),
    .d(\lfuc/n31 [14]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[14]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b15  (
    .clk(clk),
    .d(\lfuc/n31 [15]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[15]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b16  (
    .clk(clk),
    .d(\lfuc/n32 [16]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[16]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b17  (
    .clk(clk),
    .d(\lfuc/n32 [17]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[17]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b18  (
    .clk(clk),
    .d(\lfuc/n32 [18]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[18]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b19  (
    .clk(clk),
    .d(\lfuc/n32 [19]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[19]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b2  (
    .clk(clk),
    .d(\lfuc/n31 [2]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[2]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b20  (
    .clk(clk),
    .d(\lfuc/n32 [20]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[20]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b21  (
    .clk(clk),
    .d(\lfuc/n32 [21]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[21]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b22  (
    .clk(clk),
    .d(\lfuc/n32 [22]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[22]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b23  (
    .clk(clk),
    .d(\lfuc/n32 [23]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[23]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b24  (
    .clk(clk),
    .d(\lfuc/n32 [24]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[24]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b25  (
    .clk(clk),
    .d(\lfuc/n32 [25]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[25]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b26  (
    .clk(clk),
    .d(\lfuc/n32 [26]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[26]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b27  (
    .clk(clk),
    .d(\lfuc/n32 [27]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[27]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b28  (
    .clk(clk),
    .d(\lfuc/n32 [28]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[28]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b29  (
    .clk(clk),
    .d(\lfuc/n32 [29]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[29]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b3  (
    .clk(clk),
    .d(\lfuc/n31 [3]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[3]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b30  (
    .clk(clk),
    .d(\lfuc/n32 [30]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[30]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b31  (
    .clk(clk),
    .d(\lfuc/n32 [31]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[31]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b4  (
    .clk(clk),
    .d(\lfuc/n31 [4]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[4]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b5  (
    .clk(clk),
    .d(\lfuc/n31 [5]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[5]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b6  (
    .clk(clk),
    .d(\lfuc/n31 [6]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[6]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b7  (
    .clk(clk),
    .d(\lfuc/n31 [7]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[7]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b8  (
    .clk(clk),
    .d(\lfuc/n31 [8]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[8]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg0_b9  (
    .clk(clk),
    .d(\lfuc/n31 [9]),
    .en(~wr_cachhith),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachhit[9]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b0  (
    .clk(clk),
    .d(\lfuc/n25 [0]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[0]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b1  (
    .clk(clk),
    .d(\lfuc/n25 [1]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[1]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b10  (
    .clk(clk),
    .d(\lfuc/n25 [10]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[10]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b11  (
    .clk(clk),
    .d(\lfuc/n25 [11]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[11]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b12  (
    .clk(clk),
    .d(\lfuc/n25 [12]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[12]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b13  (
    .clk(clk),
    .d(\lfuc/n25 [13]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[13]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b14  (
    .clk(clk),
    .d(\lfuc/n25 [14]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[14]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b15  (
    .clk(clk),
    .d(\lfuc/n25 [15]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[15]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b16  (
    .clk(clk),
    .d(\lfuc/n26 [16]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[16]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b17  (
    .clk(clk),
    .d(\lfuc/n26 [17]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[17]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b18  (
    .clk(clk),
    .d(\lfuc/n26 [18]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[18]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b19  (
    .clk(clk),
    .d(\lfuc/n26 [19]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[19]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b2  (
    .clk(clk),
    .d(\lfuc/n25 [2]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[2]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b20  (
    .clk(clk),
    .d(\lfuc/n26 [20]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[20]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b21  (
    .clk(clk),
    .d(\lfuc/n26 [21]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[21]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b22  (
    .clk(clk),
    .d(\lfuc/n26 [22]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[22]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b23  (
    .clk(clk),
    .d(\lfuc/n26 [23]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[23]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b24  (
    .clk(clk),
    .d(\lfuc/n26 [24]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[24]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b25  (
    .clk(clk),
    .d(\lfuc/n26 [25]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[25]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b26  (
    .clk(clk),
    .d(\lfuc/n26 [26]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[26]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b27  (
    .clk(clk),
    .d(\lfuc/n26 [27]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[27]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b28  (
    .clk(clk),
    .d(\lfuc/n26 [28]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[28]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b29  (
    .clk(clk),
    .d(\lfuc/n26 [29]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[29]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b3  (
    .clk(clk),
    .d(\lfuc/n25 [3]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[3]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b30  (
    .clk(clk),
    .d(\lfuc/n26 [30]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[30]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b31  (
    .clk(clk),
    .d(\lfuc/n26 [31]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[31]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b4  (
    .clk(clk),
    .d(\lfuc/n25 [4]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[4]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b5  (
    .clk(clk),
    .d(\lfuc/n25 [5]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[5]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b6  (
    .clk(clk),
    .d(\lfuc/n25 [6]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[6]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b7  (
    .clk(clk),
    .d(\lfuc/n25 [7]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[7]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b8  (
    .clk(clk),
    .d(\lfuc/n25 [8]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[8]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \lfuc/reg1_b9  (
    .clk(clk),
    .d(\lfuc/n25 [9]),
    .en(~wr_cachcnth),
    .reset(~rst_n),
    .set(1'b0),
    .q(cachcnt[9]));  // rtl/cache2w4k.v(668)
  reg_sr_as_w1 \mbif/rd_cachdat_reg  (
    .clk(clk),
    .d(\lfuc/n28 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\mbif/rd_cachdat ));  // rtl/cache2w4k.v(269)
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r0_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_0 ),
    .do({\way0/tary/dram_do_i0_003 ,\way0/tary/dram_do_i0_002 ,\way0/tary/dram_do_i0_001 ,\way0/tary/dram_do_i0_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r0_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_0 ),
    .do({\way0/tary/dram_do_i0_007 ,\way0/tary/dram_do_i0_006 ,\way0/tary/dram_do_i0_005 ,\way0/tary/dram_do_i0_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r0_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_0 ),
    .do({\way0/tary/dram_do_i0_011 ,\way0/tary/dram_do_i0_010 ,\way0/tary/dram_do_i0_009 ,\way0/tary/dram_do_i0_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r0_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_0 ),
    .do({open_n16,open_n17,open_n18,\way0/tary/dram_do_i0_012 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r1_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_1 ),
    .do({\way0/tary/dram_do_i1_003 ,\way0/tary/dram_do_i1_002 ,\way0/tary/dram_do_i1_001 ,\way0/tary/dram_do_i1_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r1_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_1 ),
    .do({\way0/tary/dram_do_i1_007 ,\way0/tary/dram_do_i1_006 ,\way0/tary/dram_do_i1_005 ,\way0/tary/dram_do_i1_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r1_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_1 ),
    .do({\way0/tary/dram_do_i1_011 ,\way0/tary/dram_do_i1_010 ,\way0/tary/dram_do_i1_009 ,\way0/tary/dram_do_i1_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r1_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_0_1 ),
    .do({open_n19,open_n20,open_n21,\way0/tary/dram_do_i1_012 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r2_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_0 ),
    .do({\way0/tary/dram_do_i2_003 ,\way0/tary/dram_do_i2_002 ,\way0/tary/dram_do_i2_001 ,\way0/tary/dram_do_i2_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r2_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_0 ),
    .do({\way0/tary/dram_do_i2_007 ,\way0/tary/dram_do_i2_006 ,\way0/tary/dram_do_i2_005 ,\way0/tary/dram_do_i2_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r2_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_0 ),
    .do({\way0/tary/dram_do_i2_011 ,\way0/tary/dram_do_i2_010 ,\way0/tary/dram_do_i2_009 ,\way0/tary/dram_do_i2_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r2_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_0 ),
    .do({open_n22,open_n23,open_n24,\way0/tary/dram_do_i2_012 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r3_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_1 ),
    .do({\way0/tary/dram_do_i3_003 ,\way0/tary/dram_do_i3_002 ,\way0/tary/dram_do_i3_001 ,\way0/tary/dram_do_i3_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r3_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_1 ),
    .do({\way0/tary/dram_do_i3_007 ,\way0/tary/dram_do_i3_006 ,\way0/tary/dram_do_i3_005 ,\way0/tary/dram_do_i3_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r3_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_1 ),
    .do({\way0/tary/dram_do_i3_011 ,\way0/tary/dram_do_i3_010 ,\way0/tary/dram_do_i3_009 ,\way0/tary/dram_do_i3_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r3_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_0_1_1 ),
    .do({open_n25,open_n26,open_n27,\way0/tary/dram_do_i3_012 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r4_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_0 ),
    .do({\way0/tary/dram_do_i4_003 ,\way0/tary/dram_do_i4_002 ,\way0/tary/dram_do_i4_001 ,\way0/tary/dram_do_i4_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r4_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_0 ),
    .do({\way0/tary/dram_do_i4_007 ,\way0/tary/dram_do_i4_006 ,\way0/tary/dram_do_i4_005 ,\way0/tary/dram_do_i4_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r4_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_0 ),
    .do({\way0/tary/dram_do_i4_011 ,\way0/tary/dram_do_i4_010 ,\way0/tary/dram_do_i4_009 ,\way0/tary/dram_do_i4_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r4_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_0 ),
    .do({open_n28,open_n29,open_n30,\way0/tary/dram_do_i4_012 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r5_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_1 ),
    .do({\way0/tary/dram_do_i5_003 ,\way0/tary/dram_do_i5_002 ,\way0/tary/dram_do_i5_001 ,\way0/tary/dram_do_i5_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r5_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_1 ),
    .do({\way0/tary/dram_do_i5_007 ,\way0/tary/dram_do_i5_006 ,\way0/tary/dram_do_i5_005 ,\way0/tary/dram_do_i5_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r5_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_1 ),
    .do({\way0/tary/dram_do_i5_011 ,\way0/tary/dram_do_i5_010 ,\way0/tary/dram_do_i5_009 ,\way0/tary/dram_do_i5_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r5_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_0_1 ),
    .do({open_n31,open_n32,open_n33,\way0/tary/dram_do_i5_012 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r6_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_0 ),
    .do({\way0/tary/dram_do_i6_003 ,\way0/tary/dram_do_i6_002 ,\way0/tary/dram_do_i6_001 ,\way0/tary/dram_do_i6_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r6_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_0 ),
    .do({\way0/tary/dram_do_i6_007 ,\way0/tary/dram_do_i6_006 ,\way0/tary/dram_do_i6_005 ,\way0/tary/dram_do_i6_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r6_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_0 ),
    .do({\way0/tary/dram_do_i6_011 ,\way0/tary/dram_do_i6_010 ,\way0/tary/dram_do_i6_009 ,\way0/tary/dram_do_i6_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r6_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_0 ),
    .do({open_n34,open_n35,open_n36,\way0/tary/dram_do_i6_012 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r7_c0  (
    .di(\way0/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_1 ),
    .do({\way0/tary/dram_do_i7_003 ,\way0/tary/dram_do_i7_002 ,\way0/tary/dram_do_i7_001 ,\way0/tary/dram_do_i7_000 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r7_c1  (
    .di(\way0/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_1 ),
    .do({\way0/tary/dram_do_i7_007 ,\way0/tary/dram_do_i7_006 ,\way0/tary/dram_do_i7_005 ,\way0/tary/dram_do_i7_004 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r7_c2  (
    .di(\way0/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_1 ),
    .do({\way0/tary/dram_do_i7_011 ,\way0/tary/dram_do_i7_010 ,\way0/tary/dram_do_i7_009 ,\way0/tary/dram_do_i7_008 }));
  EG_LOGIC_DRAM16X4 \way0/tary/dram_r7_c3  (
    .di({3'b000,\way0/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way0/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way0/way_ta_we_1_1_1 ),
    .do({open_n37,open_n38,open_n39,\way0/tary/dram_do_i7_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r0_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_0 ),
    .do({\way1/tary/dram_do_i0_003 ,\way1/tary/dram_do_i0_002 ,\way1/tary/dram_do_i0_001 ,\way1/tary/dram_do_i0_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r0_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_0 ),
    .do({\way1/tary/dram_do_i0_007 ,\way1/tary/dram_do_i0_006 ,\way1/tary/dram_do_i0_005 ,\way1/tary/dram_do_i0_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r0_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_0 ),
    .do({\way1/tary/dram_do_i0_011 ,\way1/tary/dram_do_i0_010 ,\way1/tary/dram_do_i0_009 ,\way1/tary/dram_do_i0_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r0_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_0 ),
    .do({open_n40,open_n41,open_n42,\way1/tary/dram_do_i0_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r1_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_1 ),
    .do({\way1/tary/dram_do_i1_003 ,\way1/tary/dram_do_i1_002 ,\way1/tary/dram_do_i1_001 ,\way1/tary/dram_do_i1_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r1_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_1 ),
    .do({\way1/tary/dram_do_i1_007 ,\way1/tary/dram_do_i1_006 ,\way1/tary/dram_do_i1_005 ,\way1/tary/dram_do_i1_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r1_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_1 ),
    .do({\way1/tary/dram_do_i1_011 ,\way1/tary/dram_do_i1_010 ,\way1/tary/dram_do_i1_009 ,\way1/tary/dram_do_i1_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r1_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_0_1 ),
    .do({open_n43,open_n44,open_n45,\way1/tary/dram_do_i1_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r2_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_0 ),
    .do({\way1/tary/dram_do_i2_003 ,\way1/tary/dram_do_i2_002 ,\way1/tary/dram_do_i2_001 ,\way1/tary/dram_do_i2_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r2_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_0 ),
    .do({\way1/tary/dram_do_i2_007 ,\way1/tary/dram_do_i2_006 ,\way1/tary/dram_do_i2_005 ,\way1/tary/dram_do_i2_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r2_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_0 ),
    .do({\way1/tary/dram_do_i2_011 ,\way1/tary/dram_do_i2_010 ,\way1/tary/dram_do_i2_009 ,\way1/tary/dram_do_i2_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r2_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_0 ),
    .do({open_n46,open_n47,open_n48,\way1/tary/dram_do_i2_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r3_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_1 ),
    .do({\way1/tary/dram_do_i3_003 ,\way1/tary/dram_do_i3_002 ,\way1/tary/dram_do_i3_001 ,\way1/tary/dram_do_i3_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r3_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_1 ),
    .do({\way1/tary/dram_do_i3_007 ,\way1/tary/dram_do_i3_006 ,\way1/tary/dram_do_i3_005 ,\way1/tary/dram_do_i3_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r3_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_1 ),
    .do({\way1/tary/dram_do_i3_011 ,\way1/tary/dram_do_i3_010 ,\way1/tary/dram_do_i3_009 ,\way1/tary/dram_do_i3_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r3_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_0_1_1 ),
    .do({open_n49,open_n50,open_n51,\way1/tary/dram_do_i3_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r4_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_0 ),
    .do({\way1/tary/dram_do_i4_003 ,\way1/tary/dram_do_i4_002 ,\way1/tary/dram_do_i4_001 ,\way1/tary/dram_do_i4_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r4_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_0 ),
    .do({\way1/tary/dram_do_i4_007 ,\way1/tary/dram_do_i4_006 ,\way1/tary/dram_do_i4_005 ,\way1/tary/dram_do_i4_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r4_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_0 ),
    .do({\way1/tary/dram_do_i4_011 ,\way1/tary/dram_do_i4_010 ,\way1/tary/dram_do_i4_009 ,\way1/tary/dram_do_i4_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r4_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_0 ),
    .do({open_n52,open_n53,open_n54,\way1/tary/dram_do_i4_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r5_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_1 ),
    .do({\way1/tary/dram_do_i5_003 ,\way1/tary/dram_do_i5_002 ,\way1/tary/dram_do_i5_001 ,\way1/tary/dram_do_i5_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r5_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_1 ),
    .do({\way1/tary/dram_do_i5_007 ,\way1/tary/dram_do_i5_006 ,\way1/tary/dram_do_i5_005 ,\way1/tary/dram_do_i5_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r5_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_1 ),
    .do({\way1/tary/dram_do_i5_011 ,\way1/tary/dram_do_i5_010 ,\way1/tary/dram_do_i5_009 ,\way1/tary/dram_do_i5_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r5_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_0_1 ),
    .do({open_n55,open_n56,open_n57,\way1/tary/dram_do_i5_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r6_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_0 ),
    .do({\way1/tary/dram_do_i6_003 ,\way1/tary/dram_do_i6_002 ,\way1/tary/dram_do_i6_001 ,\way1/tary/dram_do_i6_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r6_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_0 ),
    .do({\way1/tary/dram_do_i6_007 ,\way1/tary/dram_do_i6_006 ,\way1/tary/dram_do_i6_005 ,\way1/tary/dram_do_i6_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r6_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_0 ),
    .do({\way1/tary/dram_do_i6_011 ,\way1/tary/dram_do_i6_010 ,\way1/tary/dram_do_i6_009 ,\way1/tary/dram_do_i6_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r6_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_0 ),
    .do({open_n58,open_n59,open_n60,\way1/tary/dram_do_i6_012 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r7_c0  (
    .di(\way1/way_ta_wdat [3:0]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_1 ),
    .do({\way1/tary/dram_do_i7_003 ,\way1/tary/dram_do_i7_002 ,\way1/tary/dram_do_i7_001 ,\way1/tary/dram_do_i7_000 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r7_c1  (
    .di(\way1/way_ta_wdat [7:4]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_1 ),
    .do({\way1/tary/dram_do_i7_007 ,\way1/tary/dram_do_i7_006 ,\way1/tary/dram_do_i7_005 ,\way1/tary/dram_do_i7_004 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r7_c2  (
    .di(\way1/way_ta_wdat [11:8]),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_1 ),
    .do({\way1/tary/dram_do_i7_011 ,\way1/tary/dram_do_i7_010 ,\way1/tary/dram_do_i7_009 ,\way1/tary/dram_do_i7_008 }));
  EG_LOGIC_DRAM16X4 \way1/tary/dram_r7_c3  (
    .di({3'b000,\way1/way_ta_wdat [12]}),
    .raddr(\way0/way_ta_radr [3:0]),
    .waddr(\way1/way_ta_wadr [3:0]),
    .wclk(clk),
    .we(\way1/way_ta_we_1_1_1 ),
    .do({open_n61,open_n62,open_n63,\way1/tary/dram_do_i7_012 }));

endmodule 

