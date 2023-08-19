
`timescale 1ns / 1ps
module adc124  // rtl/adc124.v(1)
  (
  afe_dout,
  afe_eoc,
  badr,
  bcmdr,
  bcmdw,
  bcs_adcu_n,
  bdatw,
  brdy,
  clk,
  clk16m,
  pll_extlock,
  rst_n,
  adc_adce,
  adc_cenr,
  adc_chnl,
  adc_soc,
  bdatr
  );
//
// 12 bit A/D converter unit
//		(c) 2021	1YEN Toru
//
//
//	2022/01/29	ver.1.00
//		12 bit SAR ADC, 4 channel
//

  input [11:0] afe_dout;  // rtl/adc124.v(36)
  input afe_eoc;  // rtl/adc124.v(35)
  input [3:0] badr;  // rtl/adc124.v(30)
  input bcmdr;  // rtl/adc124.v(27)
  input bcmdw;  // rtl/adc124.v(26)
  input bcs_adcu_n;  // rtl/adc124.v(28)
  input [15:0] bdatw;  // rtl/adc124.v(31)
  input brdy;  // rtl/adc124.v(25)
  input clk;  // rtl/adc124.v(22)
  input clk16m;  // rtl/adc124.v(23)
  input pll_extlock;  // rtl/adc124.v(29)
  input rst_n;  // rtl/adc124.v(24)
  output adc_adce;  // rtl/adc124.v(37)
  output adc_cenr;  // rtl/adc124.v(32)
  output [1:0] adc_chnl;  // rtl/adc124.v(39)
  output adc_soc;  // rtl/adc124.v(38)
  output [15:0] bdatr;  // rtl/adc124.v(33)

  wire [7:0] \actl/adcint ;  // rtl/adc124.v(242)
  wire [7:0] \actl/n41 ;
  wire [11:0] \actl/n50 ;
  wire [15:0] \actl/n52 ;
  wire [15:0] \actl/n53 ;
  wire [3:0] actl_csel;  // rtl/adc124.v(53)
  wire [15:0] actl_peri;  // rtl/adc124.v(60)
  wire [3:0] \adat/n27 ;
  wire [3:0] adat_cenf;  // rtl/adc124.v(54)
  wire [11:0] adat_dat0;  // rtl/adc124.v(56)
  wire [11:0] adat_dat1;  // rtl/adc124.v(57)
  wire [11:0] adat_dat2;  // rtl/adc124.v(58)
  wire [11:0] adat_dat3;  // rtl/adc124.v(59)
  wire [1:0] \afeif/a16_cenb_s ;  // rtl/adc124.v(340)
  wire [3:0] \afeif/a16_csel_s0 ;  // rtl/adc124.v(343)
  wire [3:0] \afeif/a16_csel_s1 ;  // rtl/adc124.v(342)
  wire [1:0] \afeif/a16_data_ack_s ;  // rtl/adc124.v(341)
  wire [1:0] \afeif/aif_ardy_s ;  // rtl/adc124.v(368)
  wire [1:0] \afeif/aif_cenb_clr_s ;  // rtl/adc124.v(366)
  wire [1:0] \afeif/aif_data_lat_s ;  // rtl/adc124.v(367)
  wire [1:0] \afeif/fsm/chnl ;  // rtl/adc_aif_fsm.v(51)
  wire [3:0] \afeif/fsm/stat ;  // rtl/adc_aif_fsm.v(53)
  wire [3:0] \afeif/fsm/stat_nx ;  // rtl/adc_aif_fsm.v(54)
  wire [1:0] \afeif/n1 ;
  wire [15:0] \afeif/pcnt ;  // rtl/adc124.v(391)
  wire [15:0] \afeif/pcnt_nx ;  // rtl/adc124.v(393)
  wire [7:0] \afeif/pcnt_psc ;  // rtl/adc124.v(390)
  wire [7:0] \afeif/pcnt_psc_nx ;  // rtl/adc124.v(392)
  wire [1:0] \afeif/rst16m_n_s ;  // rtl/adc124.v(325)
  wire [1:0] aif_chnl;  // rtl/adc124.v(52)
  wire [11:0] aif_dout;  // rtl/adc124.v(55)
  wire _al_u102_o;
  wire _al_u106_o;
  wire _al_u107_o;
  wire _al_u115_o;
  wire _al_u116_o;
  wire _al_u117_o;
  wire _al_u118_o;
  wire _al_u119_o;
  wire _al_u120_o;
  wire _al_u121_o;
  wire _al_u125_o;
  wire _al_u126_o;
  wire _al_u127_o;
  wire _al_u128_o;
  wire _al_u129_o;
  wire _al_u131_o;
  wire _al_u132_o;
  wire _al_u133_o;
  wire _al_u134_o;
  wire _al_u136_o;
  wire _al_u139_o;
  wire _al_u140_o;
  wire _al_u141_o;
  wire _al_u142_o;
  wire _al_u143_o;
  wire _al_u145_o;
  wire _al_u148_o;
  wire _al_u150_o;
  wire _al_u36_o;
  wire _al_u38_o;
  wire _al_u56_o;
  wire _al_u57_o;
  wire _al_u59_o;
  wire _al_u60_o;
  wire _al_u62_o;
  wire _al_u63_o;
  wire _al_u65_o;
  wire _al_u66_o;
  wire _al_u69_o;
  wire _al_u73_o;
  wire _al_u75_o;
  wire _al_u78_o;
  wire _al_u82_o;
  wire _al_u86_o;
  wire _al_u90_o;
  wire _al_u94_o;
  wire _al_u98_o;
  wire _al_u99_o;
  wire \actl/aif_cenb_clr_f ;  // rtl/adc124.v(215)
  wire \actl/n10 ;
  wire \actl/n12 ;
  wire \actl/n14 ;
  wire \actl/n16 ;
  wire \actl/n2 ;
  wire \actl/n32 ;
  wire \actl/n35 ;
  wire \actl/n39 ;
  wire \actl/n4 ;
  wire \actl/n6 ;
  wire \actl/n8 ;
  wire \actl/rd_adcctl ;  // rtl/adc124.v(177)
  wire \actl/rd_adcdat0 ;  // rtl/adc124.v(180)
  wire \actl/rd_adcdat1 ;  // rtl/adc124.v(181)
  wire \actl/rd_adcdat2 ;  // rtl/adc124.v(182)
  wire \actl/rd_adcdat3 ;  // rtl/adc124.v(183)
  wire \actl/rd_adcint ;  // rtl/adc124.v(178)
  wire \actl/rd_adcperi ;  // rtl/adc124.v(179)
  wire \actl/wr_adcctl ;  // rtl/adc124.v(209)
  wire \actl/wr_adcperi ;  // rtl/adc124.v(211)
  wire actl_cenb;  // rtl/adc124.v(82)
  wire \adat/mux4_b0_sel_is_3_o ;
  wire \adat/mux5_b1_sel_is_3_o ;
  wire \adat/mux5_b2_sel_is_3_o ;
  wire \adat/mux5_b3_sel_is_3_o ;
  wire adat_data_ack;  // rtl/adc124.v(96)
  wire \afeif/a16_cenb_clr ;  // rtl/adc124.v(449)
  wire \afeif/a16_data_lat ;  // rtl/adc124.v(320)
  wire \afeif/a16_pcnt_ack_lutinv ;  // rtl/adc124.v(450)
  wire \afeif/a16_pcnt_ovf ;  // rtl/adc124.v(389)
  wire \afeif/a16_pcnt_ovf_d ;
  wire \afeif/a16_pcnt_upd ;  // rtl/adc124.v(395)
  wire \afeif/add0/c0 ;
  wire \afeif/add0/c1 ;
  wire \afeif/add0/c2 ;
  wire \afeif/add0/c3 ;
  wire \afeif/add0/c4 ;
  wire \afeif/add0/c5 ;
  wire \afeif/add0/c6 ;
  wire \afeif/add0/c7 ;
  wire \afeif/add1/c0 ;
  wire \afeif/add1/c1 ;
  wire \afeif/add1/c10 ;
  wire \afeif/add1/c11 ;
  wire \afeif/add1/c12 ;
  wire \afeif/add1/c13 ;
  wire \afeif/add1/c14 ;
  wire \afeif/add1/c15 ;
  wire \afeif/add1/c2 ;
  wire \afeif/add1/c3 ;
  wire \afeif/add1/c4 ;
  wire \afeif/add1/c5 ;
  wire \afeif/add1/c6 ;
  wire \afeif/add1/c7 ;
  wire \afeif/add1/c8 ;
  wire \afeif/add1/c9 ;
  wire \afeif/fsm/mux0_b0_sel_is_3_o ;
  wire \afeif/fsm/mux0_b1_sel_is_3_o ;
  wire \afeif/fsm/mux0_b2_sel_is_3_o ;
  wire \afeif/fsm/n21_lutinv ;
  wire \afeif/fsm/n229 ;
  wire \afeif/fsm/n229_neg ;
  wire \afeif/fsm/n36_lutinv ;
  wire \afeif/fsm/n46_lutinv ;
  wire \afeif/fsm/stat_nx[3]_en ;
  wire \afeif/n11 ;
  wire \afeif/n13 ;
  wire \afeif/n14 ;
  wire \afeif/n17 ;
  wire aif_ardy;  // rtl/adc124.v(70)
  wire aif_cenb_clr;  // rtl/adc124.v(71)
  wire aif_data_lat;  // rtl/adc124.v(92)
  wire wr_adcint;  // rtl/adc124.v(81)

  assign bdatr[15] = 1'b0;
  assign bdatr[14] = 1'b0;
  assign bdatr[13] = 1'b0;
  assign bdatr[12] = 1'b0;
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'hfd0df101))
    _al_u100 (
    .a(_al_u99_o),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[5]),
    .e(adat_dat0[5]),
    .o(\actl/n52 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u101 (
    .a(\actl/n52 [5]),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(adat_cenf[1]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u102 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[6]),
    .d(adat_dat3[6]),
    .o(_al_u102_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u103 (
    .a(_al_u102_o),
    .b(\actl/rd_adcdat1 ),
    .c(adat_dat1[6]),
    .o(\actl/n50 [6]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u104 (
    .a(\actl/n50 [6]),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[6]),
    .e(adat_dat0[6]),
    .o(\actl/n52 [6]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u105 (
    .a(\actl/n52 [6]),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(adc_adce),
    .e(adat_cenf[2]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u106 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[7]),
    .d(adat_dat3[7]),
    .o(_al_u106_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u107 (
    .a(_al_u106_o),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcdat1 ),
    .d(adat_dat0[7]),
    .e(adat_dat1[7]),
    .o(_al_u107_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u108 (
    .a(_al_u107_o),
    .b(\actl/rd_adcint ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[7]),
    .e(adat_cenf[3]),
    .o(\actl/n53 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*C))*~(B)+A*(D*C)*~(B)+~(A)*(D*C)*B+A*(D*C)*B)"),
    .INIT(16'he222))
    _al_u109 (
    .a(\actl/n53 [7]),
    .b(\actl/rd_adcctl ),
    .c(adc_adce),
    .d(aif_ardy),
    .o(bdatr[7]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*(~(A)*~(B)*~(D)+A*~(B)*~(D)+A*B*D))"),
    .INIT(32'h08030000))
    _al_u110 (
    .a(\afeif/a16_pcnt_ovf ),
    .b(\afeif/fsm/stat [0]),
    .c(\afeif/fsm/stat [1]),
    .d(\afeif/fsm/stat [2]),
    .e(\afeif/a16_cenb_s [1]),
    .o(\afeif/a16_pcnt_ack_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*A)"),
    .INIT(4'hd))
    _al_u111 (
    .a(_al_u75_o),
    .b(\afeif/a16_pcnt_ack_lutinv ),
    .o(\afeif/n17 ));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h54f400a0))
    _al_u112 (
    .a(wr_adcint),
    .b(\adat/mux5_b1_sel_is_3_o ),
    .c(adat_cenf[1]),
    .d(bdatw[5]),
    .e(rst_n),
    .o(\adat/n27 [1]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h54f400a0))
    _al_u113 (
    .a(wr_adcint),
    .b(\adat/mux5_b3_sel_is_3_o ),
    .c(adat_cenf[3]),
    .d(bdatw[7]),
    .e(rst_n),
    .o(\adat/n27 [3]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h54f400a0))
    _al_u114 (
    .a(wr_adcint),
    .b(\adat/mux5_b2_sel_is_3_o ),
    .c(adat_cenf[2]),
    .d(bdatw[6]),
    .e(rst_n),
    .o(\adat/n27 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u115 (
    .a(\afeif/pcnt_nx [3]),
    .b(\afeif/pcnt_nx [2]),
    .c(actl_peri[2]),
    .d(actl_peri[3]),
    .o(_al_u115_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u116 (
    .a(_al_u115_o),
    .b(\afeif/pcnt_nx [5]),
    .c(\afeif/pcnt_nx [4]),
    .d(actl_peri[4]),
    .e(actl_peri[5]),
    .o(_al_u116_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u117 (
    .a(\afeif/pcnt_nx [14]),
    .b(\afeif/pcnt_nx [12]),
    .c(\afeif/pcnt_nx [11]),
    .d(\afeif/pcnt_nx [9]),
    .o(_al_u117_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u118 (
    .a(\afeif/pcnt_nx [15]),
    .b(\afeif/pcnt_nx [13]),
    .c(\afeif/pcnt_nx [10]),
    .d(\afeif/pcnt_nx [8]),
    .o(_al_u118_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C@B))"),
    .INIT(8'h82))
    _al_u119 (
    .a(_al_u118_o),
    .b(\afeif/pcnt_nx [0]),
    .c(actl_peri[0]),
    .o(_al_u119_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D@C))"),
    .INIT(16'h8008))
    _al_u120 (
    .a(_al_u119_o),
    .b(_al_u117_o),
    .c(\afeif/pcnt_nx [1]),
    .d(actl_peri[1]),
    .o(_al_u120_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D@C))"),
    .INIT(16'h8008))
    _al_u121 (
    .a(_al_u120_o),
    .b(\afeif/a16_pcnt_upd ),
    .c(\afeif/pcnt_nx [7]),
    .d(actl_peri[7]),
    .o(_al_u121_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D@C))"),
    .INIT(16'h8008))
    _al_u122 (
    .a(_al_u121_o),
    .b(_al_u116_o),
    .c(\afeif/pcnt_nx [6]),
    .d(actl_peri[6]),
    .o(\afeif/n13 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u123 (
    .a(\afeif/n13 ),
    .b(_al_u75_o),
    .o(\afeif/n14 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u124 (
    .a(\afeif/n13 ),
    .b(\afeif/a16_pcnt_ovf ),
    .o(\afeif/a16_pcnt_ovf_d ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u125 (
    .a(\afeif/fsm/chnl [0]),
    .b(\afeif/a16_cenb_s [1]),
    .c(\afeif/a16_csel_s1 [3]),
    .o(_al_u125_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u126 (
    .a(_al_u38_o),
    .b(\afeif/fsm/chnl [1]),
    .c(\afeif/fsm/stat [0]),
    .o(_al_u126_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u127 (
    .a(\afeif/fsm/chnl [0]),
    .b(\afeif/a16_cenb_s [1]),
    .c(\afeif/a16_csel_s1 [2]),
    .d(\afeif/a16_csel_s1 [3]),
    .o(_al_u127_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(32'h3f5fffff))
    _al_u128 (
    .a(_al_u127_o),
    .b(_al_u125_o),
    .c(_al_u38_o),
    .d(\afeif/fsm/chnl [1]),
    .e(\afeif/fsm/stat [0]),
    .o(_al_u128_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u129 (
    .a(\afeif/a16_csel_s1 [1]),
    .b(\afeif/a16_csel_s1 [2]),
    .o(_al_u129_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u130 (
    .a(_al_u126_o),
    .b(_al_u125_o),
    .c(_al_u129_o),
    .o(\afeif/fsm/n46_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*C*A*~(D*~B))"),
    .INIT(32'h80a00000))
    _al_u131 (
    .a(_al_u126_o),
    .b(\afeif/fsm/chnl [0]),
    .c(\afeif/a16_cenb_s [1]),
    .d(\afeif/a16_csel_s1 [1]),
    .e(\afeif/a16_csel_s1 [2]),
    .o(_al_u131_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u132 (
    .a(\afeif/fsm/n46_lutinv ),
    .b(_al_u131_o),
    .c(_al_u128_o),
    .o(_al_u132_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u133 (
    .a(\afeif/fsm/stat [0]),
    .b(\afeif/fsm/stat [1]),
    .c(\afeif/fsm/stat [2]),
    .o(_al_u133_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u134 (
    .a(_al_u133_o),
    .b(\afeif/a16_csel_s1 [0]),
    .c(\afeif/a16_csel_s1 [1]),
    .o(_al_u134_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u135 (
    .a(_al_u126_o),
    .b(\afeif/fsm/chnl [0]),
    .c(\afeif/a16_cenb_s [1]),
    .d(\afeif/a16_csel_s1 [1]),
    .o(\afeif/fsm/n36_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*~C*B))"),
    .INIT(16'h5155))
    _al_u136 (
    .a(\afeif/fsm/n36_lutinv ),
    .b(_al_u134_o),
    .c(\afeif/a16_csel_s1 [2]),
    .d(\afeif/a16_csel_s1 [3]),
    .o(_al_u136_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*A*~(C*~(~E*D)))"),
    .INIT(32'hf7f777f7))
    _al_u137 (
    .a(_al_u132_o),
    .b(_al_u136_o),
    .c(_al_u133_o),
    .d(_al_u129_o),
    .e(\afeif/a16_csel_s1 [0]),
    .o(adc_soc));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~A*~(~C*B)))"),
    .INIT(16'hae00))
    _al_u138 (
    .a(adc_soc),
    .b(_al_u38_o),
    .c(\afeif/fsm/stat [0]),
    .d(\afeif/rst16m_n_s [1]),
    .o(\afeif/fsm/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u139 (
    .a(_al_u134_o),
    .b(_al_u126_o),
    .c(\afeif/fsm/chnl [0]),
    .d(\afeif/a16_cenb_s [1]),
    .o(_al_u139_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*A*~(~D*~(~C*B)))"),
    .INIT(32'h55f7ffff))
    _al_u140 (
    .a(_al_u38_o),
    .b(_al_u129_o),
    .c(\afeif/fsm/chnl [0]),
    .d(\afeif/fsm/chnl [1]),
    .e(\afeif/fsm/stat [0]),
    .o(_al_u140_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u141 (
    .a(\afeif/fsm/chnl [0]),
    .b(\afeif/a16_cenb_s [1]),
    .c(\afeif/a16_csel_s1 [3]),
    .o(_al_u141_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~B)*~(~E*~D*~A))"),
    .INIT(32'hcfcfcf8a))
    _al_u142 (
    .a(_al_u139_o),
    .b(_al_u140_o),
    .c(_al_u141_o),
    .d(\afeif/a16_csel_s1 [2]),
    .e(\afeif/a16_csel_s1 [3]),
    .o(_al_u142_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u143 (
    .a(\afeif/fsm/stat [1]),
    .b(\afeif/fsm/stat [2]),
    .c(\afeif/a16_cenb_s [1]),
    .o(_al_u143_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(~D*C)*~(B*~A))"),
    .INIT(16'h44f4))
    _al_u144 (
    .a(_al_u142_o),
    .b(\afeif/fsm/n21_lutinv ),
    .c(_al_u143_o),
    .d(\afeif/fsm/stat [0]),
    .o(\afeif/a16_cenb_clr ));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~D*C)*~(~B*~A))"),
    .INIT(32'hee0eeeee))
    _al_u145 (
    .a(_al_u142_o),
    .b(\afeif/fsm/n21_lutinv ),
    .c(_al_u143_o),
    .d(\afeif/a16_pcnt_ovf ),
    .e(\afeif/fsm/stat [0]),
    .o(_al_u145_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*~A))"),
    .INIT(8'hb0))
    _al_u146 (
    .a(\afeif/a16_cenb_clr ),
    .b(_al_u145_o),
    .c(\afeif/rst16m_n_s [1]),
    .o(\afeif/fsm/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*~B*A))"),
    .INIT(16'hfd00))
    _al_u147 (
    .a(_al_u145_o),
    .b(\afeif/fsm/n229_neg ),
    .c(\afeif/a16_pcnt_ack_lutinv ),
    .d(\afeif/rst16m_n_s [1]),
    .o(\afeif/fsm/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*~(~E*D*C))"),
    .INIT(32'h22220222))
    _al_u148 (
    .a(_al_u136_o),
    .b(\afeif/fsm/n46_lutinv ),
    .c(_al_u38_o),
    .d(\afeif/fsm/chnl [0]),
    .e(\afeif/fsm/stat [0]),
    .o(_al_u148_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*A*~(E*~D*C))"),
    .INIT(32'h77f77777))
    _al_u149 (
    .a(_al_u148_o),
    .b(_al_u128_o),
    .c(_al_u133_o),
    .d(\afeif/a16_csel_s1 [0]),
    .e(\afeif/a16_csel_s1 [1]),
    .o(adc_chnl[0]));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*C*B))"),
    .INIT(16'haa2a))
    _al_u150 (
    .a(_al_u132_o),
    .b(_al_u38_o),
    .c(\afeif/fsm/chnl [1]),
    .d(\afeif/fsm/stat [0]),
    .o(_al_u150_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(B*~(~D*~C)))"),
    .INIT(16'hddd5))
    _al_u151 (
    .a(_al_u150_o),
    .b(_al_u134_o),
    .c(\afeif/a16_csel_s1 [2]),
    .d(\afeif/a16_csel_s1 [3]),
    .o(adc_chnl[1]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u152 (
    .a(\afeif/fsm/n229_neg ),
    .o(\afeif/fsm/n229 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u33 (
    .a(adc_adce),
    .b(bdatw[6]),
    .o(\actl/n39 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u34 (
    .a(\afeif/rst16m_n_s [0]),
    .b(pll_extlock),
    .o(\afeif/n1 [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u35 (
    .a(pll_extlock),
    .b(rst_n),
    .o(\afeif/n1 [0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u36 (
    .a(\actl/adcint [2]),
    .b(\actl/adcint [3]),
    .c(adat_cenf[2]),
    .d(adat_cenf[3]),
    .o(_al_u36_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u37 (
    .a(_al_u36_o),
    .b(\actl/adcint [0]),
    .c(\actl/adcint [1]),
    .d(adat_cenf[0]),
    .e(adat_cenf[1]),
    .o(adc_cenr));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u38 (
    .a(\afeif/fsm/stat [1]),
    .b(\afeif/fsm/stat [2]),
    .o(_al_u38_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u39 (
    .a(_al_u38_o),
    .b(\afeif/fsm/stat [0]),
    .c(afe_eoc),
    .o(\afeif/fsm/n229_neg ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*~A)"),
    .INIT(16'h0004))
    _al_u40 (
    .a(adat_data_ack),
    .b(aif_data_lat),
    .c(aif_chnl[0]),
    .d(aif_chnl[1]),
    .o(\adat/mux4_b0_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u41 (
    .a(bcmdr),
    .b(bcs_adcu_n),
    .o(\actl/n2 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u42 (
    .a(\actl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n4 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u43 (
    .a(bcmdw),
    .b(bcs_adcu_n),
    .c(brdy),
    .o(\actl/n32 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u44 (
    .a(\actl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/wr_adcctl ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*~A)"),
    .INIT(16'h0040))
    _al_u45 (
    .a(adat_data_ack),
    .b(aif_data_lat),
    .c(aif_chnl[0]),
    .d(aif_chnl[1]),
    .o(\adat/mux5_b1_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u46 (
    .a(adat_data_ack),
    .b(aif_data_lat),
    .c(aif_chnl[0]),
    .d(aif_chnl[1]),
    .o(\adat/mux5_b3_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u47 (
    .a(adat_data_ack),
    .b(aif_data_lat),
    .c(aif_chnl[0]),
    .d(aif_chnl[1]),
    .o(\adat/mux5_b2_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u48 (
    .a(\actl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u49 (
    .a(\actl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n14 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u50 (
    .a(\actl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n8 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u51 (
    .a(\actl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u52 (
    .a(\actl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n12 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u53 (
    .a(\actl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n6 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u54 (
    .a(\actl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_adcint));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D*~B))*~(E)*~(A)+(C*~(D*~B))*E*~(A)+~((C*~(D*~B)))*E*A+(C*~(D*~B))*E*A)"),
    .INIT(32'heafa4050))
    _al_u55 (
    .a(\actl/wr_adcctl ),
    .b(\actl/aif_cenb_clr_f ),
    .c(actl_cenb),
    .d(aif_cenb_clr),
    .e(bdatw[4]),
    .o(\actl/n41 [4]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u56 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[10]),
    .d(adat_dat3[10]),
    .o(_al_u56_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u57 (
    .a(_al_u56_o),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcdat1 ),
    .d(adat_dat0[10]),
    .e(adat_dat1[10]),
    .o(_al_u57_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u58 (
    .a(_al_u57_o),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(\actl/rd_adcperi ),
    .o(bdatr[10]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u59 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[11]),
    .d(adat_dat3[11]),
    .o(_al_u59_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u60 (
    .a(_al_u59_o),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcdat1 ),
    .d(adat_dat0[11]),
    .e(adat_dat1[11]),
    .o(_al_u60_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u61 (
    .a(_al_u60_o),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(\actl/rd_adcperi ),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u62 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[8]),
    .d(adat_dat3[8]),
    .o(_al_u62_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u63 (
    .a(_al_u62_o),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcdat1 ),
    .d(adat_dat0[8]),
    .e(adat_dat1[8]),
    .o(_al_u63_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u64 (
    .a(_al_u63_o),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(\actl/rd_adcperi ),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u65 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[9]),
    .d(adat_dat3[9]),
    .o(_al_u65_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u66 (
    .a(_al_u65_o),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcdat1 ),
    .d(adat_dat0[9]),
    .e(adat_dat1[9]),
    .o(_al_u66_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u67 (
    .a(_al_u66_o),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(\actl/rd_adcperi ),
    .o(bdatr[9]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u68 (
    .a(\afeif/fsm/n229_neg ),
    .b(\afeif/a16_data_ack_s [1]),
    .o(\afeif/fsm/stat_nx[3]_en ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u69 (
    .a(\afeif/pcnt_psc [0]),
    .b(\afeif/pcnt_psc [1]),
    .c(\afeif/pcnt_psc [2]),
    .d(\afeif/pcnt_psc [3]),
    .o(_al_u69_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u70 (
    .a(_al_u69_o),
    .b(\afeif/pcnt_psc [4]),
    .c(\afeif/pcnt_psc [5]),
    .d(\afeif/pcnt_psc [6]),
    .e(\afeif/pcnt_psc [7]),
    .o(\afeif/a16_pcnt_upd ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u71 (
    .a(\actl/n32 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\actl/n35 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u72 (
    .a(\actl/n35 ),
    .b(actl_cenb),
    .o(\actl/wr_adcperi ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u73 (
    .a(actl_peri[4]),
    .b(actl_peri[5]),
    .c(actl_peri[6]),
    .d(actl_peri[7]),
    .o(_al_u73_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u74 (
    .a(_al_u73_o),
    .b(actl_peri[0]),
    .c(actl_peri[1]),
    .d(actl_peri[2]),
    .e(actl_peri[3]),
    .o(\afeif/fsm/n21_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u75 (
    .a(\afeif/fsm/n21_lutinv ),
    .b(\afeif/a16_cenb_s [1]),
    .c(\afeif/rst16m_n_s [1]),
    .o(_al_u75_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*A)"),
    .INIT(4'hd))
    _al_u76 (
    .a(_al_u75_o),
    .b(\afeif/a16_pcnt_upd ),
    .o(\afeif/n11 ));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h54f400a0))
    _al_u77 (
    .a(wr_adcint),
    .b(\adat/mux4_b0_sel_is_3_o ),
    .c(adat_cenf[0]),
    .d(bdatw[4]),
    .e(rst_n),
    .o(\adat/n27 [0]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u78 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[0]),
    .d(adat_dat3[0]),
    .o(_al_u78_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u79 (
    .a(_al_u78_o),
    .b(\actl/rd_adcdat1 ),
    .c(adat_dat1[0]),
    .o(\actl/n50 [0]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u80 (
    .a(\actl/n50 [0]),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[0]),
    .e(adat_dat0[0]),
    .o(\actl/n52 [0]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u81 (
    .a(\actl/n52 [0]),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(actl_csel[0]),
    .e(\actl/adcint [0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u82 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[1]),
    .d(adat_dat3[1]),
    .o(_al_u82_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u83 (
    .a(_al_u82_o),
    .b(\actl/rd_adcdat1 ),
    .c(adat_dat1[1]),
    .o(\actl/n50 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u84 (
    .a(\actl/n50 [1]),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[1]),
    .e(adat_dat0[1]),
    .o(\actl/n52 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u85 (
    .a(\actl/n52 [1]),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(actl_csel[1]),
    .e(\actl/adcint [1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u86 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[2]),
    .d(adat_dat3[2]),
    .o(_al_u86_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u87 (
    .a(_al_u86_o),
    .b(\actl/rd_adcdat1 ),
    .c(adat_dat1[2]),
    .o(\actl/n50 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u88 (
    .a(\actl/n50 [2]),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[2]),
    .e(adat_dat0[2]),
    .o(\actl/n52 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u89 (
    .a(\actl/n52 [2]),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(actl_csel[2]),
    .e(\actl/adcint [2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u90 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[3]),
    .d(adat_dat3[3]),
    .o(_al_u90_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u91 (
    .a(_al_u90_o),
    .b(\actl/rd_adcdat1 ),
    .c(adat_dat1[3]),
    .o(\actl/n50 [3]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u92 (
    .a(\actl/n50 [3]),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[3]),
    .e(adat_dat0[3]),
    .o(\actl/n52 [3]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u93 (
    .a(\actl/n52 [3]),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(actl_csel[3]),
    .e(\actl/adcint [3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u94 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[4]),
    .d(adat_dat3[4]),
    .o(_al_u94_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u95 (
    .a(_al_u94_o),
    .b(\actl/rd_adcdat1 ),
    .c(adat_dat1[4]),
    .o(\actl/n50 [4]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u96 (
    .a(\actl/n50 [4]),
    .b(\actl/rd_adcdat0 ),
    .c(\actl/rd_adcperi ),
    .d(actl_peri[4]),
    .e(adat_dat0[4]),
    .o(\actl/n52 [4]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'hfe32ce02))
    _al_u97 (
    .a(\actl/n52 [4]),
    .b(\actl/rd_adcctl ),
    .c(\actl/rd_adcint ),
    .d(actl_cenb),
    .e(adat_cenf[0]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u98 (
    .a(\actl/rd_adcdat2 ),
    .b(\actl/rd_adcdat3 ),
    .c(adat_dat2[5]),
    .d(adat_dat3[5]),
    .o(_al_u98_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u99 (
    .a(_al_u98_o),
    .b(\actl/rd_adcdat1 ),
    .c(adat_dat1[5]),
    .o(_al_u99_o));
  reg_sr_as_w1 \actl/aif_cenb_clr_f_reg  (
    .clk(clk),
    .d(aif_cenb_clr),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/aif_cenb_clr_f ));  // rtl/adc124.v(222)
  reg_sr_as_w1 \actl/rd_adcctl_reg  (
    .clk(clk),
    .d(\actl/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/rd_adcctl ));  // rtl/adc124.v(206)
  reg_sr_as_w1 \actl/rd_adcdat0_reg  (
    .clk(clk),
    .d(\actl/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/rd_adcdat0 ));  // rtl/adc124.v(206)
  reg_sr_as_w1 \actl/rd_adcdat1_reg  (
    .clk(clk),
    .d(\actl/n12 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/rd_adcdat1 ));  // rtl/adc124.v(206)
  reg_sr_as_w1 \actl/rd_adcdat2_reg  (
    .clk(clk),
    .d(\actl/n14 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/rd_adcdat2 ));  // rtl/adc124.v(206)
  reg_sr_as_w1 \actl/rd_adcdat3_reg  (
    .clk(clk),
    .d(\actl/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/rd_adcdat3 ));  // rtl/adc124.v(206)
  reg_sr_as_w1 \actl/rd_adcint_reg  (
    .clk(clk),
    .d(\actl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/rd_adcint ));  // rtl/adc124.v(206)
  reg_sr_as_w1 \actl/rd_adcperi_reg  (
    .clk(clk),
    .d(\actl/n8 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/rd_adcperi ));  // rtl/adc124.v(206)
  reg_sr_as_w1 \actl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\actl/wr_adcctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_csel[0]));  // rtl/adc124.v(235)
  reg_sr_as_w1 \actl/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\actl/wr_adcctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_csel[1]));  // rtl/adc124.v(235)
  reg_sr_as_w1 \actl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\actl/wr_adcctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_csel[2]));  // rtl/adc124.v(235)
  reg_sr_as_w1 \actl/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\actl/wr_adcctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_csel[3]));  // rtl/adc124.v(235)
  reg_sr_as_w1 \actl/reg0_b4  (
    .clk(clk),
    .d(\actl/n41 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_cenb));  // rtl/adc124.v(235)
  reg_sr_as_w1 \actl/reg0_b6  (
    .clk(clk),
    .d(\actl/n39 ),
    .en(\actl/wr_adcctl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adc_adce));  // rtl/adc124.v(235)
  reg_sr_as_w1 \actl/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(wr_adcint),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/adcint [0]));  // rtl/adc124.v(249)
  reg_sr_as_w1 \actl/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(wr_adcint),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/adcint [1]));  // rtl/adc124.v(249)
  reg_sr_as_w1 \actl/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(wr_adcint),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/adcint [2]));  // rtl/adc124.v(249)
  reg_sr_as_w1 \actl/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(wr_adcint),
    .reset(~rst_n),
    .set(1'b0),
    .q(\actl/adcint [3]));  // rtl/adc124.v(249)
  reg_sr_as_w1 \actl/reg2_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[0]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \actl/reg2_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[1]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \actl/reg2_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[2]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \actl/reg2_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[3]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \actl/reg2_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[4]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \actl/reg2_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[5]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \actl/reg2_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[6]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \actl/reg2_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(\actl/wr_adcperi ),
    .reset(~rst_n),
    .set(1'b0),
    .q(actl_peri[7]));  // rtl/adc124.v(261)
  reg_sr_as_w1 \adat/adat_data_ack_reg  (
    .clk(clk),
    .d(aif_data_lat),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_data_ack));  // rtl/adc124.v(499)
  reg_ar_as_w1 \adat/reg0_b0  (
    .clk(clk),
    .d(\adat/n27 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(adat_cenf[0]));  // rtl/adc124.v(545)
  reg_ar_as_w1 \adat/reg0_b1  (
    .clk(clk),
    .d(\adat/n27 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(adat_cenf[1]));  // rtl/adc124.v(545)
  reg_ar_as_w1 \adat/reg0_b2  (
    .clk(clk),
    .d(\adat/n27 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(adat_cenf[2]));  // rtl/adc124.v(545)
  reg_ar_as_w1 \adat/reg0_b3  (
    .clk(clk),
    .d(\adat/n27 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(adat_cenf[3]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b0  (
    .clk(clk),
    .d(aif_dout[0]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[0]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b1  (
    .clk(clk),
    .d(aif_dout[1]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[1]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b10  (
    .clk(clk),
    .d(aif_dout[10]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[10]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b11  (
    .clk(clk),
    .d(aif_dout[11]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[11]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b2  (
    .clk(clk),
    .d(aif_dout[2]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[2]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b3  (
    .clk(clk),
    .d(aif_dout[3]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[3]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b4  (
    .clk(clk),
    .d(aif_dout[4]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[4]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b5  (
    .clk(clk),
    .d(aif_dout[5]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[5]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b6  (
    .clk(clk),
    .d(aif_dout[6]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[6]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b7  (
    .clk(clk),
    .d(aif_dout[7]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[7]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b8  (
    .clk(clk),
    .d(aif_dout[8]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[8]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg1_b9  (
    .clk(clk),
    .d(aif_dout[9]),
    .en(\adat/mux4_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat0[9]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b0  (
    .clk(clk),
    .d(aif_dout[0]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[0]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b1  (
    .clk(clk),
    .d(aif_dout[1]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[1]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b10  (
    .clk(clk),
    .d(aif_dout[10]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[10]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b11  (
    .clk(clk),
    .d(aif_dout[11]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[11]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b2  (
    .clk(clk),
    .d(aif_dout[2]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[2]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b3  (
    .clk(clk),
    .d(aif_dout[3]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[3]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b4  (
    .clk(clk),
    .d(aif_dout[4]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[4]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b5  (
    .clk(clk),
    .d(aif_dout[5]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[5]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b6  (
    .clk(clk),
    .d(aif_dout[6]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[6]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b7  (
    .clk(clk),
    .d(aif_dout[7]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[7]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b8  (
    .clk(clk),
    .d(aif_dout[8]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[8]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg2_b9  (
    .clk(clk),
    .d(aif_dout[9]),
    .en(\adat/mux5_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat1[9]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b0  (
    .clk(clk),
    .d(aif_dout[0]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[0]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b1  (
    .clk(clk),
    .d(aif_dout[1]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[1]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b10  (
    .clk(clk),
    .d(aif_dout[10]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[10]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b11  (
    .clk(clk),
    .d(aif_dout[11]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[11]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b2  (
    .clk(clk),
    .d(aif_dout[2]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[2]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b3  (
    .clk(clk),
    .d(aif_dout[3]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[3]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b4  (
    .clk(clk),
    .d(aif_dout[4]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[4]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b5  (
    .clk(clk),
    .d(aif_dout[5]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[5]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b6  (
    .clk(clk),
    .d(aif_dout[6]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[6]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b7  (
    .clk(clk),
    .d(aif_dout[7]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[7]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b8  (
    .clk(clk),
    .d(aif_dout[8]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[8]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg3_b9  (
    .clk(clk),
    .d(aif_dout[9]),
    .en(\adat/mux5_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat2[9]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b0  (
    .clk(clk),
    .d(aif_dout[0]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[0]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b1  (
    .clk(clk),
    .d(aif_dout[1]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[1]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b10  (
    .clk(clk),
    .d(aif_dout[10]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[10]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b11  (
    .clk(clk),
    .d(aif_dout[11]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[11]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b2  (
    .clk(clk),
    .d(aif_dout[2]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[2]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b3  (
    .clk(clk),
    .d(aif_dout[3]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[3]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b4  (
    .clk(clk),
    .d(aif_dout[4]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[4]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b5  (
    .clk(clk),
    .d(aif_dout[5]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[5]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b6  (
    .clk(clk),
    .d(aif_dout[6]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[6]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b7  (
    .clk(clk),
    .d(aif_dout[7]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[7]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b8  (
    .clk(clk),
    .d(aif_dout[8]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[8]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \adat/reg4_b9  (
    .clk(clk),
    .d(aif_dout[9]),
    .en(\adat/mux5_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(adat_dat3[9]));  // rtl/adc124.v(545)
  reg_sr_as_w1 \afeif/a16_data_lat_reg  (
    .clk(clk16m),
    .d(\afeif/fsm/n229_neg ),
    .en(\afeif/fsm/stat_nx[3]_en ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(\afeif/a16_data_lat ));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/a16_pcnt_ovf_reg  (
    .clk(clk16m),
    .d(\afeif/a16_pcnt_ovf_d ),
    .en(1'b1),
    .reset(\afeif/n17 ),
    .set(1'b0),
    .q(\afeif/a16_pcnt_ovf ));  // rtl/adc124.v(416)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u0  (
    .a(\afeif/pcnt_psc [0]),
    .b(1'b1),
    .c(\afeif/add0/c0 ),
    .o({\afeif/add0/c1 ,\afeif/pcnt_psc_nx [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u1  (
    .a(\afeif/pcnt_psc [1]),
    .b(1'b0),
    .c(\afeif/add0/c1 ),
    .o({\afeif/add0/c2 ,\afeif/pcnt_psc_nx [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u2  (
    .a(\afeif/pcnt_psc [2]),
    .b(1'b0),
    .c(\afeif/add0/c2 ),
    .o({\afeif/add0/c3 ,\afeif/pcnt_psc_nx [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u3  (
    .a(\afeif/pcnt_psc [3]),
    .b(1'b0),
    .c(\afeif/add0/c3 ),
    .o({\afeif/add0/c4 ,\afeif/pcnt_psc_nx [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u4  (
    .a(\afeif/pcnt_psc [4]),
    .b(1'b0),
    .c(\afeif/add0/c4 ),
    .o({\afeif/add0/c5 ,\afeif/pcnt_psc_nx [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u5  (
    .a(\afeif/pcnt_psc [5]),
    .b(1'b0),
    .c(\afeif/add0/c5 ),
    .o({\afeif/add0/c6 ,\afeif/pcnt_psc_nx [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u6  (
    .a(\afeif/pcnt_psc [6]),
    .b(1'b0),
    .c(\afeif/add0/c6 ),
    .o({\afeif/add0/c7 ,\afeif/pcnt_psc_nx [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add0/u7  (
    .a(\afeif/pcnt_psc [7]),
    .b(1'b0),
    .c(\afeif/add0/c7 ),
    .o({open_n0,\afeif/pcnt_psc_nx [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \afeif/add0/ucin  (
    .a(1'b0),
    .o({\afeif/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u0  (
    .a(\afeif/pcnt [0]),
    .b(1'b1),
    .c(\afeif/add1/c0 ),
    .o({\afeif/add1/c1 ,\afeif/pcnt_nx [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u1  (
    .a(\afeif/pcnt [1]),
    .b(1'b0),
    .c(\afeif/add1/c1 ),
    .o({\afeif/add1/c2 ,\afeif/pcnt_nx [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u10  (
    .a(\afeif/pcnt [10]),
    .b(1'b0),
    .c(\afeif/add1/c10 ),
    .o({\afeif/add1/c11 ,\afeif/pcnt_nx [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u11  (
    .a(\afeif/pcnt [11]),
    .b(1'b0),
    .c(\afeif/add1/c11 ),
    .o({\afeif/add1/c12 ,\afeif/pcnt_nx [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u12  (
    .a(\afeif/pcnt [12]),
    .b(1'b0),
    .c(\afeif/add1/c12 ),
    .o({\afeif/add1/c13 ,\afeif/pcnt_nx [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u13  (
    .a(\afeif/pcnt [13]),
    .b(1'b0),
    .c(\afeif/add1/c13 ),
    .o({\afeif/add1/c14 ,\afeif/pcnt_nx [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u14  (
    .a(\afeif/pcnt [14]),
    .b(1'b0),
    .c(\afeif/add1/c14 ),
    .o({\afeif/add1/c15 ,\afeif/pcnt_nx [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u15  (
    .a(\afeif/pcnt [15]),
    .b(1'b0),
    .c(\afeif/add1/c15 ),
    .o({open_n4,\afeif/pcnt_nx [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u2  (
    .a(\afeif/pcnt [2]),
    .b(1'b0),
    .c(\afeif/add1/c2 ),
    .o({\afeif/add1/c3 ,\afeif/pcnt_nx [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u3  (
    .a(\afeif/pcnt [3]),
    .b(1'b0),
    .c(\afeif/add1/c3 ),
    .o({\afeif/add1/c4 ,\afeif/pcnt_nx [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u4  (
    .a(\afeif/pcnt [4]),
    .b(1'b0),
    .c(\afeif/add1/c4 ),
    .o({\afeif/add1/c5 ,\afeif/pcnt_nx [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u5  (
    .a(\afeif/pcnt [5]),
    .b(1'b0),
    .c(\afeif/add1/c5 ),
    .o({\afeif/add1/c6 ,\afeif/pcnt_nx [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u6  (
    .a(\afeif/pcnt [6]),
    .b(1'b0),
    .c(\afeif/add1/c6 ),
    .o({\afeif/add1/c7 ,\afeif/pcnt_nx [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u7  (
    .a(\afeif/pcnt [7]),
    .b(1'b0),
    .c(\afeif/add1/c7 ),
    .o({\afeif/add1/c8 ,\afeif/pcnt_nx [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u8  (
    .a(\afeif/pcnt [8]),
    .b(1'b0),
    .c(\afeif/add1/c8 ),
    .o({\afeif/add1/c9 ,\afeif/pcnt_nx [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \afeif/add1/u9  (
    .a(\afeif/pcnt [9]),
    .b(1'b0),
    .c(\afeif/add1/c9 ),
    .o({\afeif/add1/c10 ,\afeif/pcnt_nx [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \afeif/add1/ucin  (
    .a(1'b0),
    .o({\afeif/add1/c0 ,open_n7}));
  reg_sr_as_w1 \afeif/fsm/reg0_b0  (
    .clk(clk16m),
    .d(adc_chnl[0]),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(\afeif/fsm/chnl [0]));  // rtl/adc_aif_fsm.v(111)
  reg_sr_as_w1 \afeif/fsm/reg0_b1  (
    .clk(clk16m),
    .d(adc_chnl[1]),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(\afeif/fsm/chnl [1]));  // rtl/adc_aif_fsm.v(111)
  reg_sr_as_w1 \afeif/fsm/reg1_b0  (
    .clk(clk16m),
    .d(1'b1),
    .en(1'b1),
    .reset(~\afeif/fsm/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\afeif/fsm/stat [0]));  // rtl/adc_aif_fsm.v(103)
  reg_sr_as_w1 \afeif/fsm/reg1_b1  (
    .clk(clk16m),
    .d(1'b1),
    .en(1'b1),
    .reset(~\afeif/fsm/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\afeif/fsm/stat [1]));  // rtl/adc_aif_fsm.v(103)
  reg_sr_as_w1 \afeif/fsm/reg1_b2  (
    .clk(clk16m),
    .d(1'b1),
    .en(1'b1),
    .reset(~\afeif/fsm/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\afeif/fsm/stat [2]));  // rtl/adc_aif_fsm.v(103)
  reg_ar_as_w1 \afeif/reg0_b0  (
    .clk(clk16m),
    .d(actl_cenb),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_cenb_s [0]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg0_b1  (
    .clk(clk16m),
    .d(\afeif/a16_cenb_s [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_cenb_s [1]));  // rtl/adc124.v(359)
  reg_sr_as_w1 \afeif/reg10_b0  (
    .clk(clk16m),
    .d(afe_dout[0]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[0]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b1  (
    .clk(clk16m),
    .d(afe_dout[1]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[1]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b10  (
    .clk(clk16m),
    .d(afe_dout[10]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[10]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b11  (
    .clk(clk16m),
    .d(afe_dout[11]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[11]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b2  (
    .clk(clk16m),
    .d(afe_dout[2]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[2]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b3  (
    .clk(clk16m),
    .d(afe_dout[3]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[3]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b4  (
    .clk(clk16m),
    .d(afe_dout[4]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[4]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b5  (
    .clk(clk16m),
    .d(afe_dout[5]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[5]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b6  (
    .clk(clk16m),
    .d(afe_dout[6]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[6]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b7  (
    .clk(clk16m),
    .d(afe_dout[7]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[7]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b8  (
    .clk(clk16m),
    .d(afe_dout[8]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[8]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg10_b9  (
    .clk(clk16m),
    .d(afe_dout[9]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_dout[9]));  // rtl/adc124.v(437)
  reg_ar_as_w1 \afeif/reg11_b0  (
    .clk(clk16m),
    .d(\afeif/n1 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/rst16m_n_s [0]));  // rtl/adc124.v(335)
  reg_ar_as_w1 \afeif/reg11_b1  (
    .clk(clk16m),
    .d(\afeif/n1 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/rst16m_n_s [1]));  // rtl/adc124.v(335)
  reg_ar_as_w1 \afeif/reg1_b0  (
    .clk(clk16m),
    .d(adat_data_ack),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_data_ack_s [0]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg1_b1  (
    .clk(clk16m),
    .d(\afeif/a16_data_ack_s [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_data_ack_s [1]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg2_b0  (
    .clk(clk16m),
    .d(\afeif/a16_csel_s0 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s1 [0]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg2_b1  (
    .clk(clk16m),
    .d(\afeif/a16_csel_s0 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s1 [1]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg2_b2  (
    .clk(clk16m),
    .d(\afeif/a16_csel_s0 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s1 [2]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg2_b3  (
    .clk(clk16m),
    .d(\afeif/a16_csel_s0 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s1 [3]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg3_b0  (
    .clk(clk16m),
    .d(actl_csel[0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s0 [0]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg3_b1  (
    .clk(clk16m),
    .d(actl_csel[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s0 [1]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg3_b2  (
    .clk(clk16m),
    .d(actl_csel[2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s0 [2]));  // rtl/adc124.v(359)
  reg_ar_as_w1 \afeif/reg3_b3  (
    .clk(clk16m),
    .d(actl_csel[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\afeif/a16_csel_s0 [3]));  // rtl/adc124.v(359)
  reg_sr_as_w1 \afeif/reg4_b0  (
    .clk(clk),
    .d(\afeif/a16_cenb_clr ),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(\afeif/aif_cenb_clr_s [0]));  // rtl/adc124.v(383)
  reg_sr_as_w1 \afeif/reg4_b1  (
    .clk(clk),
    .d(\afeif/aif_cenb_clr_s [0]),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_cenb_clr));  // rtl/adc124.v(383)
  reg_sr_as_w1 \afeif/reg5_b0  (
    .clk(clk),
    .d(\afeif/a16_data_lat ),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(\afeif/aif_data_lat_s [0]));  // rtl/adc124.v(383)
  reg_sr_as_w1 \afeif/reg5_b1  (
    .clk(clk),
    .d(\afeif/aif_data_lat_s [0]),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_data_lat));  // rtl/adc124.v(383)
  reg_sr_as_w1 \afeif/reg6_b0  (
    .clk(clk),
    .d(\afeif/rst16m_n_s [1]),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(\afeif/aif_ardy_s [0]));  // rtl/adc124.v(383)
  reg_sr_as_w1 \afeif/reg6_b1  (
    .clk(clk),
    .d(\afeif/aif_ardy_s [0]),
    .en(1'b1),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_ardy));  // rtl/adc124.v(383)
  reg_sr_as_w1 \afeif/reg7_b0  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [0]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [0]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg7_b1  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [1]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [1]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg7_b2  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [2]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [2]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg7_b3  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [3]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [3]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg7_b4  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [4]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [4]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg7_b5  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [5]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [5]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg7_b6  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [6]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [6]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg7_b7  (
    .clk(clk16m),
    .d(\afeif/pcnt_psc_nx [7]),
    .en(1'b1),
    .reset(\afeif/n11 ),
    .set(1'b0),
    .q(\afeif/pcnt_psc [7]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b0  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [0]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [0]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b1  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [1]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [1]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b10  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [10]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [10]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b11  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [11]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [11]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b12  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [12]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [12]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b13  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [13]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [13]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b14  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [14]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [14]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b15  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [15]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [15]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b2  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [2]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [2]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b3  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [3]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [3]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b4  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [4]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [4]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b5  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [5]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [5]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b6  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [6]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [6]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b7  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [7]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [7]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b8  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [8]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [8]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg8_b9  (
    .clk(clk16m),
    .d(\afeif/pcnt_nx [9]),
    .en(\afeif/a16_pcnt_upd ),
    .reset(\afeif/n14 ),
    .set(1'b0),
    .q(\afeif/pcnt [9]));  // rtl/adc124.v(416)
  reg_sr_as_w1 \afeif/reg9_b0  (
    .clk(clk16m),
    .d(adc_chnl[0]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_chnl[0]));  // rtl/adc124.v(437)
  reg_sr_as_w1 \afeif/reg9_b1  (
    .clk(clk16m),
    .d(adc_chnl[1]),
    .en(~\afeif/fsm/n229 ),
    .reset(~\afeif/rst16m_n_s [1]),
    .set(1'b0),
    .q(aif_chnl[1]));  // rtl/adc124.v(437)

endmodule 

