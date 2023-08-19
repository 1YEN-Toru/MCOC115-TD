
`timescale 1ns / 1ps
module iram_wrapd  // rtl/iram_wrapd.v(1)
  (
  badr0,
  bcmd,
  bcs_iram_n,
  bmst,
  brdy,
  clk,
  fadr1,
  fadr2,
  iram_bdatr1,
  iram_bdatr2,
  iram_fadr_top,
  iram_fdat1,
  iram_fdat2,
  rom_fdat1,
  rom_fdat2,
  rst_n,
  bdatr,
  fdat1,
  fdat2,
  iram_bce1,
  iram_bce2,
  iram_bwe1,
  iram_bwe2,
  iram_fce1,
  iram_fce2
  );
//
//	Moscovium instruction RAM wrapper
//		(c) 2021	1YEN Toru
//
//
//	2021/11/06	ver.1.00
//

  input badr0;  // rtl/iram_wrapd.v(35)
  input [2:0] bcmd;  // rtl/iram_wrapd.v(36)
  input bcs_iram_n;  // rtl/iram_wrapd.v(34)
  input bmst;  // rtl/iram_wrapd.v(33)
  input brdy;  // rtl/iram_wrapd.v(32)
  input clk;  // rtl/iram_wrapd.v(30)
  input [15:0] fadr1;  // rtl/iram_wrapd.v(37)
  input [15:0] fadr2;  // rtl/iram_wrapd.v(38)
  input [15:0] iram_bdatr1;  // rtl/iram_wrapd.v(46)
  input [15:0] iram_bdatr2;  // rtl/iram_wrapd.v(47)
  input [15:0] iram_fadr_top;  // rtl/iram_wrapd.v(41)
  input [15:0] iram_fdat1;  // rtl/iram_wrapd.v(48)
  input [15:0] iram_fdat2;  // rtl/iram_wrapd.v(49)
  input [15:0] rom_fdat1;  // rtl/iram_wrapd.v(39)
  input [15:0] rom_fdat2;  // rtl/iram_wrapd.v(40)
  input rst_n;  // rtl/iram_wrapd.v(31)
  output [15:0] bdatr;  // rtl/iram_wrapd.v(44)
  output [15:0] fdat1;  // rtl/iram_wrapd.v(42)
  output [15:0] fdat2;  // rtl/iram_wrapd.v(43)
  output iram_bce1;  // rtl/iram_wrapd.v(50)
  output iram_bce2;  // rtl/iram_wrapd.v(51)
  output [1:0] iram_bwe1;  // rtl/iram_wrapd.v(54)
  output [1:0] iram_bwe2;  // rtl/iram_wrapd.v(55)
  output iram_fce1;  // rtl/iram_wrapd.v(52)
  output iram_fce2;  // rtl/iram_wrapd.v(53)

  wire iram_rd1;  // rtl/iram_wrapd.v(90)
  wire iram_rd2;  // rtl/iram_wrapd.v(91)
  wire lt0_c0;
  wire lt0_c1;
  wire lt0_c10;
  wire lt0_c11;
  wire lt0_c12;
  wire lt0_c13;
  wire lt0_c14;
  wire lt0_c15;
  wire lt0_c16;
  wire lt0_c2;
  wire lt0_c3;
  wire lt0_c4;
  wire lt0_c5;
  wire lt0_c6;
  wire lt0_c7;
  wire lt0_c8;
  wire lt0_c9;
  wire lt1_c0;
  wire lt1_c1;
  wire lt1_c10;
  wire lt1_c11;
  wire lt1_c12;
  wire lt1_c13;
  wire lt1_c14;
  wire lt1_c15;
  wire lt1_c16;
  wire lt1_c2;
  wire lt1_c3;
  wire lt1_c4;
  wire lt1_c5;
  wire lt1_c6;
  wire lt1_c7;
  wire lt1_c8;
  wire lt1_c9;
  wire n8;
  wire n9;

  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u0 (
    .a(iram_fdat1[9]),
    .b(rom_fdat1[9]),
    .c(iram_fce1),
    .o(fdat1[9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1 (
    .a(iram_fdat1[8]),
    .b(rom_fdat1[8]),
    .c(iram_fce1),
    .o(fdat1[8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u10 (
    .a(iram_fdat1[13]),
    .b(rom_fdat1[13]),
    .c(iram_fce1),
    .o(fdat1[13]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u11 (
    .a(iram_fdat1[12]),
    .b(rom_fdat1[12]),
    .c(iram_fce1),
    .o(fdat1[12]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u12 (
    .a(iram_fdat1[11]),
    .b(rom_fdat1[11]),
    .c(iram_fce1),
    .o(fdat1[11]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u13 (
    .a(iram_fdat1[10]),
    .b(rom_fdat1[10]),
    .c(iram_fce1),
    .o(fdat1[10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u14 (
    .a(iram_fdat1[1]),
    .b(rom_fdat1[1]),
    .c(iram_fce1),
    .o(fdat1[1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u15 (
    .a(iram_fdat1[0]),
    .b(rom_fdat1[0]),
    .c(iram_fce1),
    .o(fdat1[0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u16 (
    .a(iram_fdat2[9]),
    .b(rom_fdat2[9]),
    .c(iram_fce2),
    .o(fdat2[9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u17 (
    .a(iram_fdat2[8]),
    .b(rom_fdat2[8]),
    .c(iram_fce2),
    .o(fdat2[8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u18 (
    .a(iram_fdat2[7]),
    .b(rom_fdat2[7]),
    .c(iram_fce2),
    .o(fdat2[7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u19 (
    .a(iram_fdat2[6]),
    .b(rom_fdat2[6]),
    .c(iram_fce2),
    .o(fdat2[6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2 (
    .a(iram_fdat1[7]),
    .b(rom_fdat1[7]),
    .c(iram_fce1),
    .o(fdat1[7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u20 (
    .a(iram_fdat2[5]),
    .b(rom_fdat2[5]),
    .c(iram_fce2),
    .o(fdat2[5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u21 (
    .a(iram_fdat2[4]),
    .b(rom_fdat2[4]),
    .c(iram_fce2),
    .o(fdat2[4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u22 (
    .a(iram_fdat2[3]),
    .b(rom_fdat2[3]),
    .c(iram_fce2),
    .o(fdat2[3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u23 (
    .a(iram_fdat2[2]),
    .b(rom_fdat2[2]),
    .c(iram_fce2),
    .o(fdat2[2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u24 (
    .a(iram_fdat2[15]),
    .b(rom_fdat2[15]),
    .c(iram_fce2),
    .o(fdat2[15]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u25 (
    .a(iram_fdat2[14]),
    .b(rom_fdat2[14]),
    .c(iram_fce2),
    .o(fdat2[14]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u26 (
    .a(iram_fdat2[13]),
    .b(rom_fdat2[13]),
    .c(iram_fce2),
    .o(fdat2[13]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u27 (
    .a(iram_fdat2[12]),
    .b(rom_fdat2[12]),
    .c(iram_fce2),
    .o(fdat2[12]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u28 (
    .a(iram_fdat2[11]),
    .b(rom_fdat2[11]),
    .c(iram_fce2),
    .o(fdat2[11]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u29 (
    .a(iram_fdat2[10]),
    .b(rom_fdat2[10]),
    .c(iram_fce2),
    .o(fdat2[10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u3 (
    .a(iram_fdat1[6]),
    .b(rom_fdat1[6]),
    .c(iram_fce1),
    .o(fdat1[6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u30 (
    .a(iram_fdat2[1]),
    .b(rom_fdat2[1]),
    .c(iram_fce2),
    .o(fdat2[1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u31 (
    .a(iram_fdat2[0]),
    .b(rom_fdat2[0]),
    .c(iram_fce2),
    .o(fdat2[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u32 (
    .a(bcs_iram_n),
    .b(bmst),
    .o(iram_bce2));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u33 (
    .a(bcs_iram_n),
    .b(bmst),
    .o(iram_bce1));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u34 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[9]),
    .d(iram_bdatr2[9]),
    .o(bdatr[9]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u35 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[8]),
    .d(iram_bdatr2[8]),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u36 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[7]),
    .d(iram_bdatr2[7]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u37 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[6]),
    .d(iram_bdatr2[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u38 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[5]),
    .d(iram_bdatr2[5]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u39 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[4]),
    .d(iram_bdatr2[4]),
    .o(bdatr[4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u4 (
    .a(iram_fdat1[5]),
    .b(rom_fdat1[5]),
    .c(iram_fce1),
    .o(fdat1[5]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u40 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[3]),
    .d(iram_bdatr2[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u41 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[2]),
    .d(iram_bdatr2[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u42 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[15]),
    .d(iram_bdatr2[15]),
    .o(bdatr[15]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u43 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[14]),
    .d(iram_bdatr2[14]),
    .o(bdatr[14]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u44 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[13]),
    .d(iram_bdatr2[13]),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u45 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[12]),
    .d(iram_bdatr2[12]),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u46 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[11]),
    .d(iram_bdatr2[11]),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u47 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[10]),
    .d(iram_bdatr2[10]),
    .o(bdatr[10]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u48 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[1]),
    .d(iram_bdatr2[1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'he4a0))
    _al_u49 (
    .a(iram_rd1),
    .b(iram_rd2),
    .c(iram_bdatr1[0]),
    .d(iram_bdatr2[0]),
    .o(bdatr[0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u5 (
    .a(iram_fdat1[4]),
    .b(rom_fdat1[4]),
    .c(iram_fce1),
    .o(fdat1[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u50 (
    .a(iram_bce2),
    .b(bcmd[0]),
    .o(n9));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u51 (
    .a(iram_bce1),
    .b(bcmd[0]),
    .o(n8));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(C*~B))"),
    .INIT(16'h8a00))
    _al_u52 (
    .a(iram_bce2),
    .b(badr0),
    .c(bcmd[2]),
    .d(bcmd[1]),
    .o(iram_bwe2[0]));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(C*B))"),
    .INIT(16'h2a00))
    _al_u53 (
    .a(iram_bce2),
    .b(badr0),
    .c(bcmd[2]),
    .d(bcmd[1]),
    .o(iram_bwe2[1]));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(C*B))"),
    .INIT(16'h2a00))
    _al_u54 (
    .a(iram_bce1),
    .b(badr0),
    .c(bcmd[2]),
    .d(bcmd[1]),
    .o(iram_bwe1[1]));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(C*~B))"),
    .INIT(16'h8a00))
    _al_u55 (
    .a(iram_bce1),
    .b(badr0),
    .c(bcmd[2]),
    .d(bcmd[1]),
    .o(iram_bwe1[0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u6 (
    .a(iram_fdat1[3]),
    .b(rom_fdat1[3]),
    .c(iram_fce1),
    .o(fdat1[3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u7 (
    .a(iram_fdat1[2]),
    .b(rom_fdat1[2]),
    .c(iram_fce1),
    .o(fdat1[2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u8 (
    .a(iram_fdat1[15]),
    .b(rom_fdat1[15]),
    .c(iram_fce1),
    .o(fdat1[15]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u9 (
    .a(iram_fdat1[14]),
    .b(rom_fdat1[14]),
    .c(iram_fce1),
    .o(fdat1[14]));
  reg_sr_as_w1 iram_rd1_reg (
    .clk(clk),
    .d(n8),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(iram_rd1));  // rtl/iram_wrapd.v(104)
  reg_sr_as_w1 iram_rd2_reg (
    .clk(clk),
    .d(n9),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(iram_rd2));  // rtl/iram_wrapd.v(104)
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_0 (
    .a(iram_fadr_top[0]),
    .b(fadr1[0]),
    .c(lt0_c0),
    .o({lt0_c1,open_n0}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_1 (
    .a(iram_fadr_top[1]),
    .b(fadr1[1]),
    .c(lt0_c1),
    .o({lt0_c2,open_n1}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_10 (
    .a(iram_fadr_top[10]),
    .b(fadr1[10]),
    .c(lt0_c10),
    .o({lt0_c11,open_n2}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_11 (
    .a(iram_fadr_top[11]),
    .b(fadr1[11]),
    .c(lt0_c11),
    .o({lt0_c12,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_12 (
    .a(iram_fadr_top[12]),
    .b(fadr1[12]),
    .c(lt0_c12),
    .o({lt0_c13,open_n4}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_13 (
    .a(iram_fadr_top[13]),
    .b(fadr1[13]),
    .c(lt0_c13),
    .o({lt0_c14,open_n5}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_14 (
    .a(iram_fadr_top[14]),
    .b(fadr1[14]),
    .c(lt0_c14),
    .o({lt0_c15,open_n6}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_15 (
    .a(iram_fadr_top[15]),
    .b(fadr1[15]),
    .c(lt0_c15),
    .o({lt0_c16,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_2 (
    .a(iram_fadr_top[2]),
    .b(fadr1[2]),
    .c(lt0_c2),
    .o({lt0_c3,open_n8}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_3 (
    .a(iram_fadr_top[3]),
    .b(fadr1[3]),
    .c(lt0_c3),
    .o({lt0_c4,open_n9}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_4 (
    .a(iram_fadr_top[4]),
    .b(fadr1[4]),
    .c(lt0_c4),
    .o({lt0_c5,open_n10}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_5 (
    .a(iram_fadr_top[5]),
    .b(fadr1[5]),
    .c(lt0_c5),
    .o({lt0_c6,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_6 (
    .a(iram_fadr_top[6]),
    .b(fadr1[6]),
    .c(lt0_c6),
    .o({lt0_c7,open_n12}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_7 (
    .a(iram_fadr_top[7]),
    .b(fadr1[7]),
    .c(lt0_c7),
    .o({lt0_c8,open_n13}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_8 (
    .a(iram_fadr_top[8]),
    .b(fadr1[8]),
    .c(lt0_c8),
    .o({lt0_c9,open_n14}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_9 (
    .a(iram_fadr_top[9]),
    .b(fadr1[9]),
    .c(lt0_c9),
    .o({lt0_c10,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    lt0_cin (
    .a(1'b1),
    .o({lt0_c0,open_n18}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt0_cout (
    .a(1'b0),
    .b(1'b1),
    .c(lt0_c16),
    .o({open_n19,iram_fce1}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_0 (
    .a(iram_fadr_top[0]),
    .b(fadr2[0]),
    .c(lt1_c0),
    .o({lt1_c1,open_n20}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_1 (
    .a(iram_fadr_top[1]),
    .b(fadr2[1]),
    .c(lt1_c1),
    .o({lt1_c2,open_n21}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_10 (
    .a(iram_fadr_top[10]),
    .b(fadr2[10]),
    .c(lt1_c10),
    .o({lt1_c11,open_n22}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_11 (
    .a(iram_fadr_top[11]),
    .b(fadr2[11]),
    .c(lt1_c11),
    .o({lt1_c12,open_n23}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_12 (
    .a(iram_fadr_top[12]),
    .b(fadr2[12]),
    .c(lt1_c12),
    .o({lt1_c13,open_n24}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_13 (
    .a(iram_fadr_top[13]),
    .b(fadr2[13]),
    .c(lt1_c13),
    .o({lt1_c14,open_n25}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_14 (
    .a(iram_fadr_top[14]),
    .b(fadr2[14]),
    .c(lt1_c14),
    .o({lt1_c15,open_n26}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_15 (
    .a(iram_fadr_top[15]),
    .b(fadr2[15]),
    .c(lt1_c15),
    .o({lt1_c16,open_n27}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_2 (
    .a(iram_fadr_top[2]),
    .b(fadr2[2]),
    .c(lt1_c2),
    .o({lt1_c3,open_n28}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_3 (
    .a(iram_fadr_top[3]),
    .b(fadr2[3]),
    .c(lt1_c3),
    .o({lt1_c4,open_n29}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_4 (
    .a(iram_fadr_top[4]),
    .b(fadr2[4]),
    .c(lt1_c4),
    .o({lt1_c5,open_n30}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_5 (
    .a(iram_fadr_top[5]),
    .b(fadr2[5]),
    .c(lt1_c5),
    .o({lt1_c6,open_n31}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_6 (
    .a(iram_fadr_top[6]),
    .b(fadr2[6]),
    .c(lt1_c6),
    .o({lt1_c7,open_n32}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_7 (
    .a(iram_fadr_top[7]),
    .b(fadr2[7]),
    .c(lt1_c7),
    .o({lt1_c8,open_n33}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_8 (
    .a(iram_fadr_top[8]),
    .b(fadr2[8]),
    .c(lt1_c8),
    .o({lt1_c9,open_n34}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_9 (
    .a(iram_fadr_top[9]),
    .b(fadr2[9]),
    .c(lt1_c9),
    .o({lt1_c10,open_n35}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    lt1_cin (
    .a(1'b1),
    .o({lt1_c0,open_n38}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt1_cout (
    .a(1'b0),
    .b(1'b1),
    .c(lt1_c16),
    .o({open_n39,iram_fce2}));

endmodule 

