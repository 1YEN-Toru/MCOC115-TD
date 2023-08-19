
`timescale 1ns / 1ps
module sdramc8m  // rtl/sdramc8m.v(1)
  (
  badr,
  bcmd,
  bcs_sdram_n,
  bcs_sdrc_n,
  bdatw,
  brdy,
  clk,
  clksdc,
  pll_extlock,
  rst_n,
  sdc_dqi,
  bdatr,
  sdc_addr,
  sdc_ba,
  sdc_brdy,
  sdc_bst_adr,
  sdc_bst_dat,
  sdc_bst_enb,
  sdc_cas_n,
  sdc_cs_n,
  sdc_dqie,
  sdc_dqm,
  sdc_dqo,
  sdc_dqoe,
  sdc_ras_n,
  sdc_we_n
  );
//
//	Synchronous dynamic RAM controller
//		(c) 2022	1YEN Toru
//
//
//	2022/03/12	ver.1.02
//		corresponding to cache controller
//		4 cycle burst read
//
//	2022/02/19	ver.1.00
//		targeted for EM638325 integrated in EG4S20BG256
//		EM638325: 4 bank*2048 row*256 column*32 bit=8M byte
//		2 cycle single write
//		3 cycle single read
//

  input [22:0] badr;  // rtl/sdramc8m.v(41)
  input [2:0] bcmd;  // rtl/sdramc8m.v(39)
  input bcs_sdram_n;  // rtl/sdramc8m.v(37)
  input bcs_sdrc_n;  // rtl/sdramc8m.v(38)
  input [15:0] bdatw;  // rtl/sdramc8m.v(40)
  input brdy;  // rtl/sdramc8m.v(36)
  input clk;  // rtl/sdramc8m.v(32)
  input clksdc;  // rtl/sdramc8m.v(33)
  input pll_extlock;  // rtl/sdramc8m.v(35)
  input rst_n;  // rtl/sdramc8m.v(34)
  input [31:0] sdc_dqi;  // rtl/sdramc8m.v(49)
  output [15:0] bdatr;  // rtl/sdramc8m.v(43)
  output [10:0] sdc_addr;  // rtl/sdramc8m.v(58)
  output [1:0] sdc_ba;  // rtl/sdramc8m.v(56)
  output sdc_brdy;  // rtl/sdramc8m.v(42)
  output [1:0] sdc_bst_adr;  // rtl/sdramc8m.v(46)
  output [31:0] sdc_bst_dat;  // rtl/sdramc8m.v(47)
  output sdc_bst_enb;  // rtl/sdramc8m.v(45)
  output sdc_cas_n;  // rtl/sdramc8m.v(54)
  output sdc_cs_n;  // rtl/sdramc8m.v(52)
  output sdc_dqie;  // rtl/sdramc8m.v(50)
  output [3:0] sdc_dqm;  // rtl/sdramc8m.v(57)
  output [31:0] sdc_dqo;  // rtl/sdramc8m.v(59)
  output sdc_dqoe;  // rtl/sdramc8m.v(51)
  output sdc_ras_n;  // rtl/sdramc8m.v(53)
  output sdc_we_n;  // rtl/sdramc8m.v(55)

  wire [22:0] badr_br;  // rtl/sdramc8m.v(89)
  wire [2:0] bcmd_br;  // rtl/sdramc8m.v(86)
  wire [15:0] bdatr_br;  // rtl/sdramc8m.v(88)
  wire [15:0] bdatw_br;  // rtl/sdramc8m.v(87)
  wire [2:0] \mbif/n17 ;
  wire [22:0] \mbif/n18 ;
  wire [15:0] \mbif/n19 ;
  wire [11:0] \rfsh/n4 ;
  wire [11:0] \rfsh/rfc_rfsh_cnt ;  // rtl/sdramc8m.v(430)
  wire  \sctl/sel2/B2 ;
  wire [5:0] \sctl/stat ;  // rtl/sdc_fsm.v(111)
  wire [1:0] \sdif/brcnt ;  // rtl/sdramc8m.v(694)
  wire [3:0] \sdif/n2 ;
  wire [3:0] \sdif/n32 ;
  wire [10:0] \sdif/n44 ;
  wire [10:0] \sdif/n46 ;
  wire [15:0] \sdif/n5 ;
  wire [1:0] \sdif/n52 ;
  wire [1:0] \sdif/n56 ;
  wire [15:0] \ssys/n10 ;
  wire [1:0] \ssys/n8 ;
  wire [1:0] \ssys/phcnt ;  // rtl/sdramc8m.v(240)
  wire [15:0] \ssys/scnt ;  // rtl/sdramc8m.v(258)
  wire _al_u157_o;
  wire _al_u158_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u163_o;
  wire _al_u164_o;
  wire _al_u166_o;
  wire _al_u167_o;
  wire _al_u169_o;
  wire _al_u170_o;
  wire _al_u171_o;
  wire _al_u172_o;
  wire _al_u173_o;
  wire _al_u174_o;
  wire _al_u175_o;
  wire _al_u176_o;
  wire _al_u177_o;
  wire _al_u181_o;
  wire _al_u182_o;
  wire _al_u186_o;
  wire _al_u190_o;
  wire _al_u191_o;
  wire _al_u193_o;
  wire _al_u194_o;
  wire _al_u195_o;
  wire _al_u196_o;
  wire _al_u197_o;
  wire _al_u199_o;
  wire _al_u200_o;
  wire _al_u203_o;
  wire _al_u208_o;
  wire _al_u209_o;
  wire _al_u210_o;
  wire _al_u211_o;
  wire _al_u212_o;
  wire _al_u213_o;
  wire _al_u215_o;
  wire _al_u216_o;
  wire _al_u218_o;
  wire _al_u219_o;
  wire _al_u221_o;
  wire _al_u223_o;
  wire _al_u224_o;
  wire _al_u225_o;
  wire _al_u227_o;
  wire _al_u228_o;
  wire _al_u229_o;
  wire _al_u230_o;
  wire _al_u231_o;
  wire _al_u232_o;
  wire _al_u235_o;
  wire _al_u236_o;
  wire _al_u237_o;
  wire _al_u238_o;
  wire _al_u241_o;
  wire _al_u242_o;
  wire _al_u244_o;
  wire _al_u245_o;
  wire _al_u246_o;
  wire _al_u247_o;
  wire _al_u249_o;
  wire _al_u250_o;
  wire _al_u251_o;
  wire _al_u252_o;
  wire _al_u253_o;
  wire _al_u254_o;
  wire _al_u255_o;
  wire _al_u256_o;
  wire _al_u257_o;
  wire _al_u259_o;
  wire _al_u260_o;
  wire _al_u261_o;
  wire _al_u270_o;
  wire _al_u277_o;
  wire _al_u279_o;
  wire \mbif/_al_n0_en ;
  wire \mbif/n3 ;
  wire \mbif/n30 ;
  wire \mbif/n8 ;
  wire \mbif/rd_sdrmctl ;  // rtl/sdramc8m.v(329)
  wire \mbif/sctl_ready ;  // rtl/sdramc8m.v(349)
  wire \mbif/sdc_brdy_r ;  // rtl/sdramc8m.v(394)
  wire rfc_rfsh_req;  // rtl/sdramc8m.v(95)
  wire \rfsh/add0/c0 ;
  wire \rfsh/add0/c1 ;
  wire \rfsh/add0/c10 ;
  wire \rfsh/add0/c11 ;
  wire \rfsh/add0/c2 ;
  wire \rfsh/add0/c3 ;
  wire \rfsh/add0/c4 ;
  wire \rfsh/add0/c5 ;
  wire \rfsh/add0/c6 ;
  wire \rfsh/add0/c7 ;
  wire \rfsh/add0/c8 ;
  wire \rfsh/add0/c9 ;
  wire \rfsh/n3 ;
  wire \rfsh/rfc_rfsh_ovf ;  // rtl/sdramc8m.v(431)
  wire rstsdc_n;  // rtl/sdramc8m.v(94)
  wire \sctl/n106_lutinv ;
  wire \sctl/n317_neg_lutinv ;
  wire \sctl/n471_neg ;
  wire \sctl/n72_lutinv ;
  wire \sctl/n93_lutinv ;
  wire \sctl/sel3_b0_sel_o_neg ;
  wire \sctl/sel3_b1_sel_o_neg ;
  wire \sctl/sel3_b2_sel_o_neg ;
  wire \sctl/sel3_b3_sel_o ;  // rtl/sdc_fsm.v(189)
  wire \sctl/sel3_b4_sel_o_neg ;
  wire \sctl/sel3_b5_sel_o ;  // rtl/sdc_fsm.v(189)
  wire sctl_bw_enb;  // rtl/sdramc8m.v(106)
  wire sctl_cs_n_t;  // rtl/sdramc8m.v(107)
  wire sctl_ready_t;  // rtl/sdramc8m.v(104)
  wire sctl_ready_t_d;
  wire sctl_test_enb;  // rtl/sdramc8m.v(150)
  wire \sdif/eq2/or_xor_i0[3]_i1[3]_o_o_lutinv ;
  wire \sdif/eq8/or_xor_i0[4]_i1[4]_o_o_lutinv ;
  wire \sdif/mux12_b8_sel_is_0_o ;
  wire \sdif/mux13_b0_sel_is_1_o ;
  wire \sdif/mux13_b8_sel_is_3_o ;
  wire \sdif/n19_d ;
  wire \sdif/n22 ;
  wire \sdif/n24_lutinv ;
  wire \sdif/n4 ;
  wire \sdif/n46[1]_d ;
  wire \sdif/n46[4]_d ;
  wire \sdif/n46[5]_d ;
  wire \sdif/n46[9]_d ;
  wire \sdif/n50 ;
  wire \sdif/n55 ;
  wire \sdif/n58_lutinv ;
  wire \sdif/sctl_data_lat ;  // rtl/sdramc8m.v(567)
  wire \sdif/sdc_cs_n_r ;  // rtl/sdramc8m.v(594)
  wire \sdif/sdc_dqie_r ;  // rtl/sdramc8m.v(598)
  wire \sdif/sdc_dqoe_r ;  // rtl/sdramc8m.v(599)
  wire \sdif/sdif_bst_lat ;  // rtl/sdramc8m.v(571)
  wire \sdif/u15_sel_is_2_o ;
  wire \sdif/u16_sel_is_2_o ;
  wire \sdif/u17_sel_is_2_o ;
  wire \ssys/add1/c0 ;
  wire \ssys/add1/c1 ;
  wire \ssys/add1/c10 ;
  wire \ssys/add1/c11 ;
  wire \ssys/add1/c12 ;
  wire \ssys/add1/c13 ;
  wire \ssys/add1/c14 ;
  wire \ssys/add1/c15 ;
  wire \ssys/add1/c2 ;
  wire \ssys/add1/c3 ;
  wire \ssys/add1/c4 ;
  wire \ssys/add1/c5 ;
  wire \ssys/add1/c6 ;
  wire \ssys/add1/c7 ;
  wire \ssys/add1/c8 ;
  wire \ssys/add1/c9 ;
  wire \ssys/lat_clk ;  // rtl/sdramc8m.v(239)
  wire \ssys/n0 ;
  wire \ssys/n2 ;
  wire \ssys/n7 ;
  wire \ssys/rst_n_f ;  // rtl/sdramc8m.v(216)
  wire \ssys/tgl_clk ;  // rtl/sdramc8m.v(231)
  wire ssys_osync;  // rtl/sdramc8m.v(98)
  wire ssys_stbl;  // rtl/sdramc8m.v(96)
  wire ssys_stbl_d;

  assign sdc_bst_enb = sctl_bw_enb;
  assign sdc_dqo[15] = sdc_dqo[31];
  assign sdc_dqo[14] = sdc_dqo[30];
  assign sdc_dqo[13] = sdc_dqo[29];
  assign sdc_dqo[12] = sdc_dqo[28];
  assign sdc_dqo[11] = sdc_dqo[27];
  assign sdc_dqo[10] = sdc_dqo[26];
  assign sdc_dqo[9] = sdc_dqo[25];
  assign sdc_dqo[8] = sdc_dqo[24];
  assign sdc_dqo[7] = sdc_dqo[23];
  assign sdc_dqo[6] = sdc_dqo[22];
  assign sdc_dqo[5] = sdc_dqo[21];
  assign sdc_dqo[4] = sdc_dqo[20];
  assign sdc_dqo[3] = sdc_dqo[19];
  assign sdc_dqo[2] = sdc_dqo[18];
  assign sdc_dqo[1] = sdc_dqo[17];
  assign sdc_dqo[0] = sdc_dqo[16];
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u100 (
    .a(bcmd_br[0]),
    .b(bdatr_br[5]),
    .o(bdatr[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u101 (
    .a(bcmd_br[0]),
    .b(bdatr_br[8]),
    .o(bdatr[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u102 (
    .a(bcmd_br[0]),
    .b(bdatr_br[9]),
    .o(bdatr[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u103 (
    .a(\sdif/sdc_dqoe_r ),
    .b(rstsdc_n),
    .o(sdc_dqoe));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u104 (
    .a(\sdif/sdc_dqie_r ),
    .b(rstsdc_n),
    .o(sdc_dqie));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u105 (
    .a(\mbif/rd_sdrmctl ),
    .b(bcmd_br[0]),
    .c(bdatr_br[7]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'hec20))
    _al_u106 (
    .a(\mbif/rd_sdrmctl ),
    .b(bcmd_br[0]),
    .c(sctl_test_enb),
    .d(bdatr_br[15]),
    .o(bdatr[15]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u107 (
    .a(\sdif/brcnt [0]),
    .b(\sdif/brcnt [1]),
    .o(\sdif/n52 [1]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u108 (
    .a(sdc_bst_adr[0]),
    .b(sdc_bst_adr[1]),
    .o(\sdif/n56 [1]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u109 (
    .a(\ssys/phcnt [0]),
    .b(\ssys/phcnt [1]),
    .o(\ssys/n8 [1]));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u110 (
    .a(\sdif/sdc_cs_n_r ),
    .b(rstsdc_n),
    .o(sdc_cs_n));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u111 (
    .a(\mbif/sdc_brdy_r ),
    .b(rstsdc_n),
    .o(sdc_brdy));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u112 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[9]),
    .o(\mbif/n19 [9]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u113 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[8]),
    .o(\mbif/n19 [8]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u114 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[7]),
    .o(\mbif/n19 [7]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u115 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[6]),
    .o(\mbif/n19 [6]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u116 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[5]),
    .o(\mbif/n19 [5]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u117 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[4]),
    .o(\mbif/n19 [4]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u118 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[3]),
    .o(\mbif/n19 [3]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u119 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[2]),
    .o(\mbif/n19 [2]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u120 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[15]),
    .o(\mbif/n19 [15]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u121 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[14]),
    .o(\mbif/n19 [14]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u122 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[13]),
    .o(\mbif/n19 [13]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u123 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[12]),
    .o(\mbif/n19 [12]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u124 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[11]),
    .o(\mbif/n19 [11]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u125 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[10]),
    .o(\mbif/n19 [10]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u126 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[1]),
    .o(\mbif/n19 [1]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u127 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_sdram_n),
    .d(bdatw[0]),
    .o(\mbif/n19 [0]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u128 (
    .a(badr[9]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [9]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u129 (
    .a(badr[8]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [8]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u130 (
    .a(badr[7]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [7]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u131 (
    .a(badr[6]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [6]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u132 (
    .a(badr[5]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u133 (
    .a(badr[4]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u134 (
    .a(badr[3]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u135 (
    .a(badr[22]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [22]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u136 (
    .a(badr[21]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [21]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u137 (
    .a(badr[20]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [20]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u138 (
    .a(badr[2]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u139 (
    .a(badr[19]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [19]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u140 (
    .a(badr[18]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [18]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u141 (
    .a(badr[17]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [17]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u142 (
    .a(badr[16]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [16]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u143 (
    .a(badr[15]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [15]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u144 (
    .a(badr[14]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [14]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u145 (
    .a(badr[13]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [13]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u146 (
    .a(badr[12]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [12]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u147 (
    .a(badr[11]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [11]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u148 (
    .a(badr[10]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [10]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u149 (
    .a(badr[1]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u150 (
    .a(badr[0]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n18 [0]));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u151 (
    .a(bcmd[2]),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(bcs_sdram_n),
    .o(\mbif/n17 [2]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u152 (
    .a(bcmd[1]),
    .b(bcs_sdram_n),
    .o(\mbif/n17 [1]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u153 (
    .a(bcmd[0]),
    .b(bcs_sdram_n),
    .o(\mbif/n17 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C*~A))"),
    .INIT(8'h73))
    _al_u154 (
    .a(\ssys/lat_clk ),
    .b(rstsdc_n),
    .c(\ssys/tgl_clk ),
    .o(\ssys/n7 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u155 (
    .a(\ssys/phcnt [0]),
    .b(\ssys/phcnt [1]),
    .o(ssys_osync));
  AL_MAP_LUT5 #(
    .EQN("((E*C*A)*~(D)*~(B)+(E*C*A)*D*~(B)+~((E*C*A))*D*B+(E*C*A)*D*B)"),
    .INIT(32'hec20cc00))
    _al_u156 (
    .a(\mbif/rd_sdrmctl ),
    .b(bcmd_br[0]),
    .c(\mbif/sctl_ready ),
    .d(bdatr_br[6]),
    .e(rstsdc_n),
    .o(bdatr[6]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u157 (
    .a(badr[1]),
    .b(badr[0]),
    .c(bcs_sdrc_n),
    .o(_al_u157_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u158 (
    .a(badr[3]),
    .b(badr[2]),
    .o(_al_u158_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u159 (
    .a(_al_u157_o),
    .b(_al_u158_o),
    .c(bcmd[1]),
    .d(brdy),
    .o(\mbif/n8 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u160 (
    .a(_al_u158_o),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmd[0]),
    .e(bcs_sdrc_n),
    .o(\mbif/n3 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u161 (
    .a(\sctl/stat [4]),
    .b(\sctl/stat [5]),
    .o(_al_u161_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u162 (
    .a(\sctl/stat [2]),
    .b(\sctl/stat [3]),
    .o(_al_u162_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u163 (
    .a(_al_u161_o),
    .b(_al_u162_o),
    .o(_al_u163_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u164 (
    .a(\sctl/stat [0]),
    .b(\sctl/stat [1]),
    .o(_al_u164_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u165 (
    .a(_al_u163_o),
    .b(_al_u164_o),
    .o(\sctl/n471_neg ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u166 (
    .a(\rfsh/rfc_rfsh_cnt [0]),
    .b(\rfsh/rfc_rfsh_cnt [1]),
    .c(\rfsh/rfc_rfsh_cnt [10]),
    .d(\rfsh/rfc_rfsh_cnt [11]),
    .o(_al_u166_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u167 (
    .a(_al_u166_o),
    .b(\rfsh/rfc_rfsh_cnt [2]),
    .c(\rfsh/rfc_rfsh_cnt [3]),
    .d(\rfsh/rfc_rfsh_cnt [4]),
    .e(\rfsh/rfc_rfsh_cnt [5]),
    .o(_al_u167_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u168 (
    .a(_al_u167_o),
    .b(\rfsh/rfc_rfsh_cnt [6]),
    .c(\rfsh/rfc_rfsh_cnt [7]),
    .d(\rfsh/rfc_rfsh_cnt [8]),
    .e(\rfsh/rfc_rfsh_cnt [9]),
    .o(\rfsh/rfc_rfsh_ovf ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u169 (
    .a(\sctl/stat [3]),
    .b(\sctl/stat [4]),
    .c(\sctl/stat [5]),
    .o(_al_u169_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*(B*~(A)*~(D)+B*A*~(D)+~(B)*A*D+B*A*D))"),
    .INIT(32'h0a0c0000))
    _al_u170 (
    .a(_al_u169_o),
    .b(_al_u161_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .e(\sctl/stat [2]),
    .o(_al_u170_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u171 (
    .a(\sctl/stat [4]),
    .b(\sctl/stat [5]),
    .o(_al_u171_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u172 (
    .a(_al_u171_o),
    .b(\sctl/stat [3]),
    .o(_al_u172_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u173 (
    .a(\sctl/stat [0]),
    .b(\sctl/stat [1]),
    .c(\sctl/stat [2]),
    .o(_al_u173_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u174 (
    .a(_al_u170_o),
    .b(_al_u172_o),
    .c(_al_u173_o),
    .o(_al_u174_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u175 (
    .a(\sctl/stat [0]),
    .b(\sctl/stat [1]),
    .o(_al_u175_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u176 (
    .a(_al_u172_o),
    .b(_al_u175_o),
    .c(\sctl/stat [2]),
    .o(_al_u176_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u177 (
    .a(\sctl/stat [3]),
    .b(\sctl/stat [4]),
    .c(\sctl/stat [5]),
    .o(_al_u177_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u178 (
    .a(_al_u173_o),
    .b(_al_u177_o),
    .o(\sdif/n22 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*~B*A))"),
    .INIT(16'hfd00))
    _al_u179 (
    .a(_al_u174_o),
    .b(_al_u176_o),
    .c(\sdif/n22 ),
    .d(rstsdc_n),
    .o(\sdif/u17_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("(D*~B*A*~(E*C))"),
    .INIT(32'h02002200))
    _al_u180 (
    .a(_al_u171_o),
    .b(\sctl/stat [0]),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .e(\sctl/stat [3]),
    .o(\sctl/n106_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(C*~(~D*~B)))"),
    .INIT(16'h0515))
    _al_u181 (
    .a(\sctl/n106_lutinv ),
    .b(_al_u169_o),
    .c(_al_u173_o),
    .d(_al_u161_o),
    .o(_al_u181_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u182 (
    .a(\sctl/stat [0]),
    .b(\sctl/stat [1]),
    .c(\sctl/stat [2]),
    .o(_al_u182_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u183 (
    .a(_al_u182_o),
    .b(rfc_rfsh_req),
    .c(\sctl/stat [3]),
    .d(\sctl/stat [4]),
    .e(\sctl/stat [5]),
    .o(\sctl/n72_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*A))"),
    .INIT(8'hd0))
    _al_u184 (
    .a(_al_u181_o),
    .b(\sctl/n72_lutinv ),
    .c(rstsdc_n),
    .o(\sdif/u16_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*~A)"),
    .INIT(8'hbf))
    _al_u185 (
    .a(\rfsh/rfc_rfsh_ovf ),
    .b(sctl_ready_t),
    .c(rstsdc_n),
    .o(\rfsh/n3 ));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D*C*B))"),
    .INIT(32'h15555555))
    _al_u186 (
    .a(\sctl/n72_lutinv ),
    .b(_al_u171_o),
    .c(_al_u175_o),
    .d(\sctl/stat [2]),
    .e(\sctl/stat [3]),
    .o(_al_u186_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~A*~(E*D*C))"),
    .INIT(32'hfbbbbbbb))
    _al_u187 (
    .a(\rfsh/rfc_rfsh_ovf ),
    .b(_al_u186_o),
    .c(_al_u172_o),
    .d(_al_u164_o),
    .e(\sctl/stat [2]),
    .o(\mbif/_al_n0_en ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u188 (
    .a(ssys_osync),
    .b(_al_u164_o),
    .c(_al_u162_o),
    .d(\sctl/stat [4]),
    .e(\sctl/stat [5]),
    .o(\sctl/n317_neg_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u189 (
    .a(\sctl/n317_neg_lutinv ),
    .b(sctl_ready_t),
    .o(sctl_ready_t_d));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u190 (
    .a(_al_u169_o),
    .b(\sctl/stat [2]),
    .o(_al_u190_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u191 (
    .a(\sctl/stat [2]),
    .b(\sctl/stat [3]),
    .c(\sctl/stat [4]),
    .d(\sctl/stat [5]),
    .o(_al_u191_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'haa0ccccc))
    _al_u192 (
    .a(_al_u190_o),
    .b(_al_u191_o),
    .c(ssys_osync),
    .d(\sctl/stat [0]),
    .e(\sctl/stat [1]),
    .o(sctl_bw_enb));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u193 (
    .a(\sctl/stat [0]),
    .b(\sctl/stat [1]),
    .c(\sctl/stat [2]),
    .o(_al_u193_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u194 (
    .a(\ssys/phcnt [0]),
    .b(\ssys/phcnt [1]),
    .o(_al_u194_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D*C))"),
    .INIT(16'h0888))
    _al_u195 (
    .a(_al_u172_o),
    .b(_al_u193_o),
    .c(_al_u194_o),
    .d(ssys_stbl),
    .o(_al_u195_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~(B)*C*~(D)+B*C*~(D)+~(B)*~(C)*D))"),
    .INIT(16'h02a0))
    _al_u196 (
    .a(_al_u191_o),
    .b(ssys_osync),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .o(_al_u196_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(D*C))"),
    .INIT(16'h0111))
    _al_u197 (
    .a(_al_u195_o),
    .b(_al_u196_o),
    .c(_al_u172_o),
    .d(\sctl/stat [0]),
    .o(_al_u197_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u198 (
    .a(_al_u163_o),
    .b(ssys_osync),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .o(\sctl/n93_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~A*~(~D*B)))"),
    .INIT(16'ha0e0))
    _al_u199 (
    .a(_al_u169_o),
    .b(_al_u177_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .o(_al_u199_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D*C))"),
    .INIT(16'h0222))
    _al_u200 (
    .a(\sctl/stat [0]),
    .b(\sctl/stat [2]),
    .c(\sctl/stat [3]),
    .d(\sctl/stat [5]),
    .o(_al_u200_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u201 (
    .a(_al_u197_o),
    .b(\sctl/n471_neg ),
    .c(\sctl/n93_lutinv ),
    .d(_al_u199_o),
    .e(_al_u200_o),
    .o(\sctl/sel3_b0_sel_o_neg ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u202 (
    .a(badr_br[2]),
    .b(badr_br[3]),
    .c(\sdif/brcnt [0]),
    .d(\sdif/brcnt [1]),
    .o(\sdif/n58_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u203 (
    .a(\sctl/stat [1]),
    .b(\sctl/stat [2]),
    .o(_al_u203_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(D*C)*~(~E*A)))"),
    .INIT(32'hc000c888))
    _al_u204 (
    .a(_al_u191_o),
    .b(\sdif/n58_lutinv ),
    .c(_al_u169_o),
    .d(_al_u203_o),
    .e(\sctl/stat [1]),
    .o(\sdif/sdif_bst_lat ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u205 (
    .a(\sdif/sdif_bst_lat ),
    .b(\sdif/sctl_data_lat ),
    .o(\sdif/n4 ));
  AL_MAP_LUT5 #(
    .EQN("~(E*(A*~((D*B))*~(C)+A*(D*B)*~(C)+~(A)*(D*B)*C+A*(D*B)*C))"),
    .INIT(32'h35f5ffff))
    _al_u206 (
    .a(_al_u191_o),
    .b(_al_u169_o),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .e(rstsdc_n),
    .o(\sdif/n50 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u207 (
    .a(sctl_bw_enb),
    .b(rstsdc_n),
    .o(\sdif/n55 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u208 (
    .a(rfc_rfsh_req),
    .b(\sctl/stat [3]),
    .c(\sctl/stat [4]),
    .d(\sctl/stat [5]),
    .o(_al_u208_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u209 (
    .a(\sctl/stat [0]),
    .b(\ssys/phcnt [0]),
    .c(\ssys/phcnt [1]),
    .o(_al_u209_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u210 (
    .a(_al_u208_o),
    .b(_al_u209_o),
    .c(_al_u203_o),
    .o(_al_u210_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~(B)*C*~(D)+B*C*~(D)+~(B)*~(C)*D+B*~(C)*D+~(B)*C*D))"),
    .INIT(16'h2aa0))
    _al_u211 (
    .a(_al_u191_o),
    .b(_al_u194_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .o(_al_u211_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*B))*~(A)+D*(C*B)*~(A)+~(D)*(C*B)*A+D*(C*B)*A)"),
    .INIT(16'h2a7f))
    _al_u212 (
    .a(_al_u210_o),
    .b(bcmd_br[0]),
    .c(bcmd_br[1]),
    .d(_al_u211_o),
    .o(_al_u212_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*~A)"),
    .INIT(16'h0004))
    _al_u213 (
    .a(\sctl/stat [2]),
    .b(\sctl/stat [3]),
    .c(\sctl/stat [4]),
    .d(\sctl/stat [5]),
    .o(_al_u213_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*B))"),
    .INIT(8'h51))
    _al_u214 (
    .a(_al_u213_o),
    .b(_al_u171_o),
    .c(\sctl/stat [3]),
    .o(\sdif/eq8/or_xor_i0[4]_i1[4]_o_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u215 (
    .a(_al_u209_o),
    .b(_al_u161_o),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .o(_al_u215_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*(~(B)*~(C)*~(D)*~(E)+B*~(C)*~(D)*~(E)+~(B)*~(C)*D*~(E)+~(B)*C*D*~(E)+~(B)*~(C)*~(D)*E+B*~(C)*~(D)*E+~(B)*~(C)*D*E))"),
    .INIT(32'h01051105))
    _al_u216 (
    .a(_al_u215_o),
    .b(_al_u191_o),
    .c(_al_u169_o),
    .d(_al_u175_o),
    .e(\sctl/stat [2]),
    .o(_al_u216_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(~D*~C))"),
    .INIT(16'h8880))
    _al_u217 (
    .a(_al_u212_o),
    .b(\sdif/eq8/or_xor_i0[4]_i1[4]_o_o_lutinv ),
    .c(\sctl/stat [4]),
    .d(_al_u216_o),
    .o(\sctl/sel3_b4_sel_o_neg ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u218 (
    .a(_al_u203_o),
    .b(\sctl/stat [3]),
    .c(\sctl/stat [4]),
    .d(\sctl/stat [5]),
    .o(_al_u218_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u219 (
    .a(bcmd_br[0]),
    .b(bcmd_br[1]),
    .o(_al_u219_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u220 (
    .a(_al_u218_o),
    .b(_al_u209_o),
    .c(_al_u219_o),
    .d(rfc_rfsh_req),
    .o(\sdif/mux12_b8_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(D*C))"),
    .INIT(16'h0111))
    _al_u221 (
    .a(\sdif/mux12_b8_sel_is_0_o ),
    .b(\sctl/n72_lutinv ),
    .c(_al_u172_o),
    .d(_al_u193_o),
    .o(_al_u221_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*B)*~(~(E*D)*A))"),
    .INIT(32'h3f151515))
    _al_u222 (
    .a(_al_u191_o),
    .b(_al_u169_o),
    .c(_al_u182_o),
    .d(_al_u209_o),
    .e(\sctl/stat [1]),
    .o(\sdif/eq2/or_xor_i0[3]_i1[3]_o_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*(B@A))"),
    .INIT(8'h06))
    _al_u223 (
    .a(\sctl/stat [0]),
    .b(\sctl/stat [1]),
    .c(\sctl/stat [2]),
    .o(_al_u223_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u224 (
    .a(_al_u223_o),
    .b(\sctl/stat [3]),
    .c(\sctl/stat [5]),
    .o(_al_u224_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*C*D*~(E)+~(B)*~(C)*~(D)*E+~(B)*~(C)*D*E))"),
    .INIT(32'h02028000))
    _al_u225 (
    .a(_al_u171_o),
    .b(\sctl/stat [0]),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .e(\sctl/stat [3]),
    .o(_al_u225_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u226 (
    .a(_al_u221_o),
    .b(\sdif/eq2/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(_al_u224_o),
    .d(_al_u225_o),
    .o(\sctl/sel3_b2_sel_o_neg ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfff13fff))
    _al_u227 (
    .a(_al_u169_o),
    .b(_al_u171_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .e(\sctl/stat [2]),
    .o(_al_u227_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfff31fff))
    _al_u228 (
    .a(_al_u169_o),
    .b(_al_u161_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .e(\sctl/stat [2]),
    .o(_al_u228_o));
  AL_MAP_LUT5 #(
    .EQN("(B*A*~(~E*~D*C))"),
    .INIT(32'h88888808))
    _al_u229 (
    .a(_al_u227_o),
    .b(_al_u228_o),
    .c(_al_u213_o),
    .d(\sctl/stat [0]),
    .e(\sctl/stat [1]),
    .o(_al_u229_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(C)*~(D)*~((~E*B))+~(A)*C*~(D)*~((~E*B))+A*C*~(D)*~((~E*B))+~(A)*~(C)*D*~((~E*B))+A*~(C)*D*~((~E*B))+~(A)*C*D*~((~E*B))+A*C*D*~((~E*B))+~(A)*~(C)*~(D)*(~E*B)+~(A)*C*~(D)*(~E*B)+A*C*~(D)*(~E*B)+~(A)*~(C)*D*(~E*B)+A*~(C)*D*(~E*B))"),
    .INIT(32'hfff53ff5))
    _al_u230 (
    .a(_al_u191_o),
    .b(_al_u162_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .e(\sctl/stat [4]),
    .o(_al_u230_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u231 (
    .a(\sctl/stat [3]),
    .b(\sctl/stat [4]),
    .c(\sctl/stat [5]),
    .o(_al_u231_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*C*D*~(E)+B*C*D*~(E)+~(B)*~(C)*~(D)*E+B*~(C)*~(D)*E+~(B)*C*~(D)*E))"),
    .INIT(32'h002aa000))
    _al_u232 (
    .a(_al_u231_o),
    .b(ssys_osync),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .e(\sctl/stat [2]),
    .o(_al_u232_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u233 (
    .a(_al_u221_o),
    .b(_al_u229_o),
    .c(_al_u230_o),
    .d(_al_u232_o),
    .o(\sctl/sel3_b1_sel_o_neg ));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~D*~C*~B*A))"),
    .INIT(32'hfffd0000))
    _al_u234 (
    .a(_al_u174_o),
    .b(\sdif/mux12_b8_sel_is_0_o ),
    .c(\sctl/n72_lutinv ),
    .d(\sctl/n106_lutinv ),
    .e(rstsdc_n),
    .o(\sdif/u15_sel_is_2_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u235 (
    .a(\ssys/scnt [0]),
    .b(\ssys/scnt [1]),
    .c(\ssys/scnt [2]),
    .d(\ssys/scnt [3]),
    .o(_al_u235_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u236 (
    .a(_al_u235_o),
    .b(\ssys/scnt [4]),
    .c(\ssys/scnt [5]),
    .d(\ssys/scnt [6]),
    .e(\ssys/scnt [7]),
    .o(_al_u236_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u237 (
    .a(\ssys/scnt [12]),
    .b(\ssys/scnt [13]),
    .c(\ssys/scnt [14]),
    .d(\ssys/scnt [15]),
    .o(_al_u237_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u238 (
    .a(_al_u237_o),
    .b(\ssys/scnt [10]),
    .c(\ssys/scnt [11]),
    .d(\ssys/scnt [8]),
    .e(\ssys/scnt [9]),
    .o(_al_u238_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~C*~(B*A))"),
    .INIT(16'hfff8))
    _al_u239 (
    .a(_al_u236_o),
    .b(_al_u238_o),
    .c(sctl_test_enb),
    .d(ssys_stbl),
    .o(ssys_stbl_d));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u240 (
    .a(_al_u174_o),
    .b(_al_u181_o),
    .c(\sdif/mux12_b8_sel_is_0_o ),
    .d(\sctl/n72_lutinv ),
    .o(sctl_cs_n_t));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u241 (
    .a(_al_u231_o),
    .b(_al_u223_o),
    .o(_al_u241_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u242 (
    .a(_al_u241_o),
    .b(_al_u172_o),
    .c(_al_u213_o),
    .o(_al_u242_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~(~C*B*A))"),
    .INIT(32'h0000f700))
    _al_u243 (
    .a(_al_u242_o),
    .b(_al_u186_o),
    .c(_al_u232_o),
    .d(_al_u194_o),
    .e(_al_u219_o),
    .o(\sctl/sel2/B2 ));
  AL_MAP_LUT5 #(
    .EQN("(D*~C*~(~A*~(E*B)))"),
    .INIT(32'h0e000a00))
    _al_u244 (
    .a(_al_u191_o),
    .b(_al_u161_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .e(\sctl/stat [2]),
    .o(_al_u244_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u245 (
    .a(_al_u208_o),
    .b(_al_u182_o),
    .o(_al_u245_o));
  AL_MAP_LUT5 #(
    .EQN("(E*A*(B*C*~(D)+~(B)*~(C)*D+B*~(C)*D))"),
    .INIT(32'h0a800000))
    _al_u246 (
    .a(_al_u161_o),
    .b(\sctl/stat [0]),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .e(\sctl/stat [3]),
    .o(_al_u246_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*~B*~A))"),
    .INIT(16'hfe00))
    _al_u247 (
    .a(_al_u244_o),
    .b(_al_u245_o),
    .c(_al_u246_o),
    .d(ssys_osync),
    .o(_al_u247_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(~D*~B))"),
    .INIT(16'h0504))
    _al_u248 (
    .a(\sctl/sel2/B2 ),
    .b(_al_u247_o),
    .c(\sdif/mux12_b8_sel_is_0_o ),
    .d(\mbif/sdc_brdy_r ),
    .o(\mbif/n30 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u249 (
    .a(_al_u216_o),
    .b(_al_u241_o),
    .c(\sctl/n72_lutinv ),
    .d(_al_u232_o),
    .o(_al_u249_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u250 (
    .a(_al_u208_o),
    .b(_al_u194_o),
    .c(_al_u219_o),
    .o(_al_u250_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u251 (
    .a(_al_u249_o),
    .b(_al_u250_o),
    .c(_al_u186_o),
    .o(_al_u251_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u252 (
    .a(\sctl/stat [3]),
    .b(\sctl/stat [5]),
    .o(_al_u252_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u253 (
    .a(_al_u252_o),
    .b(_al_u193_o),
    .o(_al_u253_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*~A))"),
    .INIT(16'h0e00))
    _al_u254 (
    .a(_al_u169_o),
    .b(_al_u177_o),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .o(_al_u254_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u255 (
    .a(_al_u253_o),
    .b(_al_u241_o),
    .c(_al_u254_o),
    .d(\sctl/n72_lutinv ),
    .e(_al_u232_o),
    .o(_al_u255_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u256 (
    .a(_al_u161_o),
    .b(\sctl/stat [0]),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .o(_al_u256_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u257 (
    .a(\sdif/eq8/or_xor_i0[4]_i1[4]_o_o_lutinv ),
    .b(_al_u245_o),
    .c(_al_u256_o),
    .o(_al_u257_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(B*~(D*~C)))"),
    .INIT(16'hd5dd))
    _al_u258 (
    .a(_al_u251_o),
    .b(_al_u255_o),
    .c(_al_u257_o),
    .d(_al_u212_o),
    .o(\sctl/sel3_b5_sel_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u259 (
    .a(_al_u213_o),
    .b(_al_u177_o),
    .o(_al_u259_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~B*A*~(~E*D))"),
    .INIT(32'h20200020))
    _al_u260 (
    .a(_al_u259_o),
    .b(_al_u250_o),
    .c(_al_u230_o),
    .d(_al_u208_o),
    .e(bcmd_br[0]),
    .o(_al_u260_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u261 (
    .a(_al_u225_o),
    .b(_al_u216_o),
    .o(_al_u261_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*(~(B)*~(C)*~(D)*~(E)+B*~(C)*~(D)*~(E)+~(B)*C*~(D)*~(E)+B*C*~(D)*~(E)+~(B)*~(C)*D*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+B*~(C)*~(D)*E+B*C*~(D)*E+~(B)*~(C)*D*E+B*~(C)*D*E+~(B)*C*D*E))"),
    .INIT(32'hd577d555))
    _al_u262 (
    .a(_al_u260_o),
    .b(_al_u255_o),
    .c(_al_u257_o),
    .d(_al_u261_o),
    .e(\sctl/stat [4]),
    .o(\sctl/sel3_b3_sel_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u263 (
    .a(_al_u176_o),
    .b(rstsdc_n),
    .o(\sdif/mux13_b0_sel_is_1_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u264 (
    .a(\sdif/mux12_b8_sel_is_0_o ),
    .b(badr_br[17]),
    .c(badr_br[9]),
    .o(\sdif/n46 [7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u265 (
    .a(\sdif/mux12_b8_sel_is_0_o ),
    .b(badr_br[16]),
    .c(badr_br[8]),
    .o(\sdif/n46 [6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u266 (
    .a(\sdif/mux12_b8_sel_is_0_o ),
    .b(badr_br[13]),
    .c(badr_br[5]),
    .o(\sdif/n46 [3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u267 (
    .a(\sdif/mux12_b8_sel_is_0_o ),
    .b(badr_br[12]),
    .c(badr_br[4]),
    .o(\sdif/n46 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u268 (
    .a(_al_u174_o),
    .b(\sdif/mux12_b8_sel_is_0_o ),
    .c(badr_br[20]),
    .o(\sdif/n46 [10]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C*B))*~(D)*~(A)+(E*~(C*B))*D*~(A)+~((E*~(C*B)))*D*A+(E*~(C*B))*D*A)"),
    .INIT(32'hbf15aa00))
    _al_u269 (
    .a(\sdif/mux12_b8_sel_is_0_o ),
    .b(_al_u169_o),
    .c(_al_u173_o),
    .d(badr_br[10]),
    .e(badr_br[2]),
    .o(\sdif/n46 [0]));
  AL_MAP_LUT4 #(
    .EQN("~((~D*B)*~(A)*~(C)+(~D*B)*A*~(C)+~((~D*B))*A*C+(~D*B)*A*C)"),
    .INIT(16'h5f53))
    _al_u270 (
    .a(_al_u190_o),
    .b(_al_u191_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .o(_al_u270_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*~A*~(D*C))"),
    .INIT(16'hfbbb))
    _al_u271 (
    .a(\sctl/n471_neg ),
    .b(_al_u270_o),
    .c(_al_u169_o),
    .d(_al_u203_o),
    .o(\sdif/n19_d ));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u272 (
    .a(_al_u176_o),
    .b(\sdif/mux12_b8_sel_is_0_o ),
    .c(badr_br[19]),
    .o(\sdif/n46[9]_d ));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'hfbea))
    _al_u273 (
    .a(_al_u176_o),
    .b(\sdif/mux12_b8_sel_is_0_o ),
    .c(badr_br[15]),
    .d(badr_br[7]),
    .o(\sdif/n46[5]_d ));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'hfbea))
    _al_u274 (
    .a(_al_u176_o),
    .b(\sdif/mux12_b8_sel_is_0_o ),
    .c(badr_br[14]),
    .d(badr_br[6]),
    .o(\sdif/n46[4]_d ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*A))"),
    .INIT(8'h70))
    _al_u275 (
    .a(_al_u169_o),
    .b(_al_u173_o),
    .c(badr_br[3]),
    .o(\sdif/n44 [1]));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'hfeba))
    _al_u276 (
    .a(_al_u176_o),
    .b(\sdif/mux12_b8_sel_is_0_o ),
    .c(\sdif/n44 [1]),
    .d(badr_br[11]),
    .o(\sdif/n46[1]_d ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u277 (
    .a(\sctl/sel3_b2_sel_o_neg ),
    .b(\sctl/sel3_b1_sel_o_neg ),
    .c(\sdif/mux13_b0_sel_is_1_o ),
    .o(_al_u277_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(C)*~(D)+~(B)*~(C)*D+~(B)*C*D))"),
    .INIT(16'h2208))
    _al_u278 (
    .a(_al_u277_o),
    .b(\sctl/sel3_b5_sel_o ),
    .c(\sctl/sel3_b3_sel_o ),
    .d(\sctl/sel3_b4_sel_o_neg ),
    .o(\sdif/mux13_b8_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf55553ff))
    _al_u279 (
    .a(_al_u169_o),
    .b(_al_u177_o),
    .c(\sctl/stat [0]),
    .d(\sctl/stat [1]),
    .e(\sctl/stat [2]),
    .o(_al_u279_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u280 (
    .a(_al_u161_o),
    .b(\sctl/stat [0]),
    .c(\sctl/stat [1]),
    .d(\sctl/stat [2]),
    .e(\sctl/stat [3]),
    .o(\sdif/n24_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u281 (
    .a(bcmd_br[2]),
    .b(badr_br[0]),
    .o(\sdif/n2 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(~B*~(A*~(~E*~D))))"),
    .INIT(32'h0e0e0e0c))
    _al_u282 (
    .a(\sdif/n22 ),
    .b(_al_u279_o),
    .c(\sdif/n24_lutinv ),
    .d(\sdif/n2 [1]),
    .e(badr_br[1]),
    .o(\sdif/n32 [3]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u283 (
    .a(bcmd_br[2]),
    .b(badr_br[0]),
    .o(\sdif/n2 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(~B*~(A*~(~E*~D))))"),
    .INIT(32'h0e0e0e0c))
    _al_u284 (
    .a(\sdif/n22 ),
    .b(_al_u279_o),
    .c(\sdif/n24_lutinv ),
    .d(\sdif/n2 [0]),
    .e(badr_br[1]),
    .o(\sdif/n32 [2]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(~B*~(A*~(E*~D))))"),
    .INIT(32'h0e0c0e0e))
    _al_u285 (
    .a(\sdif/n22 ),
    .b(_al_u279_o),
    .c(\sdif/n24_lutinv ),
    .d(\sdif/n2 [1]),
    .e(badr_br[1]),
    .o(\sdif/n32 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(~B*~(A*~(E*~D))))"),
    .INIT(32'h0e0c0e0e))
    _al_u286 (
    .a(\sdif/n22 ),
    .b(_al_u279_o),
    .c(\sdif/n24_lutinv ),
    .d(\sdif/n2 [0]),
    .e(badr_br[1]),
    .o(\sdif/n32 [0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u287 (
    .a(\sdif/brcnt [0]),
    .o(\sdif/n52 [0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u288 (
    .a(sdc_bst_adr[0]),
    .o(\sdif/n56 [0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u289 (
    .a(\ssys/phcnt [0]),
    .o(\ssys/n8 [0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u290 (
    .a(\ssys/tgl_clk ),
    .o(\ssys/n2 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u73 (
    .a(pll_extlock),
    .b(rst_n),
    .o(\ssys/n0 ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u74 (
    .a(sdc_dqi[25]),
    .b(sdc_dqi[9]),
    .c(badr_br[1]),
    .o(\sdif/n5 [9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u75 (
    .a(sdc_dqi[24]),
    .b(sdc_dqi[8]),
    .c(badr_br[1]),
    .o(\sdif/n5 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u76 (
    .a(sdc_dqi[23]),
    .b(sdc_dqi[7]),
    .c(badr_br[1]),
    .o(\sdif/n5 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u77 (
    .a(sdc_dqi[22]),
    .b(sdc_dqi[6]),
    .c(badr_br[1]),
    .o(\sdif/n5 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u78 (
    .a(sdc_dqi[21]),
    .b(sdc_dqi[5]),
    .c(badr_br[1]),
    .o(\sdif/n5 [5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u79 (
    .a(sdc_dqi[20]),
    .b(sdc_dqi[4]),
    .c(badr_br[1]),
    .o(\sdif/n5 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u80 (
    .a(sdc_dqi[19]),
    .b(sdc_dqi[3]),
    .c(badr_br[1]),
    .o(\sdif/n5 [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u81 (
    .a(sdc_dqi[18]),
    .b(sdc_dqi[2]),
    .c(badr_br[1]),
    .o(\sdif/n5 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u82 (
    .a(sdc_dqi[31]),
    .b(sdc_dqi[15]),
    .c(badr_br[1]),
    .o(\sdif/n5 [15]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u83 (
    .a(sdc_dqi[30]),
    .b(sdc_dqi[14]),
    .c(badr_br[1]),
    .o(\sdif/n5 [14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u84 (
    .a(sdc_dqi[29]),
    .b(sdc_dqi[13]),
    .c(badr_br[1]),
    .o(\sdif/n5 [13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u85 (
    .a(sdc_dqi[28]),
    .b(sdc_dqi[12]),
    .c(badr_br[1]),
    .o(\sdif/n5 [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u86 (
    .a(sdc_dqi[27]),
    .b(sdc_dqi[11]),
    .c(badr_br[1]),
    .o(\sdif/n5 [11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u87 (
    .a(sdc_dqi[26]),
    .b(sdc_dqi[10]),
    .c(badr_br[1]),
    .o(\sdif/n5 [10]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u88 (
    .a(sdc_dqi[17]),
    .b(sdc_dqi[1]),
    .c(badr_br[1]),
    .o(\sdif/n5 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u89 (
    .a(sdc_dqi[16]),
    .b(sdc_dqi[0]),
    .c(badr_br[1]),
    .o(\sdif/n5 [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u90 (
    .a(bcmd_br[0]),
    .b(bdatr_br[0]),
    .o(bdatr[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u91 (
    .a(bcmd_br[0]),
    .b(bdatr_br[1]),
    .o(bdatr[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u92 (
    .a(bcmd_br[0]),
    .b(bdatr_br[10]),
    .o(bdatr[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u93 (
    .a(bcmd_br[0]),
    .b(bdatr_br[11]),
    .o(bdatr[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u94 (
    .a(bcmd_br[0]),
    .b(bdatr_br[12]),
    .o(bdatr[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u95 (
    .a(bcmd_br[0]),
    .b(bdatr_br[13]),
    .o(bdatr[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u96 (
    .a(bcmd_br[0]),
    .b(bdatr_br[14]),
    .o(bdatr[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u97 (
    .a(bcmd_br[0]),
    .b(bdatr_br[2]),
    .o(bdatr[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u98 (
    .a(bcmd_br[0]),
    .b(bdatr_br[3]),
    .o(bdatr[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u99 (
    .a(bcmd_br[0]),
    .b(bdatr_br[4]),
    .o(bdatr[4]));
  reg_sr_as_w1 \mbif/rd_sdrmctl_reg  (
    .clk(clk),
    .d(\mbif/n3 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\mbif/rd_sdrmctl ));  // rtl/sdramc8m.v(336)
  reg_sr_as_w1 \mbif/reg0_b0  (
    .clk(clk),
    .d(\mbif/n17 [0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bcmd_br[0]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg0_b1  (
    .clk(clk),
    .d(\mbif/n17 [1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bcmd_br[1]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg0_b2  (
    .clk(clk),
    .d(\mbif/n17 [2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bcmd_br[2]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b0  (
    .clk(clk),
    .d(\mbif/n18 [0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[0]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b1  (
    .clk(clk),
    .d(\mbif/n18 [1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[1]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b10  (
    .clk(clk),
    .d(\mbif/n18 [10]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[10]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b11  (
    .clk(clk),
    .d(\mbif/n18 [11]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[11]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b12  (
    .clk(clk),
    .d(\mbif/n18 [12]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[12]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b13  (
    .clk(clk),
    .d(\mbif/n18 [13]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[13]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b14  (
    .clk(clk),
    .d(\mbif/n18 [14]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[14]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b15  (
    .clk(clk),
    .d(\mbif/n18 [15]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[15]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b16  (
    .clk(clk),
    .d(\mbif/n18 [16]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[16]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b17  (
    .clk(clk),
    .d(\mbif/n18 [17]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[17]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b18  (
    .clk(clk),
    .d(\mbif/n18 [18]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[18]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b19  (
    .clk(clk),
    .d(\mbif/n18 [19]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[19]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b2  (
    .clk(clk),
    .d(\mbif/n18 [2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[2]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b20  (
    .clk(clk),
    .d(\mbif/n18 [20]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[20]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b21  (
    .clk(clk),
    .d(\mbif/n18 [21]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[21]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b22  (
    .clk(clk),
    .d(\mbif/n18 [22]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[22]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b3  (
    .clk(clk),
    .d(\mbif/n18 [3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[3]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b4  (
    .clk(clk),
    .d(\mbif/n18 [4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[4]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b5  (
    .clk(clk),
    .d(\mbif/n18 [5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[5]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b6  (
    .clk(clk),
    .d(\mbif/n18 [6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[6]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b7  (
    .clk(clk),
    .d(\mbif/n18 [7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[7]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b8  (
    .clk(clk),
    .d(\mbif/n18 [8]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[8]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg1_b9  (
    .clk(clk),
    .d(\mbif/n18 [9]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_br[9]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b0  (
    .clk(clk),
    .d(\mbif/n19 [0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[0]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b1  (
    .clk(clk),
    .d(\mbif/n19 [1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[1]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b10  (
    .clk(clk),
    .d(\mbif/n19 [10]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[10]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b11  (
    .clk(clk),
    .d(\mbif/n19 [11]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[11]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b12  (
    .clk(clk),
    .d(\mbif/n19 [12]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[12]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b13  (
    .clk(clk),
    .d(\mbif/n19 [13]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[13]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b14  (
    .clk(clk),
    .d(\mbif/n19 [14]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[14]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b15  (
    .clk(clk),
    .d(\mbif/n19 [15]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[15]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b2  (
    .clk(clk),
    .d(\mbif/n19 [2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[2]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b3  (
    .clk(clk),
    .d(\mbif/n19 [3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[3]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b4  (
    .clk(clk),
    .d(\mbif/n19 [4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[4]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b5  (
    .clk(clk),
    .d(\mbif/n19 [5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[5]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b6  (
    .clk(clk),
    .d(\mbif/n19 [6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[6]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b7  (
    .clk(clk),
    .d(\mbif/n19 [7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[7]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b8  (
    .clk(clk),
    .d(\mbif/n19 [8]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[8]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/reg2_b9  (
    .clk(clk),
    .d(\mbif/n19 [9]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bdatw_br[9]));  // rtl/sdramc8m.v(385)
  reg_sr_as_w1 \mbif/sctl_ready_reg  (
    .clk(clksdc),
    .d(sctl_ready_t),
    .en(ssys_osync),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\mbif/sctl_ready ));  // rtl/sdramc8m.v(356)
  reg_sr_as_w1 \mbif/sctl_test_enb_reg  (
    .clk(clk),
    .d(bdatw[15]),
    .en(\mbif/n8 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(sctl_test_enb));  // rtl/sdramc8m.v(346)
  reg_ar_ss_w1 \mbif/sdc_brdy_r_reg  (
    .clk(clksdc),
    .d(\mbif/n30 ),
    .en(1'b1),
    .reset(1'b0),
    .set(~rstsdc_n),
    .q(\mbif/sdc_brdy_r ));  // rtl/sdramc8m.v(403)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u0  (
    .a(\rfsh/rfc_rfsh_cnt [0]),
    .b(1'b1),
    .c(\rfsh/add0/c0 ),
    .o({\rfsh/add0/c1 ,\rfsh/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u1  (
    .a(\rfsh/rfc_rfsh_cnt [1]),
    .b(1'b0),
    .c(\rfsh/add0/c1 ),
    .o({\rfsh/add0/c2 ,\rfsh/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u10  (
    .a(\rfsh/rfc_rfsh_cnt [10]),
    .b(1'b0),
    .c(\rfsh/add0/c10 ),
    .o({\rfsh/add0/c11 ,\rfsh/n4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u11  (
    .a(\rfsh/rfc_rfsh_cnt [11]),
    .b(1'b0),
    .c(\rfsh/add0/c11 ),
    .o({open_n0,\rfsh/n4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u2  (
    .a(\rfsh/rfc_rfsh_cnt [2]),
    .b(1'b0),
    .c(\rfsh/add0/c2 ),
    .o({\rfsh/add0/c3 ,\rfsh/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u3  (
    .a(\rfsh/rfc_rfsh_cnt [3]),
    .b(1'b0),
    .c(\rfsh/add0/c3 ),
    .o({\rfsh/add0/c4 ,\rfsh/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u4  (
    .a(\rfsh/rfc_rfsh_cnt [4]),
    .b(1'b0),
    .c(\rfsh/add0/c4 ),
    .o({\rfsh/add0/c5 ,\rfsh/n4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u5  (
    .a(\rfsh/rfc_rfsh_cnt [5]),
    .b(1'b0),
    .c(\rfsh/add0/c5 ),
    .o({\rfsh/add0/c6 ,\rfsh/n4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u6  (
    .a(\rfsh/rfc_rfsh_cnt [6]),
    .b(1'b0),
    .c(\rfsh/add0/c6 ),
    .o({\rfsh/add0/c7 ,\rfsh/n4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u7  (
    .a(\rfsh/rfc_rfsh_cnt [7]),
    .b(1'b0),
    .c(\rfsh/add0/c7 ),
    .o({\rfsh/add0/c8 ,\rfsh/n4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u8  (
    .a(\rfsh/rfc_rfsh_cnt [8]),
    .b(1'b0),
    .c(\rfsh/add0/c8 ),
    .o({\rfsh/add0/c9 ,\rfsh/n4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rfsh/add0/u9  (
    .a(\rfsh/rfc_rfsh_cnt [9]),
    .b(1'b0),
    .c(\rfsh/add0/c9 ),
    .o({\rfsh/add0/c10 ,\rfsh/n4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rfsh/add0/ucin  (
    .a(1'b0),
    .o({\rfsh/add0/c0 ,open_n3}));
  reg_sr_as_w1 \rfsh/reg0_b0  (
    .clk(clksdc),
    .d(\rfsh/n4 [0]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [0]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b1  (
    .clk(clksdc),
    .d(\rfsh/n4 [1]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [1]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b10  (
    .clk(clksdc),
    .d(\rfsh/n4 [10]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [10]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b11  (
    .clk(clksdc),
    .d(\rfsh/n4 [11]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [11]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b2  (
    .clk(clksdc),
    .d(\rfsh/n4 [2]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [2]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b3  (
    .clk(clksdc),
    .d(\rfsh/n4 [3]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [3]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b4  (
    .clk(clksdc),
    .d(\rfsh/n4 [4]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [4]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b5  (
    .clk(clksdc),
    .d(\rfsh/n4 [5]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [5]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b6  (
    .clk(clksdc),
    .d(\rfsh/n4 [6]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [6]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b7  (
    .clk(clksdc),
    .d(\rfsh/n4 [7]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [7]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b8  (
    .clk(clksdc),
    .d(\rfsh/n4 [8]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [8]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/reg0_b9  (
    .clk(clksdc),
    .d(\rfsh/n4 [9]),
    .en(1'b1),
    .reset(\rfsh/n3 ),
    .set(1'b0),
    .q(\rfsh/rfc_rfsh_cnt [9]));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \rfsh/rfc_rfsh_req_reg  (
    .clk(clksdc),
    .d(\rfsh/rfc_rfsh_ovf ),
    .en(\mbif/_al_n0_en ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(rfc_rfsh_req));  // rtl/sdramc8m.v(447)
  reg_sr_as_w1 \sctl/reg0_b0  (
    .clk(clksdc),
    .d(\sctl/sel3_b0_sel_o_neg ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sctl/stat [0]));  // rtl/sdc_fsm.v(198)
  reg_sr_as_w1 \sctl/reg0_b1  (
    .clk(clksdc),
    .d(\sctl/sel3_b1_sel_o_neg ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sctl/stat [1]));  // rtl/sdc_fsm.v(198)
  reg_sr_as_w1 \sctl/reg0_b2  (
    .clk(clksdc),
    .d(\sctl/sel3_b2_sel_o_neg ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sctl/stat [2]));  // rtl/sdc_fsm.v(198)
  reg_sr_as_w1 \sctl/reg0_b3  (
    .clk(clksdc),
    .d(\sctl/sel3_b3_sel_o ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sctl/stat [3]));  // rtl/sdc_fsm.v(198)
  reg_sr_as_w1 \sctl/reg0_b4  (
    .clk(clksdc),
    .d(\sctl/sel3_b4_sel_o_neg ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sctl/stat [4]));  // rtl/sdc_fsm.v(198)
  reg_sr_as_w1 \sctl/reg0_b5  (
    .clk(clksdc),
    .d(\sctl/sel3_b5_sel_o ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sctl/stat [5]));  // rtl/sdc_fsm.v(198)
  reg_sr_as_w1 \sctl/sctl_ready_t_reg  (
    .clk(clksdc),
    .d(sctl_ready_t_d),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(sctl_ready_t));  // rtl/sdc_fsm.v(126)
  reg_sr_as_w1 \sdif/reg0_b0  (
    .clk(clksdc),
    .d(\sdif/n5 [0]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[0]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b1  (
    .clk(clksdc),
    .d(\sdif/n5 [1]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[1]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b10  (
    .clk(clksdc),
    .d(\sdif/n5 [10]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[10]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b11  (
    .clk(clksdc),
    .d(\sdif/n5 [11]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[11]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b12  (
    .clk(clksdc),
    .d(\sdif/n5 [12]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[12]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b13  (
    .clk(clksdc),
    .d(\sdif/n5 [13]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[13]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b14  (
    .clk(clksdc),
    .d(\sdif/n5 [14]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[14]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b15  (
    .clk(clksdc),
    .d(\sdif/n5 [15]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[15]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b2  (
    .clk(clksdc),
    .d(\sdif/n5 [2]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[2]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b3  (
    .clk(clksdc),
    .d(\sdif/n5 [3]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[3]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b4  (
    .clk(clksdc),
    .d(\sdif/n5 [4]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[4]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b5  (
    .clk(clksdc),
    .d(\sdif/n5 [5]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[5]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b6  (
    .clk(clksdc),
    .d(\sdif/n5 [6]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[6]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b7  (
    .clk(clksdc),
    .d(\sdif/n5 [7]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[7]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b8  (
    .clk(clksdc),
    .d(\sdif/n5 [8]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[8]));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/reg0_b9  (
    .clk(clksdc),
    .d(\sdif/n5 [9]),
    .en(\sdif/n4 ),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(bdatr_br[9]));  // rtl/sdramc8m.v(591)
  reg_ar_as_w1 \sdif/reg1_b0  (
    .clk(clksdc),
    .d(bdatw_br[0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[16]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b1  (
    .clk(clksdc),
    .d(bdatw_br[1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[17]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b10  (
    .clk(clksdc),
    .d(bdatw_br[10]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[26]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b11  (
    .clk(clksdc),
    .d(bdatw_br[11]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[27]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b12  (
    .clk(clksdc),
    .d(bdatw_br[12]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[28]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b13  (
    .clk(clksdc),
    .d(bdatw_br[13]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[29]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b14  (
    .clk(clksdc),
    .d(bdatw_br[14]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[30]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b15  (
    .clk(clksdc),
    .d(bdatw_br[15]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[31]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b18  (
    .clk(clksdc),
    .d(bdatw_br[2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[18]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b19  (
    .clk(clksdc),
    .d(bdatw_br[3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[19]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b20  (
    .clk(clksdc),
    .d(bdatw_br[4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[20]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b21  (
    .clk(clksdc),
    .d(bdatw_br[5]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[21]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b22  (
    .clk(clksdc),
    .d(bdatw_br[6]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[22]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b23  (
    .clk(clksdc),
    .d(bdatw_br[7]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[23]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b24  (
    .clk(clksdc),
    .d(bdatw_br[8]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[24]));  // rtl/sdramc8m.v(688)
  reg_ar_as_w1 \sdif/reg1_b25  (
    .clk(clksdc),
    .d(bdatw_br[9]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(sdc_dqo[25]));  // rtl/sdramc8m.v(688)
  reg_ar_ss_w1 \sdif/reg2_b0  (
    .clk(clksdc),
    .d(\sdif/n32 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rstsdc_n),
    .q(sdc_dqm[0]));  // rtl/sdramc8m.v(688)
  reg_ar_ss_w1 \sdif/reg2_b1  (
    .clk(clksdc),
    .d(\sdif/n32 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rstsdc_n),
    .q(sdc_dqm[1]));  // rtl/sdramc8m.v(688)
  reg_ar_ss_w1 \sdif/reg2_b2  (
    .clk(clksdc),
    .d(\sdif/n32 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rstsdc_n),
    .q(sdc_dqm[2]));  // rtl/sdramc8m.v(688)
  reg_ar_ss_w1 \sdif/reg2_b3  (
    .clk(clksdc),
    .d(\sdif/n32 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rstsdc_n),
    .q(sdc_dqm[3]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg3_b0  (
    .clk(clksdc),
    .d(badr_br[21]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_ba[0]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg3_b1  (
    .clk(clksdc),
    .d(badr_br[22]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_ba[1]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b0  (
    .clk(clksdc),
    .d(\sdif/n46 [0]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_addr[0]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b1  (
    .clk(clksdc),
    .d(\sdif/n46[1]_d ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(sdc_addr[1]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b10  (
    .clk(clksdc),
    .d(\sdif/n46 [10]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_addr[10]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b2  (
    .clk(clksdc),
    .d(\sdif/n46 [2]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_addr[2]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b3  (
    .clk(clksdc),
    .d(\sdif/n46 [3]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_addr[3]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b4  (
    .clk(clksdc),
    .d(\sdif/n46[4]_d ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(sdc_addr[4]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b5  (
    .clk(clksdc),
    .d(\sdif/n46[5]_d ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(sdc_addr[5]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b6  (
    .clk(clksdc),
    .d(\sdif/n46 [6]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_addr[6]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b7  (
    .clk(clksdc),
    .d(\sdif/n46 [7]),
    .en(1'b1),
    .reset(~\sdif/mux13_b0_sel_is_1_o ),
    .set(1'b0),
    .q(sdc_addr[7]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b8  (
    .clk(clksdc),
    .d(badr_br[18]),
    .en(1'b1),
    .reset(~\sdif/mux13_b8_sel_is_3_o ),
    .set(1'b0),
    .q(sdc_addr[8]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg4_b9  (
    .clk(clksdc),
    .d(\sdif/n46[9]_d ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(sdc_addr[9]));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/reg5_b0  (
    .clk(clksdc),
    .d(sdc_dqi[0]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[0]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b1  (
    .clk(clksdc),
    .d(sdc_dqi[1]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[1]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b10  (
    .clk(clksdc),
    .d(sdc_dqi[10]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[10]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b11  (
    .clk(clksdc),
    .d(sdc_dqi[11]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[11]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b12  (
    .clk(clksdc),
    .d(sdc_dqi[12]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[12]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b13  (
    .clk(clksdc),
    .d(sdc_dqi[13]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[13]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b14  (
    .clk(clksdc),
    .d(sdc_dqi[14]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[14]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b15  (
    .clk(clksdc),
    .d(sdc_dqi[15]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[15]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b16  (
    .clk(clksdc),
    .d(sdc_dqi[16]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[16]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b17  (
    .clk(clksdc),
    .d(sdc_dqi[17]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[17]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b18  (
    .clk(clksdc),
    .d(sdc_dqi[18]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[18]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b19  (
    .clk(clksdc),
    .d(sdc_dqi[19]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[19]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b2  (
    .clk(clksdc),
    .d(sdc_dqi[2]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[2]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b20  (
    .clk(clksdc),
    .d(sdc_dqi[20]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[20]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b21  (
    .clk(clksdc),
    .d(sdc_dqi[21]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[21]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b22  (
    .clk(clksdc),
    .d(sdc_dqi[22]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[22]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b23  (
    .clk(clksdc),
    .d(sdc_dqi[23]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[23]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b24  (
    .clk(clksdc),
    .d(sdc_dqi[24]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[24]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b25  (
    .clk(clksdc),
    .d(sdc_dqi[25]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[25]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b26  (
    .clk(clksdc),
    .d(sdc_dqi[26]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[26]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b27  (
    .clk(clksdc),
    .d(sdc_dqi[27]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[27]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b28  (
    .clk(clksdc),
    .d(sdc_dqi[28]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[28]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b29  (
    .clk(clksdc),
    .d(sdc_dqi[29]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[29]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b3  (
    .clk(clksdc),
    .d(sdc_dqi[3]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[3]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b30  (
    .clk(clksdc),
    .d(sdc_dqi[30]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[30]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b31  (
    .clk(clksdc),
    .d(sdc_dqi[31]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[31]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b4  (
    .clk(clksdc),
    .d(sdc_dqi[4]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[4]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b5  (
    .clk(clksdc),
    .d(sdc_dqi[5]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[5]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b6  (
    .clk(clksdc),
    .d(sdc_dqi[6]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[6]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b7  (
    .clk(clksdc),
    .d(sdc_dqi[7]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[7]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b8  (
    .clk(clksdc),
    .d(sdc_dqi[8]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[8]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg5_b9  (
    .clk(clksdc),
    .d(sdc_dqi[9]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(sdc_bst_dat[9]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg6_b0  (
    .clk(clksdc),
    .d(\sdif/n52 [0]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(\sdif/brcnt [0]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg6_b1  (
    .clk(clksdc),
    .d(\sdif/n52 [1]),
    .en(1'b1),
    .reset(\sdif/n50 ),
    .set(1'b0),
    .q(\sdif/brcnt [1]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg7_b0  (
    .clk(clksdc),
    .d(\sdif/n56 [0]),
    .en(1'b1),
    .reset(\sdif/n55 ),
    .set(1'b0),
    .q(sdc_bst_adr[0]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/reg7_b1  (
    .clk(clksdc),
    .d(\sdif/n56 [1]),
    .en(1'b1),
    .reset(\sdif/n55 ),
    .set(1'b0),
    .q(sdc_bst_adr[1]));  // rtl/sdramc8m.v(716)
  reg_sr_as_w1 \sdif/sctl_data_lat_reg  (
    .clk(clksdc),
    .d(\sctl/n471_neg ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sdif/sctl_data_lat ));  // rtl/sdramc8m.v(591)
  reg_sr_as_w1 \sdif/sdc_cas_n_reg  (
    .clk(clksdc),
    .d(1'b1),
    .en(1'b1),
    .reset(\sdif/u16_sel_is_2_o ),
    .set(1'b0),
    .q(sdc_cas_n));  // rtl/sdramc8m.v(688)
  reg_ar_ss_w1 \sdif/sdc_cs_n_r_reg  (
    .clk(clksdc),
    .d(sctl_cs_n_t),
    .en(1'b1),
    .reset(1'b0),
    .set(~rstsdc_n),
    .q(\sdif/sdc_cs_n_r ));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/sdc_dqie_r_reg  (
    .clk(clksdc),
    .d(\sdif/n19_d ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sdif/sdc_dqie_r ));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/sdc_dqoe_r_reg  (
    .clk(clksdc),
    .d(\sdif/n22 ),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\sdif/sdc_dqoe_r ));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/sdc_ras_n_reg  (
    .clk(clksdc),
    .d(1'b1),
    .en(1'b1),
    .reset(\sdif/u15_sel_is_2_o ),
    .set(1'b0),
    .q(sdc_ras_n));  // rtl/sdramc8m.v(688)
  reg_sr_as_w1 \sdif/sdc_we_n_reg  (
    .clk(clksdc),
    .d(1'b1),
    .en(1'b1),
    .reset(\sdif/u17_sel_is_2_o ),
    .set(1'b0),
    .q(sdc_we_n));  // rtl/sdramc8m.v(688)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u0  (
    .a(\ssys/scnt [0]),
    .b(1'b1),
    .c(\ssys/add1/c0 ),
    .o({\ssys/add1/c1 ,\ssys/n10 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u1  (
    .a(\ssys/scnt [1]),
    .b(1'b0),
    .c(\ssys/add1/c1 ),
    .o({\ssys/add1/c2 ,\ssys/n10 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u10  (
    .a(\ssys/scnt [10]),
    .b(1'b0),
    .c(\ssys/add1/c10 ),
    .o({\ssys/add1/c11 ,\ssys/n10 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u11  (
    .a(\ssys/scnt [11]),
    .b(1'b0),
    .c(\ssys/add1/c11 ),
    .o({\ssys/add1/c12 ,\ssys/n10 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u12  (
    .a(\ssys/scnt [12]),
    .b(1'b0),
    .c(\ssys/add1/c12 ),
    .o({\ssys/add1/c13 ,\ssys/n10 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u13  (
    .a(\ssys/scnt [13]),
    .b(1'b0),
    .c(\ssys/add1/c13 ),
    .o({\ssys/add1/c14 ,\ssys/n10 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u14  (
    .a(\ssys/scnt [14]),
    .b(1'b0),
    .c(\ssys/add1/c14 ),
    .o({\ssys/add1/c15 ,\ssys/n10 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u15  (
    .a(\ssys/scnt [15]),
    .b(1'b0),
    .c(\ssys/add1/c15 ),
    .o({open_n4,\ssys/n10 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u2  (
    .a(\ssys/scnt [2]),
    .b(1'b0),
    .c(\ssys/add1/c2 ),
    .o({\ssys/add1/c3 ,\ssys/n10 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u3  (
    .a(\ssys/scnt [3]),
    .b(1'b0),
    .c(\ssys/add1/c3 ),
    .o({\ssys/add1/c4 ,\ssys/n10 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u4  (
    .a(\ssys/scnt [4]),
    .b(1'b0),
    .c(\ssys/add1/c4 ),
    .o({\ssys/add1/c5 ,\ssys/n10 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u5  (
    .a(\ssys/scnt [5]),
    .b(1'b0),
    .c(\ssys/add1/c5 ),
    .o({\ssys/add1/c6 ,\ssys/n10 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u6  (
    .a(\ssys/scnt [6]),
    .b(1'b0),
    .c(\ssys/add1/c6 ),
    .o({\ssys/add1/c7 ,\ssys/n10 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u7  (
    .a(\ssys/scnt [7]),
    .b(1'b0),
    .c(\ssys/add1/c7 ),
    .o({\ssys/add1/c8 ,\ssys/n10 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u8  (
    .a(\ssys/scnt [8]),
    .b(1'b0),
    .c(\ssys/add1/c8 ),
    .o({\ssys/add1/c9 ,\ssys/n10 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ssys/add1/u9  (
    .a(\ssys/scnt [9]),
    .b(1'b0),
    .c(\ssys/add1/c9 ),
    .o({\ssys/add1/c10 ,\ssys/n10 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \ssys/add1/ucin  (
    .a(1'b0),
    .o({\ssys/add1/c0 ,open_n7}));
  reg_ar_as_w1 \ssys/lat_clk_reg  (
    .clk(clksdc),
    .d(\ssys/tgl_clk ),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\ssys/lat_clk ));  // rtl/sdramc8m.v(251)
  reg_sr_as_w1 \ssys/reg0_b0  (
    .clk(clksdc),
    .d(\ssys/n8 [0]),
    .en(1'b1),
    .reset(\ssys/n7 ),
    .set(1'b0),
    .q(\ssys/phcnt [0]));  // rtl/sdramc8m.v(251)
  reg_sr_as_w1 \ssys/reg0_b1  (
    .clk(clksdc),
    .d(\ssys/n8 [1]),
    .en(1'b1),
    .reset(\ssys/n7 ),
    .set(1'b0),
    .q(\ssys/phcnt [1]));  // rtl/sdramc8m.v(251)
  reg_sr_as_w1 \ssys/reg1_b0  (
    .clk(clksdc),
    .d(\ssys/n10 [0]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [0]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b1  (
    .clk(clksdc),
    .d(\ssys/n10 [1]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [1]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b10  (
    .clk(clksdc),
    .d(\ssys/n10 [10]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [10]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b11  (
    .clk(clksdc),
    .d(\ssys/n10 [11]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [11]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b12  (
    .clk(clksdc),
    .d(\ssys/n10 [12]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [12]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b13  (
    .clk(clksdc),
    .d(\ssys/n10 [13]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [13]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b14  (
    .clk(clksdc),
    .d(\ssys/n10 [14]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [14]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b15  (
    .clk(clksdc),
    .d(\ssys/n10 [15]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [15]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b2  (
    .clk(clksdc),
    .d(\ssys/n10 [2]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [2]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b3  (
    .clk(clksdc),
    .d(\ssys/n10 [3]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [3]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b4  (
    .clk(clksdc),
    .d(\ssys/n10 [4]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [4]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b5  (
    .clk(clksdc),
    .d(\ssys/n10 [5]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [5]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b6  (
    .clk(clksdc),
    .d(\ssys/n10 [6]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [6]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b7  (
    .clk(clksdc),
    .d(\ssys/n10 [7]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [7]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b8  (
    .clk(clksdc),
    .d(\ssys/n10 [8]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [8]));  // rtl/sdramc8m.v(276)
  reg_sr_as_w1 \ssys/reg1_b9  (
    .clk(clksdc),
    .d(\ssys/n10 [9]),
    .en(~ssys_stbl),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(\ssys/scnt [9]));  // rtl/sdramc8m.v(276)
  reg_ar_as_w1 \ssys/rst_n_f_reg  (
    .clk(clk),
    .d(\ssys/n0 ),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\ssys/rst_n_f ));  // rtl/sdramc8m.v(218)
  reg_ar_as_w1 \ssys/rstsdc_n_reg  (
    .clk(clksdc),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ssys/rst_n_f ),
    .set(1'b0),
    .q(rstsdc_n));  // rtl/sdramc8m.v(227)
  reg_sr_as_w1 \ssys/ssys_stbl_reg  (
    .clk(clksdc),
    .d(ssys_stbl_d),
    .en(1'b1),
    .reset(~rstsdc_n),
    .set(1'b0),
    .q(ssys_stbl));  // rtl/sdramc8m.v(276)
  reg_ar_ss_w1 \ssys/tgl_clk_reg  (
    .clk(clk),
    .d(\ssys/n2 ),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\ssys/tgl_clk ));  // rtl/sdramc8m.v(238)

endmodule 

