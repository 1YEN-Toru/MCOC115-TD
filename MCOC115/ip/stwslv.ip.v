
`timescale 1ns / 1ps
module stwslv  // rtl/stwslv.v(1)
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
  stws_scl_o,
  stws_sda_o,
  stws_srar,
  stws_star
  );
//
//	Synchronous Two Wire serial Slave Unit
//		(c) 2021	1YEN Toru
//
//
//	2021/08/14	ver.1.00
//		i2c like synchronous two wire serial slave
//

  input [3:0] badr;  // rtl/stwslv.v(27)
  input bcmdr;  // rtl/stwslv.v(25)
  input bcmdw;  // rtl/stwslv.v(26)
  input bcs_stws_n;  // rtl/stwslv.v(23)
  input [15:0] bdatw;  // rtl/stwslv.v(28)
  input brdy;  // rtl/stwslv.v(24)
  input clk;  // rtl/stwslv.v(19)
  input rst_n;  // rtl/stwslv.v(20)
  input stws_scl_i;  // rtl/stwslv.v(21)
  input stws_sda_i;  // rtl/stwslv.v(22)
  output [15:0] bdatr;  // rtl/stwslv.v(33)
  output stws_scl_o;  // rtl/stwslv.v(29)
  output stws_sda_o;  // rtl/stwslv.v(30)
  output stws_srar;  // rtl/stwslv.v(31)
  output stws_star;  // rtl/stwslv.v(32)

  wire [15:0] bdatr_sadr;  // rtl/stwslv.v(51)
  wire [15:0] bdatr_sdat;  // rtl/stwslv.v(50)
  wire [4:0] \sctl/fsm/stat ;  // rtl/stws_fsm.v(83)
  wire [7:0] \sctl/sctl_scl_f ;  // rtl/stwslv.v(352)
  wire [7:0] \sctl/sctl_sda_f ;  // rtl/stwslv.v(353)
  wire [4:0] \sctl/synfil_scl ;  // rtl/stwslv.v(324)
  wire [4:0] \sctl/synfil_sda ;  // rtl/stwslv.v(325)
  wire [7:0] \sdat/n8 ;
  wire [7:0] \sdat/sdat_dats ;  // rtl/stwslv.v(657)
  wire [7:0] \sdat/sdat_dats_sft ;  // rtl/stwslv.v(656)
  wire [7:0] \sdat/stwsdatr ;  // rtl/stwslv.v(603)
  wire [7:0] \sdat/stwsdats ;  // rtl/stwslv.v(638)
  wire [7:0] sdat_datr_sft;  // rtl/stwslv.v(48)
  wire [6:0] stwsadr;  // rtl/stwslv.v(46)
  wire [6:0] stwsmsk;  // rtl/stwslv.v(47)
  wire _al_u100_o;
  wire _al_u101_o;
  wire _al_u102_o;
  wire _al_u103_o;
  wire _al_u105_o;
  wire _al_u106_o;
  wire _al_u107_o;
  wire _al_u108_o;
  wire _al_u109_o;
  wire _al_u110_o;
  wire _al_u111_o;
  wire _al_u113_o;
  wire _al_u114_o;
  wire _al_u115_o;
  wire _al_u116_o;
  wire _al_u117_o;
  wire _al_u118_o;
  wire _al_u119_o;
  wire _al_u120_o;
  wire _al_u123_o;
  wire _al_u124_o;
  wire _al_u126_o;
  wire _al_u127_o;
  wire _al_u129_o;
  wire _al_u131_o;
  wire _al_u132_o;
  wire _al_u133_o;
  wire _al_u136_o;
  wire _al_u137_o;
  wire _al_u138_o;
  wire _al_u139_o;
  wire _al_u140_o;
  wire _al_u141_o;
  wire _al_u142_o;
  wire _al_u143_o;
  wire _al_u144_o;
  wire _al_u145_o;
  wire _al_u148_o;
  wire _al_u149_o;
  wire _al_u150_o;
  wire _al_u151_o;
  wire _al_u152_o;
  wire _al_u154_o;
  wire _al_u155_o;
  wire _al_u156_o;
  wire _al_u157_o;
  wire _al_u158_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u163_o;
  wire _al_u164_o;
  wire _al_u166_o;
  wire _al_u168_o;
  wire _al_u169_o;
  wire _al_u170_o;
  wire _al_u171_o;
  wire _al_u172_o;
  wire _al_u173_o;
  wire _al_u174_o;
  wire _al_u176_o;
  wire _al_u177_o;
  wire _al_u179_o;
  wire _al_u181_o;
  wire _al_u182_o;
  wire _al_u183_o;
  wire _al_u184_o;
  wire _al_u185_o;
  wire _al_u186_o;
  wire _al_u187_o;
  wire _al_u188_o;
  wire _al_u46_o;
  wire _al_u48_o;
  wire _al_u50_o;
  wire _al_u52_o;
  wire _al_u54_o;
  wire _al_u56_o;
  wire _al_u58_o;
  wire _al_u61_o;
  wire _al_u63_o;
  wire _al_u64_o;
  wire _al_u76_o;
  wire _al_u77_o;
  wire _al_u81_o;
  wire _al_u87_o;
  wire _al_u88_o;
  wire _al_u89_o;
  wire _al_u91_o;
  wire _al_u93_o;
  wire _al_u94_o;
  wire _al_u95_o;
  wire _al_u96_o;
  wire _al_u97_o;
  wire _al_u98_o;
  wire _al_u99_o;
  wire \bdatr_sadr[15]_en ;
  wire rst_slv_n;  // rtl/stwslv.v(71)
  wire \sctl/eq12/xor_i0[0]_i1[0]_o_lutinv ;
  wire \sctl/eq12/xor_i0[3]_i1[3]_o_lutinv ;
  wire \sctl/eq12/xor_i0[5]_i1[5]_o_lutinv ;
  wire \sctl/fsm/mux1_b0_sel_is_1_o ;
  wire \sctl/fsm/mux1_b1_sel_is_3_o ;
  wire \sctl/fsm/mux1_b2_sel_is_3_o ;
  wire \sctl/fsm/mux1_b3_sel_is_3_o ;
  wire \sctl/fsm/mux1_b4_sel_is_3_o ;
  wire \sctl/fsm/n113_lutinv ;
  wire \sctl/fsm/n144_lutinv ;
  wire \sctl/fsm/n188_lutinv ;
  wire \sctl/fsm/n25_lutinv ;
  wire \sctl/fsm/n324_lutinv ;
  wire \sctl/fsm/n327_lutinv ;
  wire \sctl/fsm/n73_lutinv ;
  wire \sctl/fsm/n76_lutinv ;
  wire \sctl/fsm/sctl_dtct_sta_f ;  // rtl/stws_fsm.v(87)
  wire \sctl/fsm/sctl_lat_ack_t ;  // rtl/stws_fsm.v(80)
  wire \sctl/fsm/sctl_lat_ad_t ;  // rtl/stws_fsm.v(72)
  wire \sctl/fsm/sctl_lat_rv_t ;  // rtl/stws_fsm.v(75)
  wire \sctl/mctl_srst ;  // rtl/stwslv.v(260)
  wire \sctl/n0 ;
  wire \sctl/n11 ;
  wire \sctl/n13 ;
  wire \sctl/n23 ;
  wire \sctl/n43 ;
  wire \sctl/n45 ;
  wire \sctl/n5 ;
  wire \sctl/n51 ;
  wire \sctl/n54 ;
  wire \sctl/n7 ;
  wire \sctl/n74 ;
  wire \sctl/n79 ;
  wire \sctl/n9 ;
  wire \sctl/sctl_dtct_sclr ;  // rtl/stwslv.v(369)
  wire \sctl/sctl_dtct_sta ;  // rtl/stwslv.v(386)
  wire \sctl/sctl_dtct_stp ;  // rtl/stwslv.v(387)
  wire \sctl/sctl_lat_ack ;  // rtl/stwslv.v(525)
  wire \sctl/sctl_lat_ad ;  // rtl/stwslv.v(519)
  wire \sctl/sctl_read ;  // rtl/stwslv.v(432)
  wire \sctl/sctl_scl_ob ;  // rtl/stwslv.v(526)
  wire \sctl/sctl_scl_s ;  // rtl/stwslv.v(340)
  wire \sctl/sctl_sda_o ;  // rtl/stwslv.v(492)
  wire \sctl/sctl_sda_ob ;  // rtl/stwslv.v(527)
  wire \sctl/sctl_stwsctl_rd ;  // rtl/stwslv.v(275)
  wire \sctl/sctl_stwsctl_wr ;  // rtl/stwslv.v(259)
  wire \sctl/u92_sel_is_3_o ;
  wire sctl_ack_stat;  // rtl/stwslv.v(80)
  wire sctl_dtct_sclf;  // rtl/stwslv.v(79)
  wire sctl_flg_sadr;  // rtl/stwslv.v(82)
  wire sctl_flg_ssta;  // rtl/stwslv.v(81)
  wire sctl_flg_sstp;  // rtl/stwslv.v(83)
  wire sctl_lat_rv;  // rtl/stwslv.v(74)
  wire sctl_nak_rv;  // rtl/stwslv.v(75)
  wire sctl_rst_sd;  // rtl/stwslv.v(77)
  wire sctl_sda_s;  // rtl/stwslv.v(72)
  wire sctl_sft_rv;  // rtl/stwslv.v(73)
  wire sctl_sft_sd;  // rtl/stwslv.v(76)
  wire sctl_srae;  // rtl/stwslv.v(91)
  wire sctl_stae;  // rtl/stwslv.v(90)
  wire sctl_stwsadr_rd;  // rtl/stwslv.v(85)
  wire sctl_stwsadr_wr;  // rtl/stwslv.v(88)
  wire sctl_stwsdatr_rd;  // rtl/stwslv.v(84)
  wire sctl_stwsdats_wr;  // rtl/stwslv.v(87)
  wire sctl_stwsmsk_rd;  // rtl/stwslv.v(86)
  wire sctl_stwsmsk_wr;  // rtl/stwslv.v(89)
  wire \sdat/n11 ;
  wire \sdat/n12 ;
  wire \sdat/n30 ;
  wire \sdat/n4_d ;
  wire sdat_sda_o;  // rtl/stwslv.v(65)
  wire sdat_sraf;  // rtl/stwslv.v(64)
  wire sdat_staf;  // rtl/stwslv.v(63)

  assign bdatr[15] = 1'b0;
  assign bdatr[14] = 1'b0;
  assign bdatr[13] = 1'b0;
  assign bdatr[12] = 1'b0;
  assign bdatr[11] = 1'b0;
  assign bdatr[10] = bdatr_sdat[10];
  assign bdatr[9] = bdatr_sdat[9];
  assign bdatr[8] = bdatr_sdat[8];
  assign bdatr[7] = bdatr_sdat[7];
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u100 (
    .a(_al_u96_o),
    .b(\sctl/fsm/stat [0]),
    .o(_al_u100_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u101 (
    .a(_al_u91_o),
    .b(_al_u95_o),
    .c(_al_u98_o),
    .d(_al_u99_o),
    .e(_al_u100_o),
    .o(_al_u101_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~A*~(~C*B)))"),
    .INIT(16'hae00))
    _al_u102 (
    .a(_al_u88_o),
    .b(_al_u89_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_read ),
    .o(_al_u102_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*C*B))"),
    .INIT(16'h5515))
    _al_u103 (
    .a(_al_u102_o),
    .b(_al_u89_o),
    .c(_al_u64_o),
    .d(\sctl/sctl_dtct_sclr ),
    .o(_al_u103_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(B*A))"),
    .INIT(16'h0070))
    _al_u104 (
    .a(_al_u101_o),
    .b(_al_u103_o),
    .c(rst_slv_n),
    .d(\sctl/fsm/sctl_dtct_sta_f ),
    .o(\sctl/fsm/mux1_b2_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(32'hca000000))
    _al_u105 (
    .a(_al_u76_o),
    .b(_al_u87_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .e(\sctl/sctl_read ),
    .o(_al_u105_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u106 (
    .a(_al_u87_o),
    .b(\sctl/fsm/stat [2]),
    .o(_al_u106_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u107 (
    .a(\sctl/fsm/stat [0]),
    .b(\sctl/sctl_dtct_sclr ),
    .o(_al_u107_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u108 (
    .a(_al_u87_o),
    .b(\sctl/fsm/stat [1]),
    .c(\sctl/fsm/stat [2]),
    .o(_al_u108_o));
  AL_MAP_LUT4 #(
    .EQN("(C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'hc0a0))
    _al_u109 (
    .a(_al_u94_o),
    .b(_al_u108_o),
    .c(_al_u64_o),
    .d(\sctl/sctl_dtct_sclr ),
    .o(_al_u109_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u110 (
    .a(_al_u94_o),
    .b(\sctl/fsm/stat [0]),
    .o(_al_u110_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*~D*~C*B))"),
    .INIT(32'h55515555))
    _al_u111 (
    .a(_al_u109_o),
    .b(_al_u110_o),
    .c(\sctl/sctl_dtct_sta ),
    .d(\sctl/sctl_dtct_stp ),
    .e(\sctl/sctl_read ),
    .o(_al_u111_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(C*(~E*~(D)*~(B)+~E*D*~(B)+~(~E)*D*B+~E*D*B)))"),
    .INIT(32'heaaafaba))
    _al_u112 (
    .a(_al_u105_o),
    .b(_al_u106_o),
    .c(_al_u107_o),
    .d(\sctl/sctl_read ),
    .e(_al_u111_o),
    .o(sctl_sft_sd));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u113 (
    .a(_al_u99_o),
    .b(_al_u108_o),
    .c(_al_u64_o),
    .o(_al_u113_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u114 (
    .a(_al_u110_o),
    .b(_al_u61_o),
    .c(\sctl/sctl_read ),
    .o(_al_u114_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u115 (
    .a(_al_u111_o),
    .b(_al_u113_o),
    .c(_al_u114_o),
    .o(_al_u115_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+A*~(B)*C*D+A*B*C*D))"),
    .INIT(32'ha00c0000))
    _al_u116 (
    .a(_al_u89_o),
    .b(_al_u76_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .e(\sctl/sctl_read ),
    .o(_al_u116_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u117 (
    .a(\sdat/sdat_dats_sft [0]),
    .b(\sdat/sdat_dats_sft [6]),
    .c(\sdat/sdat_dats [0]),
    .d(\sdat/sdat_dats [6]),
    .o(_al_u117_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u118 (
    .a(_al_u117_o),
    .b(\sdat/sdat_dats_sft [1]),
    .c(\sdat/sdat_dats_sft [7]),
    .d(\sdat/sdat_dats [1]),
    .e(\sdat/sdat_dats [7]),
    .o(_al_u118_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u119 (
    .a(\sdat/sdat_dats_sft [2]),
    .b(\sdat/sdat_dats_sft [3]),
    .c(\sdat/sdat_dats [2]),
    .d(\sdat/sdat_dats [3]),
    .o(_al_u119_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u120 (
    .a(_al_u119_o),
    .b(\sdat/sdat_dats_sft [4]),
    .c(\sdat/sdat_dats_sft [5]),
    .d(\sdat/sdat_dats [4]),
    .e(\sdat/sdat_dats [5]),
    .o(_al_u120_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*D*~(~C*B*A))"),
    .INIT(32'h08ffffff))
    _al_u121 (
    .a(_al_u115_o),
    .b(_al_u103_o),
    .c(_al_u116_o),
    .d(_al_u118_o),
    .e(_al_u120_o),
    .o(\sdat/n30 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u122 (
    .a(_al_u63_o),
    .b(_al_u107_o),
    .o(\sctl/fsm/sctl_lat_ad_t ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u123 (
    .a(stwsadr[0]),
    .b(stwsadr[1]),
    .c(stwsadr[2]),
    .d(stwsadr[3]),
    .o(_al_u123_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u124 (
    .a(_al_u123_o),
    .b(stwsadr[4]),
    .c(stwsadr[5]),
    .d(stwsadr[6]),
    .o(_al_u124_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*(C@B))"),
    .INIT(8'h14))
    _al_u125 (
    .a(stwsmsk[5]),
    .b(stwsadr[5]),
    .c(sdat_datr_sft[5]),
    .o(\sctl/eq12/xor_i0[5]_i1[5]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~B*(D@C)))"),
    .INIT(16'h5445))
    _al_u126 (
    .a(\sctl/eq12/xor_i0[5]_i1[5]_o_lutinv ),
    .b(stwsmsk[4]),
    .c(stwsadr[4]),
    .d(sdat_datr_sft[4]),
    .o(_al_u126_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(~C*(E@D)))"),
    .INIT(32'h44404044))
    _al_u127 (
    .a(_al_u124_o),
    .b(_al_u126_o),
    .c(stwsmsk[6]),
    .d(stwsadr[6]),
    .e(sdat_datr_sft[6]),
    .o(_al_u127_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*(C@B))"),
    .INIT(8'h14))
    _al_u128 (
    .a(stwsmsk[0]),
    .b(stwsadr[0]),
    .c(sdat_datr_sft[0]),
    .o(\sctl/eq12/xor_i0[0]_i1[0]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~B*(D@C)))"),
    .INIT(16'h5445))
    _al_u129 (
    .a(\sctl/eq12/xor_i0[0]_i1[0]_o_lutinv ),
    .b(stwsmsk[1]),
    .c(stwsadr[1]),
    .d(sdat_datr_sft[1]),
    .o(_al_u129_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*(C@B))"),
    .INIT(8'h14))
    _al_u130 (
    .a(stwsmsk[3]),
    .b(stwsadr[3]),
    .c(sdat_datr_sft[3]),
    .o(\sctl/eq12/xor_i0[3]_i1[3]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*~(~C*(E@D)))"),
    .INIT(32'h22202022))
    _al_u131 (
    .a(_al_u129_o),
    .b(\sctl/eq12/xor_i0[3]_i1[3]_o_lutinv ),
    .c(stwsmsk[2]),
    .d(stwsadr[2]),
    .e(sdat_datr_sft[2]),
    .o(_al_u131_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u132 (
    .a(_al_u127_o),
    .b(_al_u131_o),
    .o(_al_u132_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u133 (
    .a(_al_u76_o),
    .b(\sctl/sctl_read ),
    .o(_al_u133_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*C)*~(B*A))"),
    .INIT(16'hf888))
    _al_u134 (
    .a(_al_u132_o),
    .b(\sctl/fsm/sctl_lat_ad_t ),
    .c(_al_u133_o),
    .d(_al_u107_o),
    .o(\sctl/fsm/sctl_lat_rv_t ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u135 (
    .a(\sctl/fsm/n188_lutinv ),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/fsm/stat [1]),
    .d(\sctl/sctl_dtct_sclr ),
    .o(\sctl/fsm/n25_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u136 (
    .a(\sctl/fsm/n25_lutinv ),
    .b(_al_u89_o),
    .c(_al_u107_o),
    .o(_al_u136_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u137 (
    .a(\sctl/fsm/stat [1]),
    .b(\sctl/fsm/stat [2]),
    .c(\sctl/fsm/stat [3]),
    .d(\sctl/fsm/stat [4]),
    .o(_al_u137_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u138 (
    .a(_al_u137_o),
    .b(_al_u61_o),
    .c(\sctl/fsm/stat [0]),
    .o(_al_u138_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*~(~E*D*C))"),
    .INIT(32'h22220222))
    _al_u139 (
    .a(_al_u136_o),
    .b(_al_u138_o),
    .c(_al_u93_o),
    .d(\sctl/fsm/stat [0]),
    .e(\sctl/sctl_dtct_sclr ),
    .o(_al_u139_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*(D@(E*C))))"),
    .INIT(32'ha22a22aa))
    _al_u140 (
    .a(_al_u139_o),
    .b(_al_u96_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/fsm/stat [1]),
    .e(\sctl/sctl_dtct_sclr ),
    .o(_al_u140_o));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(C*B))"),
    .INIT(16'h2a00))
    _al_u141 (
    .a(_al_u81_o),
    .b(\sctl/fsm/stat [0]),
    .c(sctl_ack_stat),
    .d(\sctl/sctl_read ),
    .o(_al_u141_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u142 (
    .a(\sctl/fsm/sctl_lat_ack_t ),
    .b(_al_u141_o),
    .o(_al_u142_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h5ffb))
    _al_u143 (
    .a(_al_u88_o),
    .b(_al_u89_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .o(_al_u143_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u144 (
    .a(_al_u93_o),
    .b(_al_u61_o),
    .c(\sctl/fsm/stat [0]),
    .o(_al_u144_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u145 (
    .a(_al_u140_o),
    .b(_al_u111_o),
    .c(_al_u142_o),
    .d(_al_u143_o),
    .e(_al_u144_o),
    .o(_al_u145_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u146 (
    .a(_al_u132_o),
    .b(\sctl/fsm/sctl_lat_ad_t ),
    .o(\sctl/fsm/n76_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u147 (
    .a(_al_u110_o),
    .b(\sctl/sctl_dtct_sclr ),
    .c(\sctl/sctl_dtct_sta ),
    .d(\sctl/sctl_dtct_stp ),
    .e(\sctl/sctl_read ),
    .o(\sctl/fsm/n144_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*C*B))"),
    .INIT(16'h5515))
    _al_u148 (
    .a(\sctl/fsm/n144_lutinv ),
    .b(_al_u108_o),
    .c(_al_u77_o),
    .d(\sctl/sctl_read ),
    .o(_al_u148_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u149 (
    .a(_al_u110_o),
    .b(\sctl/sctl_dtct_sclr ),
    .c(\sctl/sctl_dtct_sta ),
    .d(\sctl/sctl_dtct_stp ),
    .o(_al_u149_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u150 (
    .a(_al_u94_o),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/sctl_dtct_sclr ),
    .o(_al_u150_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u151 (
    .a(_al_u149_o),
    .b(_al_u150_o),
    .o(_al_u151_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u152 (
    .a(_al_u145_o),
    .b(\sctl/fsm/n76_lutinv ),
    .c(_al_u148_o),
    .d(_al_u151_o),
    .e(_al_u91_o),
    .o(_al_u152_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u153 (
    .a(_al_u152_o),
    .b(rst_slv_n),
    .c(\sctl/fsm/sctl_dtct_sta_f ),
    .o(\sctl/fsm/mux1_b1_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*A*~(E*D))"),
    .INIT(32'h00080808))
    _al_u154 (
    .a(_al_u63_o),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/sctl_dtct_sclr ),
    .d(\sctl/sctl_read ),
    .e(sdat_staf),
    .o(_al_u154_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~A*~(~E*D))"),
    .INIT(32'h01010001))
    _al_u155 (
    .a(_al_u141_o),
    .b(_al_u138_o),
    .c(_al_u154_o),
    .d(_al_u63_o),
    .e(\sctl/fsm/stat [0]),
    .o(_al_u155_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*(~(C)*~(D)*~(E)+C*~(D)*~(E)+~(C)*D*~(E)+C*~(D)*E+~(C)*D*E+C*D*E)))"),
    .INIT(32'h222aa222))
    _al_u156 (
    .a(_al_u155_o),
    .b(_al_u76_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .e(\sctl/sctl_read ),
    .o(_al_u156_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u157 (
    .a(_al_u116_o),
    .b(\sctl/sctl_scl_ob ),
    .o(_al_u157_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(D*B)*~(~E*A)))"),
    .INIT(32'hc000e0a0))
    _al_u158 (
    .a(_al_u89_o),
    .b(_al_u96_o),
    .c(_al_u77_o),
    .d(\sctl/fsm/stat [1]),
    .e(\sctl/sctl_read ),
    .o(_al_u158_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~(~C*B*A))"),
    .INIT(32'h0000f700))
    _al_u159 (
    .a(_al_u156_o),
    .b(_al_u157_o),
    .c(_al_u158_o),
    .d(rst_slv_n),
    .e(\sctl/fsm/sctl_dtct_sta_f ),
    .o(\sctl/fsm/mux1_b3_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff1303ff))
    _al_u160 (
    .a(_al_u132_o),
    .b(_al_u133_o),
    .c(_al_u63_o),
    .d(\sctl/fsm/stat [0]),
    .e(\sctl/sctl_dtct_sclr ),
    .o(\sctl/sctl_sda_ob ));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(D*C))"),
    .INIT(16'h0111))
    _al_u161 (
    .a(\sctl/fsm/sctl_lat_ad_t ),
    .b(\sctl/fsm/n25_lutinv ),
    .c(_al_u96_o),
    .d(\sctl/sctl_dtct_sclr ),
    .o(_al_u161_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u162 (
    .a(_al_u148_o),
    .b(_al_u161_o),
    .c(\sctl/fsm/n324_lutinv ),
    .d(_al_u95_o),
    .e(_al_u158_o),
    .o(_al_u162_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(~B*~A))"),
    .INIT(16'h00e0))
    _al_u163 (
    .a(_al_u88_o),
    .b(_al_u76_o),
    .c(_al_u107_o),
    .d(\sctl/sctl_read ),
    .o(_al_u163_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D*(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)))"),
    .INIT(32'h04551555))
    _al_u164 (
    .a(_al_u163_o),
    .b(_al_u93_o),
    .c(_al_u61_o),
    .d(_al_u107_o),
    .e(_al_u96_o),
    .o(_al_u164_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u165 (
    .a(_al_u162_o),
    .b(_al_u164_o),
    .o(sctl_sft_rv));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u166 (
    .a(_al_u94_o),
    .b(\sctl/fsm/n188_lutinv ),
    .o(_al_u166_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u167 (
    .a(_al_u137_o),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/sctl_dtct_sta ),
    .o(\sctl/fsm/n113_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u168 (
    .a(_al_u166_o),
    .b(sctl_rst_sd),
    .c(\sctl/fsm/n113_lutinv ),
    .o(_al_u168_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u169 (
    .a(_al_u168_o),
    .b(_al_u142_o),
    .c(_al_u98_o),
    .d(_al_u100_o),
    .o(_al_u169_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u170 (
    .a(_al_u63_o),
    .b(_al_u76_o),
    .o(_al_u170_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u171 (
    .a(_al_u170_o),
    .b(_al_u108_o),
    .c(\sctl/fsm/stat [0]),
    .o(_al_u171_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u172 (
    .a(_al_u169_o),
    .b(_al_u91_o),
    .c(_al_u171_o),
    .d(_al_u102_o),
    .o(_al_u172_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u173 (
    .a(_al_u137_o),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/sctl_dtct_sta ),
    .o(_al_u173_o));
  AL_MAP_LUT4 #(
    .EQN("~((~C*~B)*~(D)*~(A)+(~C*~B)*D*~(A)+~((~C*~B))*D*A+(~C*~B)*D*A)"),
    .INIT(16'h54fe))
    _al_u174 (
    .a(_al_u110_o),
    .b(_al_u154_o),
    .c(_al_u173_o),
    .d(_al_u61_o),
    .o(_al_u174_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u175 (
    .a(_al_u172_o),
    .b(_al_u157_o),
    .c(_al_u174_o),
    .d(_al_u158_o),
    .o(\sctl/fsm/n327_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*(~(B)*~(C)*~(D)+~(B)*C*~(D)+B*C*~(D)+~(B)*~(C)*D+B*C*D))"),
    .INIT(16'h4151))
    _al_u176 (
    .a(\sctl/fsm/n113_lutinv ),
    .b(_al_u63_o),
    .c(\sctl/fsm/stat [0]),
    .d(_al_u141_o),
    .o(_al_u176_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(~C*~B))"),
    .INIT(16'h00a8))
    _al_u177 (
    .a(rst_slv_n),
    .b(\sctl/fsm/stat [3]),
    .c(\sctl/fsm/stat [4]),
    .d(\sctl/fsm/sctl_dtct_sta_f ),
    .o(_al_u177_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u178 (
    .a(\sctl/fsm/n327_lutinv ),
    .b(_al_u176_o),
    .c(_al_u174_o),
    .d(\sctl/sctl_scl_ob ),
    .e(_al_u177_o),
    .o(\sctl/fsm/mux1_b4_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'hc0a0))
    _al_u179 (
    .a(_al_u94_o),
    .b(_al_u76_o),
    .c(_al_u77_o),
    .d(\sctl/sctl_read ),
    .o(_al_u179_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u180 (
    .a(_al_u63_o),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/sctl_dtct_sclr ),
    .o(\sctl/fsm/n73_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u181 (
    .a(_al_u99_o),
    .b(_al_u116_o),
    .c(_al_u179_o),
    .d(\sctl/fsm/n73_lutinv ),
    .e(\sctl/fsm/n25_lutinv ),
    .o(_al_u181_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E)"),
    .INIT(32'h3f31fff1))
    _al_u182 (
    .a(_al_u133_o),
    .b(_al_u173_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .e(\sctl/sctl_dtct_stp ),
    .o(_al_u182_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u183 (
    .a(_al_u181_o),
    .b(_al_u182_o),
    .o(_al_u183_o));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf00fa008))
    _al_u184 (
    .a(_al_u93_o),
    .b(_al_u61_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .e(\sctl/fsm/stat [2]),
    .o(_al_u184_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u185 (
    .a(_al_u94_o),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/sctl_dtct_sta ),
    .d(\sctl/sctl_dtct_stp ),
    .o(_al_u185_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*A*~(~E*C))"),
    .INIT(32'h00220002))
    _al_u186 (
    .a(\sctl/fsm/n188_lutinv ),
    .b(\sctl/fsm/stat [0]),
    .c(\sctl/fsm/stat [1]),
    .d(\sctl/sctl_dtct_sta ),
    .e(\sctl/sctl_dtct_stp ),
    .o(_al_u186_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h00100111))
    _al_u187 (
    .a(_al_u184_o),
    .b(_al_u185_o),
    .c(_al_u108_o),
    .d(_al_u77_o),
    .e(_al_u186_o),
    .o(_al_u187_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u188 (
    .a(\sctl/fsm/n327_lutinv ),
    .b(\sctl/fsm/n76_lutinv ),
    .c(_al_u183_o),
    .d(_al_u187_o),
    .e(_al_u149_o),
    .o(_al_u188_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*~A))"),
    .INIT(8'hc8))
    _al_u189 (
    .a(_al_u188_o),
    .b(rst_slv_n),
    .c(\sctl/fsm/sctl_dtct_sta_f ),
    .o(\sctl/fsm/mux1_b0_sel_is_1_o ));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u190 (
    .a(sctl_sda_s),
    .o(\sctl/n74 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u25 (
    .a(sctl_flg_sadr),
    .b(sctl_stwsdatr_rd),
    .o(bdatr_sdat[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u26 (
    .a(sctl_flg_sstp),
    .b(sctl_stwsdatr_rd),
    .o(bdatr_sdat[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u27 (
    .a(sctl_flg_ssta),
    .b(sctl_stwsdatr_rd),
    .o(bdatr_sdat[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u28 (
    .a(sctl_stwsdatr_rd),
    .b(\sdat/stwsdatr [7]),
    .o(bdatr_sdat[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u29 (
    .a(\sctl/sctl_sda_o ),
    .b(sdat_sda_o),
    .o(stws_sda_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u30 (
    .a(sctl_srae),
    .b(sdat_sraf),
    .o(stws_srar));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u31 (
    .a(sctl_stae),
    .b(sdat_staf),
    .o(stws_star));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u32 (
    .a(\sctl/mctl_srst ),
    .b(rst_n),
    .o(rst_slv_n));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u33 (
    .a(\sctl/sctl_scl_f [2]),
    .b(\sctl/sctl_scl_f [3]),
    .o(\sctl/n45 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u34 (
    .a(\sctl/sctl_scl_f [2]),
    .b(\sctl/sctl_scl_f [3]),
    .o(\sctl/n43 ));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u35 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [0]),
    .d(sdat_datr_sft[0]),
    .o(\sdat/n8 [0]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u36 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [1]),
    .d(sdat_datr_sft[1]),
    .o(\sdat/n8 [1]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u37 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [2]),
    .d(sdat_datr_sft[2]),
    .o(\sdat/n8 [2]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u38 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [3]),
    .d(sdat_datr_sft[3]),
    .o(\sdat/n8 [3]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u39 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [4]),
    .d(sdat_datr_sft[4]),
    .o(\sdat/n8 [4]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u40 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [5]),
    .d(sdat_datr_sft[5]),
    .o(\sdat/n8 [5]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u41 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [6]),
    .d(sdat_datr_sft[6]),
    .o(\sdat/n8 [6]));
  AL_MAP_LUT4 #(
    .EQN("((C*~B)*~(D)*~(A)+(C*~B)*D*~(A)+~((C*~B))*D*A+(C*~B)*D*A)"),
    .INIT(16'hba10))
    _al_u42 (
    .a(sctl_lat_rv),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [7]),
    .d(sdat_datr_sft[7]),
    .o(\sdat/n8 [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u43 (
    .a(rst_slv_n),
    .b(\sctl/sctl_lat_ack ),
    .o(\sctl/u92_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u44 (
    .a(\sctl/sctl_scl_f [0]),
    .b(\sctl/sctl_scl_f [3]),
    .c(\sctl/sctl_sda_f [1]),
    .d(\sctl/sctl_sda_f [2]),
    .o(\sctl/n51 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u45 (
    .a(\sctl/sctl_scl_f [0]),
    .b(\sctl/sctl_scl_f [3]),
    .c(\sctl/sctl_sda_f [1]),
    .d(\sctl/sctl_sda_f [2]),
    .o(\sctl/n54 ));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u46 (
    .a(stwsmsk[6]),
    .b(stwsadr[6]),
    .c(sctl_stwsadr_rd),
    .d(sctl_stwsmsk_rd),
    .o(_al_u46_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u47 (
    .a(_al_u46_o),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u48 (
    .a(stwsmsk[2]),
    .b(stwsadr[2]),
    .c(sctl_stwsadr_rd),
    .d(sctl_stwsmsk_rd),
    .o(_al_u48_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u49 (
    .a(_al_u48_o),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u50 (
    .a(sctl_srae),
    .b(\sctl/sctl_stwsctl_rd ),
    .c(sctl_stwsdatr_rd),
    .d(\sdat/stwsdatr [0]),
    .o(_al_u50_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*B)*~(C)*~(D)+(E*B)*C*~(D)+~((E*B))*C*D+(E*B)*C*D))"),
    .INIT(32'hf5ddf555))
    _al_u51 (
    .a(_al_u50_o),
    .b(stwsmsk[0]),
    .c(stwsadr[0]),
    .d(sctl_stwsadr_rd),
    .e(sctl_stwsmsk_rd),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u52 (
    .a(sctl_stae),
    .b(\sctl/sctl_stwsctl_rd ),
    .c(sctl_stwsdatr_rd),
    .d(\sdat/stwsdatr [1]),
    .o(_al_u52_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*B)*~(C)*~(D)+(E*B)*C*~(D)+~((E*B))*C*D+(E*B)*C*D))"),
    .INIT(32'hf5ddf555))
    _al_u53 (
    .a(_al_u52_o),
    .b(stwsmsk[1]),
    .c(stwsadr[1]),
    .d(sctl_stwsadr_rd),
    .e(sctl_stwsmsk_rd),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u54 (
    .a(sctl_ack_stat),
    .b(\sctl/sctl_stwsctl_rd ),
    .c(sctl_stwsdatr_rd),
    .d(\sdat/stwsdatr [3]),
    .o(_al_u54_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*B)*~(C)*~(D)+(E*B)*C*~(D)+~((E*B))*C*D+(E*B)*C*D))"),
    .INIT(32'hf5ddf555))
    _al_u55 (
    .a(_al_u54_o),
    .b(stwsmsk[3]),
    .c(stwsadr[3]),
    .d(sctl_stwsadr_rd),
    .e(sctl_stwsmsk_rd),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u56 (
    .a(\sctl/sctl_stwsctl_rd ),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [4]),
    .d(sdat_sraf),
    .o(_al_u56_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*B)*~(C)*~(D)+(E*B)*C*~(D)+~((E*B))*C*D+(E*B)*C*D))"),
    .INIT(32'hf5ddf555))
    _al_u57 (
    .a(_al_u56_o),
    .b(stwsmsk[4]),
    .c(stwsadr[4]),
    .d(sctl_stwsadr_rd),
    .e(sctl_stwsmsk_rd),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u58 (
    .a(\sctl/sctl_stwsctl_rd ),
    .b(sctl_stwsdatr_rd),
    .c(\sdat/stwsdatr [5]),
    .d(sdat_staf),
    .o(_al_u58_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E*B)*~(C)*~(D)+(E*B)*C*~(D)+~((E*B))*C*D+(E*B)*C*D))"),
    .INIT(32'hf5ddf555))
    _al_u59 (
    .a(_al_u58_o),
    .b(stwsmsk[5]),
    .c(stwsadr[5]),
    .d(sctl_stwsadr_rd),
    .e(sctl_stwsmsk_rd),
    .o(bdatr[5]));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(~D*~(~E*~C*~B)))"),
    .INIT(32'haaffaafe))
    _al_u60 (
    .a(sctl_lat_rv),
    .b(sctl_flg_ssta),
    .c(sctl_flg_sstp),
    .d(sctl_stwsdatr_rd),
    .e(sdat_sraf),
    .o(\sdat/n4_d ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u61 (
    .a(\sctl/sctl_dtct_sta ),
    .b(\sctl/sctl_dtct_stp ),
    .o(_al_u61_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~B*A)"),
    .INIT(8'hfd))
    _al_u62 (
    .a(_al_u61_o),
    .b(\sctl/sctl_lat_ad ),
    .c(sctl_stwsdatr_rd),
    .o(\bdatr_sadr[15]_en ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u63 (
    .a(\sctl/fsm/stat [1]),
    .b(\sctl/fsm/stat [2]),
    .c(\sctl/fsm/stat [3]),
    .d(\sctl/fsm/stat [4]),
    .o(_al_u63_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u64 (
    .a(\sctl/fsm/stat [0]),
    .b(\sctl/sctl_read ),
    .o(_al_u64_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*B*A)"),
    .INIT(16'hf7ff))
    _al_u65 (
    .a(_al_u63_o),
    .b(_al_u64_o),
    .c(\sctl/sctl_dtct_sclr ),
    .d(sdat_staf),
    .o(\sctl/sctl_scl_ob ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u66 (
    .a(bcmdr),
    .b(bcs_stws_n),
    .o(\sctl/n5 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u67 (
    .a(\sctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\sctl/n7 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u68 (
    .a(bcmdw),
    .b(bcs_stws_n),
    .c(brdy),
    .o(\sctl/n23 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u69 (
    .a(\sctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\sctl/sctl_stwsctl_wr ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u70 (
    .a(\sctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(sctl_stwsadr_wr));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u71 (
    .a(\sctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\sctl/n11 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u72 (
    .a(\sctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(sctl_stwsmsk_wr));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u73 (
    .a(\sctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\sctl/n13 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u74 (
    .a(\sctl/n23 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(sctl_stwsdats_wr));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u75 (
    .a(\sctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\sctl/n9 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u76 (
    .a(\sctl/fsm/stat [1]),
    .b(\sctl/fsm/stat [2]),
    .c(\sctl/fsm/stat [3]),
    .d(\sctl/fsm/stat [4]),
    .o(_al_u76_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u77 (
    .a(\sctl/fsm/stat [0]),
    .b(\sctl/sctl_dtct_sclr ),
    .o(_al_u77_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u78 (
    .a(_al_u76_o),
    .b(_al_u77_o),
    .c(\sctl/sctl_read ),
    .o(\sctl/fsm/sctl_lat_ack_t ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u79 (
    .a(\sctl/sctl_scl_ob ),
    .b(sctl_dtct_sclf),
    .o(\sctl/n79 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u80 (
    .a(\sctl/sctl_stwsctl_wr ),
    .b(bdatw[15]),
    .o(\sctl/n0 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u81 (
    .a(\sctl/fsm/stat [1]),
    .b(\sctl/fsm/stat [2]),
    .c(\sctl/fsm/stat [3]),
    .d(\sctl/fsm/stat [4]),
    .o(_al_u81_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(D*B)*~(E*A)))"),
    .INIT(32'he0a0c000))
    _al_u82 (
    .a(_al_u63_o),
    .b(_al_u81_o),
    .c(_al_u64_o),
    .d(sctl_ack_stat),
    .e(\sctl/sctl_dtct_sclr ),
    .o(sctl_rst_sd));
  AL_MAP_LUT3 #(
    .EQN("(A*B*~(C)+A*~(B)*C+~(A)*B*C+A*B*C)"),
    .INIT(8'he8))
    _al_u83 (
    .a(\sctl/synfil_scl [2]),
    .b(\sctl/synfil_scl [3]),
    .c(\sctl/synfil_scl [4]),
    .o(\sctl/sctl_scl_s ));
  AL_MAP_LUT3 #(
    .EQN("(A*B*~(C)+A*~(B)*C+~(A)*B*C+A*B*C)"),
    .INIT(8'he8))
    _al_u84 (
    .a(\sctl/synfil_sda [2]),
    .b(\sctl/synfil_sda [3]),
    .c(\sctl/synfil_sda [4]),
    .o(sctl_sda_s));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u85 (
    .a(sctl_rst_sd),
    .b(rst_slv_n),
    .o(\sdat/n11 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u86 (
    .a(\sdat/n11 ),
    .b(sctl_nak_rv),
    .o(\sdat/n12 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u87 (
    .a(\sctl/fsm/stat [3]),
    .b(\sctl/fsm/stat [4]),
    .o(_al_u87_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u88 (
    .a(_al_u87_o),
    .b(\sctl/fsm/stat [1]),
    .c(\sctl/fsm/stat [2]),
    .o(_al_u88_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u89 (
    .a(_al_u87_o),
    .b(\sctl/fsm/stat [1]),
    .c(\sctl/fsm/stat [2]),
    .o(_al_u89_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C))"),
    .INIT(32'h0000ac00))
    _al_u90 (
    .a(_al_u88_o),
    .b(_al_u89_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .e(\sctl/sctl_read ),
    .o(\sctl/fsm/n324_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*B))"),
    .INIT(8'h51))
    _al_u91 (
    .a(\sctl/fsm/n324_lutinv ),
    .b(_al_u89_o),
    .c(\sctl/sctl_dtct_sclr ),
    .o(_al_u91_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u92 (
    .a(\sctl/fsm/stat [2]),
    .b(\sctl/fsm/stat [3]),
    .c(\sctl/fsm/stat [4]),
    .o(\sctl/fsm/n188_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u93 (
    .a(\sctl/fsm/n188_lutinv ),
    .b(\sctl/fsm/stat [1]),
    .o(_al_u93_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u94 (
    .a(_al_u87_o),
    .b(\sctl/fsm/stat [1]),
    .c(\sctl/fsm/stat [2]),
    .o(_al_u94_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~A*~(~D*B)))"),
    .INIT(16'ha0e0))
    _al_u95 (
    .a(_al_u93_o),
    .b(_al_u94_o),
    .c(_al_u77_o),
    .d(\sctl/sctl_read ),
    .o(_al_u95_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u96 (
    .a(\sctl/fsm/stat [2]),
    .b(\sctl/fsm/stat [3]),
    .c(\sctl/fsm/stat [4]),
    .o(_al_u96_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u97 (
    .a(_al_u96_o),
    .b(\sctl/fsm/stat [1]),
    .c(\sctl/sctl_dtct_sclr ),
    .o(_al_u97_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u98 (
    .a(_al_u97_o),
    .b(_al_u88_o),
    .o(_al_u98_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*C*D+A*B*C*D))"),
    .INIT(32'hc00a0000))
    _al_u99 (
    .a(_al_u88_o),
    .b(_al_u94_o),
    .c(\sctl/fsm/stat [0]),
    .d(\sctl/sctl_dtct_sclr ),
    .e(\sctl/sctl_read ),
    .o(_al_u99_o));
  reg_sr_as_w1 \sadr/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(sctl_stwsmsk_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsmsk[0]));  // rtl/stwslv.v(730)
  reg_sr_as_w1 \sadr/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(sctl_stwsmsk_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsmsk[1]));  // rtl/stwslv.v(730)
  reg_sr_as_w1 \sadr/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(sctl_stwsmsk_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsmsk[2]));  // rtl/stwslv.v(730)
  reg_sr_as_w1 \sadr/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(sctl_stwsmsk_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsmsk[3]));  // rtl/stwslv.v(730)
  reg_sr_as_w1 \sadr/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(sctl_stwsmsk_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsmsk[4]));  // rtl/stwslv.v(730)
  reg_sr_as_w1 \sadr/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(sctl_stwsmsk_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsmsk[5]));  // rtl/stwslv.v(730)
  reg_sr_as_w1 \sadr/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(sctl_stwsmsk_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsmsk[6]));  // rtl/stwslv.v(730)
  reg_sr_as_w1 \sadr/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(sctl_stwsadr_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsadr[0]));  // rtl/stwslv.v(720)
  reg_sr_as_w1 \sadr/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(sctl_stwsadr_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsadr[1]));  // rtl/stwslv.v(720)
  reg_sr_as_w1 \sadr/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(sctl_stwsadr_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsadr[2]));  // rtl/stwslv.v(720)
  reg_sr_as_w1 \sadr/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(sctl_stwsadr_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsadr[3]));  // rtl/stwslv.v(720)
  reg_sr_as_w1 \sadr/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(sctl_stwsadr_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsadr[4]));  // rtl/stwslv.v(720)
  reg_sr_as_w1 \sadr/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(sctl_stwsadr_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsadr[5]));  // rtl/stwslv.v(720)
  reg_sr_as_w1 \sadr/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(sctl_stwsadr_wr),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(stwsadr[6]));  // rtl/stwslv.v(720)
  reg_sr_as_w1 \sctl/fsm/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\sctl/fsm/mux1_b0_sel_is_1_o ),
    .set(1'b0),
    .q(\sctl/fsm/stat [0]));  // rtl/stws_fsm.v(112)
  reg_sr_as_w1 \sctl/fsm/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\sctl/fsm/mux1_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\sctl/fsm/stat [1]));  // rtl/stws_fsm.v(112)
  reg_sr_as_w1 \sctl/fsm/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\sctl/fsm/mux1_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\sctl/fsm/stat [2]));  // rtl/stws_fsm.v(112)
  reg_sr_as_w1 \sctl/fsm/reg0_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\sctl/fsm/mux1_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\sctl/fsm/stat [3]));  // rtl/stws_fsm.v(112)
  reg_sr_as_w1 \sctl/fsm/reg0_b4  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\sctl/fsm/mux1_b4_sel_is_3_o ),
    .set(1'b0),
    .q(\sctl/fsm/stat [4]));  // rtl/stws_fsm.v(112)
  reg_sr_as_w1 \sctl/fsm/sctl_dtct_sta_f_reg  (
    .clk(clk),
    .d(\sctl/sctl_dtct_sta ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/fsm/sctl_dtct_sta_f ));  // rtl/stws_fsm.v(112)
  reg_sr_as_w1 \sctl/fsm/sctl_lat_ack_reg  (
    .clk(clk),
    .d(\sctl/fsm/sctl_lat_ack_t ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/sctl_lat_ack ));  // rtl/stws_fsm.v(222)
  reg_sr_as_w1 \sctl/fsm/sctl_lat_ad_reg  (
    .clk(clk),
    .d(\sctl/fsm/sctl_lat_ad_t ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/sctl_lat_ad ));  // rtl/stws_fsm.v(206)
  reg_sr_as_w1 \sctl/fsm/sctl_lat_rv_reg  (
    .clk(clk),
    .d(\sctl/fsm/sctl_lat_rv_t ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_lat_rv));  // rtl/stws_fsm.v(214)
  reg_ar_ss_w1 \sctl/mctl_srst_reg  (
    .clk(clk),
    .d(\sctl/n0 ),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\sctl/mctl_srst ));  // rtl/stwslv.v(269)
  reg_sr_as_w1 \sctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\sctl/sctl_stwsctl_wr ),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_srae));  // rtl/stwslv.v(311)
  reg_sr_as_w1 \sctl/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\sctl/sctl_stwsctl_wr ),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_stae));  // rtl/stwslv.v(311)
  reg_ar_ss_w1 \sctl/reg1_b0  (
    .clk(clk),
    .d(stws_scl_i),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_scl [0]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg1_b1  (
    .clk(clk),
    .d(\sctl/synfil_scl [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_scl [1]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg1_b2  (
    .clk(clk),
    .d(\sctl/synfil_scl [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_scl [2]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg1_b3  (
    .clk(clk),
    .d(\sctl/synfil_scl [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_scl [3]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg1_b4  (
    .clk(clk),
    .d(\sctl/synfil_scl [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_scl [4]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg2_b0  (
    .clk(clk),
    .d(stws_sda_i),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_sda [0]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg2_b1  (
    .clk(clk),
    .d(\sctl/synfil_sda [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_sda [1]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg2_b2  (
    .clk(clk),
    .d(\sctl/synfil_sda [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_sda [2]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg2_b3  (
    .clk(clk),
    .d(\sctl/synfil_sda [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_sda [3]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg2_b4  (
    .clk(clk),
    .d(\sctl/synfil_sda [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/synfil_sda [4]));  // rtl/stwslv.v(338)
  reg_ar_ss_w1 \sctl/reg3_b0  (
    .clk(clk),
    .d(\sctl/sctl_scl_s ),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_scl_f [0]));  // rtl/stwslv.v(366)
  reg_ar_ss_w1 \sctl/reg3_b1  (
    .clk(clk),
    .d(\sctl/sctl_scl_f [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_scl_f [1]));  // rtl/stwslv.v(366)
  reg_ar_ss_w1 \sctl/reg3_b2  (
    .clk(clk),
    .d(\sctl/sctl_scl_f [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_scl_f [2]));  // rtl/stwslv.v(366)
  reg_ar_ss_w1 \sctl/reg3_b3  (
    .clk(clk),
    .d(\sctl/sctl_scl_f [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_scl_f [3]));  // rtl/stwslv.v(366)
  reg_ar_ss_w1 \sctl/reg4_b0  (
    .clk(clk),
    .d(sctl_sda_s),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_sda_f [0]));  // rtl/stwslv.v(366)
  reg_ar_ss_w1 \sctl/reg4_b1  (
    .clk(clk),
    .d(\sctl/sctl_sda_f [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_sda_f [1]));  // rtl/stwslv.v(366)
  reg_ar_ss_w1 \sctl/reg4_b2  (
    .clk(clk),
    .d(\sctl/sctl_sda_f [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_sda_f [2]));  // rtl/stwslv.v(366)
  reg_sr_as_w1 \sctl/sctl_ack_stat_reg  (
    .clk(clk),
    .d(\sctl/n74 ),
    .en(\sctl/sctl_lat_ack ),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_ack_stat));  // rtl/stwslv.v(488)
  reg_sr_as_w1 \sctl/sctl_dtct_sclf_reg  (
    .clk(clk),
    .d(\sctl/n45 ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_dtct_sclf));  // rtl/stwslv.v(383)
  reg_sr_as_w1 \sctl/sctl_dtct_sclr_reg  (
    .clk(clk),
    .d(\sctl/n43 ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/sctl_dtct_sclr ));  // rtl/stwslv.v(383)
  reg_sr_as_w1 \sctl/sctl_dtct_sta_reg  (
    .clk(clk),
    .d(\sctl/n51 ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/sctl_dtct_sta ));  // rtl/stwslv.v(426)
  reg_sr_as_w1 \sctl/sctl_dtct_stp_reg  (
    .clk(clk),
    .d(\sctl/n54 ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/sctl_dtct_stp ));  // rtl/stwslv.v(426)
  reg_sr_as_w1 \sctl/sctl_flg_sadr_reg  (
    .clk(clk),
    .d(\sctl/sctl_lat_ad ),
    .en(\bdatr_sadr[15]_en ),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_flg_sadr));  // rtl/stwslv.v(466)
  reg_sr_as_w1 \sctl/sctl_flg_ssta_reg  (
    .clk(clk),
    .d(\sctl/sctl_dtct_sta ),
    .en(\bdatr_sadr[15]_en ),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_flg_ssta));  // rtl/stwslv.v(466)
  reg_sr_as_w1 \sctl/sctl_flg_sstp_reg  (
    .clk(clk),
    .d(\sctl/sctl_dtct_stp ),
    .en(\bdatr_sadr[15]_en ),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_flg_sstp));  // rtl/stwslv.v(466)
  reg_sr_as_w1 \sctl/sctl_nak_rv_reg  (
    .clk(clk),
    .d(sctl_sda_s),
    .en(1'b1),
    .reset(~\sctl/u92_sel_is_3_o ),
    .set(1'b0),
    .q(sctl_nak_rv));  // rtl/stwslv.v(488)
  reg_sr_as_w1 \sctl/sctl_read_reg  (
    .clk(clk),
    .d(sdat_datr_sft[0]),
    .en(\sctl/sctl_lat_ad ),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/sctl_read ));  // rtl/stwslv.v(466)
  reg_ar_ss_w1 \sctl/sctl_sda_o_reg  (
    .clk(clk),
    .d(\sctl/sctl_sda_ob ),
    .en(sctl_dtct_sclf),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(\sctl/sctl_sda_o ));  // rtl/stwslv.v(505)
  reg_sr_as_w1 \sctl/sctl_stwsadr_rd_reg  (
    .clk(clk),
    .d(\sctl/n11 ),
    .en(brdy),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_stwsadr_rd));  // rtl/stwslv.v(295)
  reg_sr_as_w1 \sctl/sctl_stwsctl_rd_reg  (
    .clk(clk),
    .d(\sctl/n7 ),
    .en(brdy),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sctl/sctl_stwsctl_rd ));  // rtl/stwslv.v(295)
  reg_sr_as_w1 \sctl/sctl_stwsdatr_rd_reg  (
    .clk(clk),
    .d(\sctl/n9 ),
    .en(brdy),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_stwsdatr_rd));  // rtl/stwslv.v(295)
  reg_sr_as_w1 \sctl/sctl_stwsmsk_rd_reg  (
    .clk(clk),
    .d(\sctl/n13 ),
    .en(brdy),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sctl_stwsmsk_rd));  // rtl/stwslv.v(295)
  reg_ar_ss_w1 \sctl/stws_scl_o_reg  (
    .clk(clk),
    .d(\sctl/sctl_scl_ob ),
    .en(\sctl/n79 ),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(stws_scl_o));  // rtl/stwslv.v(505)
  reg_sr_as_w1 \sdat/reg0_b0  (
    .clk(clk),
    .d(\sdat/n8 [0]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [0]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg0_b1  (
    .clk(clk),
    .d(\sdat/n8 [1]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [1]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg0_b2  (
    .clk(clk),
    .d(\sdat/n8 [2]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [2]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg0_b3  (
    .clk(clk),
    .d(\sdat/n8 [3]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [3]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg0_b4  (
    .clk(clk),
    .d(\sdat/n8 [4]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [4]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg0_b5  (
    .clk(clk),
    .d(\sdat/n8 [5]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [5]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg0_b6  (
    .clk(clk),
    .d(\sdat/n8 [6]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [6]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg0_b7  (
    .clk(clk),
    .d(\sdat/n8 [7]),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/stwsdatr [7]));  // rtl/stwslv.v(625)
  reg_sr_as_w1 \sdat/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [0]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [1]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [2]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [3]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [4]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [5]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [6]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(sctl_stwsdats_wr),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/stwsdats [7]));  // rtl/stwslv.v(652)
  reg_sr_as_w1 \sdat/reg2_b0  (
    .clk(clk),
    .d(\sdat/sdat_dats_sft [1]),
    .en(sctl_sft_sd),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/sdat_dats_sft [0]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg2_b1  (
    .clk(clk),
    .d(\sdat/sdat_dats_sft [2]),
    .en(sctl_sft_sd),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/sdat_dats_sft [1]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg2_b2  (
    .clk(clk),
    .d(\sdat/sdat_dats_sft [3]),
    .en(sctl_sft_sd),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/sdat_dats_sft [2]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg2_b3  (
    .clk(clk),
    .d(\sdat/sdat_dats_sft [4]),
    .en(sctl_sft_sd),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/sdat_dats_sft [3]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg2_b4  (
    .clk(clk),
    .d(\sdat/sdat_dats_sft [5]),
    .en(sctl_sft_sd),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/sdat_dats_sft [4]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg2_b5  (
    .clk(clk),
    .d(\sdat/sdat_dats_sft [6]),
    .en(sctl_sft_sd),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/sdat_dats_sft [5]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg2_b6  (
    .clk(clk),
    .d(\sdat/sdat_dats_sft [7]),
    .en(sctl_sft_sd),
    .reset(\sdat/n11 ),
    .set(1'b0),
    .q(\sdat/sdat_dats_sft [6]));  // rtl/stwslv.v(671)
  reg_ar_ss_w1 \sdat/reg2_b7  (
    .clk(clk),
    .d(1'b0),
    .en(sctl_sft_sd),
    .reset(1'b0),
    .set(\sdat/n11 ),
    .q(\sdat/sdat_dats_sft [7]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b0  (
    .clk(clk),
    .d(\sdat/stwsdats [0]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [0]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b1  (
    .clk(clk),
    .d(\sdat/stwsdats [1]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [1]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b2  (
    .clk(clk),
    .d(\sdat/stwsdats [2]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [2]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b3  (
    .clk(clk),
    .d(\sdat/stwsdats [3]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [3]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b4  (
    .clk(clk),
    .d(\sdat/stwsdats [4]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [4]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b5  (
    .clk(clk),
    .d(\sdat/stwsdats [5]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [5]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b6  (
    .clk(clk),
    .d(\sdat/stwsdats [6]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [6]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg3_b7  (
    .clk(clk),
    .d(\sdat/stwsdats [7]),
    .en(sctl_rst_sd),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(\sdat/sdat_dats [7]));  // rtl/stwslv.v(671)
  reg_sr_as_w1 \sdat/reg4_b0  (
    .clk(clk),
    .d(sctl_sda_s),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[0]));  // rtl/stwslv.v(599)
  reg_sr_as_w1 \sdat/reg4_b1  (
    .clk(clk),
    .d(sdat_datr_sft[0]),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[1]));  // rtl/stwslv.v(599)
  reg_sr_as_w1 \sdat/reg4_b2  (
    .clk(clk),
    .d(sdat_datr_sft[1]),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[2]));  // rtl/stwslv.v(599)
  reg_sr_as_w1 \sdat/reg4_b3  (
    .clk(clk),
    .d(sdat_datr_sft[2]),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[3]));  // rtl/stwslv.v(599)
  reg_sr_as_w1 \sdat/reg4_b4  (
    .clk(clk),
    .d(sdat_datr_sft[3]),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[4]));  // rtl/stwslv.v(599)
  reg_sr_as_w1 \sdat/reg4_b5  (
    .clk(clk),
    .d(sdat_datr_sft[4]),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[5]));  // rtl/stwslv.v(599)
  reg_sr_as_w1 \sdat/reg4_b6  (
    .clk(clk),
    .d(sdat_datr_sft[5]),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[6]));  // rtl/stwslv.v(599)
  reg_sr_as_w1 \sdat/reg4_b7  (
    .clk(clk),
    .d(sdat_datr_sft[6]),
    .en(sctl_sft_rv),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_datr_sft[7]));  // rtl/stwslv.v(599)
  reg_ar_ss_w1 \sdat/sdat_sda_o_reg  (
    .clk(clk),
    .d(\sdat/n30 ),
    .en(sctl_dtct_sclf),
    .reset(1'b0),
    .set(~rst_slv_n),
    .q(sdat_sda_o));  // rtl/stwslv.v(682)
  reg_sr_as_w1 \sdat/sdat_sraf_reg  (
    .clk(clk),
    .d(\sdat/n4_d ),
    .en(1'b1),
    .reset(~rst_slv_n),
    .set(1'b0),
    .q(sdat_sraf));  // rtl/stwslv.v(625)
  reg_ar_ss_w1 \sdat/sdat_staf_reg  (
    .clk(clk),
    .d(1'b0),
    .en(sctl_stwsdats_wr),
    .reset(1'b0),
    .set(\sdat/n12 ),
    .q(sdat_staf));  // rtl/stwslv.v(652)

endmodule 

