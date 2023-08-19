
`timescale 1ns / 1ps
module loga8ch  // rtl/loga8ch.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_loga_n,
  bdatw,
  brdy,
  clk,
  ffdt_do,
  ffdt_empty,
  ffdt_full,
  fftk_do,
  fftk_empty,
  fftk_full,
  loga_dch,
  rst_n,
  bdatr,
  ffdt_di,
  ffdt_re,
  ffdt_rst,
  ffdt_we,
  fftk_di,
  fftk_re,
  fftk_rst,
  fftk_we,
  lctl_laer
  );
//
//	Logic analyzer unit
//		(c) 2021	1YEN Toru
//
//
//	2021/05/29	ver.1.00
//		8 channel edition
//		sampling rate: 24MHz
//

  input [3:0] badr;  // rtl/loga8ch.v(36)
  input bcmdr;  // rtl/loga8ch.v(34)
  input bcmdw;  // rtl/loga8ch.v(35)
  input bcs_loga_n;  // rtl/loga8ch.v(32)
  input [15:0] bdatw;  // rtl/loga8ch.v(37)
  input brdy;  // rtl/loga8ch.v(33)
  input clk;  // rtl/loga8ch.v(30)
  input [7:0] ffdt_do;  // rtl/loga8ch.v(46)
  input ffdt_empty;  // rtl/loga8ch.v(42)
  input ffdt_full;  // rtl/loga8ch.v(43)
  input [15:0] fftk_do;  // rtl/loga8ch.v(47)
  input fftk_empty;  // rtl/loga8ch.v(44)
  input fftk_full;  // rtl/loga8ch.v(45)
  input [7:0] loga_dch;  // rtl/loga8ch.v(38)
  input rst_n;  // rtl/loga8ch.v(31)
  output [15:0] bdatr;  // rtl/loga8ch.v(40)
  output [7:0] ffdt_di;  // rtl/loga8ch.v(54)
  output ffdt_re;  // rtl/loga8ch.v(49)
  output ffdt_rst;  // rtl/loga8ch.v(48)
  output ffdt_we;  // rtl/loga8ch.v(50)
  output [15:0] fftk_di;  // rtl/loga8ch.v(55)
  output fftk_re;  // rtl/loga8ch.v(52)
  output fftk_rst;  // rtl/loga8ch.v(51)
  output fftk_we;  // rtl/loga8ch.v(53)
  output lctl_laer;  // rtl/loga8ch.v(39)

  wire [7:0] \cdat/loga_dch_f1 ;  // rtl/loga_capt.v(102)
  wire [7:0] \cdat/loga_dch_f2 ;  // rtl/loga_capt.v(103)
  wire [7:0] \cdat/loga_dch_f3 ;  // rtl/loga_capt.v(104)
  wire [7:0] \cdat/logacmsk ;  // rtl/loga_capt.v(72)
  wire [7:0] \cdat/logatcnd ;  // rtl/loga_capt.v(92)
  wire [7:0] \cdat/logatmsk ;  // rtl/loga_capt.v(82)
  wire [7:0] \cdat/mskdat ;  // rtl/loga_capt.v(124)
  wire [7:0] \cdat/n12 ;
  wire [7:0] \cdat/n13 ;
  wire [7:0] \cdat/refdat ;  // rtl/loga_capt.v(123)
  wire [15:0] \ctck/n4 ;
  wire [1:0] \lctl/fsm/stat ;  // rtl/loga_fsm.v(44)
  wire [15:0] \lctl/logactl ;  // rtl/loga_lctl.v(124)
  wire [15:0] \maxc/logamaxc ;  // rtl/loga_maxcnt.v(30)
  wire [15:0] \maxc/maxcnt ;  // rtl/loga_maxcnt.v(63)
  wire [15:0] \maxc/n10 ;
  wire [14:0] \maxc/n6 ;
  wire [14:0] \maxc/psccnt ;  // rtl/loga_maxcnt.v(42)
  wire _al_u101_o;
  wire _al_u102_o;
  wire _al_u103_o;
  wire _al_u105_o;
  wire _al_u106_o;
  wire _al_u107_o;
  wire _al_u109_o;
  wire _al_u110_o;
  wire _al_u111_o;
  wire _al_u112_o;
  wire _al_u113_o;
  wire _al_u114_o;
  wire _al_u115_o;
  wire _al_u116_o;
  wire _al_u117_o;
  wire _al_u118_o;
  wire _al_u121_o;
  wire _al_u123_o;
  wire _al_u125_o;
  wire _al_u127_o;
  wire _al_u128_o;
  wire _al_u134_o;
  wire _al_u135_o;
  wire _al_u136_o;
  wire _al_u137_o;
  wire _al_u138_o;
  wire _al_u140_o;
  wire _al_u141_o;
  wire _al_u142_o;
  wire _al_u53_o;
  wire _al_u73_o;
  wire _al_u74_o;
  wire _al_u76_o;
  wire _al_u77_o;
  wire _al_u78_o;
  wire _al_u81_o;
  wire _al_u82_o;
  wire _al_u83_o;
  wire _al_u85_o;
  wire _al_u86_o;
  wire _al_u87_o;
  wire _al_u89_o;
  wire _al_u90_o;
  wire _al_u91_o;
  wire _al_u93_o;
  wire _al_u94_o;
  wire _al_u95_o;
  wire _al_u97_o;
  wire _al_u98_o;
  wire _al_u99_o;
  wire \cdat/eq0/xor_i0[2]_i1[2]_o_lutinv ;
  wire \cdat/eq0/xor_i0[3]_i1[3]_o_lutinv ;
  wire \cdat/eq0/xor_i0[6]_i1[6]_o_lutinv ;
  wire \cdat/eq0/xor_i0[7]_i1[7]_o_lutinv ;
  wire \ctck/add0/c0 ;
  wire \ctck/add0/c1 ;
  wire \ctck/add0/c10 ;
  wire \ctck/add0/c11 ;
  wire \ctck/add0/c12 ;
  wire \ctck/add0/c13 ;
  wire \ctck/add0/c14 ;
  wire \ctck/add0/c15 ;
  wire \ctck/add0/c2 ;
  wire \ctck/add0/c3 ;
  wire \ctck/add0/c4 ;
  wire \ctck/add0/c5 ;
  wire \ctck/add0/c6 ;
  wire \ctck/add0/c7 ;
  wire \ctck/add0/c8 ;
  wire \ctck/add0/c9 ;
  wire \ctck/n2 ;
  wire \ctck/n3 ;
  wire \lctl/fsm/mux0_b0_sel_is_1_o ;
  wire \lctl/fsm/mux0_b1_sel_is_1_o ;
  wire \lctl/fsm/sel0_b0_sel_o_neg_lutinv ;
  wire \lctl/lctl_laef ;  // rtl/loga_lctl.v(140)
  wire \lctl/lctl_laef_d ;
  wire \lctl/mux1_b0_sel_is_3_o ;
  wire \lctl/n10 ;
  wire \lctl/n12 ;
  wire \lctl/n13_lutinv ;
  wire \lctl/n16 ;
  wire \lctl/n2 ;
  wire \lctl/n20 ;
  wire \lctl/n38 ;
  wire \lctl/n4 ;
  wire \lctl/n48 ;
  wire \lctl/n6 ;
  wire \lctl/n8 ;
  wire \lctl/rd_logactl ;  // rtl/loga_lctl.v(81)
  wire \lctl/u57_sel_is_0_o ;
  wire \lctl/wr_logactl ;  // rtl/loga_lctl.v(117)
  wire lctl_load_trg_lutinv;  // rtl/loga8ch.v(100)
  wire \maxc/add0/c0 ;
  wire \maxc/add0/c1 ;
  wire \maxc/add0/c10 ;
  wire \maxc/add0/c11 ;
  wire \maxc/add0/c12 ;
  wire \maxc/add0/c13 ;
  wire \maxc/add0/c14 ;
  wire \maxc/add0/c2 ;
  wire \maxc/add0/c3 ;
  wire \maxc/add0/c4 ;
  wire \maxc/add0/c5 ;
  wire \maxc/add0/c6 ;
  wire \maxc/add0/c7 ;
  wire \maxc/add0/c8 ;
  wire \maxc/add0/c9 ;
  wire \maxc/add1/c0 ;
  wire \maxc/add1/c1 ;
  wire \maxc/add1/c10 ;
  wire \maxc/add1/c11 ;
  wire \maxc/add1/c12 ;
  wire \maxc/add1/c13 ;
  wire \maxc/add1/c14 ;
  wire \maxc/add1/c15 ;
  wire \maxc/add1/c2 ;
  wire \maxc/add1/c3 ;
  wire \maxc/add1/c4 ;
  wire \maxc/add1/c5 ;
  wire \maxc/add1/c6 ;
  wire \maxc/add1/c7 ;
  wire \maxc/add1/c8 ;
  wire \maxc/add1/c9 ;
  wire \maxc/ms_up ;  // rtl/loga_maxcnt.v(41)
  wire \maxc/mux4_b0_sel_is_0_o ;
  wire \maxc/n5 ;
  wire rd_logacdat;  // rtl/loga8ch.v(93)
  wire rd_logacmsk;  // rtl/loga8ch.v(89)
  wire rd_logactck;  // rtl/loga8ch.v(94)
  wire rd_logamaxc;  // rtl/loga8ch.v(92)
  wire rd_logatcnd;  // rtl/loga8ch.v(91)
  wire rd_logatmsk;  // rtl/loga8ch.v(90)
  wire wr_logacmsk;  // rtl/loga8ch.v(95)
  wire wr_logamaxc;  // rtl/loga8ch.v(98)
  wire wr_logatcnd;  // rtl/loga8ch.v(97)
  wire wr_logatmsk;  // rtl/loga8ch.v(96)

  assign fftk_rst = ffdt_rst;
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u100 (
    .a(_al_u99_o),
    .b(rd_logactck),
    .c(fftk_do[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u101 (
    .a(\cdat/logatmsk [1]),
    .b(\cdat/logatcnd [1]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u101_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h003a3a3a))
    _al_u102 (
    .a(_al_u101_o),
    .b(\cdat/logacmsk [1]),
    .c(rd_logacmsk),
    .d(\lctl/rd_logactl ),
    .e(\lctl/logactl [1]),
    .o(_al_u102_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u103 (
    .a(_al_u102_o),
    .b(rd_logacdat),
    .c(rd_logamaxc),
    .d(\maxc/logamaxc [1]),
    .e(ffdt_do[1]),
    .o(_al_u103_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u104 (
    .a(_al_u103_o),
    .b(rd_logactck),
    .c(fftk_do[1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u105 (
    .a(\cdat/logatmsk [0]),
    .b(\cdat/logatcnd [0]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u105_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h003a3a3a))
    _al_u106 (
    .a(_al_u105_o),
    .b(\cdat/logacmsk [0]),
    .c(rd_logacmsk),
    .d(\lctl/rd_logactl ),
    .e(\lctl/logactl [0]),
    .o(_al_u106_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u107 (
    .a(_al_u106_o),
    .b(rd_logacdat),
    .c(rd_logamaxc),
    .d(\maxc/logamaxc [0]),
    .e(ffdt_do[0]),
    .o(_al_u107_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u108 (
    .a(_al_u107_o),
    .b(rd_logactck),
    .c(fftk_do[0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u109 (
    .a(\maxc/maxcnt [0]),
    .b(\maxc/maxcnt [1]),
    .c(\maxc/logamaxc [0]),
    .d(\maxc/logamaxc [1]),
    .o(_al_u109_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u110 (
    .a(_al_u109_o),
    .b(\maxc/maxcnt [2]),
    .c(\maxc/maxcnt [3]),
    .d(\maxc/logamaxc [2]),
    .e(\maxc/logamaxc [3]),
    .o(_al_u110_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u111 (
    .a(\maxc/maxcnt [6]),
    .b(\maxc/maxcnt [7]),
    .c(\maxc/logamaxc [6]),
    .d(\maxc/logamaxc [7]),
    .o(_al_u111_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u112 (
    .a(_al_u111_o),
    .b(\maxc/maxcnt [4]),
    .c(\maxc/maxcnt [5]),
    .d(\maxc/logamaxc [4]),
    .e(\maxc/logamaxc [5]),
    .o(_al_u112_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u113 (
    .a(\maxc/maxcnt [14]),
    .b(\maxc/maxcnt [15]),
    .c(\maxc/logamaxc [14]),
    .d(\maxc/logamaxc [15]),
    .o(_al_u113_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u114 (
    .a(_al_u113_o),
    .b(\maxc/maxcnt [12]),
    .c(\maxc/maxcnt [13]),
    .d(\maxc/logamaxc [12]),
    .e(\maxc/logamaxc [13]),
    .o(_al_u114_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u115 (
    .a(\maxc/maxcnt [10]),
    .b(\maxc/maxcnt [11]),
    .c(\maxc/logamaxc [10]),
    .d(\maxc/logamaxc [11]),
    .o(_al_u115_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u116 (
    .a(_al_u115_o),
    .b(\maxc/maxcnt [8]),
    .c(\maxc/maxcnt [9]),
    .d(\maxc/logamaxc [8]),
    .e(\maxc/logamaxc [9]),
    .o(_al_u116_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u117 (
    .a(_al_u110_o),
    .b(_al_u112_o),
    .c(_al_u114_o),
    .d(_al_u116_o),
    .o(_al_u117_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u118 (
    .a(_al_u117_o),
    .b(ffdt_full),
    .c(fftk_full),
    .o(_al_u118_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(C*B*~A))"),
    .INIT(16'hff40))
    _al_u119 (
    .a(_al_u118_o),
    .b(\lctl/fsm/stat [0]),
    .c(\lctl/fsm/stat [1]),
    .d(\lctl/lctl_laef ),
    .o(\lctl/lctl_laef_d ));
  AL_MAP_LUT3 #(
    .EQN("(C*(B@A))"),
    .INIT(8'h60))
    _al_u120 (
    .a(\cdat/loga_dch_f2 [3]),
    .b(\cdat/refdat [3]),
    .c(\cdat/mskdat [3]),
    .o(\cdat/eq0/xor_i0[3]_i1[3]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*(C@B)))"),
    .INIT(16'h4155))
    _al_u121 (
    .a(\cdat/eq0/xor_i0[3]_i1[3]_o_lutinv ),
    .b(\cdat/loga_dch_f2 [0]),
    .c(\cdat/refdat [0]),
    .d(\cdat/mskdat [0]),
    .o(_al_u121_o));
  AL_MAP_LUT3 #(
    .EQN("(C*(B@A))"),
    .INIT(8'h60))
    _al_u122 (
    .a(\cdat/loga_dch_f2 [7]),
    .b(\cdat/refdat [7]),
    .c(\cdat/mskdat [7]),
    .o(\cdat/eq0/xor_i0[7]_i1[7]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*~(E*(D@C)))"),
    .INIT(32'h20022222))
    _al_u123 (
    .a(_al_u121_o),
    .b(\cdat/eq0/xor_i0[7]_i1[7]_o_lutinv ),
    .c(\cdat/loga_dch_f2 [4]),
    .d(\cdat/refdat [4]),
    .e(\cdat/mskdat [4]),
    .o(_al_u123_o));
  AL_MAP_LUT3 #(
    .EQN("(C*(B@A))"),
    .INIT(8'h60))
    _al_u124 (
    .a(\cdat/loga_dch_f2 [6]),
    .b(\cdat/refdat [6]),
    .c(\cdat/mskdat [6]),
    .o(\cdat/eq0/xor_i0[6]_i1[6]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*(C@B)))"),
    .INIT(16'h4155))
    _al_u125 (
    .a(\cdat/eq0/xor_i0[6]_i1[6]_o_lutinv ),
    .b(\cdat/loga_dch_f2 [5]),
    .c(\cdat/refdat [5]),
    .d(\cdat/mskdat [5]),
    .o(_al_u125_o));
  AL_MAP_LUT3 #(
    .EQN("(C*(B@A))"),
    .INIT(8'h60))
    _al_u126 (
    .a(\cdat/loga_dch_f2 [2]),
    .b(\cdat/refdat [2]),
    .c(\cdat/mskdat [2]),
    .o(\cdat/eq0/xor_i0[2]_i1[2]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*~(E*(D@C)))"),
    .INIT(32'h20022222))
    _al_u127 (
    .a(_al_u125_o),
    .b(\cdat/eq0/xor_i0[2]_i1[2]_o_lutinv ),
    .c(\cdat/loga_dch_f2 [1]),
    .d(\cdat/refdat [1]),
    .e(\cdat/mskdat [1]),
    .o(_al_u127_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u128 (
    .a(_al_u123_o),
    .b(_al_u127_o),
    .o(_al_u128_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u129 (
    .a(\lctl/logactl [1]),
    .b(rst_n),
    .o(\lctl/n48 ));
  AL_MAP_LUT5 #(
    .EQN("(C*(~(A)*~(B)*D*~(E)+A*~(B)*D*~(E)+~(A)*~(B)*~(D)*E+A*~(B)*~(D)*E+~(A)*B*~(D)*E+A*B*~(D)*E+A*~(B)*D*E+A*B*D*E))"),
    .INIT(32'ha0f03000))
    _al_u130 (
    .a(_al_u118_o),
    .b(_al_u128_o),
    .c(\lctl/n48 ),
    .d(\lctl/fsm/stat [0]),
    .e(\lctl/fsm/stat [1]),
    .o(\lctl/fsm/mux0_b1_sel_is_1_o ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'haccfacc0))
    _al_u131 (
    .a(_al_u118_o),
    .b(_al_u128_o),
    .c(\lctl/fsm/stat [0]),
    .d(\lctl/fsm/stat [1]),
    .e(\lctl/logactl [0]),
    .o(\lctl/fsm/sel0_b0_sel_o_neg_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u132 (
    .a(\lctl/fsm/sel0_b0_sel_o_neg_lutinv ),
    .b(\lctl/n48 ),
    .o(\lctl/fsm/mux0_b0_sel_is_1_o ));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u133 (
    .a(\lctl/fsm/stat [0]),
    .b(\lctl/fsm/stat [1]),
    .c(rst_n),
    .o(\ctck/n2 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u134 (
    .a(fftk_di[0]),
    .b(fftk_di[1]),
    .c(fftk_di[10]),
    .d(fftk_di[11]),
    .o(_al_u134_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u135 (
    .a(_al_u134_o),
    .b(fftk_di[12]),
    .c(fftk_di[13]),
    .d(fftk_di[14]),
    .e(fftk_di[15]),
    .o(_al_u135_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u136 (
    .a(fftk_di[2]),
    .b(fftk_di[3]),
    .c(fftk_di[4]),
    .d(fftk_di[5]),
    .o(_al_u136_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u137 (
    .a(_al_u136_o),
    .b(fftk_di[6]),
    .c(fftk_di[7]),
    .d(fftk_di[8]),
    .e(fftk_di[9]),
    .o(_al_u137_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u138 (
    .a(_al_u135_o),
    .b(_al_u137_o),
    .o(_al_u138_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(A*~(~C*B)))"),
    .INIT(16'hffa2))
    _al_u139 (
    .a(_al_u118_o),
    .b(_al_u128_o),
    .c(_al_u138_o),
    .d(\ctck/n2 ),
    .o(\ctck/n3 ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u140 (
    .a(_al_u118_o),
    .b(\lctl/fsm/stat [0]),
    .c(\lctl/fsm/stat [1]),
    .o(_al_u140_o));
  AL_MAP_LUT4 #(
    .EQN("(D*(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca00))
    _al_u141 (
    .a(_al_u128_o),
    .b(_al_u117_o),
    .c(\lctl/fsm/stat [0]),
    .d(\lctl/fsm/stat [1]),
    .o(_al_u141_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(A*~(~D*C)))"),
    .INIT(16'h1131))
    _al_u142 (
    .a(_al_u140_o),
    .b(_al_u141_o),
    .c(_al_u128_o),
    .d(_al_u138_o),
    .o(_al_u142_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u143 (
    .a(_al_u142_o),
    .b(ffdt_full),
    .o(ffdt_we));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u144 (
    .a(_al_u142_o),
    .b(fftk_full),
    .o(fftk_we));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u145 (
    .a(\maxc/n5 ),
    .b(\ctck/n2 ),
    .o(\maxc/mux4_b0_sel_is_0_o ));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u146 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [7]),
    .d(\cdat/loga_dch_f2 [7]),
    .e(\cdat/refdat [7]),
    .o(\cdat/n12 [7]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u147 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [6]),
    .d(\cdat/loga_dch_f2 [6]),
    .e(\cdat/refdat [6]),
    .o(\cdat/n12 [6]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u148 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [5]),
    .d(\cdat/loga_dch_f2 [5]),
    .e(\cdat/refdat [5]),
    .o(\cdat/n12 [5]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u149 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [4]),
    .d(\cdat/loga_dch_f2 [4]),
    .e(\cdat/refdat [4]),
    .o(\cdat/n12 [4]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u150 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [3]),
    .d(\cdat/loga_dch_f2 [3]),
    .e(\cdat/refdat [3]),
    .o(\cdat/n12 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u151 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [2]),
    .d(\cdat/loga_dch_f2 [2]),
    .e(\cdat/refdat [2]),
    .o(\cdat/n12 [2]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u152 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [1]),
    .d(\cdat/loga_dch_f2 [1]),
    .e(\cdat/refdat [1]),
    .o(\cdat/n12 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(C)*~(B)+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*~(B)+~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*C*B+(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*C*B)"),
    .INIT(32'hf3e2d1c0))
    _al_u153 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatcnd [0]),
    .d(\cdat/loga_dch_f2 [0]),
    .e(\cdat/refdat [0]),
    .o(\cdat/n12 [0]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u154 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [7]),
    .d(\cdat/mskdat [7]),
    .e(\cdat/logacmsk [7]),
    .o(\cdat/n13 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u155 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [6]),
    .d(\cdat/mskdat [6]),
    .e(\cdat/logacmsk [6]),
    .o(\cdat/n13 [6]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u156 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [5]),
    .d(\cdat/mskdat [5]),
    .e(\cdat/logacmsk [5]),
    .o(\cdat/n13 [5]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u157 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [4]),
    .d(\cdat/mskdat [4]),
    .e(\cdat/logacmsk [4]),
    .o(\cdat/n13 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u158 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [3]),
    .d(\cdat/mskdat [3]),
    .e(\cdat/logacmsk [3]),
    .o(\cdat/n13 [3]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u159 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [2]),
    .d(\cdat/mskdat [2]),
    .e(\cdat/logacmsk [2]),
    .o(\cdat/n13 [2]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u160 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [1]),
    .d(\cdat/mskdat [1]),
    .e(\cdat/logacmsk [1]),
    .o(\cdat/n13 [1]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*~(C)*~(B)+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*~(B)+~((E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))*C*B+(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A)*C*B)"),
    .INIT(32'hf3d1e2c0))
    _al_u161 (
    .a(_al_u142_o),
    .b(lctl_load_trg_lutinv),
    .c(\cdat/logatmsk [0]),
    .d(\cdat/mskdat [0]),
    .e(\cdat/logacmsk [0]),
    .o(\cdat/n13 [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u35 (
    .a(\cdat/loga_dch_f3 [0]),
    .b(\cdat/logacmsk [0]),
    .o(ffdt_di[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u36 (
    .a(\cdat/loga_dch_f3 [1]),
    .b(\cdat/logacmsk [1]),
    .o(ffdt_di[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u37 (
    .a(\cdat/loga_dch_f3 [2]),
    .b(\cdat/logacmsk [2]),
    .o(ffdt_di[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u38 (
    .a(\cdat/loga_dch_f3 [3]),
    .b(\cdat/logacmsk [3]),
    .o(ffdt_di[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u39 (
    .a(\cdat/loga_dch_f3 [4]),
    .b(\cdat/logacmsk [4]),
    .o(ffdt_di[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u40 (
    .a(\cdat/loga_dch_f3 [5]),
    .b(\cdat/logacmsk [5]),
    .o(ffdt_di[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u41 (
    .a(\cdat/loga_dch_f3 [6]),
    .b(\cdat/logacmsk [6]),
    .o(ffdt_di[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u42 (
    .a(\cdat/loga_dch_f3 [7]),
    .b(\cdat/logacmsk [7]),
    .o(ffdt_di[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u43 (
    .a(\lctl/lctl_laef ),
    .b(\lctl/logactl [3]),
    .o(lctl_laer));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u44 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [10]),
    .d(fftk_do[10]),
    .o(bdatr[10]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u45 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [11]),
    .d(fftk_do[11]),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u46 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [12]),
    .d(fftk_do[12]),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u47 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [13]),
    .d(fftk_do[13]),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u48 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [14]),
    .d(fftk_do[14]),
    .o(bdatr[14]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u49 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [15]),
    .d(fftk_do[15]),
    .o(bdatr[15]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u50 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [8]),
    .d(fftk_do[8]),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u51 (
    .a(rd_logactck),
    .b(rd_logamaxc),
    .c(\maxc/logamaxc [9]),
    .d(fftk_do[9]),
    .o(bdatr[9]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u52 (
    .a(bcmdr),
    .b(bcs_loga_n),
    .o(\lctl/n2 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u53 (
    .a(\lctl/n2 ),
    .b(badr[1]),
    .c(badr[0]),
    .o(_al_u53_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u54 (
    .a(_al_u53_o),
    .b(badr[3]),
    .c(badr[2]),
    .o(\lctl/n4 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u55 (
    .a(bcmdw),
    .b(bcs_loga_n),
    .c(brdy),
    .o(\lctl/n38 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u56 (
    .a(\lctl/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\lctl/wr_logactl ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u57 (
    .a(\lctl/fsm/stat [0]),
    .b(\lctl/fsm/stat [1]),
    .c(\lctl/logactl [0]),
    .o(lctl_load_trg_lutinv));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u58 (
    .a(lctl_load_trg_lutinv),
    .b(\lctl/logactl [2]),
    .o(ffdt_rst));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u59 (
    .a(_al_u53_o),
    .b(badr[3]),
    .c(badr[2]),
    .o(\lctl/n12 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u60 (
    .a(\lctl/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_logamaxc));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u61 (
    .a(_al_u53_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(brdy),
    .o(ffdt_re));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u62 (
    .a(_al_u53_o),
    .b(badr[3]),
    .c(badr[2]),
    .o(\lctl/n8 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u63 (
    .a(\lctl/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_logatmsk));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u64 (
    .a(badr[3]),
    .b(badr[2]),
    .c(badr[1]),
    .d(badr[0]),
    .o(\lctl/n13_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u65 (
    .a(\lctl/n13_lutinv ),
    .b(\lctl/n2 ),
    .c(brdy),
    .o(fftk_re));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u66 (
    .a(\lctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\lctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u67 (
    .a(\lctl/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_logatcnd));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u68 (
    .a(\lctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\lctl/n6 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u69 (
    .a(\lctl/n38 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_logacmsk));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u70 (
    .a(\lctl/wr_logactl ),
    .b(rst_n),
    .o(\lctl/mux1_b0_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u71 (
    .a(_al_u53_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(ffdt_empty),
    .o(\lctl/n20 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u72 (
    .a(\lctl/n13_lutinv ),
    .b(\lctl/n2 ),
    .c(fftk_empty),
    .o(\lctl/n16 ));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u73 (
    .a(\cdat/logatmsk [6]),
    .b(\cdat/logatcnd [6]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u73_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h003a3a3a))
    _al_u74 (
    .a(_al_u73_o),
    .b(\cdat/logacmsk [6]),
    .c(rd_logacmsk),
    .d(rd_logamaxc),
    .e(\maxc/logamaxc [6]),
    .o(_al_u74_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u75 (
    .a(_al_u74_o),
    .b(rd_logacdat),
    .c(rd_logactck),
    .d(ffdt_do[6]),
    .e(fftk_do[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u76 (
    .a(\maxc/psccnt [0]),
    .b(\maxc/psccnt [1]),
    .c(\maxc/psccnt [10]),
    .d(\maxc/psccnt [11]),
    .o(_al_u76_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u77 (
    .a(_al_u76_o),
    .b(\maxc/psccnt [12]),
    .c(\maxc/psccnt [13]),
    .d(\maxc/psccnt [14]),
    .e(\maxc/psccnt [2]),
    .o(_al_u77_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u78 (
    .a(\maxc/psccnt [3]),
    .b(\maxc/psccnt [4]),
    .c(\maxc/psccnt [5]),
    .d(\maxc/psccnt [6]),
    .o(_al_u78_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u79 (
    .a(_al_u77_o),
    .b(_al_u78_o),
    .c(\maxc/psccnt [7]),
    .d(\maxc/psccnt [8]),
    .e(\maxc/psccnt [9]),
    .o(\maxc/n5 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~B*~(C*A))"),
    .INIT(16'h1300))
    _al_u80 (
    .a(\lctl/wr_logactl ),
    .b(\lctl/logactl [0]),
    .c(bdatw[7]),
    .d(rst_n),
    .o(\lctl/u57_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u81 (
    .a(\cdat/logatmsk [7]),
    .b(\cdat/logatcnd [7]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u81_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(E*C))"),
    .INIT(32'h030a33aa))
    _al_u82 (
    .a(_al_u81_o),
    .b(\cdat/logacmsk [7]),
    .c(\lctl/lctl_laef ),
    .d(rd_logacmsk),
    .e(\lctl/rd_logactl ),
    .o(_al_u82_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u83 (
    .a(_al_u82_o),
    .b(rd_logacdat),
    .c(rd_logamaxc),
    .d(\maxc/logamaxc [7]),
    .e(ffdt_do[7]),
    .o(_al_u83_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u84 (
    .a(_al_u83_o),
    .b(rd_logactck),
    .c(fftk_do[7]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u85 (
    .a(\cdat/logatmsk [5]),
    .b(\cdat/logatcnd [5]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u85_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h3a3a003a))
    _al_u86 (
    .a(_al_u85_o),
    .b(\cdat/logacmsk [5]),
    .c(rd_logacmsk),
    .d(\lctl/rd_logactl ),
    .e(ffdt_empty),
    .o(_al_u86_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u87 (
    .a(_al_u86_o),
    .b(rd_logacdat),
    .c(rd_logamaxc),
    .d(\maxc/logamaxc [5]),
    .e(ffdt_do[5]),
    .o(_al_u87_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u88 (
    .a(_al_u87_o),
    .b(rd_logactck),
    .c(fftk_do[5]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u89 (
    .a(\cdat/logatmsk [4]),
    .b(\cdat/logatcnd [4]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u89_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h3a3a003a))
    _al_u90 (
    .a(_al_u89_o),
    .b(\cdat/logacmsk [4]),
    .c(rd_logacmsk),
    .d(\lctl/rd_logactl ),
    .e(fftk_empty),
    .o(_al_u90_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u91 (
    .a(_al_u90_o),
    .b(rd_logacdat),
    .c(rd_logamaxc),
    .d(\maxc/logamaxc [4]),
    .e(ffdt_do[4]),
    .o(_al_u91_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u92 (
    .a(_al_u91_o),
    .b(rd_logactck),
    .c(fftk_do[4]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u93 (
    .a(\cdat/logatmsk [3]),
    .b(\cdat/logatcnd [3]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u93_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h003a3a3a))
    _al_u94 (
    .a(_al_u93_o),
    .b(\cdat/logacmsk [3]),
    .c(rd_logacmsk),
    .d(\lctl/rd_logactl ),
    .e(\lctl/logactl [3]),
    .o(_al_u94_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u95 (
    .a(_al_u94_o),
    .b(rd_logacdat),
    .c(rd_logamaxc),
    .d(\maxc/logamaxc [3]),
    .e(ffdt_do[3]),
    .o(_al_u95_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u96 (
    .a(_al_u95_o),
    .b(rd_logactck),
    .c(fftk_do[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u97 (
    .a(\cdat/logatmsk [2]),
    .b(\cdat/logatcnd [2]),
    .c(rd_logatcnd),
    .d(rd_logatmsk),
    .o(_al_u97_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*D)*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h003a3a3a))
    _al_u98 (
    .a(_al_u97_o),
    .b(\cdat/logacmsk [2]),
    .c(rd_logacmsk),
    .d(\lctl/rd_logactl ),
    .e(\lctl/logactl [2]),
    .o(_al_u98_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u99 (
    .a(_al_u98_o),
    .b(rd_logacdat),
    .c(rd_logamaxc),
    .d(\maxc/logamaxc [2]),
    .e(ffdt_do[2]),
    .o(_al_u99_o));
  reg_sr_as_w1 \cdat/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [0]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [1]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [2]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [3]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [4]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [5]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [6]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_logatmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatmsk [7]));  // rtl/loga_capt.v(89)
  reg_sr_as_w1 \cdat/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [0]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [1]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [2]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [3]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [4]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [5]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [6]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_logatcnd),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logatcnd [7]));  // rtl/loga_capt.v(99)
  reg_sr_as_w1 \cdat/reg2_b0  (
    .clk(clk),
    .d(loga_dch[0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [0]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg2_b1  (
    .clk(clk),
    .d(loga_dch[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [1]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg2_b2  (
    .clk(clk),
    .d(loga_dch[2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [2]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg2_b3  (
    .clk(clk),
    .d(loga_dch[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [3]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg2_b4  (
    .clk(clk),
    .d(loga_dch[4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [4]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg2_b5  (
    .clk(clk),
    .d(loga_dch[5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [5]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg2_b6  (
    .clk(clk),
    .d(loga_dch[6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [6]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg2_b7  (
    .clk(clk),
    .d(loga_dch[7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f1 [7]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b0  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [0]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b1  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [1]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b2  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [2]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b3  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [3]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b4  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [4]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b5  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [5]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b6  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [6]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg3_b7  (
    .clk(clk),
    .d(\cdat/loga_dch_f1 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f2 [7]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b0  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [0]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b1  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [1]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b2  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [2]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b3  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [3]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b4  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [4]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b5  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [5]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b6  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [6]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg4_b7  (
    .clk(clk),
    .d(\cdat/loga_dch_f2 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/loga_dch_f3 [7]));  // rtl/loga_capt.v(119)
  reg_sr_as_w1 \cdat/reg5_b0  (
    .clk(clk),
    .d(\cdat/n12 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [0]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg5_b1  (
    .clk(clk),
    .d(\cdat/n12 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [1]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg5_b2  (
    .clk(clk),
    .d(\cdat/n12 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [2]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg5_b3  (
    .clk(clk),
    .d(\cdat/n12 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [3]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg5_b4  (
    .clk(clk),
    .d(\cdat/n12 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [4]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg5_b5  (
    .clk(clk),
    .d(\cdat/n12 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [5]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg5_b6  (
    .clk(clk),
    .d(\cdat/n12 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [6]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg5_b7  (
    .clk(clk),
    .d(\cdat/n12 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/refdat [7]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b0  (
    .clk(clk),
    .d(\cdat/n13 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [0]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b1  (
    .clk(clk),
    .d(\cdat/n13 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [1]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b2  (
    .clk(clk),
    .d(\cdat/n13 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [2]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b3  (
    .clk(clk),
    .d(\cdat/n13 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [3]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b4  (
    .clk(clk),
    .d(\cdat/n13 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [4]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b5  (
    .clk(clk),
    .d(\cdat/n13 [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [5]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b6  (
    .clk(clk),
    .d(\cdat/n13 [6]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [6]));  // rtl/loga_capt.v(142)
  reg_ar_ss_w1 \cdat/reg6_b7  (
    .clk(clk),
    .d(\cdat/n13 [7]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\cdat/mskdat [7]));  // rtl/loga_capt.v(142)
  reg_sr_as_w1 \cdat/reg7_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [0]));  // rtl/loga_capt.v(79)
  reg_sr_as_w1 \cdat/reg7_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [1]));  // rtl/loga_capt.v(79)
  reg_sr_as_w1 \cdat/reg7_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [2]));  // rtl/loga_capt.v(79)
  reg_sr_as_w1 \cdat/reg7_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [3]));  // rtl/loga_capt.v(79)
  reg_sr_as_w1 \cdat/reg7_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [4]));  // rtl/loga_capt.v(79)
  reg_sr_as_w1 \cdat/reg7_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [5]));  // rtl/loga_capt.v(79)
  reg_sr_as_w1 \cdat/reg7_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [6]));  // rtl/loga_capt.v(79)
  reg_sr_as_w1 \cdat/reg7_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_logacmsk),
    .reset(~rst_n),
    .set(1'b0),
    .q(\cdat/logacmsk [7]));  // rtl/loga_capt.v(79)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u0  (
    .a(fftk_di[0]),
    .b(1'b1),
    .c(\ctck/add0/c0 ),
    .o({\ctck/add0/c1 ,\ctck/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u1  (
    .a(fftk_di[1]),
    .b(1'b0),
    .c(\ctck/add0/c1 ),
    .o({\ctck/add0/c2 ,\ctck/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u10  (
    .a(fftk_di[10]),
    .b(1'b0),
    .c(\ctck/add0/c10 ),
    .o({\ctck/add0/c11 ,\ctck/n4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u11  (
    .a(fftk_di[11]),
    .b(1'b0),
    .c(\ctck/add0/c11 ),
    .o({\ctck/add0/c12 ,\ctck/n4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u12  (
    .a(fftk_di[12]),
    .b(1'b0),
    .c(\ctck/add0/c12 ),
    .o({\ctck/add0/c13 ,\ctck/n4 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u13  (
    .a(fftk_di[13]),
    .b(1'b0),
    .c(\ctck/add0/c13 ),
    .o({\ctck/add0/c14 ,\ctck/n4 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u14  (
    .a(fftk_di[14]),
    .b(1'b0),
    .c(\ctck/add0/c14 ),
    .o({\ctck/add0/c15 ,\ctck/n4 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u15  (
    .a(fftk_di[15]),
    .b(1'b0),
    .c(\ctck/add0/c15 ),
    .o({open_n0,\ctck/n4 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u2  (
    .a(fftk_di[2]),
    .b(1'b0),
    .c(\ctck/add0/c2 ),
    .o({\ctck/add0/c3 ,\ctck/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u3  (
    .a(fftk_di[3]),
    .b(1'b0),
    .c(\ctck/add0/c3 ),
    .o({\ctck/add0/c4 ,\ctck/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u4  (
    .a(fftk_di[4]),
    .b(1'b0),
    .c(\ctck/add0/c4 ),
    .o({\ctck/add0/c5 ,\ctck/n4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u5  (
    .a(fftk_di[5]),
    .b(1'b0),
    .c(\ctck/add0/c5 ),
    .o({\ctck/add0/c6 ,\ctck/n4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u6  (
    .a(fftk_di[6]),
    .b(1'b0),
    .c(\ctck/add0/c6 ),
    .o({\ctck/add0/c7 ,\ctck/n4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u7  (
    .a(fftk_di[7]),
    .b(1'b0),
    .c(\ctck/add0/c7 ),
    .o({\ctck/add0/c8 ,\ctck/n4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u8  (
    .a(fftk_di[8]),
    .b(1'b0),
    .c(\ctck/add0/c8 ),
    .o({\ctck/add0/c9 ,\ctck/n4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ctck/add0/u9  (
    .a(fftk_di[9]),
    .b(1'b0),
    .c(\ctck/add0/c9 ),
    .o({\ctck/add0/c10 ,\ctck/n4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \ctck/add0/ucin  (
    .a(1'b0),
    .o({\ctck/add0/c0 ,open_n3}));
  reg_sr_as_w1 \ctck/reg0_b0  (
    .clk(clk),
    .d(\ctck/n4 [0]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[0]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b1  (
    .clk(clk),
    .d(\ctck/n4 [1]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[1]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b10  (
    .clk(clk),
    .d(\ctck/n4 [10]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[10]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b11  (
    .clk(clk),
    .d(\ctck/n4 [11]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[11]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b12  (
    .clk(clk),
    .d(\ctck/n4 [12]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[12]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b13  (
    .clk(clk),
    .d(\ctck/n4 [13]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[13]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b14  (
    .clk(clk),
    .d(\ctck/n4 [14]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[14]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b15  (
    .clk(clk),
    .d(\ctck/n4 [15]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[15]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b2  (
    .clk(clk),
    .d(\ctck/n4 [2]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[2]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b3  (
    .clk(clk),
    .d(\ctck/n4 [3]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[3]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b4  (
    .clk(clk),
    .d(\ctck/n4 [4]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[4]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b5  (
    .clk(clk),
    .d(\ctck/n4 [5]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[5]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b6  (
    .clk(clk),
    .d(\ctck/n4 [6]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[6]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b7  (
    .clk(clk),
    .d(\ctck/n4 [7]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[7]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b8  (
    .clk(clk),
    .d(\ctck/n4 [8]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[8]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \ctck/reg0_b9  (
    .clk(clk),
    .d(\ctck/n4 [9]),
    .en(1'b1),
    .reset(\ctck/n3 ),
    .set(1'b0),
    .q(fftk_di[9]));  // rtl/loga_capt.v(26)
  reg_sr_as_w1 \lctl/fsm/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\lctl/fsm/mux0_b0_sel_is_1_o ),
    .set(1'b0),
    .q(\lctl/fsm/stat [0]));  // rtl/loga_fsm.v(74)
  reg_sr_as_w1 \lctl/fsm/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\lctl/fsm/mux0_b1_sel_is_1_o ),
    .set(1'b0),
    .q(\lctl/fsm/stat [1]));  // rtl/loga_fsm.v(74)
  reg_sr_as_w1 \lctl/lctl_laef_reg  (
    .clk(clk),
    .d(\lctl/lctl_laef_d ),
    .en(1'b1),
    .reset(~\lctl/u57_sel_is_0_o ),
    .set(1'b0),
    .q(\lctl/lctl_laef ));  // rtl/loga_lctl.v(149)
  reg_sr_as_w1 \lctl/rd_logacdat_reg  (
    .clk(clk),
    .d(\lctl/n20 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_logacdat));  // rtl/loga_lctl.v(112)
  reg_sr_as_w1 \lctl/rd_logacmsk_reg  (
    .clk(clk),
    .d(\lctl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_logacmsk));  // rtl/loga_lctl.v(112)
  reg_sr_as_w1 \lctl/rd_logactck_reg  (
    .clk(clk),
    .d(\lctl/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_logactck));  // rtl/loga_lctl.v(112)
  reg_sr_as_w1 \lctl/rd_logactl_reg  (
    .clk(clk),
    .d(\lctl/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\lctl/rd_logactl ));  // rtl/loga_lctl.v(112)
  reg_sr_as_w1 \lctl/rd_logamaxc_reg  (
    .clk(clk),
    .d(\lctl/n12 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_logamaxc));  // rtl/loga_lctl.v(112)
  reg_sr_as_w1 \lctl/rd_logatcnd_reg  (
    .clk(clk),
    .d(\lctl/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_logatcnd));  // rtl/loga_lctl.v(112)
  reg_sr_as_w1 \lctl/rd_logatmsk_reg  (
    .clk(clk),
    .d(\lctl/n8 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_logatmsk));  // rtl/loga_lctl.v(112)
  reg_sr_as_w1 \lctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(1'b1),
    .reset(~\lctl/mux1_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\lctl/logactl [0]));  // rtl/loga_lctl.v(133)
  reg_sr_as_w1 \lctl/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(1'b1),
    .reset(~\lctl/mux1_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\lctl/logactl [1]));  // rtl/loga_lctl.v(133)
  reg_sr_as_w1 \lctl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(1'b1),
    .reset(~\lctl/mux1_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\lctl/logactl [2]));  // rtl/loga_lctl.v(133)
  reg_sr_as_w1 \lctl/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\lctl/wr_logactl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\lctl/logactl [3]));  // rtl/loga_lctl.v(133)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u0  (
    .a(\maxc/psccnt [0]),
    .b(1'b1),
    .c(\maxc/add0/c0 ),
    .o({\maxc/add0/c1 ,\maxc/n6 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u1  (
    .a(\maxc/psccnt [1]),
    .b(1'b0),
    .c(\maxc/add0/c1 ),
    .o({\maxc/add0/c2 ,\maxc/n6 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u10  (
    .a(\maxc/psccnt [10]),
    .b(1'b0),
    .c(\maxc/add0/c10 ),
    .o({\maxc/add0/c11 ,\maxc/n6 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u11  (
    .a(\maxc/psccnt [11]),
    .b(1'b0),
    .c(\maxc/add0/c11 ),
    .o({\maxc/add0/c12 ,\maxc/n6 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u12  (
    .a(\maxc/psccnt [12]),
    .b(1'b0),
    .c(\maxc/add0/c12 ),
    .o({\maxc/add0/c13 ,\maxc/n6 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u13  (
    .a(\maxc/psccnt [13]),
    .b(1'b0),
    .c(\maxc/add0/c13 ),
    .o({\maxc/add0/c14 ,\maxc/n6 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u14  (
    .a(\maxc/psccnt [14]),
    .b(1'b0),
    .c(\maxc/add0/c14 ),
    .o({open_n4,\maxc/n6 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u2  (
    .a(\maxc/psccnt [2]),
    .b(1'b0),
    .c(\maxc/add0/c2 ),
    .o({\maxc/add0/c3 ,\maxc/n6 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u3  (
    .a(\maxc/psccnt [3]),
    .b(1'b0),
    .c(\maxc/add0/c3 ),
    .o({\maxc/add0/c4 ,\maxc/n6 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u4  (
    .a(\maxc/psccnt [4]),
    .b(1'b0),
    .c(\maxc/add0/c4 ),
    .o({\maxc/add0/c5 ,\maxc/n6 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u5  (
    .a(\maxc/psccnt [5]),
    .b(1'b0),
    .c(\maxc/add0/c5 ),
    .o({\maxc/add0/c6 ,\maxc/n6 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u6  (
    .a(\maxc/psccnt [6]),
    .b(1'b0),
    .c(\maxc/add0/c6 ),
    .o({\maxc/add0/c7 ,\maxc/n6 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u7  (
    .a(\maxc/psccnt [7]),
    .b(1'b0),
    .c(\maxc/add0/c7 ),
    .o({\maxc/add0/c8 ,\maxc/n6 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u8  (
    .a(\maxc/psccnt [8]),
    .b(1'b0),
    .c(\maxc/add0/c8 ),
    .o({\maxc/add0/c9 ,\maxc/n6 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add0/u9  (
    .a(\maxc/psccnt [9]),
    .b(1'b0),
    .c(\maxc/add0/c9 ),
    .o({\maxc/add0/c10 ,\maxc/n6 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \maxc/add0/ucin  (
    .a(1'b0),
    .o({\maxc/add0/c0 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u0  (
    .a(\maxc/maxcnt [0]),
    .b(1'b1),
    .c(\maxc/add1/c0 ),
    .o({\maxc/add1/c1 ,\maxc/n10 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u1  (
    .a(\maxc/maxcnt [1]),
    .b(1'b0),
    .c(\maxc/add1/c1 ),
    .o({\maxc/add1/c2 ,\maxc/n10 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u10  (
    .a(\maxc/maxcnt [10]),
    .b(1'b0),
    .c(\maxc/add1/c10 ),
    .o({\maxc/add1/c11 ,\maxc/n10 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u11  (
    .a(\maxc/maxcnt [11]),
    .b(1'b0),
    .c(\maxc/add1/c11 ),
    .o({\maxc/add1/c12 ,\maxc/n10 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u12  (
    .a(\maxc/maxcnt [12]),
    .b(1'b0),
    .c(\maxc/add1/c12 ),
    .o({\maxc/add1/c13 ,\maxc/n10 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u13  (
    .a(\maxc/maxcnt [13]),
    .b(1'b0),
    .c(\maxc/add1/c13 ),
    .o({\maxc/add1/c14 ,\maxc/n10 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u14  (
    .a(\maxc/maxcnt [14]),
    .b(1'b0),
    .c(\maxc/add1/c14 ),
    .o({\maxc/add1/c15 ,\maxc/n10 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u15  (
    .a(\maxc/maxcnt [15]),
    .b(1'b0),
    .c(\maxc/add1/c15 ),
    .o({open_n8,\maxc/n10 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u2  (
    .a(\maxc/maxcnt [2]),
    .b(1'b0),
    .c(\maxc/add1/c2 ),
    .o({\maxc/add1/c3 ,\maxc/n10 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u3  (
    .a(\maxc/maxcnt [3]),
    .b(1'b0),
    .c(\maxc/add1/c3 ),
    .o({\maxc/add1/c4 ,\maxc/n10 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u4  (
    .a(\maxc/maxcnt [4]),
    .b(1'b0),
    .c(\maxc/add1/c4 ),
    .o({\maxc/add1/c5 ,\maxc/n10 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u5  (
    .a(\maxc/maxcnt [5]),
    .b(1'b0),
    .c(\maxc/add1/c5 ),
    .o({\maxc/add1/c6 ,\maxc/n10 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u6  (
    .a(\maxc/maxcnt [6]),
    .b(1'b0),
    .c(\maxc/add1/c6 ),
    .o({\maxc/add1/c7 ,\maxc/n10 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u7  (
    .a(\maxc/maxcnt [7]),
    .b(1'b0),
    .c(\maxc/add1/c7 ),
    .o({\maxc/add1/c8 ,\maxc/n10 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u8  (
    .a(\maxc/maxcnt [8]),
    .b(1'b0),
    .c(\maxc/add1/c8 ),
    .o({\maxc/add1/c9 ,\maxc/n10 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \maxc/add1/u9  (
    .a(\maxc/maxcnt [9]),
    .b(1'b0),
    .c(\maxc/add1/c9 ),
    .o({\maxc/add1/c10 ,\maxc/n10 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \maxc/add1/ucin  (
    .a(1'b0),
    .o({\maxc/add1/c0 ,open_n11}));
  reg_sr_as_w1 \maxc/ms_up_reg  (
    .clk(clk),
    .d(\maxc/n5 ),
    .en(1'b1),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/ms_up ));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b0  (
    .clk(clk),
    .d(\maxc/n6 [0]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [0]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b1  (
    .clk(clk),
    .d(\maxc/n6 [1]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [1]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b10  (
    .clk(clk),
    .d(\maxc/n6 [10]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [10]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b11  (
    .clk(clk),
    .d(\maxc/n6 [11]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [11]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b12  (
    .clk(clk),
    .d(\maxc/n6 [12]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [12]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b13  (
    .clk(clk),
    .d(\maxc/n6 [13]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [13]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b14  (
    .clk(clk),
    .d(\maxc/n6 [14]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [14]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b2  (
    .clk(clk),
    .d(\maxc/n6 [2]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [2]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b3  (
    .clk(clk),
    .d(\maxc/n6 [3]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [3]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b4  (
    .clk(clk),
    .d(\maxc/n6 [4]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [4]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b5  (
    .clk(clk),
    .d(\maxc/n6 [5]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [5]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b6  (
    .clk(clk),
    .d(\maxc/n6 [6]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [6]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b7  (
    .clk(clk),
    .d(\maxc/n6 [7]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [7]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b8  (
    .clk(clk),
    .d(\maxc/n6 [8]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [8]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg0_b9  (
    .clk(clk),
    .d(\maxc/n6 [9]),
    .en(1'b1),
    .reset(~\maxc/mux4_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\maxc/psccnt [9]));  // rtl/loga_maxcnt.v(60)
  reg_sr_as_w1 \maxc/reg1_b0  (
    .clk(clk),
    .d(\maxc/n10 [0]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [0]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b1  (
    .clk(clk),
    .d(\maxc/n10 [1]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [1]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b10  (
    .clk(clk),
    .d(\maxc/n10 [10]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [10]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b11  (
    .clk(clk),
    .d(\maxc/n10 [11]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [11]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b12  (
    .clk(clk),
    .d(\maxc/n10 [12]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [12]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b13  (
    .clk(clk),
    .d(\maxc/n10 [13]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [13]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b14  (
    .clk(clk),
    .d(\maxc/n10 [14]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [14]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b15  (
    .clk(clk),
    .d(\maxc/n10 [15]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [15]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b2  (
    .clk(clk),
    .d(\maxc/n10 [2]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [2]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b3  (
    .clk(clk),
    .d(\maxc/n10 [3]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [3]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b4  (
    .clk(clk),
    .d(\maxc/n10 [4]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [4]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b5  (
    .clk(clk),
    .d(\maxc/n10 [5]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [5]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b6  (
    .clk(clk),
    .d(\maxc/n10 [6]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [6]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b7  (
    .clk(clk),
    .d(\maxc/n10 [7]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [7]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b8  (
    .clk(clk),
    .d(\maxc/n10 [8]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [8]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg1_b9  (
    .clk(clk),
    .d(\maxc/n10 [9]),
    .en(\maxc/ms_up ),
    .reset(\ctck/n2 ),
    .set(1'b0),
    .q(\maxc/maxcnt [9]));  // rtl/loga_maxcnt.v(70)
  reg_sr_as_w1 \maxc/reg2_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [0]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [1]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [10]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [11]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [12]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [13]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [14]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [15]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [2]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [3]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [4]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [5]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [6]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [7]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [8]));  // rtl/loga_maxcnt.v(37)
  reg_sr_as_w1 \maxc/reg2_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(wr_logamaxc),
    .reset(~rst_n),
    .set(1'b0),
    .q(\maxc/logamaxc [9]));  // rtl/loga_maxcnt.v(37)

endmodule 

