
`timescale 1ns / 1ps
module stwmst  // rtl/stwmst.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_stws_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  stws_scl_i,
  stws_sda_i,
  bdatr,
  stwm_scl_o,
  stwm_sda_o,
  stws_mrar,
  stws_mter
  );
//
//	Synchronous Two Wire serial Master Unit
//		(c) 2021	1YEN Toru
//
//
//	2021/08/14	ver.1.00
//		i2c like synchronous two wire serial master
//

  input [3:0] badr;  // rtl/stwmst.v(27)
  input bcmdr;  // rtl/stwmst.v(25)
  input bcmdw;  // rtl/stwmst.v(26)
  input bcs_stws_n;  // rtl/stwmst.v(23)
  input [15:0] bdatw;  // rtl/stwmst.v(28)
  input brdy;  // rtl/stwmst.v(24)
  input clk;  // rtl/stwmst.v(19)
  input rst_n;  // rtl/stwmst.v(20)
  input stws_scl_i;  // rtl/stwmst.v(21)
  input stws_sda_i;  // rtl/stwmst.v(22)
  output [15:0] bdatr;  // rtl/stwmst.v(33)
  output stwm_scl_o;  // rtl/stwmst.v(29)
  output stwm_sda_o;  // rtl/stwmst.v(30)
  output stws_mrar;  // rtl/stwmst.v(32)
  output stws_mter;  // rtl/stwmst.v(31)

  wire [15:0] bdatr_mclk;  // rtl/stwmst.v(49)
  wire [15:0] \mclk/hcnt ;  // rtl/stwmst.v(806)
  wire [15:0] \mclk/lcnt ;  // rtl/stwmst.v(785)
  wire [15:0] \mclk/n12 ;
  wire [15:0] \mclk/n19 ;
  wire [15:0] \mclk/tscl_l ;  // rtl/stwmst.v(779)
  wire [4:0] \mctl/fsm/stat ;  // rtl/stwm_fsm.v(111)
  wire [7:0] \mctl/mctl_scl_f ;  // rtl/stwmst.v(362)
  wire [7:0] \mctl/mctl_sda_f ;  // rtl/stwmst.v(363)
  wire [15:0] \mctl/n84 ;
  wire [15:0] \mctl/n88 ;
  wire [15:0] \mctl/stwmctl ;  // rtl/stwmst.v(313)
  wire [4:0] \mctl/synfil_scl ;  // rtl/stwmst.v(333)
  wire [4:0] \mctl/synfil_sda ;  // rtl/stwmst.v(334)
  wire [15:0] \mctl/tcnt ;  // rtl/stwmst.v(482)
  wire [15:0] \mctl/tcnt_cmp ;  // rtl/stwmst.v(481)
  wire [15:0] \mctl/tcnt_cmp_t ;  // rtl/stwmst.v(473)
  wire [7:0] \mdat/mdat_datr_sft ;  // rtl/stwmst.v(603)
  wire [8:0] \mdat/mdat_dats ;  // rtl/stwmst.v(706)
  wire [8:0] \mdat/mdat_dats_sft ;  // rtl/stwmst.v(705)
  wire [7:0] \mdat/n7 ;
  wire [7:0] \mdat/stwmdatr ;  // rtl/stwmst.v(614)
  wire [8:0] \mdat/stwmdats ;  // rtl/stwmst.v(682)
  wire [4:0] n0;
  wire [11:0] n1;
  wire [15:0] stwmbaud;  // rtl/stwmst.v(46)
  wire _al_u118_o;
  wire _al_u120_o;
  wire _al_u122_o;
  wire _al_u124_o;
  wire _al_u126_o;
  wire _al_u128_o;
  wire _al_u134_o;
  wire _al_u136_o;
  wire _al_u144_o;
  wire _al_u157_o;
  wire _al_u158_o;
  wire _al_u159_o;
  wire _al_u160_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u163_o;
  wire _al_u164_o;
  wire _al_u165_o;
  wire _al_u168_o;
  wire _al_u169_o;
  wire _al_u170_o;
  wire _al_u171_o;
  wire _al_u172_o;
  wire _al_u173_o;
  wire _al_u174_o;
  wire _al_u175_o;
  wire _al_u176_o;
  wire _al_u178_o;
  wire _al_u180_o;
  wire _al_u182_o;
  wire _al_u183_o;
  wire _al_u184_o;
  wire _al_u185_o;
  wire _al_u187_o;
  wire _al_u188_o;
  wire _al_u189_o;
  wire _al_u190_o;
  wire _al_u191_o;
  wire _al_u192_o;
  wire _al_u193_o;
  wire _al_u194_o;
  wire _al_u195_o;
  wire _al_u196_o;
  wire _al_u197_o;
  wire _al_u198_o;
  wire _al_u202_o;
  wire _al_u206_o;
  wire _al_u207_o;
  wire _al_u208_o;
  wire _al_u209_o;
  wire _al_u210_o;
  wire _al_u211_o;
  wire _al_u212_o;
  wire _al_u213_o;
  wire _al_u214_o;
  wire _al_u215_o;
  wire _al_u216_o;
  wire _al_u217_o;
  wire _al_u218_o;
  wire _al_u219_o;
  wire _al_u220_o;
  wire _al_u221_o;
  wire _al_u222_o;
  wire _al_u223_o;
  wire _al_u225_o;
  wire _al_u227_o;
  wire _al_u228_o;
  wire _al_u229_o;
  wire _al_u231_o;
  wire _al_u232_o;
  wire _al_u234_o;
  wire _al_u235_o;
  wire _al_u236_o;
  wire _al_u238_o;
  wire _al_u239_o;
  wire _al_u240_o;
  wire _al_u241_o;
  wire _al_u243_o;
  wire _al_u244_o;
  wire _al_u245_o;
  wire _al_u246_o;
  wire _al_u248_o;
  wire _al_u249_o;
  wire _al_u251_o;
  wire _al_u252_o;
  wire _al_u254_o;
  wire _al_u255_o;
  wire _al_u256_o;
  wire _al_u258_o;
  wire _al_u259_o;
  wire _al_u262_o;
  wire _al_u263_o;
  wire _al_u264_o;
  wire _al_u265_o;
  wire _al_u266_o;
  wire _al_u267_o;
  wire _al_u269_o;
  wire _al_u270_o;
  wire _al_u274_o;
  wire _al_u275_o;
  wire _al_u277_o;
  wire _al_u278_o;
  wire _al_u279_o;
  wire _al_u280_o;
  wire _al_u284_o;
  wire _al_u285_o;
  wire _al_u286_o;
  wire _al_u287_o;
  wire _al_u290_o;
  wire _al_u293_o;
  wire _al_u309_o;
  wire \mclk/add1/c0 ;
  wire \mclk/add1/c1 ;
  wire \mclk/add1/c10 ;
  wire \mclk/add1/c11 ;
  wire \mclk/add1/c12 ;
  wire \mclk/add1/c13 ;
  wire \mclk/add1/c14 ;
  wire \mclk/add1/c15 ;
  wire \mclk/add1/c2 ;
  wire \mclk/add1/c3 ;
  wire \mclk/add1/c4 ;
  wire \mclk/add1/c5 ;
  wire \mclk/add1/c6 ;
  wire \mclk/add1/c7 ;
  wire \mclk/add1/c8 ;
  wire \mclk/add1/c9 ;
  wire \mclk/add2/c0 ;
  wire \mclk/add2/c1 ;
  wire \mclk/add2/c10 ;
  wire \mclk/add2/c11 ;
  wire \mclk/add2/c12 ;
  wire \mclk/add2/c13 ;
  wire \mclk/add2/c14 ;
  wire \mclk/add2/c15 ;
  wire \mclk/add2/c2 ;
  wire \mclk/add2/c3 ;
  wire \mclk/add2/c4 ;
  wire \mclk/add2/c5 ;
  wire \mclk/add2/c6 ;
  wire \mclk/add2/c7 ;
  wire \mclk/add2/c8 ;
  wire \mclk/add2/c9 ;
  wire \mclk/mclk_start_cnt ;  // rtl/stwmst.v(784)
  wire \mclk/mux4_b0_sel_is_2_o ;
  wire \mclk/mux7_b0_sel_is_2_o ;
  wire \mclk/n2_en ;
  wire \mclk/n2_en_al_n128 ;
  wire \mclk/n2_en_al_n130 ;
  wire \mclk/n2_en_al_n132 ;
  wire \mclk/n2_en_al_n134 ;
  wire \mclk/n2_en_al_n136 ;
  wire \mclk/n2_en_al_n138 ;
  wire \mclk/n9 ;
  wire \mclk/sub1_mclk/sub2/c0 ;
  wire \mclk/sub1_mclk/sub2/c1 ;
  wire \mclk/sub1_mclk/sub2/c10 ;
  wire \mclk/sub1_mclk/sub2/c11 ;
  wire \mclk/sub1_mclk/sub2/c2 ;
  wire \mclk/sub1_mclk/sub2/c3 ;
  wire \mclk/sub1_mclk/sub2/c4 ;
  wire \mclk/sub1_mclk/sub2/c5 ;
  wire \mclk/sub1_mclk/sub2/c6 ;
  wire \mclk/sub1_mclk/sub2/c7 ;
  wire \mclk/sub1_mclk/sub2/c8 ;
  wire \mclk/sub1_mclk/sub2/c9 ;
  wire \mclk/u15_sel_is_3_o ;
  wire mclk_scl_o;  // rtl/stwmst.v(68)
  wire mclk_scl_o_d;
  wire \mctl/add0/c0 ;
  wire \mctl/add0/c1 ;
  wire \mctl/add0/c10 ;
  wire \mctl/add0/c11 ;
  wire \mctl/add0/c12 ;
  wire \mctl/add0/c13 ;
  wire \mctl/add0/c14 ;
  wire \mctl/add0/c15 ;
  wire \mctl/add0/c2 ;
  wire \mctl/add0/c3 ;
  wire \mctl/add0/c4 ;
  wire \mctl/add0/c5 ;
  wire \mctl/add0/c6 ;
  wire \mctl/add0/c7 ;
  wire \mctl/add0/c8 ;
  wire \mctl/add0/c9 ;
  wire \mctl/fsm/mctl_lat_ack_t ;  // rtl/stwm_fsm.v(104)
  wire \mctl/fsm/mctl_lat_rv_t ;  // rtl/stwm_fsm.v(99)
  wire \mctl/fsm/mctl_scl_o_t ;  // rtl/stwm_fsm.v(107)
  wire \mctl/fsm/mctl_sda_o_t ;  // rtl/stwm_fsm.v(109)
  wire \mctl/fsm/mux0_b0_sel_is_3_o ;
  wire \mctl/fsm/mux0_b1_sel_is_3_o ;
  wire \mctl/fsm/mux0_b2_sel_is_3_o ;
  wire \mctl/fsm/mux0_b3_sel_is_3_o ;
  wire \mctl/fsm/mux0_b4_sel_is_3_o ;
  wire \mctl/fsm/n280_lutinv ;
  wire \mctl/fsm/n311 ;
  wire \mctl/fsm/n320 ;
  wire \mctl/fsm/n341 ;
  wire \mctl/fsm/n353 ;
  wire \mctl/fsm/n416 ;
  wire \mctl/fsm/n419 ;
  wire \mctl/mctl_ack_stat ;  // rtl/stwmst.v(263)
  wire \mctl/mctl_bus_bsy ;  // rtl/stwmst.v(398)
  wire \mctl/mctl_dtct_sclf ;  // rtl/stwmst.v(380)
  wire \mctl/mctl_dtct_sta ;  // rtl/stwmst.v(396)
  wire \mctl/mctl_dtct_stp ;  // rtl/stwmst.v(397)
  wire \mctl/mctl_lat_ack ;  // rtl/stwmst.v(533)
  wire \mctl/mctl_mrst ;  // rtl/stwmst.v(269)
  wire \mctl/mctl_mtef ;  // rtl/stwmst.v(264)
  wire \mctl/mctl_scl_o ;  // rtl/stwmst.v(535)
  wire \mctl/mctl_sda_o ;  // rtl/stwmst.v(536)
  wire \mctl/mctl_stwmctl_rd ;  // rtl/stwmst.v(284)
  wire \mctl/mctl_stwmctl_wr ;  // rtl/stwmst.v(268)
  wire \mctl/mux13_b0_sel_is_0_o ;
  wire \mctl/n0 ;
  wire \mctl/n11 ;
  wire \mctl/n13 ;
  wire \mctl/n23 ;
  wire \mctl/n45 ;
  wire \mctl/n47 ;
  wire \mctl/n5 ;
  wire \mctl/n53 ;
  wire \mctl/n56 ;
  wire \mctl/n58 ;
  wire \mctl/n64 ;
  wire \mctl/n65 ;
  wire \mctl/n7 ;
  wire \mctl/n74_lutinv ;
  wire \mctl/n9 ;
  wire \mctl/n93 ;
  wire \mctl/rst_fsm_n ;  // rtl/stwmst.v(511)
  wire \mctl/u73_sel_is_0_o_neg ;
  wire \mctl/u89_sel_is_1_o ;
  wire mctl_bus_err;  // rtl/stwmst.v(76)
  wire mctl_bus_err_d;
  wire mctl_clk_gen;  // rtl/stwmst.v(85)
  wire mctl_dtct_sclr;  // rtl/stwmst.v(83)
  wire mctl_lat_rv;  // rtl/stwmst.v(87)
  wire mctl_mrae;  // rtl/stwmst.v(91)
  wire mctl_rst_sd;  // rtl/stwmst.v(89)
  wire mctl_scl_s;  // rtl/stwmst.v(74)
  wire mctl_sda_s;  // rtl/stwmst.v(75)
  wire mctl_sft_rv_lutinv;  // rtl/stwmst.v(86)
  wire mctl_sft_sd;  // rtl/stwmst.v(88)
  wire mctl_stwmbaud_rd;  // rtl/stwmst.v(79)
  wire mctl_stwmbaud_wr;  // rtl/stwmst.v(82)
  wire mctl_stwmdatr_rd;  // rtl/stwmst.v(77)
  wire mctl_stwmdats_wr;  // rtl/stwmst.v(80)
  wire mctl_stwmreqr_rd;  // rtl/stwmst.v(78)
  wire mctl_stwmreqr_wr;  // rtl/stwmst.v(81)
  wire \mdat/mdat_rcv_nack ;  // rtl/stwmst.v(638)
  wire \mdat/n0 ;
  wire \mdat/n11 ;
  wire \mdat/n12 ;
  wire \mdat/n16 ;
  wire \mdat/n20 ;
  wire \mdat/n28 ;
  wire \mdat/n29 ;
  wire \mdat/n48 ;
  wire mdat_mraf;  // rtl/stwmst.v(62)
  wire mdat_mtaf;  // rtl/stwmst.v(61)
  wire mdat_nak_rv;  // rtl/stwmst.v(67)
  wire mdat_sda_o;  // rtl/stwmst.v(69)
  wire mdat_sta_sd;  // rtl/stwmst.v(66)
  wire mdat_trg_rd;  // rtl/stwmst.v(64)
  wire mdat_trg_sp;  // rtl/stwmst.v(65)
  wire mdat_trg_wr;  // rtl/stwmst.v(63)
  wire mdat_trg_wr_d;
  wire rst_mst_n;  // rtl/stwmst.v(73)
  wire \u1/c0 ;
  wire \u1/c1 ;
  wire \u1/c2 ;
  wire \u1/c3 ;
  wire \u1/c4 ;
  wire \u2/c0 ;
  wire \u2/c1 ;
  wire \u2/c10 ;
  wire \u2/c11 ;
  wire \u2/c12 ;
  wire \u2/c13 ;
  wire \u2/c14 ;
  wire \u2/c15 ;
  wire \u2/c2 ;
  wire \u2/c3 ;
  wire \u2/c4 ;
  wire \u2/c5 ;
  wire \u2/c6 ;
  wire \u2/c7 ;
  wire \u2/c8 ;
  wire \u2/c9 ;

  assign bdatr[15] = 1'b0;
  assign bdatr[14] = bdatr_mclk[14];
  assign bdatr[13] = bdatr_mclk[13];
  assign bdatr[12] = bdatr_mclk[12];
  assign bdatr[11] = bdatr_mclk[11];
  assign bdatr[10] = bdatr_mclk[10];
  assign bdatr[9] = bdatr_mclk[9];
  assign bdatr[8] = bdatr_mclk[8];
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u100 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .o(\mclk/n2_en_al_n132 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u101 (
    .a(\mctl/mctl_sda_o ),
    .b(mdat_sda_o),
    .o(stwm_sda_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u102 (
    .a(\mctl/mctl_mrst ),
    .b(rst_n),
    .o(rst_mst_n));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u103 (
    .a(mctl_bus_err),
    .b(\mctl/mctl_mtef ),
    .c(\mctl/stwmctl [2]),
    .o(stws_mter));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u104 (
    .a(\mctl/mctl_scl_f [2]),
    .b(\mctl/mctl_scl_f [3]),
    .o(\mctl/n47 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u105 (
    .a(\mctl/mctl_scl_f [2]),
    .b(\mctl/mctl_scl_f [3]),
    .o(\mctl/n45 ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*~A))"),
    .INIT(8'hc8))
    _al_u106 (
    .a(mctl_bus_err),
    .b(mctl_mrae),
    .c(mdat_mraf),
    .o(stws_mrar));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u107 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [0]),
    .d(\mdat/mdat_datr_sft [0]),
    .o(\mdat/n7 [0]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u108 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [1]),
    .d(\mdat/mdat_datr_sft [1]),
    .o(\mdat/n7 [1]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u109 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [2]),
    .d(\mdat/mdat_datr_sft [2]),
    .o(\mdat/n7 [2]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u110 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [3]),
    .d(\mdat/mdat_datr_sft [3]),
    .o(\mdat/n7 [3]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u111 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [4]),
    .d(\mdat/mdat_datr_sft [4]),
    .o(\mdat/n7 [4]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u112 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [5]),
    .d(\mdat/mdat_datr_sft [5]),
    .o(\mdat/n7 [5]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u113 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [6]),
    .d(\mdat/mdat_datr_sft [6]),
    .o(\mdat/n7 [6]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u114 (
    .a(mctl_lat_rv),
    .b(mctl_stwmdatr_rd),
    .c(\mdat/stwmdatr [7]),
    .d(\mdat/mdat_datr_sft [7]),
    .o(\mdat/n7 [7]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u115 (
    .a(rst_mst_n),
    .b(mctl_bus_err),
    .o(\mctl/rst_fsm_n ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u116 (
    .a(\mctl/mctl_scl_f [0]),
    .b(\mctl/mctl_scl_f [3]),
    .c(\mctl/mctl_sda_f [1]),
    .d(\mctl/mctl_sda_f [2]),
    .o(\mctl/n53 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u117 (
    .a(\mctl/mctl_scl_f [0]),
    .b(\mctl/mctl_scl_f [3]),
    .c(\mctl/mctl_sda_f [1]),
    .d(\mctl/mctl_sda_f [2]),
    .o(\mctl/n56 ));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u118 (
    .a(mctl_stwmdatr_rd),
    .b(mctl_stwmreqr_rd),
    .c(\mdat/mdat_rcv_nack ),
    .d(\mdat/stwmdatr [1]),
    .o(_al_u118_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u119 (
    .a(_al_u118_o),
    .b(stwmbaud[1]),
    .c(mctl_stwmbaud_rd),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u120 (
    .a(stwmbaud[3]),
    .b(mctl_stwmbaud_rd),
    .c(mctl_stwmdatr_rd),
    .d(\mdat/stwmdatr [3]),
    .o(_al_u120_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u121 (
    .a(_al_u120_o),
    .b(\mctl/mctl_ack_stat ),
    .c(\mctl/mctl_stwmctl_rd ),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u122 (
    .a(stwmbaud[4]),
    .b(mctl_stwmbaud_rd),
    .c(mctl_stwmdatr_rd),
    .d(\mdat/stwmdatr [4]),
    .o(_al_u122_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u123 (
    .a(_al_u122_o),
    .b(\mctl/mctl_stwmctl_rd ),
    .c(mdat_mraf),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u124 (
    .a(stwmbaud[5]),
    .b(mctl_stwmbaud_rd),
    .c(mctl_stwmdatr_rd),
    .d(\mdat/stwmdatr [5]),
    .o(_al_u124_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u125 (
    .a(_al_u124_o),
    .b(\mctl/mctl_stwmctl_rd ),
    .c(mdat_mtaf),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u126 (
    .a(stwmbaud[6]),
    .b(mctl_stwmbaud_rd),
    .c(mctl_stwmdatr_rd),
    .d(\mdat/stwmdatr [6]),
    .o(_al_u126_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u127 (
    .a(_al_u126_o),
    .b(\mctl/mctl_mtef ),
    .c(\mctl/mctl_stwmctl_rd ),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u128 (
    .a(stwmbaud[7]),
    .b(mctl_stwmbaud_rd),
    .c(mctl_stwmdatr_rd),
    .d(\mdat/stwmdatr [7]),
    .o(_al_u128_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u129 (
    .a(_al_u128_o),
    .b(mctl_bus_err),
    .c(\mctl/mctl_stwmctl_rd ),
    .o(bdatr[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u130 (
    .a(bcmdw),
    .b(bcs_stws_n),
    .c(brdy),
    .o(\mctl/n23 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u131 (
    .a(\mctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\mctl/mctl_stwmctl_wr ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u132 (
    .a(bcmdr),
    .b(bcs_stws_n),
    .o(\mctl/n5 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u133 (
    .a(\mctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\mctl/n7 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u134 (
    .a(stwmbaud[0]),
    .b(mctl_stwmbaud_rd),
    .c(\mctl/mctl_stwmctl_rd ),
    .d(mctl_mrae),
    .o(_al_u134_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'hfddd7555))
    _al_u135 (
    .a(_al_u134_o),
    .b(mctl_stwmdatr_rd),
    .c(mctl_stwmreqr_rd),
    .d(mdat_trg_rd),
    .e(\mdat/stwmdatr [0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u136 (
    .a(stwmbaud[2]),
    .b(mctl_stwmbaud_rd),
    .c(\mctl/mctl_stwmctl_rd ),
    .d(\mctl/stwmctl [2]),
    .o(_al_u136_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'hfddd7555))
    _al_u137 (
    .a(_al_u136_o),
    .b(mctl_stwmdatr_rd),
    .c(mctl_stwmreqr_rd),
    .d(mdat_trg_sp),
    .e(\mdat/stwmdatr [2]),
    .o(bdatr[2]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u138 (
    .a(\mctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\mctl/n11 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u139 (
    .a(\mctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(mctl_stwmbaud_wr));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u140 (
    .a(\mctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\mctl/n13 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u141 (
    .a(\mctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(mctl_stwmdats_wr));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u142 (
    .a(\mctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\mctl/n9 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u143 (
    .a(\mctl/mctl_stwmctl_wr ),
    .b(bdatw[15]),
    .o(\mctl/n0 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u144 (
    .a(\mctl/synfil_scl [3]),
    .b(\mctl/synfil_scl [4]),
    .c(\mctl/synfil_sda [3]),
    .d(\mctl/synfil_sda [4]),
    .o(_al_u144_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*~B*A)"),
    .INIT(16'hdfff))
    _al_u145 (
    .a(_al_u144_o),
    .b(\mctl/mctl_dtct_sta ),
    .c(\mctl/synfil_scl [2]),
    .d(\mctl/synfil_sda [2]),
    .o(\mctl/n58 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u146 (
    .a(\mctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(mctl_stwmreqr_wr));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u147 (
    .a(mctl_stwmreqr_wr),
    .b(bdatw[2]),
    .o(\mdat/n20 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u148 (
    .a(mctl_stwmreqr_wr),
    .b(bdatw[1]),
    .o(\mdat/n16 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u149 (
    .a(mctl_stwmreqr_wr),
    .b(bdatw[0]),
    .o(\mdat/n12 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u150 (
    .a(mctl_stwmdats_wr),
    .b(mdat_trg_wr),
    .o(mdat_trg_wr_d));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u151 (
    .a(\mctl/n58 ),
    .b(\mctl/mctl_dtct_stp ),
    .o(\mclk/n2_en_al_n128 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u152 (
    .a(\mdat/n16 ),
    .b(mctl_lat_rv),
    .o(\mclk/n2_en_al_n134 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u153 (
    .a(\mdat/n12 ),
    .b(mctl_lat_rv),
    .o(\mclk/n2_en_al_n136 ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u154 (
    .a(\mctl/mctl_stwmctl_wr ),
    .b(rst_mst_n),
    .c(bdatw[7]),
    .o(\mctl/u89_sel_is_1_o ));
  AL_MAP_LUT3 #(
    .EQN("(A*B*~(C)+A*~(B)*C+~(A)*B*C+A*B*C)"),
    .INIT(8'he8))
    _al_u155 (
    .a(\mctl/synfil_scl [2]),
    .b(\mctl/synfil_scl [3]),
    .c(\mctl/synfil_scl [4]),
    .o(mctl_scl_s));
  AL_MAP_LUT3 #(
    .EQN("(~(A)*~(B)*~(C)+A*~(B)*~(C)+~(A)*B*~(C)+~(A)*~(B)*C)"),
    .INIT(8'h17))
    _al_u156 (
    .a(\mctl/synfil_sda [2]),
    .b(\mctl/synfil_sda [3]),
    .c(\mctl/synfil_sda [4]),
    .o(\mctl/n65 ));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u157 (
    .a(\mclk/tscl_l [13]),
    .b(\mclk/tscl_l [12]),
    .c(\mclk/lcnt [12]),
    .d(\mclk/lcnt [13]),
    .o(_al_u157_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u158 (
    .a(_al_u157_o),
    .b(\mclk/tscl_l [15]),
    .c(\mclk/tscl_l [14]),
    .d(\mclk/lcnt [14]),
    .e(\mclk/lcnt [15]),
    .o(_al_u158_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u159 (
    .a(\mclk/tscl_l [9]),
    .b(\mclk/tscl_l [8]),
    .c(\mclk/lcnt [8]),
    .d(\mclk/lcnt [9]),
    .o(_al_u159_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u160 (
    .a(_al_u159_o),
    .b(\mclk/tscl_l [11]),
    .c(\mclk/tscl_l [10]),
    .d(\mclk/lcnt [10]),
    .e(\mclk/lcnt [11]),
    .o(_al_u160_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u161 (
    .a(\mclk/tscl_l [5]),
    .b(\mclk/tscl_l [4]),
    .c(\mclk/lcnt [4]),
    .d(\mclk/lcnt [5]),
    .o(_al_u161_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u162 (
    .a(_al_u161_o),
    .b(\mclk/tscl_l [7]),
    .c(\mclk/tscl_l [6]),
    .d(\mclk/lcnt [6]),
    .e(\mclk/lcnt [7]),
    .o(_al_u162_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u163 (
    .a(\mclk/tscl_l [1]),
    .b(\mclk/tscl_l [0]),
    .c(\mclk/lcnt [0]),
    .d(\mclk/lcnt [1]),
    .o(_al_u163_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u164 (
    .a(_al_u163_o),
    .b(\mclk/tscl_l [3]),
    .c(\mclk/tscl_l [2]),
    .d(\mclk/lcnt [2]),
    .e(\mclk/lcnt [3]),
    .o(_al_u164_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u165 (
    .a(_al_u158_o),
    .b(_al_u160_o),
    .c(_al_u162_o),
    .d(_al_u164_o),
    .o(_al_u165_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u166 (
    .a(_al_u165_o),
    .b(mclk_scl_o),
    .o(mclk_scl_o_d));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u167 (
    .a(_al_u165_o),
    .b(mctl_scl_s),
    .c(\mclk/mclk_start_cnt ),
    .o(\mclk/mux4_b0_sel_is_2_o ));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u168 (
    .a(n1[4]),
    .b(n1[3]),
    .c(\mclk/hcnt [6]),
    .d(\mclk/hcnt [7]),
    .o(_al_u168_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u169 (
    .a(_al_u168_o),
    .b(n1[10]),
    .c(n1[9]),
    .d(\mclk/hcnt [12]),
    .e(\mclk/hcnt [13]),
    .o(_al_u169_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u170 (
    .a(n1[8]),
    .b(n1[7]),
    .c(\mclk/hcnt [10]),
    .d(\mclk/hcnt [11]),
    .o(_al_u170_o));
  AL_MAP_LUT5 #(
    .EQN("(B*A*(~(C)*~(D)*~(E)+C*D*E))"),
    .INIT(32'h80000008))
    _al_u171 (
    .a(_al_u169_o),
    .b(_al_u170_o),
    .c(n1[11]),
    .d(\mclk/hcnt [14]),
    .e(\mclk/hcnt [15]),
    .o(_al_u171_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u172 (
    .a(\mclk/hcnt [0]),
    .b(\mclk/hcnt [1]),
    .c(stwmbaud[1]),
    .d(stwmbaud[2]),
    .o(_al_u172_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u173 (
    .a(_al_u172_o),
    .b(n1[2]),
    .c(n1[1]),
    .d(\mclk/hcnt [4]),
    .e(\mclk/hcnt [5]),
    .o(_al_u173_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u174 (
    .a(n1[6]),
    .b(n1[5]),
    .c(\mclk/hcnt [8]),
    .d(\mclk/hcnt [9]),
    .o(_al_u174_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u175 (
    .a(n1[0]),
    .b(\mclk/hcnt [2]),
    .c(\mclk/hcnt [3]),
    .d(stwmbaud[3]),
    .o(_al_u175_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u176 (
    .a(_al_u171_o),
    .b(_al_u173_o),
    .c(_al_u174_o),
    .d(_al_u175_o),
    .o(_al_u176_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u177 (
    .a(_al_u176_o),
    .b(_al_u165_o),
    .c(mctl_scl_s),
    .o(\mclk/mux7_b0_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u178 (
    .a(\mctl/fsm/stat [0]),
    .b(\mctl/fsm/stat [1]),
    .o(_al_u178_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~(~B*A))"),
    .INIT(32'h000d0000))
    _al_u179 (
    .a(_al_u178_o),
    .b(\mctl/fsm/stat [2]),
    .c(\mctl/fsm/stat [3]),
    .d(\mctl/fsm/stat [4]),
    .e(\mctl/mctl_dtct_sclf ),
    .o(mctl_sft_sd));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u180 (
    .a(\mctl/fsm/stat [2]),
    .b(\mctl/fsm/stat [3]),
    .c(\mctl/fsm/stat [4]),
    .o(_al_u180_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*A*(D@B))"),
    .INIT(16'h0208))
    _al_u181 (
    .a(_al_u180_o),
    .b(\mctl/fsm/stat [0]),
    .c(\mctl/fsm/stat [1]),
    .d(\mctl/mctl_dtct_sclf ),
    .o(\mctl/fsm/mctl_lat_ack_t ));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u182 (
    .a(\mdat/mdat_dats_sft [4]),
    .b(\mdat/mdat_dats_sft [7]),
    .c(\mdat/mdat_dats [4]),
    .d(\mdat/mdat_dats [7]),
    .o(_al_u182_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u183 (
    .a(_al_u182_o),
    .b(\mdat/mdat_dats_sft [1]),
    .c(\mdat/mdat_dats_sft [2]),
    .d(\mdat/mdat_dats [1]),
    .e(\mdat/mdat_dats [2]),
    .o(_al_u183_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u184 (
    .a(_al_u183_o),
    .b(\mdat/mdat_dats_sft [0]),
    .c(\mdat/mdat_dats_sft [3]),
    .d(\mdat/mdat_dats [0]),
    .e(\mdat/mdat_dats [3]),
    .o(_al_u184_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u185 (
    .a(_al_u184_o),
    .b(\mdat/mdat_dats_sft [5]),
    .c(\mdat/mdat_dats_sft [6]),
    .d(\mdat/mdat_dats [5]),
    .e(\mdat/mdat_dats [6]),
    .o(_al_u185_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~A*~(D@(~C*B)))"),
    .INIT(32'h00000451))
    _al_u186 (
    .a(_al_u185_o),
    .b(_al_u178_o),
    .c(\mctl/fsm/stat [2]),
    .d(\mctl/fsm/stat [3]),
    .e(\mctl/fsm/stat [4]),
    .o(\mdat/n48 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u187 (
    .a(\mctl/tcnt [8]),
    .b(\mctl/tcnt [9]),
    .c(\mctl/tcnt_cmp [8]),
    .d(\mctl/tcnt_cmp [9]),
    .o(_al_u187_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u188 (
    .a(_al_u187_o),
    .b(\mctl/tcnt [14]),
    .c(\mctl/tcnt [15]),
    .d(\mctl/tcnt_cmp [14]),
    .e(\mctl/tcnt_cmp [15]),
    .o(_al_u188_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u189 (
    .a(\mctl/tcnt [4]),
    .b(\mctl/tcnt [5]),
    .c(\mctl/tcnt_cmp [4]),
    .d(\mctl/tcnt_cmp [5]),
    .o(_al_u189_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u190 (
    .a(_al_u189_o),
    .b(\mctl/tcnt [0]),
    .c(\mctl/tcnt [1]),
    .d(\mctl/tcnt_cmp [0]),
    .e(\mctl/tcnt_cmp [1]),
    .o(_al_u190_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u191 (
    .a(\mctl/tcnt [10]),
    .b(\mctl/tcnt [11]),
    .c(\mctl/tcnt_cmp [10]),
    .d(\mctl/tcnt_cmp [11]),
    .o(_al_u191_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u192 (
    .a(_al_u191_o),
    .b(\mctl/tcnt [12]),
    .c(\mctl/tcnt [13]),
    .d(\mctl/tcnt_cmp [12]),
    .e(\mctl/tcnt_cmp [13]),
    .o(_al_u192_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u193 (
    .a(\mctl/tcnt [2]),
    .b(\mctl/tcnt [3]),
    .c(\mctl/tcnt_cmp [2]),
    .d(\mctl/tcnt_cmp [3]),
    .o(_al_u193_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u194 (
    .a(_al_u193_o),
    .b(\mctl/tcnt [6]),
    .c(\mctl/tcnt [7]),
    .d(\mctl/tcnt_cmp [6]),
    .e(\mctl/tcnt_cmp [7]),
    .o(_al_u194_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u195 (
    .a(_al_u188_o),
    .b(_al_u190_o),
    .c(_al_u192_o),
    .d(_al_u194_o),
    .o(_al_u195_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u196 (
    .a(\mctl/fsm/stat [2]),
    .b(\mctl/fsm/stat [3]),
    .c(\mctl/fsm/stat [4]),
    .o(_al_u196_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u197 (
    .a(_al_u196_o),
    .b(\mctl/fsm/stat [0]),
    .c(\mctl/fsm/stat [1]),
    .o(_al_u197_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u198 (
    .a(_al_u195_o),
    .b(_al_u197_o),
    .o(_al_u198_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u199 (
    .a(_al_u198_o),
    .b(\mdat/n20 ),
    .o(\mclk/n2_en_al_n138 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u200 (
    .a(_al_u198_o),
    .b(\mctl/n64 ),
    .o(\mctl/u73_sel_is_0_o_neg ));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u201 (
    .a(\mctl/u73_sel_is_0_o_neg ),
    .b(\mctl/mctl_stwmctl_wr ),
    .c(bdatw[6]),
    .o(\mclk/n2_en_al_n130 ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u202 (
    .a(\mctl/fsm/stat [2]),
    .b(\mctl/fsm/stat [3]),
    .c(\mctl/fsm/stat [4]),
    .o(_al_u202_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u203 (
    .a(_al_u202_o),
    .b(_al_u178_o),
    .c(\mctl/mctl_dtct_sclf ),
    .o(\mctl/fsm/mctl_lat_rv_t ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~(C@(~B*A)))"),
    .INIT(32'h00002d00))
    _al_u204 (
    .a(_al_u178_o),
    .b(\mctl/fsm/stat [2]),
    .c(\mctl/fsm/stat [3]),
    .d(\mctl/fsm/stat [4]),
    .e(\mctl/mctl_dtct_sclf ),
    .o(mctl_sft_rv_lutinv));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u205 (
    .a(mctl_sft_rv_lutinv),
    .b(mctl_dtct_sclr),
    .o(\mdat/n0 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u206 (
    .a(_al_u196_o),
    .b(_al_u178_o),
    .o(_al_u206_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u207 (
    .a(\mctl/fsm/stat [2]),
    .b(\mctl/fsm/stat [3]),
    .c(\mctl/fsm/stat [4]),
    .o(_al_u207_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u208 (
    .a(_al_u207_o),
    .b(_al_u178_o),
    .o(_al_u208_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~B*A*~(~D*~C))"),
    .INIT(32'h00002220))
    _al_u209 (
    .a(_al_u208_o),
    .b(\mctl/mctl_bus_bsy ),
    .c(mdat_trg_rd),
    .d(mdat_trg_sp),
    .e(mdat_trg_wr),
    .o(_al_u209_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u210 (
    .a(\mctl/fsm/stat [1]),
    .b(\mctl/fsm/stat [2]),
    .c(\mctl/fsm/stat [3]),
    .o(_al_u210_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*B*A*~(~D*~C))"),
    .INIT(32'h00008880))
    _al_u211 (
    .a(_al_u210_o),
    .b(\mctl/fsm/stat [0]),
    .c(mdat_trg_rd),
    .d(mdat_trg_sp),
    .e(mdat_trg_wr),
    .o(_al_u211_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u212 (
    .a(\mctl/fsm/stat [2]),
    .b(\mctl/fsm/stat [3]),
    .o(_al_u212_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u213 (
    .a(_al_u212_o),
    .b(\mctl/fsm/stat [4]),
    .o(_al_u213_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u214 (
    .a(\mctl/fsm/stat [2]),
    .b(\mctl/fsm/stat [3]),
    .c(\mctl/fsm/stat [4]),
    .o(_al_u214_o));
  AL_MAP_LUT4 #(
    .EQN("(~(~D*~C)*~(~B*~A))"),
    .INIT(16'heee0))
    _al_u215 (
    .a(_al_u213_o),
    .b(_al_u214_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .o(_al_u215_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u216 (
    .a(_al_u206_o),
    .b(_al_u209_o),
    .c(_al_u211_o),
    .d(_al_u215_o),
    .e(_al_u213_o),
    .o(_al_u216_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u217 (
    .a(\mctl/fsm/stat [2]),
    .b(\mctl/fsm/stat [3]),
    .c(\mctl/fsm/stat [4]),
    .o(_al_u217_o));
  AL_MAP_LUT5 #(
    .EQN("(~((B*~A))*~(C)*~(D)*~(E)+~((B*~A))*C*~(D)*~(E)+~((B*~A))*~(C)*D*~(E)+(B*~A)*~(C)*D*~(E)+~((B*~A))*C*D*~(E)+(B*~A)*C*D*~(E)+~((B*~A))*~(C)*~(D)*E+(B*~A)*~(C)*~(D)*E+~((B*~A))*C*~(D)*E+(B*~A)*C*~(D)*E+~((B*~A))*~(C)*D*E+(B*~A)*~(C)*D*E)"),
    .INIT(32'h0fffffbb))
    _al_u218 (
    .a(_al_u195_o),
    .b(_al_u214_o),
    .c(_al_u217_o),
    .d(\mctl/fsm/stat [0]),
    .e(\mctl/fsm/stat [1]),
    .o(_al_u218_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~B*~(~D*~C)))"),
    .INIT(16'h888a))
    _al_u219 (
    .a(_al_u216_o),
    .b(_al_u218_o),
    .c(_al_u195_o),
    .d(_al_u178_o),
    .o(_al_u219_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(C*(~(B)*D*~(E)+B*D*~(E)+~(B)*~(D)*E)))"),
    .INIT(32'haa8a0aaa))
    _al_u220 (
    .a(_al_u219_o),
    .b(_al_u195_o),
    .c(_al_u196_o),
    .d(\mctl/fsm/stat [0]),
    .e(\mctl/fsm/stat [1]),
    .o(_al_u220_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u221 (
    .a(mdat_trg_rd),
    .b(mdat_trg_wr),
    .o(_al_u221_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u222 (
    .a(_al_u221_o),
    .b(\mctl/fsm/stat [0]),
    .c(mdat_trg_sp),
    .o(_al_u222_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*C*~A))"),
    .INIT(16'h8ccc))
    _al_u223 (
    .a(_al_u222_o),
    .b(_al_u202_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .o(_al_u223_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*A))"),
    .INIT(8'hd0))
    _al_u224 (
    .a(_al_u220_o),
    .b(_al_u223_o),
    .c(\mctl/rst_fsm_n ),
    .o(\mctl/fsm/mux0_b4_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u225 (
    .a(_al_u195_o),
    .b(\mctl/fsm/stat [0]),
    .c(\mctl/fsm/stat [1]),
    .o(_al_u225_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u226 (
    .a(_al_u225_o),
    .b(_al_u217_o),
    .o(\mctl/fsm/n353 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u227 (
    .a(_al_u207_o),
    .b(\mctl/fsm/stat [1]),
    .o(_al_u227_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u228 (
    .a(\mctl/fsm/stat [0]),
    .b(\mctl/mctl_bus_bsy ),
    .o(_al_u228_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~E*D*C*B))"),
    .INIT(32'h55551555))
    _al_u229 (
    .a(\mctl/fsm/n353 ),
    .b(_al_u227_o),
    .c(_al_u228_o),
    .d(mdat_trg_wr),
    .e(mdat_sta_sd),
    .o(_al_u229_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(~E*D*C*B))"),
    .INIT(32'h5555d555))
    _al_u230 (
    .a(_al_u229_o),
    .b(_al_u210_o),
    .c(\mctl/fsm/stat [0]),
    .d(mdat_trg_wr),
    .e(mdat_sta_sd),
    .o(mctl_rst_sd));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'he3ef))
    _al_u231 (
    .a(_al_u195_o),
    .b(\mctl/fsm/stat [0]),
    .c(\mctl/fsm/stat [1]),
    .d(\mctl/mctl_dtct_sclf ),
    .o(_al_u231_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u232 (
    .a(_al_u210_o),
    .b(\mctl/fsm/stat [4]),
    .o(_al_u232_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u233 (
    .a(_al_u195_o),
    .b(_al_u232_o),
    .c(\mctl/fsm/stat [0]),
    .o(\mctl/fsm/n416 ));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*~A))"),
    .INIT(8'h23))
    _al_u234 (
    .a(_al_u231_o),
    .b(\mctl/fsm/n416 ),
    .c(_al_u180_o),
    .o(_al_u234_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u235 (
    .a(_al_u210_o),
    .b(\mctl/fsm/stat [0]),
    .c(mdat_trg_wr),
    .d(mdat_sta_sd),
    .o(_al_u235_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D*C*B))"),
    .INIT(32'h15555555))
    _al_u236 (
    .a(_al_u235_o),
    .b(_al_u210_o),
    .c(_al_u221_o),
    .d(\mctl/fsm/stat [0]),
    .e(mdat_trg_sp),
    .o(_al_u236_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u237 (
    .a(_al_u232_o),
    .b(_al_u222_o),
    .o(\mctl/fsm/n419 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u238 (
    .a(\mctl/fsm/n419 ),
    .b(\mctl/fsm/mctl_lat_ack_t ),
    .o(_al_u238_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E)"),
    .INIT(32'h3ffffff5))
    _al_u239 (
    .a(_al_u180_o),
    .b(_al_u212_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .e(\mctl/mctl_dtct_sclf ),
    .o(_al_u239_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u240 (
    .a(_al_u234_o),
    .b(_al_u223_o),
    .c(_al_u236_o),
    .d(_al_u238_o),
    .e(_al_u239_o),
    .o(_al_u240_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*(A*B*~(C)*~(D)+A*B*C*~(D)+~(A)*~(B)*C*D+~(A)*B*C*D))"),
    .INIT(32'h00005088))
    _al_u241 (
    .a(_al_u195_o),
    .b(_al_u214_o),
    .c(_al_u217_o),
    .d(\mctl/fsm/stat [0]),
    .e(\mctl/fsm/stat [1]),
    .o(_al_u241_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u242 (
    .a(_al_u227_o),
    .b(_al_u228_o),
    .c(mdat_trg_wr),
    .d(mdat_sta_sd),
    .o(\mctl/fsm/n320 ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(~E*D*C))"),
    .INIT(32'h11110111))
    _al_u243 (
    .a(_al_u241_o),
    .b(\mctl/fsm/n320 ),
    .c(_al_u217_o),
    .d(_al_u178_o),
    .e(\mctl/mctl_bus_bsy ),
    .o(_al_u243_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*C*~(D)+~(A)*~(C)*D))"),
    .INIT(16'h0480))
    _al_u244 (
    .a(_al_u195_o),
    .b(_al_u217_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .o(_al_u244_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u245 (
    .a(\mctl/fsm/stat [0]),
    .b(\mctl/fsm/stat [1]),
    .o(_al_u245_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u246 (
    .a(_al_u195_o),
    .b(_al_u217_o),
    .c(_al_u245_o),
    .o(_al_u246_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u247 (
    .a(_al_u208_o),
    .b(_al_u221_o),
    .c(\mctl/mctl_bus_bsy ),
    .d(mdat_trg_sp),
    .o(\mctl/fsm/n311 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u248 (
    .a(_al_u243_o),
    .b(_al_u244_o),
    .c(_al_u246_o),
    .d(\mctl/fsm/n311 ),
    .o(_al_u248_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*~(~C*~A)))"),
    .INIT(16'h04cc))
    _al_u249 (
    .a(_al_u195_o),
    .b(_al_u196_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .o(_al_u249_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*B*A))"),
    .INIT(16'hf700))
    _al_u250 (
    .a(_al_u240_o),
    .b(_al_u248_o),
    .c(_al_u249_o),
    .d(\mctl/rst_fsm_n ),
    .o(\mctl/fsm/mux0_b3_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u251 (
    .a(\mctl/fsm/stat [0]),
    .b(\mctl/mctl_dtct_sclf ),
    .o(_al_u251_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*(C@(B*A)))"),
    .INIT(16'h0078))
    _al_u252 (
    .a(_al_u251_o),
    .b(\mctl/fsm/stat [1]),
    .c(\mctl/fsm/stat [2]),
    .d(\mctl/fsm/stat [3]),
    .o(_al_u252_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~D*C*~B*A))"),
    .INIT(32'hffdf0000))
    _al_u253 (
    .a(_al_u248_o),
    .b(_al_u249_o),
    .c(_al_u236_o),
    .d(_al_u252_o),
    .e(\mctl/rst_fsm_n ),
    .o(\mctl/fsm/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*~A))"),
    .INIT(8'hc8))
    _al_u254 (
    .a(_al_u225_o),
    .b(_al_u210_o),
    .c(_al_u222_o),
    .o(_al_u254_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*(B@A))"),
    .INIT(8'h06))
    _al_u255 (
    .a(_al_u251_o),
    .b(\mctl/fsm/stat [1]),
    .c(\mctl/fsm/stat [3]),
    .o(_al_u255_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u256 (
    .a(_al_u254_o),
    .b(_al_u246_o),
    .c(_al_u255_o),
    .o(_al_u256_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u257 (
    .a(_al_u231_o),
    .b(\mctl/fsm/stat [2]),
    .c(\mctl/fsm/stat [3]),
    .o(\mctl/n74_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*C*~(D)+~(A)*~(C)*D))"),
    .INIT(16'h0480))
    _al_u258 (
    .a(_al_u195_o),
    .b(_al_u196_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .o(_al_u258_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u259 (
    .a(_al_u258_o),
    .b(_al_u235_o),
    .o(_al_u259_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~D*C*~B*A))"),
    .INIT(32'hffdf0000))
    _al_u260 (
    .a(_al_u256_o),
    .b(\mctl/n74_lutinv ),
    .c(_al_u259_o),
    .d(_al_u244_o),
    .e(\mctl/rst_fsm_n ),
    .o(\mctl/fsm/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(B*A*~(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D))"),
    .INIT(32'h00808880))
    _al_u261 (
    .a(_al_u227_o),
    .b(_al_u228_o),
    .c(mdat_trg_rd),
    .d(mdat_trg_wr),
    .e(mdat_sta_sd),
    .o(\mctl/fsm/n280_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~C*A*(D@B))"),
    .INIT(16'h0208))
    _al_u262 (
    .a(_al_u202_o),
    .b(\mctl/fsm/stat [0]),
    .c(\mctl/fsm/stat [1]),
    .d(\mctl/mctl_dtct_sclf ),
    .o(_al_u262_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u263 (
    .a(\mctl/fsm/n280_lutinv ),
    .b(_al_u262_o),
    .c(_al_u235_o),
    .o(_al_u263_o));
  AL_MAP_LUT5 #(
    .EQN("(B*A*~(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D))"),
    .INIT(32'h00808880))
    _al_u264 (
    .a(_al_u210_o),
    .b(\mctl/fsm/stat [0]),
    .c(mdat_trg_rd),
    .d(mdat_trg_wr),
    .e(mdat_sta_sd),
    .o(_al_u264_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hf31f))
    _al_u265 (
    .a(_al_u227_o),
    .b(_al_u212_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/mctl_dtct_sclf ),
    .o(_al_u265_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf1ff1f3f))
    _al_u266 (
    .a(_al_u207_o),
    .b(_al_u214_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .e(\mctl/mctl_dtct_sclf ),
    .o(_al_u266_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u267 (
    .a(_al_u238_o),
    .b(_al_u263_o),
    .c(_al_u264_o),
    .d(_al_u265_o),
    .e(_al_u266_o),
    .o(_al_u267_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u268 (
    .a(_al_u195_o),
    .b(_al_u217_o),
    .c(_al_u178_o),
    .d(\mctl/mctl_bus_bsy ),
    .o(\mctl/fsm/n341 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*~A)"),
    .INIT(16'h0004))
    _al_u269 (
    .a(_al_u254_o),
    .b(_al_u267_o),
    .c(_al_u246_o),
    .d(\mctl/fsm/n341 ),
    .o(_al_u269_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*B*(C@A))"),
    .INIT(16'h0048))
    _al_u270 (
    .a(_al_u195_o),
    .b(_al_u196_o),
    .c(\mctl/fsm/stat [0]),
    .d(\mctl/fsm/stat [1]),
    .o(_al_u270_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(~E*~C*~B*A))"),
    .INIT(32'hff00fd00))
    _al_u271 (
    .a(_al_u269_o),
    .b(\mctl/fsm/n353 ),
    .c(_al_u241_o),
    .d(\mctl/rst_fsm_n ),
    .e(_al_u270_o),
    .o(\mctl/fsm/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u272 (
    .a(mctl_rst_sd),
    .b(rst_mst_n),
    .o(\mdat/n28 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u273 (
    .a(mctl_rst_sd),
    .b(\mctl/rst_fsm_n ),
    .o(\mdat/n29 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C@(~B*A)))"),
    .INIT(16'h2d00))
    _al_u274 (
    .a(_al_u178_o),
    .b(\mctl/fsm/stat [2]),
    .c(\mctl/fsm/stat [3]),
    .d(\mctl/mctl_dtct_sclf ),
    .o(_al_u274_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u275 (
    .a(_al_u264_o),
    .b(_al_u274_o),
    .o(_al_u275_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*B*~A)"),
    .INIT(8'hfb))
    _al_u276 (
    .a(\mctl/fsm/n353 ),
    .b(_al_u275_o),
    .c(\mctl/fsm/n280_lutinv ),
    .o(mctl_clk_gen));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u277 (
    .a(\mctl/fsm/stat [1]),
    .b(_al_u196_o),
    .o(_al_u277_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*~(~D*~(~E*C))))"),
    .INIT(32'h11551115))
    _al_u278 (
    .a(\mctl/fsm/n320 ),
    .b(_al_u208_o),
    .c(_al_u221_o),
    .d(\mctl/mctl_bus_bsy ),
    .e(mdat_trg_sp),
    .o(_al_u278_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~A*~(D*C))"),
    .INIT(16'h0444))
    _al_u279 (
    .a(_al_u270_o),
    .b(_al_u278_o),
    .c(_al_u217_o),
    .d(_al_u178_o),
    .o(_al_u279_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h5fffaf33))
    _al_u280 (
    .a(_al_u195_o),
    .b(_al_u214_o),
    .c(_al_u217_o),
    .d(\mctl/fsm/stat [0]),
    .e(\mctl/fsm/stat [1]),
    .o(_al_u280_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*B*~A)"),
    .INIT(16'hfbff))
    _al_u281 (
    .a(_al_u277_o),
    .b(_al_u279_o),
    .c(_al_u258_o),
    .d(_al_u280_o),
    .o(\mctl/fsm/mctl_scl_o_t ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u282 (
    .a(mctl_clk_gen),
    .b(rst_mst_n),
    .o(\mclk/n9 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u283 (
    .a(mctl_clk_gen),
    .b(_al_u165_o),
    .o(\mclk/n2_en ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*C*B))"),
    .INIT(16'h5515))
    _al_u284 (
    .a(\mctl/fsm/mctl_lat_ack_t ),
    .b(_al_u202_o),
    .c(_al_u178_o),
    .d(\mctl/mctl_dtct_sclf ),
    .o(_al_u284_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~((D*C))*~(B)+E*(D*C)*~(B)+~(E)*(D*C)*B+E*(D*C)*B))"),
    .INIT(32'h08882aaa))
    _al_u285 (
    .a(_al_u284_o),
    .b(_al_u217_o),
    .c(_al_u178_o),
    .d(\mctl/mctl_bus_bsy ),
    .e(_al_u213_o),
    .o(_al_u285_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*A*~(E*D))"),
    .INIT(32'h00080808))
    _al_u286 (
    .a(_al_u278_o),
    .b(_al_u285_o),
    .c(_al_u215_o),
    .d(_al_u262_o),
    .e(mdat_nak_rv),
    .o(_al_u286_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*C*~B))"),
    .INIT(16'h8aaa))
    _al_u287 (
    .a(_al_u286_o),
    .b(_al_u195_o),
    .c(_al_u217_o),
    .d(_al_u178_o),
    .o(_al_u287_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*~A)"),
    .INIT(16'hbfff))
    _al_u288 (
    .a(_al_u277_o),
    .b(_al_u287_o),
    .c(_al_u259_o),
    .d(_al_u218_o),
    .o(\mctl/fsm/mctl_sda_o_t ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u289 (
    .a(\mclk/n9 ),
    .b(_al_u176_o),
    .o(\mclk/u15_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~D*(~((~B*A))*~(C)*~(E)+(~B*A)*C*~(E)+~((~B*A))*~(C)*E))"),
    .INIT(32'h000d002d))
    _al_u290 (
    .a(_al_u178_o),
    .b(\mctl/fsm/stat [2]),
    .c(\mctl/fsm/stat [3]),
    .d(\mctl/fsm/stat [4]),
    .e(\mctl/mctl_dtct_sclf ),
    .o(_al_u290_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*~B*~A))"),
    .INIT(16'hfe00))
    _al_u291 (
    .a(mctl_rst_sd),
    .b(_al_u262_o),
    .c(_al_u290_o),
    .d(mctl_dtct_sclr),
    .o(\mctl/n93 ));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(C*B*A))"),
    .INIT(16'hff80))
    _al_u292 (
    .a(\mctl/n93 ),
    .b(\mctl/n65 ),
    .c(stwm_sda_o),
    .d(mctl_bus_err),
    .o(mctl_bus_err_d));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u293 (
    .a(_al_u218_o),
    .b(_al_u236_o),
    .c(_al_u197_o),
    .d(_al_u206_o),
    .o(_al_u293_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u294 (
    .a(_al_u293_o),
    .b(_al_u243_o),
    .c(_al_u244_o),
    .d(_al_u258_o),
    .e(\mctl/fsm/n311 ),
    .o(\mctl/n84 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~(~B*A))"),
    .INIT(16'h0d00))
    _al_u295 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(_al_u195_o),
    .d(rst_mst_n),
    .o(\mctl/mux13_b0_sel_is_0_o ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u296 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[9]),
    .o(\mctl/tcnt_cmp_t [10]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u297 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[8]),
    .o(\mctl/tcnt_cmp_t [9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u298 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[7]),
    .o(\mctl/tcnt_cmp_t [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u299 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[6]),
    .o(\mctl/tcnt_cmp_t [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u300 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[3]),
    .o(\mctl/tcnt_cmp_t [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u301 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[2]),
    .o(\mctl/tcnt_cmp_t [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u302 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[14]),
    .o(\mctl/tcnt_cmp_t [15]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u303 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[13]),
    .o(\mctl/tcnt_cmp_t [14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u304 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[12]),
    .o(\mctl/tcnt_cmp_t [13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u305 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[11]),
    .o(\mctl/tcnt_cmp_t [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u306 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[10]),
    .o(\mctl/tcnt_cmp_t [11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u307 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[1]),
    .o(\mctl/tcnt_cmp_t [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u308 (
    .a(\mctl/n84 [0]),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[0]),
    .o(\mctl/tcnt_cmp_t [1]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*~A)"),
    .INIT(16'h0100))
    _al_u309 (
    .a(\mctl/n84 [0]),
    .b(_al_u270_o),
    .c(\mctl/fsm/n341 ),
    .d(_al_u280_o),
    .o(_al_u309_o));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))"),
    .INIT(16'hfeae))
    _al_u310 (
    .a(_al_u309_o),
    .b(\mctl/n84 [0]),
    .c(\mctl/n74_lutinv ),
    .d(stwmbaud[5]),
    .o(\mctl/tcnt_cmp_t [6]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*B))"),
    .INIT(8'h51))
    _al_u311 (
    .a(_al_u309_o),
    .b(\mctl/n74_lutinv ),
    .c(stwmbaud[4]),
    .o(\mctl/tcnt_cmp_t [5]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u312 (
    .a(\mctl/rst_fsm_n ),
    .o(\mdat/n11 ));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u313 (
    .a(\mctl/n65 ),
    .o(mctl_sda_s));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u91 (
    .a(mclk_scl_o),
    .b(\mctl/mctl_scl_o ),
    .o(stwm_scl_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u92 (
    .a(\mctl/mctl_lat_ack ),
    .b(mctl_dtct_sclr),
    .o(\mctl/n64 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u93 (
    .a(stwmbaud[9]),
    .b(mctl_stwmbaud_rd),
    .o(bdatr_mclk[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u94 (
    .a(stwmbaud[8]),
    .b(mctl_stwmbaud_rd),
    .o(bdatr_mclk[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u95 (
    .a(stwmbaud[14]),
    .b(mctl_stwmbaud_rd),
    .o(bdatr_mclk[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u96 (
    .a(stwmbaud[13]),
    .b(mctl_stwmbaud_rd),
    .o(bdatr_mclk[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u97 (
    .a(stwmbaud[12]),
    .b(mctl_stwmbaud_rd),
    .o(bdatr_mclk[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u98 (
    .a(stwmbaud[11]),
    .b(mctl_stwmbaud_rd),
    .o(bdatr_mclk[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u99 (
    .a(stwmbaud[10]),
    .b(mctl_stwmbaud_rd),
    .o(bdatr_mclk[10]));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u0  (
    .a(\mclk/lcnt [0]),
    .b(1'b1),
    .c(\mclk/add1/c0 ),
    .o({\mclk/add1/c1 ,\mclk/n12 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u1  (
    .a(\mclk/lcnt [1]),
    .b(1'b0),
    .c(\mclk/add1/c1 ),
    .o({\mclk/add1/c2 ,\mclk/n12 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u10  (
    .a(\mclk/lcnt [10]),
    .b(1'b0),
    .c(\mclk/add1/c10 ),
    .o({\mclk/add1/c11 ,\mclk/n12 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u11  (
    .a(\mclk/lcnt [11]),
    .b(1'b0),
    .c(\mclk/add1/c11 ),
    .o({\mclk/add1/c12 ,\mclk/n12 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u12  (
    .a(\mclk/lcnt [12]),
    .b(1'b0),
    .c(\mclk/add1/c12 ),
    .o({\mclk/add1/c13 ,\mclk/n12 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u13  (
    .a(\mclk/lcnt [13]),
    .b(1'b0),
    .c(\mclk/add1/c13 ),
    .o({\mclk/add1/c14 ,\mclk/n12 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u14  (
    .a(\mclk/lcnt [14]),
    .b(1'b0),
    .c(\mclk/add1/c14 ),
    .o({\mclk/add1/c15 ,\mclk/n12 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u15  (
    .a(\mclk/lcnt [15]),
    .b(1'b0),
    .c(\mclk/add1/c15 ),
    .o({open_n0,\mclk/n12 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u2  (
    .a(\mclk/lcnt [2]),
    .b(1'b0),
    .c(\mclk/add1/c2 ),
    .o({\mclk/add1/c3 ,\mclk/n12 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u3  (
    .a(\mclk/lcnt [3]),
    .b(1'b0),
    .c(\mclk/add1/c3 ),
    .o({\mclk/add1/c4 ,\mclk/n12 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u4  (
    .a(\mclk/lcnt [4]),
    .b(1'b0),
    .c(\mclk/add1/c4 ),
    .o({\mclk/add1/c5 ,\mclk/n12 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u5  (
    .a(\mclk/lcnt [5]),
    .b(1'b0),
    .c(\mclk/add1/c5 ),
    .o({\mclk/add1/c6 ,\mclk/n12 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u6  (
    .a(\mclk/lcnt [6]),
    .b(1'b0),
    .c(\mclk/add1/c6 ),
    .o({\mclk/add1/c7 ,\mclk/n12 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u7  (
    .a(\mclk/lcnt [7]),
    .b(1'b0),
    .c(\mclk/add1/c7 ),
    .o({\mclk/add1/c8 ,\mclk/n12 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u8  (
    .a(\mclk/lcnt [8]),
    .b(1'b0),
    .c(\mclk/add1/c8 ),
    .o({\mclk/add1/c9 ,\mclk/n12 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add1/u9  (
    .a(\mclk/lcnt [9]),
    .b(1'b0),
    .c(\mclk/add1/c9 ),
    .o({\mclk/add1/c10 ,\mclk/n12 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \mclk/add1/ucin  (
    .a(1'b0),
    .o({\mclk/add1/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u0  (
    .a(\mclk/hcnt [0]),
    .b(1'b1),
    .c(\mclk/add2/c0 ),
    .o({\mclk/add2/c1 ,\mclk/n19 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u1  (
    .a(\mclk/hcnt [1]),
    .b(1'b0),
    .c(\mclk/add2/c1 ),
    .o({\mclk/add2/c2 ,\mclk/n19 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u10  (
    .a(\mclk/hcnt [10]),
    .b(1'b0),
    .c(\mclk/add2/c10 ),
    .o({\mclk/add2/c11 ,\mclk/n19 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u11  (
    .a(\mclk/hcnt [11]),
    .b(1'b0),
    .c(\mclk/add2/c11 ),
    .o({\mclk/add2/c12 ,\mclk/n19 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u12  (
    .a(\mclk/hcnt [12]),
    .b(1'b0),
    .c(\mclk/add2/c12 ),
    .o({\mclk/add2/c13 ,\mclk/n19 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u13  (
    .a(\mclk/hcnt [13]),
    .b(1'b0),
    .c(\mclk/add2/c13 ),
    .o({\mclk/add2/c14 ,\mclk/n19 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u14  (
    .a(\mclk/hcnt [14]),
    .b(1'b0),
    .c(\mclk/add2/c14 ),
    .o({\mclk/add2/c15 ,\mclk/n19 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u15  (
    .a(\mclk/hcnt [15]),
    .b(1'b0),
    .c(\mclk/add2/c15 ),
    .o({open_n4,\mclk/n19 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u2  (
    .a(\mclk/hcnt [2]),
    .b(1'b0),
    .c(\mclk/add2/c2 ),
    .o({\mclk/add2/c3 ,\mclk/n19 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u3  (
    .a(\mclk/hcnt [3]),
    .b(1'b0),
    .c(\mclk/add2/c3 ),
    .o({\mclk/add2/c4 ,\mclk/n19 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u4  (
    .a(\mclk/hcnt [4]),
    .b(1'b0),
    .c(\mclk/add2/c4 ),
    .o({\mclk/add2/c5 ,\mclk/n19 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u5  (
    .a(\mclk/hcnt [5]),
    .b(1'b0),
    .c(\mclk/add2/c5 ),
    .o({\mclk/add2/c6 ,\mclk/n19 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u6  (
    .a(\mclk/hcnt [6]),
    .b(1'b0),
    .c(\mclk/add2/c6 ),
    .o({\mclk/add2/c7 ,\mclk/n19 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u7  (
    .a(\mclk/hcnt [7]),
    .b(1'b0),
    .c(\mclk/add2/c7 ),
    .o({\mclk/add2/c8 ,\mclk/n19 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u8  (
    .a(\mclk/hcnt [8]),
    .b(1'b0),
    .c(\mclk/add2/c8 ),
    .o({\mclk/add2/c9 ,\mclk/n19 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mclk/add2/u9  (
    .a(\mclk/hcnt [9]),
    .b(1'b0),
    .c(\mclk/add2/c9 ),
    .o({\mclk/add2/c10 ,\mclk/n19 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \mclk/add2/ucin  (
    .a(1'b0),
    .o({\mclk/add2/c0 ,open_n7}));
  reg_sr_as_w1 \mclk/mclk_scl_o_reg  (
    .clk(clk),
    .d(mclk_scl_o_d),
    .en(1'b1),
    .reset(~\mclk/u15_sel_is_3_o ),
    .set(1'b0),
    .q(mclk_scl_o));  // rtl/stwmst.v(830)
  reg_sr_as_w1 \mclk/mclk_start_cnt_reg  (
    .clk(clk),
    .d(mctl_clk_gen),
    .en(\mclk/n2_en ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mclk/mclk_start_cnt ));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b0  (
    .clk(clk),
    .d(\mclk/n12 [0]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [0]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b1  (
    .clk(clk),
    .d(\mclk/n12 [1]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [1]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b10  (
    .clk(clk),
    .d(\mclk/n12 [10]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [10]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b11  (
    .clk(clk),
    .d(\mclk/n12 [11]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [11]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b12  (
    .clk(clk),
    .d(\mclk/n12 [12]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [12]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b13  (
    .clk(clk),
    .d(\mclk/n12 [13]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [13]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b14  (
    .clk(clk),
    .d(\mclk/n12 [14]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [14]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b15  (
    .clk(clk),
    .d(\mclk/n12 [15]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [15]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b2  (
    .clk(clk),
    .d(\mclk/n12 [2]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [2]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b3  (
    .clk(clk),
    .d(\mclk/n12 [3]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [3]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b4  (
    .clk(clk),
    .d(\mclk/n12 [4]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [4]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b5  (
    .clk(clk),
    .d(\mclk/n12 [5]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [5]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b6  (
    .clk(clk),
    .d(\mclk/n12 [6]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [6]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b7  (
    .clk(clk),
    .d(\mclk/n12 [7]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [7]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b8  (
    .clk(clk),
    .d(\mclk/n12 [8]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [8]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg0_b9  (
    .clk(clk),
    .d(\mclk/n12 [9]),
    .en(\mclk/mux4_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/lcnt [9]));  // rtl/stwmst.v(803)
  reg_sr_as_w1 \mclk/reg1_b0  (
    .clk(clk),
    .d(\mclk/n19 [0]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [0]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b1  (
    .clk(clk),
    .d(\mclk/n19 [1]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [1]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b10  (
    .clk(clk),
    .d(\mclk/n19 [10]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [10]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b11  (
    .clk(clk),
    .d(\mclk/n19 [11]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [11]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b12  (
    .clk(clk),
    .d(\mclk/n19 [12]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [12]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b13  (
    .clk(clk),
    .d(\mclk/n19 [13]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [13]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b14  (
    .clk(clk),
    .d(\mclk/n19 [14]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [14]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b15  (
    .clk(clk),
    .d(\mclk/n19 [15]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [15]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b2  (
    .clk(clk),
    .d(\mclk/n19 [2]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [2]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b3  (
    .clk(clk),
    .d(\mclk/n19 [3]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [3]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b4  (
    .clk(clk),
    .d(\mclk/n19 [4]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [4]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b5  (
    .clk(clk),
    .d(\mclk/n19 [5]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [5]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b6  (
    .clk(clk),
    .d(\mclk/n19 [6]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [6]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b7  (
    .clk(clk),
    .d(\mclk/n19 [7]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [7]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b8  (
    .clk(clk),
    .d(\mclk/n19 [8]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [8]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg1_b9  (
    .clk(clk),
    .d(\mclk/n19 [9]),
    .en(\mclk/mux7_b0_sel_is_2_o ),
    .reset(\mclk/n9 ),
    .set(1'b0),
    .q(\mclk/hcnt [9]));  // rtl/stwmst.v(816)
  reg_sr_as_w1 \mclk/reg2_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[0]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[1]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[10]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[11]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[12]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[13]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[14]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[2]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[3]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[4]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[5]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[6]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[7]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[8]));  // rtl/stwmst.v(770)
  reg_sr_as_w1 \mclk/reg2_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(mctl_stwmbaud_wr),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(stwmbaud[9]));  // rtl/stwmst.v(770)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u0  (
    .a(stwmbaud[4]),
    .b(1'b1),
    .c(\mclk/sub1_mclk/sub2/c0 ),
    .o({\mclk/sub1_mclk/sub2/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u1  (
    .a(stwmbaud[5]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c1 ),
    .o({\mclk/sub1_mclk/sub2/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u10  (
    .a(stwmbaud[14]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c10 ),
    .o({\mclk/sub1_mclk/sub2/c11 ,n1[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u2  (
    .a(stwmbaud[6]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c2 ),
    .o({\mclk/sub1_mclk/sub2/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u3  (
    .a(stwmbaud[7]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c3 ),
    .o({\mclk/sub1_mclk/sub2/c4 ,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u4  (
    .a(stwmbaud[8]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c4 ),
    .o({\mclk/sub1_mclk/sub2/c5 ,n1[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u5  (
    .a(stwmbaud[9]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c5 ),
    .o({\mclk/sub1_mclk/sub2/c6 ,n1[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u6  (
    .a(stwmbaud[10]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c6 ),
    .o({\mclk/sub1_mclk/sub2/c7 ,n1[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u7  (
    .a(stwmbaud[11]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c7 ),
    .o({\mclk/sub1_mclk/sub2/c8 ,n1[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u8  (
    .a(stwmbaud[12]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c8 ),
    .o({\mclk/sub1_mclk/sub2/c9 ,n1[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/u9  (
    .a(stwmbaud[13]),
    .b(1'b0),
    .c(\mclk/sub1_mclk/sub2/c9 ),
    .o({\mclk/sub1_mclk/sub2/c10 ,n1[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \mclk/sub1_mclk/sub2/ucin  (
    .a(1'b0),
    .o({\mclk/sub1_mclk/sub2/c0 ,open_n10}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mclk/sub1_mclk/sub2/ucout  (
    .c(\mclk/sub1_mclk/sub2/c11 ),
    .o({open_n13,n1[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u0  (
    .a(\mctl/tcnt [0]),
    .b(1'b1),
    .c(\mctl/add0/c0 ),
    .o({\mctl/add0/c1 ,\mctl/n88 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u1  (
    .a(\mctl/tcnt [1]),
    .b(1'b0),
    .c(\mctl/add0/c1 ),
    .o({\mctl/add0/c2 ,\mctl/n88 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u10  (
    .a(\mctl/tcnt [10]),
    .b(1'b0),
    .c(\mctl/add0/c10 ),
    .o({\mctl/add0/c11 ,\mctl/n88 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u11  (
    .a(\mctl/tcnt [11]),
    .b(1'b0),
    .c(\mctl/add0/c11 ),
    .o({\mctl/add0/c12 ,\mctl/n88 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u12  (
    .a(\mctl/tcnt [12]),
    .b(1'b0),
    .c(\mctl/add0/c12 ),
    .o({\mctl/add0/c13 ,\mctl/n88 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u13  (
    .a(\mctl/tcnt [13]),
    .b(1'b0),
    .c(\mctl/add0/c13 ),
    .o({\mctl/add0/c14 ,\mctl/n88 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u14  (
    .a(\mctl/tcnt [14]),
    .b(1'b0),
    .c(\mctl/add0/c14 ),
    .o({\mctl/add0/c15 ,\mctl/n88 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u15  (
    .a(\mctl/tcnt [15]),
    .b(1'b0),
    .c(\mctl/add0/c15 ),
    .o({open_n14,\mctl/n88 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u2  (
    .a(\mctl/tcnt [2]),
    .b(1'b0),
    .c(\mctl/add0/c2 ),
    .o({\mctl/add0/c3 ,\mctl/n88 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u3  (
    .a(\mctl/tcnt [3]),
    .b(1'b0),
    .c(\mctl/add0/c3 ),
    .o({\mctl/add0/c4 ,\mctl/n88 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u4  (
    .a(\mctl/tcnt [4]),
    .b(1'b0),
    .c(\mctl/add0/c4 ),
    .o({\mctl/add0/c5 ,\mctl/n88 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u5  (
    .a(\mctl/tcnt [5]),
    .b(1'b0),
    .c(\mctl/add0/c5 ),
    .o({\mctl/add0/c6 ,\mctl/n88 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u6  (
    .a(\mctl/tcnt [6]),
    .b(1'b0),
    .c(\mctl/add0/c6 ),
    .o({\mctl/add0/c7 ,\mctl/n88 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u7  (
    .a(\mctl/tcnt [7]),
    .b(1'b0),
    .c(\mctl/add0/c7 ),
    .o({\mctl/add0/c8 ,\mctl/n88 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u8  (
    .a(\mctl/tcnt [8]),
    .b(1'b0),
    .c(\mctl/add0/c8 ),
    .o({\mctl/add0/c9 ,\mctl/n88 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mctl/add0/u9  (
    .a(\mctl/tcnt [9]),
    .b(1'b0),
    .c(\mctl/add0/c9 ),
    .o({\mctl/add0/c10 ,\mctl/n88 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \mctl/add0/ucin  (
    .a(1'b0),
    .o({\mctl/add0/c0 ,open_n17}));
  reg_sr_as_w1 \mctl/fsm/mctl_lat_ack_reg  (
    .clk(clk),
    .d(\mctl/fsm/mctl_lat_ack_t ),
    .en(1'b1),
    .reset(~\mctl/rst_fsm_n ),
    .set(1'b0),
    .q(\mctl/mctl_lat_ack ));  // rtl/stwm_fsm.v(226)
  reg_sr_as_w1 \mctl/fsm/mctl_lat_rv_reg  (
    .clk(clk),
    .d(\mctl/fsm/mctl_lat_rv_t ),
    .en(1'b1),
    .reset(~\mctl/rst_fsm_n ),
    .set(1'b0),
    .q(mctl_lat_rv));  // rtl/stwm_fsm.v(218)
  reg_ar_ss_w1 \mctl/fsm/mctl_scl_o_reg  (
    .clk(clk),
    .d(\mctl/fsm/mctl_scl_o_t ),
    .en(1'b1),
    .reset(1'b0),
    .set(~\mctl/rst_fsm_n ),
    .q(\mctl/mctl_scl_o ));  // rtl/stwm_fsm.v(234)
  reg_ar_ss_w1 \mctl/fsm/mctl_sda_o_reg  (
    .clk(clk),
    .d(\mctl/fsm/mctl_sda_o_t ),
    .en(1'b1),
    .reset(1'b0),
    .set(~\mctl/rst_fsm_n ),
    .q(\mctl/mctl_sda_o ));  // rtl/stwm_fsm.v(242)
  reg_sr_as_w1 \mctl/fsm/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\mctl/fsm/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\mctl/fsm/stat [0]));  // rtl/stwm_fsm.v(210)
  reg_sr_as_w1 \mctl/fsm/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\mctl/fsm/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\mctl/fsm/stat [1]));  // rtl/stwm_fsm.v(210)
  reg_sr_as_w1 \mctl/fsm/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\mctl/fsm/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\mctl/fsm/stat [2]));  // rtl/stwm_fsm.v(210)
  reg_sr_as_w1 \mctl/fsm/reg0_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\mctl/fsm/mux0_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\mctl/fsm/stat [3]));  // rtl/stwm_fsm.v(210)
  reg_sr_as_w1 \mctl/fsm/reg0_b4  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\mctl/fsm/mux0_b4_sel_is_3_o ),
    .set(1'b0),
    .q(\mctl/fsm/stat [4]));  // rtl/stwm_fsm.v(210)
  reg_sr_as_w1 \mctl/mctl_ack_stat_reg  (
    .clk(clk),
    .d(\mctl/n65 ),
    .en(\mctl/n64 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/mctl_ack_stat ));  // rtl/stwmst.v(441)
  reg_sr_as_w1 \mctl/mctl_bus_bsy_reg  (
    .clk(clk),
    .d(\mctl/n58 ),
    .en(\mclk/n2_en_al_n128 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/mctl_bus_bsy ));  // rtl/stwmst.v(431)
  reg_sr_as_w1 \mctl/mctl_bus_err_reg  (
    .clk(clk),
    .d(mctl_bus_err_d),
    .en(1'b1),
    .reset(~\mctl/u89_sel_is_1_o ),
    .set(1'b0),
    .q(mctl_bus_err));  // rtl/stwmst.v(510)
  reg_sr_as_w1 \mctl/mctl_dtct_sclf_reg  (
    .clk(clk),
    .d(\mctl/n47 ),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/mctl_dtct_sclf ));  // rtl/stwmst.v(393)
  reg_sr_as_w1 \mctl/mctl_dtct_sclr_reg  (
    .clk(clk),
    .d(\mctl/n45 ),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mctl_dtct_sclr));  // rtl/stwmst.v(393)
  reg_sr_as_w1 \mctl/mctl_dtct_sta_reg  (
    .clk(clk),
    .d(\mctl/n53 ),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/mctl_dtct_sta ));  // rtl/stwmst.v(431)
  reg_sr_as_w1 \mctl/mctl_dtct_stp_reg  (
    .clk(clk),
    .d(\mctl/n56 ),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/mctl_dtct_stp ));  // rtl/stwmst.v(431)
  reg_ar_ss_w1 \mctl/mctl_mrst_reg  (
    .clk(clk),
    .d(\mctl/n0 ),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\mctl/mctl_mrst ));  // rtl/stwmst.v(278)
  reg_sr_as_w1 \mctl/mctl_mtef_reg  (
    .clk(clk),
    .d(\mctl/u73_sel_is_0_o_neg ),
    .en(\mclk/n2_en_al_n130 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/mctl_mtef ));  // rtl/stwmst.v(454)
  reg_sr_as_w1 \mctl/mctl_stwmbaud_rd_reg  (
    .clk(clk),
    .d(\mctl/n13 ),
    .en(brdy),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mctl_stwmbaud_rd));  // rtl/stwmst.v(304)
  reg_sr_as_w1 \mctl/mctl_stwmctl_rd_reg  (
    .clk(clk),
    .d(\mctl/n7 ),
    .en(brdy),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/mctl_stwmctl_rd ));  // rtl/stwmst.v(304)
  reg_sr_as_w1 \mctl/mctl_stwmdatr_rd_reg  (
    .clk(clk),
    .d(\mctl/n9 ),
    .en(brdy),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mctl_stwmdatr_rd));  // rtl/stwmst.v(304)
  reg_sr_as_w1 \mctl/mctl_stwmreqr_rd_reg  (
    .clk(clk),
    .d(\mctl/n11 ),
    .en(brdy),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mctl_stwmreqr_rd));  // rtl/stwmst.v(304)
  reg_sr_as_w1 \mctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\mctl/mctl_stwmctl_wr ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mctl_mrae));  // rtl/stwmst.v(320)
  reg_sr_as_w1 \mctl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\mctl/mctl_stwmctl_wr ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mctl/stwmctl [2]));  // rtl/stwmst.v(320)
  reg_ar_ss_w1 \mctl/reg1_b0  (
    .clk(clk),
    .d(stws_scl_i),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_scl [0]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg1_b1  (
    .clk(clk),
    .d(\mctl/synfil_scl [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_scl [1]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg1_b2  (
    .clk(clk),
    .d(\mctl/synfil_scl [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_scl [2]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg1_b3  (
    .clk(clk),
    .d(\mctl/synfil_scl [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_scl [3]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg1_b4  (
    .clk(clk),
    .d(\mctl/synfil_scl [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_scl [4]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg2_b0  (
    .clk(clk),
    .d(stws_sda_i),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_sda [0]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg2_b1  (
    .clk(clk),
    .d(\mctl/synfil_sda [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_sda [1]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg2_b2  (
    .clk(clk),
    .d(\mctl/synfil_sda [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_sda [2]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg2_b3  (
    .clk(clk),
    .d(\mctl/synfil_sda [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_sda [3]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg2_b4  (
    .clk(clk),
    .d(\mctl/synfil_sda [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/synfil_sda [4]));  // rtl/stwmst.v(347)
  reg_ar_ss_w1 \mctl/reg3_b0  (
    .clk(clk),
    .d(mctl_scl_s),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/mctl_scl_f [0]));  // rtl/stwmst.v(376)
  reg_ar_ss_w1 \mctl/reg3_b1  (
    .clk(clk),
    .d(\mctl/mctl_scl_f [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/mctl_scl_f [1]));  // rtl/stwmst.v(376)
  reg_ar_ss_w1 \mctl/reg3_b2  (
    .clk(clk),
    .d(\mctl/mctl_scl_f [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/mctl_scl_f [2]));  // rtl/stwmst.v(376)
  reg_ar_ss_w1 \mctl/reg3_b3  (
    .clk(clk),
    .d(\mctl/mctl_scl_f [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/mctl_scl_f [3]));  // rtl/stwmst.v(376)
  reg_ar_ss_w1 \mctl/reg4_b0  (
    .clk(clk),
    .d(mctl_sda_s),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/mctl_sda_f [0]));  // rtl/stwmst.v(376)
  reg_ar_ss_w1 \mctl/reg4_b1  (
    .clk(clk),
    .d(\mctl/mctl_sda_f [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/mctl_sda_f [1]));  // rtl/stwmst.v(376)
  reg_ar_ss_w1 \mctl/reg4_b2  (
    .clk(clk),
    .d(\mctl/mctl_sda_f [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/mctl_sda_f [2]));  // rtl/stwmst.v(376)
  reg_sr_as_w1 \mctl/reg5_b0  (
    .clk(clk),
    .d(\mctl/n88 [0]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [0]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b1  (
    .clk(clk),
    .d(\mctl/n88 [1]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [1]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b10  (
    .clk(clk),
    .d(\mctl/n88 [10]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [10]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b11  (
    .clk(clk),
    .d(\mctl/n88 [11]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [11]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b12  (
    .clk(clk),
    .d(\mctl/n88 [12]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [12]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b13  (
    .clk(clk),
    .d(\mctl/n88 [13]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [13]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b14  (
    .clk(clk),
    .d(\mctl/n88 [14]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [14]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b15  (
    .clk(clk),
    .d(\mctl/n88 [15]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [15]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b2  (
    .clk(clk),
    .d(\mctl/n88 [2]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [2]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b3  (
    .clk(clk),
    .d(\mctl/n88 [3]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [3]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b4  (
    .clk(clk),
    .d(\mctl/n88 [4]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [4]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b5  (
    .clk(clk),
    .d(\mctl/n88 [5]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [5]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b6  (
    .clk(clk),
    .d(\mctl/n88 [6]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [6]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b7  (
    .clk(clk),
    .d(\mctl/n88 [7]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [7]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b8  (
    .clk(clk),
    .d(\mctl/n88 [8]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [8]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg5_b9  (
    .clk(clk),
    .d(\mctl/n88 [9]),
    .en(1'b1),
    .reset(~\mctl/mux13_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mctl/tcnt [9]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mctl/reg6_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(rst_mst_n),
    .set(1'b0),
    .q(\mctl/tcnt_cmp [0]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b1  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [1]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b10  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [10]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [10]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b11  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [11]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [11]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b12  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [12]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [12]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b13  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [13]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [13]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b14  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [14]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [14]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b15  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [15]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [15]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b2  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [2]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b3  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [3]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b4  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [4]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b5  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [5]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b6  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [6]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [6]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b7  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [7]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [7]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b8  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [8]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [8]));  // rtl/stwmst.v(497)
  reg_ar_ss_w1 \mctl/reg6_b9  (
    .clk(clk),
    .d(\mctl/tcnt_cmp_t [9]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_mst_n),
    .q(\mctl/tcnt_cmp [9]));  // rtl/stwmst.v(497)
  reg_sr_as_w1 \mdat/mdat_mraf_reg  (
    .clk(clk),
    .d(mctl_lat_rv),
    .en(\mclk/n2_en_al_n132 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mdat_mraf));  // rtl/stwmst.v(633)
  reg_ar_ss_w1 \mdat/mdat_mtaf_reg  (
    .clk(clk),
    .d(1'b0),
    .en(mctl_stwmdats_wr),
    .reset(1'b0),
    .set(\mdat/n28 ),
    .q(mdat_mtaf));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/mdat_nak_rv_reg  (
    .clk(clk),
    .d(\mdat/mdat_rcv_nack ),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mdat_nak_rv));  // rtl/stwmst.v(672)
  reg_sr_as_w1 \mdat/mdat_rcv_nack_reg  (
    .clk(clk),
    .d(\mdat/n16 ),
    .en(\mclk/n2_en_al_n134 ),
    .reset(\mdat/n11 ),
    .set(1'b0),
    .q(\mdat/mdat_rcv_nack ));  // rtl/stwmst.v(672)
  reg_sr_as_w1 \mdat/mdat_sda_o_reg  (
    .clk(clk),
    .d(\mdat/n48 ),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(mdat_sda_o));  // rtl/stwmst.v(732)
  reg_sr_as_w1 \mdat/mdat_trg_rd_reg  (
    .clk(clk),
    .d(\mdat/n12 ),
    .en(\mclk/n2_en_al_n136 ),
    .reset(\mdat/n11 ),
    .set(1'b0),
    .q(mdat_trg_rd));  // rtl/stwmst.v(672)
  reg_sr_as_w1 \mdat/mdat_trg_sp_reg  (
    .clk(clk),
    .d(\mdat/n20 ),
    .en(\mclk/n2_en_al_n138 ),
    .reset(\mdat/n11 ),
    .set(1'b0),
    .q(mdat_trg_sp));  // rtl/stwmst.v(672)
  reg_sr_as_w1 \mdat/mdat_trg_wr_reg  (
    .clk(clk),
    .d(mdat_trg_wr_d),
    .en(1'b1),
    .reset(\mdat/n29 ),
    .set(1'b0),
    .q(mdat_trg_wr));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg0_b0  (
    .clk(clk),
    .d(\mdat/n7 [0]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [0]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg0_b1  (
    .clk(clk),
    .d(\mdat/n7 [1]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [1]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg0_b2  (
    .clk(clk),
    .d(\mdat/n7 [2]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [2]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg0_b3  (
    .clk(clk),
    .d(\mdat/n7 [3]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [3]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg0_b4  (
    .clk(clk),
    .d(\mdat/n7 [4]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [4]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg0_b5  (
    .clk(clk),
    .d(\mdat/n7 [5]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [5]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg0_b6  (
    .clk(clk),
    .d(\mdat/n7 [6]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [6]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg0_b7  (
    .clk(clk),
    .d(\mdat/n7 [7]),
    .en(1'b1),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/stwmdatr [7]));  // rtl/stwmst.v(633)
  reg_sr_as_w1 \mdat/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [0]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [1]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [2]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [3]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [4]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [5]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [6]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/stwmdats [7]));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg1_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(mctl_stwmdats_wr),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(mdat_sta_sd));  // rtl/stwmst.v(702)
  reg_sr_as_w1 \mdat/reg2_b0  (
    .clk(clk),
    .d(\mdat/mdat_dats_sft [1]),
    .en(mctl_sft_sd),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/mdat_dats_sft [0]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg2_b1  (
    .clk(clk),
    .d(\mdat/mdat_dats_sft [2]),
    .en(mctl_sft_sd),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/mdat_dats_sft [1]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg2_b2  (
    .clk(clk),
    .d(\mdat/mdat_dats_sft [3]),
    .en(mctl_sft_sd),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/mdat_dats_sft [2]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg2_b3  (
    .clk(clk),
    .d(\mdat/mdat_dats_sft [4]),
    .en(mctl_sft_sd),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/mdat_dats_sft [3]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg2_b4  (
    .clk(clk),
    .d(\mdat/mdat_dats_sft [5]),
    .en(mctl_sft_sd),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/mdat_dats_sft [4]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg2_b5  (
    .clk(clk),
    .d(\mdat/mdat_dats_sft [6]),
    .en(mctl_sft_sd),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/mdat_dats_sft [5]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg2_b6  (
    .clk(clk),
    .d(\mdat/mdat_dats_sft [7]),
    .en(mctl_sft_sd),
    .reset(\mdat/n28 ),
    .set(1'b0),
    .q(\mdat/mdat_dats_sft [6]));  // rtl/stwmst.v(720)
  reg_ar_ss_w1 \mdat/reg2_b7  (
    .clk(clk),
    .d(1'b0),
    .en(mctl_sft_sd),
    .reset(1'b0),
    .set(\mdat/n28 ),
    .q(\mdat/mdat_dats_sft [7]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b0  (
    .clk(clk),
    .d(\mdat/stwmdats [0]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [0]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b1  (
    .clk(clk),
    .d(\mdat/stwmdats [1]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [1]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b2  (
    .clk(clk),
    .d(\mdat/stwmdats [2]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [2]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b3  (
    .clk(clk),
    .d(\mdat/stwmdats [3]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [3]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b4  (
    .clk(clk),
    .d(\mdat/stwmdats [4]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [4]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b5  (
    .clk(clk),
    .d(\mdat/stwmdats [5]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [5]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b6  (
    .clk(clk),
    .d(\mdat/stwmdats [6]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [6]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg3_b7  (
    .clk(clk),
    .d(\mdat/stwmdats [7]),
    .en(mctl_rst_sd),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_dats [7]));  // rtl/stwmst.v(720)
  reg_sr_as_w1 \mdat/reg4_b0  (
    .clk(clk),
    .d(mctl_sda_s),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [0]));  // rtl/stwmst.v(610)
  reg_sr_as_w1 \mdat/reg4_b1  (
    .clk(clk),
    .d(\mdat/mdat_datr_sft [0]),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [1]));  // rtl/stwmst.v(610)
  reg_sr_as_w1 \mdat/reg4_b2  (
    .clk(clk),
    .d(\mdat/mdat_datr_sft [1]),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [2]));  // rtl/stwmst.v(610)
  reg_sr_as_w1 \mdat/reg4_b3  (
    .clk(clk),
    .d(\mdat/mdat_datr_sft [2]),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [3]));  // rtl/stwmst.v(610)
  reg_sr_as_w1 \mdat/reg4_b4  (
    .clk(clk),
    .d(\mdat/mdat_datr_sft [3]),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [4]));  // rtl/stwmst.v(610)
  reg_sr_as_w1 \mdat/reg4_b5  (
    .clk(clk),
    .d(\mdat/mdat_datr_sft [4]),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [5]));  // rtl/stwmst.v(610)
  reg_sr_as_w1 \mdat/reg4_b6  (
    .clk(clk),
    .d(\mdat/mdat_datr_sft [5]),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [6]));  // rtl/stwmst.v(610)
  reg_sr_as_w1 \mdat/reg4_b7  (
    .clk(clk),
    .d(\mdat/mdat_datr_sft [6]),
    .en(\mdat/n0 ),
    .reset(~rst_mst_n),
    .set(1'b0),
    .q(\mdat/mdat_datr_sft [7]));  // rtl/stwmst.v(610)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u0  (
    .a(1'b0),
    .b(1'b1),
    .c(\u1/c0 ),
    .o({\u1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u1  (
    .a(1'b0),
    .b(1'b0),
    .c(\u1/c1 ),
    .o({\u1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u2  (
    .a(1'b1),
    .b(1'b0),
    .c(\u1/c2 ),
    .o({\u1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/u3  (
    .a(1'b0),
    .b(1'b1),
    .c(\u1/c3 ),
    .o({\u1/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \u1/ucin  (
    .a(1'b0),
    .o({\u1/c0 ,open_n20}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \u1/ucout  (
    .c(\u1/c4 ),
    .o({open_n23,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u0  (
    .a(stwmbaud[1]),
    .b(n0[0]),
    .c(\u2/c0 ),
    .o({\u2/c1 ,\mclk/tscl_l [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u1  (
    .a(stwmbaud[2]),
    .b(n0[1]),
    .c(\u2/c1 ),
    .o({\u2/c2 ,\mclk/tscl_l [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u10  (
    .a(stwmbaud[11]),
    .b(n0[4]),
    .c(\u2/c10 ),
    .o({\u2/c11 ,\mclk/tscl_l [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u11  (
    .a(stwmbaud[12]),
    .b(n0[4]),
    .c(\u2/c11 ),
    .o({\u2/c12 ,\mclk/tscl_l [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u12  (
    .a(stwmbaud[13]),
    .b(n0[4]),
    .c(\u2/c12 ),
    .o({\u2/c13 ,\mclk/tscl_l [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u13  (
    .a(stwmbaud[14]),
    .b(n0[4]),
    .c(\u2/c13 ),
    .o({\u2/c14 ,\mclk/tscl_l [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u14  (
    .a(1'b0),
    .b(n0[4]),
    .c(\u2/c14 ),
    .o({\u2/c15 ,\mclk/tscl_l [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u15  (
    .a(1'b0),
    .b(n0[4]),
    .c(\u2/c15 ),
    .o({open_n24,\mclk/tscl_l [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u2  (
    .a(stwmbaud[3]),
    .b(n0[2]),
    .c(\u2/c2 ),
    .o({\u2/c3 ,\mclk/tscl_l [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u3  (
    .a(stwmbaud[4]),
    .b(n0[3]),
    .c(\u2/c3 ),
    .o({\u2/c4 ,\mclk/tscl_l [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u4  (
    .a(stwmbaud[5]),
    .b(n0[4]),
    .c(\u2/c4 ),
    .o({\u2/c5 ,\mclk/tscl_l [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u5  (
    .a(stwmbaud[6]),
    .b(n0[4]),
    .c(\u2/c5 ),
    .o({\u2/c6 ,\mclk/tscl_l [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u6  (
    .a(stwmbaud[7]),
    .b(n0[4]),
    .c(\u2/c6 ),
    .o({\u2/c7 ,\mclk/tscl_l [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u7  (
    .a(stwmbaud[8]),
    .b(n0[4]),
    .c(\u2/c7 ),
    .o({\u2/c8 ,\mclk/tscl_l [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u8  (
    .a(stwmbaud[9]),
    .b(n0[4]),
    .c(\u2/c8 ),
    .o({\u2/c9 ,\mclk/tscl_l [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u9  (
    .a(stwmbaud[10]),
    .b(n0[4]),
    .c(\u2/c9 ),
    .o({\u2/c10 ,\mclk/tscl_l [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u2/ucin  (
    .a(1'b0),
    .o({\u2/c0 ,open_n27}));

endmodule 

