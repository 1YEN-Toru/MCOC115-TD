
`timescale 1ns / 1ps
module tim162  // rtl/tim162.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_timr_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  bdatr,
  timr_cmar,
  timr_cmbr,
  timr_ovfr,
  timr_pwma,
  timr_pwmb
  );
//
//	16 bit timer unit
//		(c) 2021	1YEN Toru
//
//
//	2021/05/01	ver.1.00
//		general purpose 16 bits timer
//		with 2 pwm outputs
//

  input [3:0] badr;  // rtl/tim162.v(24)
  input bcmdr;  // rtl/tim162.v(21)
  input bcmdw;  // rtl/tim162.v(22)
  input bcs_timr_n;  // rtl/tim162.v(23)
  input [15:0] bdatw;  // rtl/tim162.v(25)
  input brdy;  // rtl/tim162.v(20)
  input clk;  // rtl/tim162.v(18)
  input rst_n;  // rtl/tim162.v(19)
  output [15:0] bdatr;  // rtl/tim162.v(31)
  output timr_cmar;  // rtl/tim162.v(29)
  output timr_cmbr;  // rtl/tim162.v(30)
  output timr_ovfr;  // rtl/tim162.v(28)
  output timr_pwma;  // rtl/tim162.v(26)
  output timr_pwmb;  // rtl/tim162.v(27)

  wire [15:0] bdatr_cmb;  // rtl/tim162.v(55)
  wire [15:0] \rcma/timcmx2 ;  // rtl/tim162.v(660)
  wire [15:0] \rcmb/timcmx2 ;  // rtl/tim162.v(660)
  wire [15:0] \rcnt/n10 ;
  wire [15:0] \rcnt/n4 ;
  wire [15:0] \rcnt/psc ;  // rtl/tim162.v(719)
  wire [7:0] \rctl/timctl ;  // rtl/tim162.v(361)
  wire [3:0] \rflg/timflg ;  // rtl/tim162.v(536)
  wire [15:0] timcma;  // rtl/tim162.v(46)
  wire [15:0] timcmb;  // rtl/tim162.v(47)
  wire [15:0] timcnt;  // rtl/tim162.v(48)
  wire [15:0] timnxt;  // rtl/tim162.v(49)
  wire [15:0] timprd;  // rtl/tim162.v(44)
  wire [15:0] timpsc;  // rtl/tim162.v(45)
  wire _al_u101_o;
  wire _al_u102_o;
  wire _al_u104_o;
  wire _al_u105_o;
  wire _al_u107_o;
  wire _al_u108_o;
  wire _al_u110_o;
  wire _al_u111_o;
  wire _al_u112_o;
  wire _al_u114_o;
  wire _al_u115_o;
  wire _al_u116_o;
  wire _al_u118_o;
  wire _al_u119_o;
  wire _al_u120_o;
  wire _al_u125_o;
  wire _al_u126_o;
  wire _al_u127_o;
  wire _al_u128_o;
  wire _al_u129_o;
  wire _al_u130_o;
  wire _al_u131_o;
  wire _al_u132_o;
  wire _al_u134_o;
  wire _al_u135_o;
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
  wire _al_u146_o;
  wire _al_u147_o;
  wire _al_u150_o;
  wire _al_u151_o;
  wire _al_u152_o;
  wire _al_u153_o;
  wire _al_u154_o;
  wire _al_u155_o;
  wire _al_u156_o;
  wire _al_u157_o;
  wire _al_u158_o;
  wire _al_u159_o;
  wire _al_u160_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u163_o;
  wire _al_u167_o;
  wire _al_u168_o;
  wire _al_u169_o;
  wire _al_u170_o;
  wire _al_u171_o;
  wire _al_u172_o;
  wire _al_u173_o;
  wire _al_u174_o;
  wire _al_u179_o;
  wire _al_u181_o;
  wire _al_u183_o;
  wire _al_u185_o;
  wire _al_u187_o;
  wire _al_u189_o;
  wire _al_u191_o;
  wire _al_u193_o;
  wire _al_u195_o;
  wire _al_u197_o;
  wire _al_u199_o;
  wire _al_u201_o;
  wire _al_u203_o;
  wire _al_u205_o;
  wire _al_u207_o;
  wire _al_u209_o;
  wire _al_u61_o;
  wire _al_u64_o;
  wire _al_u67_o;
  wire _al_u70_o;
  wire _al_u73_o;
  wire _al_u76_o;
  wire _al_u79_o;
  wire _al_u82_o;
  wire _al_u86_o;
  wire _al_u87_o;
  wire _al_u88_o;
  wire _al_u89_o;
  wire _al_u90_o;
  wire _al_u91_o;
  wire _al_u92_o;
  wire _al_u93_o;
  wire _al_u95_o;
  wire _al_u96_o;
  wire _al_u98_o;
  wire _al_u99_o;
  wire \rcma/n3 ;
  wire \rcnt/add0/c0 ;
  wire \rcnt/add0/c1 ;
  wire \rcnt/add0/c10 ;
  wire \rcnt/add0/c11 ;
  wire \rcnt/add0/c12 ;
  wire \rcnt/add0/c13 ;
  wire \rcnt/add0/c14 ;
  wire \rcnt/add0/c15 ;
  wire \rcnt/add0/c2 ;
  wire \rcnt/add0/c3 ;
  wire \rcnt/add0/c4 ;
  wire \rcnt/add0/c5 ;
  wire \rcnt/add0/c6 ;
  wire \rcnt/add0/c7 ;
  wire \rcnt/add0/c8 ;
  wire \rcnt/add0/c9 ;
  wire \rcnt/add1/c0 ;
  wire \rcnt/add1/c1 ;
  wire \rcnt/add1/c10 ;
  wire \rcnt/add1/c11 ;
  wire \rcnt/add1/c12 ;
  wire \rcnt/add1/c13 ;
  wire \rcnt/add1/c14 ;
  wire \rcnt/add1/c15 ;
  wire \rcnt/add1/c2 ;
  wire \rcnt/add1/c3 ;
  wire \rcnt/add1/c4 ;
  wire \rcnt/add1/c5 ;
  wire \rcnt/add1/c6 ;
  wire \rcnt/add1/c7 ;
  wire \rcnt/add1/c8 ;
  wire \rcnt/add1/c9 ;
  wire \rcnt/mux1_b0_sel_is_0_o ;
  wire \rcnt/n12_lutinv ;
  wire \rcnt/n7 ;
  wire rcnt_up;  // rtl/tim162.v(88)
  wire \rctl/n11 ;
  wire \rctl/n15 ;
  wire \rctl/n22 ;
  wire \rctl/n4 ;
  wire rctl_cnte;  // rtl/tim162.v(97)
  wire rd_timcma;  // rtl/tim162.v(72)
  wire rd_timcmb;  // rtl/tim162.v(73)
  wire rd_timcnt;  // rtl/tim162.v(70)
  wire rd_timctl;  // rtl/tim162.v(67)
  wire rd_timflg;  // rtl/tim162.v(68)
  wire rd_timprd;  // rtl/tim162.v(71)
  wire rd_timpsc;  // rtl/tim162.v(69)
  wire \rflg/n12 ;
  wire \rflg/n20 ;
  wire \rflg/rflg_cmaf ;  // rtl/tim162.v(489)
  wire \rflg/rflg_cmbf ;  // rtl/tim162.v(512)
  wire \rflg/rflg_ovff ;  // rtl/tim162.v(477)
  wire \rflg/rflg_ovff_d ;
  wire \rflg/u19_sel_is_0_o ;
  wire \rflg/u29_sel_is_0_o ;
  wire \rflg/u9_sel_is_0_o ;
  wire rflg_top_lutinv;  // rtl/tim162.v(89)
  wire \rpsc/n1 ;
  wire \tctl/n10 ;
  wire \tctl/n12 ;
  wire \tctl/n14 ;
  wire \tctl/n16 ;
  wire \tctl/n2 ;
  wire \tctl/n32 ;
  wire \tctl/n4 ;
  wire \tctl/n6 ;
  wire \tctl/n8 ;
  wire wr_timcma;  // rtl/tim162.v(79)
  wire wr_timcmb;  // rtl/tim162.v(80)
  wire wr_timcnt;  // rtl/tim162.v(77)
  wire wr_timctl;  // rtl/tim162.v(74)
  wire wr_timflg;  // rtl/tim162.v(75)
  wire wr_timprd;  // rtl/tim162.v(78)
  wire wr_timpsc;  // rtl/tim162.v(76)

  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u100 (
    .a(_al_u99_o),
    .b(\rcmb/timcmx2 [3]),
    .c(timprd[3]),
    .d(rd_timcmb),
    .e(rd_timprd),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u101 (
    .a(timcnt[2]),
    .b(\rflg/timflg [2]),
    .c(rd_timcnt),
    .d(rd_timflg),
    .o(_al_u101_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u102 (
    .a(_al_u101_o),
    .b(\rcmb/timcmx2 [2]),
    .c(timprd[2]),
    .d(rd_timcmb),
    .e(rd_timprd),
    .o(_al_u102_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u103 (
    .a(_al_u102_o),
    .b(\rcma/timcmx2 [2]),
    .c(timpsc[2]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u104 (
    .a(\rcma/timcmx2 [1]),
    .b(timpsc[1]),
    .c(rd_timcma),
    .d(rd_timpsc),
    .o(_al_u104_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u105 (
    .a(_al_u104_o),
    .b(\rcmb/timcmx2 [1]),
    .c(\rflg/timflg [1]),
    .d(rd_timcmb),
    .e(rd_timflg),
    .o(_al_u105_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u106 (
    .a(_al_u105_o),
    .b(timcnt[1]),
    .c(timprd[1]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u107 (
    .a(\rcma/timcmx2 [0]),
    .b(timpsc[0]),
    .c(rd_timcma),
    .d(rd_timpsc),
    .o(_al_u107_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u108 (
    .a(_al_u107_o),
    .b(\rcmb/timcmx2 [0]),
    .c(rctl_cnte),
    .d(rd_timcmb),
    .e(rd_timctl),
    .o(_al_u108_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u109 (
    .a(_al_u108_o),
    .b(timcnt[0]),
    .c(timprd[0]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u110 (
    .a(\rflg/rflg_ovff ),
    .b(timprd[7]),
    .c(rd_timflg),
    .d(rd_timprd),
    .o(_al_u110_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u111 (
    .a(_al_u110_o),
    .b(\rctl/timctl [7]),
    .c(timpsc[7]),
    .d(rd_timctl),
    .e(rd_timpsc),
    .o(_al_u111_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u112 (
    .a(_al_u111_o),
    .b(\rcma/timcmx2 [7]),
    .c(\rcmb/timcmx2 [7]),
    .d(rd_timcma),
    .e(rd_timcmb),
    .o(_al_u112_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u113 (
    .a(_al_u112_o),
    .b(timcnt[7]),
    .c(rd_timcnt),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u114 (
    .a(\rctl/timctl [6]),
    .b(timpsc[6]),
    .c(rd_timctl),
    .d(rd_timpsc),
    .o(_al_u114_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u115 (
    .a(_al_u114_o),
    .b(\rflg/rflg_cmaf ),
    .c(timprd[6]),
    .d(rd_timflg),
    .e(rd_timprd),
    .o(_al_u115_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u116 (
    .a(_al_u115_o),
    .b(\rcma/timcmx2 [6]),
    .c(\rcmb/timcmx2 [6]),
    .d(rd_timcma),
    .e(rd_timcmb),
    .o(_al_u116_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u117 (
    .a(_al_u116_o),
    .b(timcnt[6]),
    .c(rd_timcnt),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u118 (
    .a(\rflg/rflg_cmbf ),
    .b(timprd[5]),
    .c(rd_timflg),
    .d(rd_timprd),
    .o(_al_u118_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u119 (
    .a(_al_u118_o),
    .b(\rctl/timctl [5]),
    .c(timpsc[5]),
    .d(rd_timctl),
    .e(rd_timpsc),
    .o(_al_u119_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u120 (
    .a(_al_u119_o),
    .b(\rcma/timcmx2 [5]),
    .c(\rcmb/timcmx2 [5]),
    .d(rd_timcma),
    .e(rd_timcmb),
    .o(_al_u120_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u121 (
    .a(_al_u120_o),
    .b(timcnt[5]),
    .c(rd_timcnt),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("(D*B*~(C*A))"),
    .INIT(16'h4c00))
    _al_u122 (
    .a(wr_timflg),
    .b(rctl_cnte),
    .c(bdatw[7]),
    .d(rst_n),
    .o(\rflg/u9_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*B*~(C*A))"),
    .INIT(16'h4c00))
    _al_u123 (
    .a(wr_timflg),
    .b(rctl_cnte),
    .c(bdatw[5]),
    .d(rst_n),
    .o(\rflg/u29_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*B*~(C*A))"),
    .INIT(16'h4c00))
    _al_u124 (
    .a(wr_timflg),
    .b(rctl_cnte),
    .c(bdatw[6]),
    .d(rst_n),
    .o(\rflg/u19_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u125 (
    .a(timcnt[12]),
    .b(timcnt[13]),
    .c(timprd[12]),
    .d(timprd[13]),
    .o(_al_u125_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u126 (
    .a(timcnt[0]),
    .b(timcnt[1]),
    .c(timprd[0]),
    .d(timprd[1]),
    .o(_al_u126_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u127 (
    .a(timcnt[8]),
    .b(timcnt[9]),
    .c(timprd[8]),
    .d(timprd[9]),
    .o(_al_u127_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u128 (
    .a(timcnt[4]),
    .b(timcnt[5]),
    .c(timprd[4]),
    .d(timprd[5]),
    .o(_al_u128_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u129 (
    .a(_al_u126_o),
    .b(timcnt[2]),
    .c(timcnt[3]),
    .d(timprd[2]),
    .e(timprd[3]),
    .o(_al_u129_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u130 (
    .a(_al_u128_o),
    .b(timcnt[6]),
    .c(timcnt[7]),
    .d(timprd[6]),
    .e(timprd[7]),
    .o(_al_u130_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u131 (
    .a(_al_u125_o),
    .b(timcnt[14]),
    .c(timcnt[15]),
    .d(timprd[14]),
    .e(timprd[15]),
    .o(_al_u131_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u132 (
    .a(_al_u127_o),
    .b(timcnt[10]),
    .c(timcnt[11]),
    .d(timprd[10]),
    .e(timprd[11]),
    .o(_al_u132_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u133 (
    .a(_al_u129_o),
    .b(_al_u130_o),
    .c(_al_u131_o),
    .d(_al_u132_o),
    .o(rflg_top_lutinv));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u134 (
    .a(timnxt[1]),
    .b(timnxt[0]),
    .c(timcmb[0]),
    .d(timcmb[1]),
    .o(_al_u134_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u135 (
    .a(timnxt[5]),
    .b(timnxt[4]),
    .c(timcmb[4]),
    .d(timcmb[5]),
    .o(_al_u135_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u136 (
    .a(_al_u135_o),
    .b(timnxt[7]),
    .c(timnxt[6]),
    .d(timcmb[6]),
    .e(timcmb[7]),
    .o(_al_u136_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u137 (
    .a(timnxt[9]),
    .b(timnxt[8]),
    .c(timcmb[8]),
    .d(timcmb[9]),
    .o(_al_u137_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u138 (
    .a(_al_u137_o),
    .b(timnxt[11]),
    .c(timnxt[10]),
    .d(timcmb[10]),
    .e(timcmb[11]),
    .o(_al_u138_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u139 (
    .a(_al_u134_o),
    .b(timnxt[3]),
    .c(timnxt[2]),
    .d(timcmb[2]),
    .e(timcmb[3]),
    .o(_al_u139_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u140 (
    .a(timnxt[13]),
    .b(timnxt[12]),
    .c(timcmb[12]),
    .d(timcmb[13]),
    .o(_al_u140_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u141 (
    .a(_al_u140_o),
    .b(timnxt[15]),
    .c(timnxt[14]),
    .d(timcmb[14]),
    .e(timcmb[15]),
    .o(_al_u141_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D*C*B))"),
    .INIT(32'h15555555))
    _al_u142 (
    .a(rflg_top_lutinv),
    .b(_al_u141_o),
    .c(_al_u138_o),
    .d(_al_u136_o),
    .e(_al_u139_o),
    .o(_al_u142_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u143 (
    .a(timcmb[12]),
    .b(timcmb[13]),
    .c(timcmb[14]),
    .d(timcmb[15]),
    .o(_al_u143_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u144 (
    .a(_al_u143_o),
    .b(timcmb[0]),
    .c(timcmb[1]),
    .d(timcmb[10]),
    .o(_al_u144_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u145 (
    .a(timcmb[2]),
    .b(timcmb[3]),
    .c(timcmb[4]),
    .d(timcmb[5]),
    .o(_al_u145_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u146 (
    .a(_al_u145_o),
    .b(timcmb[6]),
    .c(timcmb[7]),
    .d(timcmb[8]),
    .e(timcmb[9]),
    .o(_al_u146_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*C*B))"),
    .INIT(16'haa2a))
    _al_u147 (
    .a(rflg_top_lutinv),
    .b(_al_u144_o),
    .c(_al_u146_o),
    .d(timcmb[11]),
    .o(_al_u147_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(~B*~A))"),
    .INIT(8'hf1))
    _al_u148 (
    .a(_al_u142_o),
    .b(_al_u147_o),
    .c(\rflg/rflg_cmbf ),
    .o(\rflg/n20 ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'he3e25140))
    _al_u149 (
    .a(_al_u142_o),
    .b(_al_u147_o),
    .c(\rctl/timctl [4]),
    .d(\rctl/timctl [5]),
    .e(timr_pwmb),
    .o(\rctl/n22 ));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u150 (
    .a(timnxt[1]),
    .b(timnxt[0]),
    .c(timcma[0]),
    .d(timcma[1]),
    .o(_al_u150_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u151 (
    .a(timnxt[5]),
    .b(timnxt[4]),
    .c(timcma[4]),
    .d(timcma[5]),
    .o(_al_u151_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u152 (
    .a(_al_u151_o),
    .b(timnxt[7]),
    .c(timnxt[6]),
    .d(timcma[6]),
    .e(timcma[7]),
    .o(_al_u152_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u153 (
    .a(timnxt[9]),
    .b(timnxt[8]),
    .c(timcma[8]),
    .d(timcma[9]),
    .o(_al_u153_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u154 (
    .a(_al_u153_o),
    .b(timnxt[11]),
    .c(timnxt[10]),
    .d(timcma[10]),
    .e(timcma[11]),
    .o(_al_u154_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u155 (
    .a(_al_u150_o),
    .b(timnxt[3]),
    .c(timnxt[2]),
    .d(timcma[2]),
    .e(timcma[3]),
    .o(_al_u155_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u156 (
    .a(timnxt[13]),
    .b(timnxt[12]),
    .c(timcma[12]),
    .d(timcma[13]),
    .o(_al_u156_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u157 (
    .a(_al_u156_o),
    .b(timnxt[15]),
    .c(timnxt[14]),
    .d(timcma[14]),
    .e(timcma[15]),
    .o(_al_u157_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D*C*B))"),
    .INIT(32'h15555555))
    _al_u158 (
    .a(rflg_top_lutinv),
    .b(_al_u157_o),
    .c(_al_u154_o),
    .d(_al_u152_o),
    .e(_al_u155_o),
    .o(_al_u158_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u159 (
    .a(timcma[12]),
    .b(timcma[13]),
    .c(timcma[14]),
    .d(timcma[15]),
    .o(_al_u159_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u160 (
    .a(timcma[6]),
    .b(timcma[7]),
    .c(timcma[8]),
    .d(timcma[9]),
    .o(_al_u160_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u161 (
    .a(_al_u159_o),
    .b(timcma[0]),
    .c(timcma[1]),
    .d(timcma[10]),
    .o(_al_u161_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u162 (
    .a(_al_u160_o),
    .b(timcma[11]),
    .c(timcma[2]),
    .d(timcma[5]),
    .o(_al_u162_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*~D*C*B))"),
    .INIT(32'haaaaaa2a))
    _al_u163 (
    .a(rflg_top_lutinv),
    .b(_al_u161_o),
    .c(_al_u162_o),
    .d(timcma[3]),
    .e(timcma[4]),
    .o(_al_u163_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(~B*~A))"),
    .INIT(8'hf1))
    _al_u164 (
    .a(_al_u158_o),
    .b(_al_u163_o),
    .c(\rflg/rflg_cmaf ),
    .o(\rflg/n12 ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'he3e25140))
    _al_u165 (
    .a(_al_u158_o),
    .b(_al_u163_o),
    .c(\rctl/timctl [6]),
    .d(\rctl/timctl [7]),
    .e(timr_pwma),
    .o(\rctl/n11 ));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(B*A))"),
    .INIT(8'hf8))
    _al_u166 (
    .a(rcnt_up),
    .b(rflg_top_lutinv),
    .c(\rflg/rflg_ovff ),
    .o(\rflg/rflg_ovff_d ));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u167 (
    .a(timnxt[5]),
    .b(timnxt[4]),
    .c(timprd[4]),
    .d(timprd[5]),
    .o(_al_u167_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u168 (
    .a(_al_u167_o),
    .b(timnxt[7]),
    .c(timnxt[6]),
    .d(timprd[6]),
    .e(timprd[7]),
    .o(_al_u168_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u169 (
    .a(timnxt[9]),
    .b(timnxt[8]),
    .c(timprd[8]),
    .d(timprd[9]),
    .o(_al_u169_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u170 (
    .a(_al_u169_o),
    .b(timnxt[11]),
    .c(timnxt[10]),
    .d(timprd[10]),
    .e(timprd[11]),
    .o(_al_u170_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u171 (
    .a(timnxt[1]),
    .b(timnxt[0]),
    .c(timprd[0]),
    .d(timprd[1]),
    .o(_al_u171_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u172 (
    .a(_al_u171_o),
    .b(timnxt[3]),
    .c(timnxt[2]),
    .d(timprd[2]),
    .e(timprd[3]),
    .o(_al_u172_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u173 (
    .a(timnxt[13]),
    .b(timnxt[12]),
    .c(timprd[12]),
    .d(timprd[13]),
    .o(_al_u173_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u174 (
    .a(_al_u173_o),
    .b(timnxt[15]),
    .c(timnxt[14]),
    .d(timprd[14]),
    .e(timprd[15]),
    .o(_al_u174_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u175 (
    .a(_al_u174_o),
    .b(_al_u170_o),
    .c(_al_u168_o),
    .d(_al_u172_o),
    .o(\rcnt/n12_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B*A))"),
    .INIT(8'h8f))
    _al_u176 (
    .a(\rcnt/n12_lutinv ),
    .b(rcnt_up),
    .c(rctl_cnte),
    .o(\rcma/n3 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u177 (
    .a(\tctl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_timcnt));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u178 (
    .a(rcnt_up),
    .b(rctl_cnte),
    .o(\rcnt/n7 ));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u179 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[9]),
    .d(timcnt[9]),
    .o(_al_u179_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u180 (
    .a(_al_u179_o),
    .b(wr_timcnt),
    .c(bdatw[9]),
    .o(\rcnt/n10 [9]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u181 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[8]),
    .d(timcnt[8]),
    .o(_al_u181_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u182 (
    .a(_al_u181_o),
    .b(wr_timcnt),
    .c(bdatw[8]),
    .o(\rcnt/n10 [8]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u183 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[7]),
    .d(timcnt[7]),
    .o(_al_u183_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u184 (
    .a(_al_u183_o),
    .b(wr_timcnt),
    .c(bdatw[7]),
    .o(\rcnt/n10 [7]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u185 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[6]),
    .d(timcnt[6]),
    .o(_al_u185_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u186 (
    .a(_al_u185_o),
    .b(wr_timcnt),
    .c(bdatw[6]),
    .o(\rcnt/n10 [6]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u187 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[5]),
    .d(timcnt[5]),
    .o(_al_u187_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u188 (
    .a(_al_u187_o),
    .b(wr_timcnt),
    .c(bdatw[5]),
    .o(\rcnt/n10 [5]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u189 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[4]),
    .d(timcnt[4]),
    .o(_al_u189_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u190 (
    .a(_al_u189_o),
    .b(wr_timcnt),
    .c(bdatw[4]),
    .o(\rcnt/n10 [4]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u191 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[3]),
    .d(timcnt[3]),
    .o(_al_u191_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u192 (
    .a(_al_u191_o),
    .b(wr_timcnt),
    .c(bdatw[3]),
    .o(\rcnt/n10 [3]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u193 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[2]),
    .d(timcnt[2]),
    .o(_al_u193_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u194 (
    .a(_al_u193_o),
    .b(wr_timcnt),
    .c(bdatw[2]),
    .o(\rcnt/n10 [2]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u195 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[15]),
    .d(timcnt[15]),
    .o(_al_u195_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u196 (
    .a(_al_u195_o),
    .b(wr_timcnt),
    .c(bdatw[15]),
    .o(\rcnt/n10 [15]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u197 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[14]),
    .d(timcnt[14]),
    .o(_al_u197_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u198 (
    .a(_al_u197_o),
    .b(wr_timcnt),
    .c(bdatw[14]),
    .o(\rcnt/n10 [14]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u199 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[13]),
    .d(timcnt[13]),
    .o(_al_u199_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u200 (
    .a(_al_u199_o),
    .b(wr_timcnt),
    .c(bdatw[13]),
    .o(\rcnt/n10 [13]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u201 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[12]),
    .d(timcnt[12]),
    .o(_al_u201_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u202 (
    .a(_al_u201_o),
    .b(wr_timcnt),
    .c(bdatw[12]),
    .o(\rcnt/n10 [12]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u203 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[11]),
    .d(timcnt[11]),
    .o(_al_u203_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u204 (
    .a(_al_u203_o),
    .b(wr_timcnt),
    .c(bdatw[11]),
    .o(\rcnt/n10 [11]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u205 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[10]),
    .d(timcnt[10]),
    .o(_al_u205_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u206 (
    .a(_al_u205_o),
    .b(wr_timcnt),
    .c(bdatw[10]),
    .o(\rcnt/n10 [10]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u207 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[1]),
    .d(timcnt[1]),
    .o(_al_u207_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u208 (
    .a(_al_u207_o),
    .b(wr_timcnt),
    .c(bdatw[1]),
    .o(\rcnt/n10 [1]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h8adf))
    _al_u209 (
    .a(\rcnt/n7 ),
    .b(rflg_top_lutinv),
    .c(timnxt[0]),
    .d(timcnt[0]),
    .o(_al_u209_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u210 (
    .a(_al_u209_o),
    .b(wr_timcnt),
    .c(bdatw[0]),
    .o(\rcnt/n10 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u211 (
    .a(rcnt_up),
    .b(wr_timcnt),
    .c(rctl_cnte),
    .d(rst_n),
    .o(\rcnt/mux1_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u41 (
    .a(\rflg/timflg [2]),
    .b(\rflg/rflg_cmaf ),
    .o(timr_cmar));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u42 (
    .a(\rflg/timflg [1]),
    .b(\rflg/rflg_cmbf ),
    .o(timr_cmbr));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u43 (
    .a(\rflg/timflg [3]),
    .b(\rflg/rflg_ovff ),
    .o(timr_ovfr));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(~B*~A))"),
    .INIT(8'h1f))
    _al_u44 (
    .a(\rctl/timctl [4]),
    .b(\rctl/timctl [5]),
    .c(rst_n),
    .o(\rctl/n15 ));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(~B*~A))"),
    .INIT(8'h1f))
    _al_u45 (
    .a(\rctl/timctl [6]),
    .b(\rctl/timctl [7]),
    .c(rst_n),
    .o(\rctl/n4 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u46 (
    .a(bcmdr),
    .b(bcs_timr_n),
    .o(\tctl/n2 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u47 (
    .a(\tctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\tctl/n4 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u48 (
    .a(bcmdw),
    .b(bcs_timr_n),
    .c(brdy),
    .o(\tctl/n32 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u49 (
    .a(\tctl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_timctl));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u50 (
    .a(\tctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\tctl/n12 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u51 (
    .a(\tctl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_timprd));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u52 (
    .a(\tctl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_timcmb));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u53 (
    .a(\tctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\tctl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u54 (
    .a(\tctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\tctl/n8 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u55 (
    .a(\tctl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_timcma));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u56 (
    .a(\tctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\tctl/n14 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u57 (
    .a(\tctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\tctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u58 (
    .a(\tctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\tctl/n6 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u59 (
    .a(\tctl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_timflg));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u60 (
    .a(\rcmb/timcmx2 [9]),
    .b(rd_timcmb),
    .o(bdatr_cmb[9]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u61 (
    .a(bdatr_cmb[9]),
    .b(timcnt[9]),
    .c(timprd[9]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u61_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u62 (
    .a(_al_u61_o),
    .b(\rcma/timcmx2 [9]),
    .c(timpsc[9]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u63 (
    .a(\rcmb/timcmx2 [8]),
    .b(rd_timcmb),
    .o(bdatr_cmb[8]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u64 (
    .a(bdatr_cmb[8]),
    .b(timcnt[8]),
    .c(timprd[8]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u64_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u65 (
    .a(_al_u64_o),
    .b(\rcma/timcmx2 [8]),
    .c(timpsc[8]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u66 (
    .a(\rcmb/timcmx2 [15]),
    .b(rd_timcmb),
    .o(bdatr_cmb[15]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u67 (
    .a(bdatr_cmb[15]),
    .b(timcnt[15]),
    .c(timprd[15]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u67_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u68 (
    .a(_al_u67_o),
    .b(\rcma/timcmx2 [15]),
    .c(timpsc[15]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u69 (
    .a(\rcmb/timcmx2 [14]),
    .b(rd_timcmb),
    .o(bdatr_cmb[14]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u70 (
    .a(bdatr_cmb[14]),
    .b(timcnt[14]),
    .c(timprd[14]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u70_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u71 (
    .a(_al_u70_o),
    .b(\rcma/timcmx2 [14]),
    .c(timpsc[14]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u72 (
    .a(\rcmb/timcmx2 [13]),
    .b(rd_timcmb),
    .o(bdatr_cmb[13]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u73 (
    .a(bdatr_cmb[13]),
    .b(timcnt[13]),
    .c(timprd[13]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u73_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u74 (
    .a(_al_u73_o),
    .b(\rcma/timcmx2 [13]),
    .c(timpsc[13]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u75 (
    .a(\rcmb/timcmx2 [12]),
    .b(rd_timcmb),
    .o(bdatr_cmb[12]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u76 (
    .a(bdatr_cmb[12]),
    .b(timcnt[12]),
    .c(timprd[12]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u76_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u77 (
    .a(_al_u76_o),
    .b(\rcma/timcmx2 [12]),
    .c(timpsc[12]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u78 (
    .a(\rcmb/timcmx2 [11]),
    .b(rd_timcmb),
    .o(bdatr_cmb[11]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u79 (
    .a(bdatr_cmb[11]),
    .b(timcnt[11]),
    .c(timprd[11]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u79_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u80 (
    .a(_al_u79_o),
    .b(\rcma/timcmx2 [11]),
    .c(timpsc[11]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u81 (
    .a(\rcmb/timcmx2 [10]),
    .b(rd_timcmb),
    .o(bdatr_cmb[10]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u82 (
    .a(bdatr_cmb[10]),
    .b(timcnt[10]),
    .c(timprd[10]),
    .d(rd_timcnt),
    .e(rd_timprd),
    .o(_al_u82_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u83 (
    .a(_al_u82_o),
    .b(\rcma/timcmx2 [10]),
    .c(timpsc[10]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(bdatr[10]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u84 (
    .a(\tctl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_timpsc));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u85 (
    .a(wr_timpsc),
    .b(rctl_cnte),
    .o(\rpsc/n1 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u86 (
    .a(\rcnt/psc [6]),
    .b(\rcnt/psc [7]),
    .c(timpsc[6]),
    .d(timpsc[7]),
    .o(_al_u86_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u87 (
    .a(\rcnt/psc [0]),
    .b(\rcnt/psc [1]),
    .c(timpsc[0]),
    .d(timpsc[1]),
    .o(_al_u87_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u88 (
    .a(\rcnt/psc [14]),
    .b(\rcnt/psc [15]),
    .c(timpsc[14]),
    .d(timpsc[15]),
    .o(_al_u88_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u89 (
    .a(\rcnt/psc [10]),
    .b(\rcnt/psc [11]),
    .c(timpsc[10]),
    .d(timpsc[11]),
    .o(_al_u89_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u90 (
    .a(_al_u87_o),
    .b(\rcnt/psc [2]),
    .c(\rcnt/psc [3]),
    .d(timpsc[2]),
    .e(timpsc[3]),
    .o(_al_u90_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u91 (
    .a(_al_u86_o),
    .b(\rcnt/psc [4]),
    .c(\rcnt/psc [5]),
    .d(timpsc[4]),
    .e(timpsc[5]),
    .o(_al_u91_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u92 (
    .a(_al_u88_o),
    .b(\rcnt/psc [12]),
    .c(\rcnt/psc [13]),
    .d(timpsc[12]),
    .e(timpsc[13]),
    .o(_al_u92_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u93 (
    .a(_al_u89_o),
    .b(\rcnt/psc [8]),
    .c(\rcnt/psc [9]),
    .d(timpsc[8]),
    .e(timpsc[9]),
    .o(_al_u93_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u94 (
    .a(_al_u90_o),
    .b(_al_u91_o),
    .c(_al_u92_o),
    .d(_al_u93_o),
    .o(rcnt_up));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u95 (
    .a(timcnt[4]),
    .b(\rctl/timctl [4]),
    .c(rd_timcnt),
    .d(rd_timctl),
    .o(_al_u95_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u96 (
    .a(_al_u95_o),
    .b(\rcma/timcmx2 [4]),
    .c(timpsc[4]),
    .d(rd_timcma),
    .e(rd_timpsc),
    .o(_al_u96_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u97 (
    .a(_al_u96_o),
    .b(\rcmb/timcmx2 [4]),
    .c(timprd[4]),
    .d(rd_timcmb),
    .e(rd_timprd),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u98 (
    .a(\rcma/timcmx2 [3]),
    .b(timpsc[3]),
    .c(rd_timcma),
    .d(rd_timpsc),
    .o(_al_u98_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u99 (
    .a(_al_u98_o),
    .b(timcnt[3]),
    .c(\rflg/timflg [3]),
    .d(rd_timcnt),
    .e(rd_timflg),
    .o(_al_u99_o));
  reg_sr_as_w1 \rcma/reg0_b0  (
    .clk(clk),
    .d(\rcma/timcmx2 [0]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[0]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b1  (
    .clk(clk),
    .d(\rcma/timcmx2 [1]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[1]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b10  (
    .clk(clk),
    .d(\rcma/timcmx2 [10]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[10]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b11  (
    .clk(clk),
    .d(\rcma/timcmx2 [11]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[11]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b12  (
    .clk(clk),
    .d(\rcma/timcmx2 [12]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[12]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b13  (
    .clk(clk),
    .d(\rcma/timcmx2 [13]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[13]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b14  (
    .clk(clk),
    .d(\rcma/timcmx2 [14]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[14]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b15  (
    .clk(clk),
    .d(\rcma/timcmx2 [15]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[15]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b2  (
    .clk(clk),
    .d(\rcma/timcmx2 [2]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[2]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b3  (
    .clk(clk),
    .d(\rcma/timcmx2 [3]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[3]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b4  (
    .clk(clk),
    .d(\rcma/timcmx2 [4]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[4]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b5  (
    .clk(clk),
    .d(\rcma/timcmx2 [5]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[5]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b6  (
    .clk(clk),
    .d(\rcma/timcmx2 [6]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[6]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b7  (
    .clk(clk),
    .d(\rcma/timcmx2 [7]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[7]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b8  (
    .clk(clk),
    .d(\rcma/timcmx2 [8]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[8]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg0_b9  (
    .clk(clk),
    .d(\rcma/timcmx2 [9]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcma[9]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcma/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [0]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [1]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [10]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [11]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [12]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [13]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [14]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [15]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [2]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [3]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [4]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [5]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [6]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [7]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [8]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcma/reg1_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(wr_timcma),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcma/timcmx2 [9]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg0_b0  (
    .clk(clk),
    .d(\rcmb/timcmx2 [0]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[0]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b1  (
    .clk(clk),
    .d(\rcmb/timcmx2 [1]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[1]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b10  (
    .clk(clk),
    .d(\rcmb/timcmx2 [10]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[10]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b11  (
    .clk(clk),
    .d(\rcmb/timcmx2 [11]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[11]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b12  (
    .clk(clk),
    .d(\rcmb/timcmx2 [12]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[12]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b13  (
    .clk(clk),
    .d(\rcmb/timcmx2 [13]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[13]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b14  (
    .clk(clk),
    .d(\rcmb/timcmx2 [14]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[14]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b15  (
    .clk(clk),
    .d(\rcmb/timcmx2 [15]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[15]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b2  (
    .clk(clk),
    .d(\rcmb/timcmx2 [2]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[2]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b3  (
    .clk(clk),
    .d(\rcmb/timcmx2 [3]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[3]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b4  (
    .clk(clk),
    .d(\rcmb/timcmx2 [4]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[4]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b5  (
    .clk(clk),
    .d(\rcmb/timcmx2 [5]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[5]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b6  (
    .clk(clk),
    .d(\rcmb/timcmx2 [6]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[6]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b7  (
    .clk(clk),
    .d(\rcmb/timcmx2 [7]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[7]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b8  (
    .clk(clk),
    .d(\rcmb/timcmx2 [8]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[8]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg0_b9  (
    .clk(clk),
    .d(\rcmb/timcmx2 [9]),
    .en(\rcma/n3 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcmb[9]));  // rtl/tim162.v(677)
  reg_sr_as_w1 \rcmb/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [0]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [1]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [10]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [11]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [12]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [13]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [14]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [15]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [2]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [3]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [4]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [5]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [6]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [7]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [8]));  // rtl/tim162.v(667)
  reg_sr_as_w1 \rcmb/reg1_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(wr_timcmb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rcmb/timcmx2 [9]));  // rtl/tim162.v(667)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u0  (
    .a(\rcnt/psc [0]),
    .b(1'b1),
    .c(\rcnt/add0/c0 ),
    .o({\rcnt/add0/c1 ,\rcnt/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u1  (
    .a(\rcnt/psc [1]),
    .b(1'b0),
    .c(\rcnt/add0/c1 ),
    .o({\rcnt/add0/c2 ,\rcnt/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u10  (
    .a(\rcnt/psc [10]),
    .b(1'b0),
    .c(\rcnt/add0/c10 ),
    .o({\rcnt/add0/c11 ,\rcnt/n4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u11  (
    .a(\rcnt/psc [11]),
    .b(1'b0),
    .c(\rcnt/add0/c11 ),
    .o({\rcnt/add0/c12 ,\rcnt/n4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u12  (
    .a(\rcnt/psc [12]),
    .b(1'b0),
    .c(\rcnt/add0/c12 ),
    .o({\rcnt/add0/c13 ,\rcnt/n4 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u13  (
    .a(\rcnt/psc [13]),
    .b(1'b0),
    .c(\rcnt/add0/c13 ),
    .o({\rcnt/add0/c14 ,\rcnt/n4 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u14  (
    .a(\rcnt/psc [14]),
    .b(1'b0),
    .c(\rcnt/add0/c14 ),
    .o({\rcnt/add0/c15 ,\rcnt/n4 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u15  (
    .a(\rcnt/psc [15]),
    .b(1'b0),
    .c(\rcnt/add0/c15 ),
    .o({open_n0,\rcnt/n4 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u2  (
    .a(\rcnt/psc [2]),
    .b(1'b0),
    .c(\rcnt/add0/c2 ),
    .o({\rcnt/add0/c3 ,\rcnt/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u3  (
    .a(\rcnt/psc [3]),
    .b(1'b0),
    .c(\rcnt/add0/c3 ),
    .o({\rcnt/add0/c4 ,\rcnt/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u4  (
    .a(\rcnt/psc [4]),
    .b(1'b0),
    .c(\rcnt/add0/c4 ),
    .o({\rcnt/add0/c5 ,\rcnt/n4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u5  (
    .a(\rcnt/psc [5]),
    .b(1'b0),
    .c(\rcnt/add0/c5 ),
    .o({\rcnt/add0/c6 ,\rcnt/n4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u6  (
    .a(\rcnt/psc [6]),
    .b(1'b0),
    .c(\rcnt/add0/c6 ),
    .o({\rcnt/add0/c7 ,\rcnt/n4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u7  (
    .a(\rcnt/psc [7]),
    .b(1'b0),
    .c(\rcnt/add0/c7 ),
    .o({\rcnt/add0/c8 ,\rcnt/n4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u8  (
    .a(\rcnt/psc [8]),
    .b(1'b0),
    .c(\rcnt/add0/c8 ),
    .o({\rcnt/add0/c9 ,\rcnt/n4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u9  (
    .a(\rcnt/psc [9]),
    .b(1'b0),
    .c(\rcnt/add0/c9 ),
    .o({\rcnt/add0/c10 ,\rcnt/n4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add0/ucin  (
    .a(1'b0),
    .o({\rcnt/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u0  (
    .a(timcnt[0]),
    .b(1'b1),
    .c(\rcnt/add1/c0 ),
    .o({\rcnt/add1/c1 ,timnxt[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u1  (
    .a(timcnt[1]),
    .b(1'b0),
    .c(\rcnt/add1/c1 ),
    .o({\rcnt/add1/c2 ,timnxt[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u10  (
    .a(timcnt[10]),
    .b(1'b0),
    .c(\rcnt/add1/c10 ),
    .o({\rcnt/add1/c11 ,timnxt[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u11  (
    .a(timcnt[11]),
    .b(1'b0),
    .c(\rcnt/add1/c11 ),
    .o({\rcnt/add1/c12 ,timnxt[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u12  (
    .a(timcnt[12]),
    .b(1'b0),
    .c(\rcnt/add1/c12 ),
    .o({\rcnt/add1/c13 ,timnxt[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u13  (
    .a(timcnt[13]),
    .b(1'b0),
    .c(\rcnt/add1/c13 ),
    .o({\rcnt/add1/c14 ,timnxt[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u14  (
    .a(timcnt[14]),
    .b(1'b0),
    .c(\rcnt/add1/c14 ),
    .o({\rcnt/add1/c15 ,timnxt[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u15  (
    .a(timcnt[15]),
    .b(1'b0),
    .c(\rcnt/add1/c15 ),
    .o({open_n4,timnxt[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u2  (
    .a(timcnt[2]),
    .b(1'b0),
    .c(\rcnt/add1/c2 ),
    .o({\rcnt/add1/c3 ,timnxt[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u3  (
    .a(timcnt[3]),
    .b(1'b0),
    .c(\rcnt/add1/c3 ),
    .o({\rcnt/add1/c4 ,timnxt[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u4  (
    .a(timcnt[4]),
    .b(1'b0),
    .c(\rcnt/add1/c4 ),
    .o({\rcnt/add1/c5 ,timnxt[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u5  (
    .a(timcnt[5]),
    .b(1'b0),
    .c(\rcnt/add1/c5 ),
    .o({\rcnt/add1/c6 ,timnxt[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u6  (
    .a(timcnt[6]),
    .b(1'b0),
    .c(\rcnt/add1/c6 ),
    .o({\rcnt/add1/c7 ,timnxt[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u7  (
    .a(timcnt[7]),
    .b(1'b0),
    .c(\rcnt/add1/c7 ),
    .o({\rcnt/add1/c8 ,timnxt[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u8  (
    .a(timcnt[8]),
    .b(1'b0),
    .c(\rcnt/add1/c8 ),
    .o({\rcnt/add1/c9 ,timnxt[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u9  (
    .a(timcnt[9]),
    .b(1'b0),
    .c(\rcnt/add1/c9 ),
    .o({\rcnt/add1/c10 ,timnxt[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add1/ucin  (
    .a(1'b0),
    .o({\rcnt/add1/c0 ,open_n7}));
  reg_sr_as_w1 \rcnt/reg0_b0  (
    .clk(clk),
    .d(\rcnt/n10 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[0]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b1  (
    .clk(clk),
    .d(\rcnt/n10 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[1]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b10  (
    .clk(clk),
    .d(\rcnt/n10 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[10]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b11  (
    .clk(clk),
    .d(\rcnt/n10 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[11]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b12  (
    .clk(clk),
    .d(\rcnt/n10 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[12]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b13  (
    .clk(clk),
    .d(\rcnt/n10 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[13]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b14  (
    .clk(clk),
    .d(\rcnt/n10 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[14]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b15  (
    .clk(clk),
    .d(\rcnt/n10 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[15]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b2  (
    .clk(clk),
    .d(\rcnt/n10 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[2]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b3  (
    .clk(clk),
    .d(\rcnt/n10 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[3]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b4  (
    .clk(clk),
    .d(\rcnt/n10 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[4]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b5  (
    .clk(clk),
    .d(\rcnt/n10 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[5]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b6  (
    .clk(clk),
    .d(\rcnt/n10 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[6]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b7  (
    .clk(clk),
    .d(\rcnt/n10 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[7]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b8  (
    .clk(clk),
    .d(\rcnt/n10 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[8]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg0_b9  (
    .clk(clk),
    .d(\rcnt/n10 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(timcnt[9]));  // rtl/tim162.v(746)
  reg_sr_as_w1 \rcnt/reg1_b0  (
    .clk(clk),
    .d(\rcnt/n4 [0]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [0]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b1  (
    .clk(clk),
    .d(\rcnt/n4 [1]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [1]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b10  (
    .clk(clk),
    .d(\rcnt/n4 [10]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [10]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b11  (
    .clk(clk),
    .d(\rcnt/n4 [11]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [11]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b12  (
    .clk(clk),
    .d(\rcnt/n4 [12]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [12]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b13  (
    .clk(clk),
    .d(\rcnt/n4 [13]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [13]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b14  (
    .clk(clk),
    .d(\rcnt/n4 [14]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [14]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b15  (
    .clk(clk),
    .d(\rcnt/n4 [15]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [15]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b2  (
    .clk(clk),
    .d(\rcnt/n4 [2]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [2]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b3  (
    .clk(clk),
    .d(\rcnt/n4 [3]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [3]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b4  (
    .clk(clk),
    .d(\rcnt/n4 [4]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [4]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b5  (
    .clk(clk),
    .d(\rcnt/n4 [5]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [5]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b6  (
    .clk(clk),
    .d(\rcnt/n4 [6]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [6]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b7  (
    .clk(clk),
    .d(\rcnt/n4 [7]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [7]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b8  (
    .clk(clk),
    .d(\rcnt/n4 [8]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [8]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rcnt/reg1_b9  (
    .clk(clk),
    .d(\rcnt/n4 [9]),
    .en(1'b1),
    .reset(~\rcnt/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\rcnt/psc [9]));  // rtl/tim162.v(728)
  reg_sr_as_w1 \rctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_timctl),
    .reset(~rst_n),
    .set(1'b0),
    .q(rctl_cnte));  // rtl/tim162.v(368)
  reg_sr_as_w1 \rctl/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_timctl),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/timctl [4]));  // rtl/tim162.v(368)
  reg_sr_as_w1 \rctl/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_timctl),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/timctl [5]));  // rtl/tim162.v(368)
  reg_sr_as_w1 \rctl/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_timctl),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/timctl [6]));  // rtl/tim162.v(368)
  reg_sr_as_w1 \rctl/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_timctl),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/timctl [7]));  // rtl/tim162.v(368)
  reg_sr_as_w1 \rctl/timr_pwma_reg  (
    .clk(clk),
    .d(\rctl/n11 ),
    .en(rcnt_up),
    .reset(\rctl/n4 ),
    .set(1'b0),
    .q(timr_pwma));  // rtl/tim162.v(398)
  reg_sr_as_w1 \rctl/timr_pwmb_reg  (
    .clk(clk),
    .d(\rctl/n22 ),
    .en(rcnt_up),
    .reset(\rctl/n15 ),
    .set(1'b0),
    .q(timr_pwmb));  // rtl/tim162.v(422)
  reg_sr_as_w1 \rflg/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_timflg),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rflg/timflg [1]));  // rtl/tim162.v(543)
  reg_sr_as_w1 \rflg/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_timflg),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rflg/timflg [2]));  // rtl/tim162.v(543)
  reg_sr_as_w1 \rflg/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_timflg),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rflg/timflg [3]));  // rtl/tim162.v(543)
  reg_sr_as_w1 \rflg/rflg_cmaf_reg  (
    .clk(clk),
    .d(\rflg/n12 ),
    .en(rcnt_up),
    .reset(~\rflg/u19_sel_is_0_o ),
    .set(1'b0),
    .q(\rflg/rflg_cmaf ));  // rtl/tim162.v(509)
  reg_sr_as_w1 \rflg/rflg_cmbf_reg  (
    .clk(clk),
    .d(\rflg/n20 ),
    .en(rcnt_up),
    .reset(~\rflg/u29_sel_is_0_o ),
    .set(1'b0),
    .q(\rflg/rflg_cmbf ));  // rtl/tim162.v(532)
  reg_sr_as_w1 \rflg/rflg_ovff_reg  (
    .clk(clk),
    .d(\rflg/rflg_ovff_d ),
    .en(1'b1),
    .reset(~\rflg/u9_sel_is_0_o ),
    .set(1'b0),
    .q(\rflg/rflg_ovff ));  // rtl/tim162.v(486)
  reg_sr_as_w1 \rprd/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[0]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[1]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[10]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[11]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[12]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[13]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[14]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[15]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[2]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[3]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[4]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[5]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[6]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[7]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[8]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rprd/reg0_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(wr_timprd),
    .reset(~rst_n),
    .set(1'b0),
    .q(timprd[9]));  // rtl/tim162.v(591)
  reg_sr_as_w1 \rpsc/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[0]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[1]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[10]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[11]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[12]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[13]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[14]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[15]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[2]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[3]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[4]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[5]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[6]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[7]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[8]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \rpsc/reg0_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(\rpsc/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(timpsc[9]));  // rtl/tim162.v(628)
  reg_sr_as_w1 \tctl/rd_timcma_reg  (
    .clk(clk),
    .d(\tctl/n14 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_timcma));  // rtl/tim162.v(310)
  reg_sr_as_w1 \tctl/rd_timcmb_reg  (
    .clk(clk),
    .d(\tctl/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_timcmb));  // rtl/tim162.v(310)
  reg_sr_as_w1 \tctl/rd_timcnt_reg  (
    .clk(clk),
    .d(\tctl/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_timcnt));  // rtl/tim162.v(310)
  reg_sr_as_w1 \tctl/rd_timctl_reg  (
    .clk(clk),
    .d(\tctl/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_timctl));  // rtl/tim162.v(310)
  reg_sr_as_w1 \tctl/rd_timflg_reg  (
    .clk(clk),
    .d(\tctl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_timflg));  // rtl/tim162.v(310)
  reg_sr_as_w1 \tctl/rd_timprd_reg  (
    .clk(clk),
    .d(\tctl/n12 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_timprd));  // rtl/tim162.v(310)
  reg_sr_as_w1 \tctl/rd_timpsc_reg  (
    .clk(clk),
    .d(\tctl/n8 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_timpsc));  // rtl/tim162.v(310)

endmodule 

