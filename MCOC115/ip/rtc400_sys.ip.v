
`timescale 1ns / 1ps
module rtc400_sys  // rtl/rtc400_sys.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_rtcu_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  rsub_reg,
  rsub_wrt_ack,
  rtc_clkin,
  bdatr,
  clk32k,
  rctl_wrt_req,
  rsys_reg,
  rtc_rtcr
  );
//
//	Real Time Clock Unit (system clock domain)
//		(c) 2022	1YEN Toru
//
//
//	2022/10/08	ver.1.00
//

  input [3:0] badr;  // rtl/rtc400_sys.v(28)
  input bcmdr;  // rtl/rtc400_sys.v(24)
  input bcmdw;  // rtl/rtc400_sys.v(23)
  input bcs_rtcu_n;  // rtl/rtc400_sys.v(25)
  input [15:0] bdatw;  // rtl/rtc400_sys.v(29)
  input brdy;  // rtl/rtc400_sys.v(22)
  input clk;  // rtl/rtc400_sys.v(20)
  input rst_n;  // rtl/rtc400_sys.v(21)
  input [79:0] rsub_reg;  // rtl/rtc400_sys.v(30)
  input rsub_wrt_ack;  // rtl/rtc400_sys.v(27)
  input rtc_clkin;  // rtl/rtc400_sys.v(26)
  output [15:0] bdatr;  // rtl/rtc400_sys.v(34)
  output clk32k;  // rtl/rtc400_sys.v(31)
  output rctl_wrt_req;  // rtl/rtc400_sys.v(33)
  output [79:0] rsys_reg;  // rtl/rtc400_sys.v(35)
  output rtc_rtcr;  // rtl/rtc400_sys.v(32)

  wire [9:0] \rckg/n11 ;
  wire [6:0] \rckg/n13 ;
  wire [6:0] \rckg/n14 ;
  wire [6:0] \rckg/n15 ;
  wire [10:0] \rckg/n2 ;
  wire [2:0] \rckg/rckg_clk32k_s ;  // rtl/rtc400_sys.v(512)
  wire [2:0] \rckg/rckg_clkin_s ;  // rtl/rtc400_sys.v(416)
  wire [10:0] \rckg/rckg_cnt ;  // rtl/rtc400_sys.v(424)
  wire [6:0] \rckg/rckg_err ;  // rtl/rtc400_sys.v(461)
  wire [9:0] \rckg/rckg_pscl ;  // rtl/rtc400_sys.v(462)
  wire [2:0] \rctl/n34 ;
  wire [7:0] \rctl/n35 ;
  wire [7:0] \rctl/n43 ;
  wire [15:0] \rctl/n48 ;
  wire [15:0] \rctl/n50 ;
  wire [2:0] \rctl/rfsm/stat ;  // rtl/rtc_sys_fsm.v(35)
  wire [2:0] \rctl/rsub_wrt_ack_s ;  // rtl/rtc400_sys.v(170)
  wire [7:0] \rctl/rtcctl ;  // rtl/rtc400_sys.v(233)
  wire [7:0] \rctl/rtcintc ;  // rtl/rtc400_sys.v(250)
  wire [15:0] \rdup/n20 ;
  wire [15:0] \rdup/n21 ;
  wire [15:0] \rdup/n22 ;
  wire [15:0] \rdup/n23 ;
  wire [15:0] \rdup/n24 ;
  wire _al_u100_o;
  wire _al_u101_o;
  wire _al_u104_o;
  wire _al_u110_o;
  wire _al_u112_o;
  wire _al_u114_o;
  wire _al_u116_o;
  wire _al_u126_o;
  wire _al_u127_o;
  wire _al_u130_o;
  wire _al_u132_o;
  wire _al_u134_o;
  wire _al_u135_o;
  wire _al_u137_o;
  wire _al_u138_o;
  wire _al_u140_o;
  wire _al_u141_o;
  wire _al_u146_o;
  wire _al_u147_o;
  wire _al_u149_o;
  wire _al_u150_o;
  wire _al_u152_o;
  wire _al_u153_o;
  wire _al_u160_o;
  wire _al_u165_o;
  wire _al_u169_o;
  wire _al_u173_o;
  wire _al_u174_o;
  wire _al_u175_o;
  wire _al_u177_o;
  wire _al_u179_o;
  wire _al_u182_o;
  wire _al_u241_o;
  wire _al_u244_o;
  wire _al_u245_o;
  wire _al_u248_o;
  wire _al_u91_o;
  wire _al_u92_o;
  wire _al_u93_o;
  wire _al_u95_o;
  wire _al_u96_o;
  wire _al_u97_o;
  wire _al_u99_o;
  wire \rckg/add0/c0 ;
  wire \rckg/add0/c1 ;
  wire \rckg/add0/c10 ;
  wire \rckg/add0/c2 ;
  wire \rckg/add0/c3 ;
  wire \rckg/add0/c4 ;
  wire \rckg/add0/c5 ;
  wire \rckg/add0/c6 ;
  wire \rckg/add0/c7 ;
  wire \rckg/add0/c8 ;
  wire \rckg/add0/c9 ;
  wire \rckg/add1/c0 ;
  wire \rckg/add1/c1 ;
  wire \rckg/add1/c2 ;
  wire \rckg/add1/c3 ;
  wire \rckg/add1/c4 ;
  wire \rckg/add1/c5 ;
  wire \rckg/add1/c6 ;
  wire \rckg/add1/c7 ;
  wire \rckg/add1/c8 ;
  wire \rckg/add1/c9 ;
  wire \rckg/add2/c0 ;
  wire \rckg/add2/c1 ;
  wire \rckg/add2/c2 ;
  wire \rckg/add2/c3 ;
  wire \rckg/add2/c4 ;
  wire \rckg/add2/c5 ;
  wire \rckg/add2/c6 ;
  wire \rckg/add3/c0 ;
  wire \rckg/add3/c1 ;
  wire \rckg/add3/c2 ;
  wire \rckg/add3/c3 ;
  wire \rckg/add3/c4 ;
  wire \rckg/add3/c5 ;
  wire \rckg/add3/c6 ;
  wire \rckg/n0 ;
  wire \rckg/n1 ;
  wire \rckg/n5 ;
  wire \rckg/n7 ;
  wire \rckg/n8 ;
  wire \rckg/rckg_clk32k ;  // rtl/rtc400_sys.v(460)
  wire \rckg/rckg_esel_dat ;  // rtl/rtc400_sys.v(500)
  wire \rckg/rckg_ovfl ;  // rtl/rtc400_sys.v(463)
  wire rckg_eavl;  // rtl/rtc400_sys.v(55)
  wire rckg_esel;  // rtl/rtc400_sys.v(56)
  wire \rctl/mux8_b4_sel_is_2_o ;
  wire \rctl/n10 ;
  wire \rctl/n12 ;
  wire \rctl/n14 ;
  wire \rctl/n16 ;
  wire \rctl/n2 ;
  wire \rctl/n4 ;
  wire \rctl/n6 ;
  wire \rctl/n8 ;
  wire \rctl/rd_rtcctl ;  // rtl/rtc400_sys.v(190)
  wire \rctl/rd_rtchrmi ;  // rtl/rtc400_sys.v(194)
  wire \rctl/rd_rtcintc ;  // rtl/rtc400_sys.v(191)
  wire \rctl/rd_rtcmody ;  // rtl/rtc400_sys.v(193)
  wire \rctl/rd_rtcscps ;  // rtl/rtc400_sys.v(195)
  wire \rctl/rd_rtcweek ;  // rtl/rtc400_sys.v(196)
  wire \rctl/rd_rtcyear ;  // rtl/rtc400_sys.v(192)
  wire \rctl/rfsm/mux0_b0_sel_is_3_o ;
  wire \rctl/rfsm/mux0_b1_sel_is_3_o ;
  wire \rctl/rfsm/mux0_b2_sel_is_3_o ;
  wire \rctl/rfsm/n10 ;
  wire \rctl/wr_rtcctl ;  // rtl/rtc400_sys.v(224)
  wire \rctl/wr_rtcintc ;  // rtl/rtc400_sys.v(225)
  wire \rctl/wrt_cyc ;  // rtl/rtc400_sys.v(222)
  wire rctl_esel;  // rtl/rtc400_sys.v(70)
  wire rctl_snap;  // rtl/rtc400_sys.v(71)
  wire \rdup/mux5_b0_sel_is_3_o ;
  wire \rdup/mux6_b0_sel_is_3_o ;
  wire \rdup/mux7_b0_sel_is_3_o ;
  wire \rdup/mux8_b0_sel_is_3_o ;
  wire \rdup/mux9_b0_sel_is_3_o ;
  wire \rdup/n2 ;
  wire \rdup/n3 ;
  wire \rdup/n4 ;
  wire \rdup/n5 ;
  wire \rdup/u11_sel_is_2_o ;
  wire rdup_leap;  // rtl/rtc400_sys.v(60)
  wire rdup_set_houf;  // rtl/rtc400_sys.v(57)
  wire rdup_set_minf;  // rtl/rtc400_sys.v(58)
  wire rdup_set_secf;  // rtl/rtc400_sys.v(59)

  assign bdatr[15] = 1'b0;
  assign rsys_reg[79] = 1'b0;
  assign rsys_reg[78] = 1'b0;
  assign rsys_reg[77] = 1'b0;
  assign rsys_reg[76] = 1'b0;
  assign rsys_reg[75] = 1'b0;
  assign rsys_reg[74] = 1'b0;
  assign rsys_reg[63] = 1'b0;
  assign rsys_reg[62] = 1'b0;
  assign rsys_reg[61] = 1'b0;
  assign rsys_reg[55] = 1'b0;
  assign rsys_reg[54] = 1'b0;
  assign rsys_reg[47] = 1'b0;
  assign rsys_reg[46] = 1'b0;
  assign rsys_reg[39] = 1'b0;
  assign rsys_reg[31] = 1'b0;
  assign rsys_reg[15] = 1'b0;
  assign rsys_reg[14] = 1'b0;
  assign rsys_reg[13] = 1'b0;
  assign rsys_reg[12] = 1'b0;
  assign rsys_reg[11] = 1'b0;
  assign rsys_reg[10] = 1'b0;
  assign rsys_reg[9] = 1'b0;
  assign rsys_reg[8] = 1'b0;
  assign rsys_reg[7] = 1'b0;
  assign rsys_reg[6] = 1'b0;
  assign rsys_reg[5] = 1'b0;
  assign rsys_reg[4] = 1'b0;
  assign rsys_reg[3] = 1'b0;
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u100 (
    .a(_al_u99_o),
    .b(rsys_reg[26]),
    .c(rsys_reg[27]),
    .d(rsub_reg[27]),
    .e(rsub_reg[26]),
    .o(_al_u100_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u101 (
    .a(rsys_reg[28]),
    .b(rsys_reg[29]),
    .c(rsub_reg[29]),
    .d(rsub_reg[28]),
    .o(_al_u101_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*B*A*~(E@C))"),
    .INIT(32'hff7ffff7))
    _al_u102 (
    .a(_al_u100_o),
    .b(_al_u101_o),
    .c(rsys_reg[30]),
    .d(rsub_reg[31]),
    .e(rsub_reg[30]),
    .o(\rdup/n5 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u103 (
    .a(\rckg/rckg_clkin_s [1]),
    .b(\rckg/rckg_clkin_s [2]),
    .o(\rckg/n0 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u104 (
    .a(\rctl/rtcintc [0]),
    .b(\rctl/rtcintc [2]),
    .c(\rctl/rtcintc [4]),
    .d(\rctl/rtcintc [6]),
    .o(_al_u104_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u105 (
    .a(_al_u104_o),
    .b(\rctl/rtcintc [1]),
    .c(\rctl/rtcintc [5]),
    .o(rtc_rtcr));
  AL_MAP_LUT3 #(
    .EQN("~(C*~B*A)"),
    .INIT(8'hdf))
    _al_u106 (
    .a(\rctl/rfsm/stat [0]),
    .b(\rctl/rfsm/stat [1]),
    .c(\rctl/rfsm/stat [2]),
    .o(\rctl/rfsm/n10 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u107 (
    .a(bcmdr),
    .b(bcs_rtcu_n),
    .o(\rctl/n2 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u108 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n4 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u109 (
    .a(\rckg/rckg_clk32k_s [1]),
    .b(\rckg/rckg_clk32k_s [2]),
    .c(rctl_snap),
    .o(\rdup/n2 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u110 (
    .a(\rctl/rtcctl [1]),
    .b(\rctl/rsub_wrt_ack_s [1]),
    .c(\rctl/rfsm/stat [2]),
    .o(_al_u110_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u111 (
    .a(_al_u110_o),
    .b(\rctl/rfsm/stat [0]),
    .c(\rctl/rfsm/stat [1]),
    .o(rctl_wrt_req));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u112 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[42]),
    .d(rsys_reg[26]),
    .o(_al_u112_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))"),
    .INIT(32'h00310001))
    _al_u113 (
    .a(_al_u112_o),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcmody ),
    .d(\rctl/rd_rtcyear ),
    .e(rsys_reg[58]),
    .o(bdatr[10]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u114 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[43]),
    .d(rsys_reg[27]),
    .o(_al_u114_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))"),
    .INIT(32'h00310001))
    _al_u115 (
    .a(_al_u114_o),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcmody ),
    .d(\rctl/rd_rtcyear ),
    .e(rsys_reg[59]),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u116 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[44]),
    .d(rsys_reg[28]),
    .o(_al_u116_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))"),
    .INIT(32'h00310001))
    _al_u117 (
    .a(_al_u116_o),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcmody ),
    .d(\rctl/rd_rtcyear ),
    .e(rsys_reg[60]),
    .o(bdatr[12]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u118 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n12 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u119 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u120 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n8 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u121 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n14 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u122 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u123 (
    .a(\rctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/n6 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u124 (
    .a(bcmdw),
    .b(bcs_rtcu_n),
    .c(brdy),
    .o(\rctl/wrt_cyc ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u125 (
    .a(\rctl/wrt_cyc ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/wr_rtcintc ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u126 (
    .a(\rckg/rckg_pscl [0]),
    .b(\rckg/rckg_pscl [1]),
    .c(\rckg/rckg_pscl [2]),
    .d(\rckg/rckg_pscl [3]),
    .e(\rckg/rckg_pscl [4]),
    .o(_al_u126_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u127 (
    .a(\rckg/rckg_pscl [5]),
    .b(\rckg/rckg_pscl [6]),
    .c(\rckg/rckg_pscl [7]),
    .d(\rckg/rckg_pscl [8]),
    .e(\rckg/rckg_pscl [9]),
    .o(_al_u127_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u128 (
    .a(_al_u126_o),
    .b(_al_u127_o),
    .o(\rckg/n7 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u129 (
    .a(\rdup/n2 ),
    .b(rst_n),
    .o(\rdup/u11_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u130 (
    .a(\rctl/rd_rtcctl ),
    .b(\rctl/rd_rtcyear ),
    .c(rsys_reg[30]),
    .o(_al_u130_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u131 (
    .a(_al_u130_o),
    .b(\rctl/rd_rtchrmi ),
    .c(\rctl/rd_rtcmody ),
    .d(\rctl/rd_rtcscps ),
    .o(bdatr[14]));
  AL_MAP_LUT5 #(
    .EQN("~(~B*((E*C)*~(D)*~(A)+(E*C)*D*~(A)+~((E*C))*D*A+(E*C)*D*A))"),
    .INIT(32'hcdefddff))
    _al_u132 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcmody ),
    .c(\rctl/rd_rtcscps ),
    .d(rsys_reg[45]),
    .e(rsys_reg[29]),
    .o(_al_u132_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(~C*A))"),
    .INIT(8'h31))
    _al_u133 (
    .a(_al_u132_o),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcyear ),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u134 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[35]),
    .d(rsys_reg[19]),
    .o(_al_u134_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u135 (
    .a(_al_u134_o),
    .b(\rctl/rd_rtcmody ),
    .c(\rctl/rd_rtcyear ),
    .d(rsys_reg[67]),
    .e(rsys_reg[51]),
    .o(_al_u135_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u136 (
    .a(_al_u135_o),
    .b(\rctl/rd_rtcctl ),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u137 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[40]),
    .d(rsys_reg[24]),
    .o(_al_u137_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u138 (
    .a(_al_u137_o),
    .b(\rctl/rd_rtcmody ),
    .c(\rctl/rd_rtcyear ),
    .d(rsys_reg[72]),
    .e(rsys_reg[56]),
    .o(_al_u138_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u139 (
    .a(_al_u138_o),
    .b(\rctl/rd_rtcctl ),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u140 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[41]),
    .d(rsys_reg[25]),
    .o(_al_u140_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u141 (
    .a(_al_u140_o),
    .b(\rctl/rd_rtcmody ),
    .c(\rctl/rd_rtcyear ),
    .d(rsys_reg[73]),
    .e(rsys_reg[57]),
    .o(_al_u141_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u142 (
    .a(_al_u141_o),
    .b(\rctl/rd_rtcctl ),
    .o(bdatr[9]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h54dc))
    _al_u143 (
    .a(\rctl/wr_rtcintc ),
    .b(\rctl/rtcintc [2]),
    .c(rdup_set_houf),
    .d(bdatw[2]),
    .o(\rctl/n43 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h54dc))
    _al_u144 (
    .a(\rctl/wr_rtcintc ),
    .b(\rctl/rtcintc [1]),
    .c(rdup_set_minf),
    .d(bdatw[1]),
    .o(\rctl/n43 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h54dc))
    _al_u145 (
    .a(\rctl/wr_rtcintc ),
    .b(\rctl/rtcintc [0]),
    .c(rdup_set_secf),
    .d(bdatw[0]),
    .o(\rctl/n43 [0]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u146 (
    .a(\rckg/rckg_cnt [0]),
    .b(\rckg/rckg_cnt [1]),
    .c(\rckg/rckg_cnt [10]),
    .d(\rckg/rckg_cnt [2]),
    .o(_al_u146_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u147 (
    .a(_al_u146_o),
    .b(\rckg/rckg_cnt [3]),
    .c(\rckg/rckg_cnt [4]),
    .d(\rckg/rckg_cnt [5]),
    .e(\rckg/rckg_cnt [6]),
    .o(_al_u147_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u148 (
    .a(_al_u147_o),
    .b(\rckg/rckg_cnt [7]),
    .c(\rckg/rckg_cnt [8]),
    .d(\rckg/rckg_cnt [9]),
    .o(\rckg/n1 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u149 (
    .a(\rckg/rckg_pscl [5]),
    .b(\rckg/rckg_pscl [6]),
    .c(\rckg/rckg_pscl [7]),
    .d(\rckg/rckg_pscl [8]),
    .e(\rckg/rckg_pscl [9]),
    .o(_al_u149_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*~A)"),
    .INIT(32'h00004000))
    _al_u150 (
    .a(\rckg/rckg_pscl [0]),
    .b(\rckg/rckg_pscl [1]),
    .c(\rckg/rckg_pscl [2]),
    .d(\rckg/rckg_pscl [3]),
    .e(\rckg/rckg_pscl [4]),
    .o(_al_u150_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u151 (
    .a(_al_u149_o),
    .b(_al_u150_o),
    .o(\rckg/n8 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u152 (
    .a(\rckg/rckg_pscl [3]),
    .b(\rckg/rckg_pscl [5]),
    .c(\rckg/rckg_pscl [7]),
    .d(\rckg/rckg_pscl [9]),
    .o(_al_u152_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'heff7))
    _al_u153 (
    .a(\rckg/rckg_pscl [0]),
    .b(\rckg/rckg_pscl [1]),
    .c(\rckg/rckg_pscl [2]),
    .d(\rckg/rckg_err [6]),
    .o(_al_u153_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u154 (
    .a(_al_u152_o),
    .b(_al_u153_o),
    .c(\rckg/rckg_pscl [4]),
    .d(\rckg/rckg_pscl [6]),
    .e(\rckg/rckg_pscl [8]),
    .o(\rckg/rckg_ovfl ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u155 (
    .a(\rctl/rd_rtchrmi ),
    .b(\rctl/rd_rtcmody ),
    .c(\rctl/rd_rtcscps ),
    .d(rsys_reg[23]),
    .o(\rctl/n50 [7]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D)*~(B)*~(C)+(A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D)*B*~(C)+~((A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D))*B*C+(A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D)*B*C)"),
    .INIT(32'hcfcac0ca))
    _al_u156 (
    .a(\rctl/n50 [7]),
    .b(rckg_eavl),
    .c(\rctl/rd_rtcctl ),
    .d(\rctl/rd_rtcyear ),
    .e(rsys_reg[71]),
    .o(bdatr[7]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u157 (
    .a(\rctl/wrt_cyc ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rctl/wr_rtcctl ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*C*B))"),
    .INIT(16'haa2a))
    _al_u158 (
    .a(rctl_snap),
    .b(\rctl/rfsm/stat [0]),
    .c(\rctl/rfsm/stat [1]),
    .d(\rctl/rfsm/stat [2]),
    .o(\rctl/n34 [0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u159 (
    .a(\rctl/wr_rtcctl ),
    .b(\rctl/n34 [0]),
    .c(bdatw[0]),
    .o(\rctl/n35 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*~(B*~A)))"),
    .INIT(16'hf400))
    _al_u160 (
    .a(rctl_snap),
    .b(\rctl/rtcctl [1]),
    .c(\rctl/rfsm/stat [2]),
    .d(rst_n),
    .o(_al_u160_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u161 (
    .a(_al_u160_o),
    .b(\rctl/rfsm/stat [0]),
    .c(\rctl/rfsm/stat [1]),
    .o(\rctl/rfsm/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B*(D@C)))"),
    .INIT(16'ha22a))
    _al_u162 (
    .a(\rctl/rtcctl [1]),
    .b(\rctl/rfsm/stat [0]),
    .c(\rctl/rfsm/stat [1]),
    .d(\rctl/rfsm/stat [2]),
    .o(\rctl/n34 [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u163 (
    .a(\rctl/wr_rtcctl ),
    .b(\rctl/n34 [1]),
    .c(bdatw[1]),
    .o(\rctl/n35 [1]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u164 (
    .a(\rctl/rd_rtcintc ),
    .b(\rctl/rd_rtcweek ),
    .o(\rctl/mux8_b4_sel_is_2_o ));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u165 (
    .a(\rctl/rd_rtcintc ),
    .b(\rctl/rd_rtcweek ),
    .c(\rctl/rtcintc [0]),
    .d(rsys_reg[0]),
    .o(_al_u165_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u166 (
    .a(_al_u165_o),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[16]),
    .o(\rctl/n48 [0]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u167 (
    .a(\rctl/n48 [0]),
    .b(\rctl/rd_rtchrmi ),
    .c(\rctl/rd_rtcmody ),
    .d(rsys_reg[48]),
    .e(rsys_reg[32]),
    .o(\rctl/n50 [0]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u168 (
    .a(\rctl/n50 [0]),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcyear ),
    .d(rctl_snap),
    .e(rsys_reg[64]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u169 (
    .a(\rctl/rd_rtcintc ),
    .b(\rctl/rd_rtcweek ),
    .c(\rctl/rtcintc [1]),
    .d(rsys_reg[1]),
    .o(_al_u169_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u170 (
    .a(_al_u169_o),
    .b(\rctl/rd_rtcscps ),
    .c(rsys_reg[17]),
    .o(\rctl/n48 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u171 (
    .a(\rctl/n48 [1]),
    .b(\rctl/rd_rtchrmi ),
    .c(\rctl/rd_rtcmody ),
    .d(rsys_reg[49]),
    .e(rsys_reg[33]),
    .o(\rctl/n50 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u172 (
    .a(\rctl/n50 [1]),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcyear ),
    .d(\rctl/rtcctl [1]),
    .e(rsys_reg[65]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u173 (
    .a(\rctl/rd_rtcintc ),
    .b(\rctl/rd_rtcweek ),
    .c(\rctl/rtcintc [2]),
    .d(rsys_reg[2]),
    .o(_al_u173_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u174 (
    .a(_al_u173_o),
    .b(\rctl/rd_rtchrmi ),
    .c(\rctl/rd_rtcscps ),
    .d(rsys_reg[34]),
    .e(rsys_reg[18]),
    .o(_al_u174_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u175 (
    .a(_al_u174_o),
    .b(\rctl/rd_rtcmody ),
    .c(\rctl/rd_rtcyear ),
    .d(rsys_reg[66]),
    .e(rsys_reg[50]),
    .o(_al_u175_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u176 (
    .a(_al_u175_o),
    .b(\rctl/rd_rtcctl ),
    .o(bdatr[2]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B*A))"),
    .INIT(8'h07))
    _al_u177 (
    .a(rctl_snap),
    .b(\rctl/rtcctl [1]),
    .c(\rctl/rfsm/stat [2]),
    .o(_al_u177_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D))"),
    .INIT(32'h0aa30000))
    _al_u178 (
    .a(_al_u110_o),
    .b(_al_u177_o),
    .c(\rctl/rfsm/stat [0]),
    .d(\rctl/rfsm/stat [1]),
    .e(rst_n),
    .o(\rctl/rfsm/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*(A*B*~(C)+~(A)*~(B)*C+A*~(B)*C))"),
    .INIT(32'h00380000))
    _al_u179 (
    .a(\rctl/rsub_wrt_ack_s [1]),
    .b(\rctl/rfsm/stat [0]),
    .c(\rctl/rfsm/stat [1]),
    .d(\rctl/rfsm/stat [2]),
    .e(rst_n),
    .o(_al_u179_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u180 (
    .a(_al_u179_o),
    .b(\rctl/rtcctl [1]),
    .o(\rctl/rfsm/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'hea40))
    _al_u181 (
    .a(\rctl/wr_rtcctl ),
    .b(\rctl/rfsm/n10 ),
    .c(rctl_esel),
    .d(bdatw[6]),
    .o(\rctl/n35 [6]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u182 (
    .a(\rctl/wrt_cyc ),
    .b(rctl_snap),
    .c(\rctl/rtcctl [1]),
    .o(_al_u182_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u183 (
    .a(_al_u182_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rdup/mux9_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u184 (
    .a(\rdup/mux9_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[2]),
    .d(bdatw[2]),
    .e(rsub_reg[2]),
    .o(\rdup/n24 [2]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u185 (
    .a(\rdup/mux9_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[1]),
    .d(bdatw[1]),
    .e(rsub_reg[1]),
    .o(\rdup/n24 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u186 (
    .a(\rdup/mux9_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[0]),
    .d(bdatw[0]),
    .e(rsub_reg[0]),
    .o(\rdup/n24 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u187 (
    .a(_al_u182_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rdup/mux8_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u188 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[25]),
    .d(bdatw[9]),
    .e(rsub_reg[25]),
    .o(\rdup/n23 [9]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u189 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[24]),
    .d(bdatw[8]),
    .e(rsub_reg[24]),
    .o(\rdup/n23 [8]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u190 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[23]),
    .d(bdatw[7]),
    .e(rsub_reg[23]),
    .o(\rdup/n23 [7]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u191 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[22]),
    .d(bdatw[6]),
    .e(rsub_reg[22]),
    .o(\rdup/n23 [6]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u192 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[21]),
    .d(bdatw[5]),
    .e(rsub_reg[21]),
    .o(\rdup/n23 [5]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u193 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[20]),
    .d(bdatw[4]),
    .e(rsub_reg[20]),
    .o(\rdup/n23 [4]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u194 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[19]),
    .d(bdatw[3]),
    .e(rsub_reg[19]),
    .o(\rdup/n23 [3]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u195 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[18]),
    .d(bdatw[2]),
    .e(rsub_reg[18]),
    .o(\rdup/n23 [2]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u196 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[17]),
    .d(bdatw[1]),
    .e(rsub_reg[17]),
    .o(\rdup/n23 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u197 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[30]),
    .d(bdatw[14]),
    .e(rsub_reg[30]),
    .o(\rdup/n23 [14]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u198 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[29]),
    .d(bdatw[13]),
    .e(rsub_reg[29]),
    .o(\rdup/n23 [13]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u199 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[28]),
    .d(bdatw[12]),
    .e(rsub_reg[28]),
    .o(\rdup/n23 [12]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u200 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[27]),
    .d(bdatw[11]),
    .e(rsub_reg[27]),
    .o(\rdup/n23 [11]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u201 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[26]),
    .d(bdatw[10]),
    .e(rsub_reg[26]),
    .o(\rdup/n23 [10]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u202 (
    .a(\rdup/mux8_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[16]),
    .d(bdatw[0]),
    .e(rsub_reg[16]),
    .o(\rdup/n23 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u203 (
    .a(_al_u182_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rdup/mux7_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u204 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[41]),
    .d(bdatw[9]),
    .e(rsub_reg[41]),
    .o(\rdup/n22 [9]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u205 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[40]),
    .d(bdatw[8]),
    .e(rsub_reg[40]),
    .o(\rdup/n22 [8]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u206 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[38]),
    .d(bdatw[6]),
    .e(rsub_reg[38]),
    .o(\rdup/n22 [6]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u207 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[37]),
    .d(bdatw[5]),
    .e(rsub_reg[37]),
    .o(\rdup/n22 [5]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u208 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[36]),
    .d(bdatw[4]),
    .e(rsub_reg[36]),
    .o(\rdup/n22 [4]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u209 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[35]),
    .d(bdatw[3]),
    .e(rsub_reg[35]),
    .o(\rdup/n22 [3]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u210 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[34]),
    .d(bdatw[2]),
    .e(rsub_reg[34]),
    .o(\rdup/n22 [2]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u211 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[33]),
    .d(bdatw[1]),
    .e(rsub_reg[33]),
    .o(\rdup/n22 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u212 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[45]),
    .d(bdatw[13]),
    .e(rsub_reg[45]),
    .o(\rdup/n22 [13]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u213 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[44]),
    .d(bdatw[12]),
    .e(rsub_reg[44]),
    .o(\rdup/n22 [12]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u214 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[43]),
    .d(bdatw[11]),
    .e(rsub_reg[43]),
    .o(\rdup/n22 [11]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u215 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[42]),
    .d(bdatw[10]),
    .e(rsub_reg[42]),
    .o(\rdup/n22 [10]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u216 (
    .a(\rdup/mux7_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[32]),
    .d(bdatw[0]),
    .e(rsub_reg[32]),
    .o(\rdup/n22 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u217 (
    .a(_al_u182_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rdup/mux6_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u218 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[57]),
    .d(bdatw[9]),
    .e(rsub_reg[57]),
    .o(\rdup/n21 [9]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u219 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[56]),
    .d(bdatw[8]),
    .e(rsub_reg[56]),
    .o(\rdup/n21 [8]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u220 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[53]),
    .d(bdatw[5]),
    .e(rsub_reg[53]),
    .o(\rdup/n21 [5]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u221 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[52]),
    .d(bdatw[4]),
    .e(rsub_reg[52]),
    .o(\rdup/n21 [4]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u222 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[51]),
    .d(bdatw[3]),
    .e(rsub_reg[51]),
    .o(\rdup/n21 [3]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u223 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[50]),
    .d(bdatw[2]),
    .e(rsub_reg[50]),
    .o(\rdup/n21 [2]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u224 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[49]),
    .d(bdatw[1]),
    .e(rsub_reg[49]),
    .o(\rdup/n21 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u225 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[60]),
    .d(bdatw[12]),
    .e(rsub_reg[60]),
    .o(\rdup/n21 [12]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u226 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[59]),
    .d(bdatw[11]),
    .e(rsub_reg[59]),
    .o(\rdup/n21 [11]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u227 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[58]),
    .d(bdatw[10]),
    .e(rsub_reg[58]),
    .o(\rdup/n21 [10]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u228 (
    .a(\rdup/mux6_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[48]),
    .d(bdatw[0]),
    .e(rsub_reg[48]),
    .o(\rdup/n21 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u229 (
    .a(_al_u182_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\rdup/mux5_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u230 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[73]),
    .d(bdatw[9]),
    .e(rsub_reg[73]),
    .o(\rdup/n20 [9]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u231 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[72]),
    .d(bdatw[8]),
    .e(rsub_reg[72]),
    .o(\rdup/n20 [8]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u232 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[71]),
    .d(bdatw[7]),
    .e(rsub_reg[71]),
    .o(\rdup/n20 [7]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u233 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[70]),
    .d(bdatw[6]),
    .e(rsub_reg[70]),
    .o(\rdup/n20 [6]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u234 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[69]),
    .d(bdatw[5]),
    .e(rsub_reg[69]),
    .o(\rdup/n20 [5]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u235 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[68]),
    .d(bdatw[4]),
    .e(rsub_reg[68]),
    .o(\rdup/n20 [4]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u236 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[67]),
    .d(bdatw[3]),
    .e(rsub_reg[67]),
    .o(\rdup/n20 [3]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u237 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[66]),
    .d(bdatw[2]),
    .e(rsub_reg[66]),
    .o(\rdup/n20 [2]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u238 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[65]),
    .d(bdatw[1]),
    .e(rsub_reg[65]),
    .o(\rdup/n20 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*~(E)*~(B)+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*~(B)+~((C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))*E*B+(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A)*E*B)"),
    .INIT(32'hfedc3210))
    _al_u239 (
    .a(\rdup/mux5_b0_sel_is_3_o ),
    .b(\rdup/n2 ),
    .c(rsys_reg[64]),
    .d(bdatw[0]),
    .e(rsub_reg[64]),
    .o(\rdup/n20 [0]));
  AL_MAP_LUT4 #(
    .EQN("((C*~A)*~(D)*~(B)+(C*~A)*D*~(B)+~((C*~A))*D*B+(C*~A)*D*B)"),
    .INIT(16'hdc10))
    _al_u240 (
    .a(\rckg/n1 ),
    .b(\rckg/n0 ),
    .c(rckg_eavl),
    .d(\rckg/rckg_cnt [9]),
    .o(\rckg/n5 ));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u241 (
    .a(\rctl/mux8_b4_sel_is_2_o ),
    .b(\rctl/rd_rtcscps ),
    .c(\rctl/rtcintc [6]),
    .d(rsys_reg[22]),
    .o(_al_u241_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))"),
    .INIT(16'h0d01))
    _al_u242 (
    .a(_al_u241_o),
    .b(\rctl/rd_rtchrmi ),
    .c(\rctl/rd_rtcmody ),
    .d(rsys_reg[38]),
    .o(\rctl/n50 [6]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D)*~(B)*~(C)+(A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D)*B*~(C)+~((A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D))*B*C+(A*~(E)*~(D)+A*E*~(D)+~(A)*E*D+A*E*D)*B*C)"),
    .INIT(32'hcfcac0ca))
    _al_u243 (
    .a(\rctl/n50 [6]),
    .b(rckg_esel),
    .c(\rctl/rd_rtcctl ),
    .d(\rctl/rd_rtcyear ),
    .e(rsys_reg[70]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u244 (
    .a(\rctl/mux8_b4_sel_is_2_o ),
    .b(\rctl/rd_rtcscps ),
    .c(\rctl/rtcintc [5]),
    .d(rsys_reg[21]),
    .o(_al_u244_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u245 (
    .a(_al_u244_o),
    .b(\rctl/rd_rtchrmi ),
    .c(\rctl/rd_rtcmody ),
    .d(rsys_reg[53]),
    .e(rsys_reg[37]),
    .o(_al_u245_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u246 (
    .a(_al_u245_o),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcyear ),
    .d(rdup_leap),
    .e(rsys_reg[69]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'hec20))
    _al_u247 (
    .a(\rctl/mux8_b4_sel_is_2_o ),
    .b(\rctl/rd_rtcscps ),
    .c(\rctl/rtcintc [4]),
    .d(rsys_reg[20]),
    .o(\rctl/n48 [4]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'h01f10dfd))
    _al_u248 (
    .a(\rctl/n48 [4]),
    .b(\rctl/rd_rtchrmi ),
    .c(\rctl/rd_rtcmody ),
    .d(rsys_reg[52]),
    .e(rsys_reg[36]),
    .o(_al_u248_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u249 (
    .a(_al_u248_o),
    .b(\rctl/rd_rtcctl ),
    .c(\rctl/rd_rtcyear ),
    .d(rsys_reg[68]),
    .o(bdatr[4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u82 (
    .a(\rckg/rckg_clk32k ),
    .b(rckg_esel),
    .c(rtc_clkin),
    .o(clk32k));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u83 (
    .a(\rckg/n13 [6]),
    .b(\rckg/n14 [6]),
    .c(\rckg/rckg_err [6]),
    .o(\rckg/n15 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u84 (
    .a(\rckg/n13 [5]),
    .b(\rckg/n14 [5]),
    .c(\rckg/rckg_err [6]),
    .o(\rckg/n15 [5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u85 (
    .a(\rckg/n13 [4]),
    .b(\rckg/n14 [4]),
    .c(\rckg/rckg_err [6]),
    .o(\rckg/n15 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u86 (
    .a(\rckg/n13 [3]),
    .b(\rckg/n14 [3]),
    .c(\rckg/rckg_err [6]),
    .o(\rckg/n15 [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u87 (
    .a(\rckg/n13 [2]),
    .b(\rckg/n14 [2]),
    .c(\rckg/rckg_err [6]),
    .o(\rckg/n15 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u88 (
    .a(\rckg/n13 [1]),
    .b(\rckg/n14 [1]),
    .c(\rckg/rckg_err [6]),
    .o(\rckg/n15 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u89 (
    .a(\rckg/n13 [0]),
    .b(\rckg/n14 [0]),
    .c(\rckg/rckg_err [6]),
    .o(\rckg/n15 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u90 (
    .a(rckg_eavl),
    .b(rckg_esel),
    .c(rctl_esel),
    .o(\rckg/rckg_esel_dat ));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u91 (
    .a(rsys_reg[32]),
    .b(rsys_reg[33]),
    .c(rsub_reg[33]),
    .d(rsub_reg[32]),
    .o(_al_u91_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u92 (
    .a(_al_u91_o),
    .b(rsys_reg[34]),
    .c(rsys_reg[35]),
    .d(rsub_reg[35]),
    .e(rsub_reg[34]),
    .o(_al_u92_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u93 (
    .a(rsys_reg[36]),
    .b(rsys_reg[37]),
    .c(rsub_reg[37]),
    .d(rsub_reg[36]),
    .o(_al_u93_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*B*A*~(E@C))"),
    .INIT(32'hff7ffff7))
    _al_u94 (
    .a(_al_u92_o),
    .b(_al_u93_o),
    .c(rsys_reg[38]),
    .d(rsub_reg[39]),
    .e(rsub_reg[38]),
    .o(\rdup/n4 ));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u95 (
    .a(rsys_reg[40]),
    .b(rsys_reg[41]),
    .c(rsub_reg[41]),
    .d(rsub_reg[40]),
    .o(_al_u95_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u96 (
    .a(_al_u95_o),
    .b(rsys_reg[42]),
    .c(rsys_reg[43]),
    .d(rsub_reg[43]),
    .e(rsub_reg[42]),
    .o(_al_u96_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u97 (
    .a(rsys_reg[44]),
    .b(rsys_reg[45]),
    .c(rsub_reg[45]),
    .d(rsub_reg[44]),
    .o(_al_u97_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~C*B*A)"),
    .INIT(16'hfff7))
    _al_u98 (
    .a(_al_u96_o),
    .b(_al_u97_o),
    .c(rsub_reg[47]),
    .d(rsub_reg[46]),
    .o(\rdup/n3 ));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u99 (
    .a(rsys_reg[24]),
    .b(rsys_reg[25]),
    .c(rsub_reg[25]),
    .d(rsub_reg[24]),
    .o(_al_u99_o));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u0  (
    .a(\rckg/rckg_cnt [0]),
    .b(1'b1),
    .c(\rckg/add0/c0 ),
    .o({\rckg/add0/c1 ,\rckg/n2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u1  (
    .a(\rckg/rckg_cnt [1]),
    .b(1'b0),
    .c(\rckg/add0/c1 ),
    .o({\rckg/add0/c2 ,\rckg/n2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u10  (
    .a(\rckg/rckg_cnt [10]),
    .b(1'b0),
    .c(\rckg/add0/c10 ),
    .o({open_n0,\rckg/n2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u2  (
    .a(\rckg/rckg_cnt [2]),
    .b(1'b0),
    .c(\rckg/add0/c2 ),
    .o({\rckg/add0/c3 ,\rckg/n2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u3  (
    .a(\rckg/rckg_cnt [3]),
    .b(1'b0),
    .c(\rckg/add0/c3 ),
    .o({\rckg/add0/c4 ,\rckg/n2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u4  (
    .a(\rckg/rckg_cnt [4]),
    .b(1'b0),
    .c(\rckg/add0/c4 ),
    .o({\rckg/add0/c5 ,\rckg/n2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u5  (
    .a(\rckg/rckg_cnt [5]),
    .b(1'b0),
    .c(\rckg/add0/c5 ),
    .o({\rckg/add0/c6 ,\rckg/n2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u6  (
    .a(\rckg/rckg_cnt [6]),
    .b(1'b0),
    .c(\rckg/add0/c6 ),
    .o({\rckg/add0/c7 ,\rckg/n2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u7  (
    .a(\rckg/rckg_cnt [7]),
    .b(1'b0),
    .c(\rckg/add0/c7 ),
    .o({\rckg/add0/c8 ,\rckg/n2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u8  (
    .a(\rckg/rckg_cnt [8]),
    .b(1'b0),
    .c(\rckg/add0/c8 ),
    .o({\rckg/add0/c9 ,\rckg/n2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add0/u9  (
    .a(\rckg/rckg_cnt [9]),
    .b(1'b0),
    .c(\rckg/add0/c9 ),
    .o({\rckg/add0/c10 ,\rckg/n2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rckg/add0/ucin  (
    .a(1'b0),
    .o({\rckg/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u0  (
    .a(\rckg/rckg_pscl [0]),
    .b(1'b1),
    .c(\rckg/add1/c0 ),
    .o({\rckg/add1/c1 ,\rckg/n11 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u1  (
    .a(\rckg/rckg_pscl [1]),
    .b(1'b0),
    .c(\rckg/add1/c1 ),
    .o({\rckg/add1/c2 ,\rckg/n11 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u2  (
    .a(\rckg/rckg_pscl [2]),
    .b(1'b0),
    .c(\rckg/add1/c2 ),
    .o({\rckg/add1/c3 ,\rckg/n11 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u3  (
    .a(\rckg/rckg_pscl [3]),
    .b(1'b0),
    .c(\rckg/add1/c3 ),
    .o({\rckg/add1/c4 ,\rckg/n11 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u4  (
    .a(\rckg/rckg_pscl [4]),
    .b(1'b0),
    .c(\rckg/add1/c4 ),
    .o({\rckg/add1/c5 ,\rckg/n11 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u5  (
    .a(\rckg/rckg_pscl [5]),
    .b(1'b0),
    .c(\rckg/add1/c5 ),
    .o({\rckg/add1/c6 ,\rckg/n11 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u6  (
    .a(\rckg/rckg_pscl [6]),
    .b(1'b0),
    .c(\rckg/add1/c6 ),
    .o({\rckg/add1/c7 ,\rckg/n11 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u7  (
    .a(\rckg/rckg_pscl [7]),
    .b(1'b0),
    .c(\rckg/add1/c7 ),
    .o({\rckg/add1/c8 ,\rckg/n11 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u8  (
    .a(\rckg/rckg_pscl [8]),
    .b(1'b0),
    .c(\rckg/add1/c8 ),
    .o({\rckg/add1/c9 ,\rckg/n11 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add1/u9  (
    .a(\rckg/rckg_pscl [9]),
    .b(1'b0),
    .c(\rckg/add1/c9 ),
    .o({open_n4,\rckg/n11 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rckg/add1/ucin  (
    .a(1'b0),
    .o({\rckg/add1/c0 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add2/u0  (
    .a(\rckg/rckg_err [0]),
    .b(1'b1),
    .c(\rckg/add2/c0 ),
    .o({\rckg/add2/c1 ,\rckg/n13 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add2/u1  (
    .a(\rckg/rckg_err [1]),
    .b(1'b0),
    .c(\rckg/add2/c1 ),
    .o({\rckg/add2/c2 ,\rckg/n13 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add2/u2  (
    .a(\rckg/rckg_err [2]),
    .b(1'b1),
    .c(\rckg/add2/c2 ),
    .o({\rckg/add2/c3 ,\rckg/n13 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add2/u3  (
    .a(\rckg/rckg_err [3]),
    .b(1'b0),
    .c(\rckg/add2/c3 ),
    .o({\rckg/add2/c4 ,\rckg/n13 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add2/u4  (
    .a(\rckg/rckg_err [4]),
    .b(1'b0),
    .c(\rckg/add2/c4 ),
    .o({\rckg/add2/c5 ,\rckg/n13 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add2/u5  (
    .a(\rckg/rckg_err [5]),
    .b(1'b1),
    .c(\rckg/add2/c5 ),
    .o({\rckg/add2/c6 ,\rckg/n13 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add2/u6  (
    .a(\rckg/rckg_err [6]),
    .b(1'b1),
    .c(\rckg/add2/c6 ),
    .o({open_n8,\rckg/n13 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rckg/add2/ucin  (
    .a(1'b0),
    .o({\rckg/add2/c0 ,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add3/u0  (
    .a(\rckg/rckg_err [0]),
    .b(1'b1),
    .c(\rckg/add3/c0 ),
    .o({\rckg/add3/c1 ,\rckg/n14 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add3/u1  (
    .a(\rckg/rckg_err [1]),
    .b(1'b0),
    .c(\rckg/add3/c1 ),
    .o({\rckg/add3/c2 ,\rckg/n14 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add3/u2  (
    .a(\rckg/rckg_err [2]),
    .b(1'b1),
    .c(\rckg/add3/c2 ),
    .o({\rckg/add3/c3 ,\rckg/n14 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add3/u3  (
    .a(\rckg/rckg_err [3]),
    .b(1'b0),
    .c(\rckg/add3/c3 ),
    .o({\rckg/add3/c4 ,\rckg/n14 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add3/u4  (
    .a(\rckg/rckg_err [4]),
    .b(1'b0),
    .c(\rckg/add3/c4 ),
    .o({\rckg/add3/c5 ,\rckg/n14 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add3/u5  (
    .a(\rckg/rckg_err [5]),
    .b(1'b1),
    .c(\rckg/add3/c5 ),
    .o({\rckg/add3/c6 ,\rckg/n14 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rckg/add3/u6  (
    .a(\rckg/rckg_err [6]),
    .b(1'b0),
    .c(\rckg/add3/c6 ),
    .o({open_n12,\rckg/n14 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rckg/add3/ucin  (
    .a(1'b0),
    .o({\rckg/add3/c0 ,open_n15}));
  reg_ar_ss_w1 \rckg/rckg_clk32k_reg  (
    .clk(clk),
    .d(1'b0),
    .en(\rckg/n8 ),
    .reset(1'b0),
    .set(\rckg/n7 ),
    .q(\rckg/rckg_clk32k ));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/rckg_eavl_reg  (
    .clk(clk),
    .d(\rckg/n5 ),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rckg_eavl));  // rtl/rtc400_sys.v(445)
  reg_ar_as_w1 \rckg/rckg_esel_reg  (
    .clk(clk),
    .d(\rckg/rckg_esel_dat ),
    .en(~\rctl/rfsm/n10 ),
    .reset(1'b0),
    .set(1'b0),
    .q(rckg_esel));  // rtl/rtc400_sys.v(508)
  reg_sr_as_w1 \rckg/reg0_b0  (
    .clk(clk),
    .d(\rckg/n2 [0]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [0]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b1  (
    .clk(clk),
    .d(\rckg/n2 [1]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [1]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b10  (
    .clk(clk),
    .d(\rckg/n2 [10]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [10]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b2  (
    .clk(clk),
    .d(\rckg/n2 [2]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [2]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b3  (
    .clk(clk),
    .d(\rckg/n2 [3]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [3]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b4  (
    .clk(clk),
    .d(\rckg/n2 [4]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [4]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b5  (
    .clk(clk),
    .d(\rckg/n2 [5]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [5]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b6  (
    .clk(clk),
    .d(\rckg/n2 [6]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [6]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b7  (
    .clk(clk),
    .d(\rckg/n2 [7]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [7]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b8  (
    .clk(clk),
    .d(\rckg/n2 [8]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [8]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg0_b9  (
    .clk(clk),
    .d(\rckg/n2 [9]),
    .en(~\rckg/n1 ),
    .reset(\rckg/n0 ),
    .set(1'b0),
    .q(\rckg/rckg_cnt [9]));  // rtl/rtc400_sys.v(445)
  reg_sr_as_w1 \rckg/reg1_b0  (
    .clk(clk),
    .d(\rckg/n11 [0]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [0]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b1  (
    .clk(clk),
    .d(\rckg/n11 [1]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [1]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b2  (
    .clk(clk),
    .d(\rckg/n11 [2]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [2]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b3  (
    .clk(clk),
    .d(\rckg/n11 [3]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [3]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b4  (
    .clk(clk),
    .d(\rckg/n11 [4]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [4]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b5  (
    .clk(clk),
    .d(\rckg/n11 [5]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [5]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b6  (
    .clk(clk),
    .d(\rckg/n11 [6]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [6]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b7  (
    .clk(clk),
    .d(\rckg/n11 [7]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [7]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b8  (
    .clk(clk),
    .d(\rckg/n11 [8]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [8]));  // rtl/rtc400_sys.v(493)
  reg_sr_as_w1 \rckg/reg1_b9  (
    .clk(clk),
    .d(\rckg/n11 [9]),
    .en(1'b1),
    .reset(\rckg/rckg_ovfl ),
    .set(1'b0),
    .q(\rckg/rckg_pscl [9]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg2_b0  (
    .clk(clk),
    .d(\rckg/n15 [0]),
    .en(\rckg/rckg_ovfl ),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_err [0]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg2_b1  (
    .clk(clk),
    .d(\rckg/n15 [1]),
    .en(\rckg/rckg_ovfl ),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_err [1]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg2_b2  (
    .clk(clk),
    .d(\rckg/n15 [2]),
    .en(\rckg/rckg_ovfl ),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_err [2]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg2_b3  (
    .clk(clk),
    .d(\rckg/n15 [3]),
    .en(\rckg/rckg_ovfl ),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_err [3]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg2_b4  (
    .clk(clk),
    .d(\rckg/n15 [4]),
    .en(\rckg/rckg_ovfl ),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_err [4]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg2_b5  (
    .clk(clk),
    .d(\rckg/n15 [5]),
    .en(\rckg/rckg_ovfl ),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_err [5]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg2_b6  (
    .clk(clk),
    .d(\rckg/n15 [6]),
    .en(\rckg/rckg_ovfl ),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_err [6]));  // rtl/rtc400_sys.v(493)
  reg_ar_as_w1 \rckg/reg3_b0  (
    .clk(clk),
    .d(clk32k),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_clk32k_s [0]));  // rtl/rtc400_sys.v(516)
  reg_ar_as_w1 \rckg/reg3_b1  (
    .clk(clk),
    .d(\rckg/rckg_clk32k_s [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_clk32k_s [1]));  // rtl/rtc400_sys.v(516)
  reg_ar_as_w1 \rckg/reg3_b2  (
    .clk(clk),
    .d(\rckg/rckg_clk32k_s [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_clk32k_s [2]));  // rtl/rtc400_sys.v(516)
  reg_ar_as_w1 \rckg/reg4_b0  (
    .clk(clk),
    .d(rtc_clkin),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_clkin_s [0]));  // rtl/rtc400_sys.v(420)
  reg_ar_as_w1 \rckg/reg4_b1  (
    .clk(clk),
    .d(\rckg/rckg_clkin_s [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_clkin_s [1]));  // rtl/rtc400_sys.v(420)
  reg_ar_as_w1 \rckg/reg4_b2  (
    .clk(clk),
    .d(\rckg/rckg_clkin_s [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rckg/rckg_clkin_s [2]));  // rtl/rtc400_sys.v(420)
  reg_sr_as_w1 \rctl/rd_rtcctl_reg  (
    .clk(clk),
    .d(\rctl/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rd_rtcctl ));  // rtl/rtc400_sys.v(219)
  reg_sr_as_w1 \rctl/rd_rtchrmi_reg  (
    .clk(clk),
    .d(\rctl/n12 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rd_rtchrmi ));  // rtl/rtc400_sys.v(219)
  reg_sr_as_w1 \rctl/rd_rtcintc_reg  (
    .clk(clk),
    .d(\rctl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rd_rtcintc ));  // rtl/rtc400_sys.v(219)
  reg_sr_as_w1 \rctl/rd_rtcmody_reg  (
    .clk(clk),
    .d(\rctl/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rd_rtcmody ));  // rtl/rtc400_sys.v(219)
  reg_sr_as_w1 \rctl/rd_rtcscps_reg  (
    .clk(clk),
    .d(\rctl/n14 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rd_rtcscps ));  // rtl/rtc400_sys.v(219)
  reg_sr_as_w1 \rctl/rd_rtcweek_reg  (
    .clk(clk),
    .d(\rctl/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rd_rtcweek ));  // rtl/rtc400_sys.v(219)
  reg_sr_as_w1 \rctl/rd_rtcyear_reg  (
    .clk(clk),
    .d(\rctl/n8 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rd_rtcyear ));  // rtl/rtc400_sys.v(219)
  reg_sr_as_w1 \rctl/reg0_b0  (
    .clk(clk),
    .d(\rctl/n35 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rctl_snap));  // rtl/rtc400_sys.v(244)
  reg_sr_as_w1 \rctl/reg0_b1  (
    .clk(clk),
    .d(\rctl/n35 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rtcctl [1]));  // rtl/rtc400_sys.v(244)
  reg_sr_as_w1 \rctl/reg0_b6  (
    .clk(clk),
    .d(\rctl/n35 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rctl_esel));  // rtl/rtc400_sys.v(244)
  reg_sr_as_w1 \rctl/reg1_b0  (
    .clk(clk),
    .d(\rctl/n43 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rtcintc [0]));  // rtl/rtc400_sys.v(260)
  reg_sr_as_w1 \rctl/reg1_b1  (
    .clk(clk),
    .d(\rctl/n43 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rtcintc [1]));  // rtl/rtc400_sys.v(260)
  reg_sr_as_w1 \rctl/reg1_b2  (
    .clk(clk),
    .d(\rctl/n43 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rtcintc [2]));  // rtl/rtc400_sys.v(260)
  reg_sr_as_w1 \rctl/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\rctl/wr_rtcintc ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rtcintc [4]));  // rtl/rtc400_sys.v(260)
  reg_sr_as_w1 \rctl/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\rctl/wr_rtcintc ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rtcintc [5]));  // rtl/rtc400_sys.v(260)
  reg_sr_as_w1 \rctl/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\rctl/wr_rtcintc ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rctl/rtcintc [6]));  // rtl/rtc400_sys.v(260)
  reg_ar_as_w1 \rctl/reg2_b0  (
    .clk(clk),
    .d(rsub_wrt_ack),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rctl/rsub_wrt_ack_s [0]));  // rtl/rtc400_sys.v(174)
  reg_ar_as_w1 \rctl/reg2_b1  (
    .clk(clk),
    .d(\rctl/rsub_wrt_ack_s [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rctl/rsub_wrt_ack_s [1]));  // rtl/rtc400_sys.v(174)
  reg_sr_as_w1 \rctl/rfsm/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\rctl/rfsm/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\rctl/rfsm/stat [0]));  // rtl/rtc_sys_fsm.v(65)
  reg_sr_as_w1 \rctl/rfsm/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\rctl/rfsm/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\rctl/rfsm/stat [1]));  // rtl/rtc_sys_fsm.v(65)
  reg_sr_as_w1 \rctl/rfsm/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\rctl/rfsm/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\rctl/rfsm/stat [2]));  // rtl/rtc_sys_fsm.v(65)
  reg_ar_ss_w1 \rdup/rdup_leap_reg  (
    .clk(clk),
    .d(rsub_reg[79]),
    .en(\rdup/n2 ),
    .reset(1'b0),
    .set(~rst_n),
    .q(rdup_leap));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/rdup_set_houf_reg  (
    .clk(clk),
    .d(\rdup/n3 ),
    .en(1'b1),
    .reset(~\rdup/u11_sel_is_2_o ),
    .set(1'b0),
    .q(rdup_set_houf));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/rdup_set_minf_reg  (
    .clk(clk),
    .d(\rdup/n4 ),
    .en(1'b1),
    .reset(~\rdup/u11_sel_is_2_o ),
    .set(1'b0),
    .q(rdup_set_minf));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/rdup_set_secf_reg  (
    .clk(clk),
    .d(\rdup/n5 ),
    .en(1'b1),
    .reset(~\rdup/u11_sel_is_2_o ),
    .set(1'b0),
    .q(rdup_set_secf));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b0  (
    .clk(clk),
    .d(\rdup/n20 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[64]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b1  (
    .clk(clk),
    .d(\rdup/n20 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[65]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b2  (
    .clk(clk),
    .d(\rdup/n20 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[66]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b3  (
    .clk(clk),
    .d(\rdup/n20 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[67]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b4  (
    .clk(clk),
    .d(\rdup/n20 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[68]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b5  (
    .clk(clk),
    .d(\rdup/n20 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[69]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b6  (
    .clk(clk),
    .d(\rdup/n20 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[70]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b7  (
    .clk(clk),
    .d(\rdup/n20 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[71]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b8  (
    .clk(clk),
    .d(\rdup/n20 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[72]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg0_b9  (
    .clk(clk),
    .d(\rdup/n20 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[73]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b0  (
    .clk(clk),
    .d(\rdup/n21 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[48]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b1  (
    .clk(clk),
    .d(\rdup/n21 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[49]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b10  (
    .clk(clk),
    .d(\rdup/n21 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[58]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b11  (
    .clk(clk),
    .d(\rdup/n21 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[59]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b12  (
    .clk(clk),
    .d(\rdup/n21 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[60]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b2  (
    .clk(clk),
    .d(\rdup/n21 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[50]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b3  (
    .clk(clk),
    .d(\rdup/n21 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[51]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b4  (
    .clk(clk),
    .d(\rdup/n21 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[52]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b5  (
    .clk(clk),
    .d(\rdup/n21 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[53]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b8  (
    .clk(clk),
    .d(\rdup/n21 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[56]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg1_b9  (
    .clk(clk),
    .d(\rdup/n21 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[57]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b0  (
    .clk(clk),
    .d(\rdup/n22 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[32]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b1  (
    .clk(clk),
    .d(\rdup/n22 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[33]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b10  (
    .clk(clk),
    .d(\rdup/n22 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[42]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b11  (
    .clk(clk),
    .d(\rdup/n22 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[43]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b12  (
    .clk(clk),
    .d(\rdup/n22 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[44]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b13  (
    .clk(clk),
    .d(\rdup/n22 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[45]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b2  (
    .clk(clk),
    .d(\rdup/n22 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[34]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b3  (
    .clk(clk),
    .d(\rdup/n22 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[35]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b4  (
    .clk(clk),
    .d(\rdup/n22 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[36]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b5  (
    .clk(clk),
    .d(\rdup/n22 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[37]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b6  (
    .clk(clk),
    .d(\rdup/n22 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[38]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b8  (
    .clk(clk),
    .d(\rdup/n22 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[40]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg2_b9  (
    .clk(clk),
    .d(\rdup/n22 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[41]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b0  (
    .clk(clk),
    .d(\rdup/n23 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[16]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b1  (
    .clk(clk),
    .d(\rdup/n23 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[17]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b10  (
    .clk(clk),
    .d(\rdup/n23 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[26]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b11  (
    .clk(clk),
    .d(\rdup/n23 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[27]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b12  (
    .clk(clk),
    .d(\rdup/n23 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[28]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b13  (
    .clk(clk),
    .d(\rdup/n23 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[29]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b14  (
    .clk(clk),
    .d(\rdup/n23 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[30]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b2  (
    .clk(clk),
    .d(\rdup/n23 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[18]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b3  (
    .clk(clk),
    .d(\rdup/n23 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[19]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b4  (
    .clk(clk),
    .d(\rdup/n23 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[20]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b5  (
    .clk(clk),
    .d(\rdup/n23 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[21]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b6  (
    .clk(clk),
    .d(\rdup/n23 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[22]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b7  (
    .clk(clk),
    .d(\rdup/n23 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[23]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b8  (
    .clk(clk),
    .d(\rdup/n23 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[24]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg3_b9  (
    .clk(clk),
    .d(\rdup/n23 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[25]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg4_b0  (
    .clk(clk),
    .d(\rdup/n24 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[0]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg4_b1  (
    .clk(clk),
    .d(\rdup/n24 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[1]));  // rtl/rtc400_sys.v(381)
  reg_sr_as_w1 \rdup/reg4_b2  (
    .clk(clk),
    .d(\rdup/n24 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rsys_reg[2]));  // rtl/rtc400_sys.v(381)

endmodule 

