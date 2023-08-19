
`timescale 1ns / 1ps
module semph5r12u  // rtl/semph5r12u.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_smph_n,
  bdatw,
  bmst,
  brdy,
  clk,
  rst_n,
  bdatr,
  smph_ram1_n,
  smph_ram2_n,
  smph_smrr1,
  smph_smrr2,
  smph_smur1,
  smph_smur2,
  smph_usr1_n,
  smph_usr2_n
  );
//
// Semaphore Unit
//		(c) 2021	1YEN Toru
//
//
//	2021/07/31	ver.1.00
//		5 ram area semaphores
//		12 user defined semaphores
//		dual core edition
//

  input [3:0] badr;  // rtl/semph5r12u.v(29)
  input bcmdr;  // rtl/semph5r12u.v(25)
  input bcmdw;  // rtl/semph5r12u.v(26)
  input bcs_smph_n;  // rtl/semph5r12u.v(28)
  input [15:0] bdatw;  // rtl/semph5r12u.v(30)
  input bmst;  // rtl/semph5r12u.v(27)
  input brdy;  // rtl/semph5r12u.v(24)
  input clk;  // rtl/semph5r12u.v(22)
  input rst_n;  // rtl/semph5r12u.v(23)
  output [15:0] bdatr;  // rtl/semph5r12u.v(39)
  output [5:0] smph_ram1_n;  // rtl/semph5r12u.v(35)
  output [5:0] smph_ram2_n;  // rtl/semph5r12u.v(36)
  output smph_smrr1;  // rtl/semph5r12u.v(31)
  output smph_smrr2;  // rtl/semph5r12u.v(33)
  output smph_smur1;  // rtl/semph5r12u.v(32)
  output smph_smur2;  // rtl/semph5r12u.v(34)
  output [11:0] smph_usr1_n;  // rtl/semph5r12u.v(37)
  output [11:0] smph_usr2_n;  // rtl/semph5r12u.v(38)

  wire [15:0] bdatr_usrb;  // rtl/semph5r12u.v(60)
  wire [15:0] \sctl/semctl1 ;  // rtl/semph5r12u.v(271)
  wire [15:0] \sctl/semctl2 ;  // rtl/semph5r12u.v(272)
  wire [5:0] \sctl/smph_ram1_nf ;  // rtl/semph5r12u.v(291)
  wire [5:0] \sctl/smph_ram2_nf ;  // rtl/semph5r12u.v(292)
  wire [11:0] \sctl/smph_usr1_nf ;  // rtl/semph5r12u.v(293)
  wire [11:0] \sctl/smph_usr2_nf ;  // rtl/semph5r12u.v(294)
  wire [1:0] \srama/n20 ;
  wire [1:0] \srama/n31 ;
  wire [1:0] \srama/n42 ;
  wire [1:0] \srama/n9 ;
  wire [1:0] \sramb/n20 ;
  wire [1:0] \sramb/n31 ;
  wire [1:0] \sramb/n42 ;
  wire [1:0] \sramb/n9 ;
  wire [1:0] \susra/n20 ;
  wire [1:0] \susra/n31 ;
  wire [1:0] \susra/n42 ;
  wire [1:0] \susra/n9 ;
  wire [1:0] \susrb/n20 ;
  wire [1:0] \susrb/n31 ;
  wire [1:0] \susrb/n42 ;
  wire [1:0] \susrb/n9 ;
  wire [1:0] \susrc/n20 ;
  wire [1:0] \susrc/n31 ;
  wire [1:0] \susrc/n42 ;
  wire [1:0] \susrc/n9 ;
  wire _al_n0_en;
  wire _al_n0_en_al_n102;
  wire _al_n0_en_al_n96;
  wire _al_n0_en_al_n99;
  wire _al_u100_o;
  wire _al_u107_o;
  wire _al_u112_o;
  wire _al_u115_o;
  wire _al_u118_o;
  wire _al_u121_o;
  wire _al_u128_o;
  wire _al_u129_o;
  wire _al_u130_o;
  wire _al_u132_o;
  wire _al_u133_o;
  wire _al_u134_o;
  wire _al_u136_o;
  wire _al_u137_o;
  wire _al_u138_o;
  wire _al_u140_o;
  wire _al_u141_o;
  wire _al_u142_o;
  wire _al_u145_o;
  wire _al_u146_o;
  wire _al_u147_o;
  wire _al_u150_o;
  wire _al_u151_o;
  wire _al_u153_o;
  wire _al_u154_o;
  wire _al_u155_o;
  wire _al_u158_o;
  wire _al_u159_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u163_o;
  wire _al_u166_o;
  wire _al_u167_o;
  wire _al_u169_o;
  wire _al_u170_o;
  wire _al_u171_o;
  wire _al_u174_o;
  wire _al_u175_o;
  wire _al_u178_o;
  wire _al_u181_o;
  wire _al_u184_o;
  wire _al_u187_o;
  wire _al_u191_o;
  wire _al_u194_o;
  wire _al_u197_o;
  wire _al_u200_o;
  wire _al_u204_o;
  wire _al_u207_o;
  wire _al_u210_o;
  wire _al_u213_o;
  wire _al_u217_o;
  wire _al_u220_o;
  wire _al_u223_o;
  wire _al_u226_o;
  wire _al_u74_o;
  wire _al_u75_o;
  wire _al_u77_o;
  wire _al_u78_o;
  wire _al_u80_o;
  wire _al_u81_o;
  wire _al_u82_o;
  wire _al_u83_o;
  wire _al_u84_o;
  wire _al_u85_o;
  wire _al_u87_o;
  wire _al_u88_o;
  wire _al_u89_o;
  wire _al_u90_o;
  wire _al_u91_o;
  wire _al_u92_o;
  wire _al_u98_o;
  wire rd_semrama;  // rtl/semph5r12u.v(87)
  wire rd_semramb;  // rtl/semph5r12u.v(88)
  wire rd_semusra;  // rtl/semph5r12u.v(89)
  wire rd_semusrb;  // rtl/semph5r12u.v(90)
  wire rd_semusrc;  // rtl/semph5r12u.v(91)
  wire \sctl/mux2_b0_sel_is_2_o ;
  wire \sctl/n12 ;
  wire \sctl/n14 ;
  wire \sctl/n15 ;
  wire \sctl/n16 ;
  wire \sctl/n17 ;
  wire \sctl/n18 ;
  wire \sctl/n19 ;
  wire \sctl/n2 ;
  wire \sctl/n20 ;
  wire \sctl/n48 ;
  wire \sctl/n49 ;
  wire \sctl/n52 ;
  wire \sctl/n53 ;
  wire \sctl/n56 ;
  wire \sctl/n57 ;
  wire \sctl/n60 ;
  wire \sctl/n61 ;
  wire \sctl/rd_semctl1 ;  // rtl/semph5r12u.v(239)
  wire \sctl/rd_semctl2 ;  // rtl/semph5r12u.v(240)
  wire \sctl/smph_smrf1 ;  // rtl/semph5r12u.v(314)
  wire \sctl/smph_smrf2 ;  // rtl/semph5r12u.v(315)
  wire \sctl/smph_smuf1 ;  // rtl/semph5r12u.v(316)
  wire \sctl/smph_smuf2 ;  // rtl/semph5r12u.v(317)
  wire \sctl/wr_semctl1 ;  // rtl/semph5r12u.v(230)
  wire \sramb/rsem_semregx1_n[1] ;  // rtl/semph5r12u.v(378)
  wire \sramb/rsem_semregx1_n[2] ;  // rtl/semph5r12u.v(378)
  wire \sramb/rsem_semregx1_n[3] ;  // rtl/semph5r12u.v(378)
  wire \sramb/rsem_semregx2_n[1] ;  // rtl/semph5r12u.v(379)
  wire \sramb/rsem_semregx2_n[2] ;  // rtl/semph5r12u.v(379)
  wire \sramb/rsem_semregx2_n[3] ;  // rtl/semph5r12u.v(379)
  wire \susra/n1 ;
  wire \susra/n12 ;
  wire \susra/n23 ;
  wire \susra/n34 ;
  wire wr_semrama;  // rtl/semph5r12u.v(82)
  wire wr_semramb;  // rtl/semph5r12u.v(83)
  wire wr_semusra;  // rtl/semph5r12u.v(84)
  wire wr_semusrb;  // rtl/semph5r12u.v(85)
  wire wr_semusrc;  // rtl/semph5r12u.v(86)

  assign bdatr[15] = 1'b0;
  assign bdatr[14] = 1'b0;
  assign bdatr[13] = 1'b0;
  assign bdatr[12] = 1'b0;
  assign bdatr[11] = 1'b0;
  assign bdatr[10] = 1'b0;
  assign bdatr[9] = 1'b0;
  assign bdatr[8] = 1'b0;
  assign smph_ram1_n[5] = 1'b0;
  assign smph_ram2_n[5] = 1'b0;
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u100 (
    .a(_al_u98_o),
    .b(\sctl/n12 ),
    .o(_al_u100_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u101 (
    .a(_al_u100_o),
    .b(badr[3]),
    .c(badr[2]),
    .o(\sctl/n18 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u102 (
    .a(_al_u98_o),
    .b(\sctl/n12 ),
    .c(badr[3]),
    .d(badr[2]),
    .o(\sctl/n20 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u103 (
    .a(_al_u100_o),
    .b(badr[3]),
    .c(badr[2]),
    .o(\sctl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u104 (
    .a(\sctl/n12 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\sctl/n19 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u105 (
    .a(\sctl/n12 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\sctl/n17 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u106 (
    .a(bcmdw),
    .b(bcs_smph_n),
    .c(brdy),
    .o(\sctl/n2 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u107 (
    .a(\sctl/n2 ),
    .b(_al_u98_o),
    .o(_al_u107_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u108 (
    .a(_al_u107_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(bmst),
    .o(\sctl/wr_semctl1 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u109 (
    .a(_al_u100_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(bmst),
    .o(\sctl/n15 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u110 (
    .a(_al_u100_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(bmst),
    .o(\sctl/n14 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u111 (
    .a(rd_semusrb),
    .b(smph_usr2_n[5]),
    .o(bdatr_usrb[4]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u112 (
    .a(bdatr_usrb[4]),
    .b(rd_semrama),
    .c(rd_semusrc),
    .d(smph_ram2_n[1]),
    .e(smph_usr2_n[9]),
    .o(_al_u112_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u113 (
    .a(_al_u112_o),
    .b(rd_semramb),
    .c(rd_semusra),
    .d(\sramb/rsem_semregx2_n[1] ),
    .e(smph_usr2_n[1]),
    .o(bdatr[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u114 (
    .a(rd_semusrb),
    .b(smph_usr1_n[5]),
    .o(bdatr_usrb[5]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u115 (
    .a(bdatr_usrb[5]),
    .b(rd_semrama),
    .c(rd_semusrc),
    .d(smph_ram1_n[1]),
    .e(smph_usr1_n[9]),
    .o(_al_u115_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u116 (
    .a(_al_u115_o),
    .b(rd_semramb),
    .c(rd_semusra),
    .d(\sramb/rsem_semregx1_n[1] ),
    .e(smph_usr1_n[1]),
    .o(bdatr[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u117 (
    .a(rd_semusrb),
    .b(smph_usr2_n[7]),
    .o(bdatr_usrb[0]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u118 (
    .a(bdatr_usrb[0]),
    .b(rd_semrama),
    .c(rd_semusrc),
    .d(smph_ram2_n[3]),
    .e(smph_usr2_n[11]),
    .o(_al_u118_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u119 (
    .a(_al_u118_o),
    .b(rd_semramb),
    .c(rd_semusra),
    .d(\sramb/rsem_semregx2_n[3] ),
    .e(smph_usr2_n[3]),
    .o(bdatr[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u120 (
    .a(rd_semusrb),
    .b(smph_usr1_n[7]),
    .o(bdatr_usrb[1]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u121 (
    .a(bdatr_usrb[1]),
    .b(rd_semrama),
    .c(rd_semusrc),
    .d(smph_ram1_n[3]),
    .e(smph_usr1_n[11]),
    .o(_al_u121_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u122 (
    .a(_al_u121_o),
    .b(rd_semramb),
    .c(rd_semusra),
    .d(\sramb/rsem_semregx1_n[3] ),
    .e(smph_usr1_n[3]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u123 (
    .a(_al_u107_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(bmst),
    .o(\sctl/mux2_b0_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u124 (
    .a(\sctl/mux2_b0_sel_is_2_o ),
    .b(bdatw[6]),
    .o(\sctl/n60 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u125 (
    .a(\sctl/mux2_b0_sel_is_2_o ),
    .b(bdatw[7]),
    .o(\sctl/n56 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u126 (
    .a(\sctl/wr_semctl1 ),
    .b(bdatw[6]),
    .o(\sctl/n52 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u127 (
    .a(\sctl/wr_semctl1 ),
    .b(bdatw[7]),
    .o(\sctl/n48 ));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u128 (
    .a(\sctl/rd_semctl1 ),
    .b(\sctl/rd_semctl2 ),
    .c(\sctl/semctl1 [2]),
    .d(\sctl/semctl2 [2]),
    .o(_al_u128_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u129 (
    .a(rd_semramb),
    .b(rd_semusra),
    .c(\sramb/rsem_semregx2_n[2] ),
    .d(smph_usr2_n[2]),
    .o(_al_u129_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u130 (
    .a(_al_u129_o),
    .b(rd_semusrb),
    .c(rd_semusrc),
    .d(smph_usr2_n[6]),
    .e(smph_usr2_n[10]),
    .o(_al_u130_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*A*~(D*C))"),
    .INIT(16'hf777))
    _al_u131 (
    .a(_al_u130_o),
    .b(_al_u128_o),
    .c(rd_semrama),
    .d(smph_ram2_n[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u132 (
    .a(\sctl/rd_semctl1 ),
    .b(\sctl/rd_semctl2 ),
    .c(\sctl/semctl1 [3]),
    .d(\sctl/semctl2 [3]),
    .o(_al_u132_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u133 (
    .a(rd_semramb),
    .b(rd_semusra),
    .c(\sramb/rsem_semregx1_n[2] ),
    .d(smph_usr1_n[2]),
    .o(_al_u133_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u134 (
    .a(_al_u133_o),
    .b(rd_semusrb),
    .c(rd_semusrc),
    .d(smph_usr1_n[6]),
    .e(smph_usr1_n[10]),
    .o(_al_u134_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*A*~(D*C))"),
    .INIT(16'hf777))
    _al_u135 (
    .a(_al_u134_o),
    .b(_al_u132_o),
    .c(rd_semrama),
    .d(smph_ram1_n[2]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u136 (
    .a(rd_semramb),
    .b(rd_semusrc),
    .c(smph_ram1_n[4]),
    .d(smph_usr1_n[8]),
    .o(_al_u136_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u137 (
    .a(rd_semrama),
    .b(rd_semusra),
    .c(smph_ram1_n[0]),
    .d(smph_usr1_n[0]),
    .o(_al_u137_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*C)*~(B)*~(D)+(E*C)*B*~(D)+~((E*C))*B*D+(E*C)*B*D))"),
    .INIT(32'h220a22aa))
    _al_u138 (
    .a(_al_u137_o),
    .b(smph_smrr1),
    .c(smph_smrr2),
    .d(\sctl/rd_semctl1 ),
    .e(\sctl/rd_semctl2 ),
    .o(_al_u138_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*A*~(D*C))"),
    .INIT(16'hf777))
    _al_u139 (
    .a(_al_u138_o),
    .b(_al_u136_o),
    .c(rd_semusrb),
    .d(smph_usr1_n[4]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u140 (
    .a(rd_semramb),
    .b(rd_semusrc),
    .c(smph_ram2_n[4]),
    .d(smph_usr2_n[8]),
    .o(_al_u140_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u141 (
    .a(rd_semrama),
    .b(rd_semusra),
    .c(smph_ram2_n[0]),
    .d(smph_usr2_n[0]),
    .o(_al_u141_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*C)*~(B)*~(D)+(E*C)*B*~(D)+~((E*C))*B*D+(E*C)*B*D))"),
    .INIT(32'h220a22aa))
    _al_u142 (
    .a(_al_u141_o),
    .b(smph_smur1),
    .c(smph_smur2),
    .d(\sctl/rd_semctl1 ),
    .e(\sctl/rd_semctl2 ),
    .o(_al_u142_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*A*~(D*C))"),
    .INIT(16'hf777))
    _al_u143 (
    .a(_al_u142_o),
    .b(_al_u140_o),
    .c(rd_semusrb),
    .d(smph_usr2_n[4]),
    .o(bdatr[6]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u144 (
    .a(_al_u107_o),
    .b(badr[3]),
    .c(badr[2]),
    .o(wr_semusra));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u145 (
    .a(wr_semusra),
    .b(smph_usr2_n[0]),
    .c(bdatw[7]),
    .d(bdatw[6]),
    .e(bmst),
    .o(_al_u145_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u146 (
    .a(bdatw[7]),
    .b(bdatw[6]),
    .c(bmst),
    .o(_al_u146_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u147 (
    .a(bdatw[7]),
    .b(bdatw[6]),
    .c(bmst),
    .o(_al_u147_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u148 (
    .a(wr_semusra),
    .b(_al_u146_o),
    .c(_al_u147_o),
    .o(\susra/n1 ));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~C*B)*~(A)*~(D)+~(E*~C*B)*A*~(D)+~(~(E*~C*B))*A*D+~(E*~C*B)*A*D)"),
    .INIT(32'h550c5500))
    _al_u149 (
    .a(_al_u145_o),
    .b(\susra/n1 ),
    .c(smph_usr2_n[0]),
    .d(smph_usr1_n[0]),
    .e(bmst),
    .o(\susra/n9 [1]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u150 (
    .a(bdatw[7]),
    .b(bdatw[6]),
    .c(bmst),
    .o(_al_u150_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u151 (
    .a(wr_semusra),
    .b(_al_u150_o),
    .c(smph_usr1_n[0]),
    .o(_al_u151_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~E*~D*A)*~(B)*~(C)+~(~E*~D*A)*B*~(C)+~(~(~E*~D*A))*B*C+~(~E*~D*A)*B*C)"),
    .INIT(32'h3030303a))
    _al_u152 (
    .a(\susra/n1 ),
    .b(_al_u151_o),
    .c(smph_usr2_n[0]),
    .d(smph_usr1_n[0]),
    .e(bmst),
    .o(\susra/n9 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u153 (
    .a(wr_semusra),
    .b(smph_usr2_n[3]),
    .c(bdatw[1]),
    .d(bdatw[0]),
    .e(bmst),
    .o(_al_u153_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u154 (
    .a(bdatw[1]),
    .b(bdatw[0]),
    .c(bmst),
    .o(_al_u154_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u155 (
    .a(bdatw[1]),
    .b(bdatw[0]),
    .c(bmst),
    .o(_al_u155_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u156 (
    .a(wr_semusra),
    .b(_al_u154_o),
    .c(_al_u155_o),
    .o(\susra/n34 ));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~C*B)*~(A)*~(D)+~(E*~C*B)*A*~(D)+~(~(E*~C*B))*A*D+~(E*~C*B)*A*D)"),
    .INIT(32'h550c5500))
    _al_u157 (
    .a(_al_u153_o),
    .b(\susra/n34 ),
    .c(smph_usr2_n[3]),
    .d(smph_usr1_n[3]),
    .e(bmst),
    .o(\susra/n42 [1]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u158 (
    .a(bdatw[1]),
    .b(bdatw[0]),
    .c(bmst),
    .o(_al_u158_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u159 (
    .a(wr_semusra),
    .b(_al_u158_o),
    .c(smph_usr1_n[3]),
    .o(_al_u159_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~E*~D*A)*~(B)*~(C)+~(~E*~D*A)*B*~(C)+~(~(~E*~D*A))*B*C+~(~E*~D*A)*B*C)"),
    .INIT(32'h3030303a))
    _al_u160 (
    .a(\susra/n34 ),
    .b(_al_u159_o),
    .c(smph_usr2_n[3]),
    .d(smph_usr1_n[3]),
    .e(bmst),
    .o(\susra/n42 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u161 (
    .a(wr_semusra),
    .b(smph_usr2_n[2]),
    .c(bdatw[3]),
    .d(bdatw[2]),
    .e(bmst),
    .o(_al_u161_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u162 (
    .a(bdatw[3]),
    .b(bdatw[2]),
    .c(bmst),
    .o(_al_u162_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u163 (
    .a(bdatw[3]),
    .b(bdatw[2]),
    .c(bmst),
    .o(_al_u163_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u164 (
    .a(wr_semusra),
    .b(_al_u162_o),
    .c(_al_u163_o),
    .o(\susra/n23 ));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~C*B)*~(A)*~(D)+~(E*~C*B)*A*~(D)+~(~(E*~C*B))*A*D+~(E*~C*B)*A*D)"),
    .INIT(32'h550c5500))
    _al_u165 (
    .a(_al_u161_o),
    .b(\susra/n23 ),
    .c(smph_usr2_n[2]),
    .d(smph_usr1_n[2]),
    .e(bmst),
    .o(\susra/n31 [1]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u166 (
    .a(bdatw[3]),
    .b(bdatw[2]),
    .c(bmst),
    .o(_al_u166_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u167 (
    .a(wr_semusra),
    .b(_al_u166_o),
    .c(smph_usr1_n[2]),
    .o(_al_u167_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~E*~D*A)*~(B)*~(C)+~(~E*~D*A)*B*~(C)+~(~(~E*~D*A))*B*C+~(~E*~D*A)*B*C)"),
    .INIT(32'h3030303a))
    _al_u168 (
    .a(\susra/n23 ),
    .b(_al_u167_o),
    .c(smph_usr2_n[2]),
    .d(smph_usr1_n[2]),
    .e(bmst),
    .o(\susra/n31 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u169 (
    .a(wr_semusra),
    .b(smph_usr2_n[1]),
    .c(bdatw[5]),
    .d(bdatw[4]),
    .e(bmst),
    .o(_al_u169_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u170 (
    .a(bdatw[5]),
    .b(bdatw[4]),
    .c(bmst),
    .o(_al_u170_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u171 (
    .a(bdatw[5]),
    .b(bdatw[4]),
    .c(bmst),
    .o(_al_u171_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u172 (
    .a(wr_semusra),
    .b(_al_u170_o),
    .c(_al_u171_o),
    .o(\susra/n12 ));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~C*B)*~(A)*~(D)+~(E*~C*B)*A*~(D)+~(~(E*~C*B))*A*D+~(E*~C*B)*A*D)"),
    .INIT(32'h550c5500))
    _al_u173 (
    .a(_al_u169_o),
    .b(\susra/n12 ),
    .c(smph_usr2_n[1]),
    .d(smph_usr1_n[1]),
    .e(bmst),
    .o(\susra/n20 [1]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u174 (
    .a(bdatw[5]),
    .b(bdatw[4]),
    .c(bmst),
    .o(_al_u174_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u175 (
    .a(wr_semusra),
    .b(_al_u174_o),
    .c(smph_usr1_n[1]),
    .o(_al_u175_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~E*~D*A)*~(B)*~(C)+~(~E*~D*A)*B*~(C)+~(~(~E*~D*A))*B*C+~(~E*~D*A)*B*C)"),
    .INIT(32'h3030303a))
    _al_u176 (
    .a(\susra/n12 ),
    .b(_al_u175_o),
    .c(smph_usr2_n[1]),
    .d(smph_usr1_n[1]),
    .e(bmst),
    .o(\susra/n20 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u177 (
    .a(\sctl/n2 ),
    .b(_al_u98_o),
    .c(badr[3]),
    .d(badr[2]),
    .o(wr_semusrc));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u178 (
    .a(smph_usr2_n[8]),
    .b(bdatw[7]),
    .c(bdatw[6]),
    .d(bmst),
    .o(_al_u178_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u179 (
    .a(wr_semusrc),
    .b(_al_u178_o),
    .c(_al_u146_o),
    .d(smph_usr2_n[8]),
    .e(smph_usr1_n[8]),
    .o(\susrc/n9 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u180 (
    .a(wr_semusrc),
    .b(_al_u147_o),
    .c(_al_u150_o),
    .d(smph_usr2_n[8]),
    .e(smph_usr1_n[8]),
    .o(\susrc/n9 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u181 (
    .a(smph_usr2_n[11]),
    .b(bdatw[1]),
    .c(bdatw[0]),
    .d(bmst),
    .o(_al_u181_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u182 (
    .a(wr_semusrc),
    .b(_al_u181_o),
    .c(_al_u154_o),
    .d(smph_usr2_n[11]),
    .e(smph_usr1_n[11]),
    .o(\susrc/n42 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u183 (
    .a(wr_semusrc),
    .b(_al_u155_o),
    .c(_al_u158_o),
    .d(smph_usr2_n[11]),
    .e(smph_usr1_n[11]),
    .o(\susrc/n42 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u184 (
    .a(smph_usr2_n[10]),
    .b(bdatw[3]),
    .c(bdatw[2]),
    .d(bmst),
    .o(_al_u184_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u185 (
    .a(wr_semusrc),
    .b(_al_u184_o),
    .c(_al_u162_o),
    .d(smph_usr2_n[10]),
    .e(smph_usr1_n[10]),
    .o(\susrc/n31 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u186 (
    .a(wr_semusrc),
    .b(_al_u163_o),
    .c(_al_u166_o),
    .d(smph_usr2_n[10]),
    .e(smph_usr1_n[10]),
    .o(\susrc/n31 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u187 (
    .a(smph_usr2_n[9]),
    .b(bdatw[5]),
    .c(bdatw[4]),
    .d(bmst),
    .o(_al_u187_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u188 (
    .a(wr_semusrc),
    .b(_al_u187_o),
    .c(_al_u170_o),
    .d(smph_usr2_n[9]),
    .e(smph_usr1_n[9]),
    .o(\susrc/n20 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u189 (
    .a(wr_semusrc),
    .b(_al_u171_o),
    .c(_al_u174_o),
    .d(smph_usr2_n[9]),
    .e(smph_usr1_n[9]),
    .o(\susrc/n20 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u190 (
    .a(_al_u107_o),
    .b(badr[3]),
    .c(badr[2]),
    .o(wr_semrama));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u191 (
    .a(smph_ram2_n[0]),
    .b(bdatw[7]),
    .c(bdatw[6]),
    .d(bmst),
    .o(_al_u191_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u192 (
    .a(wr_semrama),
    .b(_al_u191_o),
    .c(_al_u146_o),
    .d(smph_ram2_n[0]),
    .e(smph_ram1_n[0]),
    .o(\srama/n9 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u193 (
    .a(wr_semrama),
    .b(_al_u147_o),
    .c(_al_u150_o),
    .d(smph_ram2_n[0]),
    .e(smph_ram1_n[0]),
    .o(\srama/n9 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u194 (
    .a(smph_ram2_n[3]),
    .b(bdatw[1]),
    .c(bdatw[0]),
    .d(bmst),
    .o(_al_u194_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u195 (
    .a(wr_semrama),
    .b(_al_u194_o),
    .c(_al_u154_o),
    .d(smph_ram2_n[3]),
    .e(smph_ram1_n[3]),
    .o(\srama/n42 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u196 (
    .a(wr_semrama),
    .b(_al_u155_o),
    .c(_al_u158_o),
    .d(smph_ram2_n[3]),
    .e(smph_ram1_n[3]),
    .o(\srama/n42 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u197 (
    .a(smph_ram2_n[2]),
    .b(bdatw[3]),
    .c(bdatw[2]),
    .d(bmst),
    .o(_al_u197_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u198 (
    .a(wr_semrama),
    .b(_al_u197_o),
    .c(_al_u162_o),
    .d(smph_ram2_n[2]),
    .e(smph_ram1_n[2]),
    .o(\srama/n31 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u199 (
    .a(wr_semrama),
    .b(_al_u163_o),
    .c(_al_u166_o),
    .d(smph_ram2_n[2]),
    .e(smph_ram1_n[2]),
    .o(\srama/n31 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u200 (
    .a(smph_ram2_n[1]),
    .b(bdatw[5]),
    .c(bdatw[4]),
    .d(bmst),
    .o(_al_u200_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u201 (
    .a(wr_semrama),
    .b(_al_u200_o),
    .c(_al_u170_o),
    .d(smph_ram2_n[1]),
    .e(smph_ram1_n[1]),
    .o(\srama/n20 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u202 (
    .a(wr_semrama),
    .b(_al_u171_o),
    .c(_al_u174_o),
    .d(smph_ram2_n[1]),
    .e(smph_ram1_n[1]),
    .o(\srama/n20 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u203 (
    .a(\sctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_semusrb));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u204 (
    .a(smph_usr2_n[4]),
    .b(bdatw[7]),
    .c(bdatw[6]),
    .d(bmst),
    .o(_al_u204_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u205 (
    .a(wr_semusrb),
    .b(_al_u204_o),
    .c(_al_u146_o),
    .d(smph_usr2_n[4]),
    .e(smph_usr1_n[4]),
    .o(\susrb/n9 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u206 (
    .a(wr_semusrb),
    .b(_al_u147_o),
    .c(_al_u150_o),
    .d(smph_usr2_n[4]),
    .e(smph_usr1_n[4]),
    .o(\susrb/n9 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u207 (
    .a(smph_usr2_n[7]),
    .b(bdatw[1]),
    .c(bdatw[0]),
    .d(bmst),
    .o(_al_u207_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u208 (
    .a(wr_semusrb),
    .b(_al_u207_o),
    .c(_al_u154_o),
    .d(smph_usr2_n[7]),
    .e(smph_usr1_n[7]),
    .o(\susrb/n42 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u209 (
    .a(wr_semusrb),
    .b(_al_u155_o),
    .c(_al_u158_o),
    .d(smph_usr2_n[7]),
    .e(smph_usr1_n[7]),
    .o(\susrb/n42 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u210 (
    .a(smph_usr2_n[6]),
    .b(bdatw[3]),
    .c(bdatw[2]),
    .d(bmst),
    .o(_al_u210_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u211 (
    .a(wr_semusrb),
    .b(_al_u210_o),
    .c(_al_u162_o),
    .d(smph_usr2_n[6]),
    .e(smph_usr1_n[6]),
    .o(\susrb/n31 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u212 (
    .a(wr_semusrb),
    .b(_al_u163_o),
    .c(_al_u166_o),
    .d(smph_usr2_n[6]),
    .e(smph_usr1_n[6]),
    .o(\susrb/n31 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u213 (
    .a(smph_usr2_n[5]),
    .b(bdatw[5]),
    .c(bdatw[4]),
    .d(bmst),
    .o(_al_u213_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u214 (
    .a(wr_semusrb),
    .b(_al_u213_o),
    .c(_al_u170_o),
    .d(smph_usr2_n[5]),
    .e(smph_usr1_n[5]),
    .o(\susrb/n20 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u215 (
    .a(wr_semusrb),
    .b(_al_u171_o),
    .c(_al_u174_o),
    .d(smph_usr2_n[5]),
    .e(smph_usr1_n[5]),
    .o(\susrb/n20 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u216 (
    .a(\sctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(wr_semramb));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u217 (
    .a(smph_ram2_n[4]),
    .b(bdatw[7]),
    .c(bdatw[6]),
    .d(bmst),
    .o(_al_u217_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u218 (
    .a(wr_semramb),
    .b(_al_u217_o),
    .c(_al_u146_o),
    .d(smph_ram2_n[4]),
    .e(smph_ram1_n[4]),
    .o(\sramb/n9 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u219 (
    .a(wr_semramb),
    .b(_al_u147_o),
    .c(_al_u150_o),
    .d(smph_ram2_n[4]),
    .e(smph_ram1_n[4]),
    .o(\sramb/n9 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u220 (
    .a(\sramb/rsem_semregx2_n[3] ),
    .b(bdatw[1]),
    .c(bdatw[0]),
    .d(bmst),
    .o(_al_u220_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u221 (
    .a(wr_semramb),
    .b(_al_u220_o),
    .c(_al_u154_o),
    .d(\sramb/rsem_semregx2_n[3] ),
    .e(\sramb/rsem_semregx1_n[3] ),
    .o(\sramb/n42 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u222 (
    .a(wr_semramb),
    .b(_al_u155_o),
    .c(_al_u158_o),
    .d(\sramb/rsem_semregx2_n[3] ),
    .e(\sramb/rsem_semregx1_n[3] ),
    .o(\sramb/n42 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u223 (
    .a(\sramb/rsem_semregx2_n[2] ),
    .b(bdatw[3]),
    .c(bdatw[2]),
    .d(bmst),
    .o(_al_u223_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u224 (
    .a(wr_semramb),
    .b(_al_u223_o),
    .c(_al_u162_o),
    .d(\sramb/rsem_semregx2_n[2] ),
    .e(\sramb/rsem_semregx1_n[2] ),
    .o(\sramb/n31 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u225 (
    .a(wr_semramb),
    .b(_al_u163_o),
    .c(_al_u166_o),
    .d(\sramb/rsem_semregx2_n[2] ),
    .e(\sramb/rsem_semregx1_n[2] ),
    .o(\sramb/n31 [0]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u226 (
    .a(\sramb/rsem_semregx2_n[1] ),
    .b(bdatw[5]),
    .c(bdatw[4]),
    .d(bmst),
    .o(_al_u226_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*(~D*C)*~(E)+A*B*(~D*C)*~(E)+~(A)*~(B)*~((~D*C))*E+A*~(B)*~((~D*C))*E+~(A)*B*~((~D*C))*E+~(A)*~(B)*(~D*C)*E+A*~(B)*(~D*C)*E+~(A)*B*(~D*C)*E)"),
    .INIT(32'h777700a0))
    _al_u227 (
    .a(wr_semramb),
    .b(_al_u226_o),
    .c(_al_u170_o),
    .d(\sramb/rsem_semregx2_n[1] ),
    .e(\sramb/rsem_semregx1_n[1] ),
    .o(\sramb/n20 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~(C)*D*~((~E*A))+B*~(C)*D*~((~E*A))+~(B)*C*D*~((~E*A))+B*C*D*~((~E*A))+B*~(C)*~(D)*(~E*A)+B*C*~(D)*(~E*A)+~(B)*~(C)*D*(~E*A)+B*~(C)*D*(~E*A))"),
    .INIT(32'hff005f88))
    _al_u228 (
    .a(wr_semramb),
    .b(_al_u171_o),
    .c(_al_u174_o),
    .d(\sramb/rsem_semregx2_n[1] ),
    .e(\sramb/rsem_semregx1_n[1] ),
    .o(\sramb/n20 [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u70 (
    .a(\sctl/semctl1 [3]),
    .b(\sctl/smph_smrf1 ),
    .o(smph_smrr1));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u71 (
    .a(\sctl/semctl2 [3]),
    .b(\sctl/smph_smrf2 ),
    .o(smph_smrr2));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u72 (
    .a(\sctl/semctl1 [2]),
    .b(\sctl/smph_smuf1 ),
    .o(smph_smur1));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u73 (
    .a(\sctl/semctl2 [2]),
    .b(\sctl/smph_smuf2 ),
    .o(smph_smur2));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u74 (
    .a(\sctl/smph_ram2_nf [0]),
    .b(\sctl/smph_ram2_nf [4]),
    .c(smph_ram2_n[0]),
    .d(smph_ram2_n[4]),
    .o(_al_u74_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u75 (
    .a(\sctl/smph_ram2_nf [1]),
    .b(\sctl/smph_ram2_nf [2]),
    .c(smph_ram2_n[1]),
    .d(smph_ram2_n[2]),
    .o(_al_u75_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*A*~(D@C))"),
    .INIT(16'h7ff7))
    _al_u76 (
    .a(_al_u74_o),
    .b(_al_u75_o),
    .c(\sctl/smph_ram2_nf [3]),
    .d(smph_ram2_n[3]),
    .o(\sctl/n57 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u77 (
    .a(\sctl/smph_ram1_nf [0]),
    .b(\sctl/smph_ram1_nf [4]),
    .c(smph_ram1_n[0]),
    .d(smph_ram1_n[4]),
    .o(_al_u77_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u78 (
    .a(\sctl/smph_ram1_nf [1]),
    .b(\sctl/smph_ram1_nf [2]),
    .c(smph_ram1_n[1]),
    .d(smph_ram1_n[2]),
    .o(_al_u78_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*A*~(D@C))"),
    .INIT(16'h7ff7))
    _al_u79 (
    .a(_al_u77_o),
    .b(_al_u78_o),
    .c(\sctl/smph_ram1_nf [3]),
    .d(smph_ram1_n[3]),
    .o(\sctl/n49 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u80 (
    .a(\sctl/smph_usr2_nf [1]),
    .b(\sctl/smph_usr2_nf [2]),
    .c(smph_usr2_n[1]),
    .d(smph_usr2_n[2]),
    .o(_al_u80_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u81 (
    .a(_al_u80_o),
    .b(\sctl/smph_usr2_nf [3]),
    .c(\sctl/smph_usr2_nf [4]),
    .d(smph_usr2_n[3]),
    .e(smph_usr2_n[4]),
    .o(_al_u81_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u82 (
    .a(\sctl/smph_usr2_nf [10]),
    .b(\sctl/smph_usr2_nf [9]),
    .c(smph_usr2_n[9]),
    .d(smph_usr2_n[10]),
    .o(_al_u82_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u83 (
    .a(_al_u82_o),
    .b(\sctl/smph_usr2_nf [6]),
    .c(\sctl/smph_usr2_nf [8]),
    .d(smph_usr2_n[6]),
    .e(smph_usr2_n[8]),
    .o(_al_u83_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u84 (
    .a(\sctl/smph_usr2_nf [11]),
    .b(\sctl/smph_usr2_nf [7]),
    .c(smph_usr2_n[7]),
    .d(smph_usr2_n[11]),
    .o(_al_u84_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u85 (
    .a(\sctl/smph_usr2_nf [0]),
    .b(\sctl/smph_usr2_nf [5]),
    .c(smph_usr2_n[0]),
    .d(smph_usr2_n[5]),
    .o(_al_u85_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u86 (
    .a(_al_u81_o),
    .b(_al_u83_o),
    .c(_al_u84_o),
    .d(_al_u85_o),
    .o(\sctl/n61 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u87 (
    .a(\sctl/smph_usr1_nf [1]),
    .b(\sctl/smph_usr1_nf [2]),
    .c(smph_usr1_n[1]),
    .d(smph_usr1_n[2]),
    .o(_al_u87_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u88 (
    .a(_al_u87_o),
    .b(\sctl/smph_usr1_nf [3]),
    .c(\sctl/smph_usr1_nf [4]),
    .d(smph_usr1_n[3]),
    .e(smph_usr1_n[4]),
    .o(_al_u88_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u89 (
    .a(\sctl/smph_usr1_nf [10]),
    .b(\sctl/smph_usr1_nf [9]),
    .c(smph_usr1_n[9]),
    .d(smph_usr1_n[10]),
    .o(_al_u89_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u90 (
    .a(_al_u89_o),
    .b(\sctl/smph_usr1_nf [6]),
    .c(\sctl/smph_usr1_nf [8]),
    .d(smph_usr1_n[6]),
    .e(smph_usr1_n[8]),
    .o(_al_u90_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u91 (
    .a(\sctl/smph_usr1_nf [11]),
    .b(\sctl/smph_usr1_nf [7]),
    .c(smph_usr1_n[7]),
    .d(smph_usr1_n[11]),
    .o(_al_u91_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u92 (
    .a(\sctl/smph_usr1_nf [0]),
    .b(\sctl/smph_usr1_nf [5]),
    .c(smph_usr1_n[0]),
    .d(smph_usr1_n[5]),
    .o(_al_u92_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u93 (
    .a(_al_u88_o),
    .b(_al_u90_o),
    .c(_al_u91_o),
    .d(_al_u92_o),
    .o(\sctl/n53 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u94 (
    .a(\sctl/n57 ),
    .b(rst_n),
    .o(_al_n0_en_al_n96));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u95 (
    .a(\sctl/n49 ),
    .b(rst_n),
    .o(_al_n0_en));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u96 (
    .a(\sctl/n61 ),
    .b(rst_n),
    .o(_al_n0_en_al_n102));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u97 (
    .a(\sctl/n53 ),
    .b(rst_n),
    .o(_al_n0_en_al_n99));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u98 (
    .a(badr[1]),
    .b(badr[0]),
    .o(_al_u98_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u99 (
    .a(bcmdr),
    .b(bcs_smph_n),
    .o(\sctl/n12 ));
  reg_sr_as_w1 \sctl/rd_semctl1_reg  (
    .clk(clk),
    .d(\sctl/n14 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/rd_semctl1 ));  // rtl/semph5r12u.v(268)
  reg_sr_as_w1 \sctl/rd_semctl2_reg  (
    .clk(clk),
    .d(\sctl/n15 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/rd_semctl2 ));  // rtl/semph5r12u.v(268)
  reg_sr_as_w1 \sctl/rd_semrama_reg  (
    .clk(clk),
    .d(\sctl/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_semrama));  // rtl/semph5r12u.v(268)
  reg_sr_as_w1 \sctl/rd_semramb_reg  (
    .clk(clk),
    .d(\sctl/n17 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_semramb));  // rtl/semph5r12u.v(268)
  reg_sr_as_w1 \sctl/rd_semusra_reg  (
    .clk(clk),
    .d(\sctl/n18 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_semusra));  // rtl/semph5r12u.v(268)
  reg_sr_as_w1 \sctl/rd_semusrb_reg  (
    .clk(clk),
    .d(\sctl/n19 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_semusrb));  // rtl/semph5r12u.v(268)
  reg_sr_as_w1 \sctl/rd_semusrc_reg  (
    .clk(clk),
    .d(\sctl/n20 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_semusrc));  // rtl/semph5r12u.v(268)
  reg_sr_as_w1 \sctl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\sctl/wr_semctl1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/semctl1 [2]));  // rtl/semph5r12u.v(284)
  reg_sr_as_w1 \sctl/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\sctl/wr_semctl1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/semctl1 [3]));  // rtl/semph5r12u.v(284)
  reg_sr_as_w1 \sctl/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\sctl/mux2_b0_sel_is_2_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/semctl2 [2]));  // rtl/semph5r12u.v(284)
  reg_sr_as_w1 \sctl/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\sctl/mux2_b0_sel_is_2_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/semctl2 [3]));  // rtl/semph5r12u.v(284)
  reg_sr_as_w1 \sctl/reg2_b0  (
    .clk(clk),
    .d(smph_ram1_n[0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram1_nf [0]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg2_b1  (
    .clk(clk),
    .d(smph_ram1_n[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram1_nf [1]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg2_b2  (
    .clk(clk),
    .d(smph_ram1_n[2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram1_nf [2]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg2_b3  (
    .clk(clk),
    .d(smph_ram1_n[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram1_nf [3]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg2_b4  (
    .clk(clk),
    .d(smph_ram1_n[4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram1_nf [4]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg3_b0  (
    .clk(clk),
    .d(smph_ram2_n[0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram2_nf [0]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg3_b1  (
    .clk(clk),
    .d(smph_ram2_n[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram2_nf [1]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg3_b2  (
    .clk(clk),
    .d(smph_ram2_n[2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram2_nf [2]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg3_b3  (
    .clk(clk),
    .d(smph_ram2_n[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram2_nf [3]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg3_b4  (
    .clk(clk),
    .d(smph_ram2_n[4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_ram2_nf [4]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b0  (
    .clk(clk),
    .d(smph_usr1_n[0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [0]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b1  (
    .clk(clk),
    .d(smph_usr1_n[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [1]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b10  (
    .clk(clk),
    .d(smph_usr1_n[10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [10]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b11  (
    .clk(clk),
    .d(smph_usr1_n[11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [11]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b2  (
    .clk(clk),
    .d(smph_usr1_n[2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [2]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b3  (
    .clk(clk),
    .d(smph_usr1_n[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [3]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b4  (
    .clk(clk),
    .d(smph_usr1_n[4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [4]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b5  (
    .clk(clk),
    .d(smph_usr1_n[5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [5]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b6  (
    .clk(clk),
    .d(smph_usr1_n[6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [6]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b7  (
    .clk(clk),
    .d(smph_usr1_n[7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [7]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b8  (
    .clk(clk),
    .d(smph_usr1_n[8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [8]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg4_b9  (
    .clk(clk),
    .d(smph_usr1_n[9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr1_nf [9]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b0  (
    .clk(clk),
    .d(smph_usr2_n[0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [0]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b1  (
    .clk(clk),
    .d(smph_usr2_n[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [1]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b10  (
    .clk(clk),
    .d(smph_usr2_n[10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [10]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b11  (
    .clk(clk),
    .d(smph_usr2_n[11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [11]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b2  (
    .clk(clk),
    .d(smph_usr2_n[2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [2]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b3  (
    .clk(clk),
    .d(smph_usr2_n[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [3]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b4  (
    .clk(clk),
    .d(smph_usr2_n[4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [4]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b5  (
    .clk(clk),
    .d(smph_usr2_n[5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [5]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b6  (
    .clk(clk),
    .d(smph_usr2_n[6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [6]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b7  (
    .clk(clk),
    .d(smph_usr2_n[7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [7]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b8  (
    .clk(clk),
    .d(smph_usr2_n[8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [8]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/reg5_b9  (
    .clk(clk),
    .d(smph_usr2_n[9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sctl/smph_usr2_nf [9]));  // rtl/semph5r12u.v(311)
  reg_sr_as_w1 \sctl/smph_smrf1_reg  (
    .clk(clk),
    .d(\sctl/n49 ),
    .en(_al_n0_en),
    .reset(\sctl/n48 ),
    .set(1'b0),
    .q(\sctl/smph_smrf1 ));  // rtl/semph5r12u.v(345)
  reg_sr_as_w1 \sctl/smph_smrf2_reg  (
    .clk(clk),
    .d(\sctl/n57 ),
    .en(_al_n0_en_al_n96),
    .reset(\sctl/n56 ),
    .set(1'b0),
    .q(\sctl/smph_smrf2 ));  // rtl/semph5r12u.v(345)
  reg_sr_as_w1 \sctl/smph_smuf1_reg  (
    .clk(clk),
    .d(\sctl/n53 ),
    .en(_al_n0_en_al_n99),
    .reset(\sctl/n52 ),
    .set(1'b0),
    .q(\sctl/smph_smuf1 ));  // rtl/semph5r12u.v(345)
  reg_sr_as_w1 \sctl/smph_smuf2_reg  (
    .clk(clk),
    .d(\sctl/n61 ),
    .en(_al_n0_en_al_n102),
    .reset(\sctl/n60 ),
    .set(1'b0),
    .q(\sctl/smph_smuf2 ));  // rtl/semph5r12u.v(345)
  reg_sr_as_w1 \srama/reg0_b0  (
    .clk(clk),
    .d(\srama/n20 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram2_n[1]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \srama/reg0_b1  (
    .clk(clk),
    .d(\srama/n20 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram1_n[1]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \srama/reg1_b0  (
    .clk(clk),
    .d(\srama/n31 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram2_n[2]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \srama/reg1_b1  (
    .clk(clk),
    .d(\srama/n31 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram1_n[2]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \srama/reg2_b0  (
    .clk(clk),
    .d(\srama/n42 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram2_n[3]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \srama/reg2_b1  (
    .clk(clk),
    .d(\srama/n42 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram1_n[3]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \srama/reg3_b0  (
    .clk(clk),
    .d(\srama/n9 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram2_n[0]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \srama/reg3_b1  (
    .clk(clk),
    .d(\srama/n9 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram1_n[0]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \sramb/reg0_b0  (
    .clk(clk),
    .d(\sramb/n20 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sramb/rsem_semregx2_n[1] ));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \sramb/reg0_b1  (
    .clk(clk),
    .d(\sramb/n20 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sramb/rsem_semregx1_n[1] ));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \sramb/reg1_b0  (
    .clk(clk),
    .d(\sramb/n31 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sramb/rsem_semregx2_n[2] ));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \sramb/reg1_b1  (
    .clk(clk),
    .d(\sramb/n31 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sramb/rsem_semregx1_n[2] ));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \sramb/reg2_b0  (
    .clk(clk),
    .d(\sramb/n42 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sramb/rsem_semregx2_n[3] ));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \sramb/reg2_b1  (
    .clk(clk),
    .d(\sramb/n42 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sramb/rsem_semregx1_n[3] ));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \sramb/reg3_b0  (
    .clk(clk),
    .d(\sramb/n9 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram2_n[4]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \sramb/reg3_b1  (
    .clk(clk),
    .d(\sramb/n9 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_ram1_n[4]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \susra/reg0_b0  (
    .clk(clk),
    .d(\susra/n20 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[1]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \susra/reg0_b1  (
    .clk(clk),
    .d(\susra/n20 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[1]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \susra/reg1_b0  (
    .clk(clk),
    .d(\susra/n31 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[2]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \susra/reg1_b1  (
    .clk(clk),
    .d(\susra/n31 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[2]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \susra/reg2_b0  (
    .clk(clk),
    .d(\susra/n42 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[3]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \susra/reg2_b1  (
    .clk(clk),
    .d(\susra/n42 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[3]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \susra/reg3_b0  (
    .clk(clk),
    .d(\susra/n9 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[0]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \susra/reg3_b1  (
    .clk(clk),
    .d(\susra/n9 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[0]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \susrb/reg0_b0  (
    .clk(clk),
    .d(\susrb/n20 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[5]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \susrb/reg0_b1  (
    .clk(clk),
    .d(\susrb/n20 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[5]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \susrb/reg1_b0  (
    .clk(clk),
    .d(\susrb/n31 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[6]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \susrb/reg1_b1  (
    .clk(clk),
    .d(\susrb/n31 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[6]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \susrb/reg2_b0  (
    .clk(clk),
    .d(\susrb/n42 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[7]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \susrb/reg2_b1  (
    .clk(clk),
    .d(\susrb/n42 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[7]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \susrb/reg3_b0  (
    .clk(clk),
    .d(\susrb/n9 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[4]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \susrb/reg3_b1  (
    .clk(clk),
    .d(\susrb/n9 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[4]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \susrc/reg0_b0  (
    .clk(clk),
    .d(\susrc/n20 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[9]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \susrc/reg0_b1  (
    .clk(clk),
    .d(\susrc/n20 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[9]));  // rtl/semph5r12u.v(409)
  reg_sr_as_w1 \susrc/reg1_b0  (
    .clk(clk),
    .d(\susrc/n31 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[10]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \susrc/reg1_b1  (
    .clk(clk),
    .d(\susrc/n31 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[10]));  // rtl/semph5r12u.v(421)
  reg_sr_as_w1 \susrc/reg2_b0  (
    .clk(clk),
    .d(\susrc/n42 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[11]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \susrc/reg2_b1  (
    .clk(clk),
    .d(\susrc/n42 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[11]));  // rtl/semph5r12u.v(433)
  reg_sr_as_w1 \susrc/reg3_b0  (
    .clk(clk),
    .d(\susrc/n9 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr2_n[8]));  // rtl/semph5r12u.v(397)
  reg_sr_as_w1 \susrc/reg3_b1  (
    .clk(clk),
    .d(\susrc/n9 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(smph_usr1_n[8]));  // rtl/semph5r12u.v(397)

endmodule 

