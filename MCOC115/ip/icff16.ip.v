
`timescale 1ns / 1ps
module icff16  // rtl/icff16.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_icff_n,
  bdatw,
  bmst,
  brdy,
  clk,
  icff_dato12,
  icff_dato21,
  icff_empt12,
  icff_empt21,
  icff_full12,
  icff_full21,
  rst_n,
  bdatr,
  icff_dati12,
  icff_dati21,
  icff_frar1,
  icff_frar2,
  icff_ftar1,
  icff_ftar2,
  icff_re12,
  icff_re21,
  icff_rst12,
  icff_rst21,
  icff_we12,
  icff_we21
  );
//
// Intercommunication FIFO Unit
//		(c) 2021	1YEN Toru
//
//
//	2021/07/31	ver.1.00
//		16 bit fifo, dual core edition
//

  input [3:0] badr;  // rtl/icff16.v(40)
  input bcmdr;  // rtl/icff16.v(36)
  input bcmdw;  // rtl/icff16.v(37)
  input bcs_icff_n;  // rtl/icff16.v(39)
  input [15:0] bdatw;  // rtl/icff16.v(41)
  input bmst;  // rtl/icff16.v(38)
  input brdy;  // rtl/icff16.v(35)
  input clk;  // rtl/icff16.v(33)
  input [15:0] icff_dato12;  // rtl/icff16.v(52)
  input [15:0] icff_dato21;  // rtl/icff16.v(53)
  input icff_empt12;  // rtl/icff16.v(49)
  input icff_empt21;  // rtl/icff16.v(51)
  input icff_full12;  // rtl/icff16.v(48)
  input icff_full21;  // rtl/icff16.v(50)
  input rst_n;  // rtl/icff16.v(34)
  output [15:0] bdatr;  // rtl/icff16.v(46)
  output [15:0] icff_dati12;  // rtl/icff16.v(60)
  output [15:0] icff_dati21;  // rtl/icff16.v(61)
  output icff_frar1;  // rtl/icff16.v(42)
  output icff_frar2;  // rtl/icff16.v(44)
  output icff_ftar1;  // rtl/icff16.v(43)
  output icff_ftar2;  // rtl/icff16.v(45)
  output icff_re12;  // rtl/icff16.v(57)
  output icff_re21;  // rtl/icff16.v(59)
  output icff_rst12;  // rtl/icff16.v(54)
  output icff_rst21;  // rtl/icff16.v(55)
  output icff_we12;  // rtl/icff16.v(56)
  output icff_we21;  // rtl/icff16.v(58)

  wire [15:0] icffctl1;  // rtl/icff16.v(108)
  wire [15:0] icffctl2;  // rtl/icff16.v(123)
  wire [15:0] n24;
  wire [15:0] n26;
  wire _al_u68_o;
  wire _al_u70_o;
  wire _al_u72_o;
  wire _al_u74_o;
  wire _al_u76_o;
  wire _al_u83_o;
  wire _al_u85_o;
  wire mux7_b10_sel_is_0_o;
  wire n21_lutinv;
  wire n5_lutinv;
  wire n6;
  wire n7;
  wire rd_icffctl1;  // rtl/icff16.v(77)
  wire rd_icffctl2;  // rtl/icff16.v(78)
  wire rd_icffrecv1;  // rtl/icff16.v(79)
  wire rd_icffrecv2;  // rtl/icff16.v(80)
  wire wr_cpu1;  // rtl/icff16.v(100)
  wire wr_cpu2;  // rtl/icff16.v(101)
  wire wr_icffctl1;  // rtl/icff16.v(102)
  wire wr_icffctl2;  // rtl/icff16.v(103)

  assign icff_dati12[15] = bdatw[15];
  assign icff_dati12[14] = bdatw[14];
  assign icff_dati12[13] = bdatw[13];
  assign icff_dati12[12] = bdatw[12];
  assign icff_dati12[11] = bdatw[11];
  assign icff_dati12[10] = bdatw[10];
  assign icff_dati12[9] = bdatw[9];
  assign icff_dati12[8] = bdatw[8];
  assign icff_dati12[7] = bdatw[7];
  assign icff_dati12[6] = bdatw[6];
  assign icff_dati12[5] = bdatw[5];
  assign icff_dati12[4] = bdatw[4];
  assign icff_dati12[3] = bdatw[3];
  assign icff_dati12[2] = bdatw[2];
  assign icff_dati12[1] = bdatw[1];
  assign icff_dati21[0] = bdatw[0];
  assign icff_dati12[0] = bdatw[0];
  assign icff_dati21[15] = bdatw[15];
  assign icff_dati21[14] = bdatw[14];
  assign icff_dati21[13] = bdatw[13];
  assign icff_dati21[12] = bdatw[12];
  assign icff_dati21[11] = bdatw[11];
  assign icff_dati21[10] = bdatw[10];
  assign icff_dati21[9] = bdatw[9];
  assign icff_dati21[8] = bdatw[8];
  assign icff_dati21[7] = bdatw[7];
  assign icff_dati21[6] = bdatw[6];
  assign icff_dati21[5] = bdatw[5];
  assign icff_dati21[4] = bdatw[4];
  assign icff_dati21[3] = bdatw[3];
  assign icff_dati21[2] = bdatw[2];
  assign icff_dati21[1] = bdatw[1];
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u45 (
    .a(icffctl2[3]),
    .b(icff_empt12),
    .o(icff_frar2));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u46 (
    .a(icffctl1[3]),
    .b(icff_empt21),
    .o(icff_frar1));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u47 (
    .a(icffctl1[2]),
    .b(icff_full12),
    .o(icff_ftar1));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u48 (
    .a(icffctl2[2]),
    .b(icff_full21),
    .o(icff_ftar2));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u49 (
    .a(rd_icffctl1),
    .b(rd_icffctl2),
    .o(mux7_b10_sel_is_0_o));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u50 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[9]),
    .e(icff_dato21[9]),
    .o(bdatr[9]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u51 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[8]),
    .e(icff_dato21[8]),
    .o(bdatr[8]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u52 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[5]),
    .e(icff_dato21[5]),
    .o(bdatr[5]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u53 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[4]),
    .e(icff_dato21[4]),
    .o(bdatr[4]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u54 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[15]),
    .e(icff_dato21[15]),
    .o(bdatr[15]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u55 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[14]),
    .e(icff_dato21[14]),
    .o(bdatr[14]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u56 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[13]),
    .e(icff_dato21[13]),
    .o(bdatr[13]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u57 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[12]),
    .e(icff_dato21[12]),
    .o(bdatr[12]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u58 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[11]),
    .e(icff_dato21[11]),
    .o(bdatr[11]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u59 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[10]),
    .e(icff_dato21[10]),
    .o(bdatr[10]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u60 (
    .a(mux7_b10_sel_is_0_o),
    .b(rd_icffrecv1),
    .c(rd_icffrecv2),
    .d(icff_dato12[1]),
    .e(icff_dato21[1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u61 (
    .a(badr[3]),
    .b(badr[2]),
    .c(badr[1]),
    .d(badr[0]),
    .o(n5_lutinv));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u62 (
    .a(n5_lutinv),
    .b(bcmdr),
    .c(bcs_icff_n),
    .d(bmst),
    .e(brdy),
    .o(n7));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*B*A)"),
    .INIT(32'h00080000))
    _al_u63 (
    .a(n5_lutinv),
    .b(bcmdr),
    .c(bcs_icff_n),
    .d(bmst),
    .e(brdy),
    .o(n6));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u64 (
    .a(bcmdw),
    .b(bcs_icff_n),
    .c(bmst),
    .d(brdy),
    .o(wr_cpu2));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u65 (
    .a(n5_lutinv),
    .b(wr_cpu2),
    .o(wr_icffctl2));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u66 (
    .a(bcmdw),
    .b(bcs_icff_n),
    .c(bmst),
    .d(brdy),
    .o(wr_cpu1));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u67 (
    .a(n5_lutinv),
    .b(wr_cpu1),
    .o(wr_icffctl1));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u68 (
    .a(rd_icffrecv1),
    .b(rd_icffrecv2),
    .c(icff_dato12[7]),
    .d(icff_dato21[7]),
    .o(_al_u68_o));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'h0131cdfd))
    _al_u69 (
    .a(_al_u68_o),
    .b(rd_icffctl1),
    .c(rd_icffctl2),
    .d(icff_empt12),
    .e(icff_empt21),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u70 (
    .a(rd_icffrecv1),
    .b(rd_icffrecv2),
    .c(icff_dato12[6]),
    .d(icff_dato21[6]),
    .o(_al_u70_o));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*~(D)*~(B)+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*~(B)+~((A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C))*D*B+(A*~(E)*~(C)+A*E*~(C)+~(A)*E*C+A*E*C)*D*B)"),
    .INIT(32'h01cd31fd))
    _al_u71 (
    .a(_al_u70_o),
    .b(rd_icffctl1),
    .c(rd_icffctl2),
    .d(icff_full12),
    .e(icff_full21),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u72 (
    .a(rd_icffrecv1),
    .b(rd_icffrecv2),
    .c(icff_dato12[3]),
    .d(icff_dato21[3]),
    .o(_al_u72_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u73 (
    .a(_al_u72_o),
    .b(rd_icffctl1),
    .c(rd_icffctl2),
    .d(icffctl1[3]),
    .e(icffctl2[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u74 (
    .a(rd_icffrecv1),
    .b(rd_icffrecv2),
    .c(icff_dato12[2]),
    .d(icff_dato21[2]),
    .o(_al_u74_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u75 (
    .a(_al_u74_o),
    .b(rd_icffctl1),
    .c(rd_icffctl2),
    .d(icffctl1[2]),
    .e(icffctl2[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(D)*~(A)+(C*B)*D*~(A)+~((C*B))*D*A+(C*B)*D*A)"),
    .INIT(16'h15bf))
    _al_u76 (
    .a(rd_icffrecv1),
    .b(rd_icffrecv2),
    .c(icff_dato12[0]),
    .d(icff_dato21[0]),
    .o(_al_u76_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u77 (
    .a(_al_u76_o),
    .b(rd_icffctl1),
    .c(rd_icffctl2),
    .d(icff_rst21),
    .e(icff_rst12),
    .o(bdatr[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u78 (
    .a(wr_icffctl2),
    .b(icff_dati21[0]),
    .o(n26[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u79 (
    .a(wr_icffctl1),
    .b(icff_dati21[0]),
    .o(n24[0]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*~A)"),
    .INIT(16'h0004))
    _al_u80 (
    .a(badr[3]),
    .b(badr[2]),
    .c(badr[1]),
    .d(badr[0]),
    .o(n21_lutinv));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u81 (
    .a(wr_cpu2),
    .b(n21_lutinv),
    .c(icff_full21),
    .o(icff_we21));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u82 (
    .a(wr_cpu1),
    .b(n21_lutinv),
    .c(icff_full12),
    .o(icff_we12));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u83 (
    .a(bcmdr),
    .b(bcs_icff_n),
    .c(bmst),
    .d(brdy),
    .e(icff_empt12),
    .o(_al_u83_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u84 (
    .a(_al_u83_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(icff_re12));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u85 (
    .a(bcmdr),
    .b(bcs_icff_n),
    .c(bmst),
    .d(brdy),
    .e(icff_empt21),
    .o(_al_u85_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u86 (
    .a(_al_u85_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(icff_re21));
  reg_sr_as_w1 rd_icffctl1_reg (
    .clk(clk),
    .d(n6),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_icffctl1));  // rtl/icff16.v(97)
  reg_sr_as_w1 rd_icffctl2_reg (
    .clk(clk),
    .d(n7),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_icffctl2));  // rtl/icff16.v(97)
  reg_sr_as_w1 rd_icffrecv1_reg (
    .clk(clk),
    .d(icff_re21),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_icffrecv1));  // rtl/icff16.v(97)
  reg_sr_as_w1 rd_icffrecv2_reg (
    .clk(clk),
    .d(icff_re12),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(rd_icffrecv2));  // rtl/icff16.v(97)
  reg_ar_ss_w1 reg0_b0 (
    .clk(clk),
    .d(n24[0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(icff_rst21));  // rtl/icff16.v(117)
  reg_sr_as_w1 reg0_b2 (
    .clk(clk),
    .d(icff_dati12[2]),
    .en(wr_icffctl1),
    .reset(~rst_n),
    .set(1'b0),
    .q(icffctl1[2]));  // rtl/icff16.v(117)
  reg_sr_as_w1 reg0_b3 (
    .clk(clk),
    .d(icff_dati12[3]),
    .en(wr_icffctl1),
    .reset(~rst_n),
    .set(1'b0),
    .q(icffctl1[3]));  // rtl/icff16.v(117)
  reg_ar_ss_w1 reg1_b0 (
    .clk(clk),
    .d(n26[0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(icff_rst12));  // rtl/icff16.v(132)
  reg_sr_as_w1 reg1_b2 (
    .clk(clk),
    .d(icff_dati12[2]),
    .en(wr_icffctl2),
    .reset(~rst_n),
    .set(1'b0),
    .q(icffctl2[2]));  // rtl/icff16.v(132)
  reg_sr_as_w1 reg1_b3 (
    .clk(clk),
    .d(icff_dati12[3]),
    .en(wr_icffctl2),
    .reset(~rst_n),
    .set(1'b0),
    .q(icffctl2[3]));  // rtl/icff16.v(132)

endmodule 

