
`timescale 1ns / 1ps
module systim  // rtl/systim.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_sytm_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  bdatr
  );
//
//	System Timer Unit
//		(c) 2021	1YEN Toru
//
//
//	2021/07/31	ver.1.02
//		corresponding to internal offset register
//			sytmctl[TCOE, MCOE, MLOE] bit
//
//	2021/03/27	ver.1.00
//		clock, micro seconds and milli seconds counter
//

  input [3:0] badr;  // rtl/systim.v(19)
  input bcmdr;  // rtl/systim.v(17)
  input bcmdw;  // rtl/systim.v(16)
  input bcs_sytm_n;  // rtl/systim.v(18)
  input [15:0] bdatw;  // rtl/systim.v(20)
  input brdy;  // rtl/systim.v(15)
  input clk;  // rtl/systim.v(13)
  input rst_n;  // rtl/systim.v(14)
  output [15:0] bdatr;  // rtl/systim.v(21)

  wire [31:0] mcrcnt;  // rtl/systim.v(38)
  wire [31:0] \micr/mcrcnt ;  // rtl/systim.v(312)
  wire [31:0] \micr/mcrofs ;  // rtl/systim.v(344)
  wire [4:0] \micr/n3 ;
  wire [31:0] \micr/n7 ;
  wire [4:0] \micr/prescl ;  // rtl/systim.v(311)
  wire [31:0] milcnt;  // rtl/systim.v(39)
  wire [31:0] \mill/milcnt ;  // rtl/systim.v(382)
  wire [31:0] \mill/milofs ;  // rtl/systim.v(414)
  wire [14:0] \mill/n3 ;
  wire [31:0] \mill/n7 ;
  wire [14:0] \mill/prescl ;  // rtl/systim.v(381)
  wire [15:0] \rctl/n51 ;
  wire [15:0] \rctl/n53 ;
  wire [15:0] \rctl/n57 ;
  wire [15:0] \rctl/n69 ;
  wire [15:0] \rctl/n72 ;
  wire [15:0] \rctl/n75 ;
  wire [15:0] \rctl/tmpcnt ;  // rtl/systim.v(204)
  wire [31:0] tckcnt;  // rtl/systim.v(37)
  wire [31:0] \tick/n2 ;
  wire [31:0] \tick/tckcnt ;  // rtl/systim.v(268)
  wire [31:0] \tick/tckofs ;  // rtl/systim.v(278)
  wire _al_u131_o;
  wire _al_u132_o;
  wire _al_u133_o;
  wire _al_u137_o;
  wire _al_u138_o;
  wire _al_u139_o;
  wire _al_u143_o;
  wire _al_u144_o;
  wire _al_u145_o;
  wire _al_u148_o;
  wire _al_u151_o;
  wire _al_u155_o;
  wire _al_u156_o;
  wire _al_u157_o;
  wire _al_u160_o;
  wire _al_u162_o;
  wire _al_u166_o;
  wire _al_u168_o;
  wire _al_u172_o;
  wire _al_u174_o;
  wire _al_u179_o;
  wire _al_u180_o;
  wire _al_u181_o;
  wire _al_u184_o;
  wire _al_u186_o;
  wire _al_u190_o;
  wire _al_u192_o;
  wire _al_u197_o;
  wire _al_u198_o;
  wire _al_u199_o;
  wire _al_u203_o;
  wire _al_u204_o;
  wire _al_u205_o;
  wire _al_u208_o;
  wire _al_u210_o;
  wire _al_u214_o;
  wire _al_u216_o;
  wire _al_u220_o;
  wire _al_u223_o;
  wire _al_u76_o;
  wire _al_u77_o;
  wire _al_u78_o;
  wire \micr/_al_n0_en ;
  wire \micr/add0/c0 ;
  wire \micr/add0/c1 ;
  wire \micr/add0/c2 ;
  wire \micr/add0/c3 ;
  wire \micr/add0/c4 ;
  wire \micr/add1/c0 ;
  wire \micr/add1/c1 ;
  wire \micr/add1/c10 ;
  wire \micr/add1/c11 ;
  wire \micr/add1/c12 ;
  wire \micr/add1/c13 ;
  wire \micr/add1/c14 ;
  wire \micr/add1/c15 ;
  wire \micr/add1/c16 ;
  wire \micr/add1/c17 ;
  wire \micr/add1/c18 ;
  wire \micr/add1/c19 ;
  wire \micr/add1/c2 ;
  wire \micr/add1/c20 ;
  wire \micr/add1/c21 ;
  wire \micr/add1/c22 ;
  wire \micr/add1/c23 ;
  wire \micr/add1/c24 ;
  wire \micr/add1/c25 ;
  wire \micr/add1/c26 ;
  wire \micr/add1/c27 ;
  wire \micr/add1/c28 ;
  wire \micr/add1/c29 ;
  wire \micr/add1/c3 ;
  wire \micr/add1/c30 ;
  wire \micr/add1/c31 ;
  wire \micr/add1/c4 ;
  wire \micr/add1/c5 ;
  wire \micr/add1/c6 ;
  wire \micr/add1/c7 ;
  wire \micr/add1/c8 ;
  wire \micr/add1/c9 ;
  wire \micr/cnt_up ;  // rtl/systim.v(310)
  wire \micr/mux1_b0_sel_is_0_o ;
  wire \micr/n1 ;
  wire \micr/n11 ;
  wire \micr/n2 ;
  wire \micr/sub0/c0 ;
  wire \micr/sub0/c1 ;
  wire \micr/sub0/c10 ;
  wire \micr/sub0/c11 ;
  wire \micr/sub0/c12 ;
  wire \micr/sub0/c13 ;
  wire \micr/sub0/c14 ;
  wire \micr/sub0/c15 ;
  wire \micr/sub0/c16 ;
  wire \micr/sub0/c17 ;
  wire \micr/sub0/c18 ;
  wire \micr/sub0/c19 ;
  wire \micr/sub0/c2 ;
  wire \micr/sub0/c20 ;
  wire \micr/sub0/c21 ;
  wire \micr/sub0/c22 ;
  wire \micr/sub0/c23 ;
  wire \micr/sub0/c24 ;
  wire \micr/sub0/c25 ;
  wire \micr/sub0/c26 ;
  wire \micr/sub0/c27 ;
  wire \micr/sub0/c28 ;
  wire \micr/sub0/c29 ;
  wire \micr/sub0/c3 ;
  wire \micr/sub0/c30 ;
  wire \micr/sub0/c31 ;
  wire \micr/sub0/c4 ;
  wire \micr/sub0/c5 ;
  wire \micr/sub0/c6 ;
  wire \micr/sub0/c7 ;
  wire \micr/sub0/c8 ;
  wire \micr/sub0/c9 ;
  wire \mill/add0/c0 ;
  wire \mill/add0/c1 ;
  wire \mill/add0/c10 ;
  wire \mill/add0/c11 ;
  wire \mill/add0/c12 ;
  wire \mill/add0/c13 ;
  wire \mill/add0/c14 ;
  wire \mill/add0/c2 ;
  wire \mill/add0/c3 ;
  wire \mill/add0/c4 ;
  wire \mill/add0/c5 ;
  wire \mill/add0/c6 ;
  wire \mill/add0/c7 ;
  wire \mill/add0/c8 ;
  wire \mill/add0/c9 ;
  wire \mill/add1/c0 ;
  wire \mill/add1/c1 ;
  wire \mill/add1/c10 ;
  wire \mill/add1/c11 ;
  wire \mill/add1/c12 ;
  wire \mill/add1/c13 ;
  wire \mill/add1/c14 ;
  wire \mill/add1/c15 ;
  wire \mill/add1/c16 ;
  wire \mill/add1/c17 ;
  wire \mill/add1/c18 ;
  wire \mill/add1/c19 ;
  wire \mill/add1/c2 ;
  wire \mill/add1/c20 ;
  wire \mill/add1/c21 ;
  wire \mill/add1/c22 ;
  wire \mill/add1/c23 ;
  wire \mill/add1/c24 ;
  wire \mill/add1/c25 ;
  wire \mill/add1/c26 ;
  wire \mill/add1/c27 ;
  wire \mill/add1/c28 ;
  wire \mill/add1/c29 ;
  wire \mill/add1/c3 ;
  wire \mill/add1/c30 ;
  wire \mill/add1/c31 ;
  wire \mill/add1/c4 ;
  wire \mill/add1/c5 ;
  wire \mill/add1/c6 ;
  wire \mill/add1/c7 ;
  wire \mill/add1/c8 ;
  wire \mill/add1/c9 ;
  wire \mill/cnt_up ;  // rtl/systim.v(380)
  wire \mill/mux1_b0_sel_is_0_o ;
  wire \mill/n11 ;
  wire \mill/n2 ;
  wire \mill/sub0/c0 ;
  wire \mill/sub0/c1 ;
  wire \mill/sub0/c10 ;
  wire \mill/sub0/c11 ;
  wire \mill/sub0/c12 ;
  wire \mill/sub0/c13 ;
  wire \mill/sub0/c14 ;
  wire \mill/sub0/c15 ;
  wire \mill/sub0/c16 ;
  wire \mill/sub0/c17 ;
  wire \mill/sub0/c18 ;
  wire \mill/sub0/c19 ;
  wire \mill/sub0/c2 ;
  wire \mill/sub0/c20 ;
  wire \mill/sub0/c21 ;
  wire \mill/sub0/c22 ;
  wire \mill/sub0/c23 ;
  wire \mill/sub0/c24 ;
  wire \mill/sub0/c25 ;
  wire \mill/sub0/c26 ;
  wire \mill/sub0/c27 ;
  wire \mill/sub0/c28 ;
  wire \mill/sub0/c29 ;
  wire \mill/sub0/c3 ;
  wire \mill/sub0/c30 ;
  wire \mill/sub0/c31 ;
  wire \mill/sub0/c4 ;
  wire \mill/sub0/c5 ;
  wire \mill/sub0/c6 ;
  wire \mill/sub0/c7 ;
  wire \mill/sub0/c8 ;
  wire \mill/sub0/c9 ;
  wire \rctl/mcrcnth_rd ;  // rtl/systim.v(139)
  wire \rctl/mcrcntl_rd ;  // rtl/systim.v(142)
  wire \rctl/milcnth_rd ;  // rtl/systim.v(140)
  wire \rctl/milcntl_rd ;  // rtl/systim.v(143)
  wire \rctl/mux1_b0_sel_is_2_o ;
  wire \rctl/n10 ;
  wire \rctl/n12 ;
  wire \rctl/n14 ;
  wire \rctl/n16 ;
  wire \rctl/n2 ;
  wire \rctl/n33 ;
  wire \rctl/n35 ;
  wire \rctl/n37 ;
  wire \rctl/n39 ;
  wire \rctl/n3_lutinv ;
  wire \rctl/n4 ;
  wire \rctl/n6 ;
  wire \rctl/n8 ;
  wire \rctl/sytmctl_rd ;  // rtl/systim.v(137)
  wire \rctl/tckcnth_rd ;  // rtl/systim.v(138)
  wire \rctl/tckcntl_rd ;  // rtl/systim.v(141)
  wire \rctl/tmp_enb ;  // rtl/systim.v(203)
  wire \rctl/u51_sel_is_2_o_neg ;
  wire tctl_mcr_ofse;  // rtl/systim.v(57)
  wire tctl_mcr_ofst;  // rtl/systim.v(54)
  wire tctl_mil_ofse;  // rtl/systim.v(58)
  wire tctl_mil_ofst;  // rtl/systim.v(55)
  wire tctl_rst_all;  // rtl/systim.v(59)
  wire tctl_tck_ofse;  // rtl/systim.v(56)
  wire tctl_tck_ofst;  // rtl/systim.v(53)
  wire \tick/add0/c0 ;
  wire \tick/add0/c1 ;
  wire \tick/add0/c10 ;
  wire \tick/add0/c11 ;
  wire \tick/add0/c12 ;
  wire \tick/add0/c13 ;
  wire \tick/add0/c14 ;
  wire \tick/add0/c15 ;
  wire \tick/add0/c16 ;
  wire \tick/add0/c17 ;
  wire \tick/add0/c18 ;
  wire \tick/add0/c19 ;
  wire \tick/add0/c2 ;
  wire \tick/add0/c20 ;
  wire \tick/add0/c21 ;
  wire \tick/add0/c22 ;
  wire \tick/add0/c23 ;
  wire \tick/add0/c24 ;
  wire \tick/add0/c25 ;
  wire \tick/add0/c26 ;
  wire \tick/add0/c27 ;
  wire \tick/add0/c28 ;
  wire \tick/add0/c29 ;
  wire \tick/add0/c3 ;
  wire \tick/add0/c30 ;
  wire \tick/add0/c31 ;
  wire \tick/add0/c4 ;
  wire \tick/add0/c5 ;
  wire \tick/add0/c6 ;
  wire \tick/add0/c7 ;
  wire \tick/add0/c8 ;
  wire \tick/add0/c9 ;
  wire \tick/n5 ;
  wire \tick/sub0/c0 ;
  wire \tick/sub0/c1 ;
  wire \tick/sub0/c10 ;
  wire \tick/sub0/c11 ;
  wire \tick/sub0/c12 ;
  wire \tick/sub0/c13 ;
  wire \tick/sub0/c14 ;
  wire \tick/sub0/c15 ;
  wire \tick/sub0/c16 ;
  wire \tick/sub0/c17 ;
  wire \tick/sub0/c18 ;
  wire \tick/sub0/c19 ;
  wire \tick/sub0/c2 ;
  wire \tick/sub0/c20 ;
  wire \tick/sub0/c21 ;
  wire \tick/sub0/c22 ;
  wire \tick/sub0/c23 ;
  wire \tick/sub0/c24 ;
  wire \tick/sub0/c25 ;
  wire \tick/sub0/c26 ;
  wire \tick/sub0/c27 ;
  wire \tick/sub0/c28 ;
  wire \tick/sub0/c29 ;
  wire \tick/sub0/c3 ;
  wire \tick/sub0/c30 ;
  wire \tick/sub0/c31 ;
  wire \tick/sub0/c4 ;
  wire \tick/sub0/c5 ;
  wire \tick/sub0/c6 ;
  wire \tick/sub0/c7 ;
  wire \tick/sub0/c8 ;
  wire \tick/sub0/c9 ;

  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u100 (
    .a(\rctl/n51 [3]),
    .b(milcnt[3]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [3]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u101 (
    .a(\rctl/n53 [3]),
    .b(mcrcnt[3]),
    .c(tckcnt[3]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [3]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u102 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [2]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u103 (
    .a(\rctl/n51 [2]),
    .b(milcnt[2]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u104 (
    .a(\rctl/n53 [2]),
    .b(mcrcnt[2]),
    .c(tckcnt[2]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [2]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u105 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [15]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [15]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u106 (
    .a(milcnt[15]),
    .b(\rctl/n51 [15]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [15]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u107 (
    .a(\rctl/n53 [15]),
    .b(mcrcnt[15]),
    .c(tckcnt[15]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [15]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u108 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [14]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [14]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u109 (
    .a(milcnt[14]),
    .b(\rctl/n51 [14]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [14]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u110 (
    .a(\rctl/n53 [14]),
    .b(mcrcnt[14]),
    .c(tckcnt[14]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [14]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u111 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [13]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [13]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u112 (
    .a(milcnt[13]),
    .b(\rctl/n51 [13]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [13]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u113 (
    .a(\rctl/n53 [13]),
    .b(mcrcnt[13]),
    .c(tckcnt[13]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [13]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u114 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [12]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [12]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u115 (
    .a(milcnt[12]),
    .b(\rctl/n51 [12]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [12]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u116 (
    .a(\rctl/n53 [12]),
    .b(mcrcnt[12]),
    .c(tckcnt[12]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [12]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u117 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [11]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [11]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u118 (
    .a(milcnt[11]),
    .b(\rctl/n51 [11]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [11]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u119 (
    .a(\rctl/n53 [11]),
    .b(mcrcnt[11]),
    .c(tckcnt[11]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [11]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u120 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [10]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u121 (
    .a(milcnt[10]),
    .b(\rctl/n51 [10]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [10]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u122 (
    .a(\rctl/n53 [10]),
    .b(mcrcnt[10]),
    .c(tckcnt[10]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [10]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u123 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [1]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u124 (
    .a(\rctl/n51 [1]),
    .b(milcnt[1]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u125 (
    .a(\rctl/n53 [1]),
    .b(mcrcnt[1]),
    .c(tckcnt[1]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [1]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u126 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [0]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [0]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u127 (
    .a(\rctl/n51 [0]),
    .b(milcnt[0]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [0]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u128 (
    .a(\rctl/n53 [0]),
    .b(mcrcnt[0]),
    .c(tckcnt[0]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u129 (
    .a(\mill/n2 ),
    .b(\micr/n1 ),
    .o(\mill/mux1_b0_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u130 (
    .a(milcnt[9]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [9]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [9]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u131 (
    .a(\rctl/n69 [9]),
    .b(milcnt[25]),
    .c(\rctl/milcnth_rd ),
    .o(_al_u131_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E))*~(C)+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*~(C)+~(~A)*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C)"),
    .INIT(32'h0afa3a3a))
    _al_u132 (
    .a(_al_u131_o),
    .b(mcrcnt[9]),
    .c(\rctl/mcrcntl_rd ),
    .d(\rctl/tmpcnt [9]),
    .e(\rctl/tmp_enb ),
    .o(_al_u132_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u133 (
    .a(tckcnt[9]),
    .b(\rctl/tmpcnt [9]),
    .c(\rctl/tmp_enb ),
    .o(_al_u133_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h3333f055))
    _al_u134 (
    .a(_al_u132_o),
    .b(_al_u133_o),
    .c(mcrcnt[25]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [9]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u135 (
    .a(\rctl/n75 [9]),
    .b(tckcnt[25]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[9]));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u136 (
    .a(milcnt[8]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [8]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [8]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u137 (
    .a(\rctl/n69 [8]),
    .b(milcnt[24]),
    .c(\rctl/milcnth_rd ),
    .o(_al_u137_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E))*~(C)+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*~(C)+~(~A)*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C)"),
    .INIT(32'h0afa3a3a))
    _al_u138 (
    .a(_al_u137_o),
    .b(mcrcnt[8]),
    .c(\rctl/mcrcntl_rd ),
    .d(\rctl/tmpcnt [8]),
    .e(\rctl/tmp_enb ),
    .o(_al_u138_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u139 (
    .a(tckcnt[8]),
    .b(\rctl/tmpcnt [8]),
    .c(\rctl/tmp_enb ),
    .o(_al_u139_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h3333f055))
    _al_u140 (
    .a(_al_u138_o),
    .b(_al_u139_o),
    .c(mcrcnt[24]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [8]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u141 (
    .a(\rctl/n75 [8]),
    .b(tckcnt[24]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u142 (
    .a(milcnt[7]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [7]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [7]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u143 (
    .a(\rctl/n69 [7]),
    .b(milcnt[23]),
    .c(\rctl/milcnth_rd ),
    .o(_al_u143_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E))*~(C)+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*~(C)+~(~A)*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C)"),
    .INIT(32'h0afa3a3a))
    _al_u144 (
    .a(_al_u143_o),
    .b(mcrcnt[7]),
    .c(\rctl/mcrcntl_rd ),
    .d(\rctl/tmpcnt [7]),
    .e(\rctl/tmp_enb ),
    .o(_al_u144_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u145 (
    .a(tckcnt[7]),
    .b(\rctl/tmpcnt [7]),
    .c(\rctl/tmp_enb ),
    .o(_al_u145_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h3333f055))
    _al_u146 (
    .a(_al_u144_o),
    .b(_al_u145_o),
    .c(mcrcnt[23]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [7]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)*~(D)+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*~(D)+~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*C*D+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*D)"),
    .INIT(32'hf0ccf0aa))
    _al_u147 (
    .a(\rctl/n75 [7]),
    .b(tckcnt[23]),
    .c(tctl_tck_ofse),
    .d(\rctl/sytmctl_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(bdatr[7]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u148 (
    .a(mcrcnt[6]),
    .b(\rctl/tmpcnt [6]),
    .c(\rctl/tmp_enb ),
    .o(_al_u148_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u149 (
    .a(milcnt[6]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [6]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [6]));
  AL_MAP_LUT5 #(
    .EQN("~(~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)*~(D)+~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A*~(D)+~(~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*A*D+~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A*D)"),
    .INIT(32'h55f055cc))
    _al_u150 (
    .a(_al_u148_o),
    .b(\rctl/n69 [6]),
    .c(milcnt[22]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [6]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u151 (
    .a(tckcnt[6]),
    .b(\rctl/tmpcnt [6]),
    .c(\rctl/tmp_enb ),
    .o(_al_u151_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u152 (
    .a(\rctl/n72 [6]),
    .b(_al_u151_o),
    .c(mcrcnt[22]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [6]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)*~(D)+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*~(D)+~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*C*D+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*D)"),
    .INIT(32'hf0ccf0aa))
    _al_u153 (
    .a(\rctl/n75 [6]),
    .b(tckcnt[22]),
    .c(tctl_mcr_ofse),
    .d(\rctl/sytmctl_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u154 (
    .a(milcnt[5]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [5]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [5]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u155 (
    .a(\rctl/n69 [5]),
    .b(milcnt[21]),
    .c(\rctl/milcnth_rd ),
    .o(_al_u155_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E))*~(C)+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*~(C)+~(~A)*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C)"),
    .INIT(32'h0afa3a3a))
    _al_u156 (
    .a(_al_u155_o),
    .b(mcrcnt[5]),
    .c(\rctl/mcrcntl_rd ),
    .d(\rctl/tmpcnt [5]),
    .e(\rctl/tmp_enb ),
    .o(_al_u156_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u157 (
    .a(tckcnt[5]),
    .b(\rctl/tmpcnt [5]),
    .c(\rctl/tmp_enb ),
    .o(_al_u157_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h3333f055))
    _al_u158 (
    .a(_al_u156_o),
    .b(_al_u157_o),
    .c(mcrcnt[21]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [5]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)*~(D)+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*~(D)+~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*C*D+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*D)"),
    .INIT(32'hf0ccf0aa))
    _al_u159 (
    .a(\rctl/n75 [5]),
    .b(tckcnt[21]),
    .c(tctl_mil_ofse),
    .d(\rctl/sytmctl_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(bdatr[5]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u160 (
    .a(tckcnt[4]),
    .b(\rctl/tmpcnt [4]),
    .c(\rctl/tmp_enb ),
    .o(_al_u160_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u161 (
    .a(milcnt[4]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [4]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [4]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u162 (
    .a(mcrcnt[4]),
    .b(\rctl/tmpcnt [4]),
    .c(\rctl/tmp_enb ),
    .o(_al_u162_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h33f033aa))
    _al_u163 (
    .a(\rctl/n69 [4]),
    .b(_al_u162_o),
    .c(milcnt[20]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [4]));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u164 (
    .a(\rctl/n72 [4]),
    .b(_al_u160_o),
    .c(mcrcnt[20]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u165 (
    .a(\rctl/n75 [4]),
    .b(tckcnt[20]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[4]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u166 (
    .a(tckcnt[3]),
    .b(\rctl/tmpcnt [3]),
    .c(\rctl/tmp_enb ),
    .o(_al_u166_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u167 (
    .a(milcnt[3]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [3]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [3]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u168 (
    .a(mcrcnt[3]),
    .b(\rctl/tmpcnt [3]),
    .c(\rctl/tmp_enb ),
    .o(_al_u168_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h33f033aa))
    _al_u169 (
    .a(\rctl/n69 [3]),
    .b(_al_u168_o),
    .c(milcnt[19]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [3]));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u170 (
    .a(\rctl/n72 [3]),
    .b(_al_u166_o),
    .c(mcrcnt[19]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u171 (
    .a(\rctl/n75 [3]),
    .b(tckcnt[19]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[3]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u172 (
    .a(tckcnt[2]),
    .b(\rctl/tmpcnt [2]),
    .c(\rctl/tmp_enb ),
    .o(_al_u172_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u173 (
    .a(milcnt[2]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [2]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u174 (
    .a(mcrcnt[2]),
    .b(\rctl/tmpcnt [2]),
    .c(\rctl/tmp_enb ),
    .o(_al_u174_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h33f033aa))
    _al_u175 (
    .a(\rctl/n69 [2]),
    .b(_al_u174_o),
    .c(milcnt[18]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [2]));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u176 (
    .a(\rctl/n72 [2]),
    .b(_al_u172_o),
    .c(mcrcnt[18]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u177 (
    .a(\rctl/n75 [2]),
    .b(tckcnt[18]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u178 (
    .a(milcnt[15]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [15]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [15]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u179 (
    .a(\rctl/n69 [15]),
    .b(milcnt[31]),
    .c(\rctl/milcnth_rd ),
    .o(_al_u179_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E))*~(C)+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*~(C)+~(~A)*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C)"),
    .INIT(32'h0afa3a3a))
    _al_u180 (
    .a(_al_u179_o),
    .b(mcrcnt[15]),
    .c(\rctl/mcrcntl_rd ),
    .d(\rctl/tmpcnt [15]),
    .e(\rctl/tmp_enb ),
    .o(_al_u180_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u181 (
    .a(tckcnt[15]),
    .b(\rctl/tmpcnt [15]),
    .c(\rctl/tmp_enb ),
    .o(_al_u181_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h3333f055))
    _al_u182 (
    .a(_al_u180_o),
    .b(_al_u181_o),
    .c(mcrcnt[31]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [15]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u183 (
    .a(\rctl/n75 [15]),
    .b(tckcnt[31]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[15]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u184 (
    .a(tckcnt[14]),
    .b(\rctl/tmpcnt [14]),
    .c(\rctl/tmp_enb ),
    .o(_al_u184_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u185 (
    .a(milcnt[14]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [14]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [14]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u186 (
    .a(mcrcnt[14]),
    .b(\rctl/tmpcnt [14]),
    .c(\rctl/tmp_enb ),
    .o(_al_u186_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h33f033aa))
    _al_u187 (
    .a(\rctl/n69 [14]),
    .b(_al_u186_o),
    .c(milcnt[30]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [14]));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u188 (
    .a(\rctl/n72 [14]),
    .b(_al_u184_o),
    .c(mcrcnt[30]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [14]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u189 (
    .a(\rctl/n75 [14]),
    .b(tckcnt[30]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[14]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u190 (
    .a(tckcnt[13]),
    .b(\rctl/tmpcnt [13]),
    .c(\rctl/tmp_enb ),
    .o(_al_u190_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u191 (
    .a(milcnt[13]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [13]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [13]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u192 (
    .a(mcrcnt[13]),
    .b(\rctl/tmpcnt [13]),
    .c(\rctl/tmp_enb ),
    .o(_al_u192_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h33f033aa))
    _al_u193 (
    .a(\rctl/n69 [13]),
    .b(_al_u192_o),
    .c(milcnt[29]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [13]));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u194 (
    .a(\rctl/n72 [13]),
    .b(_al_u190_o),
    .c(mcrcnt[29]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [13]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u195 (
    .a(\rctl/n75 [13]),
    .b(tckcnt[29]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u196 (
    .a(milcnt[12]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [12]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [12]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u197 (
    .a(\rctl/n69 [12]),
    .b(milcnt[28]),
    .c(\rctl/milcnth_rd ),
    .o(_al_u197_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E))*~(C)+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*~(C)+~(~A)*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C)"),
    .INIT(32'h0afa3a3a))
    _al_u198 (
    .a(_al_u197_o),
    .b(mcrcnt[12]),
    .c(\rctl/mcrcntl_rd ),
    .d(\rctl/tmpcnt [12]),
    .e(\rctl/tmp_enb ),
    .o(_al_u198_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u199 (
    .a(tckcnt[12]),
    .b(\rctl/tmpcnt [12]),
    .c(\rctl/tmp_enb ),
    .o(_al_u199_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h3333f055))
    _al_u200 (
    .a(_al_u198_o),
    .b(_al_u199_o),
    .c(mcrcnt[28]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [12]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u201 (
    .a(\rctl/n75 [12]),
    .b(tckcnt[28]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u202 (
    .a(milcnt[11]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [11]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [11]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u203 (
    .a(\rctl/n69 [11]),
    .b(milcnt[27]),
    .c(\rctl/milcnth_rd ),
    .o(_al_u203_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E))*~(C)+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*~(C)+~(~A)*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C+~A*(B*~(D)*~(E)+B*D*~(E)+~(B)*D*E+B*D*E)*C)"),
    .INIT(32'h0afa3a3a))
    _al_u204 (
    .a(_al_u203_o),
    .b(mcrcnt[11]),
    .c(\rctl/mcrcntl_rd ),
    .d(\rctl/tmpcnt [11]),
    .e(\rctl/tmp_enb ),
    .o(_al_u204_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u205 (
    .a(tckcnt[11]),
    .b(\rctl/tmpcnt [11]),
    .c(\rctl/tmp_enb ),
    .o(_al_u205_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~(~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h3333f055))
    _al_u206 (
    .a(_al_u204_o),
    .b(_al_u205_o),
    .c(mcrcnt[27]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [11]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u207 (
    .a(\rctl/n75 [11]),
    .b(tckcnt[27]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[11]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u208 (
    .a(tckcnt[10]),
    .b(\rctl/tmpcnt [10]),
    .c(\rctl/tmp_enb ),
    .o(_al_u208_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u209 (
    .a(milcnt[10]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [10]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [10]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u210 (
    .a(mcrcnt[10]),
    .b(\rctl/tmpcnt [10]),
    .c(\rctl/tmp_enb ),
    .o(_al_u210_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h33f033aa))
    _al_u211 (
    .a(\rctl/n69 [10]),
    .b(_al_u210_o),
    .c(milcnt[26]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [10]));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u212 (
    .a(\rctl/n72 [10]),
    .b(_al_u208_o),
    .c(mcrcnt[26]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [10]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u213 (
    .a(\rctl/n75 [10]),
    .b(tckcnt[26]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[10]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u214 (
    .a(tckcnt[1]),
    .b(\rctl/tmpcnt [1]),
    .c(\rctl/tmp_enb ),
    .o(_al_u214_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u215 (
    .a(milcnt[1]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [1]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [1]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u216 (
    .a(mcrcnt[1]),
    .b(\rctl/tmpcnt [1]),
    .c(\rctl/tmp_enb ),
    .o(_al_u216_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~(~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+~(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h33f033aa))
    _al_u217 (
    .a(\rctl/n69 [1]),
    .b(_al_u216_o),
    .c(milcnt[17]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [1]));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u218 (
    .a(\rctl/n72 [1]),
    .b(_al_u214_o),
    .c(mcrcnt[17]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h0c0a))
    _al_u219 (
    .a(\rctl/n75 [1]),
    .b(tckcnt[17]),
    .c(\rctl/sytmctl_rd ),
    .d(\rctl/tckcnth_rd ),
    .o(bdatr[1]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u220 (
    .a(mcrcnt[0]),
    .b(\rctl/tmpcnt [0]),
    .c(\rctl/tmp_enb ),
    .o(_al_u220_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))"),
    .INIT(16'hc088))
    _al_u221 (
    .a(milcnt[0]),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [0]),
    .d(\rctl/tmp_enb ),
    .o(\rctl/n69 [0]));
  AL_MAP_LUT5 #(
    .EQN("~(~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)*~(D)+~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A*~(D)+~(~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*A*D+~(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A*D)"),
    .INIT(32'h55f055cc))
    _al_u222 (
    .a(_al_u220_o),
    .b(\rctl/n69 [0]),
    .c(milcnt[16]),
    .d(\rctl/mcrcntl_rd ),
    .e(\rctl/milcnth_rd ),
    .o(\rctl/n72 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u223 (
    .a(tckcnt[0]),
    .b(\rctl/tmpcnt [0]),
    .c(\rctl/tmp_enb ),
    .o(_al_u223_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~(~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+~(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'h3333f0aa))
    _al_u224 (
    .a(\rctl/n72 [0]),
    .b(_al_u223_o),
    .c(mcrcnt[16]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcntl_rd ),
    .o(\rctl/n75 [0]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)*~(D)+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*~(D)+~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*C*D+(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*D)"),
    .INIT(32'hf0ccf0aa))
    _al_u225 (
    .a(\rctl/n75 [0]),
    .b(tckcnt[16]),
    .c(tctl_rst_all),
    .d(\rctl/sytmctl_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(bdatr[0]));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u55 (
    .a(tctl_rst_all),
    .b(rst_n),
    .o(\micr/n1 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u56 (
    .a(tctl_mil_ofse),
    .b(bdatw[5]),
    .o(\rctl/n39 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u57 (
    .a(tctl_mcr_ofse),
    .b(bdatw[6]),
    .o(\rctl/n37 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u58 (
    .a(tctl_tck_ofse),
    .b(bdatw[7]),
    .o(\rctl/n35 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u59 (
    .a(\micr/n1 ),
    .b(tctl_tck_ofse),
    .o(\tick/n5 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u60 (
    .a(\micr/n1 ),
    .b(tctl_mil_ofse),
    .o(\mill/n11 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u61 (
    .a(\micr/n1 ),
    .b(tctl_mcr_ofse),
    .o(\micr/n11 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u62 (
    .a(badr[3]),
    .b(badr[2]),
    .c(badr[1]),
    .d(badr[0]),
    .o(\rctl/n3_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u63 (
    .a(bcmdr),
    .b(bcs_sytm_n),
    .o(\rctl/n2 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u64 (
    .a(\rctl/n3_lutinv ),
    .b(\rctl/n2 ),
    .o(\rctl/n4 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u65 (
    .a(\rctl/n3_lutinv ),
    .b(bcmdw),
    .c(bcs_sytm_n),
    .d(brdy),
    .o(\rctl/n33 ));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~B*~A)"),
    .INIT(8'hfe))
    _al_u66 (
    .a(\rctl/mcrcnth_rd ),
    .b(\rctl/milcnth_rd ),
    .c(\rctl/tckcnth_rd ),
    .o(\rctl/u51_sel_is_2_o_neg ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u67 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n8 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u68 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u69 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n6 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u70 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u71 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n14 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u72 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n12 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u73 (
    .a(\rctl/n33 ),
    .b(rst_n),
    .o(\rctl/mux1_b0_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*B*A)"),
    .INIT(32'h00800000))
    _al_u74 (
    .a(\micr/prescl [0]),
    .b(\micr/prescl [1]),
    .c(\micr/prescl [2]),
    .d(\micr/prescl [3]),
    .e(\micr/prescl [4]),
    .o(\micr/n2 ));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(E*~(~D*~C*~B)))"),
    .INIT(32'hfffeaaaa))
    _al_u75 (
    .a(\rctl/u51_sel_is_2_o_neg ),
    .b(\rctl/mcrcntl_rd ),
    .c(\rctl/milcntl_rd ),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\micr/_al_n0_en ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u76 (
    .a(\mill/prescl [0]),
    .b(\mill/prescl [1]),
    .c(\mill/prescl [10]),
    .d(\mill/prescl [11]),
    .o(_al_u76_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u77 (
    .a(_al_u76_o),
    .b(\mill/prescl [12]),
    .c(\mill/prescl [13]),
    .d(\mill/prescl [14]),
    .e(\mill/prescl [2]),
    .o(_al_u77_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u78 (
    .a(\mill/prescl [3]),
    .b(\mill/prescl [4]),
    .c(\mill/prescl [5]),
    .d(\mill/prescl [6]),
    .o(_al_u78_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u79 (
    .a(_al_u77_o),
    .b(_al_u78_o),
    .c(\mill/prescl [7]),
    .d(\mill/prescl [8]),
    .e(\mill/prescl [9]),
    .o(\mill/n2 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u80 (
    .a(\micr/n2 ),
    .b(\micr/n1 ),
    .o(\micr/mux1_b0_sel_is_0_o ));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u81 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [9]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u82 (
    .a(milcnt[9]),
    .b(\rctl/n51 [9]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [9]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u83 (
    .a(\rctl/n53 [9]),
    .b(mcrcnt[9]),
    .c(tckcnt[9]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [9]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u84 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [8]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u85 (
    .a(milcnt[8]),
    .b(\rctl/n51 [8]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [8]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u86 (
    .a(\rctl/n53 [8]),
    .b(mcrcnt[8]),
    .c(tckcnt[8]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [8]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u87 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [7]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u88 (
    .a(milcnt[7]),
    .b(\rctl/n51 [7]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [7]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u89 (
    .a(\rctl/n53 [7]),
    .b(mcrcnt[7]),
    .c(tckcnt[7]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [7]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u90 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [6]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u91 (
    .a(milcnt[6]),
    .b(\rctl/n51 [6]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [6]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u92 (
    .a(\rctl/n53 [6]),
    .b(mcrcnt[6]),
    .c(tckcnt[6]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [6]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u93 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [5]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u94 (
    .a(milcnt[5]),
    .b(\rctl/n51 [5]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [5]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u95 (
    .a(\rctl/n53 [5]),
    .b(mcrcnt[5]),
    .c(tckcnt[5]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [5]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u96 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [4]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u97 (
    .a(\rctl/n51 [4]),
    .b(milcnt[4]),
    .c(\rctl/milcnth_rd ),
    .o(\rctl/n53 [4]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u98 (
    .a(\rctl/n53 [4]),
    .b(mcrcnt[4]),
    .c(tckcnt[4]),
    .d(\rctl/mcrcnth_rd ),
    .e(\rctl/tckcnth_rd ),
    .o(\rctl/n57 [4]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*~B*~A)))"),
    .INIT(32'h0010f0f0))
    _al_u99 (
    .a(\rctl/mcrcntl_rd ),
    .b(\rctl/milcntl_rd ),
    .c(\rctl/tmpcnt [3]),
    .d(\rctl/tckcntl_rd ),
    .e(brdy),
    .o(\rctl/n51 [3]));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add0/u0  (
    .a(\micr/prescl [0]),
    .b(1'b1),
    .c(\micr/add0/c0 ),
    .o({\micr/add0/c1 ,\micr/n3 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add0/u1  (
    .a(\micr/prescl [1]),
    .b(1'b0),
    .c(\micr/add0/c1 ),
    .o({\micr/add0/c2 ,\micr/n3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add0/u2  (
    .a(\micr/prescl [2]),
    .b(1'b0),
    .c(\micr/add0/c2 ),
    .o({\micr/add0/c3 ,\micr/n3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add0/u3  (
    .a(\micr/prescl [3]),
    .b(1'b0),
    .c(\micr/add0/c3 ),
    .o({\micr/add0/c4 ,\micr/n3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add0/u4  (
    .a(\micr/prescl [4]),
    .b(1'b0),
    .c(\micr/add0/c4 ),
    .o({open_n0,\micr/n3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \micr/add0/ucin  (
    .a(1'b0),
    .o({\micr/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u0  (
    .a(\micr/mcrcnt [0]),
    .b(1'b1),
    .c(\micr/add1/c0 ),
    .o({\micr/add1/c1 ,\micr/n7 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u1  (
    .a(\micr/mcrcnt [1]),
    .b(1'b0),
    .c(\micr/add1/c1 ),
    .o({\micr/add1/c2 ,\micr/n7 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u10  (
    .a(\micr/mcrcnt [10]),
    .b(1'b0),
    .c(\micr/add1/c10 ),
    .o({\micr/add1/c11 ,\micr/n7 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u11  (
    .a(\micr/mcrcnt [11]),
    .b(1'b0),
    .c(\micr/add1/c11 ),
    .o({\micr/add1/c12 ,\micr/n7 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u12  (
    .a(\micr/mcrcnt [12]),
    .b(1'b0),
    .c(\micr/add1/c12 ),
    .o({\micr/add1/c13 ,\micr/n7 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u13  (
    .a(\micr/mcrcnt [13]),
    .b(1'b0),
    .c(\micr/add1/c13 ),
    .o({\micr/add1/c14 ,\micr/n7 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u14  (
    .a(\micr/mcrcnt [14]),
    .b(1'b0),
    .c(\micr/add1/c14 ),
    .o({\micr/add1/c15 ,\micr/n7 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u15  (
    .a(\micr/mcrcnt [15]),
    .b(1'b0),
    .c(\micr/add1/c15 ),
    .o({\micr/add1/c16 ,\micr/n7 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u16  (
    .a(\micr/mcrcnt [16]),
    .b(1'b0),
    .c(\micr/add1/c16 ),
    .o({\micr/add1/c17 ,\micr/n7 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u17  (
    .a(\micr/mcrcnt [17]),
    .b(1'b0),
    .c(\micr/add1/c17 ),
    .o({\micr/add1/c18 ,\micr/n7 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u18  (
    .a(\micr/mcrcnt [18]),
    .b(1'b0),
    .c(\micr/add1/c18 ),
    .o({\micr/add1/c19 ,\micr/n7 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u19  (
    .a(\micr/mcrcnt [19]),
    .b(1'b0),
    .c(\micr/add1/c19 ),
    .o({\micr/add1/c20 ,\micr/n7 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u2  (
    .a(\micr/mcrcnt [2]),
    .b(1'b0),
    .c(\micr/add1/c2 ),
    .o({\micr/add1/c3 ,\micr/n7 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u20  (
    .a(\micr/mcrcnt [20]),
    .b(1'b0),
    .c(\micr/add1/c20 ),
    .o({\micr/add1/c21 ,\micr/n7 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u21  (
    .a(\micr/mcrcnt [21]),
    .b(1'b0),
    .c(\micr/add1/c21 ),
    .o({\micr/add1/c22 ,\micr/n7 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u22  (
    .a(\micr/mcrcnt [22]),
    .b(1'b0),
    .c(\micr/add1/c22 ),
    .o({\micr/add1/c23 ,\micr/n7 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u23  (
    .a(\micr/mcrcnt [23]),
    .b(1'b0),
    .c(\micr/add1/c23 ),
    .o({\micr/add1/c24 ,\micr/n7 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u24  (
    .a(\micr/mcrcnt [24]),
    .b(1'b0),
    .c(\micr/add1/c24 ),
    .o({\micr/add1/c25 ,\micr/n7 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u25  (
    .a(\micr/mcrcnt [25]),
    .b(1'b0),
    .c(\micr/add1/c25 ),
    .o({\micr/add1/c26 ,\micr/n7 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u26  (
    .a(\micr/mcrcnt [26]),
    .b(1'b0),
    .c(\micr/add1/c26 ),
    .o({\micr/add1/c27 ,\micr/n7 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u27  (
    .a(\micr/mcrcnt [27]),
    .b(1'b0),
    .c(\micr/add1/c27 ),
    .o({\micr/add1/c28 ,\micr/n7 [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u28  (
    .a(\micr/mcrcnt [28]),
    .b(1'b0),
    .c(\micr/add1/c28 ),
    .o({\micr/add1/c29 ,\micr/n7 [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u29  (
    .a(\micr/mcrcnt [29]),
    .b(1'b0),
    .c(\micr/add1/c29 ),
    .o({\micr/add1/c30 ,\micr/n7 [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u3  (
    .a(\micr/mcrcnt [3]),
    .b(1'b0),
    .c(\micr/add1/c3 ),
    .o({\micr/add1/c4 ,\micr/n7 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u30  (
    .a(\micr/mcrcnt [30]),
    .b(1'b0),
    .c(\micr/add1/c30 ),
    .o({\micr/add1/c31 ,\micr/n7 [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u31  (
    .a(\micr/mcrcnt [31]),
    .b(1'b0),
    .c(\micr/add1/c31 ),
    .o({open_n4,\micr/n7 [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u4  (
    .a(\micr/mcrcnt [4]),
    .b(1'b0),
    .c(\micr/add1/c4 ),
    .o({\micr/add1/c5 ,\micr/n7 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u5  (
    .a(\micr/mcrcnt [5]),
    .b(1'b0),
    .c(\micr/add1/c5 ),
    .o({\micr/add1/c6 ,\micr/n7 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u6  (
    .a(\micr/mcrcnt [6]),
    .b(1'b0),
    .c(\micr/add1/c6 ),
    .o({\micr/add1/c7 ,\micr/n7 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u7  (
    .a(\micr/mcrcnt [7]),
    .b(1'b0),
    .c(\micr/add1/c7 ),
    .o({\micr/add1/c8 ,\micr/n7 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u8  (
    .a(\micr/mcrcnt [8]),
    .b(1'b0),
    .c(\micr/add1/c8 ),
    .o({\micr/add1/c9 ,\micr/n7 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \micr/add1/u9  (
    .a(\micr/mcrcnt [9]),
    .b(1'b0),
    .c(\micr/add1/c9 ),
    .o({\micr/add1/c10 ,\micr/n7 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \micr/add1/ucin  (
    .a(1'b0),
    .o({\micr/add1/c0 ,open_n7}));
  reg_sr_as_w1 \micr/cnt_up_reg  (
    .clk(clk),
    .d(\micr/n2 ),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/cnt_up ));  // rtl/systim.v(332)
  reg_sr_as_w1 \micr/reg0_b0  (
    .clk(clk),
    .d(\micr/n7 [0]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [0]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b1  (
    .clk(clk),
    .d(\micr/n7 [1]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [1]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b10  (
    .clk(clk),
    .d(\micr/n7 [10]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [10]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b11  (
    .clk(clk),
    .d(\micr/n7 [11]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [11]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b12  (
    .clk(clk),
    .d(\micr/n7 [12]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [12]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b13  (
    .clk(clk),
    .d(\micr/n7 [13]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [13]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b14  (
    .clk(clk),
    .d(\micr/n7 [14]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [14]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b15  (
    .clk(clk),
    .d(\micr/n7 [15]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [15]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b16  (
    .clk(clk),
    .d(\micr/n7 [16]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [16]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b17  (
    .clk(clk),
    .d(\micr/n7 [17]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [17]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b18  (
    .clk(clk),
    .d(\micr/n7 [18]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [18]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b19  (
    .clk(clk),
    .d(\micr/n7 [19]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [19]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b2  (
    .clk(clk),
    .d(\micr/n7 [2]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [2]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b20  (
    .clk(clk),
    .d(\micr/n7 [20]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [20]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b21  (
    .clk(clk),
    .d(\micr/n7 [21]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [21]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b22  (
    .clk(clk),
    .d(\micr/n7 [22]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [22]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b23  (
    .clk(clk),
    .d(\micr/n7 [23]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [23]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b24  (
    .clk(clk),
    .d(\micr/n7 [24]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [24]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b25  (
    .clk(clk),
    .d(\micr/n7 [25]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [25]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b26  (
    .clk(clk),
    .d(\micr/n7 [26]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [26]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b27  (
    .clk(clk),
    .d(\micr/n7 [27]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [27]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b28  (
    .clk(clk),
    .d(\micr/n7 [28]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [28]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b29  (
    .clk(clk),
    .d(\micr/n7 [29]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [29]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b3  (
    .clk(clk),
    .d(\micr/n7 [3]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [3]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b30  (
    .clk(clk),
    .d(\micr/n7 [30]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [30]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b31  (
    .clk(clk),
    .d(\micr/n7 [31]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [31]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b4  (
    .clk(clk),
    .d(\micr/n7 [4]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [4]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b5  (
    .clk(clk),
    .d(\micr/n7 [5]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [5]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b6  (
    .clk(clk),
    .d(\micr/n7 [6]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [6]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b7  (
    .clk(clk),
    .d(\micr/n7 [7]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [7]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b8  (
    .clk(clk),
    .d(\micr/n7 [8]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [8]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg0_b9  (
    .clk(clk),
    .d(\micr/n7 [9]),
    .en(\micr/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\micr/mcrcnt [9]));  // rtl/systim.v(341)
  reg_sr_as_w1 \micr/reg1_b0  (
    .clk(clk),
    .d(\micr/mcrcnt [0]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [0]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b1  (
    .clk(clk),
    .d(\micr/mcrcnt [1]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [1]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b10  (
    .clk(clk),
    .d(\micr/mcrcnt [10]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [10]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b11  (
    .clk(clk),
    .d(\micr/mcrcnt [11]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [11]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b12  (
    .clk(clk),
    .d(\micr/mcrcnt [12]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [12]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b13  (
    .clk(clk),
    .d(\micr/mcrcnt [13]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [13]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b14  (
    .clk(clk),
    .d(\micr/mcrcnt [14]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [14]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b15  (
    .clk(clk),
    .d(\micr/mcrcnt [15]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [15]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b16  (
    .clk(clk),
    .d(\micr/mcrcnt [16]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [16]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b17  (
    .clk(clk),
    .d(\micr/mcrcnt [17]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [17]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b18  (
    .clk(clk),
    .d(\micr/mcrcnt [18]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [18]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b19  (
    .clk(clk),
    .d(\micr/mcrcnt [19]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [19]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b2  (
    .clk(clk),
    .d(\micr/mcrcnt [2]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [2]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b20  (
    .clk(clk),
    .d(\micr/mcrcnt [20]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [20]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b21  (
    .clk(clk),
    .d(\micr/mcrcnt [21]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [21]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b22  (
    .clk(clk),
    .d(\micr/mcrcnt [22]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [22]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b23  (
    .clk(clk),
    .d(\micr/mcrcnt [23]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [23]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b24  (
    .clk(clk),
    .d(\micr/mcrcnt [24]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [24]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b25  (
    .clk(clk),
    .d(\micr/mcrcnt [25]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [25]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b26  (
    .clk(clk),
    .d(\micr/mcrcnt [26]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [26]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b27  (
    .clk(clk),
    .d(\micr/mcrcnt [27]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [27]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b28  (
    .clk(clk),
    .d(\micr/mcrcnt [28]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [28]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b29  (
    .clk(clk),
    .d(\micr/mcrcnt [29]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [29]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b3  (
    .clk(clk),
    .d(\micr/mcrcnt [3]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [3]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b30  (
    .clk(clk),
    .d(\micr/mcrcnt [30]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [30]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b31  (
    .clk(clk),
    .d(\micr/mcrcnt [31]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [31]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b4  (
    .clk(clk),
    .d(\micr/mcrcnt [4]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [4]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b5  (
    .clk(clk),
    .d(\micr/mcrcnt [5]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [5]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b6  (
    .clk(clk),
    .d(\micr/mcrcnt [6]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [6]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b7  (
    .clk(clk),
    .d(\micr/mcrcnt [7]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [7]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b8  (
    .clk(clk),
    .d(\micr/mcrcnt [8]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [8]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg1_b9  (
    .clk(clk),
    .d(\micr/mcrcnt [9]),
    .en(tctl_mcr_ofst),
    .reset(\micr/n11 ),
    .set(1'b0),
    .q(\micr/mcrofs [9]));  // rtl/systim.v(351)
  reg_sr_as_w1 \micr/reg2_b0  (
    .clk(clk),
    .d(\micr/n3 [0]),
    .en(1'b1),
    .reset(~\micr/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\micr/prescl [0]));  // rtl/systim.v(332)
  reg_sr_as_w1 \micr/reg2_b1  (
    .clk(clk),
    .d(\micr/n3 [1]),
    .en(1'b1),
    .reset(~\micr/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\micr/prescl [1]));  // rtl/systim.v(332)
  reg_sr_as_w1 \micr/reg2_b2  (
    .clk(clk),
    .d(\micr/n3 [2]),
    .en(1'b1),
    .reset(~\micr/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\micr/prescl [2]));  // rtl/systim.v(332)
  reg_sr_as_w1 \micr/reg2_b3  (
    .clk(clk),
    .d(\micr/n3 [3]),
    .en(1'b1),
    .reset(~\micr/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\micr/prescl [3]));  // rtl/systim.v(332)
  reg_sr_as_w1 \micr/reg2_b4  (
    .clk(clk),
    .d(\micr/n3 [4]),
    .en(1'b1),
    .reset(~\micr/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\micr/prescl [4]));  // rtl/systim.v(332)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u0  (
    .a(\micr/mcrcnt [0]),
    .b(\micr/mcrofs [0]),
    .c(\micr/sub0/c0 ),
    .o({\micr/sub0/c1 ,mcrcnt[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u1  (
    .a(\micr/mcrcnt [1]),
    .b(\micr/mcrofs [1]),
    .c(\micr/sub0/c1 ),
    .o({\micr/sub0/c2 ,mcrcnt[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u10  (
    .a(\micr/mcrcnt [10]),
    .b(\micr/mcrofs [10]),
    .c(\micr/sub0/c10 ),
    .o({\micr/sub0/c11 ,mcrcnt[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u11  (
    .a(\micr/mcrcnt [11]),
    .b(\micr/mcrofs [11]),
    .c(\micr/sub0/c11 ),
    .o({\micr/sub0/c12 ,mcrcnt[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u12  (
    .a(\micr/mcrcnt [12]),
    .b(\micr/mcrofs [12]),
    .c(\micr/sub0/c12 ),
    .o({\micr/sub0/c13 ,mcrcnt[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u13  (
    .a(\micr/mcrcnt [13]),
    .b(\micr/mcrofs [13]),
    .c(\micr/sub0/c13 ),
    .o({\micr/sub0/c14 ,mcrcnt[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u14  (
    .a(\micr/mcrcnt [14]),
    .b(\micr/mcrofs [14]),
    .c(\micr/sub0/c14 ),
    .o({\micr/sub0/c15 ,mcrcnt[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u15  (
    .a(\micr/mcrcnt [15]),
    .b(\micr/mcrofs [15]),
    .c(\micr/sub0/c15 ),
    .o({\micr/sub0/c16 ,mcrcnt[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u16  (
    .a(\micr/mcrcnt [16]),
    .b(\micr/mcrofs [16]),
    .c(\micr/sub0/c16 ),
    .o({\micr/sub0/c17 ,mcrcnt[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u17  (
    .a(\micr/mcrcnt [17]),
    .b(\micr/mcrofs [17]),
    .c(\micr/sub0/c17 ),
    .o({\micr/sub0/c18 ,mcrcnt[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u18  (
    .a(\micr/mcrcnt [18]),
    .b(\micr/mcrofs [18]),
    .c(\micr/sub0/c18 ),
    .o({\micr/sub0/c19 ,mcrcnt[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u19  (
    .a(\micr/mcrcnt [19]),
    .b(\micr/mcrofs [19]),
    .c(\micr/sub0/c19 ),
    .o({\micr/sub0/c20 ,mcrcnt[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u2  (
    .a(\micr/mcrcnt [2]),
    .b(\micr/mcrofs [2]),
    .c(\micr/sub0/c2 ),
    .o({\micr/sub0/c3 ,mcrcnt[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u20  (
    .a(\micr/mcrcnt [20]),
    .b(\micr/mcrofs [20]),
    .c(\micr/sub0/c20 ),
    .o({\micr/sub0/c21 ,mcrcnt[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u21  (
    .a(\micr/mcrcnt [21]),
    .b(\micr/mcrofs [21]),
    .c(\micr/sub0/c21 ),
    .o({\micr/sub0/c22 ,mcrcnt[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u22  (
    .a(\micr/mcrcnt [22]),
    .b(\micr/mcrofs [22]),
    .c(\micr/sub0/c22 ),
    .o({\micr/sub0/c23 ,mcrcnt[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u23  (
    .a(\micr/mcrcnt [23]),
    .b(\micr/mcrofs [23]),
    .c(\micr/sub0/c23 ),
    .o({\micr/sub0/c24 ,mcrcnt[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u24  (
    .a(\micr/mcrcnt [24]),
    .b(\micr/mcrofs [24]),
    .c(\micr/sub0/c24 ),
    .o({\micr/sub0/c25 ,mcrcnt[24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u25  (
    .a(\micr/mcrcnt [25]),
    .b(\micr/mcrofs [25]),
    .c(\micr/sub0/c25 ),
    .o({\micr/sub0/c26 ,mcrcnt[25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u26  (
    .a(\micr/mcrcnt [26]),
    .b(\micr/mcrofs [26]),
    .c(\micr/sub0/c26 ),
    .o({\micr/sub0/c27 ,mcrcnt[26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u27  (
    .a(\micr/mcrcnt [27]),
    .b(\micr/mcrofs [27]),
    .c(\micr/sub0/c27 ),
    .o({\micr/sub0/c28 ,mcrcnt[27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u28  (
    .a(\micr/mcrcnt [28]),
    .b(\micr/mcrofs [28]),
    .c(\micr/sub0/c28 ),
    .o({\micr/sub0/c29 ,mcrcnt[28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u29  (
    .a(\micr/mcrcnt [29]),
    .b(\micr/mcrofs [29]),
    .c(\micr/sub0/c29 ),
    .o({\micr/sub0/c30 ,mcrcnt[29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u3  (
    .a(\micr/mcrcnt [3]),
    .b(\micr/mcrofs [3]),
    .c(\micr/sub0/c3 ),
    .o({\micr/sub0/c4 ,mcrcnt[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u30  (
    .a(\micr/mcrcnt [30]),
    .b(\micr/mcrofs [30]),
    .c(\micr/sub0/c30 ),
    .o({\micr/sub0/c31 ,mcrcnt[30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u31  (
    .a(\micr/mcrcnt [31]),
    .b(\micr/mcrofs [31]),
    .c(\micr/sub0/c31 ),
    .o({open_n8,mcrcnt[31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u4  (
    .a(\micr/mcrcnt [4]),
    .b(\micr/mcrofs [4]),
    .c(\micr/sub0/c4 ),
    .o({\micr/sub0/c5 ,mcrcnt[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u5  (
    .a(\micr/mcrcnt [5]),
    .b(\micr/mcrofs [5]),
    .c(\micr/sub0/c5 ),
    .o({\micr/sub0/c6 ,mcrcnt[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u6  (
    .a(\micr/mcrcnt [6]),
    .b(\micr/mcrofs [6]),
    .c(\micr/sub0/c6 ),
    .o({\micr/sub0/c7 ,mcrcnt[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u7  (
    .a(\micr/mcrcnt [7]),
    .b(\micr/mcrofs [7]),
    .c(\micr/sub0/c7 ),
    .o({\micr/sub0/c8 ,mcrcnt[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u8  (
    .a(\micr/mcrcnt [8]),
    .b(\micr/mcrofs [8]),
    .c(\micr/sub0/c8 ),
    .o({\micr/sub0/c9 ,mcrcnt[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \micr/sub0/u9  (
    .a(\micr/mcrcnt [9]),
    .b(\micr/mcrofs [9]),
    .c(\micr/sub0/c9 ),
    .o({\micr/sub0/c10 ,mcrcnt[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \micr/sub0/ucin  (
    .a(1'b0),
    .o({\micr/sub0/c0 ,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u0  (
    .a(\mill/prescl [0]),
    .b(1'b1),
    .c(\mill/add0/c0 ),
    .o({\mill/add0/c1 ,\mill/n3 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u1  (
    .a(\mill/prescl [1]),
    .b(1'b0),
    .c(\mill/add0/c1 ),
    .o({\mill/add0/c2 ,\mill/n3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u10  (
    .a(\mill/prescl [10]),
    .b(1'b0),
    .c(\mill/add0/c10 ),
    .o({\mill/add0/c11 ,\mill/n3 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u11  (
    .a(\mill/prescl [11]),
    .b(1'b0),
    .c(\mill/add0/c11 ),
    .o({\mill/add0/c12 ,\mill/n3 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u12  (
    .a(\mill/prescl [12]),
    .b(1'b0),
    .c(\mill/add0/c12 ),
    .o({\mill/add0/c13 ,\mill/n3 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u13  (
    .a(\mill/prescl [13]),
    .b(1'b0),
    .c(\mill/add0/c13 ),
    .o({\mill/add0/c14 ,\mill/n3 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u14  (
    .a(\mill/prescl [14]),
    .b(1'b0),
    .c(\mill/add0/c14 ),
    .o({open_n12,\mill/n3 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u2  (
    .a(\mill/prescl [2]),
    .b(1'b0),
    .c(\mill/add0/c2 ),
    .o({\mill/add0/c3 ,\mill/n3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u3  (
    .a(\mill/prescl [3]),
    .b(1'b0),
    .c(\mill/add0/c3 ),
    .o({\mill/add0/c4 ,\mill/n3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u4  (
    .a(\mill/prescl [4]),
    .b(1'b0),
    .c(\mill/add0/c4 ),
    .o({\mill/add0/c5 ,\mill/n3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u5  (
    .a(\mill/prescl [5]),
    .b(1'b0),
    .c(\mill/add0/c5 ),
    .o({\mill/add0/c6 ,\mill/n3 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u6  (
    .a(\mill/prescl [6]),
    .b(1'b0),
    .c(\mill/add0/c6 ),
    .o({\mill/add0/c7 ,\mill/n3 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u7  (
    .a(\mill/prescl [7]),
    .b(1'b0),
    .c(\mill/add0/c7 ),
    .o({\mill/add0/c8 ,\mill/n3 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u8  (
    .a(\mill/prescl [8]),
    .b(1'b0),
    .c(\mill/add0/c8 ),
    .o({\mill/add0/c9 ,\mill/n3 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add0/u9  (
    .a(\mill/prescl [9]),
    .b(1'b0),
    .c(\mill/add0/c9 ),
    .o({\mill/add0/c10 ,\mill/n3 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \mill/add0/ucin  (
    .a(1'b0),
    .o({\mill/add0/c0 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u0  (
    .a(\mill/milcnt [0]),
    .b(1'b1),
    .c(\mill/add1/c0 ),
    .o({\mill/add1/c1 ,\mill/n7 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u1  (
    .a(\mill/milcnt [1]),
    .b(1'b0),
    .c(\mill/add1/c1 ),
    .o({\mill/add1/c2 ,\mill/n7 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u10  (
    .a(\mill/milcnt [10]),
    .b(1'b0),
    .c(\mill/add1/c10 ),
    .o({\mill/add1/c11 ,\mill/n7 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u11  (
    .a(\mill/milcnt [11]),
    .b(1'b0),
    .c(\mill/add1/c11 ),
    .o({\mill/add1/c12 ,\mill/n7 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u12  (
    .a(\mill/milcnt [12]),
    .b(1'b0),
    .c(\mill/add1/c12 ),
    .o({\mill/add1/c13 ,\mill/n7 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u13  (
    .a(\mill/milcnt [13]),
    .b(1'b0),
    .c(\mill/add1/c13 ),
    .o({\mill/add1/c14 ,\mill/n7 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u14  (
    .a(\mill/milcnt [14]),
    .b(1'b0),
    .c(\mill/add1/c14 ),
    .o({\mill/add1/c15 ,\mill/n7 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u15  (
    .a(\mill/milcnt [15]),
    .b(1'b0),
    .c(\mill/add1/c15 ),
    .o({\mill/add1/c16 ,\mill/n7 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u16  (
    .a(\mill/milcnt [16]),
    .b(1'b0),
    .c(\mill/add1/c16 ),
    .o({\mill/add1/c17 ,\mill/n7 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u17  (
    .a(\mill/milcnt [17]),
    .b(1'b0),
    .c(\mill/add1/c17 ),
    .o({\mill/add1/c18 ,\mill/n7 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u18  (
    .a(\mill/milcnt [18]),
    .b(1'b0),
    .c(\mill/add1/c18 ),
    .o({\mill/add1/c19 ,\mill/n7 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u19  (
    .a(\mill/milcnt [19]),
    .b(1'b0),
    .c(\mill/add1/c19 ),
    .o({\mill/add1/c20 ,\mill/n7 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u2  (
    .a(\mill/milcnt [2]),
    .b(1'b0),
    .c(\mill/add1/c2 ),
    .o({\mill/add1/c3 ,\mill/n7 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u20  (
    .a(\mill/milcnt [20]),
    .b(1'b0),
    .c(\mill/add1/c20 ),
    .o({\mill/add1/c21 ,\mill/n7 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u21  (
    .a(\mill/milcnt [21]),
    .b(1'b0),
    .c(\mill/add1/c21 ),
    .o({\mill/add1/c22 ,\mill/n7 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u22  (
    .a(\mill/milcnt [22]),
    .b(1'b0),
    .c(\mill/add1/c22 ),
    .o({\mill/add1/c23 ,\mill/n7 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u23  (
    .a(\mill/milcnt [23]),
    .b(1'b0),
    .c(\mill/add1/c23 ),
    .o({\mill/add1/c24 ,\mill/n7 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u24  (
    .a(\mill/milcnt [24]),
    .b(1'b0),
    .c(\mill/add1/c24 ),
    .o({\mill/add1/c25 ,\mill/n7 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u25  (
    .a(\mill/milcnt [25]),
    .b(1'b0),
    .c(\mill/add1/c25 ),
    .o({\mill/add1/c26 ,\mill/n7 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u26  (
    .a(\mill/milcnt [26]),
    .b(1'b0),
    .c(\mill/add1/c26 ),
    .o({\mill/add1/c27 ,\mill/n7 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u27  (
    .a(\mill/milcnt [27]),
    .b(1'b0),
    .c(\mill/add1/c27 ),
    .o({\mill/add1/c28 ,\mill/n7 [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u28  (
    .a(\mill/milcnt [28]),
    .b(1'b0),
    .c(\mill/add1/c28 ),
    .o({\mill/add1/c29 ,\mill/n7 [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u29  (
    .a(\mill/milcnt [29]),
    .b(1'b0),
    .c(\mill/add1/c29 ),
    .o({\mill/add1/c30 ,\mill/n7 [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u3  (
    .a(\mill/milcnt [3]),
    .b(1'b0),
    .c(\mill/add1/c3 ),
    .o({\mill/add1/c4 ,\mill/n7 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u30  (
    .a(\mill/milcnt [30]),
    .b(1'b0),
    .c(\mill/add1/c30 ),
    .o({\mill/add1/c31 ,\mill/n7 [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u31  (
    .a(\mill/milcnt [31]),
    .b(1'b0),
    .c(\mill/add1/c31 ),
    .o({open_n16,\mill/n7 [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u4  (
    .a(\mill/milcnt [4]),
    .b(1'b0),
    .c(\mill/add1/c4 ),
    .o({\mill/add1/c5 ,\mill/n7 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u5  (
    .a(\mill/milcnt [5]),
    .b(1'b0),
    .c(\mill/add1/c5 ),
    .o({\mill/add1/c6 ,\mill/n7 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u6  (
    .a(\mill/milcnt [6]),
    .b(1'b0),
    .c(\mill/add1/c6 ),
    .o({\mill/add1/c7 ,\mill/n7 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u7  (
    .a(\mill/milcnt [7]),
    .b(1'b0),
    .c(\mill/add1/c7 ),
    .o({\mill/add1/c8 ,\mill/n7 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u8  (
    .a(\mill/milcnt [8]),
    .b(1'b0),
    .c(\mill/add1/c8 ),
    .o({\mill/add1/c9 ,\mill/n7 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \mill/add1/u9  (
    .a(\mill/milcnt [9]),
    .b(1'b0),
    .c(\mill/add1/c9 ),
    .o({\mill/add1/c10 ,\mill/n7 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \mill/add1/ucin  (
    .a(1'b0),
    .o({\mill/add1/c0 ,open_n19}));
  reg_sr_as_w1 \mill/cnt_up_reg  (
    .clk(clk),
    .d(\mill/n2 ),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/cnt_up ));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg0_b0  (
    .clk(clk),
    .d(\mill/n7 [0]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [0]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b1  (
    .clk(clk),
    .d(\mill/n7 [1]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [1]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b10  (
    .clk(clk),
    .d(\mill/n7 [10]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [10]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b11  (
    .clk(clk),
    .d(\mill/n7 [11]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [11]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b12  (
    .clk(clk),
    .d(\mill/n7 [12]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [12]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b13  (
    .clk(clk),
    .d(\mill/n7 [13]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [13]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b14  (
    .clk(clk),
    .d(\mill/n7 [14]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [14]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b15  (
    .clk(clk),
    .d(\mill/n7 [15]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [15]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b16  (
    .clk(clk),
    .d(\mill/n7 [16]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [16]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b17  (
    .clk(clk),
    .d(\mill/n7 [17]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [17]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b18  (
    .clk(clk),
    .d(\mill/n7 [18]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [18]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b19  (
    .clk(clk),
    .d(\mill/n7 [19]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [19]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b2  (
    .clk(clk),
    .d(\mill/n7 [2]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [2]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b20  (
    .clk(clk),
    .d(\mill/n7 [20]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [20]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b21  (
    .clk(clk),
    .d(\mill/n7 [21]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [21]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b22  (
    .clk(clk),
    .d(\mill/n7 [22]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [22]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b23  (
    .clk(clk),
    .d(\mill/n7 [23]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [23]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b24  (
    .clk(clk),
    .d(\mill/n7 [24]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [24]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b25  (
    .clk(clk),
    .d(\mill/n7 [25]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [25]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b26  (
    .clk(clk),
    .d(\mill/n7 [26]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [26]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b27  (
    .clk(clk),
    .d(\mill/n7 [27]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [27]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b28  (
    .clk(clk),
    .d(\mill/n7 [28]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [28]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b29  (
    .clk(clk),
    .d(\mill/n7 [29]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [29]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b3  (
    .clk(clk),
    .d(\mill/n7 [3]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [3]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b30  (
    .clk(clk),
    .d(\mill/n7 [30]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [30]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b31  (
    .clk(clk),
    .d(\mill/n7 [31]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [31]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b4  (
    .clk(clk),
    .d(\mill/n7 [4]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [4]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b5  (
    .clk(clk),
    .d(\mill/n7 [5]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [5]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b6  (
    .clk(clk),
    .d(\mill/n7 [6]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [6]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b7  (
    .clk(clk),
    .d(\mill/n7 [7]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [7]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b8  (
    .clk(clk),
    .d(\mill/n7 [8]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [8]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg0_b9  (
    .clk(clk),
    .d(\mill/n7 [9]),
    .en(\mill/cnt_up ),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\mill/milcnt [9]));  // rtl/systim.v(411)
  reg_sr_as_w1 \mill/reg1_b0  (
    .clk(clk),
    .d(\mill/milcnt [0]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [0]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b1  (
    .clk(clk),
    .d(\mill/milcnt [1]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [1]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b10  (
    .clk(clk),
    .d(\mill/milcnt [10]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [10]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b11  (
    .clk(clk),
    .d(\mill/milcnt [11]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [11]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b12  (
    .clk(clk),
    .d(\mill/milcnt [12]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [12]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b13  (
    .clk(clk),
    .d(\mill/milcnt [13]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [13]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b14  (
    .clk(clk),
    .d(\mill/milcnt [14]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [14]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b15  (
    .clk(clk),
    .d(\mill/milcnt [15]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [15]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b16  (
    .clk(clk),
    .d(\mill/milcnt [16]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [16]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b17  (
    .clk(clk),
    .d(\mill/milcnt [17]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [17]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b18  (
    .clk(clk),
    .d(\mill/milcnt [18]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [18]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b19  (
    .clk(clk),
    .d(\mill/milcnt [19]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [19]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b2  (
    .clk(clk),
    .d(\mill/milcnt [2]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [2]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b20  (
    .clk(clk),
    .d(\mill/milcnt [20]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [20]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b21  (
    .clk(clk),
    .d(\mill/milcnt [21]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [21]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b22  (
    .clk(clk),
    .d(\mill/milcnt [22]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [22]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b23  (
    .clk(clk),
    .d(\mill/milcnt [23]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [23]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b24  (
    .clk(clk),
    .d(\mill/milcnt [24]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [24]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b25  (
    .clk(clk),
    .d(\mill/milcnt [25]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [25]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b26  (
    .clk(clk),
    .d(\mill/milcnt [26]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [26]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b27  (
    .clk(clk),
    .d(\mill/milcnt [27]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [27]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b28  (
    .clk(clk),
    .d(\mill/milcnt [28]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [28]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b29  (
    .clk(clk),
    .d(\mill/milcnt [29]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [29]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b3  (
    .clk(clk),
    .d(\mill/milcnt [3]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [3]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b30  (
    .clk(clk),
    .d(\mill/milcnt [30]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [30]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b31  (
    .clk(clk),
    .d(\mill/milcnt [31]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [31]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b4  (
    .clk(clk),
    .d(\mill/milcnt [4]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [4]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b5  (
    .clk(clk),
    .d(\mill/milcnt [5]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [5]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b6  (
    .clk(clk),
    .d(\mill/milcnt [6]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [6]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b7  (
    .clk(clk),
    .d(\mill/milcnt [7]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [7]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b8  (
    .clk(clk),
    .d(\mill/milcnt [8]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [8]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg1_b9  (
    .clk(clk),
    .d(\mill/milcnt [9]),
    .en(tctl_mil_ofst),
    .reset(\mill/n11 ),
    .set(1'b0),
    .q(\mill/milofs [9]));  // rtl/systim.v(421)
  reg_sr_as_w1 \mill/reg2_b0  (
    .clk(clk),
    .d(\mill/n3 [0]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [0]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b1  (
    .clk(clk),
    .d(\mill/n3 [1]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [1]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b10  (
    .clk(clk),
    .d(\mill/n3 [10]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [10]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b11  (
    .clk(clk),
    .d(\mill/n3 [11]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [11]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b12  (
    .clk(clk),
    .d(\mill/n3 [12]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [12]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b13  (
    .clk(clk),
    .d(\mill/n3 [13]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [13]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b14  (
    .clk(clk),
    .d(\mill/n3 [14]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [14]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b2  (
    .clk(clk),
    .d(\mill/n3 [2]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [2]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b3  (
    .clk(clk),
    .d(\mill/n3 [3]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [3]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b4  (
    .clk(clk),
    .d(\mill/n3 [4]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [4]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b5  (
    .clk(clk),
    .d(\mill/n3 [5]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [5]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b6  (
    .clk(clk),
    .d(\mill/n3 [6]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [6]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b7  (
    .clk(clk),
    .d(\mill/n3 [7]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [7]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b8  (
    .clk(clk),
    .d(\mill/n3 [8]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [8]));  // rtl/systim.v(402)
  reg_sr_as_w1 \mill/reg2_b9  (
    .clk(clk),
    .d(\mill/n3 [9]),
    .en(1'b1),
    .reset(~\mill/mux1_b0_sel_is_0_o ),
    .set(1'b0),
    .q(\mill/prescl [9]));  // rtl/systim.v(402)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u0  (
    .a(\mill/milcnt [0]),
    .b(\mill/milofs [0]),
    .c(\mill/sub0/c0 ),
    .o({\mill/sub0/c1 ,milcnt[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u1  (
    .a(\mill/milcnt [1]),
    .b(\mill/milofs [1]),
    .c(\mill/sub0/c1 ),
    .o({\mill/sub0/c2 ,milcnt[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u10  (
    .a(\mill/milcnt [10]),
    .b(\mill/milofs [10]),
    .c(\mill/sub0/c10 ),
    .o({\mill/sub0/c11 ,milcnt[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u11  (
    .a(\mill/milcnt [11]),
    .b(\mill/milofs [11]),
    .c(\mill/sub0/c11 ),
    .o({\mill/sub0/c12 ,milcnt[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u12  (
    .a(\mill/milcnt [12]),
    .b(\mill/milofs [12]),
    .c(\mill/sub0/c12 ),
    .o({\mill/sub0/c13 ,milcnt[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u13  (
    .a(\mill/milcnt [13]),
    .b(\mill/milofs [13]),
    .c(\mill/sub0/c13 ),
    .o({\mill/sub0/c14 ,milcnt[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u14  (
    .a(\mill/milcnt [14]),
    .b(\mill/milofs [14]),
    .c(\mill/sub0/c14 ),
    .o({\mill/sub0/c15 ,milcnt[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u15  (
    .a(\mill/milcnt [15]),
    .b(\mill/milofs [15]),
    .c(\mill/sub0/c15 ),
    .o({\mill/sub0/c16 ,milcnt[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u16  (
    .a(\mill/milcnt [16]),
    .b(\mill/milofs [16]),
    .c(\mill/sub0/c16 ),
    .o({\mill/sub0/c17 ,milcnt[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u17  (
    .a(\mill/milcnt [17]),
    .b(\mill/milofs [17]),
    .c(\mill/sub0/c17 ),
    .o({\mill/sub0/c18 ,milcnt[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u18  (
    .a(\mill/milcnt [18]),
    .b(\mill/milofs [18]),
    .c(\mill/sub0/c18 ),
    .o({\mill/sub0/c19 ,milcnt[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u19  (
    .a(\mill/milcnt [19]),
    .b(\mill/milofs [19]),
    .c(\mill/sub0/c19 ),
    .o({\mill/sub0/c20 ,milcnt[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u2  (
    .a(\mill/milcnt [2]),
    .b(\mill/milofs [2]),
    .c(\mill/sub0/c2 ),
    .o({\mill/sub0/c3 ,milcnt[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u20  (
    .a(\mill/milcnt [20]),
    .b(\mill/milofs [20]),
    .c(\mill/sub0/c20 ),
    .o({\mill/sub0/c21 ,milcnt[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u21  (
    .a(\mill/milcnt [21]),
    .b(\mill/milofs [21]),
    .c(\mill/sub0/c21 ),
    .o({\mill/sub0/c22 ,milcnt[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u22  (
    .a(\mill/milcnt [22]),
    .b(\mill/milofs [22]),
    .c(\mill/sub0/c22 ),
    .o({\mill/sub0/c23 ,milcnt[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u23  (
    .a(\mill/milcnt [23]),
    .b(\mill/milofs [23]),
    .c(\mill/sub0/c23 ),
    .o({\mill/sub0/c24 ,milcnt[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u24  (
    .a(\mill/milcnt [24]),
    .b(\mill/milofs [24]),
    .c(\mill/sub0/c24 ),
    .o({\mill/sub0/c25 ,milcnt[24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u25  (
    .a(\mill/milcnt [25]),
    .b(\mill/milofs [25]),
    .c(\mill/sub0/c25 ),
    .o({\mill/sub0/c26 ,milcnt[25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u26  (
    .a(\mill/milcnt [26]),
    .b(\mill/milofs [26]),
    .c(\mill/sub0/c26 ),
    .o({\mill/sub0/c27 ,milcnt[26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u27  (
    .a(\mill/milcnt [27]),
    .b(\mill/milofs [27]),
    .c(\mill/sub0/c27 ),
    .o({\mill/sub0/c28 ,milcnt[27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u28  (
    .a(\mill/milcnt [28]),
    .b(\mill/milofs [28]),
    .c(\mill/sub0/c28 ),
    .o({\mill/sub0/c29 ,milcnt[28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u29  (
    .a(\mill/milcnt [29]),
    .b(\mill/milofs [29]),
    .c(\mill/sub0/c29 ),
    .o({\mill/sub0/c30 ,milcnt[29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u3  (
    .a(\mill/milcnt [3]),
    .b(\mill/milofs [3]),
    .c(\mill/sub0/c3 ),
    .o({\mill/sub0/c4 ,milcnt[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u30  (
    .a(\mill/milcnt [30]),
    .b(\mill/milofs [30]),
    .c(\mill/sub0/c30 ),
    .o({\mill/sub0/c31 ,milcnt[30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u31  (
    .a(\mill/milcnt [31]),
    .b(\mill/milofs [31]),
    .c(\mill/sub0/c31 ),
    .o({open_n20,milcnt[31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u4  (
    .a(\mill/milcnt [4]),
    .b(\mill/milofs [4]),
    .c(\mill/sub0/c4 ),
    .o({\mill/sub0/c5 ,milcnt[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u5  (
    .a(\mill/milcnt [5]),
    .b(\mill/milofs [5]),
    .c(\mill/sub0/c5 ),
    .o({\mill/sub0/c6 ,milcnt[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u6  (
    .a(\mill/milcnt [6]),
    .b(\mill/milofs [6]),
    .c(\mill/sub0/c6 ),
    .o({\mill/sub0/c7 ,milcnt[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u7  (
    .a(\mill/milcnt [7]),
    .b(\mill/milofs [7]),
    .c(\mill/sub0/c7 ),
    .o({\mill/sub0/c8 ,milcnt[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u8  (
    .a(\mill/milcnt [8]),
    .b(\mill/milofs [8]),
    .c(\mill/sub0/c8 ),
    .o({\mill/sub0/c9 ,milcnt[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \mill/sub0/u9  (
    .a(\mill/milcnt [9]),
    .b(\mill/milofs [9]),
    .c(\mill/sub0/c9 ),
    .o({\mill/sub0/c10 ,milcnt[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \mill/sub0/ucin  (
    .a(1'b0),
    .o({\mill/sub0/c0 ,open_n23}));
  reg_sr_as_w1 \rctl/mcrcnth_rd_reg  (
    .clk(clk),
    .d(\rctl/n8 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/mcrcnth_rd ));  // rtl/systim.v(166)
  reg_sr_as_w1 \rctl/mcrcntl_rd_reg  (
    .clk(clk),
    .d(\rctl/n14 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/mcrcntl_rd ));  // rtl/systim.v(166)
  reg_sr_as_w1 \rctl/milcnth_rd_reg  (
    .clk(clk),
    .d(\rctl/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/milcnth_rd ));  // rtl/systim.v(166)
  reg_sr_as_w1 \rctl/milcntl_rd_reg  (
    .clk(clk),
    .d(\rctl/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/milcntl_rd ));  // rtl/systim.v(166)
  reg_sr_as_w1 \rctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(1'b1),
    .reset(~\rctl/mux1_b0_sel_is_2_o ),
    .set(1'b0),
    .q(tctl_rst_all));  // rtl/systim.v(196)
  reg_sr_as_w1 \rctl/reg0_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\rctl/n33 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(tctl_mil_ofse));  // rtl/systim.v(196)
  reg_sr_as_w1 \rctl/reg0_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\rctl/n33 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(tctl_mcr_ofse));  // rtl/systim.v(196)
  reg_sr_as_w1 \rctl/reg0_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(\rctl/n33 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(tctl_tck_ofse));  // rtl/systim.v(196)
  reg_sr_as_w1 \rctl/reg1_b0  (
    .clk(clk),
    .d(\rctl/n57 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [0]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b1  (
    .clk(clk),
    .d(\rctl/n57 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [1]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b10  (
    .clk(clk),
    .d(\rctl/n57 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [10]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b11  (
    .clk(clk),
    .d(\rctl/n57 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [11]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b12  (
    .clk(clk),
    .d(\rctl/n57 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [12]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b13  (
    .clk(clk),
    .d(\rctl/n57 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [13]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b14  (
    .clk(clk),
    .d(\rctl/n57 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [14]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b15  (
    .clk(clk),
    .d(\rctl/n57 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [15]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b2  (
    .clk(clk),
    .d(\rctl/n57 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [2]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b3  (
    .clk(clk),
    .d(\rctl/n57 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [3]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b4  (
    .clk(clk),
    .d(\rctl/n57 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [4]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b5  (
    .clk(clk),
    .d(\rctl/n57 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [5]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b6  (
    .clk(clk),
    .d(\rctl/n57 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [6]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b7  (
    .clk(clk),
    .d(\rctl/n57 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [7]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b8  (
    .clk(clk),
    .d(\rctl/n57 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [8]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/reg1_b9  (
    .clk(clk),
    .d(\rctl/n57 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmpcnt [9]));  // rtl/systim.v(232)
  reg_sr_as_w1 \rctl/sytmctl_rd_reg  (
    .clk(clk),
    .d(\rctl/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/sytmctl_rd ));  // rtl/systim.v(166)
  reg_sr_as_w1 \rctl/tckcnth_rd_reg  (
    .clk(clk),
    .d(\rctl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tckcnth_rd ));  // rtl/systim.v(166)
  reg_sr_as_w1 \rctl/tckcntl_rd_reg  (
    .clk(clk),
    .d(\rctl/n12 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tckcntl_rd ));  // rtl/systim.v(166)
  reg_sr_as_w1 \rctl/tctl_mcr_ofst_reg  (
    .clk(clk),
    .d(\rctl/n37 ),
    .en(1'b1),
    .reset(~\rctl/mux1_b0_sel_is_2_o ),
    .set(1'b0),
    .q(tctl_mcr_ofst));  // rtl/systim.v(196)
  reg_sr_as_w1 \rctl/tctl_mil_ofst_reg  (
    .clk(clk),
    .d(\rctl/n39 ),
    .en(1'b1),
    .reset(~\rctl/mux1_b0_sel_is_2_o ),
    .set(1'b0),
    .q(tctl_mil_ofst));  // rtl/systim.v(196)
  reg_sr_as_w1 \rctl/tctl_tck_ofst_reg  (
    .clk(clk),
    .d(\rctl/n35 ),
    .en(1'b1),
    .reset(~\rctl/mux1_b0_sel_is_2_o ),
    .set(1'b0),
    .q(tctl_tck_ofst));  // rtl/systim.v(196)
  reg_sr_as_w1 \rctl/tmp_enb_reg  (
    .clk(clk),
    .d(\rctl/u51_sel_is_2_o_neg ),
    .en(\micr/_al_n0_en ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/tmp_enb ));  // rtl/systim.v(232)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u0  (
    .a(\tick/tckcnt [0]),
    .b(1'b1),
    .c(\tick/add0/c0 ),
    .o({\tick/add0/c1 ,\tick/n2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u1  (
    .a(\tick/tckcnt [1]),
    .b(1'b0),
    .c(\tick/add0/c1 ),
    .o({\tick/add0/c2 ,\tick/n2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u10  (
    .a(\tick/tckcnt [10]),
    .b(1'b0),
    .c(\tick/add0/c10 ),
    .o({\tick/add0/c11 ,\tick/n2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u11  (
    .a(\tick/tckcnt [11]),
    .b(1'b0),
    .c(\tick/add0/c11 ),
    .o({\tick/add0/c12 ,\tick/n2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u12  (
    .a(\tick/tckcnt [12]),
    .b(1'b0),
    .c(\tick/add0/c12 ),
    .o({\tick/add0/c13 ,\tick/n2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u13  (
    .a(\tick/tckcnt [13]),
    .b(1'b0),
    .c(\tick/add0/c13 ),
    .o({\tick/add0/c14 ,\tick/n2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u14  (
    .a(\tick/tckcnt [14]),
    .b(1'b0),
    .c(\tick/add0/c14 ),
    .o({\tick/add0/c15 ,\tick/n2 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u15  (
    .a(\tick/tckcnt [15]),
    .b(1'b0),
    .c(\tick/add0/c15 ),
    .o({\tick/add0/c16 ,\tick/n2 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u16  (
    .a(\tick/tckcnt [16]),
    .b(1'b0),
    .c(\tick/add0/c16 ),
    .o({\tick/add0/c17 ,\tick/n2 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u17  (
    .a(\tick/tckcnt [17]),
    .b(1'b0),
    .c(\tick/add0/c17 ),
    .o({\tick/add0/c18 ,\tick/n2 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u18  (
    .a(\tick/tckcnt [18]),
    .b(1'b0),
    .c(\tick/add0/c18 ),
    .o({\tick/add0/c19 ,\tick/n2 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u19  (
    .a(\tick/tckcnt [19]),
    .b(1'b0),
    .c(\tick/add0/c19 ),
    .o({\tick/add0/c20 ,\tick/n2 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u2  (
    .a(\tick/tckcnt [2]),
    .b(1'b0),
    .c(\tick/add0/c2 ),
    .o({\tick/add0/c3 ,\tick/n2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u20  (
    .a(\tick/tckcnt [20]),
    .b(1'b0),
    .c(\tick/add0/c20 ),
    .o({\tick/add0/c21 ,\tick/n2 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u21  (
    .a(\tick/tckcnt [21]),
    .b(1'b0),
    .c(\tick/add0/c21 ),
    .o({\tick/add0/c22 ,\tick/n2 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u22  (
    .a(\tick/tckcnt [22]),
    .b(1'b0),
    .c(\tick/add0/c22 ),
    .o({\tick/add0/c23 ,\tick/n2 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u23  (
    .a(\tick/tckcnt [23]),
    .b(1'b0),
    .c(\tick/add0/c23 ),
    .o({\tick/add0/c24 ,\tick/n2 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u24  (
    .a(\tick/tckcnt [24]),
    .b(1'b0),
    .c(\tick/add0/c24 ),
    .o({\tick/add0/c25 ,\tick/n2 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u25  (
    .a(\tick/tckcnt [25]),
    .b(1'b0),
    .c(\tick/add0/c25 ),
    .o({\tick/add0/c26 ,\tick/n2 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u26  (
    .a(\tick/tckcnt [26]),
    .b(1'b0),
    .c(\tick/add0/c26 ),
    .o({\tick/add0/c27 ,\tick/n2 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u27  (
    .a(\tick/tckcnt [27]),
    .b(1'b0),
    .c(\tick/add0/c27 ),
    .o({\tick/add0/c28 ,\tick/n2 [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u28  (
    .a(\tick/tckcnt [28]),
    .b(1'b0),
    .c(\tick/add0/c28 ),
    .o({\tick/add0/c29 ,\tick/n2 [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u29  (
    .a(\tick/tckcnt [29]),
    .b(1'b0),
    .c(\tick/add0/c29 ),
    .o({\tick/add0/c30 ,\tick/n2 [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u3  (
    .a(\tick/tckcnt [3]),
    .b(1'b0),
    .c(\tick/add0/c3 ),
    .o({\tick/add0/c4 ,\tick/n2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u30  (
    .a(\tick/tckcnt [30]),
    .b(1'b0),
    .c(\tick/add0/c30 ),
    .o({\tick/add0/c31 ,\tick/n2 [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u31  (
    .a(\tick/tckcnt [31]),
    .b(1'b0),
    .c(\tick/add0/c31 ),
    .o({open_n24,\tick/n2 [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u4  (
    .a(\tick/tckcnt [4]),
    .b(1'b0),
    .c(\tick/add0/c4 ),
    .o({\tick/add0/c5 ,\tick/n2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u5  (
    .a(\tick/tckcnt [5]),
    .b(1'b0),
    .c(\tick/add0/c5 ),
    .o({\tick/add0/c6 ,\tick/n2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u6  (
    .a(\tick/tckcnt [6]),
    .b(1'b0),
    .c(\tick/add0/c6 ),
    .o({\tick/add0/c7 ,\tick/n2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u7  (
    .a(\tick/tckcnt [7]),
    .b(1'b0),
    .c(\tick/add0/c7 ),
    .o({\tick/add0/c8 ,\tick/n2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u8  (
    .a(\tick/tckcnt [8]),
    .b(1'b0),
    .c(\tick/add0/c8 ),
    .o({\tick/add0/c9 ,\tick/n2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \tick/add0/u9  (
    .a(\tick/tckcnt [9]),
    .b(1'b0),
    .c(\tick/add0/c9 ),
    .o({\tick/add0/c10 ,\tick/n2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \tick/add0/ucin  (
    .a(1'b0),
    .o({\tick/add0/c0 ,open_n27}));
  reg_sr_as_w1 \tick/reg0_b0  (
    .clk(clk),
    .d(\tick/tckcnt [0]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [0]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b1  (
    .clk(clk),
    .d(\tick/tckcnt [1]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [1]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b10  (
    .clk(clk),
    .d(\tick/tckcnt [10]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [10]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b11  (
    .clk(clk),
    .d(\tick/tckcnt [11]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [11]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b12  (
    .clk(clk),
    .d(\tick/tckcnt [12]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [12]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b13  (
    .clk(clk),
    .d(\tick/tckcnt [13]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [13]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b14  (
    .clk(clk),
    .d(\tick/tckcnt [14]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [14]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b15  (
    .clk(clk),
    .d(\tick/tckcnt [15]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [15]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b16  (
    .clk(clk),
    .d(\tick/tckcnt [16]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [16]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b17  (
    .clk(clk),
    .d(\tick/tckcnt [17]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [17]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b18  (
    .clk(clk),
    .d(\tick/tckcnt [18]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [18]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b19  (
    .clk(clk),
    .d(\tick/tckcnt [19]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [19]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b2  (
    .clk(clk),
    .d(\tick/tckcnt [2]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [2]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b20  (
    .clk(clk),
    .d(\tick/tckcnt [20]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [20]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b21  (
    .clk(clk),
    .d(\tick/tckcnt [21]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [21]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b22  (
    .clk(clk),
    .d(\tick/tckcnt [22]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [22]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b23  (
    .clk(clk),
    .d(\tick/tckcnt [23]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [23]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b24  (
    .clk(clk),
    .d(\tick/tckcnt [24]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [24]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b25  (
    .clk(clk),
    .d(\tick/tckcnt [25]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [25]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b26  (
    .clk(clk),
    .d(\tick/tckcnt [26]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [26]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b27  (
    .clk(clk),
    .d(\tick/tckcnt [27]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [27]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b28  (
    .clk(clk),
    .d(\tick/tckcnt [28]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [28]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b29  (
    .clk(clk),
    .d(\tick/tckcnt [29]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [29]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b3  (
    .clk(clk),
    .d(\tick/tckcnt [3]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [3]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b30  (
    .clk(clk),
    .d(\tick/tckcnt [30]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [30]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b31  (
    .clk(clk),
    .d(\tick/tckcnt [31]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [31]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b4  (
    .clk(clk),
    .d(\tick/tckcnt [4]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [4]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b5  (
    .clk(clk),
    .d(\tick/tckcnt [5]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [5]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b6  (
    .clk(clk),
    .d(\tick/tckcnt [6]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [6]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b7  (
    .clk(clk),
    .d(\tick/tckcnt [7]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [7]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b8  (
    .clk(clk),
    .d(\tick/tckcnt [8]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [8]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg0_b9  (
    .clk(clk),
    .d(\tick/tckcnt [9]),
    .en(tctl_tck_ofst),
    .reset(\tick/n5 ),
    .set(1'b0),
    .q(\tick/tckofs [9]));  // rtl/systim.v(285)
  reg_sr_as_w1 \tick/reg1_b0  (
    .clk(clk),
    .d(\tick/n2 [0]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [0]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b1  (
    .clk(clk),
    .d(\tick/n2 [1]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [1]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b10  (
    .clk(clk),
    .d(\tick/n2 [10]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [10]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b11  (
    .clk(clk),
    .d(\tick/n2 [11]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [11]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b12  (
    .clk(clk),
    .d(\tick/n2 [12]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [12]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b13  (
    .clk(clk),
    .d(\tick/n2 [13]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [13]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b14  (
    .clk(clk),
    .d(\tick/n2 [14]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [14]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b15  (
    .clk(clk),
    .d(\tick/n2 [15]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [15]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b16  (
    .clk(clk),
    .d(\tick/n2 [16]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [16]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b17  (
    .clk(clk),
    .d(\tick/n2 [17]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [17]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b18  (
    .clk(clk),
    .d(\tick/n2 [18]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [18]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b19  (
    .clk(clk),
    .d(\tick/n2 [19]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [19]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b2  (
    .clk(clk),
    .d(\tick/n2 [2]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [2]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b20  (
    .clk(clk),
    .d(\tick/n2 [20]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [20]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b21  (
    .clk(clk),
    .d(\tick/n2 [21]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [21]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b22  (
    .clk(clk),
    .d(\tick/n2 [22]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [22]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b23  (
    .clk(clk),
    .d(\tick/n2 [23]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [23]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b24  (
    .clk(clk),
    .d(\tick/n2 [24]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [24]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b25  (
    .clk(clk),
    .d(\tick/n2 [25]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [25]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b26  (
    .clk(clk),
    .d(\tick/n2 [26]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [26]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b27  (
    .clk(clk),
    .d(\tick/n2 [27]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [27]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b28  (
    .clk(clk),
    .d(\tick/n2 [28]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [28]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b29  (
    .clk(clk),
    .d(\tick/n2 [29]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [29]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b3  (
    .clk(clk),
    .d(\tick/n2 [3]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [3]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b30  (
    .clk(clk),
    .d(\tick/n2 [30]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [30]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b31  (
    .clk(clk),
    .d(\tick/n2 [31]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [31]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b4  (
    .clk(clk),
    .d(\tick/n2 [4]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [4]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b5  (
    .clk(clk),
    .d(\tick/n2 [5]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [5]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b6  (
    .clk(clk),
    .d(\tick/n2 [6]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [6]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b7  (
    .clk(clk),
    .d(\tick/n2 [7]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [7]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b8  (
    .clk(clk),
    .d(\tick/n2 [8]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [8]));  // rtl/systim.v(275)
  reg_sr_as_w1 \tick/reg1_b9  (
    .clk(clk),
    .d(\tick/n2 [9]),
    .en(1'b1),
    .reset(\micr/n1 ),
    .set(1'b0),
    .q(\tick/tckcnt [9]));  // rtl/systim.v(275)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u0  (
    .a(\tick/tckcnt [0]),
    .b(\tick/tckofs [0]),
    .c(\tick/sub0/c0 ),
    .o({\tick/sub0/c1 ,tckcnt[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u1  (
    .a(\tick/tckcnt [1]),
    .b(\tick/tckofs [1]),
    .c(\tick/sub0/c1 ),
    .o({\tick/sub0/c2 ,tckcnt[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u10  (
    .a(\tick/tckcnt [10]),
    .b(\tick/tckofs [10]),
    .c(\tick/sub0/c10 ),
    .o({\tick/sub0/c11 ,tckcnt[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u11  (
    .a(\tick/tckcnt [11]),
    .b(\tick/tckofs [11]),
    .c(\tick/sub0/c11 ),
    .o({\tick/sub0/c12 ,tckcnt[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u12  (
    .a(\tick/tckcnt [12]),
    .b(\tick/tckofs [12]),
    .c(\tick/sub0/c12 ),
    .o({\tick/sub0/c13 ,tckcnt[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u13  (
    .a(\tick/tckcnt [13]),
    .b(\tick/tckofs [13]),
    .c(\tick/sub0/c13 ),
    .o({\tick/sub0/c14 ,tckcnt[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u14  (
    .a(\tick/tckcnt [14]),
    .b(\tick/tckofs [14]),
    .c(\tick/sub0/c14 ),
    .o({\tick/sub0/c15 ,tckcnt[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u15  (
    .a(\tick/tckcnt [15]),
    .b(\tick/tckofs [15]),
    .c(\tick/sub0/c15 ),
    .o({\tick/sub0/c16 ,tckcnt[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u16  (
    .a(\tick/tckcnt [16]),
    .b(\tick/tckofs [16]),
    .c(\tick/sub0/c16 ),
    .o({\tick/sub0/c17 ,tckcnt[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u17  (
    .a(\tick/tckcnt [17]),
    .b(\tick/tckofs [17]),
    .c(\tick/sub0/c17 ),
    .o({\tick/sub0/c18 ,tckcnt[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u18  (
    .a(\tick/tckcnt [18]),
    .b(\tick/tckofs [18]),
    .c(\tick/sub0/c18 ),
    .o({\tick/sub0/c19 ,tckcnt[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u19  (
    .a(\tick/tckcnt [19]),
    .b(\tick/tckofs [19]),
    .c(\tick/sub0/c19 ),
    .o({\tick/sub0/c20 ,tckcnt[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u2  (
    .a(\tick/tckcnt [2]),
    .b(\tick/tckofs [2]),
    .c(\tick/sub0/c2 ),
    .o({\tick/sub0/c3 ,tckcnt[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u20  (
    .a(\tick/tckcnt [20]),
    .b(\tick/tckofs [20]),
    .c(\tick/sub0/c20 ),
    .o({\tick/sub0/c21 ,tckcnt[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u21  (
    .a(\tick/tckcnt [21]),
    .b(\tick/tckofs [21]),
    .c(\tick/sub0/c21 ),
    .o({\tick/sub0/c22 ,tckcnt[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u22  (
    .a(\tick/tckcnt [22]),
    .b(\tick/tckofs [22]),
    .c(\tick/sub0/c22 ),
    .o({\tick/sub0/c23 ,tckcnt[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u23  (
    .a(\tick/tckcnt [23]),
    .b(\tick/tckofs [23]),
    .c(\tick/sub0/c23 ),
    .o({\tick/sub0/c24 ,tckcnt[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u24  (
    .a(\tick/tckcnt [24]),
    .b(\tick/tckofs [24]),
    .c(\tick/sub0/c24 ),
    .o({\tick/sub0/c25 ,tckcnt[24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u25  (
    .a(\tick/tckcnt [25]),
    .b(\tick/tckofs [25]),
    .c(\tick/sub0/c25 ),
    .o({\tick/sub0/c26 ,tckcnt[25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u26  (
    .a(\tick/tckcnt [26]),
    .b(\tick/tckofs [26]),
    .c(\tick/sub0/c26 ),
    .o({\tick/sub0/c27 ,tckcnt[26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u27  (
    .a(\tick/tckcnt [27]),
    .b(\tick/tckofs [27]),
    .c(\tick/sub0/c27 ),
    .o({\tick/sub0/c28 ,tckcnt[27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u28  (
    .a(\tick/tckcnt [28]),
    .b(\tick/tckofs [28]),
    .c(\tick/sub0/c28 ),
    .o({\tick/sub0/c29 ,tckcnt[28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u29  (
    .a(\tick/tckcnt [29]),
    .b(\tick/tckofs [29]),
    .c(\tick/sub0/c29 ),
    .o({\tick/sub0/c30 ,tckcnt[29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u3  (
    .a(\tick/tckcnt [3]),
    .b(\tick/tckofs [3]),
    .c(\tick/sub0/c3 ),
    .o({\tick/sub0/c4 ,tckcnt[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u30  (
    .a(\tick/tckcnt [30]),
    .b(\tick/tckofs [30]),
    .c(\tick/sub0/c30 ),
    .o({\tick/sub0/c31 ,tckcnt[30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u31  (
    .a(\tick/tckcnt [31]),
    .b(\tick/tckofs [31]),
    .c(\tick/sub0/c31 ),
    .o({open_n28,tckcnt[31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u4  (
    .a(\tick/tckcnt [4]),
    .b(\tick/tckofs [4]),
    .c(\tick/sub0/c4 ),
    .o({\tick/sub0/c5 ,tckcnt[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u5  (
    .a(\tick/tckcnt [5]),
    .b(\tick/tckofs [5]),
    .c(\tick/sub0/c5 ),
    .o({\tick/sub0/c6 ,tckcnt[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u6  (
    .a(\tick/tckcnt [6]),
    .b(\tick/tckofs [6]),
    .c(\tick/sub0/c6 ),
    .o({\tick/sub0/c7 ,tckcnt[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u7  (
    .a(\tick/tckcnt [7]),
    .b(\tick/tckofs [7]),
    .c(\tick/sub0/c7 ),
    .o({\tick/sub0/c8 ,tckcnt[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u8  (
    .a(\tick/tckcnt [8]),
    .b(\tick/tckofs [8]),
    .c(\tick/sub0/c8 ),
    .o({\tick/sub0/c9 ,tckcnt[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \tick/sub0/u9  (
    .a(\tick/tckcnt [9]),
    .b(\tick/tckofs [9]),
    .c(\tick/sub0/c9 ),
    .o({\tick/sub0/c10 ,tckcnt[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \tick/sub0/ucin  (
    .a(1'b0),
    .o({\tick/sub0/c0 ,open_n31}));

endmodule 

