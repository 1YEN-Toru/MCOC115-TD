
`timescale 1ns / 1ps
module ram_wrap32  // rtl/ram_wrap32.v(1)
  (
  badr,
  bcmd,
  bcs_ram0_n,
  bcs_ram1_n,
  bcs_ram2_n,
  bcs_ram3_n,
  bcs_ram4_n,
  bcs_ram_n,
  bdatw,
  brdy,
  clk,
  ram_dou0,
  ram_dou1,
  ram_dou2,
  ram_dou3,
  ram_dou4,
  rst_n,
  bdatr,
  ram_ce0,
  ram_ce1,
  ram_ce2,
  ram_ce3,
  ram_ce4,
  ram_din,
  ram_we
  );
//
//	Moscovium RAM wrapper
//		(c) 2021	1YEN Toru
//
//
//	2023/03/11	ver.1.04
//		corresponding to long word bus
//		module name changed: ram_wrap32 (long word bus edition)
//
//	2021/06/12	ver.1.02
//		corresponding to 40KB RAM (8KB * 5 mat)
//
//	2021/03/20	ver.1.00
//

  input [15:0] badr;  // rtl/ram_wrap32.v(40)
  input [3:0] bcmd;  // rtl/ram_wrap32.v(39)
  input bcs_ram0_n;  // rtl/ram_wrap32.v(34)
  input bcs_ram1_n;  // rtl/ram_wrap32.v(35)
  input bcs_ram2_n;  // rtl/ram_wrap32.v(36)
  input bcs_ram3_n;  // rtl/ram_wrap32.v(37)
  input bcs_ram4_n;  // rtl/ram_wrap32.v(38)
  input bcs_ram_n;  // rtl/ram_wrap32.v(33)
  input [31:0] bdatw;  // rtl/ram_wrap32.v(41)
  input brdy;  // rtl/ram_wrap32.v(32)
  input clk;  // rtl/ram_wrap32.v(30)
  input [31:0] ram_dou0;  // rtl/ram_wrap32.v(44)
  input [31:0] ram_dou1;  // rtl/ram_wrap32.v(45)
  input [31:0] ram_dou2;  // rtl/ram_wrap32.v(46)
  input [31:0] ram_dou3;  // rtl/ram_wrap32.v(47)
  input [31:0] ram_dou4;  // rtl/ram_wrap32.v(48)
  input rst_n;  // rtl/ram_wrap32.v(31)
  output [31:0] bdatr;  // rtl/ram_wrap32.v(42)
  output ram_ce0;  // rtl/ram_wrap32.v(49)
  output ram_ce1;  // rtl/ram_wrap32.v(50)
  output ram_ce2;  // rtl/ram_wrap32.v(51)
  output ram_ce3;  // rtl/ram_wrap32.v(52)
  output ram_ce4;  // rtl/ram_wrap32.v(53)
  output [31:0] ram_din;  // rtl/ram_wrap32.v(55)
  output [3:0] ram_we;  // rtl/ram_wrap32.v(54)

  wire [31:0] n49;
  wire _al_u248_o;
  wire _al_u249_o;
  wire _al_u250_o;
  wire _al_u252_o;
  wire _al_u253_o;
  wire _al_u254_o;
  wire _al_u256_o;
  wire _al_u257_o;
  wire _al_u258_o;
  wire _al_u260_o;
  wire _al_u261_o;
  wire _al_u263_o;
  wire _al_u264_o;
  wire _al_u266_o;
  wire _al_u267_o;
  wire _al_u269_o;
  wire _al_u270_o;
  wire _al_u271_o;
  wire _al_u273_o;
  wire _al_u274_o;
  wire _al_u275_o;
  wire _al_u277_o;
  wire _al_u278_o;
  wire _al_u280_o;
  wire _al_u281_o;
  wire _al_u282_o;
  wire _al_u284_o;
  wire _al_u285_o;
  wire _al_u287_o;
  wire _al_u288_o;
  wire _al_u290_o;
  wire _al_u291_o;
  wire _al_u292_o;
  wire _al_u294_o;
  wire _al_u295_o;
  wire _al_u296_o;
  wire _al_u298_o;
  wire _al_u299_o;
  wire _al_u300_o;
  wire _al_u302_o;
  wire _al_u303_o;
  wire _al_u304_o;
  wire _al_u307_o;
  wire _al_u308_o;
  wire _al_u309_o;
  wire _al_u312_o;
  wire _al_u313_o;
  wire _al_u314_o;
  wire _al_u317_o;
  wire _al_u318_o;
  wire _al_u319_o;
  wire _al_u322_o;
  wire _al_u323_o;
  wire _al_u324_o;
  wire _al_u327_o;
  wire _al_u328_o;
  wire _al_u329_o;
  wire _al_u332_o;
  wire _al_u333_o;
  wire _al_u334_o;
  wire _al_u337_o;
  wire _al_u338_o;
  wire _al_u339_o;
  wire _al_u342_o;
  wire _al_u343_o;
  wire _al_u344_o;
  wire _al_u347_o;
  wire _al_u348_o;
  wire _al_u349_o;
  wire _al_u352_o;
  wire _al_u353_o;
  wire _al_u354_o;
  wire _al_u357_o;
  wire _al_u358_o;
  wire _al_u359_o;
  wire _al_u362_o;
  wire _al_u363_o;
  wire _al_u364_o;
  wire _al_u367_o;
  wire _al_u368_o;
  wire _al_u369_o;
  wire _al_u372_o;
  wire _al_u373_o;
  wire _al_u374_o;
  wire _al_u377_o;
  wire _al_u378_o;
  wire _al_u379_o;
  wire _al_u382_o;
  wire _al_u383_o;
  wire _al_u384_o;
  wire badr_1b;  // rtl/ram_wrap32.v(101)
  wire bcmd_3b;  // rtl/ram_wrap32.v(102)
  wire mux10_b0_sel_is_0_o;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire oea0;  // rtl/ram_wrap32.v(75)
  wire oea1;  // rtl/ram_wrap32.v(76)
  wire oea2;  // rtl/ram_wrap32.v(77)
  wire oea3;  // rtl/ram_wrap32.v(78)
  wire oea4;  // rtl/ram_wrap32.v(79)

  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u205 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[31]),
    .d(bdatw[15]),
    .o(ram_din[31]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u206 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[30]),
    .d(bdatw[14]),
    .o(ram_din[30]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u207 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[29]),
    .d(bdatw[13]),
    .o(ram_din[29]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u208 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[28]),
    .d(bdatw[12]),
    .o(ram_din[28]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u209 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[27]),
    .d(bdatw[11]),
    .o(ram_din[27]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u210 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[26]),
    .d(bdatw[10]),
    .o(ram_din[26]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u211 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[25]),
    .d(bdatw[9]),
    .o(ram_din[25]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u212 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[24]),
    .d(bdatw[8]),
    .o(ram_din[24]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u213 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[23]),
    .d(bdatw[7]),
    .o(ram_din[23]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u214 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[22]),
    .d(bdatw[6]),
    .o(ram_din[22]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u215 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[21]),
    .d(bdatw[5]),
    .o(ram_din[21]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u216 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[20]),
    .d(bdatw[4]),
    .o(ram_din[20]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u217 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[19]),
    .d(bdatw[3]),
    .o(ram_din[19]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u218 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[18]),
    .d(bdatw[2]),
    .o(ram_din[18]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u219 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[17]),
    .d(bdatw[1]),
    .o(ram_din[17]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(C)*~(B)+(D*~A)*C*~(B)+~((D*~A))*C*B+(D*~A)*C*B)"),
    .INIT(16'hd1c0))
    _al_u220 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[16]),
    .d(bdatw[0]),
    .o(ram_din[16]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u221 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[9]),
    .o(ram_din[9]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u222 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[8]),
    .o(ram_din[8]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u223 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[7]),
    .o(ram_din[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u224 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[6]),
    .o(ram_din[6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u225 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[5]),
    .o(ram_din[5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u226 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[4]),
    .o(ram_din[4]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u227 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[3]),
    .o(ram_din[3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u228 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[2]),
    .o(ram_din[2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u229 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[1]),
    .o(ram_din[1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u230 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[15]),
    .o(ram_din[15]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u231 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[14]),
    .o(ram_din[14]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u232 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[13]),
    .o(ram_din[13]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u233 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[12]),
    .o(ram_din[12]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u234 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[11]),
    .o(ram_din[11]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u235 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[10]),
    .o(ram_din[10]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u236 (
    .a(badr[1]),
    .b(bcmd[3]),
    .c(bdatw[0]),
    .o(ram_din[0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u237 (
    .a(bcmd[1]),
    .b(bcs_ram_n),
    .c(brdy),
    .o(n3));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~(~B*~A))"),
    .INIT(32'h000e0000))
    _al_u238 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_ram4_n),
    .d(bcs_ram_n),
    .e(brdy),
    .o(ram_ce4));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~(~B*~A))"),
    .INIT(32'h000e0000))
    _al_u239 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_ram3_n),
    .d(bcs_ram_n),
    .e(brdy),
    .o(ram_ce3));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~(~B*~A))"),
    .INIT(32'h000e0000))
    _al_u240 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_ram2_n),
    .d(bcs_ram_n),
    .e(brdy),
    .o(ram_ce2));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~(~B*~A))"),
    .INIT(32'h000e0000))
    _al_u241 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_ram1_n),
    .d(bcs_ram_n),
    .e(brdy),
    .o(ram_ce1));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~(~B*~A))"),
    .INIT(32'h000e0000))
    _al_u242 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .c(bcs_ram0_n),
    .d(bcs_ram_n),
    .e(brdy),
    .o(ram_ce0));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u243 (
    .a(ram_ce4),
    .b(bcmd[0]),
    .o(n30));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u244 (
    .a(ram_ce3),
    .b(bcmd[0]),
    .o(n29));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u245 (
    .a(ram_ce2),
    .b(bcmd[0]),
    .o(n28));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u246 (
    .a(ram_ce1),
    .b(bcmd[0]),
    .o(n27));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u247 (
    .a(ram_ce0),
    .b(bcmd[0]),
    .o(n26));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u248 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[31]),
    .d(ram_dou4[31]),
    .o(_al_u248_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u249 (
    .a(_al_u248_o),
    .b(oea2),
    .c(ram_dou2[31]),
    .o(_al_u249_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u250 (
    .a(_al_u249_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[31]),
    .o(_al_u250_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u251 (
    .a(_al_u250_o),
    .b(oea0),
    .c(ram_dou0[31]),
    .o(bdatr[31]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u252 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[30]),
    .d(ram_dou4[30]),
    .o(_al_u252_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u253 (
    .a(_al_u252_o),
    .b(oea2),
    .c(ram_dou2[30]),
    .o(_al_u253_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u254 (
    .a(_al_u253_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[30]),
    .o(_al_u254_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u255 (
    .a(_al_u254_o),
    .b(oea0),
    .c(ram_dou0[30]),
    .o(bdatr[30]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u256 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[29]),
    .d(ram_dou4[29]),
    .o(_al_u256_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u257 (
    .a(_al_u256_o),
    .b(oea2),
    .c(ram_dou2[29]),
    .o(_al_u257_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u258 (
    .a(_al_u257_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[29]),
    .o(_al_u258_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u259 (
    .a(_al_u258_o),
    .b(oea0),
    .c(ram_dou0[29]),
    .o(bdatr[29]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u260 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[28]),
    .d(ram_dou4[28]),
    .o(_al_u260_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u261 (
    .a(_al_u260_o),
    .b(oea1),
    .c(oea2),
    .d(ram_dou1[28]),
    .e(ram_dou2[28]),
    .o(_al_u261_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'hc808))
    _al_u262 (
    .a(_al_u261_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(ram_dou0[28]),
    .o(bdatr[28]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u263 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[27]),
    .d(ram_dou4[27]),
    .o(_al_u263_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u264 (
    .a(_al_u263_o),
    .b(oea1),
    .c(oea2),
    .d(ram_dou1[27]),
    .e(ram_dou2[27]),
    .o(_al_u264_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'hc808))
    _al_u265 (
    .a(_al_u264_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(ram_dou0[27]),
    .o(bdatr[27]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u266 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[26]),
    .d(ram_dou4[26]),
    .o(_al_u266_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u267 (
    .a(_al_u266_o),
    .b(oea1),
    .c(oea2),
    .d(ram_dou1[26]),
    .e(ram_dou2[26]),
    .o(_al_u267_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'hc808))
    _al_u268 (
    .a(_al_u267_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(ram_dou0[26]),
    .o(bdatr[26]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u269 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[25]),
    .d(ram_dou4[25]),
    .o(_al_u269_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u270 (
    .a(_al_u269_o),
    .b(oea2),
    .c(ram_dou2[25]),
    .o(_al_u270_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u271 (
    .a(_al_u270_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[25]),
    .o(_al_u271_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u272 (
    .a(_al_u271_o),
    .b(oea0),
    .c(ram_dou0[25]),
    .o(bdatr[25]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u273 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[24]),
    .d(ram_dou4[24]),
    .o(_al_u273_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u274 (
    .a(_al_u273_o),
    .b(oea2),
    .c(ram_dou2[24]),
    .o(_al_u274_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u275 (
    .a(_al_u274_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[24]),
    .o(_al_u275_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u276 (
    .a(_al_u275_o),
    .b(oea0),
    .c(ram_dou0[24]),
    .o(bdatr[24]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u277 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[23]),
    .d(ram_dou4[23]),
    .o(_al_u277_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u278 (
    .a(_al_u277_o),
    .b(oea1),
    .c(oea2),
    .d(ram_dou1[23]),
    .e(ram_dou2[23]),
    .o(_al_u278_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'hc808))
    _al_u279 (
    .a(_al_u278_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(ram_dou0[23]),
    .o(bdatr[23]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u280 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[22]),
    .d(ram_dou4[22]),
    .o(_al_u280_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u281 (
    .a(_al_u280_o),
    .b(oea2),
    .c(ram_dou2[22]),
    .o(_al_u281_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u282 (
    .a(_al_u281_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[22]),
    .o(_al_u282_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u283 (
    .a(_al_u282_o),
    .b(oea0),
    .c(ram_dou0[22]),
    .o(bdatr[22]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u284 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[21]),
    .d(ram_dou4[21]),
    .o(_al_u284_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u285 (
    .a(_al_u284_o),
    .b(oea1),
    .c(oea2),
    .d(ram_dou1[21]),
    .e(ram_dou2[21]),
    .o(_al_u285_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'hc808))
    _al_u286 (
    .a(_al_u285_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(ram_dou0[21]),
    .o(bdatr[21]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u287 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[20]),
    .d(ram_dou4[20]),
    .o(_al_u287_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u288 (
    .a(_al_u287_o),
    .b(oea1),
    .c(oea2),
    .d(ram_dou1[20]),
    .e(ram_dou2[20]),
    .o(_al_u288_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'hc808))
    _al_u289 (
    .a(_al_u288_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(ram_dou0[20]),
    .o(bdatr[20]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u290 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[19]),
    .d(ram_dou4[19]),
    .o(_al_u290_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u291 (
    .a(_al_u290_o),
    .b(oea2),
    .c(ram_dou2[19]),
    .o(_al_u291_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u292 (
    .a(_al_u291_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[19]),
    .o(_al_u292_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u293 (
    .a(_al_u292_o),
    .b(oea0),
    .c(ram_dou0[19]),
    .o(bdatr[19]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u294 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[18]),
    .d(ram_dou4[18]),
    .o(_al_u294_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u295 (
    .a(_al_u294_o),
    .b(oea2),
    .c(ram_dou2[18]),
    .o(_al_u295_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u296 (
    .a(_al_u295_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[18]),
    .o(_al_u296_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u297 (
    .a(_al_u296_o),
    .b(oea0),
    .c(ram_dou0[18]),
    .o(bdatr[18]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u298 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[17]),
    .d(ram_dou4[17]),
    .o(_al_u298_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u299 (
    .a(_al_u298_o),
    .b(oea2),
    .c(ram_dou2[17]),
    .o(_al_u299_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u300 (
    .a(_al_u299_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[17]),
    .o(_al_u300_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u301 (
    .a(_al_u300_o),
    .b(oea0),
    .c(ram_dou0[17]),
    .o(bdatr[17]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u302 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[16]),
    .d(ram_dou4[16]),
    .o(_al_u302_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u303 (
    .a(_al_u302_o),
    .b(oea2),
    .c(ram_dou2[16]),
    .o(_al_u303_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hccc4c0c4))
    _al_u304 (
    .a(_al_u303_o),
    .b(bcmd_3b),
    .c(oea0),
    .d(oea1),
    .e(ram_dou1[16]),
    .o(_al_u304_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u305 (
    .a(_al_u304_o),
    .b(oea0),
    .c(ram_dou0[16]),
    .o(bdatr[16]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u306 (
    .a(badr_1b),
    .b(bcmd_3b),
    .o(mux10_b0_sel_is_0_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u307 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[9]),
    .d(ram_dou4[9]),
    .o(_al_u307_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u308 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[25]),
    .c(ram_dou2[9]),
    .o(_al_u308_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u309 (
    .a(_al_u308_o),
    .b(_al_u269_o),
    .c(_al_u307_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u309_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u310 (
    .a(_al_u309_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[25]),
    .e(ram_dou1[9]),
    .o(n49[9]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u311 (
    .a(n49[9]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[25]),
    .e(ram_dou0[9]),
    .o(bdatr[9]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u312 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[8]),
    .d(ram_dou4[8]),
    .o(_al_u312_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u313 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[24]),
    .c(ram_dou2[8]),
    .o(_al_u313_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u314 (
    .a(_al_u313_o),
    .b(_al_u273_o),
    .c(_al_u312_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u314_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u315 (
    .a(_al_u314_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[24]),
    .e(ram_dou1[8]),
    .o(n49[8]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u316 (
    .a(n49[8]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[24]),
    .e(ram_dou0[8]),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u317 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[7]),
    .d(ram_dou4[7]),
    .o(_al_u317_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u318 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[23]),
    .c(ram_dou2[7]),
    .o(_al_u318_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u319 (
    .a(_al_u318_o),
    .b(_al_u277_o),
    .c(_al_u317_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u319_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u320 (
    .a(_al_u319_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[23]),
    .e(ram_dou1[7]),
    .o(n49[7]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u321 (
    .a(n49[7]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[23]),
    .e(ram_dou0[7]),
    .o(bdatr[7]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u322 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[6]),
    .d(ram_dou4[6]),
    .o(_al_u322_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u323 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[22]),
    .c(ram_dou2[6]),
    .o(_al_u323_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u324 (
    .a(_al_u323_o),
    .b(_al_u280_o),
    .c(_al_u322_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u324_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u325 (
    .a(_al_u324_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[22]),
    .e(ram_dou1[6]),
    .o(n49[6]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u326 (
    .a(n49[6]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[22]),
    .e(ram_dou0[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u327 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[5]),
    .d(ram_dou4[5]),
    .o(_al_u327_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u328 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[21]),
    .c(ram_dou2[5]),
    .o(_al_u328_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u329 (
    .a(_al_u328_o),
    .b(_al_u284_o),
    .c(_al_u327_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u329_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u330 (
    .a(_al_u329_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[21]),
    .e(ram_dou1[5]),
    .o(n49[5]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u331 (
    .a(n49[5]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[21]),
    .e(ram_dou0[5]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u332 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[4]),
    .d(ram_dou4[4]),
    .o(_al_u332_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u333 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[20]),
    .c(ram_dou2[4]),
    .o(_al_u333_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u334 (
    .a(_al_u333_o),
    .b(_al_u287_o),
    .c(_al_u332_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u334_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u335 (
    .a(_al_u334_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[20]),
    .e(ram_dou1[4]),
    .o(n49[4]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u336 (
    .a(n49[4]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[20]),
    .e(ram_dou0[4]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u337 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[3]),
    .d(ram_dou4[3]),
    .o(_al_u337_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u338 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[19]),
    .c(ram_dou2[3]),
    .o(_al_u338_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u339 (
    .a(_al_u338_o),
    .b(_al_u290_o),
    .c(_al_u337_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u339_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u340 (
    .a(_al_u339_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[19]),
    .e(ram_dou1[3]),
    .o(n49[3]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u341 (
    .a(n49[3]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[19]),
    .e(ram_dou0[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u342 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[2]),
    .d(ram_dou4[2]),
    .o(_al_u342_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u343 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[18]),
    .c(ram_dou2[2]),
    .o(_al_u343_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u344 (
    .a(_al_u343_o),
    .b(_al_u294_o),
    .c(_al_u342_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u344_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u345 (
    .a(_al_u344_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[18]),
    .e(ram_dou1[2]),
    .o(n49[2]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u346 (
    .a(n49[2]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[18]),
    .e(ram_dou0[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u347 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[1]),
    .d(ram_dou4[1]),
    .o(_al_u347_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u348 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[17]),
    .c(ram_dou2[1]),
    .o(_al_u348_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u349 (
    .a(_al_u348_o),
    .b(_al_u298_o),
    .c(_al_u347_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u349_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u350 (
    .a(_al_u349_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[17]),
    .e(ram_dou1[1]),
    .o(n49[1]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u351 (
    .a(n49[1]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[17]),
    .e(ram_dou0[1]),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u352 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[15]),
    .d(ram_dou4[15]),
    .o(_al_u352_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u353 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[31]),
    .c(ram_dou2[15]),
    .o(_al_u353_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u354 (
    .a(_al_u353_o),
    .b(_al_u248_o),
    .c(_al_u352_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u354_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u355 (
    .a(_al_u354_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[31]),
    .e(ram_dou1[15]),
    .o(n49[15]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u356 (
    .a(n49[15]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[31]),
    .e(ram_dou0[15]),
    .o(bdatr[15]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u357 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[14]),
    .d(ram_dou4[14]),
    .o(_al_u357_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u358 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[30]),
    .c(ram_dou2[14]),
    .o(_al_u358_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u359 (
    .a(_al_u358_o),
    .b(_al_u252_o),
    .c(_al_u357_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u359_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u360 (
    .a(_al_u359_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[30]),
    .e(ram_dou1[14]),
    .o(n49[14]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u361 (
    .a(n49[14]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[30]),
    .e(ram_dou0[14]),
    .o(bdatr[14]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u362 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[13]),
    .d(ram_dou4[13]),
    .o(_al_u362_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u363 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[29]),
    .c(ram_dou2[13]),
    .o(_al_u363_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u364 (
    .a(_al_u363_o),
    .b(_al_u256_o),
    .c(_al_u362_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u364_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u365 (
    .a(_al_u364_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[29]),
    .e(ram_dou1[13]),
    .o(n49[13]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u366 (
    .a(n49[13]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[29]),
    .e(ram_dou0[13]),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u367 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[12]),
    .d(ram_dou4[12]),
    .o(_al_u367_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u368 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[28]),
    .c(ram_dou2[12]),
    .o(_al_u368_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u369 (
    .a(_al_u368_o),
    .b(_al_u260_o),
    .c(_al_u367_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u369_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u370 (
    .a(_al_u369_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[28]),
    .e(ram_dou1[12]),
    .o(n49[12]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u371 (
    .a(n49[12]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[28]),
    .e(ram_dou0[12]),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u372 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[11]),
    .d(ram_dou4[11]),
    .o(_al_u372_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u373 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[27]),
    .c(ram_dou2[11]),
    .o(_al_u373_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u374 (
    .a(_al_u373_o),
    .b(_al_u263_o),
    .c(_al_u372_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u374_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u375 (
    .a(_al_u374_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[27]),
    .e(ram_dou1[11]),
    .o(n49[11]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u376 (
    .a(n49[11]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[27]),
    .e(ram_dou0[11]),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u377 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[10]),
    .d(ram_dou4[10]),
    .o(_al_u377_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u378 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[26]),
    .c(ram_dou2[10]),
    .o(_al_u378_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u379 (
    .a(_al_u378_o),
    .b(_al_u266_o),
    .c(_al_u377_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u379_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u380 (
    .a(_al_u379_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[26]),
    .e(ram_dou1[10]),
    .o(n49[10]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u381 (
    .a(n49[10]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[26]),
    .e(ram_dou0[10]),
    .o(bdatr[10]));
  AL_MAP_LUT4 #(
    .EQN("~((D*B)*~(C)*~(A)+(D*B)*C*~(A)+~((D*B))*C*A+(D*B)*C*A)"),
    .INIT(16'h1b5f))
    _al_u382 (
    .a(oea3),
    .b(oea4),
    .c(ram_dou3[0]),
    .d(ram_dou4[0]),
    .o(_al_u382_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u383 (
    .a(mux10_b0_sel_is_0_o),
    .b(ram_dou2[16]),
    .c(ram_dou2[0]),
    .o(_al_u383_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(A)*~(E)+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*~(E)+~((C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D))*A*E+(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*A*E)"),
    .INIT(32'haaaaccf0))
    _al_u384 (
    .a(_al_u383_o),
    .b(_al_u302_o),
    .c(_al_u382_o),
    .d(mux10_b0_sel_is_0_o),
    .e(oea2),
    .o(_al_u384_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(~A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+~A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hf535c505))
    _al_u385 (
    .a(_al_u384_o),
    .b(mux10_b0_sel_is_0_o),
    .c(oea1),
    .d(ram_dou1[16]),
    .e(ram_dou1[0]),
    .o(n49[0]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*~(C)+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)+~(A)*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C+A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C)"),
    .INIT(32'hfa3aca0a))
    _al_u386 (
    .a(n49[0]),
    .b(mux10_b0_sel_is_0_o),
    .c(oea0),
    .d(ram_dou0[16]),
    .e(ram_dou0[0]),
    .o(bdatr[0]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~D*~(B*~(E*~C))))"),
    .INIT(32'haa80aa88))
    _al_u387 (
    .a(n3),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmd[3]),
    .e(bcmd[2]),
    .o(ram_we[0]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~D*~(~B*~(E*C))))"),
    .INIT(32'haa02aa22))
    _al_u388 (
    .a(n3),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmd[3]),
    .e(bcmd[2]),
    .o(ram_we[3]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~D*~(B*~(E*C))))"),
    .INIT(32'haa08aa88))
    _al_u389 (
    .a(n3),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmd[3]),
    .e(bcmd[2]),
    .o(ram_we[1]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~D*~(~B*~(E*~C))))"),
    .INIT(32'haa20aa22))
    _al_u390 (
    .a(n3),
    .b(badr[1]),
    .c(badr[0]),
    .d(bcmd[3]),
    .e(bcmd[2]),
    .o(ram_we[2]));
  reg_sr_as_w1 badr_1b_reg (
    .clk(clk),
    .d(badr[1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(badr_1b));  // rtl/ram_wrap32.v(115)
  reg_sr_as_w1 bcmd_3b_reg (
    .clk(clk),
    .d(bcmd[3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(bcmd_3b));  // rtl/ram_wrap32.v(115)
  reg_sr_as_w1 oea0_reg (
    .clk(clk),
    .d(n26),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(oea0));  // rtl/ram_wrap32.v(136)
  reg_sr_as_w1 oea1_reg (
    .clk(clk),
    .d(n27),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(oea1));  // rtl/ram_wrap32.v(136)
  reg_sr_as_w1 oea2_reg (
    .clk(clk),
    .d(n28),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(oea2));  // rtl/ram_wrap32.v(136)
  reg_sr_as_w1 oea3_reg (
    .clk(clk),
    .d(n29),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(oea3));  // rtl/ram_wrap32.v(136)
  reg_sr_as_w1 oea4_reg (
    .clk(clk),
    .d(n30),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(oea4));  // rtl/ram_wrap32.v(136)

endmodule 

