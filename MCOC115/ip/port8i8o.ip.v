
`timescale 1ns / 1ps
module port8i8o  // rtl/port8i8o.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_port_n,
  bdatw,
  brdy,
  clk,
  port_init_hizo,
  port_inp,
  rst_n,
  bdatr,
  port_enb,
  port_out,
  port_sel
  );
//
//	PORT Unit (General Purpose 8 Inputs / 8 Outputs)
//		(c) 2021	1YEN Toru
//
//
//	2021/08/14	ver.1.02
//		corresponding to bi-directional port and open drain output port
//		new i/o register: pordir, porode, porsel
//		initial value of pordir register:
//			port_init_hizo=0: pordir=16'h0000; (for backward compatibility)
//			port_init_hizo=1: pordir=16'h00ff; (port_out initial drive high-z)
//
//	2021/03/27	ver.1.00
//		8 inputs / 8 outputs edition
//

  input [3:0] badr;  // rtl/port8i8o.v(25)
  input bcmdr;  // rtl/port8i8o.v(22)
  input bcmdw;  // rtl/port8i8o.v(23)
  input bcs_port_n;  // rtl/port8i8o.v(24)
  input [7:0] bdatw;  // rtl/port8i8o.v(26)
  input brdy;  // rtl/port8i8o.v(21)
  input clk;  // rtl/port8i8o.v(18)
  input port_init_hizo;  // rtl/port8i8o.v(20)
  input [7:0] port_inp;  // rtl/port8i8o.v(27)
  input rst_n;  // rtl/port8i8o.v(19)
  output [15:0] bdatr;  // rtl/port8i8o.v(28)
  output [7:0] port_enb;  // rtl/port8i8o.v(29)
  output [7:0] port_out;  // rtl/port8i8o.v(31)
  output [7:0] port_sel;  // rtl/port8i8o.v(30)

  wire [7:0] \pordir/n3 ;
  wire [7:0] \pordir/port_dir ;  // rtl/port8i8o.v(361)
  wire [7:0] \pordir/port_ode ;  // rtl/port8i8o.v(371)
  wire [7:0] \porin/porin1 ;  // rtl/port8i8o.v(247)
  wire [7:0] \porin/porin2 ;  // rtl/port8i8o.v(248)
  wire [7:0] \porout/n5 ;
  wire _al_u19_o;
  wire _al_u20_o;
  wire _al_u21_o;
  wire _al_u23_o;
  wire _al_u24_o;
  wire _al_u25_o;
  wire _al_u27_o;
  wire _al_u28_o;
  wire _al_u29_o;
  wire _al_u31_o;
  wire _al_u32_o;
  wire _al_u33_o;
  wire _al_u35_o;
  wire _al_u36_o;
  wire _al_u37_o;
  wire _al_u39_o;
  wire _al_u40_o;
  wire _al_u41_o;
  wire _al_u43_o;
  wire _al_u44_o;
  wire _al_u45_o;
  wire _al_u47_o;
  wire _al_u48_o;
  wire _al_u49_o;
  wire _al_u68_o;
  wire _al_u69_o;
  wire \pctl/n10 ;
  wire \pctl/n12 ;
  wire \pctl/n14 ;
  wire \pctl/n15 ;
  wire \pctl/n16 ;
  wire \pctl/n17 ;
  wire \pctl/n18 ;
  wire \pctl/n2 ;
  wire port_pordir_rd;  // rtl/port8i8o.v(66)
  wire port_pordir_wr;  // rtl/port8i8o.v(70)
  wire port_porin_rd;  // rtl/port8i8o.v(63)
  wire port_porind_rd;  // rtl/port8i8o.v(64)
  wire port_porode_rd;  // rtl/port8i8o.v(68)
  wire port_porode_wr;  // rtl/port8i8o.v(74)
  wire port_porout_rd;  // rtl/port8i8o.v(67)
  wire port_porsel_rd;  // rtl/port8i8o.v(65)
  wire port_porsel_wr;  // rtl/port8i8o.v(69)

  assign bdatr[15] = 1'b0;
  assign bdatr[14] = 1'b0;
  assign bdatr[13] = 1'b0;
  assign bdatr[12] = 1'b0;
  assign bdatr[11] = 1'b0;
  assign bdatr[10] = 1'b0;
  assign bdatr[9] = 1'b0;
  assign bdatr[8] = 1'b0;
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u10 (
    .a(\pordir/port_dir [1]),
    .b(\pordir/port_ode [1]),
    .c(port_out[1]),
    .o(port_enb[1]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u11 (
    .a(\pordir/port_dir [2]),
    .b(\pordir/port_ode [2]),
    .c(port_out[2]),
    .o(port_enb[2]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u12 (
    .a(\pordir/port_dir [3]),
    .b(\pordir/port_ode [3]),
    .c(port_out[3]),
    .o(port_enb[3]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u13 (
    .a(\pordir/port_dir [4]),
    .b(\pordir/port_ode [4]),
    .c(port_out[4]),
    .o(port_enb[4]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u14 (
    .a(\pordir/port_dir [5]),
    .b(\pordir/port_ode [5]),
    .c(port_out[5]),
    .o(port_enb[5]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u15 (
    .a(\pordir/port_dir [6]),
    .b(\pordir/port_ode [6]),
    .c(port_out[6]),
    .o(port_enb[6]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u16 (
    .a(\pordir/port_dir [7]),
    .b(\pordir/port_ode [7]),
    .c(port_out[7]),
    .o(port_enb[7]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u17 (
    .a(bcmdr),
    .b(bcs_port_n),
    .o(\pctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u18 (
    .a(\pctl/n10 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\pctl/n12 ));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u19 (
    .a(port_porin_rd),
    .b(port_porind_rd),
    .c(\porin/porin2 [0]),
    .d(port_inp[0]),
    .o(_al_u19_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u20 (
    .a(_al_u19_o),
    .b(port_porout_rd),
    .c(port_out[0]),
    .o(_al_u20_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u21 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(\pordir/port_dir [0]),
    .d(\pordir/port_ode [0]),
    .o(_al_u21_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'hf757))
    _al_u22 (
    .a(_al_u20_o),
    .b(_al_u21_o),
    .c(port_porsel_rd),
    .d(port_sel[0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u23 (
    .a(port_porin_rd),
    .b(port_porind_rd),
    .c(\porin/porin2 [1]),
    .d(port_inp[1]),
    .o(_al_u23_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u24 (
    .a(_al_u23_o),
    .b(port_porout_rd),
    .c(port_out[1]),
    .o(_al_u24_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u25 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(\pordir/port_dir [1]),
    .d(\pordir/port_ode [1]),
    .o(_al_u25_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'hf757))
    _al_u26 (
    .a(_al_u24_o),
    .b(_al_u25_o),
    .c(port_porsel_rd),
    .d(port_sel[1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u27 (
    .a(port_porin_rd),
    .b(port_porind_rd),
    .c(\porin/porin2 [2]),
    .d(port_inp[2]),
    .o(_al_u27_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u28 (
    .a(_al_u27_o),
    .b(port_porout_rd),
    .c(port_out[2]),
    .o(_al_u28_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u29 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(\pordir/port_dir [2]),
    .d(\pordir/port_ode [2]),
    .o(_al_u29_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'hf757))
    _al_u30 (
    .a(_al_u28_o),
    .b(_al_u29_o),
    .c(port_porsel_rd),
    .d(port_sel[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u31 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(\pordir/port_dir [3]),
    .d(\pordir/port_ode [3]),
    .o(_al_u31_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u32 (
    .a(port_porin_rd),
    .b(port_porind_rd),
    .c(\porin/porin2 [3]),
    .d(port_inp[3]),
    .o(_al_u32_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h08c8))
    _al_u33 (
    .a(_al_u31_o),
    .b(_al_u32_o),
    .c(port_porsel_rd),
    .d(port_sel[3]),
    .o(_al_u33_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u34 (
    .a(_al_u33_o),
    .b(port_porout_rd),
    .c(port_out[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u35 (
    .a(port_porin_rd),
    .b(port_porind_rd),
    .c(\porin/porin2 [4]),
    .d(port_inp[4]),
    .o(_al_u35_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u36 (
    .a(_al_u35_o),
    .b(port_porout_rd),
    .c(port_out[4]),
    .o(_al_u36_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u37 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(\pordir/port_dir [4]),
    .d(\pordir/port_ode [4]),
    .o(_al_u37_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'hf757))
    _al_u38 (
    .a(_al_u36_o),
    .b(_al_u37_o),
    .c(port_porsel_rd),
    .d(port_sel[4]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u39 (
    .a(port_porin_rd),
    .b(port_porind_rd),
    .c(\porin/porin2 [5]),
    .d(port_inp[5]),
    .o(_al_u39_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u40 (
    .a(_al_u39_o),
    .b(port_porout_rd),
    .c(port_out[5]),
    .o(_al_u40_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u41 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(\pordir/port_dir [5]),
    .d(\pordir/port_ode [5]),
    .o(_al_u41_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'hf757))
    _al_u42 (
    .a(_al_u40_o),
    .b(_al_u41_o),
    .c(port_porsel_rd),
    .d(port_sel[5]),
    .o(bdatr[5]));
  AL_MAP_LUT5 #(
    .EQN("(~C*((E*B)*~(D)*~(A)+(E*B)*D*~(A)+~((E*B))*D*A+(E*B)*D*A))"),
    .INIT(32'h0e040a00))
    _al_u43 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(port_porsel_rd),
    .d(\pordir/port_dir [6]),
    .e(\pordir/port_ode [6]),
    .o(_al_u43_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u44 (
    .a(port_porin_rd),
    .b(port_porsel_rd),
    .c(port_sel[6]),
    .d(\porin/porin2 [6]),
    .o(_al_u44_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(E*D*~C))"),
    .INIT(32'h40444444))
    _al_u45 (
    .a(_al_u43_o),
    .b(_al_u44_o),
    .c(port_porin_rd),
    .d(port_porind_rd),
    .e(port_inp[6]),
    .o(_al_u45_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u46 (
    .a(_al_u45_o),
    .b(port_porout_rd),
    .c(port_out[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u47 (
    .a(port_pordir_rd),
    .b(port_porode_rd),
    .c(\pordir/port_dir [7]),
    .d(\pordir/port_ode [7]),
    .o(_al_u47_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u48 (
    .a(port_porin_rd),
    .b(port_porind_rd),
    .c(\porin/porin2 [7]),
    .d(port_inp[7]),
    .o(_al_u48_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h08c8))
    _al_u49 (
    .a(_al_u47_o),
    .b(_al_u48_o),
    .c(port_porsel_rd),
    .d(port_sel[7]),
    .o(_al_u49_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u50 (
    .a(_al_u49_o),
    .b(port_porout_rd),
    .c(port_out[7]),
    .o(bdatr[7]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u51 (
    .a(\pctl/n10 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\pctl/n17 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u52 (
    .a(bcmdw),
    .b(bcs_port_n),
    .c(brdy),
    .o(\pctl/n2 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u53 (
    .a(\pctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(port_porsel_wr));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u54 (
    .a(\pctl/n10 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\pctl/n15 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u55 (
    .a(\pctl/n10 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\pctl/n14 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u56 (
    .a(\pctl/n10 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\pctl/n18 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u57 (
    .a(\pctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(port_porode_wr));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u58 (
    .a(\pctl/n10 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\pctl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u59 (
    .a(\pctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(port_pordir_wr));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u60 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [7]),
    .c(bdatw[7]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [7]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u61 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [6]),
    .c(bdatw[6]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [6]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u62 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [5]),
    .c(bdatw[5]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [5]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u63 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [4]),
    .c(bdatw[4]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [4]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u64 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [3]),
    .c(bdatw[3]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [3]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u65 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [2]),
    .c(bdatw[2]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [2]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u66 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [1]),
    .c(bdatw[1]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [1]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))*~(E)+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*~(E)+~(D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E+D*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)*E)"),
    .INIT(32'he4e4ff00))
    _al_u67 (
    .a(port_pordir_wr),
    .b(\pordir/port_dir [0]),
    .c(bdatw[0]),
    .d(port_init_hizo),
    .e(rst_n),
    .o(\pordir/n3 [0]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u68 (
    .a(\pctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[0]),
    .o(_al_u68_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u69 (
    .a(\pctl/n2 ),
    .b(badr[3]),
    .c(badr[1]),
    .d(badr[0]),
    .o(_al_u69_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u70 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[7]),
    .d(bdatw[7]),
    .o(\porout/n5 [7]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u71 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[6]),
    .d(bdatw[6]),
    .o(\porout/n5 [6]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u72 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[5]),
    .d(bdatw[5]),
    .o(\porout/n5 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u73 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[4]),
    .d(bdatw[4]),
    .o(\porout/n5 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u74 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[3]),
    .d(bdatw[3]),
    .o(\porout/n5 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u75 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[2]),
    .d(bdatw[2]),
    .o(\porout/n5 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u76 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[1]),
    .d(bdatw[1]),
    .o(\porout/n5 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hba70))
    _al_u77 (
    .a(_al_u68_o),
    .b(_al_u69_o),
    .c(port_out[0]),
    .d(bdatw[0]),
    .o(\porout/n5 [0]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u9 (
    .a(\pordir/port_dir [0]),
    .b(\pordir/port_ode [0]),
    .c(port_out[0]),
    .o(port_enb[0]));
  reg_sr_as_w1 \pctl/port_pordir_rd_reg  (
    .clk(clk),
    .d(\pctl/n16 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_pordir_rd));  // rtl/port8i8o.v(225)
  reg_sr_as_w1 \pctl/port_porin_rd_reg  (
    .clk(clk),
    .d(\pctl/n12 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_porin_rd));  // rtl/port8i8o.v(225)
  reg_sr_as_w1 \pctl/port_porind_rd_reg  (
    .clk(clk),
    .d(\pctl/n14 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_porind_rd));  // rtl/port8i8o.v(225)
  reg_sr_as_w1 \pctl/port_porode_rd_reg  (
    .clk(clk),
    .d(\pctl/n18 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_porode_rd));  // rtl/port8i8o.v(225)
  reg_sr_as_w1 \pctl/port_porout_rd_reg  (
    .clk(clk),
    .d(\pctl/n17 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_porout_rd));  // rtl/port8i8o.v(225)
  reg_sr_as_w1 \pctl/port_porsel_rd_reg  (
    .clk(clk),
    .d(\pctl/n15 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_porsel_rd));  // rtl/port8i8o.v(225)
  reg_ar_as_w1 \pordir/reg0_b0  (
    .clk(clk),
    .d(\pordir/n3 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [0]));  // rtl/port8i8o.v(368)
  reg_ar_as_w1 \pordir/reg0_b1  (
    .clk(clk),
    .d(\pordir/n3 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [1]));  // rtl/port8i8o.v(368)
  reg_ar_as_w1 \pordir/reg0_b2  (
    .clk(clk),
    .d(\pordir/n3 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [2]));  // rtl/port8i8o.v(368)
  reg_ar_as_w1 \pordir/reg0_b3  (
    .clk(clk),
    .d(\pordir/n3 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [3]));  // rtl/port8i8o.v(368)
  reg_ar_as_w1 \pordir/reg0_b4  (
    .clk(clk),
    .d(\pordir/n3 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [4]));  // rtl/port8i8o.v(368)
  reg_ar_as_w1 \pordir/reg0_b5  (
    .clk(clk),
    .d(\pordir/n3 [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [5]));  // rtl/port8i8o.v(368)
  reg_ar_as_w1 \pordir/reg0_b6  (
    .clk(clk),
    .d(\pordir/n3 [6]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [6]));  // rtl/port8i8o.v(368)
  reg_ar_as_w1 \pordir/reg0_b7  (
    .clk(clk),
    .d(\pordir/n3 [7]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\pordir/port_dir [7]));  // rtl/port8i8o.v(368)
  reg_sr_as_w1 \pordir/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [0]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [1]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [2]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [3]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [4]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [5]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [6]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(port_porode_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(\pordir/port_ode [7]));  // rtl/port8i8o.v(378)
  reg_sr_as_w1 \pordir/reg2_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[0]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \pordir/reg2_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[1]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \pordir/reg2_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[2]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \pordir/reg2_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[3]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \pordir/reg2_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[4]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \pordir/reg2_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[5]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \pordir/reg2_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[6]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \pordir/reg2_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(port_porsel_wr),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_sel[7]));  // rtl/port8i8o.v(358)
  reg_sr_as_w1 \porin/reg0_b0  (
    .clk(clk),
    .d(\porin/porin1 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [0]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg0_b1  (
    .clk(clk),
    .d(\porin/porin1 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [1]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg0_b2  (
    .clk(clk),
    .d(\porin/porin1 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [2]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg0_b3  (
    .clk(clk),
    .d(\porin/porin1 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [3]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg0_b4  (
    .clk(clk),
    .d(\porin/porin1 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [4]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg0_b5  (
    .clk(clk),
    .d(\porin/porin1 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [5]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg0_b6  (
    .clk(clk),
    .d(\porin/porin1 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [6]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg0_b7  (
    .clk(clk),
    .d(\porin/porin1 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin2 [7]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b0  (
    .clk(clk),
    .d(port_inp[0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [0]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b1  (
    .clk(clk),
    .d(port_inp[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [1]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b2  (
    .clk(clk),
    .d(port_inp[2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [2]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b3  (
    .clk(clk),
    .d(port_inp[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [3]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b4  (
    .clk(clk),
    .d(port_inp[4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [4]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b5  (
    .clk(clk),
    .d(port_inp[5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [5]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b6  (
    .clk(clk),
    .d(port_inp[6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [6]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porin/reg1_b7  (
    .clk(clk),
    .d(port_inp[7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\porin/porin1 [7]));  // rtl/port8i8o.v(263)
  reg_sr_as_w1 \porout/reg0_b0  (
    .clk(clk),
    .d(\porout/n5 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[0]));  // rtl/port8i8o.v(309)
  reg_sr_as_w1 \porout/reg0_b1  (
    .clk(clk),
    .d(\porout/n5 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[1]));  // rtl/port8i8o.v(309)
  reg_sr_as_w1 \porout/reg0_b2  (
    .clk(clk),
    .d(\porout/n5 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[2]));  // rtl/port8i8o.v(309)
  reg_sr_as_w1 \porout/reg0_b3  (
    .clk(clk),
    .d(\porout/n5 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[3]));  // rtl/port8i8o.v(309)
  reg_sr_as_w1 \porout/reg0_b4  (
    .clk(clk),
    .d(\porout/n5 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[4]));  // rtl/port8i8o.v(309)
  reg_sr_as_w1 \porout/reg0_b5  (
    .clk(clk),
    .d(\porout/n5 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[5]));  // rtl/port8i8o.v(309)
  reg_sr_as_w1 \porout/reg0_b6  (
    .clk(clk),
    .d(\porout/n5 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[6]));  // rtl/port8i8o.v(309)
  reg_sr_as_w1 \porout/reg0_b7  (
    .clk(clk),
    .d(\porout/n5 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(port_out[7]));  // rtl/port8i8o.v(309)

endmodule 

