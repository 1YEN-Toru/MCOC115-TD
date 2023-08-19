
`timescale 1ns / 1ps
module distus  // rtl/distus.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_dist_n,
  bdatw,
  brdy,
  clk,
  port_inp,
  rst_n,
  bdatr
  );
//
//	Distance measuring unit by ultrasonic sensor
//		(c) 2022	1YEN Toru
//
//
//	2022/09/03	ver.1.00
//

  input [3:0] badr;  // rtl/distus.v(20)
  input bcmdr;  // rtl/distus.v(18)
  input bcmdw;  // rtl/distus.v(17)
  input bcs_dist_n;  // rtl/distus.v(19)
  input [15:0] bdatw;  // rtl/distus.v(21)
  input brdy;  // rtl/distus.v(16)
  input clk;  // rtl/distus.v(14)
  input [15:0] port_inp;  // rtl/distus.v(22)
  input rst_n;  // rtl/distus.v(15)
  output [15:0] bdatr;  // rtl/distus.v(23)

  wire [19:0] \dcnt/n2 ;
  wire [2:0] \dctl/dfsm/stat ;  // rtl/dist_fsm.v(37)
  wire [2:0] \dctl/dfsm/stat_nx ;  // rtl/dist_fsm.v(38)
  wire [15:0] \dctl/n32 ;
  wire [15:0] \dctl/n34 ;
  wire [1:0] \dech/dech_echo_s ;  // rtl/distus.v(283)
  wire [19:0] distcnt;  // rtl/distus.v(37)
  wire [15:0] distecho;  // rtl/distus.v(36)
  wire [15:0] disttrig;  // rtl/distus.v(35)
  wire [1:0] \dtrg/dtrg_trig_s ;  // rtl/distus.v(236)
  wire _al_u32_o;
  wire _al_u33_o;
  wire _al_u34_o;
  wire _al_u35_o;
  wire _al_u36_o;
  wire _al_u37_o;
  wire _al_u38_o;
  wire _al_u39_o;
  wire _al_u41_o;
  wire _al_u42_o;
  wire _al_u43_o;
  wire _al_u44_o;
  wire _al_u45_o;
  wire _al_u46_o;
  wire _al_u47_o;
  wire _al_u48_o;
  wire _al_u52_o;
  wire _al_u62_o;
  wire _al_u63_o;
  wire _al_u65_o;
  wire _al_u67_o;
  wire _al_u69_o;
  wire _al_u71_o;
  wire _al_u73_o;
  wire _al_u75_o;
  wire _al_u77_o;
  wire _al_u79_o;
  wire _al_u81_o;
  wire _al_u83_o;
  wire _al_u85_o;
  wire _al_u87_o;
  wire _al_u89_o;
  wire _al_u90_o;
  wire _al_u91_o;
  wire _al_u92_o;
  wire _al_u93_o;
  wire _al_u94_o;
  wire _al_u95_o;
  wire _al_u97_o;
  wire \dcnt/add0/c0 ;
  wire \dcnt/add0/c1 ;
  wire \dcnt/add0/c10 ;
  wire \dcnt/add0/c11 ;
  wire \dcnt/add0/c12 ;
  wire \dcnt/add0/c13 ;
  wire \dcnt/add0/c14 ;
  wire \dcnt/add0/c15 ;
  wire \dcnt/add0/c16 ;
  wire \dcnt/add0/c17 ;
  wire \dcnt/add0/c18 ;
  wire \dcnt/add0/c19 ;
  wire \dcnt/add0/c2 ;
  wire \dcnt/add0/c3 ;
  wire \dcnt/add0/c4 ;
  wire \dcnt/add0/c5 ;
  wire \dcnt/add0/c6 ;
  wire \dcnt/add0/c7 ;
  wire \dcnt/add0/c8 ;
  wire \dcnt/add0/c9 ;
  wire \dcnt/n1 ;
  wire \dctl/dctl_busy ;  // rtl/distus.v(142)
  wire \dctl/dctl_err_set ;  // rtl/distus.v(145)
  wire \dctl/dctl_error ;  // rtl/distus.v(149)
  wire \dctl/dfsm/dctl_busy_t ;  // rtl/dist_fsm.v(33)
  wire \dctl/dfsm/mux0_b0_sel_is_3_o ;
  wire \dctl/dfsm/mux0_b1_sel_is_3_o ;
  wire \dctl/dfsm/stat_nx[2]_en ;
  wire \dctl/distcnth_rd ;  // rtl/distus.v(164)
  wire \dctl/distcntl_rd ;  // rtl/distus.v(165)
  wire \dctl/distctl_rd ;  // rtl/distus.v(161)
  wire \dctl/distecho_rd ;  // rtl/distus.v(163)
  wire \dctl/disttrig_rd ;  // rtl/distus.v(162)
  wire \dctl/n10_lutinv ;
  wire \dctl/n11 ;
  wire \dctl/n13 ;
  wire \dctl/n15 ;
  wire \dctl/n5 ;
  wire \dctl/n7 ;
  wire \dctl/n8_lutinv ;
  wire \dctl/n9 ;
  wire dctl_cnt_enb;  // rtl/distus.v(57)
  wire \dech/dech_echo_a ;  // rtl/distus.v(280)
  wire dech_echo;  // rtl/distus.v(48)
  wire distecho_wr;  // rtl/distus.v(55)
  wire disttrig_wr;  // rtl/distus.v(54)
  wire \dtrg/dtrg_trig_a ;  // rtl/distus.v(233)
  wire dtrg_trig;  // rtl/distus.v(47)

  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*B*C*D*~(E)+A*~(B)*C*~(D)*E+A*B*C*D*E)"),
    .INIT(32'h80208c20))
    _al_u100 (
    .a(_al_u94_o),
    .b(\dctl/dfsm/stat [0]),
    .c(\dctl/dfsm/stat [1]),
    .d(dech_echo),
    .e(dtrg_trig),
    .o(\dctl/dctl_err_set ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h7f1f701c))
    _al_u101 (
    .a(_al_u94_o),
    .b(\dctl/dfsm/stat [0]),
    .c(\dctl/dfsm/stat [1]),
    .d(dech_echo),
    .e(dtrg_trig),
    .o(\dctl/dfsm/dctl_busy_t ));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbf2fbc20))
    _al_u102 (
    .a(_al_u94_o),
    .b(\dctl/dfsm/stat [0]),
    .c(\dctl/dfsm/stat [1]),
    .d(dech_echo),
    .e(dtrg_trig),
    .o(\dctl/dfsm/stat_nx[2]_en ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u103 (
    .a(\dctl/dfsm/stat_nx[2]_en ),
    .b(rst_n),
    .o(\dcnt/n1 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u24 (
    .a(bcmdr),
    .b(bcs_dist_n),
    .o(\dctl/n5 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u25 (
    .a(\dctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\dctl/n7 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u26 (
    .a(\dctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\dctl/n13 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*~A)"),
    .INIT(16'h0004))
    _al_u27 (
    .a(badr[3]),
    .b(badr[2]),
    .c(badr[1]),
    .d(badr[0]),
    .o(\dctl/n10_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u28 (
    .a(\dctl/n10_lutinv ),
    .b(\dctl/n5 ),
    .o(\dctl/n11 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u29 (
    .a(\dctl/n5 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\dctl/n15 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u30 (
    .a(badr[3]),
    .b(badr[2]),
    .c(badr[1]),
    .d(badr[0]),
    .o(\dctl/n8_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u31 (
    .a(\dctl/n8_lutinv ),
    .b(\dctl/n5 ),
    .o(\dctl/n9 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u32 (
    .a(distecho[13]),
    .b(distecho[6]),
    .c(port_inp[13]),
    .d(port_inp[6]),
    .o(_al_u32_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u33 (
    .a(_al_u32_o),
    .b(distecho[2]),
    .c(distecho[9]),
    .d(port_inp[9]),
    .e(port_inp[2]),
    .o(_al_u33_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u34 (
    .a(distecho[11]),
    .b(distecho[14]),
    .c(port_inp[14]),
    .d(port_inp[11]),
    .o(_al_u34_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u35 (
    .a(_al_u34_o),
    .b(distecho[0]),
    .c(distecho[10]),
    .d(port_inp[10]),
    .e(port_inp[0]),
    .o(_al_u35_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u36 (
    .a(distecho[1]),
    .b(distecho[12]),
    .c(port_inp[12]),
    .d(port_inp[1]),
    .o(_al_u36_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u37 (
    .a(_al_u36_o),
    .b(distecho[3]),
    .c(distecho[4]),
    .d(port_inp[4]),
    .e(port_inp[3]),
    .o(_al_u37_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u38 (
    .a(distecho[15]),
    .b(distecho[8]),
    .c(port_inp[15]),
    .d(port_inp[8]),
    .o(_al_u38_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u39 (
    .a(_al_u38_o),
    .b(distecho[5]),
    .c(distecho[7]),
    .d(port_inp[7]),
    .e(port_inp[5]),
    .o(_al_u39_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u40 (
    .a(_al_u33_o),
    .b(_al_u35_o),
    .c(_al_u37_o),
    .d(_al_u39_o),
    .o(\dech/dech_echo_a ));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u41 (
    .a(disttrig[1]),
    .b(disttrig[9]),
    .c(port_inp[9]),
    .d(port_inp[1]),
    .o(_al_u41_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u42 (
    .a(_al_u41_o),
    .b(disttrig[2]),
    .c(disttrig[6]),
    .d(port_inp[6]),
    .e(port_inp[2]),
    .o(_al_u42_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u43 (
    .a(disttrig[14]),
    .b(disttrig[15]),
    .c(port_inp[15]),
    .d(port_inp[14]),
    .o(_al_u43_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u44 (
    .a(_al_u43_o),
    .b(disttrig[10]),
    .c(disttrig[3]),
    .d(port_inp[10]),
    .e(port_inp[3]),
    .o(_al_u44_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u45 (
    .a(disttrig[7]),
    .b(disttrig[8]),
    .c(port_inp[8]),
    .d(port_inp[7]),
    .o(_al_u45_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u46 (
    .a(_al_u45_o),
    .b(disttrig[0]),
    .c(disttrig[13]),
    .d(port_inp[13]),
    .e(port_inp[0]),
    .o(_al_u46_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u47 (
    .a(disttrig[12]),
    .b(disttrig[4]),
    .c(port_inp[12]),
    .d(port_inp[4]),
    .o(_al_u47_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u48 (
    .a(_al_u47_o),
    .b(disttrig[11]),
    .c(disttrig[5]),
    .d(port_inp[11]),
    .e(port_inp[5]),
    .o(_al_u48_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u49 (
    .a(_al_u42_o),
    .b(_al_u44_o),
    .c(_al_u46_o),
    .d(_al_u48_o),
    .o(\dtrg/dtrg_trig_a ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u50 (
    .a(\dctl/n10_lutinv ),
    .b(\dctl/dctl_busy ),
    .c(bcmdw),
    .d(bcs_dist_n),
    .o(distecho_wr));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u51 (
    .a(\dctl/n8_lutinv ),
    .b(\dctl/dctl_busy ),
    .c(bcmdw),
    .d(bcs_dist_n),
    .o(disttrig_wr));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u52 (
    .a(\dctl/dctl_busy ),
    .b(\dctl/distcnth_rd ),
    .c(\dctl/distcntl_rd ),
    .d(\dctl/distecho_rd ),
    .o(_al_u52_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*((E*B)*~(A)*~(D)+(E*B)*A*~(D)+~((E*B))*A*D+(E*B)*A*D))"),
    .INIT(32'h0a0c0a00))
    _al_u53 (
    .a(distcnt[19]),
    .b(distcnt[3]),
    .c(\dctl/dctl_busy ),
    .d(\dctl/distcnth_rd ),
    .e(\dctl/distcntl_rd ),
    .o(\dctl/n32 [3]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hfef20e02))
    _al_u54 (
    .a(\dctl/n32 [3]),
    .b(\dctl/distecho_rd ),
    .c(\dctl/disttrig_rd ),
    .d(distecho[3]),
    .e(disttrig[3]),
    .o(\dctl/n34 [3]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u55 (
    .a(\dctl/n34 [3]),
    .b(\dctl/distctl_rd ),
    .o(bdatr[3]));
  AL_MAP_LUT5 #(
    .EQN("(~C*((E*B)*~(A)*~(D)+(E*B)*A*~(D)+~((E*B))*A*D+(E*B)*A*D))"),
    .INIT(32'h0a0c0a00))
    _al_u56 (
    .a(distcnt[18]),
    .b(distcnt[2]),
    .c(\dctl/dctl_busy ),
    .d(\dctl/distcnth_rd ),
    .e(\dctl/distcntl_rd ),
    .o(\dctl/n32 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hfef20e02))
    _al_u57 (
    .a(\dctl/n32 [2]),
    .b(\dctl/distecho_rd ),
    .c(\dctl/disttrig_rd ),
    .d(distecho[2]),
    .e(disttrig[2]),
    .o(\dctl/n34 [2]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u58 (
    .a(\dctl/n34 [2]),
    .b(\dctl/distctl_rd ),
    .o(bdatr[2]));
  AL_MAP_LUT5 #(
    .EQN("(~C*((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h0c0a0c00))
    _al_u59 (
    .a(distcnt[1]),
    .b(distcnt[17]),
    .c(\dctl/dctl_busy ),
    .d(\dctl/distcnth_rd ),
    .e(\dctl/distcntl_rd ),
    .o(\dctl/n32 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hfef20e02))
    _al_u60 (
    .a(\dctl/n32 [1]),
    .b(\dctl/distecho_rd ),
    .c(\dctl/disttrig_rd ),
    .d(distecho[1]),
    .e(disttrig[1]),
    .o(\dctl/n34 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u61 (
    .a(\dctl/n34 [1]),
    .b(\dctl/dctl_error ),
    .c(\dctl/distctl_rd ),
    .o(bdatr[1]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~B*A)*~(E)*~(D)+(C*~B*A)*E*~(D)+~((C*~B*A))*E*D+(C*~B*A)*E*D)"),
    .INIT(32'h00dfffdf))
    _al_u62 (
    .a(distcnt[16]),
    .b(\dctl/dctl_busy ),
    .c(\dctl/distcnth_rd ),
    .d(\dctl/distecho_rd ),
    .e(distecho[0]),
    .o(_al_u62_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u63 (
    .a(_al_u62_o),
    .b(_al_u52_o),
    .c(distcnt[0]),
    .o(_al_u63_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*~(B)*~(C)+(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*B*~(C)+~((~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))*B*C+(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*B*C)"),
    .INIT(32'hcfc5c0c5))
    _al_u64 (
    .a(_al_u63_o),
    .b(\dctl/dctl_busy ),
    .c(\dctl/distctl_rd ),
    .d(\dctl/disttrig_rd ),
    .e(disttrig[0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u65 (
    .a(_al_u52_o),
    .b(distcnt[9]),
    .c(\dctl/distecho_rd ),
    .d(distecho[9]),
    .o(_al_u65_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u66 (
    .a(_al_u65_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[9]),
    .o(bdatr[9]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u67 (
    .a(_al_u52_o),
    .b(distcnt[8]),
    .c(\dctl/distecho_rd ),
    .d(distecho[8]),
    .o(_al_u67_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u68 (
    .a(_al_u67_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[8]),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u69 (
    .a(_al_u52_o),
    .b(distcnt[7]),
    .c(\dctl/distecho_rd ),
    .d(distecho[7]),
    .o(_al_u69_o));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hfdcd))
    _al_u70 (
    .a(_al_u69_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[7]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u71 (
    .a(_al_u52_o),
    .b(distcnt[6]),
    .c(\dctl/distecho_rd ),
    .d(distecho[6]),
    .o(_al_u71_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u72 (
    .a(_al_u71_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u73 (
    .a(_al_u52_o),
    .b(distcnt[5]),
    .c(\dctl/distecho_rd ),
    .d(distecho[5]),
    .o(_al_u73_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u74 (
    .a(_al_u73_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[5]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u75 (
    .a(_al_u52_o),
    .b(distcnt[4]),
    .c(\dctl/distecho_rd ),
    .d(distecho[4]),
    .o(_al_u75_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u76 (
    .a(_al_u75_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[4]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u77 (
    .a(_al_u52_o),
    .b(distcnt[15]),
    .c(\dctl/distecho_rd ),
    .d(distecho[15]),
    .o(_al_u77_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u78 (
    .a(_al_u77_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[15]),
    .o(bdatr[15]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u79 (
    .a(_al_u52_o),
    .b(distcnt[14]),
    .c(\dctl/distecho_rd ),
    .d(distecho[14]),
    .o(_al_u79_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u80 (
    .a(_al_u79_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[14]),
    .o(bdatr[14]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u81 (
    .a(_al_u52_o),
    .b(distcnt[13]),
    .c(\dctl/distecho_rd ),
    .d(distecho[13]),
    .o(_al_u81_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u82 (
    .a(_al_u81_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[13]),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u83 (
    .a(_al_u52_o),
    .b(distcnt[12]),
    .c(\dctl/distecho_rd ),
    .d(distecho[12]),
    .o(_al_u83_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u84 (
    .a(_al_u83_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[12]),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u85 (
    .a(_al_u52_o),
    .b(distcnt[11]),
    .c(\dctl/distecho_rd ),
    .d(distecho[11]),
    .o(_al_u85_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u86 (
    .a(_al_u85_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[11]),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u87 (
    .a(_al_u52_o),
    .b(distcnt[10]),
    .c(\dctl/distecho_rd ),
    .d(distecho[10]),
    .o(_al_u87_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u88 (
    .a(_al_u87_o),
    .b(\dctl/distctl_rd ),
    .c(\dctl/disttrig_rd ),
    .d(disttrig[10]),
    .o(bdatr[10]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u89 (
    .a(distcnt[12]),
    .b(distcnt[13]),
    .c(distcnt[14]),
    .d(distcnt[15]),
    .o(_al_u89_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u90 (
    .a(distcnt[16]),
    .b(distcnt[17]),
    .c(distcnt[18]),
    .d(distcnt[19]),
    .o(_al_u90_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u91 (
    .a(distcnt[2]),
    .b(distcnt[3]),
    .c(distcnt[4]),
    .d(distcnt[5]),
    .o(_al_u91_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u92 (
    .a(_al_u90_o),
    .b(distcnt[6]),
    .c(distcnt[7]),
    .d(distcnt[8]),
    .e(distcnt[9]),
    .o(_al_u92_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u93 (
    .a(_al_u92_o),
    .b(_al_u89_o),
    .c(distcnt[0]),
    .d(distcnt[11]),
    .o(_al_u93_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u94 (
    .a(_al_u93_o),
    .b(_al_u91_o),
    .c(distcnt[1]),
    .d(distcnt[10]),
    .o(_al_u94_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((D*~(B*A)))*~(C)+E*(D*~(B*A))*~(C)+~(E)*(D*~(B*A))*C+E*(D*~(B*A))*C)"),
    .INIT(32'h80f08fff))
    _al_u95 (
    .a(_al_u94_o),
    .b(\dctl/dfsm/stat [0]),
    .c(\dctl/dfsm/stat [1]),
    .d(dech_echo),
    .e(dtrg_trig),
    .o(_al_u95_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u96 (
    .a(_al_u95_o),
    .b(rst_n),
    .o(\dctl/dfsm/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*B*C*D*E)"),
    .INIT(32'h8fef8fe3))
    _al_u97 (
    .a(_al_u94_o),
    .b(\dctl/dfsm/stat [0]),
    .c(\dctl/dfsm/stat [1]),
    .d(dech_echo),
    .e(dtrg_trig),
    .o(_al_u97_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u98 (
    .a(_al_u97_o),
    .b(rst_n),
    .o(\dctl/dfsm/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(~D*C*B))"),
    .INIT(16'h55d5))
    _al_u99 (
    .a(_al_u97_o),
    .b(\dctl/dfsm/stat [0]),
    .c(\dctl/dfsm/stat [1]),
    .d(dech_echo),
    .o(dctl_cnt_enb));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u0  (
    .a(distcnt[0]),
    .b(1'b1),
    .c(\dcnt/add0/c0 ),
    .o({\dcnt/add0/c1 ,\dcnt/n2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u1  (
    .a(distcnt[1]),
    .b(1'b0),
    .c(\dcnt/add0/c1 ),
    .o({\dcnt/add0/c2 ,\dcnt/n2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u10  (
    .a(distcnt[10]),
    .b(1'b0),
    .c(\dcnt/add0/c10 ),
    .o({\dcnt/add0/c11 ,\dcnt/n2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u11  (
    .a(distcnt[11]),
    .b(1'b0),
    .c(\dcnt/add0/c11 ),
    .o({\dcnt/add0/c12 ,\dcnt/n2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u12  (
    .a(distcnt[12]),
    .b(1'b0),
    .c(\dcnt/add0/c12 ),
    .o({\dcnt/add0/c13 ,\dcnt/n2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u13  (
    .a(distcnt[13]),
    .b(1'b0),
    .c(\dcnt/add0/c13 ),
    .o({\dcnt/add0/c14 ,\dcnt/n2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u14  (
    .a(distcnt[14]),
    .b(1'b0),
    .c(\dcnt/add0/c14 ),
    .o({\dcnt/add0/c15 ,\dcnt/n2 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u15  (
    .a(distcnt[15]),
    .b(1'b0),
    .c(\dcnt/add0/c15 ),
    .o({\dcnt/add0/c16 ,\dcnt/n2 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u16  (
    .a(distcnt[16]),
    .b(1'b0),
    .c(\dcnt/add0/c16 ),
    .o({\dcnt/add0/c17 ,\dcnt/n2 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u17  (
    .a(distcnt[17]),
    .b(1'b0),
    .c(\dcnt/add0/c17 ),
    .o({\dcnt/add0/c18 ,\dcnt/n2 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u18  (
    .a(distcnt[18]),
    .b(1'b0),
    .c(\dcnt/add0/c18 ),
    .o({\dcnt/add0/c19 ,\dcnt/n2 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u19  (
    .a(distcnt[19]),
    .b(1'b0),
    .c(\dcnt/add0/c19 ),
    .o({open_n0,\dcnt/n2 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u2  (
    .a(distcnt[2]),
    .b(1'b0),
    .c(\dcnt/add0/c2 ),
    .o({\dcnt/add0/c3 ,\dcnt/n2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u3  (
    .a(distcnt[3]),
    .b(1'b0),
    .c(\dcnt/add0/c3 ),
    .o({\dcnt/add0/c4 ,\dcnt/n2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u4  (
    .a(distcnt[4]),
    .b(1'b0),
    .c(\dcnt/add0/c4 ),
    .o({\dcnt/add0/c5 ,\dcnt/n2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u5  (
    .a(distcnt[5]),
    .b(1'b0),
    .c(\dcnt/add0/c5 ),
    .o({\dcnt/add0/c6 ,\dcnt/n2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u6  (
    .a(distcnt[6]),
    .b(1'b0),
    .c(\dcnt/add0/c6 ),
    .o({\dcnt/add0/c7 ,\dcnt/n2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u7  (
    .a(distcnt[7]),
    .b(1'b0),
    .c(\dcnt/add0/c7 ),
    .o({\dcnt/add0/c8 ,\dcnt/n2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u8  (
    .a(distcnt[8]),
    .b(1'b0),
    .c(\dcnt/add0/c8 ),
    .o({\dcnt/add0/c9 ,\dcnt/n2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \dcnt/add0/u9  (
    .a(distcnt[9]),
    .b(1'b0),
    .c(\dcnt/add0/c9 ),
    .o({\dcnt/add0/c10 ,\dcnt/n2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \dcnt/add0/ucin  (
    .a(1'b0),
    .o({\dcnt/add0/c0 ,open_n3}));
  reg_sr_as_w1 \dcnt/reg0_b0  (
    .clk(clk),
    .d(\dcnt/n2 [0]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[0]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b1  (
    .clk(clk),
    .d(\dcnt/n2 [1]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[1]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b10  (
    .clk(clk),
    .d(\dcnt/n2 [10]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[10]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b11  (
    .clk(clk),
    .d(\dcnt/n2 [11]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[11]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b12  (
    .clk(clk),
    .d(\dcnt/n2 [12]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[12]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b13  (
    .clk(clk),
    .d(\dcnt/n2 [13]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[13]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b14  (
    .clk(clk),
    .d(\dcnt/n2 [14]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[14]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b15  (
    .clk(clk),
    .d(\dcnt/n2 [15]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[15]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b16  (
    .clk(clk),
    .d(\dcnt/n2 [16]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[16]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b17  (
    .clk(clk),
    .d(\dcnt/n2 [17]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[17]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b18  (
    .clk(clk),
    .d(\dcnt/n2 [18]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[18]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b19  (
    .clk(clk),
    .d(\dcnt/n2 [19]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[19]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b2  (
    .clk(clk),
    .d(\dcnt/n2 [2]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[2]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b3  (
    .clk(clk),
    .d(\dcnt/n2 [3]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[3]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b4  (
    .clk(clk),
    .d(\dcnt/n2 [4]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[4]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b5  (
    .clk(clk),
    .d(\dcnt/n2 [5]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[5]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b6  (
    .clk(clk),
    .d(\dcnt/n2 [6]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[6]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b7  (
    .clk(clk),
    .d(\dcnt/n2 [7]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[7]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b8  (
    .clk(clk),
    .d(\dcnt/n2 [8]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[8]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dcnt/reg0_b9  (
    .clk(clk),
    .d(\dcnt/n2 [9]),
    .en(dctl_cnt_enb),
    .reset(\dcnt/n1 ),
    .set(1'b0),
    .q(distcnt[9]));  // rtl/distus.v(322)
  reg_sr_as_w1 \dctl/dctl_error_reg  (
    .clk(clk),
    .d(\dctl/dctl_err_set ),
    .en(\dctl/dfsm/stat_nx[2]_en ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/dctl_error ));  // rtl/distus.v(158)
  reg_sr_as_w1 \dctl/dfsm/dctl_busy_reg  (
    .clk(clk),
    .d(\dctl/dfsm/dctl_busy_t ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/dctl_busy ));  // rtl/dist_fsm.v(66)
  reg_sr_as_w1 \dctl/dfsm/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\dctl/dfsm/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\dctl/dfsm/stat [0]));  // rtl/dist_fsm.v(74)
  reg_sr_as_w1 \dctl/dfsm/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\dctl/dfsm/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\dctl/dfsm/stat [1]));  // rtl/dist_fsm.v(74)
  reg_sr_as_w1 \dctl/distcnth_rd_reg  (
    .clk(clk),
    .d(\dctl/n13 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/distcnth_rd ));  // rtl/distus.v(184)
  reg_sr_as_w1 \dctl/distcntl_rd_reg  (
    .clk(clk),
    .d(\dctl/n15 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/distcntl_rd ));  // rtl/distus.v(184)
  reg_sr_as_w1 \dctl/distctl_rd_reg  (
    .clk(clk),
    .d(\dctl/n7 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/distctl_rd ));  // rtl/distus.v(184)
  reg_sr_as_w1 \dctl/distecho_rd_reg  (
    .clk(clk),
    .d(\dctl/n11 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/distecho_rd ));  // rtl/distus.v(184)
  reg_sr_as_w1 \dctl/disttrig_rd_reg  (
    .clk(clk),
    .d(\dctl/n9 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dctl/disttrig_rd ));  // rtl/distus.v(184)
  reg_sr_as_w1 \dech/reg0_b0  (
    .clk(clk),
    .d(\dech/dech_echo_a ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dech/dech_echo_s [0]));  // rtl/distus.v(290)
  reg_sr_as_w1 \dech/reg0_b1  (
    .clk(clk),
    .d(\dech/dech_echo_s [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(dech_echo));  // rtl/distus.v(290)
  reg_sr_as_w1 \dech/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[0]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[1]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[10]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[11]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[12]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[13]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[14]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[15]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[2]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[3]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[4]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[5]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[6]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[7]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[8]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dech/reg1_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(distecho_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(distecho[9]));  // rtl/distus.v(277)
  reg_sr_as_w1 \dtrg/reg0_b0  (
    .clk(clk),
    .d(\dtrg/dtrg_trig_a ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\dtrg/dtrg_trig_s [0]));  // rtl/distus.v(243)
  reg_sr_as_w1 \dtrg/reg0_b1  (
    .clk(clk),
    .d(\dtrg/dtrg_trig_s [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(dtrg_trig));  // rtl/distus.v(243)
  reg_sr_as_w1 \dtrg/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[0]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[1]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[10]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[11]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[12]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[13]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[14]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[15]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[2]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[3]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[4]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[5]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[6]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[7]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[8]));  // rtl/distus.v(230)
  reg_sr_as_w1 \dtrg/reg1_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(disttrig_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(disttrig[9]));  // rtl/distus.v(230)

endmodule 

