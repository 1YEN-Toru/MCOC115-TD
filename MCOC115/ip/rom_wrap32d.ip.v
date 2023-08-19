
`timescale 1ns / 1ps
module rom_wrap32d  // rtl/rom_wrap32d.v(1)
  (
  badr,
  bcmdl,
  bcmdr,
  bcmdw,
  bcs_rom_n,
  bmst,
  bootmd,
  brdy,
  clk,
  fadr1,
  fadr2,
  fcmdl,
  rom_dat1,
  rom_dat2,
  rst_n,
  bdatr,
  fdat1,
  fdat2,
  rom_adr1,
  rom_adr2,
  rom_we
  );
//
//	32 bit instruction ROM wrapper
//		(c) 2022	1YEN Toru
//
//
//	2023/03/11	ver.1.04
//		corresponding to 32 bit memory bus
//
//	2022/06/11	ver.1.02
//		corresponding to dual core cpu
//		module name changed: rom_wrap32d (dual core edition)
//
//	2022/05/21	ver.1.00
//		32 bit fetch bus for super-scalar edition cpu core
//

  input [15:0] badr;  // rtl/rom_wrap32d.v(36)
  input bcmdl;  // rtl/rom_wrap32d.v(32)
  input bcmdr;  // rtl/rom_wrap32d.v(30)
  input bcmdw;  // rtl/rom_wrap32d.v(31)
  input bcs_rom_n;  // rtl/rom_wrap32d.v(34)
  input bmst;  // rtl/rom_wrap32d.v(33)
  input bootmd;  // rtl/rom_wrap32d.v(28)
  input brdy;  // rtl/rom_wrap32d.v(29)
  input clk;  // rtl/rom_wrap32d.v(26)
  input [15:0] fadr1;  // rtl/rom_wrap32d.v(37)
  input [15:0] fadr2;  // rtl/rom_wrap32d.v(38)
  input fcmdl;  // rtl/rom_wrap32d.v(35)
  input [31:0] rom_dat1;  // rtl/rom_wrap32d.v(44)
  input [31:0] rom_dat2;  // rtl/rom_wrap32d.v(45)
  input rst_n;  // rtl/rom_wrap32d.v(27)
  output [31:0] bdatr;  // rtl/rom_wrap32d.v(40)
  output [31:0] fdat1;  // rtl/rom_wrap32d.v(41)
  output [31:0] fdat2;  // rtl/rom_wrap32d.v(42)
  output [15:0] rom_adr1;  // rtl/rom_wrap32d.v(46)
  output [15:0] rom_adr2;  // rtl/rom_wrap32d.v(47)
  output rom_we;  // rtl/rom_wrap32d.v(39)

  wire [31:0] n15;
  wire [31:0] rdat;  // rtl/rom_wrap32d.v(90)
  wire _al_u221_o;
  wire _al_u238_o;
  wire badr_1b;  // rtl/rom_wrap32d.v(100)
  wire bcmd_lb;  // rtl/rom_wrap32d.v(101)
  wire fadr1_1b;  // rtl/rom_wrap32d.v(115)
  wire fadr2_1b;  // rtl/rom_wrap32d.v(116)
  wire rom_drv;  // rtl/rom_wrap32d.v(80)
  wire rom_rd;  // rtl/rom_wrap32d.v(69)

  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u100 (
    .a(fcmdl),
    .b(rom_dat1[22]),
    .o(fdat1[22]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u101 (
    .a(fcmdl),
    .b(rom_dat1[21]),
    .o(fdat1[21]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u102 (
    .a(fcmdl),
    .b(rom_dat1[20]),
    .o(fdat1[20]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u103 (
    .a(fcmdl),
    .b(rom_dat1[19]),
    .o(fdat1[19]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u104 (
    .a(fcmdl),
    .b(rom_dat1[18]),
    .o(fdat1[18]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u105 (
    .a(fcmdl),
    .b(rom_dat1[17]),
    .o(fdat1[17]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u106 (
    .a(fcmdl),
    .b(rom_dat1[16]),
    .o(fdat1[16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u107 (
    .a(fcmdl),
    .b(rom_dat2[31]),
    .o(fdat2[31]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u108 (
    .a(bmst),
    .b(rom_dat1[31]),
    .c(rom_dat2[31]),
    .o(n15[31]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u109 (
    .a(fcmdl),
    .b(rom_dat2[30]),
    .o(fdat2[30]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u110 (
    .a(bmst),
    .b(rom_dat1[30]),
    .c(rom_dat2[30]),
    .o(n15[30]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u111 (
    .a(fcmdl),
    .b(rom_dat2[29]),
    .o(fdat2[29]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u112 (
    .a(bmst),
    .b(rom_dat1[29]),
    .c(rom_dat2[29]),
    .o(n15[29]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u113 (
    .a(fcmdl),
    .b(rom_dat2[28]),
    .o(fdat2[28]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u114 (
    .a(bmst),
    .b(rom_dat1[28]),
    .c(rom_dat2[28]),
    .o(n15[28]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u115 (
    .a(fcmdl),
    .b(rom_dat2[27]),
    .o(fdat2[27]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u116 (
    .a(bmst),
    .b(rom_dat1[27]),
    .c(rom_dat2[27]),
    .o(n15[27]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u117 (
    .a(fcmdl),
    .b(rom_dat2[26]),
    .o(fdat2[26]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u118 (
    .a(bmst),
    .b(rom_dat1[26]),
    .c(rom_dat2[26]),
    .o(n15[26]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u119 (
    .a(fcmdl),
    .b(rom_dat2[25]),
    .o(fdat2[25]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u120 (
    .a(bmst),
    .b(rom_dat1[25]),
    .c(rom_dat2[25]),
    .o(n15[25]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u121 (
    .a(fcmdl),
    .b(rom_dat2[24]),
    .o(fdat2[24]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u122 (
    .a(bmst),
    .b(rom_dat1[24]),
    .c(rom_dat2[24]),
    .o(n15[24]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u123 (
    .a(fcmdl),
    .b(rom_dat2[23]),
    .o(fdat2[23]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u124 (
    .a(bmst),
    .b(rom_dat1[23]),
    .c(rom_dat2[23]),
    .o(n15[23]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u125 (
    .a(fcmdl),
    .b(rom_dat2[22]),
    .o(fdat2[22]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u126 (
    .a(bmst),
    .b(rom_dat1[22]),
    .c(rom_dat2[22]),
    .o(n15[22]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u127 (
    .a(fcmdl),
    .b(rom_dat2[21]),
    .o(fdat2[21]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u128 (
    .a(bmst),
    .b(rom_dat1[21]),
    .c(rom_dat2[21]),
    .o(n15[21]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u129 (
    .a(fcmdl),
    .b(rom_dat2[20]),
    .o(fdat2[20]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u130 (
    .a(bmst),
    .b(rom_dat1[20]),
    .c(rom_dat2[20]),
    .o(n15[20]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u131 (
    .a(fcmdl),
    .b(rom_dat2[19]),
    .o(fdat2[19]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u132 (
    .a(bmst),
    .b(rom_dat1[19]),
    .c(rom_dat2[19]),
    .o(n15[19]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u133 (
    .a(fcmdl),
    .b(rom_dat2[18]),
    .o(fdat2[18]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u134 (
    .a(bmst),
    .b(rom_dat1[18]),
    .c(rom_dat2[18]),
    .o(n15[18]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u135 (
    .a(fcmdl),
    .b(rom_dat2[17]),
    .o(fdat2[17]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u136 (
    .a(bmst),
    .b(rom_dat1[17]),
    .c(rom_dat2[17]),
    .o(n15[17]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u137 (
    .a(fcmdl),
    .b(rom_dat2[16]),
    .o(fdat2[16]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u138 (
    .a(bmst),
    .b(rom_dat1[16]),
    .c(rom_dat2[16]),
    .o(n15[16]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u139 (
    .a(bmst),
    .b(rom_dat1[15]),
    .c(rom_dat2[15]),
    .o(n15[15]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u140 (
    .a(bmst),
    .b(rom_dat1[14]),
    .c(rom_dat2[14]),
    .o(n15[14]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u141 (
    .a(bmst),
    .b(rom_dat1[13]),
    .c(rom_dat2[13]),
    .o(n15[13]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u142 (
    .a(bmst),
    .b(rom_dat1[12]),
    .c(rom_dat2[12]),
    .o(n15[12]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u143 (
    .a(bmst),
    .b(rom_dat1[11]),
    .c(rom_dat2[11]),
    .o(n15[11]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u144 (
    .a(bmst),
    .b(rom_dat1[10]),
    .c(rom_dat2[10]),
    .o(n15[10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u145 (
    .a(bmst),
    .b(rom_dat1[9]),
    .c(rom_dat2[9]),
    .o(n15[9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u146 (
    .a(bmst),
    .b(rom_dat1[8]),
    .c(rom_dat2[8]),
    .o(n15[8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u147 (
    .a(bmst),
    .b(rom_dat1[7]),
    .c(rom_dat2[7]),
    .o(n15[7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u148 (
    .a(bmst),
    .b(rom_dat1[6]),
    .c(rom_dat2[6]),
    .o(n15[6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u149 (
    .a(bmst),
    .b(rom_dat1[5]),
    .c(rom_dat2[5]),
    .o(n15[5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u150 (
    .a(bmst),
    .b(rom_dat1[4]),
    .c(rom_dat2[4]),
    .o(n15[4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u151 (
    .a(bmst),
    .b(rom_dat1[3]),
    .c(rom_dat2[3]),
    .o(n15[3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u152 (
    .a(bmst),
    .b(rom_dat1[2]),
    .c(rom_dat2[2]),
    .o(n15[2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u153 (
    .a(bmst),
    .b(rom_dat1[1]),
    .c(rom_dat2[1]),
    .o(n15[1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u154 (
    .a(bmst),
    .b(rom_dat1[0]),
    .c(rom_dat2[0]),
    .o(n15[0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u155 (
    .a(bcmdr),
    .b(bcs_rom_n),
    .c(brdy),
    .o(rom_rd));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u156 (
    .a(bcmd_lb),
    .b(rdat[31]),
    .c(rom_drv),
    .o(bdatr[31]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u157 (
    .a(bcmd_lb),
    .b(rdat[30]),
    .c(rom_drv),
    .o(bdatr[30]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u158 (
    .a(bcmd_lb),
    .b(rdat[29]),
    .c(rom_drv),
    .o(bdatr[29]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u159 (
    .a(bcmd_lb),
    .b(rdat[28]),
    .c(rom_drv),
    .o(bdatr[28]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u160 (
    .a(bcmd_lb),
    .b(rdat[27]),
    .c(rom_drv),
    .o(bdatr[27]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u161 (
    .a(bcmd_lb),
    .b(rdat[26]),
    .c(rom_drv),
    .o(bdatr[26]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u162 (
    .a(bcmd_lb),
    .b(rdat[25]),
    .c(rom_drv),
    .o(bdatr[25]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u163 (
    .a(bcmd_lb),
    .b(rdat[24]),
    .c(rom_drv),
    .o(bdatr[24]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u164 (
    .a(bcmd_lb),
    .b(rdat[23]),
    .c(rom_drv),
    .o(bdatr[23]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u165 (
    .a(bcmd_lb),
    .b(rdat[22]),
    .c(rom_drv),
    .o(bdatr[22]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u166 (
    .a(bcmd_lb),
    .b(rdat[21]),
    .c(rom_drv),
    .o(bdatr[21]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u167 (
    .a(bcmd_lb),
    .b(rdat[20]),
    .c(rom_drv),
    .o(bdatr[20]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u168 (
    .a(bcmd_lb),
    .b(rdat[19]),
    .c(rom_drv),
    .o(bdatr[19]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u169 (
    .a(bcmd_lb),
    .b(rdat[18]),
    .c(rom_drv),
    .o(bdatr[18]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u170 (
    .a(bcmd_lb),
    .b(rdat[17]),
    .c(rom_drv),
    .o(bdatr[17]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u171 (
    .a(bcmd_lb),
    .b(rdat[16]),
    .c(rom_drv),
    .o(bdatr[16]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u172 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[25]),
    .d(rom_dat1[9]),
    .o(fdat1[9]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u173 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[24]),
    .d(rom_dat1[8]),
    .o(fdat1[8]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u174 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[23]),
    .d(rom_dat1[7]),
    .o(fdat1[7]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u175 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[22]),
    .d(rom_dat1[6]),
    .o(fdat1[6]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u176 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[21]),
    .d(rom_dat1[5]),
    .o(fdat1[5]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u177 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[20]),
    .d(rom_dat1[4]),
    .o(fdat1[4]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u178 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[19]),
    .d(rom_dat1[3]),
    .o(fdat1[3]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u179 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[18]),
    .d(rom_dat1[2]),
    .o(fdat1[2]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u180 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[17]),
    .d(rom_dat1[1]),
    .o(fdat1[1]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u181 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[31]),
    .d(rom_dat1[15]),
    .o(fdat1[15]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u182 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[30]),
    .d(rom_dat1[14]),
    .o(fdat1[14]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u183 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[29]),
    .d(rom_dat1[13]),
    .o(fdat1[13]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u184 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[28]),
    .d(rom_dat1[12]),
    .o(fdat1[12]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u185 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[27]),
    .d(rom_dat1[11]),
    .o(fdat1[11]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u186 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[26]),
    .d(rom_dat1[10]),
    .o(fdat1[10]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u187 (
    .a(fadr1_1b),
    .b(fcmdl),
    .c(rom_dat1[16]),
    .d(rom_dat1[0]),
    .o(fdat1[0]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u188 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[25]),
    .d(rom_dat2[9]),
    .o(fdat2[9]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u189 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[24]),
    .d(rom_dat2[8]),
    .o(fdat2[8]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u190 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[23]),
    .d(rom_dat2[7]),
    .o(fdat2[7]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u191 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[22]),
    .d(rom_dat2[6]),
    .o(fdat2[6]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u192 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[21]),
    .d(rom_dat2[5]),
    .o(fdat2[5]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u193 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[20]),
    .d(rom_dat2[4]),
    .o(fdat2[4]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u194 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[19]),
    .d(rom_dat2[3]),
    .o(fdat2[3]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u195 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[18]),
    .d(rom_dat2[2]),
    .o(fdat2[2]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u196 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[17]),
    .d(rom_dat2[1]),
    .o(fdat2[1]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u197 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[31]),
    .d(rom_dat2[15]),
    .o(fdat2[15]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u198 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[30]),
    .d(rom_dat2[14]),
    .o(fdat2[14]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u199 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[29]),
    .d(rom_dat2[13]),
    .o(fdat2[13]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u200 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[28]),
    .d(rom_dat2[12]),
    .o(fdat2[12]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u201 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[27]),
    .d(rom_dat2[11]),
    .o(fdat2[11]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u202 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[26]),
    .d(rom_dat2[10]),
    .o(fdat2[10]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A))"),
    .INIT(16'hfe10))
    _al_u203 (
    .a(fadr2_1b),
    .b(fcmdl),
    .c(rom_dat2[16]),
    .d(rom_dat2[0]),
    .o(fdat2[0]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u204 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[25]),
    .d(rdat[9]),
    .e(rom_drv),
    .o(bdatr[9]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u205 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[24]),
    .d(rdat[8]),
    .e(rom_drv),
    .o(bdatr[8]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u206 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[23]),
    .d(rdat[7]),
    .e(rom_drv),
    .o(bdatr[7]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u207 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[22]),
    .d(rdat[6]),
    .e(rom_drv),
    .o(bdatr[6]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u208 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[21]),
    .d(rdat[5]),
    .e(rom_drv),
    .o(bdatr[5]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u209 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[20]),
    .d(rdat[4]),
    .e(rom_drv),
    .o(bdatr[4]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u210 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[19]),
    .d(rdat[3]),
    .e(rom_drv),
    .o(bdatr[3]));
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~(C)*~((~B*~A))+D*C*~((~B*~A))+~(D)*C*(~B*~A)+D*C*(~B*~A)))"),
    .INIT(32'hfe100000))
    _al_u211 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[18]),
    .d(rdat[2]),
    .e(rom_drv),
    .o(bdatr[2]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u212 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[1]),
    .d(rdat[17]),
    .e(rom_drv),
    .o(bdatr[1]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u213 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[15]),
    .d(rdat[31]),
    .e(rom_drv),
    .o(bdatr[15]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u214 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[14]),
    .d(rdat[30]),
    .e(rom_drv),
    .o(bdatr[14]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u215 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[13]),
    .d(rdat[29]),
    .e(rom_drv),
    .o(bdatr[13]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u216 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[12]),
    .d(rdat[28]),
    .e(rom_drv),
    .o(bdatr[12]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u217 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[11]),
    .d(rdat[27]),
    .e(rom_drv),
    .o(bdatr[11]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u218 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[10]),
    .d(rdat[26]),
    .e(rom_drv),
    .o(bdatr[10]));
  AL_MAP_LUT5 #(
    .EQN("(E*(C*~(D)*~((~B*~A))+C*D*~((~B*~A))+~(C)*D*(~B*~A)+C*D*(~B*~A)))"),
    .INIT(32'hf1e00000))
    _al_u219 (
    .a(badr_1b),
    .b(bcmd_lb),
    .c(rdat[0]),
    .d(rdat[16]),
    .e(rom_drv),
    .o(bdatr[0]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*A)"),
    .INIT(32'h02000000))
    _al_u220 (
    .a(bcmdw),
    .b(bcs_rom_n),
    .c(bmst),
    .d(bootmd),
    .e(brdy),
    .o(rom_we));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u221 (
    .a(rom_we),
    .b(rom_rd),
    .c(bmst),
    .o(_al_u221_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u222 (
    .a(_al_u221_o),
    .b(badr[9]),
    .c(fadr2[9]),
    .o(rom_adr2[9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u223 (
    .a(_al_u221_o),
    .b(badr[8]),
    .c(fadr2[8]),
    .o(rom_adr2[8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u224 (
    .a(_al_u221_o),
    .b(badr[7]),
    .c(fadr2[7]),
    .o(rom_adr2[7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u225 (
    .a(_al_u221_o),
    .b(badr[6]),
    .c(fadr2[6]),
    .o(rom_adr2[6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u226 (
    .a(_al_u221_o),
    .b(badr[5]),
    .c(fadr2[5]),
    .o(rom_adr2[5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u227 (
    .a(_al_u221_o),
    .b(badr[4]),
    .c(fadr2[4]),
    .o(rom_adr2[4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u228 (
    .a(_al_u221_o),
    .b(badr[3]),
    .c(fadr2[3]),
    .o(rom_adr2[3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u229 (
    .a(_al_u221_o),
    .b(badr[2]),
    .c(fadr2[2]),
    .o(rom_adr2[2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u230 (
    .a(_al_u221_o),
    .b(badr[15]),
    .c(fadr2[15]),
    .o(rom_adr2[15]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u231 (
    .a(_al_u221_o),
    .b(badr[14]),
    .c(fadr2[14]),
    .o(rom_adr2[14]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u232 (
    .a(_al_u221_o),
    .b(badr[13]),
    .c(fadr2[13]),
    .o(rom_adr2[13]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u233 (
    .a(_al_u221_o),
    .b(badr[12]),
    .c(fadr2[12]),
    .o(rom_adr2[12]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u234 (
    .a(_al_u221_o),
    .b(badr[11]),
    .c(fadr2[11]),
    .o(rom_adr2[11]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u235 (
    .a(_al_u221_o),
    .b(badr[10]),
    .c(fadr2[10]),
    .o(rom_adr2[10]));
  AL_MAP_LUT4 #(
    .EQN("(B*~((~D*C))*~(A)+B*(~D*C)*~(A)+~(B)*(~D*C)*A+B*(~D*C)*A)"),
    .INIT(16'h44e4))
    _al_u236 (
    .a(_al_u221_o),
    .b(badr[1]),
    .c(fadr2[1]),
    .d(fcmdl),
    .o(rom_adr2[1]));
  AL_MAP_LUT4 #(
    .EQN("(B*~((~D*C))*~(A)+B*(~D*C)*~(A)+~(B)*(~D*C)*A+B*(~D*C)*A)"),
    .INIT(16'h44e4))
    _al_u237 (
    .a(_al_u221_o),
    .b(badr[0]),
    .c(fadr2[0]),
    .d(fcmdl),
    .o(rom_adr2[0]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*B))"),
    .INIT(8'h51))
    _al_u238 (
    .a(rom_we),
    .b(rom_rd),
    .c(bmst),
    .o(_al_u238_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u239 (
    .a(_al_u238_o),
    .b(badr[9]),
    .c(fadr1[9]),
    .o(rom_adr1[9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u240 (
    .a(_al_u238_o),
    .b(badr[8]),
    .c(fadr1[8]),
    .o(rom_adr1[8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u241 (
    .a(_al_u238_o),
    .b(badr[7]),
    .c(fadr1[7]),
    .o(rom_adr1[7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u242 (
    .a(_al_u238_o),
    .b(badr[6]),
    .c(fadr1[6]),
    .o(rom_adr1[6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u243 (
    .a(_al_u238_o),
    .b(badr[5]),
    .c(fadr1[5]),
    .o(rom_adr1[5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u244 (
    .a(_al_u238_o),
    .b(badr[4]),
    .c(fadr1[4]),
    .o(rom_adr1[4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u245 (
    .a(_al_u238_o),
    .b(badr[3]),
    .c(fadr1[3]),
    .o(rom_adr1[3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u246 (
    .a(_al_u238_o),
    .b(badr[2]),
    .c(fadr1[2]),
    .o(rom_adr1[2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u247 (
    .a(_al_u238_o),
    .b(badr[15]),
    .c(fadr1[15]),
    .o(rom_adr1[15]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u248 (
    .a(_al_u238_o),
    .b(badr[14]),
    .c(fadr1[14]),
    .o(rom_adr1[14]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u249 (
    .a(_al_u238_o),
    .b(badr[13]),
    .c(fadr1[13]),
    .o(rom_adr1[13]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u250 (
    .a(_al_u238_o),
    .b(badr[12]),
    .c(fadr1[12]),
    .o(rom_adr1[12]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u251 (
    .a(_al_u238_o),
    .b(badr[11]),
    .c(fadr1[11]),
    .o(rom_adr1[11]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u252 (
    .a(_al_u238_o),
    .b(badr[10]),
    .c(fadr1[10]),
    .o(rom_adr1[10]));
  AL_MAP_LUT4 #(
    .EQN("(B*~((~D*C))*~(A)+B*(~D*C)*~(A)+~(B)*(~D*C)*A+B*(~D*C)*A)"),
    .INIT(16'h44e4))
    _al_u253 (
    .a(_al_u238_o),
    .b(badr[1]),
    .c(fadr1[1]),
    .d(fcmdl),
    .o(rom_adr1[1]));
  AL_MAP_LUT4 #(
    .EQN("(B*~((~D*C))*~(A)+B*(~D*C)*~(A)+~(B)*(~D*C)*A+B*(~D*C)*A)"),
    .INIT(16'h44e4))
    _al_u254 (
    .a(_al_u238_o),
    .b(badr[0]),
    .c(fadr1[0]),
    .d(fcmdl),
    .o(rom_adr1[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u91 (
    .a(fcmdl),
    .b(rom_dat1[31]),
    .o(fdat1[31]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u92 (
    .a(fcmdl),
    .b(rom_dat1[30]),
    .o(fdat1[30]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u93 (
    .a(fcmdl),
    .b(rom_dat1[29]),
    .o(fdat1[29]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u94 (
    .a(fcmdl),
    .b(rom_dat1[28]),
    .o(fdat1[28]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u95 (
    .a(fcmdl),
    .b(rom_dat1[27]),
    .o(fdat1[27]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u96 (
    .a(fcmdl),
    .b(rom_dat1[26]),
    .o(fdat1[26]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u97 (
    .a(fcmdl),
    .b(rom_dat1[25]),
    .o(fdat1[25]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u98 (
    .a(fcmdl),
    .b(rom_dat1[24]),
    .o(fdat1[24]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u99 (
    .a(fcmdl),
    .b(rom_dat1[23]),
    .o(fdat1[23]));
  reg_sr_as_w1 badr_1b_reg (
    .clk(clk),
    .d(badr[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_1b));  // rtl/rom_wrap32d.v(114)
  reg_sr_as_w1 bcmd_lb_reg (
    .clk(clk),
    .d(bcmdl),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(bcmd_lb));  // rtl/rom_wrap32d.v(114)
  reg_sr_as_w1 fadr1_1b_reg (
    .clk(~clk),
    .d(fadr1[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(fadr1_1b));  // rtl/rom_wrap32d.v(129)
  reg_sr_as_w1 fadr2_1b_reg (
    .clk(~clk),
    .d(fadr2[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(fadr2_1b));  // rtl/rom_wrap32d.v(129)
  reg_sr_as_w1 reg0_b0 (
    .clk(clk),
    .d(n15[0]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[0]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b1 (
    .clk(clk),
    .d(n15[1]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[1]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b10 (
    .clk(clk),
    .d(n15[10]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[10]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b11 (
    .clk(clk),
    .d(n15[11]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[11]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b12 (
    .clk(clk),
    .d(n15[12]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[12]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b13 (
    .clk(clk),
    .d(n15[13]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[13]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b14 (
    .clk(clk),
    .d(n15[14]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[14]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b15 (
    .clk(clk),
    .d(n15[15]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[15]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b16 (
    .clk(clk),
    .d(n15[16]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[16]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b17 (
    .clk(clk),
    .d(n15[17]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[17]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b18 (
    .clk(clk),
    .d(n15[18]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[18]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b19 (
    .clk(clk),
    .d(n15[19]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[19]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b2 (
    .clk(clk),
    .d(n15[2]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[2]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b20 (
    .clk(clk),
    .d(n15[20]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[20]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b21 (
    .clk(clk),
    .d(n15[21]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[21]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b22 (
    .clk(clk),
    .d(n15[22]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[22]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b23 (
    .clk(clk),
    .d(n15[23]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[23]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b24 (
    .clk(clk),
    .d(n15[24]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[24]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b25 (
    .clk(clk),
    .d(n15[25]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[25]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b26 (
    .clk(clk),
    .d(n15[26]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[26]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b27 (
    .clk(clk),
    .d(n15[27]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[27]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b28 (
    .clk(clk),
    .d(n15[28]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[28]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b29 (
    .clk(clk),
    .d(n15[29]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[29]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b3 (
    .clk(clk),
    .d(n15[3]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[3]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b30 (
    .clk(clk),
    .d(n15[30]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[30]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b31 (
    .clk(clk),
    .d(n15[31]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[31]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b4 (
    .clk(clk),
    .d(n15[4]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[4]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b5 (
    .clk(clk),
    .d(n15[5]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[5]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b6 (
    .clk(clk),
    .d(n15[6]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[6]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b7 (
    .clk(clk),
    .d(n15[7]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[7]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b8 (
    .clk(clk),
    .d(n15[8]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[8]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 reg0_b9 (
    .clk(clk),
    .d(n15[9]),
    .en(rom_rd),
    .reset(~rst_n),
    .set(1'b0),
    .q(rdat[9]));  // rtl/rom_wrap32d.v(97)
  reg_sr_as_w1 rom_drv_reg (
    .clk(clk),
    .d(rom_rd),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rom_drv));  // rtl/rom_wrap32d.v(87)

endmodule 

