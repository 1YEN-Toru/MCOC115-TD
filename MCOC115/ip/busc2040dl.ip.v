
`timescale 1ns / 1ps
module busc2040dl  // rtl/busc2040dl.v(1)
  (
  badr1,
  badr2,
  badrx1,
  badrx2,
  bcmd1,
  bcmd2,
  bdatr,
  bdatw1,
  bdatw2,
  cch_hit,
  clk,
  rst_n,
  sdc_brdy,
  smph_ram1_n,
  smph_ram2_n,
  badr,
  badrx,
  bcmd,
  bcs_adcu_n,
  bcs_dacu_n,
  bcs_dist_n,
  bcs_fnjp_n,
  bcs_icff_n,
  bcs_idrg_n,
  bcs_int2_n,
  bcs_intc_n,
  bcs_iome_n,
  bcs_iram_n,
  bcs_loga_n,
  bcs_por1_n,
  bcs_port_n,
  bcs_ram0_n,
  bcs_ram1_n,
  bcs_ram2_n,
  bcs_ram3_n,
  bcs_ram4_n,
  bcs_ram_n,
  bcs_rom_n,
  bcs_rtcu_n,
  bcs_sdram_n,
  bcs_sdrc_n,
  bcs_smph_n,
  bcs_stws_n,
  bcs_sytm_n,
  bcs_tim0_n,
  bcs_tim1_n,
  bcs_uar1_n,
  bcs_uart_n,
  bcs_unsj_n,
  bdatr1,
  bdatr2,
  bdatw,
  bmst,
  brdy,
  brdy1,
  brdy2
  );
//
//	Bus State Controller
//		(c) 2021	1YEN Toru
//
//
//	2023/03/11	ver.1.34
//		corresponding to 32 bit memory bus
//		module name changed: busc2040d -> busc2040dl (32 bit bus edition)
//		add: bcs_iome_n
//
//	2023/01/21	ver.1.32
//		add: bcs_dacu_n
//
//	2022/10/22	ver.1.30
//		add: bcs_int2_n
//
//	2022/10/08	ver.1.28
//		add: bcs_rtcu_n
//
//	2022/09/03	ver.1.26
//		add: bcs_dist_n
//
//	2022/08/06	ver.1.24
//		add: bcs_unsj_n
//
//	2022/05/21	ver.1.22
//		optimized for SDRAM access with no SDRAMC8M unit
//
//	2022/03/12	ver.1.20
//		corresponding to CACHE2W4K unit
//
//	2022/02/19	ver.1.18
//		corresponding to SDRAMC8M unit
//		badrx (extended address) input
//		add: bcs_sdram_n, bcs_sdrc_n
//
//	2022/01/29	ver.1.16
//		add: bcs_adcu_n
//
//	2021/11/06	ver.1.14
//		add: bcs_iram_n, bcs_rom_n area reduced
//		add: bcs_uar1_n, bcs_por1_n
//
//	2021/10/16	ver.1.12
//		add: bcs_fnjp_n
//
//	2021/08/14	ver.1.10
//		add: bcs_stws_n
//
//	2021/07/31	ver.1.08
//		corresponding to dual core cpu
//		module name changed: busc2040 -> busc2040d (dual core edition)
//		add: bcs_smph_n, bcs_icff_n
//
//	2021/06/12	ver.1.06
//		add: bcs_ram[0-4]_n
//
//	2021/05/29	ver.1.04
//		add: bcs_loga_n
//
//	2021/05/01	ver.1.02
//		add: bcs_tim0_n, bcs_tim1_n, bcs_intc_n
//
//	2021/03/20	ver.1.00
//		ROM 20KB, RAM 40KB edition
//

  input [15:0] badr1;  // rtl/busc2040dl.v(69)
  input [15:0] badr2;  // rtl/busc2040dl.v(73)
  input [7:0] badrx1;  // rtl/busc2040dl.v(68)
  input [7:0] badrx2;  // rtl/busc2040dl.v(72)
  input [3:0] bcmd1;  // rtl/busc2040dl.v(67)
  input [3:0] bcmd2;  // rtl/busc2040dl.v(71)
  input [31:0] bdatr;  // rtl/busc2040dl.v(66)
  input [31:0] bdatw1;  // rtl/busc2040dl.v(70)
  input [31:0] bdatw2;  // rtl/busc2040dl.v(74)
  input cch_hit;  // rtl/busc2040dl.v(63)
  input clk;  // rtl/busc2040dl.v(60)
  input rst_n;  // rtl/busc2040dl.v(61)
  input sdc_brdy;  // rtl/busc2040dl.v(62)
  input [4:0] smph_ram1_n;  // rtl/busc2040dl.v(64)
  input [4:0] smph_ram2_n;  // rtl/busc2040dl.v(65)
  output [15:0] badr;  // rtl/busc2040dl.v(112)
  output [7:0] badrx;  // rtl/busc2040dl.v(111)
  output [3:0] bcmd;  // rtl/busc2040dl.v(110)
  output bcs_adcu_n;  // rtl/busc2040dl.v(102)
  output bcs_dacu_n;  // rtl/busc2040dl.v(108)
  output bcs_dist_n;  // rtl/busc2040dl.v(105)
  output bcs_fnjp_n;  // rtl/busc2040dl.v(99)
  output bcs_icff_n;  // rtl/busc2040dl.v(97)
  output bcs_idrg_n;  // rtl/busc2040dl.v(88)
  output bcs_int2_n;  // rtl/busc2040dl.v(107)
  output bcs_intc_n;  // rtl/busc2040dl.v(94)
  output bcs_iome_n;  // rtl/busc2040dl.v(109)
  output bcs_iram_n;  // rtl/busc2040dl.v(80)
  output bcs_loga_n;  // rtl/busc2040dl.v(95)
  output bcs_por1_n;  // rtl/busc2040dl.v(101)
  output bcs_port_n;  // rtl/busc2040dl.v(90)
  output bcs_ram0_n;  // rtl/busc2040dl.v(82)
  output bcs_ram1_n;  // rtl/busc2040dl.v(83)
  output bcs_ram2_n;  // rtl/busc2040dl.v(84)
  output bcs_ram3_n;  // rtl/busc2040dl.v(85)
  output bcs_ram4_n;  // rtl/busc2040dl.v(86)
  output bcs_ram_n;  // rtl/busc2040dl.v(81)
  output bcs_rom_n;  // rtl/busc2040dl.v(79)
  output bcs_rtcu_n;  // rtl/busc2040dl.v(106)
  output bcs_sdram_n;  // rtl/busc2040dl.v(87)
  output bcs_sdrc_n;  // rtl/busc2040dl.v(103)
  output bcs_smph_n;  // rtl/busc2040dl.v(96)
  output bcs_stws_n;  // rtl/busc2040dl.v(98)
  output bcs_sytm_n;  // rtl/busc2040dl.v(89)
  output bcs_tim0_n;  // rtl/busc2040dl.v(92)
  output bcs_tim1_n;  // rtl/busc2040dl.v(93)
  output bcs_uar1_n;  // rtl/busc2040dl.v(100)
  output bcs_uart_n;  // rtl/busc2040dl.v(91)
  output bcs_unsj_n;  // rtl/busc2040dl.v(104)
  output [31:0] bdatr1;  // rtl/busc2040dl.v(114)
  output [31:0] bdatr2;  // rtl/busc2040dl.v(115)
  output [31:0] bdatw;  // rtl/busc2040dl.v(113)
  output bmst;  // rtl/busc2040dl.v(75)
  output brdy;  // rtl/busc2040dl.v(76)
  output brdy1;  // rtl/busc2040dl.v(77)
  output brdy2;  // rtl/busc2040dl.v(78)

  wire [15:0] \acpu/badr1_c ;  // rtl/busc2040dl.v(475)
  wire [15:0] \acpu/badr2_c ;  // rtl/busc2040dl.v(479)
  wire [15:0] \acpu/badr_cp1 ;  // rtl/busc2040dl.v(522)
  wire [15:0] \acpu/badr_cp2 ;  // rtl/busc2040dl.v(523)
  wire [7:0] \acpu/badrx1_c ;  // rtl/busc2040dl.v(474)
  wire [7:0] \acpu/badrx2_c ;  // rtl/busc2040dl.v(478)
  wire [7:0] \acpu/badrx_cp1 ;  // rtl/busc2040dl.v(520)
  wire [7:0] \acpu/badrx_cp2 ;  // rtl/busc2040dl.v(521)
  wire [3:0] \acpu/bcmd1_c ;  // rtl/busc2040dl.v(473)
  wire [3:0] \acpu/bcmd2_c ;  // rtl/busc2040dl.v(477)
  wire [3:0] \acpu/bcmd_cp2 ;  // rtl/busc2040dl.v(519)
  wire [31:0] \acpu/bdatw1_c ;  // rtl/busc2040dl.v(476)
  wire [31:0] \acpu/bdatw2_c ;  // rtl/busc2040dl.v(480)
  wire [1:0] \acpu/blng1/stat ;  // rtl/busc_long_fsm.v(49)
  wire [1:0] \acpu/blng2/stat ;  // rtl/busc_long_fsm.v(49)
  wire [15:0] \acpu/datrh ;  // rtl/busc2040dl.v(481)
  wire [15:0] \acpu/datwl1 ;  // rtl/busc2040dl.v(482)
  wire [15:0] \acpu/datwl2 ;  // rtl/busc2040dl.v(483)
  wire [31:0] \acpu/n43 ;
  wire [31:0] \acpu/n44 ;
  wire [2:0] \bctl/stat ;  // rtl/busc_fsm.v(36)
  wire [22:0] n0;
  wire [22:0] n1;
  wire _al_u132_o;
  wire _al_u133_o;
  wire _al_u134_o;
  wire _al_u168_o;
  wire _al_u196_o;
  wire _al_u197_o;
  wire _al_u198_o;
  wire _al_u201_o;
  wire _al_u202_o;
  wire _al_u203_o;
  wire _al_u240_o;
  wire _al_u242_o;
  wire _al_u243_o;
  wire _al_u245_o;
  wire _al_u247_o;
  wire _al_u248_o;
  wire _al_u250_o;
  wire _al_u252_o;
  wire _al_u253_o;
  wire _al_u255_o;
  wire _al_u257_o;
  wire _al_u258_o;
  wire _al_u260_o;
  wire _al_u262_o;
  wire _al_u263_o;
  wire _al_u265_o;
  wire _al_u267_o;
  wire _al_u268_o;
  wire _al_u270_o;
  wire _al_u272_o;
  wire _al_u273_o;
  wire _al_u275_o;
  wire _al_u277_o;
  wire _al_u278_o;
  wire _al_u280_o;
  wire _al_u282_o;
  wire _al_u283_o;
  wire _al_u285_o;
  wire _al_u287_o;
  wire _al_u288_o;
  wire _al_u290_o;
  wire _al_u292_o;
  wire _al_u293_o;
  wire _al_u295_o;
  wire _al_u297_o;
  wire _al_u298_o;
  wire _al_u300_o;
  wire _al_u302_o;
  wire _al_u303_o;
  wire _al_u305_o;
  wire _al_u307_o;
  wire _al_u308_o;
  wire _al_u310_o;
  wire _al_u312_o;
  wire _al_u313_o;
  wire _al_u315_o;
  wire _al_u317_o;
  wire _al_u318_o;
  wire _al_u320_o;
  wire _al_u322_o;
  wire _al_u324_o;
  wire _al_u325_o;
  wire _al_u326_o;
  wire _al_u327_o;
  wire _al_u329_o;
  wire _al_u330_o;
  wire _al_u331_o;
  wire _al_u332_o;
  wire _al_u333_o;
  wire _al_u336_o;
  wire _al_u337_o;
  wire _al_u339_o;
  wire _al_u341_o;
  wire _al_u342_o;
  wire _al_u345_o;
  wire _al_u347_o;
  wire _al_u349_o;
  wire _al_u350_o;
  wire _al_u352_o;
  wire _al_u353_o;
  wire _al_u354_o;
  wire _al_u356_o;
  wire _al_u358_o;
  wire _al_u360_o;
  wire _al_u362_o;
  wire _al_u364_o;
  wire _al_u366_o;
  wire _al_u368_o;
  wire _al_u370_o;
  wire _al_u372_o;
  wire _al_u374_o;
  wire _al_u376_o;
  wire _al_u378_o;
  wire _al_u380_o;
  wire _al_u382_o;
  wire _al_u384_o;
  wire _al_u386_o;
  wire \acpu/add0/c0 ;
  wire \acpu/add0/c1 ;
  wire \acpu/add0/c10 ;
  wire \acpu/add0/c11 ;
  wire \acpu/add0/c12 ;
  wire \acpu/add0/c13 ;
  wire \acpu/add0/c14 ;
  wire \acpu/add0/c15 ;
  wire \acpu/add0/c16 ;
  wire \acpu/add0/c17 ;
  wire \acpu/add0/c18 ;
  wire \acpu/add0/c19 ;
  wire \acpu/add0/c2 ;
  wire \acpu/add0/c20 ;
  wire \acpu/add0/c21 ;
  wire \acpu/add0/c22 ;
  wire \acpu/add0/c3 ;
  wire \acpu/add0/c4 ;
  wire \acpu/add0/c5 ;
  wire \acpu/add0/c6 ;
  wire \acpu/add0/c7 ;
  wire \acpu/add0/c8 ;
  wire \acpu/add0/c9 ;
  wire \acpu/add1/c0 ;
  wire \acpu/add1/c1 ;
  wire \acpu/add1/c10 ;
  wire \acpu/add1/c11 ;
  wire \acpu/add1/c12 ;
  wire \acpu/add1/c13 ;
  wire \acpu/add1/c14 ;
  wire \acpu/add1/c15 ;
  wire \acpu/add1/c16 ;
  wire \acpu/add1/c17 ;
  wire \acpu/add1/c18 ;
  wire \acpu/add1/c19 ;
  wire \acpu/add1/c2 ;
  wire \acpu/add1/c20 ;
  wire \acpu/add1/c21 ;
  wire \acpu/add1/c22 ;
  wire \acpu/add1/c3 ;
  wire \acpu/add1/c4 ;
  wire \acpu/add1/c5 ;
  wire \acpu/add1/c6 ;
  wire \acpu/add1/c7 ;
  wire \acpu/add1/c8 ;
  wire \acpu/add1/c9 ;
  wire \acpu/bacp_adr_inc1 ;  // rtl/busc2040dl.v(608)
  wire \acpu/bacp_adr_inc2 ;  // rtl/busc2040dl.v(625)
  wire \acpu/bacp_drv_datr1_lutinv ;  // rtl/busc2040dl.v(610)
  wire \acpu/bacp_drv_datr2_lutinv ;  // rtl/busc2040dl.v(627)
  wire \acpu/bacp_drv_datwh1 ;  // rtl/busc2040dl.v(612)
  wire \acpu/bacp_drv_datwh2 ;  // rtl/busc2040dl.v(629)
  wire \acpu/blng1/mux0_b0_sel_is_3_o ;
  wire \acpu/blng1/mux0_b1_sel_is_3_o ;
  wire \acpu/blng1/n50 ;
  wire \acpu/blng2/mux0_b0_sel_is_3_o ;
  wire \acpu/blng2/mux0_b1_sel_is_3_o ;
  wire \acpu/last_sel ;  // rtl/busc2040dl.v(501)
  wire \acpu/n10 ;
  wire \acpu/n23 ;
  wire \acpu/n4 ;
  wire \acpu/neg_brdy1 ;  // rtl/busc2040dl.v(471)
  wire \acpu/neg_brdy2 ;  // rtl/busc2040dl.v(472)
  wire \adec/lt0_c0 ;
  wire \adec/lt0_c1 ;
  wire \adec/lt0_c10 ;
  wire \adec/lt0_c11 ;
  wire \adec/lt0_c12 ;
  wire \adec/lt0_c13 ;
  wire \adec/lt0_c14 ;
  wire \adec/lt0_c15 ;
  wire \adec/lt0_c16 ;
  wire \adec/lt0_c2 ;
  wire \adec/lt0_c3 ;
  wire \adec/lt0_c4 ;
  wire \adec/lt0_c5 ;
  wire \adec/lt0_c6 ;
  wire \adec/lt0_c7 ;
  wire \adec/lt0_c8 ;
  wire \adec/lt0_c9 ;
  wire \adec/lt10_c0 ;
  wire \adec/lt10_c1 ;
  wire \adec/lt10_c10 ;
  wire \adec/lt10_c11 ;
  wire \adec/lt10_c12 ;
  wire \adec/lt10_c13 ;
  wire \adec/lt10_c14 ;
  wire \adec/lt10_c15 ;
  wire \adec/lt10_c16 ;
  wire \adec/lt10_c2 ;
  wire \adec/lt10_c3 ;
  wire \adec/lt10_c4 ;
  wire \adec/lt10_c5 ;
  wire \adec/lt10_c6 ;
  wire \adec/lt10_c7 ;
  wire \adec/lt10_c8 ;
  wire \adec/lt10_c9 ;
  wire \adec/lt11_c0 ;
  wire \adec/lt11_c1 ;
  wire \adec/lt11_c10 ;
  wire \adec/lt11_c11 ;
  wire \adec/lt11_c12 ;
  wire \adec/lt11_c13 ;
  wire \adec/lt11_c14 ;
  wire \adec/lt11_c15 ;
  wire \adec/lt11_c16 ;
  wire \adec/lt11_c2 ;
  wire \adec/lt11_c3 ;
  wire \adec/lt11_c4 ;
  wire \adec/lt11_c5 ;
  wire \adec/lt11_c6 ;
  wire \adec/lt11_c7 ;
  wire \adec/lt11_c8 ;
  wire \adec/lt11_c9 ;
  wire \adec/lt12_c0 ;
  wire \adec/lt12_c1 ;
  wire \adec/lt12_c10 ;
  wire \adec/lt12_c11 ;
  wire \adec/lt12_c12 ;
  wire \adec/lt12_c13 ;
  wire \adec/lt12_c14 ;
  wire \adec/lt12_c15 ;
  wire \adec/lt12_c16 ;
  wire \adec/lt12_c2 ;
  wire \adec/lt12_c3 ;
  wire \adec/lt12_c4 ;
  wire \adec/lt12_c5 ;
  wire \adec/lt12_c6 ;
  wire \adec/lt12_c7 ;
  wire \adec/lt12_c8 ;
  wire \adec/lt12_c9 ;
  wire \adec/lt13/o_2_lutinv ;
  wire \adec/lt1_c0 ;
  wire \adec/lt1_c1 ;
  wire \adec/lt1_c10 ;
  wire \adec/lt1_c11 ;
  wire \adec/lt1_c12 ;
  wire \adec/lt1_c13 ;
  wire \adec/lt1_c14 ;
  wire \adec/lt1_c15 ;
  wire \adec/lt1_c16 ;
  wire \adec/lt1_c2 ;
  wire \adec/lt1_c3 ;
  wire \adec/lt1_c4 ;
  wire \adec/lt1_c5 ;
  wire \adec/lt1_c6 ;
  wire \adec/lt1_c7 ;
  wire \adec/lt1_c8 ;
  wire \adec/lt1_c9 ;
  wire \adec/lt23_c0 ;
  wire \adec/lt23_c1 ;
  wire \adec/lt23_c2 ;
  wire \adec/lt23_c3 ;
  wire \adec/lt23_c4 ;
  wire \adec/lt23_c5 ;
  wire \adec/lt23_c6 ;
  wire \adec/lt23_c7 ;
  wire \adec/lt23_c8 ;
  wire \adec/lt24_c0 ;
  wire \adec/lt24_c1 ;
  wire \adec/lt24_c2 ;
  wire \adec/lt24_c3 ;
  wire \adec/lt24_c4 ;
  wire \adec/lt24_c5 ;
  wire \adec/lt24_c6 ;
  wire \adec/lt24_c7 ;
  wire \adec/lt24_c8 ;
  wire \adec/lt25_c0 ;
  wire \adec/lt25_c1 ;
  wire \adec/lt25_c2 ;
  wire \adec/lt25_c3 ;
  wire \adec/lt25_c4 ;
  wire \adec/lt25_c5 ;
  wire \adec/lt25_c6 ;
  wire \adec/lt25_c7 ;
  wire \adec/lt25_c8 ;
  wire \adec/lt26_c0 ;
  wire \adec/lt26_c1 ;
  wire \adec/lt26_c2 ;
  wire \adec/lt26_c3 ;
  wire \adec/lt26_c4 ;
  wire \adec/lt26_c5 ;
  wire \adec/lt26_c6 ;
  wire \adec/lt26_c7 ;
  wire \adec/lt26_c8 ;
  wire \adec/lt27_c0 ;
  wire \adec/lt27_c1 ;
  wire \adec/lt27_c2 ;
  wire \adec/lt27_c3 ;
  wire \adec/lt27_c4 ;
  wire \adec/lt27_c5 ;
  wire \adec/lt27_c6 ;
  wire \adec/lt27_c7 ;
  wire \adec/lt27_c8 ;
  wire \adec/lt28_c0 ;
  wire \adec/lt28_c1 ;
  wire \adec/lt28_c2 ;
  wire \adec/lt28_c3 ;
  wire \adec/lt28_c4 ;
  wire \adec/lt28_c5 ;
  wire \adec/lt28_c6 ;
  wire \adec/lt28_c7 ;
  wire \adec/lt28_c8 ;
  wire \adec/lt29_c0 ;
  wire \adec/lt29_c1 ;
  wire \adec/lt29_c2 ;
  wire \adec/lt29_c3 ;
  wire \adec/lt29_c4 ;
  wire \adec/lt29_c5 ;
  wire \adec/lt29_c6 ;
  wire \adec/lt29_c7 ;
  wire \adec/lt29_c8 ;
  wire \adec/lt2_c0 ;
  wire \adec/lt2_c1 ;
  wire \adec/lt2_c10 ;
  wire \adec/lt2_c11 ;
  wire \adec/lt2_c12 ;
  wire \adec/lt2_c13 ;
  wire \adec/lt2_c14 ;
  wire \adec/lt2_c15 ;
  wire \adec/lt2_c16 ;
  wire \adec/lt2_c2 ;
  wire \adec/lt2_c3 ;
  wire \adec/lt2_c4 ;
  wire \adec/lt2_c5 ;
  wire \adec/lt2_c6 ;
  wire \adec/lt2_c7 ;
  wire \adec/lt2_c8 ;
  wire \adec/lt2_c9 ;
  wire \adec/lt30_c0 ;
  wire \adec/lt30_c1 ;
  wire \adec/lt30_c2 ;
  wire \adec/lt30_c3 ;
  wire \adec/lt30_c4 ;
  wire \adec/lt30_c5 ;
  wire \adec/lt30_c6 ;
  wire \adec/lt30_c7 ;
  wire \adec/lt30_c8 ;
  wire \adec/lt31_c0 ;
  wire \adec/lt31_c1 ;
  wire \adec/lt31_c2 ;
  wire \adec/lt31_c3 ;
  wire \adec/lt31_c4 ;
  wire \adec/lt31_c5 ;
  wire \adec/lt31_c6 ;
  wire \adec/lt31_c7 ;
  wire \adec/lt31_c8 ;
  wire \adec/lt32_c0 ;
  wire \adec/lt32_c1 ;
  wire \adec/lt32_c2 ;
  wire \adec/lt32_c3 ;
  wire \adec/lt32_c4 ;
  wire \adec/lt32_c5 ;
  wire \adec/lt32_c6 ;
  wire \adec/lt32_c7 ;
  wire \adec/lt32_c8 ;
  wire \adec/lt33_c0 ;
  wire \adec/lt33_c1 ;
  wire \adec/lt33_c2 ;
  wire \adec/lt33_c3 ;
  wire \adec/lt33_c4 ;
  wire \adec/lt33_c5 ;
  wire \adec/lt33_c6 ;
  wire \adec/lt33_c7 ;
  wire \adec/lt33_c8 ;
  wire \adec/lt34_c0 ;
  wire \adec/lt34_c1 ;
  wire \adec/lt34_c2 ;
  wire \adec/lt34_c3 ;
  wire \adec/lt34_c4 ;
  wire \adec/lt34_c5 ;
  wire \adec/lt34_c6 ;
  wire \adec/lt34_c7 ;
  wire \adec/lt34_c8 ;
  wire \adec/lt35_c0 ;
  wire \adec/lt35_c1 ;
  wire \adec/lt35_c2 ;
  wire \adec/lt35_c3 ;
  wire \adec/lt35_c4 ;
  wire \adec/lt35_c5 ;
  wire \adec/lt35_c6 ;
  wire \adec/lt35_c7 ;
  wire \adec/lt35_c8 ;
  wire \adec/lt36_c0 ;
  wire \adec/lt36_c1 ;
  wire \adec/lt36_c2 ;
  wire \adec/lt36_c3 ;
  wire \adec/lt36_c4 ;
  wire \adec/lt36_c5 ;
  wire \adec/lt36_c6 ;
  wire \adec/lt36_c7 ;
  wire \adec/lt36_c8 ;
  wire \adec/lt37_c0 ;
  wire \adec/lt37_c1 ;
  wire \adec/lt37_c2 ;
  wire \adec/lt37_c3 ;
  wire \adec/lt37_c4 ;
  wire \adec/lt37_c5 ;
  wire \adec/lt37_c6 ;
  wire \adec/lt37_c7 ;
  wire \adec/lt37_c8 ;
  wire \adec/lt38_c0 ;
  wire \adec/lt38_c1 ;
  wire \adec/lt38_c2 ;
  wire \adec/lt38_c3 ;
  wire \adec/lt38_c4 ;
  wire \adec/lt38_c5 ;
  wire \adec/lt38_c6 ;
  wire \adec/lt38_c7 ;
  wire \adec/lt38_c8 ;
  wire \adec/lt39_c0 ;
  wire \adec/lt39_c1 ;
  wire \adec/lt39_c2 ;
  wire \adec/lt39_c3 ;
  wire \adec/lt39_c4 ;
  wire \adec/lt39_c5 ;
  wire \adec/lt39_c6 ;
  wire \adec/lt39_c7 ;
  wire \adec/lt39_c8 ;
  wire \adec/lt3_c0 ;
  wire \adec/lt3_c1 ;
  wire \adec/lt3_c10 ;
  wire \adec/lt3_c11 ;
  wire \adec/lt3_c12 ;
  wire \adec/lt3_c13 ;
  wire \adec/lt3_c14 ;
  wire \adec/lt3_c15 ;
  wire \adec/lt3_c16 ;
  wire \adec/lt3_c2 ;
  wire \adec/lt3_c3 ;
  wire \adec/lt3_c4 ;
  wire \adec/lt3_c5 ;
  wire \adec/lt3_c6 ;
  wire \adec/lt3_c7 ;
  wire \adec/lt3_c8 ;
  wire \adec/lt3_c9 ;
  wire \adec/lt40_c0 ;
  wire \adec/lt40_c1 ;
  wire \adec/lt40_c2 ;
  wire \adec/lt40_c3 ;
  wire \adec/lt40_c4 ;
  wire \adec/lt40_c5 ;
  wire \adec/lt40_c6 ;
  wire \adec/lt40_c7 ;
  wire \adec/lt40_c8 ;
  wire \adec/lt41_c0 ;
  wire \adec/lt41_c1 ;
  wire \adec/lt41_c2 ;
  wire \adec/lt41_c3 ;
  wire \adec/lt41_c4 ;
  wire \adec/lt41_c5 ;
  wire \adec/lt41_c6 ;
  wire \adec/lt41_c7 ;
  wire \adec/lt41_c8 ;
  wire \adec/lt42_c0 ;
  wire \adec/lt42_c1 ;
  wire \adec/lt42_c2 ;
  wire \adec/lt42_c3 ;
  wire \adec/lt42_c4 ;
  wire \adec/lt42_c5 ;
  wire \adec/lt42_c6 ;
  wire \adec/lt42_c7 ;
  wire \adec/lt42_c8 ;
  wire \adec/lt43_c0 ;
  wire \adec/lt43_c1 ;
  wire \adec/lt43_c2 ;
  wire \adec/lt43_c3 ;
  wire \adec/lt43_c4 ;
  wire \adec/lt43_c5 ;
  wire \adec/lt43_c6 ;
  wire \adec/lt43_c7 ;
  wire \adec/lt43_c8 ;
  wire \adec/lt44_c0 ;
  wire \adec/lt44_c1 ;
  wire \adec/lt44_c2 ;
  wire \adec/lt44_c3 ;
  wire \adec/lt44_c4 ;
  wire \adec/lt44_c5 ;
  wire \adec/lt44_c6 ;
  wire \adec/lt44_c7 ;
  wire \adec/lt44_c8 ;
  wire \adec/lt45_c0 ;
  wire \adec/lt45_c1 ;
  wire \adec/lt45_c2 ;
  wire \adec/lt45_c3 ;
  wire \adec/lt45_c4 ;
  wire \adec/lt45_c5 ;
  wire \adec/lt45_c6 ;
  wire \adec/lt45_c7 ;
  wire \adec/lt45_c8 ;
  wire \adec/lt46_c0 ;
  wire \adec/lt46_c1 ;
  wire \adec/lt46_c2 ;
  wire \adec/lt46_c3 ;
  wire \adec/lt46_c4 ;
  wire \adec/lt46_c5 ;
  wire \adec/lt46_c6 ;
  wire \adec/lt46_c7 ;
  wire \adec/lt46_c8 ;
  wire \adec/lt47_c0 ;
  wire \adec/lt47_c1 ;
  wire \adec/lt47_c2 ;
  wire \adec/lt47_c3 ;
  wire \adec/lt47_c4 ;
  wire \adec/lt47_c5 ;
  wire \adec/lt47_c6 ;
  wire \adec/lt47_c7 ;
  wire \adec/lt47_c8 ;
  wire \adec/lt48_c0 ;
  wire \adec/lt48_c1 ;
  wire \adec/lt48_c2 ;
  wire \adec/lt48_c3 ;
  wire \adec/lt48_c4 ;
  wire \adec/lt48_c5 ;
  wire \adec/lt48_c6 ;
  wire \adec/lt48_c7 ;
  wire \adec/lt48_c8 ;
  wire \adec/lt49_c0 ;
  wire \adec/lt49_c1 ;
  wire \adec/lt49_c2 ;
  wire \adec/lt49_c3 ;
  wire \adec/lt49_c4 ;
  wire \adec/lt49_c5 ;
  wire \adec/lt49_c6 ;
  wire \adec/lt49_c7 ;
  wire \adec/lt49_c8 ;
  wire \adec/lt4_c0 ;
  wire \adec/lt4_c1 ;
  wire \adec/lt4_c10 ;
  wire \adec/lt4_c11 ;
  wire \adec/lt4_c12 ;
  wire \adec/lt4_c13 ;
  wire \adec/lt4_c14 ;
  wire \adec/lt4_c15 ;
  wire \adec/lt4_c16 ;
  wire \adec/lt4_c2 ;
  wire \adec/lt4_c3 ;
  wire \adec/lt4_c4 ;
  wire \adec/lt4_c5 ;
  wire \adec/lt4_c6 ;
  wire \adec/lt4_c7 ;
  wire \adec/lt4_c8 ;
  wire \adec/lt4_c9 ;
  wire \adec/lt50_c0 ;
  wire \adec/lt50_c1 ;
  wire \adec/lt50_c2 ;
  wire \adec/lt50_c3 ;
  wire \adec/lt50_c4 ;
  wire \adec/lt50_c5 ;
  wire \adec/lt50_c6 ;
  wire \adec/lt50_c7 ;
  wire \adec/lt50_c8 ;
  wire \adec/lt51_c0 ;
  wire \adec/lt51_c1 ;
  wire \adec/lt51_c2 ;
  wire \adec/lt51_c3 ;
  wire \adec/lt51_c4 ;
  wire \adec/lt51_c5 ;
  wire \adec/lt51_c6 ;
  wire \adec/lt51_c7 ;
  wire \adec/lt51_c8 ;
  wire \adec/lt52_c0 ;
  wire \adec/lt52_c1 ;
  wire \adec/lt52_c2 ;
  wire \adec/lt52_c3 ;
  wire \adec/lt52_c4 ;
  wire \adec/lt52_c5 ;
  wire \adec/lt52_c6 ;
  wire \adec/lt52_c7 ;
  wire \adec/lt52_c8 ;
  wire \adec/lt53_c0 ;
  wire \adec/lt53_c1 ;
  wire \adec/lt53_c2 ;
  wire \adec/lt53_c3 ;
  wire \adec/lt53_c4 ;
  wire \adec/lt53_c5 ;
  wire \adec/lt53_c6 ;
  wire \adec/lt53_c7 ;
  wire \adec/lt53_c8 ;
  wire \adec/lt54_c0 ;
  wire \adec/lt54_c1 ;
  wire \adec/lt54_c2 ;
  wire \adec/lt54_c3 ;
  wire \adec/lt54_c4 ;
  wire \adec/lt54_c5 ;
  wire \adec/lt54_c6 ;
  wire \adec/lt54_c7 ;
  wire \adec/lt54_c8 ;
  wire \adec/lt55_c0 ;
  wire \adec/lt55_c1 ;
  wire \adec/lt55_c2 ;
  wire \adec/lt55_c3 ;
  wire \adec/lt55_c4 ;
  wire \adec/lt55_c5 ;
  wire \adec/lt55_c6 ;
  wire \adec/lt55_c7 ;
  wire \adec/lt55_c8 ;
  wire \adec/lt56_c0 ;
  wire \adec/lt56_c1 ;
  wire \adec/lt56_c2 ;
  wire \adec/lt56_c3 ;
  wire \adec/lt56_c4 ;
  wire \adec/lt56_c5 ;
  wire \adec/lt56_c6 ;
  wire \adec/lt56_c7 ;
  wire \adec/lt56_c8 ;
  wire \adec/lt57_c0 ;
  wire \adec/lt57_c1 ;
  wire \adec/lt57_c2 ;
  wire \adec/lt57_c3 ;
  wire \adec/lt57_c4 ;
  wire \adec/lt57_c5 ;
  wire \adec/lt57_c6 ;
  wire \adec/lt57_c7 ;
  wire \adec/lt57_c8 ;
  wire \adec/lt58_c0 ;
  wire \adec/lt58_c1 ;
  wire \adec/lt58_c2 ;
  wire \adec/lt58_c3 ;
  wire \adec/lt58_c4 ;
  wire \adec/lt58_c5 ;
  wire \adec/lt58_c6 ;
  wire \adec/lt58_c7 ;
  wire \adec/lt58_c8 ;
  wire \adec/lt59_c0 ;
  wire \adec/lt59_c1 ;
  wire \adec/lt59_c2 ;
  wire \adec/lt59_c3 ;
  wire \adec/lt59_c4 ;
  wire \adec/lt59_c5 ;
  wire \adec/lt59_c6 ;
  wire \adec/lt59_c7 ;
  wire \adec/lt59_c8 ;
  wire \adec/lt5_c0 ;
  wire \adec/lt5_c1 ;
  wire \adec/lt5_c10 ;
  wire \adec/lt5_c11 ;
  wire \adec/lt5_c12 ;
  wire \adec/lt5_c13 ;
  wire \adec/lt5_c14 ;
  wire \adec/lt5_c15 ;
  wire \adec/lt5_c16 ;
  wire \adec/lt5_c2 ;
  wire \adec/lt5_c3 ;
  wire \adec/lt5_c4 ;
  wire \adec/lt5_c5 ;
  wire \adec/lt5_c6 ;
  wire \adec/lt5_c7 ;
  wire \adec/lt5_c8 ;
  wire \adec/lt5_c9 ;
  wire \adec/lt60_c0 ;
  wire \adec/lt60_c1 ;
  wire \adec/lt60_c2 ;
  wire \adec/lt60_c3 ;
  wire \adec/lt60_c4 ;
  wire \adec/lt60_c5 ;
  wire \adec/lt60_c6 ;
  wire \adec/lt60_c7 ;
  wire \adec/lt60_c8 ;
  wire \adec/lt61_c0 ;
  wire \adec/lt61_c1 ;
  wire \adec/lt61_c2 ;
  wire \adec/lt61_c3 ;
  wire \adec/lt61_c4 ;
  wire \adec/lt61_c5 ;
  wire \adec/lt61_c6 ;
  wire \adec/lt61_c7 ;
  wire \adec/lt61_c8 ;
  wire \adec/lt62_c0 ;
  wire \adec/lt62_c1 ;
  wire \adec/lt62_c2 ;
  wire \adec/lt62_c3 ;
  wire \adec/lt62_c4 ;
  wire \adec/lt62_c5 ;
  wire \adec/lt62_c6 ;
  wire \adec/lt62_c7 ;
  wire \adec/lt62_c8 ;
  wire \adec/lt63_c0 ;
  wire \adec/lt63_c1 ;
  wire \adec/lt63_c2 ;
  wire \adec/lt63_c3 ;
  wire \adec/lt63_c4 ;
  wire \adec/lt63_c5 ;
  wire \adec/lt63_c6 ;
  wire \adec/lt63_c7 ;
  wire \adec/lt63_c8 ;
  wire \adec/lt64_c0 ;
  wire \adec/lt64_c1 ;
  wire \adec/lt64_c2 ;
  wire \adec/lt64_c3 ;
  wire \adec/lt64_c4 ;
  wire \adec/lt64_c5 ;
  wire \adec/lt64_c6 ;
  wire \adec/lt64_c7 ;
  wire \adec/lt64_c8 ;
  wire \adec/lt65_c0 ;
  wire \adec/lt65_c1 ;
  wire \adec/lt65_c2 ;
  wire \adec/lt65_c3 ;
  wire \adec/lt65_c4 ;
  wire \adec/lt65_c5 ;
  wire \adec/lt65_c6 ;
  wire \adec/lt65_c7 ;
  wire \adec/lt65_c8 ;
  wire \adec/lt6_c0 ;
  wire \adec/lt6_c1 ;
  wire \adec/lt6_c10 ;
  wire \adec/lt6_c11 ;
  wire \adec/lt6_c12 ;
  wire \adec/lt6_c13 ;
  wire \adec/lt6_c14 ;
  wire \adec/lt6_c15 ;
  wire \adec/lt6_c16 ;
  wire \adec/lt6_c2 ;
  wire \adec/lt6_c3 ;
  wire \adec/lt6_c4 ;
  wire \adec/lt6_c5 ;
  wire \adec/lt6_c6 ;
  wire \adec/lt6_c7 ;
  wire \adec/lt6_c8 ;
  wire \adec/lt6_c9 ;
  wire \adec/lt7_c0 ;
  wire \adec/lt7_c1 ;
  wire \adec/lt7_c10 ;
  wire \adec/lt7_c11 ;
  wire \adec/lt7_c12 ;
  wire \adec/lt7_c13 ;
  wire \adec/lt7_c14 ;
  wire \adec/lt7_c15 ;
  wire \adec/lt7_c16 ;
  wire \adec/lt7_c2 ;
  wire \adec/lt7_c3 ;
  wire \adec/lt7_c4 ;
  wire \adec/lt7_c5 ;
  wire \adec/lt7_c6 ;
  wire \adec/lt7_c7 ;
  wire \adec/lt7_c8 ;
  wire \adec/lt7_c9 ;
  wire \adec/lt8_c0 ;
  wire \adec/lt8_c1 ;
  wire \adec/lt8_c10 ;
  wire \adec/lt8_c11 ;
  wire \adec/lt8_c12 ;
  wire \adec/lt8_c13 ;
  wire \adec/lt8_c14 ;
  wire \adec/lt8_c15 ;
  wire \adec/lt8_c16 ;
  wire \adec/lt8_c2 ;
  wire \adec/lt8_c3 ;
  wire \adec/lt8_c4 ;
  wire \adec/lt8_c5 ;
  wire \adec/lt8_c6 ;
  wire \adec/lt8_c7 ;
  wire \adec/lt8_c8 ;
  wire \adec/lt8_c9 ;
  wire \adec/lt9_c0 ;
  wire \adec/lt9_c1 ;
  wire \adec/lt9_c10 ;
  wire \adec/lt9_c11 ;
  wire \adec/lt9_c12 ;
  wire \adec/lt9_c13 ;
  wire \adec/lt9_c14 ;
  wire \adec/lt9_c15 ;
  wire \adec/lt9_c16 ;
  wire \adec/lt9_c2 ;
  wire \adec/lt9_c3 ;
  wire \adec/lt9_c4 ;
  wire \adec/lt9_c5 ;
  wire \adec/lt9_c6 ;
  wire \adec/lt9_c7 ;
  wire \adec/lt9_c8 ;
  wire \adec/lt9_c9 ;
  wire \adec/n0_lutinv ;
  wire \adec/n1 ;
  wire \adec/n100 ;
  wire \adec/n102 ;
  wire \adec/n104 ;
  wire \adec/n106 ;
  wire \adec/n108 ;
  wire \adec/n11 ;
  wire \adec/n110 ;
  wire \adec/n112 ;
  wire \adec/n114 ;
  wire \adec/n116 ;
  wire \adec/n118 ;
  wire \adec/n12 ;
  wire \adec/n120 ;
  wire \adec/n122 ;
  wire \adec/n124 ;
  wire \adec/n126 ;
  wire \adec/n128 ;
  wire \adec/n13 ;
  wire \adec/n130 ;
  wire \adec/n132 ;
  wire \adec/n134 ;
  wire \adec/n136 ;
  wire \adec/n138 ;
  wire \adec/n140 ;
  wire \adec/n15 ;
  wire \adec/n16 ;
  wire \adec/n17 ;
  wire \adec/n21 ;
  wire \adec/n22 ;
  wire \adec/n23 ;
  wire \adec/n3 ;
  wire \adec/n34_lutinv ;
  wire \adec/n5 ;
  wire \adec/n56 ;
  wire \adec/n58 ;
  wire \adec/n60 ;
  wire \adec/n62 ;
  wire \adec/n64 ;
  wire \adec/n66 ;
  wire \adec/n68 ;
  wire \adec/n7 ;
  wire \adec/n70 ;
  wire \adec/n72 ;
  wire \adec/n74 ;
  wire \adec/n76 ;
  wire \adec/n78 ;
  wire \adec/n80 ;
  wire \adec/n82 ;
  wire \adec/n84 ;
  wire \adec/n86 ;
  wire \adec/n88 ;
  wire \adec/n9 ;
  wire \adec/n90 ;
  wire \adec/n92 ;
  wire \adec/n94 ;
  wire \adec/n96 ;
  wire \adec/n98 ;
  wire \bctl/bctl_brdy ;  // rtl/busc_fsm.v(35)
  wire \bctl/brdy_t ;  // rtl/busc_fsm.v(34)
  wire \bctl/mux0_b0_sel_is_3_o ;
  wire \bctl/mux0_b1_sel_is_3_o ;
  wire \bctl/mux0_b2_sel_is_3_o ;

  assign bdatr1[15] = bdatr[15];
  assign bdatr1[14] = bdatr[14];
  assign bdatr1[13] = bdatr[13];
  assign bdatr1[12] = bdatr[12];
  assign bdatr1[11] = bdatr[11];
  assign bdatr1[10] = bdatr[10];
  assign bdatr1[9] = bdatr[9];
  assign bdatr1[8] = bdatr[8];
  assign bdatr1[7] = bdatr[7];
  assign bdatr1[6] = bdatr[6];
  assign bdatr1[5] = bdatr[5];
  assign bdatr1[4] = bdatr[4];
  assign bdatr1[3] = bdatr[3];
  assign bdatr1[2] = bdatr[2];
  assign bdatr1[1] = bdatr[1];
  assign bdatr1[0] = bdatr[0];
  assign bdatr2[15] = bdatr[15];
  assign bdatr2[14] = bdatr[14];
  assign bdatr2[13] = bdatr[13];
  assign bdatr2[12] = bdatr[12];
  assign bdatr2[11] = bdatr[11];
  assign bdatr2[10] = bdatr[10];
  assign bdatr2[9] = bdatr[9];
  assign bdatr2[8] = bdatr[8];
  assign bdatr2[7] = bdatr[7];
  assign bdatr2[6] = bdatr[6];
  assign bdatr2[5] = bdatr[5];
  assign bdatr2[4] = bdatr[4];
  assign bdatr2[3] = bdatr[3];
  assign bdatr2[2] = bdatr[2];
  assign bdatr2[1] = bdatr[1];
  assign bdatr2[0] = bdatr[0];
  assign bmst = \acpu/n4 ;
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u100 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [6]),
    .c(badr1[6]),
    .o(\acpu/badr_cp1 [6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u101 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [7]),
    .c(badr1[7]),
    .o(\acpu/badr_cp1 [7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u102 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [8]),
    .c(badr1[8]),
    .o(\acpu/badr_cp1 [8]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u103 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [9]),
    .c(badr1[9]),
    .o(\acpu/badr_cp1 [9]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u104 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [0]),
    .c(badrx2[0]),
    .o(\acpu/badrx_cp2 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u105 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [1]),
    .c(badrx2[1]),
    .o(\acpu/badrx_cp2 [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u106 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [2]),
    .c(badrx2[2]),
    .o(\acpu/badrx_cp2 [2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u107 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [3]),
    .c(badrx2[3]),
    .o(\acpu/badrx_cp2 [3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u108 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [4]),
    .c(badrx2[4]),
    .o(\acpu/badrx_cp2 [4]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u109 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [5]),
    .c(badrx2[5]),
    .o(\acpu/badrx_cp2 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u110 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [6]),
    .c(badrx2[6]),
    .o(\acpu/badrx_cp2 [6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u111 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badrx2_c [7]),
    .c(badrx2[7]),
    .o(\acpu/badrx_cp2 [7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u112 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [1]),
    .c(badr2[1]),
    .o(\acpu/badr_cp2 [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u113 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [10]),
    .c(badr2[10]),
    .o(\acpu/badr_cp2 [10]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u114 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [11]),
    .c(badr2[11]),
    .o(\acpu/badr_cp2 [11]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u115 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [12]),
    .c(badr2[12]),
    .o(\acpu/badr_cp2 [12]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u116 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [13]),
    .c(badr2[13]),
    .o(\acpu/badr_cp2 [13]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u117 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [14]),
    .c(badr2[14]),
    .o(\acpu/badr_cp2 [14]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u118 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [15]),
    .c(badr2[15]),
    .o(\acpu/badr_cp2 [15]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u119 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [2]),
    .c(badr2[2]),
    .o(\acpu/badr_cp2 [2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u120 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [3]),
    .c(badr2[3]),
    .o(\acpu/badr_cp2 [3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u121 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [4]),
    .c(badr2[4]),
    .o(\acpu/badr_cp2 [4]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u122 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [5]),
    .c(badr2[5]),
    .o(\acpu/badr_cp2 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u123 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [6]),
    .c(badr2[6]),
    .o(\acpu/badr_cp2 [6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u124 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [7]),
    .c(badr2[7]),
    .o(\acpu/badr_cp2 [7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u125 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [8]),
    .c(badr2[8]),
    .o(\acpu/badr_cp2 [8]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u126 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [9]),
    .c(badr2[9]),
    .o(\acpu/badr_cp2 [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u127 (
    .a(\bctl/bctl_brdy ),
    .b(sdc_brdy),
    .o(brdy));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u128 (
    .a(brdy),
    .b(\acpu/neg_brdy2 ),
    .o(brdy2));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u129 (
    .a(brdy),
    .b(\acpu/neg_brdy1 ),
    .o(brdy1));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u130 (
    .a(\acpu/blng1/stat [0]),
    .b(\acpu/blng1/stat [1]),
    .o(\acpu/bacp_adr_inc1 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u131 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(brdy),
    .o(\acpu/blng1/n50 ));
  AL_MAP_LUT5 #(
    .EQN("((E@D)*~((C@B))*~(A)+(E@D)*(C@B)*~(A)+~((E@D))*(C@B)*A+(E@D)*(C@B)*A)"),
    .INIT(32'h287d7d28))
    _al_u132 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/bcmd1_c [0]),
    .c(\acpu/bcmd1_c [1]),
    .d(bcmd1[1]),
    .e(bcmd1[0]),
    .o(_al_u132_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u133 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bcmd2_c [0]),
    .c(bcmd2[0]),
    .o(_al_u133_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u134 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bcmd2_c [1]),
    .c(bcmd2[1]),
    .o(_al_u134_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(C@B)*~(A)*~(D)+~(C@B)*A*~(D)+~(~(C@B))*A*D+~(C@B)*A*D)"),
    .INIT(16'h553c))
    _al_u135 (
    .a(_al_u132_o),
    .b(_al_u133_o),
    .c(_al_u134_o),
    .d(\acpu/last_sel ),
    .o(\acpu/n4 ));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u136 (
    .a(n0[22]),
    .b(n1[22]),
    .c(\acpu/n4 ),
    .o(bcs_sdram_n));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u137 (
    .a(n0[21]),
    .b(n1[21]),
    .c(\acpu/n4 ),
    .o(badrx[6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u138 (
    .a(n0[20]),
    .b(n1[20]),
    .c(\acpu/n4 ),
    .o(badrx[5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u139 (
    .a(n0[19]),
    .b(n1[19]),
    .c(\acpu/n4 ),
    .o(badrx[4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u140 (
    .a(n0[18]),
    .b(n1[18]),
    .c(\acpu/n4 ),
    .o(badrx[3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u141 (
    .a(n0[17]),
    .b(n1[17]),
    .c(\acpu/n4 ),
    .o(badrx[2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u142 (
    .a(n0[16]),
    .b(n1[16]),
    .c(\acpu/n4 ),
    .o(badrx[1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u143 (
    .a(n0[15]),
    .b(n1[15]),
    .c(\acpu/n4 ),
    .o(badrx[0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u144 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bcmd2_c [2]),
    .c(bcmd2[2]),
    .o(\acpu/bcmd_cp2 [2]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)*~(A)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*~(A)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*B*A+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*A)"),
    .INIT(32'hdd8dd888))
    _al_u145 (
    .a(\acpu/n4 ),
    .b(\acpu/bcmd_cp2 [2]),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bcmd1_c [2]),
    .e(bcmd1[2]),
    .o(bcmd[2]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)*~(A)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*~(A)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*B*A+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*A)"),
    .INIT(32'h77277222))
    _al_u146 (
    .a(\acpu/n4 ),
    .b(_al_u134_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bcmd1_c [1]),
    .e(bcmd1[1]),
    .o(bcmd[1]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)*~(A)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*~(A)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*B*A+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*A)"),
    .INIT(32'h77277222))
    _al_u147 (
    .a(\acpu/n4 ),
    .b(_al_u133_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bcmd1_c [0]),
    .e(bcmd1[0]),
    .o(bcmd[0]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u148 (
    .a(n0[8]),
    .b(n1[8]),
    .c(\acpu/n4 ),
    .o(badr[9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u149 (
    .a(n0[7]),
    .b(n1[7]),
    .c(\acpu/n4 ),
    .o(badr[8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u150 (
    .a(n0[6]),
    .b(n1[6]),
    .c(\acpu/n4 ),
    .o(badr[7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u151 (
    .a(n0[5]),
    .b(n1[5]),
    .c(\acpu/n4 ),
    .o(badr[6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u152 (
    .a(n0[4]),
    .b(n1[4]),
    .c(\acpu/n4 ),
    .o(badr[5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u153 (
    .a(n0[3]),
    .b(n1[3]),
    .c(\acpu/n4 ),
    .o(badr[4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u154 (
    .a(n0[2]),
    .b(n1[2]),
    .c(\acpu/n4 ),
    .o(badr[3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u155 (
    .a(n0[1]),
    .b(n1[1]),
    .c(\acpu/n4 ),
    .o(badr[2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u156 (
    .a(n0[14]),
    .b(n1[14]),
    .c(\acpu/n4 ),
    .o(badr[15]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u157 (
    .a(n0[13]),
    .b(n1[13]),
    .c(\acpu/n4 ),
    .o(badr[14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u158 (
    .a(n0[12]),
    .b(n1[12]),
    .c(\acpu/n4 ),
    .o(badr[13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u159 (
    .a(n0[11]),
    .b(n1[11]),
    .c(\acpu/n4 ),
    .o(badr[12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u160 (
    .a(n0[10]),
    .b(n1[10]),
    .c(\acpu/n4 ),
    .o(badr[11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u161 (
    .a(n0[9]),
    .b(n1[9]),
    .c(\acpu/n4 ),
    .o(badr[10]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u162 (
    .a(n0[0]),
    .b(n1[0]),
    .c(\acpu/n4 ),
    .o(badr[1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u163 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/badr2_c [0]),
    .c(badr2[0]),
    .o(\acpu/badr_cp2 [0]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)*~(A)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*~(A)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*B*A+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B*A)"),
    .INIT(32'hdd8dd888))
    _al_u164 (
    .a(\acpu/n4 ),
    .b(\acpu/badr_cp2 [0]),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/badr1_c [0]),
    .e(badr1[0]),
    .o(badr[0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u165 (
    .a(\acpu/blng2/stat [0]),
    .b(\acpu/blng2/stat [1]),
    .o(\acpu/bacp_adr_inc2 ));
  AL_MAP_LUT4 #(
    .EQN("(D*(A*B*~(C)+~(A)*~(B)*C))"),
    .INIT(16'h1800))
    _al_u166 (
    .a(brdy),
    .b(\acpu/blng2/stat [0]),
    .c(\acpu/blng2/stat [1]),
    .d(rst_n),
    .o(\acpu/blng2/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*(A*B*~(C)+~(A)*~(B)*C))"),
    .INIT(16'h1800))
    _al_u167 (
    .a(brdy),
    .b(\acpu/blng1/stat [0]),
    .c(\acpu/blng1/stat [1]),
    .d(rst_n),
    .o(\acpu/blng1/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u168 (
    .a(badrx[3]),
    .b(badrx[2]),
    .c(badrx[1]),
    .d(badrx[0]),
    .o(_al_u168_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u169 (
    .a(_al_u168_o),
    .b(bcs_sdram_n),
    .c(badrx[6]),
    .d(badrx[5]),
    .e(badrx[4]),
    .o(\adec/n0_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u170 (
    .a(\adec/n1 ),
    .b(\adec/n0_lutinv ),
    .o(bcs_rom_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u171 (
    .a(\adec/n7 ),
    .b(\adec/n9 ),
    .c(\adec/n0_lutinv ),
    .o(bcs_ram_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u172 (
    .a(\adec/n3 ),
    .b(\adec/n5 ),
    .c(\adec/n0_lutinv ),
    .o(bcs_iram_n));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u173 (
    .a(\adec/n11 ),
    .b(\adec/n0_lutinv ),
    .o(\adec/n12 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u174 (
    .a(\adec/n12 ),
    .b(\adec/n56 ),
    .o(bcs_idrg_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u175 (
    .a(\adec/n12 ),
    .b(\adec/n118 ),
    .c(\adec/n120 ),
    .o(bcs_unsj_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u176 (
    .a(\adec/n12 ),
    .b(\adec/n114 ),
    .c(\adec/n116 ),
    .o(bcs_sdrc_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u177 (
    .a(\adec/n12 ),
    .b(\adec/n110 ),
    .c(\adec/n112 ),
    .o(bcs_adcu_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u178 (
    .a(\adec/n12 ),
    .b(\adec/n106 ),
    .c(\adec/n108 ),
    .o(bcs_por1_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u179 (
    .a(\adec/n12 ),
    .b(\adec/n102 ),
    .c(\adec/n104 ),
    .o(bcs_uar1_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u180 (
    .a(\adec/n12 ),
    .b(\adec/n98 ),
    .c(\adec/n100 ),
    .o(bcs_fnjp_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u181 (
    .a(\adec/n12 ),
    .b(\adec/n94 ),
    .c(\adec/n96 ),
    .o(bcs_stws_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u182 (
    .a(\adec/n12 ),
    .b(\adec/n90 ),
    .c(\adec/n92 ),
    .o(bcs_icff_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u183 (
    .a(\adec/n12 ),
    .b(\adec/n86 ),
    .c(\adec/n88 ),
    .o(bcs_smph_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u184 (
    .a(\adec/n12 ),
    .b(\adec/n82 ),
    .c(\adec/n84 ),
    .o(bcs_loga_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u185 (
    .a(\adec/n12 ),
    .b(\adec/n78 ),
    .c(\adec/n80 ),
    .o(bcs_intc_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u186 (
    .a(\adec/n12 ),
    .b(\adec/n74 ),
    .c(\adec/n76 ),
    .o(bcs_tim1_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u187 (
    .a(\adec/n12 ),
    .b(\adec/n70 ),
    .c(\adec/n72 ),
    .o(bcs_tim0_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u188 (
    .a(\adec/n12 ),
    .b(\adec/n66 ),
    .c(\adec/n68 ),
    .o(bcs_uart_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u189 (
    .a(\adec/n12 ),
    .b(\adec/n62 ),
    .c(\adec/n64 ),
    .o(bcs_port_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u190 (
    .a(\adec/n12 ),
    .b(\adec/n58 ),
    .c(\adec/n60 ),
    .o(bcs_sytm_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u191 (
    .a(\adec/n12 ),
    .b(\adec/n138 ),
    .c(\adec/n140 ),
    .o(bcs_iome_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u192 (
    .a(\adec/n12 ),
    .b(\adec/n134 ),
    .c(\adec/n136 ),
    .o(bcs_dacu_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u193 (
    .a(\adec/n12 ),
    .b(\adec/n130 ),
    .c(\adec/n132 ),
    .o(bcs_int2_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u194 (
    .a(\adec/n12 ),
    .b(\adec/n126 ),
    .c(\adec/n128 ),
    .o(bcs_rtcu_n));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u195 (
    .a(\adec/n12 ),
    .b(\adec/n122 ),
    .c(\adec/n124 ),
    .o(bcs_dist_n));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u196 (
    .a(badr1[1]),
    .b(badrx1[7]),
    .c(badrx1[6]),
    .d(badrx1[3]),
    .o(_al_u196_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~B*~(D*C)))"),
    .INIT(16'ha888))
    _al_u197 (
    .a(_al_u196_o),
    .b(\adec/n15 ),
    .c(\adec/n16 ),
    .d(\adec/n17 ),
    .o(_al_u197_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u198 (
    .a(badrx1[5]),
    .b(badrx1[4]),
    .c(badrx1[2]),
    .d(badrx1[1]),
    .e(badrx1[0]),
    .o(_al_u198_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~(B*A))"),
    .INIT(32'h00700000))
    _al_u199 (
    .a(_al_u197_o),
    .b(_al_u198_o),
    .c(brdy),
    .d(\acpu/blng1/stat [0]),
    .e(bcmd1[3]),
    .o(\acpu/bacp_drv_datwh1 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~A*~(~C*B)))"),
    .INIT(16'hae00))
    _al_u200 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(\acpu/bacp_adr_inc1 ),
    .c(brdy),
    .d(rst_n),
    .o(\acpu/blng1/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u201 (
    .a(badr2[1]),
    .b(badrx2[7]),
    .c(badrx2[6]),
    .d(badrx2[3]),
    .o(_al_u201_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~B*~(D*C)))"),
    .INIT(16'ha888))
    _al_u202 (
    .a(_al_u201_o),
    .b(\adec/n21 ),
    .c(\adec/n22 ),
    .d(\adec/n23 ),
    .o(_al_u202_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u203 (
    .a(badrx2[5]),
    .b(badrx2[4]),
    .c(badrx2[2]),
    .d(badrx2[1]),
    .e(badrx2[0]),
    .o(_al_u203_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~(B*A))"),
    .INIT(32'h00700000))
    _al_u204 (
    .a(_al_u202_o),
    .b(_al_u203_o),
    .c(brdy),
    .d(\acpu/blng2/stat [0]),
    .e(bcmd2[3]),
    .o(\acpu/bacp_drv_datwh2 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~A*~(~C*B)))"),
    .INIT(16'hae00))
    _al_u205 (
    .a(\acpu/bacp_drv_datwh2 ),
    .b(\acpu/bacp_adr_inc2 ),
    .c(brdy),
    .d(rst_n),
    .o(\acpu/blng2/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u206 (
    .a(brdy),
    .b(\acpu/blng1/stat [0]),
    .c(\acpu/blng1/stat [1]),
    .o(\acpu/bacp_drv_datr1_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u207 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [9]),
    .c(bdatr[25]),
    .o(bdatr1[25]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u208 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [8]),
    .c(bdatr[24]),
    .o(bdatr1[24]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u209 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [7]),
    .c(bdatr[23]),
    .o(bdatr1[23]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u210 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [6]),
    .c(bdatr[22]),
    .o(bdatr1[22]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u211 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [5]),
    .c(bdatr[21]),
    .o(bdatr1[21]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u212 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [4]),
    .c(bdatr[20]),
    .o(bdatr1[20]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u213 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [3]),
    .c(bdatr[19]),
    .o(bdatr1[19]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u214 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [2]),
    .c(bdatr[18]),
    .o(bdatr1[18]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u215 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [15]),
    .c(bdatr[31]),
    .o(bdatr1[31]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u216 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [14]),
    .c(bdatr[30]),
    .o(bdatr1[30]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u217 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [13]),
    .c(bdatr[29]),
    .o(bdatr1[29]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u218 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [12]),
    .c(bdatr[28]),
    .o(bdatr1[28]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u219 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [11]),
    .c(bdatr[27]),
    .o(bdatr1[27]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u220 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [10]),
    .c(bdatr[26]),
    .o(bdatr1[26]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u221 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [1]),
    .c(bdatr[17]),
    .o(bdatr1[17]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u222 (
    .a(\acpu/bacp_drv_datr1_lutinv ),
    .b(\acpu/datrh [0]),
    .c(bdatr[16]),
    .o(bdatr1[16]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u223 (
    .a(brdy),
    .b(\acpu/blng2/stat [0]),
    .c(\acpu/blng2/stat [1]),
    .o(\acpu/bacp_drv_datr2_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u224 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [9]),
    .c(bdatr[25]),
    .o(bdatr2[25]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u225 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [8]),
    .c(bdatr[24]),
    .o(bdatr2[24]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u226 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [7]),
    .c(bdatr[23]),
    .o(bdatr2[23]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u227 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [6]),
    .c(bdatr[22]),
    .o(bdatr2[22]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u228 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [5]),
    .c(bdatr[21]),
    .o(bdatr2[21]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u229 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [4]),
    .c(bdatr[20]),
    .o(bdatr2[20]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u230 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [3]),
    .c(bdatr[19]),
    .o(bdatr2[19]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u231 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [2]),
    .c(bdatr[18]),
    .o(bdatr2[18]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u232 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [15]),
    .c(bdatr[31]),
    .o(bdatr2[31]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u233 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [14]),
    .c(bdatr[30]),
    .o(bdatr2[30]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u234 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [13]),
    .c(bdatr[29]),
    .o(bdatr2[29]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u235 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [12]),
    .c(bdatr[28]),
    .o(bdatr2[28]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u236 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [11]),
    .c(bdatr[27]),
    .o(bdatr2[27]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u237 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [10]),
    .c(bdatr[26]),
    .o(bdatr2[26]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u238 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [1]),
    .c(bdatr[17]),
    .o(bdatr2[17]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u239 (
    .a(\acpu/bacp_drv_datr2_lutinv ),
    .b(\acpu/datrh [0]),
    .c(bdatr[16]),
    .o(bdatr2[16]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~B*(D@C)))"),
    .INIT(16'h5445))
    _al_u240 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(brdy),
    .c(\acpu/blng1/stat [0]),
    .d(\acpu/blng1/stat [1]),
    .o(_al_u240_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C*B))"),
    .INIT(8'hd5))
    _al_u241 (
    .a(_al_u240_o),
    .b(\acpu/n4 ),
    .c(_al_u132_o),
    .o(\acpu/n10 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u242 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [9]),
    .d(\acpu/bdatw2_c [9]),
    .e(bdatw2[9]),
    .o(_al_u242_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u243 (
    .a(\acpu/bacp_drv_datwh2 ),
    .b(_al_u242_o),
    .c(\acpu/neg_brdy2 ),
    .d(\acpu/bdatw2_c [25]),
    .e(bdatw2[25]),
    .o(_al_u243_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u244 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [9]),
    .d(\acpu/datwl1 [9]),
    .e(bdatw1[9]),
    .o(\acpu/n43 [9]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u245 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/bdatw1_c [25]),
    .c(bdatw1[25]),
    .o(_al_u245_o));
  AL_MAP_LUT5 #(
    .EQN("~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(A)*~(C)+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*~(C)+~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*A*C+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*C)"),
    .INIT(32'h53505f5c))
    _al_u246 (
    .a(_al_u243_o),
    .b(\acpu/bacp_drv_datwh1 ),
    .c(\acpu/n4 ),
    .d(\acpu/n43 [9]),
    .e(_al_u245_o),
    .o(bdatw[9]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u247 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [8]),
    .d(\acpu/datwl1 [8]),
    .e(bdatw1[8]),
    .o(_al_u247_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u248 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u247_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [24]),
    .e(bdatw1[24]),
    .o(_al_u248_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u249 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [8]),
    .d(\acpu/bdatw2_c [8]),
    .e(bdatw2[8]),
    .o(\acpu/n44 [8]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u250 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [24]),
    .c(bdatw2[24]),
    .o(_al_u250_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u251 (
    .a(_al_u248_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [8]),
    .e(_al_u250_o),
    .o(bdatw[8]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u252 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [7]),
    .d(\acpu/datwl1 [7]),
    .e(bdatw1[7]),
    .o(_al_u252_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u253 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u252_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [23]),
    .e(bdatw1[23]),
    .o(_al_u253_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u254 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [7]),
    .d(\acpu/bdatw2_c [7]),
    .e(bdatw2[7]),
    .o(\acpu/n44 [7]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u255 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [23]),
    .c(bdatw2[23]),
    .o(_al_u255_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u256 (
    .a(_al_u253_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [7]),
    .e(_al_u255_o),
    .o(bdatw[7]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u257 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [6]),
    .d(\acpu/datwl1 [6]),
    .e(bdatw1[6]),
    .o(_al_u257_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u258 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u257_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [22]),
    .e(bdatw1[22]),
    .o(_al_u258_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u259 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [6]),
    .d(\acpu/bdatw2_c [6]),
    .e(bdatw2[6]),
    .o(\acpu/n44 [6]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u260 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [22]),
    .c(bdatw2[22]),
    .o(_al_u260_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u261 (
    .a(_al_u258_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [6]),
    .e(_al_u260_o),
    .o(bdatw[6]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u262 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [5]),
    .d(\acpu/datwl1 [5]),
    .e(bdatw1[5]),
    .o(_al_u262_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u263 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u262_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [21]),
    .e(bdatw1[21]),
    .o(_al_u263_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u264 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [5]),
    .d(\acpu/bdatw2_c [5]),
    .e(bdatw2[5]),
    .o(\acpu/n44 [5]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u265 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [21]),
    .c(bdatw2[21]),
    .o(_al_u265_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u266 (
    .a(_al_u263_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [5]),
    .e(_al_u265_o),
    .o(bdatw[5]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u267 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [4]),
    .d(\acpu/datwl1 [4]),
    .e(bdatw1[4]),
    .o(_al_u267_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u268 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u267_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [20]),
    .e(bdatw1[20]),
    .o(_al_u268_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u269 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [4]),
    .d(\acpu/bdatw2_c [4]),
    .e(bdatw2[4]),
    .o(\acpu/n44 [4]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u270 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [20]),
    .c(bdatw2[20]),
    .o(_al_u270_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u271 (
    .a(_al_u268_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [4]),
    .e(_al_u270_o),
    .o(bdatw[4]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u272 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [3]),
    .d(\acpu/datwl1 [3]),
    .e(bdatw1[3]),
    .o(_al_u272_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u273 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u272_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [19]),
    .e(bdatw1[19]),
    .o(_al_u273_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u274 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [3]),
    .d(\acpu/bdatw2_c [3]),
    .e(bdatw2[3]),
    .o(\acpu/n44 [3]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u275 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [19]),
    .c(bdatw2[19]),
    .o(_al_u275_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u276 (
    .a(_al_u273_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [3]),
    .e(_al_u275_o),
    .o(bdatw[3]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u277 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [2]),
    .d(\acpu/datwl1 [2]),
    .e(bdatw1[2]),
    .o(_al_u277_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u278 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u277_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [18]),
    .e(bdatw1[18]),
    .o(_al_u278_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u279 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [2]),
    .d(\acpu/bdatw2_c [2]),
    .e(bdatw2[2]),
    .o(\acpu/n44 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u280 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [18]),
    .c(bdatw2[18]),
    .o(_al_u280_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u281 (
    .a(_al_u278_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [2]),
    .e(_al_u280_o),
    .o(bdatw[2]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u282 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [15]),
    .d(\acpu/datwl1 [15]),
    .e(bdatw1[15]),
    .o(_al_u282_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u283 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u282_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [31]),
    .e(bdatw1[31]),
    .o(_al_u283_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u284 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [15]),
    .d(\acpu/bdatw2_c [15]),
    .e(bdatw2[15]),
    .o(\acpu/n44 [15]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u285 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [31]),
    .c(bdatw2[31]),
    .o(_al_u285_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u286 (
    .a(_al_u283_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [15]),
    .e(_al_u285_o),
    .o(bdatw[15]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u287 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [14]),
    .d(\acpu/datwl1 [14]),
    .e(bdatw1[14]),
    .o(_al_u287_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u288 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u287_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [30]),
    .e(bdatw1[30]),
    .o(_al_u288_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u289 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [14]),
    .d(\acpu/bdatw2_c [14]),
    .e(bdatw2[14]),
    .o(\acpu/n44 [14]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u290 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [30]),
    .c(bdatw2[30]),
    .o(_al_u290_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u291 (
    .a(_al_u288_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [14]),
    .e(_al_u290_o),
    .o(bdatw[14]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u292 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [13]),
    .d(\acpu/datwl1 [13]),
    .e(bdatw1[13]),
    .o(_al_u292_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u293 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u292_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [29]),
    .e(bdatw1[29]),
    .o(_al_u293_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u294 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [13]),
    .d(\acpu/bdatw2_c [13]),
    .e(bdatw2[13]),
    .o(\acpu/n44 [13]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u295 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [29]),
    .c(bdatw2[29]),
    .o(_al_u295_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u296 (
    .a(_al_u293_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [13]),
    .e(_al_u295_o),
    .o(bdatw[13]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u297 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [12]),
    .d(\acpu/bdatw2_c [12]),
    .e(bdatw2[12]),
    .o(_al_u297_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u298 (
    .a(\acpu/bacp_drv_datwh2 ),
    .b(_al_u297_o),
    .c(\acpu/neg_brdy2 ),
    .d(\acpu/bdatw2_c [28]),
    .e(bdatw2[28]),
    .o(_al_u298_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u299 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [12]),
    .d(\acpu/datwl1 [12]),
    .e(bdatw1[12]),
    .o(\acpu/n43 [12]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u300 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/bdatw1_c [28]),
    .c(bdatw1[28]),
    .o(_al_u300_o));
  AL_MAP_LUT5 #(
    .EQN("~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(A)*~(C)+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*~(C)+~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*A*C+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*C)"),
    .INIT(32'h53505f5c))
    _al_u301 (
    .a(_al_u298_o),
    .b(\acpu/bacp_drv_datwh1 ),
    .c(\acpu/n4 ),
    .d(\acpu/n43 [12]),
    .e(_al_u300_o),
    .o(bdatw[12]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u302 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [11]),
    .d(\acpu/datwl1 [11]),
    .e(bdatw1[11]),
    .o(_al_u302_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u303 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u302_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [27]),
    .e(bdatw1[27]),
    .o(_al_u303_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u304 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [11]),
    .d(\acpu/bdatw2_c [11]),
    .e(bdatw2[11]),
    .o(\acpu/n44 [11]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u305 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [27]),
    .c(bdatw2[27]),
    .o(_al_u305_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u306 (
    .a(_al_u303_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [11]),
    .e(_al_u305_o),
    .o(bdatw[11]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u307 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [10]),
    .d(\acpu/datwl1 [10]),
    .e(bdatw1[10]),
    .o(_al_u307_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u308 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(_al_u307_o),
    .c(\acpu/neg_brdy1 ),
    .d(\acpu/bdatw1_c [26]),
    .e(bdatw1[26]),
    .o(_al_u308_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u309 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [10]),
    .d(\acpu/bdatw2_c [10]),
    .e(bdatw2[10]),
    .o(\acpu/n44 [10]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u310 (
    .a(\acpu/neg_brdy2 ),
    .b(\acpu/bdatw2_c [26]),
    .c(bdatw2[26]),
    .o(_al_u310_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*~(C)+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(C)+~(A)*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C+A*(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*C)"),
    .INIT(32'h3505f5c5))
    _al_u311 (
    .a(_al_u308_o),
    .b(\acpu/bacp_drv_datwh2 ),
    .c(\acpu/n4 ),
    .d(\acpu/n44 [10]),
    .e(_al_u310_o),
    .o(bdatw[10]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u312 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [1]),
    .d(\acpu/bdatw2_c [1]),
    .e(bdatw2[1]),
    .o(_al_u312_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u313 (
    .a(\acpu/bacp_drv_datwh2 ),
    .b(_al_u312_o),
    .c(\acpu/neg_brdy2 ),
    .d(\acpu/bdatw2_c [17]),
    .e(bdatw2[17]),
    .o(_al_u313_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u314 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [1]),
    .d(\acpu/datwl1 [1]),
    .e(bdatw1[1]),
    .o(\acpu/n43 [1]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u315 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/bdatw1_c [17]),
    .c(bdatw1[17]),
    .o(_al_u315_o));
  AL_MAP_LUT5 #(
    .EQN("~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(A)*~(C)+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*~(C)+~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*A*C+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*C)"),
    .INIT(32'h53505f5c))
    _al_u316 (
    .a(_al_u313_o),
    .b(\acpu/bacp_drv_datwh1 ),
    .c(\acpu/n4 ),
    .d(\acpu/n43 [1]),
    .e(_al_u315_o),
    .o(bdatw[1]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u317 (
    .a(\acpu/bacp_adr_inc2 ),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/datwl2 [0]),
    .d(\acpu/bdatw2_c [0]),
    .e(bdatw2[0]),
    .o(_al_u317_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(A)+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)+~(~B)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A+~B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A)"),
    .INIT(32'h44e44eee))
    _al_u318 (
    .a(\acpu/bacp_drv_datwh2 ),
    .b(_al_u317_o),
    .c(\acpu/neg_brdy2 ),
    .d(\acpu/bdatw2_c [16]),
    .e(bdatw2[16]),
    .o(_al_u318_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u319 (
    .a(\acpu/bacp_adr_inc1 ),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [0]),
    .d(\acpu/datwl1 [0]),
    .e(bdatw1[0]),
    .o(\acpu/n43 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u320 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/bdatw1_c [16]),
    .c(bdatw1[16]),
    .o(_al_u320_o));
  AL_MAP_LUT5 #(
    .EQN("~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*~(A)*~(C)+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*~(C)+~((~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B))*A*C+(~D*~(E)*~(B)+~D*E*~(B)+~(~D)*E*B+~D*E*B)*A*C)"),
    .INIT(32'h53505f5c))
    _al_u321 (
    .a(_al_u318_o),
    .b(\acpu/bacp_drv_datwh1 ),
    .c(\acpu/n4 ),
    .d(\acpu/n43 [0]),
    .e(_al_u320_o),
    .o(bdatw[0]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~B*(D@C)))"),
    .INIT(16'h5445))
    _al_u322 (
    .a(\acpu/bacp_drv_datwh2 ),
    .b(brdy),
    .c(\acpu/blng2/stat [0]),
    .d(\acpu/blng2/stat [1]),
    .o(_al_u322_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*~(~B*(D@C)))"),
    .INIT(16'h5775))
    _al_u323 (
    .a(_al_u322_o),
    .b(\acpu/n4 ),
    .c(_al_u133_o),
    .d(_al_u134_o),
    .o(\acpu/n23 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u324 (
    .a(\adec/n13 ),
    .b(\adec/n0_lutinv ),
    .o(_al_u324_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*~(~C*B))*~(~E*~A))"),
    .INIT(32'h0cff08aa))
    _al_u325 (
    .a(bcs_sdram_n),
    .b(\bctl/stat [0]),
    .c(\bctl/stat [1]),
    .d(\bctl/stat [2]),
    .e(cch_hit),
    .o(_al_u325_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u326 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .o(_al_u326_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hfbcb))
    _al_u327 (
    .a(\bctl/stat [0]),
    .b(\bctl/stat [1]),
    .c(\bctl/stat [2]),
    .d(sdc_brdy),
    .o(_al_u327_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*~(C*B*~A)))"),
    .INIT(32'h40ff0000))
    _al_u328 (
    .a(_al_u324_o),
    .b(_al_u325_o),
    .c(_al_u326_o),
    .d(_al_u327_o),
    .e(rst_n),
    .o(\bctl/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~A*(B*~(C)*~(D)+~(B)*C*~(D)+B*~(C)*D))"),
    .INIT(16'h0414))
    _al_u329 (
    .a(bcs_sdram_n),
    .b(bcmd[1]),
    .c(bcmd[0]),
    .d(cch_hit),
    .o(_al_u329_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*~(C)*~(D)*~(E)+B*~(C)*~(D)*~(E)+B*C*~(D)*~(E)+~(B)*~(C)*~(D)*E+B*~(C)*~(D)*E+B*C*~(D)*E+B*~(C)*D*E))"),
    .INIT(32'h088a008a))
    _al_u330 (
    .a(_al_u329_o),
    .b(\bctl/stat [0]),
    .c(\bctl/stat [1]),
    .d(\bctl/stat [2]),
    .e(sdc_brdy),
    .o(_al_u330_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*C*~B))"),
    .INIT(16'h5545))
    _al_u331 (
    .a(_al_u330_o),
    .b(\bctl/stat [1]),
    .c(\bctl/stat [2]),
    .d(sdc_brdy),
    .o(_al_u331_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(C)*~(D)+B*~(C)*D+~(B)*C*D))"),
    .INIT(16'h2808))
    _al_u332 (
    .a(\bctl/stat [0]),
    .b(\bctl/stat [1]),
    .c(\bctl/stat [2]),
    .d(sdc_brdy),
    .o(_al_u332_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u333 (
    .a(_al_u332_o),
    .b(\bctl/stat [1]),
    .c(\bctl/stat [2]),
    .o(_al_u333_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(A*~(~E*C*~B)))"),
    .INIT(32'h55007500))
    _al_u334 (
    .a(_al_u331_o),
    .b(bcs_sdram_n),
    .c(_al_u326_o),
    .d(rst_n),
    .e(_al_u333_o),
    .o(\bctl/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u335 (
    .a(badr[14]),
    .b(badr[13]),
    .c(badr[12]),
    .o(\adec/lt13/o_2_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u336 (
    .a(badr[13]),
    .b(badr[12]),
    .o(_al_u336_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h028a))
    _al_u337 (
    .a(badr[15]),
    .b(\acpu/n4 ),
    .c(smph_ram1_n[4]),
    .d(smph_ram2_n[4]),
    .o(_al_u337_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*B*~A)"),
    .INIT(16'hfbff))
    _al_u338 (
    .a(bcs_ram_n),
    .b(\adec/lt13/o_2_lutinv ),
    .c(_al_u336_o),
    .d(_al_u337_o),
    .o(bcs_ram4_n));
  AL_MAP_LUT4 #(
    .EQN("(A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h028a))
    _al_u339 (
    .a(badr[15]),
    .b(\acpu/n4 ),
    .c(smph_ram1_n[3]),
    .d(smph_ram2_n[3]),
    .o(_al_u339_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~A*(C*~(D)*~(E)+~(C)*D*E))"),
    .INIT(32'hfbffffbf))
    _al_u340 (
    .a(bcs_ram_n),
    .b(_al_u339_o),
    .c(badr[14]),
    .d(badr[13]),
    .e(badr[12]),
    .o(bcs_ram3_n));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*~C*~B))"),
    .INIT(16'haaa8))
    _al_u341 (
    .a(badr[15]),
    .b(badr[14]),
    .c(badr[13]),
    .d(badr[12]),
    .o(_al_u341_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h0145))
    _al_u342 (
    .a(badr[14]),
    .b(\acpu/n4 ),
    .c(smph_ram1_n[2]),
    .d(smph_ram2_n[2]),
    .o(_al_u342_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*B*~A)"),
    .INIT(16'hfbff))
    _al_u343 (
    .a(bcs_ram_n),
    .b(_al_u341_o),
    .c(_al_u336_o),
    .d(_al_u342_o),
    .o(bcs_ram2_n));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u344 (
    .a(_al_u336_o),
    .b(badr[15]),
    .c(badr[14]),
    .o(\adec/n34_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00011011))
    _al_u345 (
    .a(\adec/n34_lutinv ),
    .b(_al_u341_o),
    .c(\acpu/n4 ),
    .d(smph_ram1_n[1]),
    .e(smph_ram2_n[1]),
    .o(_al_u345_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u346 (
    .a(bcs_ram_n),
    .b(_al_u345_o),
    .o(bcs_ram1_n));
  AL_MAP_LUT5 #(
    .EQN("(B*A*~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h00088088))
    _al_u347 (
    .a(\adec/n34_lutinv ),
    .b(\adec/lt13/o_2_lutinv ),
    .c(\acpu/n4 ),
    .d(smph_ram1_n[0]),
    .e(smph_ram2_n[0]),
    .o(_al_u347_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u348 (
    .a(bcs_ram_n),
    .b(_al_u347_o),
    .o(bcs_ram0_n));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u349 (
    .a(bcmd[1]),
    .b(bcmd[0]),
    .o(_al_u349_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~(B*A)*~(C)*~(D)+~(B*A)*C*~(D)+~(~(B*A))*C*D+~(B*A)*C*D))"),
    .INIT(32'h00000f88))
    _al_u350 (
    .a(_al_u324_o),
    .b(_al_u349_o),
    .c(\bctl/stat [0]),
    .d(\bctl/stat [1]),
    .e(\bctl/stat [2]),
    .o(_al_u350_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~A*~(D*C*B)))"),
    .INIT(32'heaaa0000))
    _al_u351 (
    .a(_al_u350_o),
    .b(_al_u324_o),
    .c(_al_u349_o),
    .d(_al_u332_o),
    .e(rst_n),
    .o(\bctl/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u352 (
    .a(\acpu/bacp_drv_datwh1 ),
    .b(\acpu/n4 ),
    .c(\acpu/bacp_adr_inc1 ),
    .o(_al_u352_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u353 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [31]),
    .d(bdatw1[31]),
    .o(_al_u353_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u354 (
    .a(\acpu/bacp_drv_datwh2 ),
    .b(\acpu/n4 ),
    .c(\acpu/bacp_adr_inc2 ),
    .o(_al_u354_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u355 (
    .a(_al_u353_o),
    .b(_al_u354_o),
    .c(_al_u285_o),
    .o(bdatw[31]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u356 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [30]),
    .d(bdatw1[30]),
    .o(_al_u356_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u357 (
    .a(_al_u356_o),
    .b(_al_u354_o),
    .c(_al_u290_o),
    .o(bdatw[30]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u358 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [29]),
    .d(bdatw1[29]),
    .o(_al_u358_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u359 (
    .a(_al_u358_o),
    .b(_al_u354_o),
    .c(_al_u295_o),
    .o(bdatw[29]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u360 (
    .a(_al_u354_o),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/bdatw2_c [28]),
    .d(bdatw2[28]),
    .o(_al_u360_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u361 (
    .a(_al_u360_o),
    .b(_al_u352_o),
    .c(_al_u300_o),
    .o(bdatw[28]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u362 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [27]),
    .d(bdatw1[27]),
    .o(_al_u362_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u363 (
    .a(_al_u362_o),
    .b(_al_u354_o),
    .c(_al_u305_o),
    .o(bdatw[27]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u364 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [26]),
    .d(bdatw1[26]),
    .o(_al_u364_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u365 (
    .a(_al_u364_o),
    .b(_al_u354_o),
    .c(_al_u310_o),
    .o(bdatw[26]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u366 (
    .a(_al_u354_o),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/bdatw2_c [25]),
    .d(bdatw2[25]),
    .o(_al_u366_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u367 (
    .a(_al_u366_o),
    .b(_al_u352_o),
    .c(_al_u245_o),
    .o(bdatw[25]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u368 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [24]),
    .d(bdatw1[24]),
    .o(_al_u368_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u369 (
    .a(_al_u368_o),
    .b(_al_u354_o),
    .c(_al_u250_o),
    .o(bdatw[24]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u370 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [23]),
    .d(bdatw1[23]),
    .o(_al_u370_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u371 (
    .a(_al_u370_o),
    .b(_al_u354_o),
    .c(_al_u255_o),
    .o(bdatw[23]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u372 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [22]),
    .d(bdatw1[22]),
    .o(_al_u372_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u373 (
    .a(_al_u372_o),
    .b(_al_u354_o),
    .c(_al_u260_o),
    .o(bdatw[22]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u374 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [21]),
    .d(bdatw1[21]),
    .o(_al_u374_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u375 (
    .a(_al_u374_o),
    .b(_al_u354_o),
    .c(_al_u265_o),
    .o(bdatw[21]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u376 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [20]),
    .d(bdatw1[20]),
    .o(_al_u376_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u377 (
    .a(_al_u376_o),
    .b(_al_u354_o),
    .c(_al_u270_o),
    .o(bdatw[20]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u378 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [19]),
    .d(bdatw1[19]),
    .o(_al_u378_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u379 (
    .a(_al_u378_o),
    .b(_al_u354_o),
    .c(_al_u275_o),
    .o(bdatw[19]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u380 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bdatw1_c [18]),
    .d(bdatw1[18]),
    .o(_al_u380_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u381 (
    .a(_al_u380_o),
    .b(_al_u354_o),
    .c(_al_u280_o),
    .o(bdatw[18]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u382 (
    .a(_al_u354_o),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/bdatw2_c [17]),
    .d(bdatw2[17]),
    .o(_al_u382_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u383 (
    .a(_al_u382_o),
    .b(_al_u352_o),
    .c(_al_u315_o),
    .o(bdatw[17]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u384 (
    .a(_al_u354_o),
    .b(\acpu/neg_brdy2 ),
    .c(\acpu/bdatw2_c [16]),
    .d(bdatw2[16]),
    .o(_al_u384_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(~C*B))"),
    .INIT(8'hae))
    _al_u385 (
    .a(_al_u384_o),
    .b(_al_u352_o),
    .c(_al_u320_o),
    .o(bdatw[16]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u386 (
    .a(_al_u352_o),
    .b(\acpu/neg_brdy1 ),
    .c(\acpu/bcmd1_c [3]),
    .d(bcmd1[3]),
    .o(_al_u386_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)))"),
    .INIT(32'heeaeeaaa))
    _al_u387 (
    .a(_al_u386_o),
    .b(_al_u354_o),
    .c(\acpu/neg_brdy2 ),
    .d(\acpu/bcmd2_c [3]),
    .e(bcmd2[3]),
    .o(bcmd[3]));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(~D*C*A))"),
    .INIT(16'h3313))
    _al_u388 (
    .a(_al_u324_o),
    .b(_al_u330_o),
    .c(_al_u349_o),
    .d(_al_u333_o),
    .o(\bctl/brdy_t ));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u389 (
    .a(bcs_sdram_n),
    .o(badrx[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u81 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [0]),
    .c(badrx1[0]),
    .o(\acpu/badrx_cp1 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u82 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [1]),
    .c(badrx1[1]),
    .o(\acpu/badrx_cp1 [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u83 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [2]),
    .c(badrx1[2]),
    .o(\acpu/badrx_cp1 [2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u84 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [3]),
    .c(badrx1[3]),
    .o(\acpu/badrx_cp1 [3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u85 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [4]),
    .c(badrx1[4]),
    .o(\acpu/badrx_cp1 [4]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u86 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [5]),
    .c(badrx1[5]),
    .o(\acpu/badrx_cp1 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u87 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [6]),
    .c(badrx1[6]),
    .o(\acpu/badrx_cp1 [6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u88 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badrx1_c [7]),
    .c(badrx1[7]),
    .o(\acpu/badrx_cp1 [7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u89 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [1]),
    .c(badr1[1]),
    .o(\acpu/badr_cp1 [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u90 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [10]),
    .c(badr1[10]),
    .o(\acpu/badr_cp1 [10]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u91 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [11]),
    .c(badr1[11]),
    .o(\acpu/badr_cp1 [11]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u92 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [12]),
    .c(badr1[12]),
    .o(\acpu/badr_cp1 [12]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u93 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [13]),
    .c(badr1[13]),
    .o(\acpu/badr_cp1 [13]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u94 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [14]),
    .c(badr1[14]),
    .o(\acpu/badr_cp1 [14]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u95 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [15]),
    .c(badr1[15]),
    .o(\acpu/badr_cp1 [15]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u96 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [2]),
    .c(badr1[2]),
    .o(\acpu/badr_cp1 [2]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u97 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [3]),
    .c(badr1[3]),
    .o(\acpu/badr_cp1 [3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u98 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [4]),
    .c(badr1[4]),
    .o(\acpu/badr_cp1 [4]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u99 (
    .a(\acpu/neg_brdy1 ),
    .b(\acpu/badr1_c [5]),
    .c(badr1[5]),
    .o(\acpu/badr_cp1 [5]));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u0  (
    .a(\acpu/badr_cp1 [1]),
    .b(\acpu/bacp_adr_inc1 ),
    .c(\acpu/add0/c0 ),
    .o({\acpu/add0/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u1  (
    .a(\acpu/badr_cp1 [2]),
    .b(1'b0),
    .c(\acpu/add0/c1 ),
    .o({\acpu/add0/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u10  (
    .a(\acpu/badr_cp1 [11]),
    .b(1'b0),
    .c(\acpu/add0/c10 ),
    .o({\acpu/add0/c11 ,n0[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u11  (
    .a(\acpu/badr_cp1 [12]),
    .b(1'b0),
    .c(\acpu/add0/c11 ),
    .o({\acpu/add0/c12 ,n0[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u12  (
    .a(\acpu/badr_cp1 [13]),
    .b(1'b0),
    .c(\acpu/add0/c12 ),
    .o({\acpu/add0/c13 ,n0[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u13  (
    .a(\acpu/badr_cp1 [14]),
    .b(1'b0),
    .c(\acpu/add0/c13 ),
    .o({\acpu/add0/c14 ,n0[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u14  (
    .a(\acpu/badr_cp1 [15]),
    .b(1'b0),
    .c(\acpu/add0/c14 ),
    .o({\acpu/add0/c15 ,n0[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u15  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [0]),
    .c(\acpu/add0/c15 ),
    .o({\acpu/add0/c16 ,n0[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u16  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [1]),
    .c(\acpu/add0/c16 ),
    .o({\acpu/add0/c17 ,n0[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u17  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [2]),
    .c(\acpu/add0/c17 ),
    .o({\acpu/add0/c18 ,n0[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u18  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [3]),
    .c(\acpu/add0/c18 ),
    .o({\acpu/add0/c19 ,n0[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u19  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [4]),
    .c(\acpu/add0/c19 ),
    .o({\acpu/add0/c20 ,n0[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u2  (
    .a(\acpu/badr_cp1 [3]),
    .b(1'b0),
    .c(\acpu/add0/c2 ),
    .o({\acpu/add0/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u20  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [5]),
    .c(\acpu/add0/c20 ),
    .o({\acpu/add0/c21 ,n0[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u21  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [6]),
    .c(\acpu/add0/c21 ),
    .o({\acpu/add0/c22 ,n0[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u22  (
    .a(1'b0),
    .b(\acpu/badrx_cp1 [7]),
    .c(\acpu/add0/c22 ),
    .o({open_n0,n0[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u3  (
    .a(\acpu/badr_cp1 [4]),
    .b(1'b0),
    .c(\acpu/add0/c3 ),
    .o({\acpu/add0/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u4  (
    .a(\acpu/badr_cp1 [5]),
    .b(1'b0),
    .c(\acpu/add0/c4 ),
    .o({\acpu/add0/c5 ,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u5  (
    .a(\acpu/badr_cp1 [6]),
    .b(1'b0),
    .c(\acpu/add0/c5 ),
    .o({\acpu/add0/c6 ,n0[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u6  (
    .a(\acpu/badr_cp1 [7]),
    .b(1'b0),
    .c(\acpu/add0/c6 ),
    .o({\acpu/add0/c7 ,n0[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u7  (
    .a(\acpu/badr_cp1 [8]),
    .b(1'b0),
    .c(\acpu/add0/c7 ),
    .o({\acpu/add0/c8 ,n0[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u8  (
    .a(\acpu/badr_cp1 [9]),
    .b(1'b0),
    .c(\acpu/add0/c8 ),
    .o({\acpu/add0/c9 ,n0[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add0/u9  (
    .a(\acpu/badr_cp1 [10]),
    .b(1'b0),
    .c(\acpu/add0/c9 ),
    .o({\acpu/add0/c10 ,n0[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \acpu/add0/ucin  (
    .a(1'b0),
    .o({\acpu/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u0  (
    .a(\acpu/badr_cp2 [1]),
    .b(\acpu/bacp_adr_inc2 ),
    .c(\acpu/add1/c0 ),
    .o({\acpu/add1/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u1  (
    .a(\acpu/badr_cp2 [2]),
    .b(1'b0),
    .c(\acpu/add1/c1 ),
    .o({\acpu/add1/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u10  (
    .a(\acpu/badr_cp2 [11]),
    .b(1'b0),
    .c(\acpu/add1/c10 ),
    .o({\acpu/add1/c11 ,n1[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u11  (
    .a(\acpu/badr_cp2 [12]),
    .b(1'b0),
    .c(\acpu/add1/c11 ),
    .o({\acpu/add1/c12 ,n1[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u12  (
    .a(\acpu/badr_cp2 [13]),
    .b(1'b0),
    .c(\acpu/add1/c12 ),
    .o({\acpu/add1/c13 ,n1[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u13  (
    .a(\acpu/badr_cp2 [14]),
    .b(1'b0),
    .c(\acpu/add1/c13 ),
    .o({\acpu/add1/c14 ,n1[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u14  (
    .a(\acpu/badr_cp2 [15]),
    .b(1'b0),
    .c(\acpu/add1/c14 ),
    .o({\acpu/add1/c15 ,n1[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u15  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [0]),
    .c(\acpu/add1/c15 ),
    .o({\acpu/add1/c16 ,n1[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u16  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [1]),
    .c(\acpu/add1/c16 ),
    .o({\acpu/add1/c17 ,n1[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u17  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [2]),
    .c(\acpu/add1/c17 ),
    .o({\acpu/add1/c18 ,n1[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u18  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [3]),
    .c(\acpu/add1/c18 ),
    .o({\acpu/add1/c19 ,n1[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u19  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [4]),
    .c(\acpu/add1/c19 ),
    .o({\acpu/add1/c20 ,n1[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u2  (
    .a(\acpu/badr_cp2 [3]),
    .b(1'b0),
    .c(\acpu/add1/c2 ),
    .o({\acpu/add1/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u20  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [5]),
    .c(\acpu/add1/c20 ),
    .o({\acpu/add1/c21 ,n1[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u21  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [6]),
    .c(\acpu/add1/c21 ),
    .o({\acpu/add1/c22 ,n1[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u22  (
    .a(1'b0),
    .b(\acpu/badrx_cp2 [7]),
    .c(\acpu/add1/c22 ),
    .o({open_n4,n1[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u3  (
    .a(\acpu/badr_cp2 [4]),
    .b(1'b0),
    .c(\acpu/add1/c3 ),
    .o({\acpu/add1/c4 ,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u4  (
    .a(\acpu/badr_cp2 [5]),
    .b(1'b0),
    .c(\acpu/add1/c4 ),
    .o({\acpu/add1/c5 ,n1[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u5  (
    .a(\acpu/badr_cp2 [6]),
    .b(1'b0),
    .c(\acpu/add1/c5 ),
    .o({\acpu/add1/c6 ,n1[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u6  (
    .a(\acpu/badr_cp2 [7]),
    .b(1'b0),
    .c(\acpu/add1/c6 ),
    .o({\acpu/add1/c7 ,n1[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u7  (
    .a(\acpu/badr_cp2 [8]),
    .b(1'b0),
    .c(\acpu/add1/c7 ),
    .o({\acpu/add1/c8 ,n1[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u8  (
    .a(\acpu/badr_cp2 [9]),
    .b(1'b0),
    .c(\acpu/add1/c8 ),
    .o({\acpu/add1/c9 ,n1[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \acpu/add1/u9  (
    .a(\acpu/badr_cp2 [10]),
    .b(1'b0),
    .c(\acpu/add1/c9 ),
    .o({\acpu/add1/c10 ,n1[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \acpu/add1/ucin  (
    .a(1'b0),
    .o({\acpu/add1/c0 ,open_n7}));
  reg_sr_as_w1 \acpu/blng1/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\acpu/blng1/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\acpu/blng1/stat [0]));  // rtl/busc_long_fsm.v(79)
  reg_sr_as_w1 \acpu/blng1/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\acpu/blng1/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\acpu/blng1/stat [1]));  // rtl/busc_long_fsm.v(79)
  reg_sr_as_w1 \acpu/blng2/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\acpu/blng2/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\acpu/blng2/stat [0]));  // rtl/busc_long_fsm.v(79)
  reg_sr_as_w1 \acpu/blng2/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\acpu/blng2/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\acpu/blng2/stat [1]));  // rtl/busc_long_fsm.v(79)
  reg_sr_as_w1 \acpu/last_sel_reg  (
    .clk(clk),
    .d(\acpu/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/last_sel ));  // rtl/busc2040dl.v(510)
  reg_sr_as_w1 \acpu/neg_brdy1_reg  (
    .clk(clk),
    .d(\acpu/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/neg_brdy1 ));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/neg_brdy2_reg  (
    .clk(clk),
    .d(\acpu/n23 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/neg_brdy2 ));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg0_b0  (
    .clk(clk),
    .d(bcmd1[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd1_c [0]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg0_b1  (
    .clk(clk),
    .d(bcmd1[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd1_c [1]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg0_b2  (
    .clk(clk),
    .d(bcmd1[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd1_c [2]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg0_b3  (
    .clk(clk),
    .d(bcmd1[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd1_c [3]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg10_b0  (
    .clk(clk),
    .d(bdatw2[0]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [0]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b1  (
    .clk(clk),
    .d(bdatw2[1]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [1]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b10  (
    .clk(clk),
    .d(bdatw2[10]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [10]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b11  (
    .clk(clk),
    .d(bdatw2[11]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [11]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b12  (
    .clk(clk),
    .d(bdatw2[12]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [12]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b13  (
    .clk(clk),
    .d(bdatw2[13]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [13]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b14  (
    .clk(clk),
    .d(bdatw2[14]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [14]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b15  (
    .clk(clk),
    .d(bdatw2[15]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [15]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b2  (
    .clk(clk),
    .d(bdatw2[2]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [2]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b3  (
    .clk(clk),
    .d(bdatw2[3]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [3]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b4  (
    .clk(clk),
    .d(bdatw2[4]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [4]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b5  (
    .clk(clk),
    .d(bdatw2[5]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [5]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b6  (
    .clk(clk),
    .d(bdatw2[6]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [6]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b7  (
    .clk(clk),
    .d(bdatw2[7]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [7]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b8  (
    .clk(clk),
    .d(bdatw2[8]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [8]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg10_b9  (
    .clk(clk),
    .d(bdatw2[9]),
    .en(\acpu/bacp_drv_datwh2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl2 [9]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg1_b0  (
    .clk(clk),
    .d(badrx1[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [0]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg1_b1  (
    .clk(clk),
    .d(badrx1[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [1]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg1_b2  (
    .clk(clk),
    .d(badrx1[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [2]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg1_b3  (
    .clk(clk),
    .d(badrx1[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [3]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg1_b4  (
    .clk(clk),
    .d(badrx1[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [4]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg1_b5  (
    .clk(clk),
    .d(badrx1[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [5]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg1_b6  (
    .clk(clk),
    .d(badrx1[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [6]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg1_b7  (
    .clk(clk),
    .d(badrx1[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx1_c [7]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b0  (
    .clk(clk),
    .d(badr1[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [0]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b1  (
    .clk(clk),
    .d(badr1[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [1]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b10  (
    .clk(clk),
    .d(badr1[10]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [10]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b11  (
    .clk(clk),
    .d(badr1[11]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [11]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b12  (
    .clk(clk),
    .d(badr1[12]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [12]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b13  (
    .clk(clk),
    .d(badr1[13]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [13]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b14  (
    .clk(clk),
    .d(badr1[14]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [14]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b15  (
    .clk(clk),
    .d(badr1[15]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [15]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b2  (
    .clk(clk),
    .d(badr1[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [2]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b3  (
    .clk(clk),
    .d(badr1[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [3]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b4  (
    .clk(clk),
    .d(badr1[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [4]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b5  (
    .clk(clk),
    .d(badr1[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [5]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b6  (
    .clk(clk),
    .d(badr1[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [6]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b7  (
    .clk(clk),
    .d(badr1[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [7]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b8  (
    .clk(clk),
    .d(badr1[8]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [8]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg2_b9  (
    .clk(clk),
    .d(badr1[9]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr1_c [9]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b0  (
    .clk(clk),
    .d(bdatw1[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [0]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b1  (
    .clk(clk),
    .d(bdatw1[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [1]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b10  (
    .clk(clk),
    .d(bdatw1[10]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [10]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b11  (
    .clk(clk),
    .d(bdatw1[11]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [11]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b12  (
    .clk(clk),
    .d(bdatw1[12]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [12]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b13  (
    .clk(clk),
    .d(bdatw1[13]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [13]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b14  (
    .clk(clk),
    .d(bdatw1[14]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [14]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b15  (
    .clk(clk),
    .d(bdatw1[15]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [15]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b16  (
    .clk(clk),
    .d(bdatw1[16]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [16]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b17  (
    .clk(clk),
    .d(bdatw1[17]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [17]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b18  (
    .clk(clk),
    .d(bdatw1[18]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [18]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b19  (
    .clk(clk),
    .d(bdatw1[19]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [19]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b2  (
    .clk(clk),
    .d(bdatw1[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [2]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b20  (
    .clk(clk),
    .d(bdatw1[20]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [20]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b21  (
    .clk(clk),
    .d(bdatw1[21]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [21]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b22  (
    .clk(clk),
    .d(bdatw1[22]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [22]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b23  (
    .clk(clk),
    .d(bdatw1[23]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [23]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b24  (
    .clk(clk),
    .d(bdatw1[24]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [24]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b25  (
    .clk(clk),
    .d(bdatw1[25]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [25]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b26  (
    .clk(clk),
    .d(bdatw1[26]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [26]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b27  (
    .clk(clk),
    .d(bdatw1[27]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [27]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b28  (
    .clk(clk),
    .d(bdatw1[28]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [28]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b29  (
    .clk(clk),
    .d(bdatw1[29]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [29]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b3  (
    .clk(clk),
    .d(bdatw1[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [3]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b30  (
    .clk(clk),
    .d(bdatw1[30]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [30]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b31  (
    .clk(clk),
    .d(bdatw1[31]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [31]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b4  (
    .clk(clk),
    .d(bdatw1[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [4]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b5  (
    .clk(clk),
    .d(bdatw1[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [5]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b6  (
    .clk(clk),
    .d(bdatw1[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [6]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b7  (
    .clk(clk),
    .d(bdatw1[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [7]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b8  (
    .clk(clk),
    .d(bdatw1[8]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [8]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg3_b9  (
    .clk(clk),
    .d(bdatw1[9]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw1_c [9]));  // rtl/busc2040dl.v(552)
  reg_sr_as_w1 \acpu/reg4_b0  (
    .clk(clk),
    .d(bcmd2[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd2_c [0]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg4_b1  (
    .clk(clk),
    .d(bcmd2[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd2_c [1]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg4_b2  (
    .clk(clk),
    .d(bcmd2[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd2_c [2]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg4_b3  (
    .clk(clk),
    .d(bcmd2[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bcmd2_c [3]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b0  (
    .clk(clk),
    .d(badrx2[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [0]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b1  (
    .clk(clk),
    .d(badrx2[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [1]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b2  (
    .clk(clk),
    .d(badrx2[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [2]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b3  (
    .clk(clk),
    .d(badrx2[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [3]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b4  (
    .clk(clk),
    .d(badrx2[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [4]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b5  (
    .clk(clk),
    .d(badrx2[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [5]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b6  (
    .clk(clk),
    .d(badrx2[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [6]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg5_b7  (
    .clk(clk),
    .d(badrx2[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badrx2_c [7]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b0  (
    .clk(clk),
    .d(badr2[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [0]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b1  (
    .clk(clk),
    .d(badr2[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [1]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b10  (
    .clk(clk),
    .d(badr2[10]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [10]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b11  (
    .clk(clk),
    .d(badr2[11]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [11]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b12  (
    .clk(clk),
    .d(badr2[12]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [12]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b13  (
    .clk(clk),
    .d(badr2[13]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [13]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b14  (
    .clk(clk),
    .d(badr2[14]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [14]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b15  (
    .clk(clk),
    .d(badr2[15]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [15]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b2  (
    .clk(clk),
    .d(badr2[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [2]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b3  (
    .clk(clk),
    .d(badr2[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [3]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b4  (
    .clk(clk),
    .d(badr2[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [4]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b5  (
    .clk(clk),
    .d(badr2[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [5]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b6  (
    .clk(clk),
    .d(badr2[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [6]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b7  (
    .clk(clk),
    .d(badr2[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [7]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b8  (
    .clk(clk),
    .d(badr2[8]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [8]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg6_b9  (
    .clk(clk),
    .d(badr2[9]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/badr2_c [9]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b0  (
    .clk(clk),
    .d(bdatw2[0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [0]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b1  (
    .clk(clk),
    .d(bdatw2[1]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [1]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b10  (
    .clk(clk),
    .d(bdatw2[10]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [10]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b11  (
    .clk(clk),
    .d(bdatw2[11]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [11]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b12  (
    .clk(clk),
    .d(bdatw2[12]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [12]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b13  (
    .clk(clk),
    .d(bdatw2[13]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [13]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b14  (
    .clk(clk),
    .d(bdatw2[14]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [14]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b15  (
    .clk(clk),
    .d(bdatw2[15]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [15]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b16  (
    .clk(clk),
    .d(bdatw2[16]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [16]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b17  (
    .clk(clk),
    .d(bdatw2[17]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [17]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b18  (
    .clk(clk),
    .d(bdatw2[18]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [18]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b19  (
    .clk(clk),
    .d(bdatw2[19]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [19]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b2  (
    .clk(clk),
    .d(bdatw2[2]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [2]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b20  (
    .clk(clk),
    .d(bdatw2[20]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [20]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b21  (
    .clk(clk),
    .d(bdatw2[21]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [21]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b22  (
    .clk(clk),
    .d(bdatw2[22]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [22]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b23  (
    .clk(clk),
    .d(bdatw2[23]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [23]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b24  (
    .clk(clk),
    .d(bdatw2[24]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [24]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b25  (
    .clk(clk),
    .d(bdatw2[25]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [25]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b26  (
    .clk(clk),
    .d(bdatw2[26]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [26]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b27  (
    .clk(clk),
    .d(bdatw2[27]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [27]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b28  (
    .clk(clk),
    .d(bdatw2[28]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [28]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b29  (
    .clk(clk),
    .d(bdatw2[29]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [29]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b3  (
    .clk(clk),
    .d(bdatw2[3]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [3]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b30  (
    .clk(clk),
    .d(bdatw2[30]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [30]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b31  (
    .clk(clk),
    .d(bdatw2[31]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [31]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b4  (
    .clk(clk),
    .d(bdatw2[4]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [4]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b5  (
    .clk(clk),
    .d(bdatw2[5]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [5]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b6  (
    .clk(clk),
    .d(bdatw2[6]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [6]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b7  (
    .clk(clk),
    .d(bdatw2[7]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [7]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b8  (
    .clk(clk),
    .d(bdatw2[8]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [8]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg7_b9  (
    .clk(clk),
    .d(bdatw2[9]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/bdatw2_c [9]));  // rtl/busc2040dl.v(574)
  reg_sr_as_w1 \acpu/reg8_b0  (
    .clk(clk),
    .d(bdatr[0]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [0]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b1  (
    .clk(clk),
    .d(bdatr[1]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [1]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b10  (
    .clk(clk),
    .d(bdatr[10]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [10]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b11  (
    .clk(clk),
    .d(bdatr[11]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [11]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b12  (
    .clk(clk),
    .d(bdatr[12]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [12]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b13  (
    .clk(clk),
    .d(bdatr[13]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [13]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b14  (
    .clk(clk),
    .d(bdatr[14]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [14]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b15  (
    .clk(clk),
    .d(bdatr[15]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [15]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b2  (
    .clk(clk),
    .d(bdatr[2]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [2]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b3  (
    .clk(clk),
    .d(bdatr[3]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [3]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b4  (
    .clk(clk),
    .d(bdatr[4]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [4]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b5  (
    .clk(clk),
    .d(bdatr[5]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [5]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b6  (
    .clk(clk),
    .d(bdatr[6]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [6]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b7  (
    .clk(clk),
    .d(bdatr[7]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [7]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b8  (
    .clk(clk),
    .d(bdatr[8]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [8]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg8_b9  (
    .clk(clk),
    .d(bdatr[9]),
    .en(~\acpu/blng1/n50 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datrh [9]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b0  (
    .clk(clk),
    .d(bdatw1[0]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [0]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b1  (
    .clk(clk),
    .d(bdatw1[1]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [1]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b10  (
    .clk(clk),
    .d(bdatw1[10]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [10]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b11  (
    .clk(clk),
    .d(bdatw1[11]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [11]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b12  (
    .clk(clk),
    .d(bdatw1[12]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [12]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b13  (
    .clk(clk),
    .d(bdatw1[13]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [13]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b14  (
    .clk(clk),
    .d(bdatw1[14]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [14]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b15  (
    .clk(clk),
    .d(bdatw1[15]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [15]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b2  (
    .clk(clk),
    .d(bdatw1[2]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [2]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b3  (
    .clk(clk),
    .d(bdatw1[3]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [3]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b4  (
    .clk(clk),
    .d(bdatw1[4]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [4]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b5  (
    .clk(clk),
    .d(bdatw1[5]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [5]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b6  (
    .clk(clk),
    .d(bdatw1[6]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [6]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b7  (
    .clk(clk),
    .d(bdatw1[7]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [7]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b8  (
    .clk(clk),
    .d(bdatw1[8]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [8]));  // rtl/busc2040dl.v(597)
  reg_sr_as_w1 \acpu/reg9_b9  (
    .clk(clk),
    .d(bdatw1[9]),
    .en(\acpu/bacp_drv_datwh1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\acpu/datwl1 [9]));  // rtl/busc2040dl.v(597)
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_0  (
    .a(badr[0]),
    .b(1'b0),
    .c(\adec/lt0_c0 ),
    .o({\adec/lt0_c1 ,open_n8}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_1  (
    .a(badr[1]),
    .b(1'b0),
    .c(\adec/lt0_c1 ),
    .o({\adec/lt0_c2 ,open_n9}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_10  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt0_c10 ),
    .o({\adec/lt0_c11 ,open_n10}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_11  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt0_c11 ),
    .o({\adec/lt0_c12 ,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_12  (
    .a(badr[12]),
    .b(1'b0),
    .c(\adec/lt0_c12 ),
    .o({\adec/lt0_c13 ,open_n12}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_13  (
    .a(badr[13]),
    .b(1'b0),
    .c(\adec/lt0_c13 ),
    .o({\adec/lt0_c14 ,open_n13}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_14  (
    .a(badr[14]),
    .b(1'b1),
    .c(\adec/lt0_c14 ),
    .o({\adec/lt0_c15 ,open_n14}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_15  (
    .a(badr[15]),
    .b(1'b0),
    .c(\adec/lt0_c15 ),
    .o({\adec/lt0_c16 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_2  (
    .a(badr[2]),
    .b(1'b0),
    .c(\adec/lt0_c2 ),
    .o({\adec/lt0_c3 ,open_n16}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_3  (
    .a(badr[3]),
    .b(1'b0),
    .c(\adec/lt0_c3 ),
    .o({\adec/lt0_c4 ,open_n17}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_4  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt0_c4 ),
    .o({\adec/lt0_c5 ,open_n18}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_5  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt0_c5 ),
    .o({\adec/lt0_c6 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_6  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt0_c6 ),
    .o({\adec/lt0_c7 ,open_n20}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_7  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt0_c7 ),
    .o({\adec/lt0_c8 ,open_n21}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_8  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt0_c8 ),
    .o({\adec/lt0_c9 ,open_n22}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_9  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt0_c9 ),
    .o({\adec/lt0_c10 ,open_n23}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt0_cin  (
    .a(1'b0),
    .o({\adec/lt0_c0 ,open_n26}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt0_c16 ),
    .o({open_n27,\adec/n1 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_0  (
    .a(badr2[0]),
    .b(1'b0),
    .c(\adec/lt10_c0 ),
    .o({\adec/lt10_c1 ,open_n28}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_1  (
    .a(badr2[1]),
    .b(1'b0),
    .c(\adec/lt10_c1 ),
    .o({\adec/lt10_c2 ,open_n29}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_10  (
    .a(badr2[10]),
    .b(1'b0),
    .c(\adec/lt10_c10 ),
    .o({\adec/lt10_c11 ,open_n30}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_11  (
    .a(badr2[11]),
    .b(1'b0),
    .c(\adec/lt10_c11 ),
    .o({\adec/lt10_c12 ,open_n31}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_12  (
    .a(badr2[12]),
    .b(1'b0),
    .c(\adec/lt10_c12 ),
    .o({\adec/lt10_c13 ,open_n32}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_13  (
    .a(badr2[13]),
    .b(1'b0),
    .c(\adec/lt10_c13 ),
    .o({\adec/lt10_c14 ,open_n33}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_14  (
    .a(badr2[14]),
    .b(1'b1),
    .c(\adec/lt10_c14 ),
    .o({\adec/lt10_c15 ,open_n34}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_15  (
    .a(badr2[15]),
    .b(1'b0),
    .c(\adec/lt10_c15 ),
    .o({\adec/lt10_c16 ,open_n35}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_2  (
    .a(badr2[2]),
    .b(1'b0),
    .c(\adec/lt10_c2 ),
    .o({\adec/lt10_c3 ,open_n36}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_3  (
    .a(badr2[3]),
    .b(1'b0),
    .c(\adec/lt10_c3 ),
    .o({\adec/lt10_c4 ,open_n37}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_4  (
    .a(badr2[4]),
    .b(1'b0),
    .c(\adec/lt10_c4 ),
    .o({\adec/lt10_c5 ,open_n38}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_5  (
    .a(badr2[5]),
    .b(1'b0),
    .c(\adec/lt10_c5 ),
    .o({\adec/lt10_c6 ,open_n39}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_6  (
    .a(badr2[6]),
    .b(1'b0),
    .c(\adec/lt10_c6 ),
    .o({\adec/lt10_c7 ,open_n40}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_7  (
    .a(badr2[7]),
    .b(1'b0),
    .c(\adec/lt10_c7 ),
    .o({\adec/lt10_c8 ,open_n41}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_8  (
    .a(badr2[8]),
    .b(1'b0),
    .c(\adec/lt10_c8 ),
    .o({\adec/lt10_c9 ,open_n42}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_9  (
    .a(badr2[9]),
    .b(1'b0),
    .c(\adec/lt10_c9 ),
    .o({\adec/lt10_c10 ,open_n43}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt10_cin  (
    .a(1'b0),
    .o({\adec/lt10_c0 ,open_n46}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt10_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt10_c16 ),
    .o({open_n47,\adec/n21 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_0  (
    .a(1'b0),
    .b(badr2[0]),
    .c(\adec/lt11_c0 ),
    .o({\adec/lt11_c1 ,open_n48}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_1  (
    .a(1'b0),
    .b(badr2[1]),
    .c(\adec/lt11_c1 ),
    .o({\adec/lt11_c2 ,open_n49}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_10  (
    .a(1'b0),
    .b(badr2[10]),
    .c(\adec/lt11_c10 ),
    .o({\adec/lt11_c11 ,open_n50}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_11  (
    .a(1'b0),
    .b(badr2[11]),
    .c(\adec/lt11_c11 ),
    .o({\adec/lt11_c12 ,open_n51}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_12  (
    .a(1'b1),
    .b(badr2[12]),
    .c(\adec/lt11_c12 ),
    .o({\adec/lt11_c13 ,open_n52}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_13  (
    .a(1'b0),
    .b(badr2[13]),
    .c(\adec/lt11_c13 ),
    .o({\adec/lt11_c14 ,open_n53}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_14  (
    .a(1'b1),
    .b(badr2[14]),
    .c(\adec/lt11_c14 ),
    .o({\adec/lt11_c15 ,open_n54}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_15  (
    .a(1'b0),
    .b(badr2[15]),
    .c(\adec/lt11_c15 ),
    .o({\adec/lt11_c16 ,open_n55}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_2  (
    .a(1'b0),
    .b(badr2[2]),
    .c(\adec/lt11_c2 ),
    .o({\adec/lt11_c3 ,open_n56}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_3  (
    .a(1'b0),
    .b(badr2[3]),
    .c(\adec/lt11_c3 ),
    .o({\adec/lt11_c4 ,open_n57}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_4  (
    .a(1'b0),
    .b(badr2[4]),
    .c(\adec/lt11_c4 ),
    .o({\adec/lt11_c5 ,open_n58}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_5  (
    .a(1'b0),
    .b(badr2[5]),
    .c(\adec/lt11_c5 ),
    .o({\adec/lt11_c6 ,open_n59}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_6  (
    .a(1'b0),
    .b(badr2[6]),
    .c(\adec/lt11_c6 ),
    .o({\adec/lt11_c7 ,open_n60}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_7  (
    .a(1'b0),
    .b(badr2[7]),
    .c(\adec/lt11_c7 ),
    .o({\adec/lt11_c8 ,open_n61}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_8  (
    .a(1'b0),
    .b(badr2[8]),
    .c(\adec/lt11_c8 ),
    .o({\adec/lt11_c9 ,open_n62}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_9  (
    .a(1'b0),
    .b(badr2[9]),
    .c(\adec/lt11_c9 ),
    .o({\adec/lt11_c10 ,open_n63}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt11_cin  (
    .a(1'b1),
    .o({\adec/lt11_c0 ,open_n66}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt11_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt11_c16 ),
    .o({open_n67,\adec/n22 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_0  (
    .a(badr2[0]),
    .b(1'b0),
    .c(\adec/lt12_c0 ),
    .o({\adec/lt12_c1 ,open_n68}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_1  (
    .a(badr2[1]),
    .b(1'b0),
    .c(\adec/lt12_c1 ),
    .o({\adec/lt12_c2 ,open_n69}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_10  (
    .a(badr2[10]),
    .b(1'b0),
    .c(\adec/lt12_c10 ),
    .o({\adec/lt12_c11 ,open_n70}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_11  (
    .a(badr2[11]),
    .b(1'b0),
    .c(\adec/lt12_c11 ),
    .o({\adec/lt12_c12 ,open_n71}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_12  (
    .a(badr2[12]),
    .b(1'b1),
    .c(\adec/lt12_c12 ),
    .o({\adec/lt12_c13 ,open_n72}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_13  (
    .a(badr2[13]),
    .b(1'b1),
    .c(\adec/lt12_c13 ),
    .o({\adec/lt12_c14 ,open_n73}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_14  (
    .a(badr2[14]),
    .b(1'b1),
    .c(\adec/lt12_c14 ),
    .o({\adec/lt12_c15 ,open_n74}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_15  (
    .a(badr2[15]),
    .b(1'b1),
    .c(\adec/lt12_c15 ),
    .o({\adec/lt12_c16 ,open_n75}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_2  (
    .a(badr2[2]),
    .b(1'b0),
    .c(\adec/lt12_c2 ),
    .o({\adec/lt12_c3 ,open_n76}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_3  (
    .a(badr2[3]),
    .b(1'b0),
    .c(\adec/lt12_c3 ),
    .o({\adec/lt12_c4 ,open_n77}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_4  (
    .a(badr2[4]),
    .b(1'b0),
    .c(\adec/lt12_c4 ),
    .o({\adec/lt12_c5 ,open_n78}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_5  (
    .a(badr2[5]),
    .b(1'b0),
    .c(\adec/lt12_c5 ),
    .o({\adec/lt12_c6 ,open_n79}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_6  (
    .a(badr2[6]),
    .b(1'b0),
    .c(\adec/lt12_c6 ),
    .o({\adec/lt12_c7 ,open_n80}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_7  (
    .a(badr2[7]),
    .b(1'b0),
    .c(\adec/lt12_c7 ),
    .o({\adec/lt12_c8 ,open_n81}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_8  (
    .a(badr2[8]),
    .b(1'b0),
    .c(\adec/lt12_c8 ),
    .o({\adec/lt12_c9 ,open_n82}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_9  (
    .a(badr2[9]),
    .b(1'b0),
    .c(\adec/lt12_c9 ),
    .o({\adec/lt12_c10 ,open_n83}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt12_cin  (
    .a(1'b0),
    .o({\adec/lt12_c0 ,open_n86}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt12_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt12_c16 ),
    .o({open_n87,\adec/n23 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_0  (
    .a(1'b0),
    .b(badr[0]),
    .c(\adec/lt1_c0 ),
    .o({\adec/lt1_c1 ,open_n88}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_1  (
    .a(1'b0),
    .b(badr[1]),
    .c(\adec/lt1_c1 ),
    .o({\adec/lt1_c2 ,open_n89}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_10  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt1_c10 ),
    .o({\adec/lt1_c11 ,open_n90}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_11  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt1_c11 ),
    .o({\adec/lt1_c12 ,open_n91}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_12  (
    .a(1'b0),
    .b(badr[12]),
    .c(\adec/lt1_c12 ),
    .o({\adec/lt1_c13 ,open_n92}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_13  (
    .a(1'b0),
    .b(badr[13]),
    .c(\adec/lt1_c13 ),
    .o({\adec/lt1_c14 ,open_n93}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_14  (
    .a(1'b1),
    .b(badr[14]),
    .c(\adec/lt1_c14 ),
    .o({\adec/lt1_c15 ,open_n94}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_15  (
    .a(1'b0),
    .b(badr[15]),
    .c(\adec/lt1_c15 ),
    .o({\adec/lt1_c16 ,open_n95}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_2  (
    .a(1'b0),
    .b(badr[2]),
    .c(\adec/lt1_c2 ),
    .o({\adec/lt1_c3 ,open_n96}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_3  (
    .a(1'b0),
    .b(badr[3]),
    .c(\adec/lt1_c3 ),
    .o({\adec/lt1_c4 ,open_n97}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_4  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt1_c4 ),
    .o({\adec/lt1_c5 ,open_n98}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_5  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt1_c5 ),
    .o({\adec/lt1_c6 ,open_n99}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_6  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt1_c6 ),
    .o({\adec/lt1_c7 ,open_n100}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_7  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt1_c7 ),
    .o({\adec/lt1_c8 ,open_n101}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_8  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt1_c8 ),
    .o({\adec/lt1_c9 ,open_n102}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_9  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt1_c9 ),
    .o({\adec/lt1_c10 ,open_n103}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt1_cin  (
    .a(1'b1),
    .o({\adec/lt1_c0 ,open_n106}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt1_c16 ),
    .o({open_n107,\adec/n3 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt23_c0 ),
    .o({\adec/lt23_c1 ,open_n108}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt23_c1 ),
    .o({\adec/lt23_c2 ,open_n109}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt23_c2 ),
    .o({\adec/lt23_c3 ,open_n110}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt23_c3 ),
    .o({\adec/lt23_c4 ,open_n111}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt23_c4 ),
    .o({\adec/lt23_c5 ,open_n112}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt23_c5 ),
    .o({\adec/lt23_c6 ,open_n113}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt23_c6 ),
    .o({\adec/lt23_c7 ,open_n114}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt23_c7 ),
    .o({\adec/lt23_c8 ,open_n115}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt23_cin  (
    .a(1'b0),
    .o({\adec/lt23_c0 ,open_n118}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt23_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt23_c8 ),
    .o({open_n119,\adec/n56 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt24_c0 ),
    .o({\adec/lt24_c1 ,open_n120}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt24_c1 ),
    .o({\adec/lt24_c2 ,open_n121}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt24_c2 ),
    .o({\adec/lt24_c3 ,open_n122}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt24_c3 ),
    .o({\adec/lt24_c4 ,open_n123}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt24_c4 ),
    .o({\adec/lt24_c5 ,open_n124}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt24_c5 ),
    .o({\adec/lt24_c6 ,open_n125}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt24_c6 ),
    .o({\adec/lt24_c7 ,open_n126}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt24_c7 ),
    .o({\adec/lt24_c8 ,open_n127}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt24_cin  (
    .a(1'b1),
    .o({\adec/lt24_c0 ,open_n130}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt24_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt24_c8 ),
    .o({open_n131,\adec/n58 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt25_c0 ),
    .o({\adec/lt25_c1 ,open_n132}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt25_c1 ),
    .o({\adec/lt25_c2 ,open_n133}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt25_c2 ),
    .o({\adec/lt25_c3 ,open_n134}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt25_c3 ),
    .o({\adec/lt25_c4 ,open_n135}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt25_c4 ),
    .o({\adec/lt25_c5 ,open_n136}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt25_c5 ),
    .o({\adec/lt25_c6 ,open_n137}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt25_c6 ),
    .o({\adec/lt25_c7 ,open_n138}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt25_c7 ),
    .o({\adec/lt25_c8 ,open_n139}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt25_cin  (
    .a(1'b0),
    .o({\adec/lt25_c0 ,open_n142}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt25_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt25_c8 ),
    .o({open_n143,\adec/n60 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt26_c0 ),
    .o({\adec/lt26_c1 ,open_n144}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt26_c1 ),
    .o({\adec/lt26_c2 ,open_n145}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt26_c2 ),
    .o({\adec/lt26_c3 ,open_n146}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt26_c3 ),
    .o({\adec/lt26_c4 ,open_n147}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt26_c4 ),
    .o({\adec/lt26_c5 ,open_n148}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt26_c5 ),
    .o({\adec/lt26_c6 ,open_n149}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt26_c6 ),
    .o({\adec/lt26_c7 ,open_n150}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt26_c7 ),
    .o({\adec/lt26_c8 ,open_n151}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt26_cin  (
    .a(1'b1),
    .o({\adec/lt26_c0 ,open_n154}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt26_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt26_c8 ),
    .o({open_n155,\adec/n62 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt27_c0 ),
    .o({\adec/lt27_c1 ,open_n156}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt27_c1 ),
    .o({\adec/lt27_c2 ,open_n157}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt27_c2 ),
    .o({\adec/lt27_c3 ,open_n158}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt27_c3 ),
    .o({\adec/lt27_c4 ,open_n159}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt27_c4 ),
    .o({\adec/lt27_c5 ,open_n160}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt27_c5 ),
    .o({\adec/lt27_c6 ,open_n161}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt27_c6 ),
    .o({\adec/lt27_c7 ,open_n162}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt27_c7 ),
    .o({\adec/lt27_c8 ,open_n163}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt27_cin  (
    .a(1'b0),
    .o({\adec/lt27_c0 ,open_n166}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt27_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt27_c8 ),
    .o({open_n167,\adec/n64 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt28_c0 ),
    .o({\adec/lt28_c1 ,open_n168}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt28_c1 ),
    .o({\adec/lt28_c2 ,open_n169}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt28_c2 ),
    .o({\adec/lt28_c3 ,open_n170}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt28_c3 ),
    .o({\adec/lt28_c4 ,open_n171}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt28_c4 ),
    .o({\adec/lt28_c5 ,open_n172}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt28_c5 ),
    .o({\adec/lt28_c6 ,open_n173}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt28_c6 ),
    .o({\adec/lt28_c7 ,open_n174}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt28_c7 ),
    .o({\adec/lt28_c8 ,open_n175}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt28_cin  (
    .a(1'b1),
    .o({\adec/lt28_c0 ,open_n178}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt28_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt28_c8 ),
    .o({open_n179,\adec/n66 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt29_c0 ),
    .o({\adec/lt29_c1 ,open_n180}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt29_c1 ),
    .o({\adec/lt29_c2 ,open_n181}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt29_c2 ),
    .o({\adec/lt29_c3 ,open_n182}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt29_c3 ),
    .o({\adec/lt29_c4 ,open_n183}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt29_c4 ),
    .o({\adec/lt29_c5 ,open_n184}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt29_c5 ),
    .o({\adec/lt29_c6 ,open_n185}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt29_c6 ),
    .o({\adec/lt29_c7 ,open_n186}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt29_c7 ),
    .o({\adec/lt29_c8 ,open_n187}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt29_cin  (
    .a(1'b0),
    .o({\adec/lt29_c0 ,open_n190}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt29_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt29_c8 ),
    .o({open_n191,\adec/n68 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_0  (
    .a(badr[0]),
    .b(1'b0),
    .c(\adec/lt2_c0 ),
    .o({\adec/lt2_c1 ,open_n192}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_1  (
    .a(badr[1]),
    .b(1'b0),
    .c(\adec/lt2_c1 ),
    .o({\adec/lt2_c2 ,open_n193}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_10  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt2_c10 ),
    .o({\adec/lt2_c11 ,open_n194}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_11  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt2_c11 ),
    .o({\adec/lt2_c12 ,open_n195}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_12  (
    .a(badr[12]),
    .b(1'b1),
    .c(\adec/lt2_c12 ),
    .o({\adec/lt2_c13 ,open_n196}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_13  (
    .a(badr[13]),
    .b(1'b0),
    .c(\adec/lt2_c13 ),
    .o({\adec/lt2_c14 ,open_n197}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_14  (
    .a(badr[14]),
    .b(1'b1),
    .c(\adec/lt2_c14 ),
    .o({\adec/lt2_c15 ,open_n198}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_15  (
    .a(badr[15]),
    .b(1'b0),
    .c(\adec/lt2_c15 ),
    .o({\adec/lt2_c16 ,open_n199}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_2  (
    .a(badr[2]),
    .b(1'b0),
    .c(\adec/lt2_c2 ),
    .o({\adec/lt2_c3 ,open_n200}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_3  (
    .a(badr[3]),
    .b(1'b0),
    .c(\adec/lt2_c3 ),
    .o({\adec/lt2_c4 ,open_n201}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_4  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt2_c4 ),
    .o({\adec/lt2_c5 ,open_n202}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_5  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt2_c5 ),
    .o({\adec/lt2_c6 ,open_n203}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_6  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt2_c6 ),
    .o({\adec/lt2_c7 ,open_n204}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_7  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt2_c7 ),
    .o({\adec/lt2_c8 ,open_n205}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_8  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt2_c8 ),
    .o({\adec/lt2_c9 ,open_n206}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_9  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt2_c9 ),
    .o({\adec/lt2_c10 ,open_n207}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt2_cin  (
    .a(1'b0),
    .o({\adec/lt2_c0 ,open_n210}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt2_c16 ),
    .o({open_n211,\adec/n5 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt30_c0 ),
    .o({\adec/lt30_c1 ,open_n212}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt30_c1 ),
    .o({\adec/lt30_c2 ,open_n213}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt30_c2 ),
    .o({\adec/lt30_c3 ,open_n214}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt30_c3 ),
    .o({\adec/lt30_c4 ,open_n215}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt30_c4 ),
    .o({\adec/lt30_c5 ,open_n216}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt30_c5 ),
    .o({\adec/lt30_c6 ,open_n217}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt30_c6 ),
    .o({\adec/lt30_c7 ,open_n218}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt30_c7 ),
    .o({\adec/lt30_c8 ,open_n219}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt30_cin  (
    .a(1'b1),
    .o({\adec/lt30_c0 ,open_n222}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt30_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt30_c8 ),
    .o({open_n223,\adec/n70 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt31_c0 ),
    .o({\adec/lt31_c1 ,open_n224}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt31_c1 ),
    .o({\adec/lt31_c2 ,open_n225}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt31_c2 ),
    .o({\adec/lt31_c3 ,open_n226}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt31_c3 ),
    .o({\adec/lt31_c4 ,open_n227}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt31_c4 ),
    .o({\adec/lt31_c5 ,open_n228}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt31_c5 ),
    .o({\adec/lt31_c6 ,open_n229}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt31_c6 ),
    .o({\adec/lt31_c7 ,open_n230}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt31_c7 ),
    .o({\adec/lt31_c8 ,open_n231}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt31_cin  (
    .a(1'b0),
    .o({\adec/lt31_c0 ,open_n234}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt31_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt31_c8 ),
    .o({open_n235,\adec/n72 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt32_c0 ),
    .o({\adec/lt32_c1 ,open_n236}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt32_c1 ),
    .o({\adec/lt32_c2 ,open_n237}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt32_c2 ),
    .o({\adec/lt32_c3 ,open_n238}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt32_c3 ),
    .o({\adec/lt32_c4 ,open_n239}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt32_c4 ),
    .o({\adec/lt32_c5 ,open_n240}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt32_c5 ),
    .o({\adec/lt32_c6 ,open_n241}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt32_c6 ),
    .o({\adec/lt32_c7 ,open_n242}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt32_c7 ),
    .o({\adec/lt32_c8 ,open_n243}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt32_cin  (
    .a(1'b1),
    .o({\adec/lt32_c0 ,open_n246}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt32_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt32_c8 ),
    .o({open_n247,\adec/n74 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt33_c0 ),
    .o({\adec/lt33_c1 ,open_n248}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt33_c1 ),
    .o({\adec/lt33_c2 ,open_n249}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt33_c2 ),
    .o({\adec/lt33_c3 ,open_n250}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt33_c3 ),
    .o({\adec/lt33_c4 ,open_n251}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt33_c4 ),
    .o({\adec/lt33_c5 ,open_n252}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt33_c5 ),
    .o({\adec/lt33_c6 ,open_n253}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt33_c6 ),
    .o({\adec/lt33_c7 ,open_n254}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt33_c7 ),
    .o({\adec/lt33_c8 ,open_n255}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt33_cin  (
    .a(1'b0),
    .o({\adec/lt33_c0 ,open_n258}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt33_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt33_c8 ),
    .o({open_n259,\adec/n76 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt34_c0 ),
    .o({\adec/lt34_c1 ,open_n260}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt34_c1 ),
    .o({\adec/lt34_c2 ,open_n261}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt34_c2 ),
    .o({\adec/lt34_c3 ,open_n262}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt34_c3 ),
    .o({\adec/lt34_c4 ,open_n263}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt34_c4 ),
    .o({\adec/lt34_c5 ,open_n264}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt34_c5 ),
    .o({\adec/lt34_c6 ,open_n265}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt34_c6 ),
    .o({\adec/lt34_c7 ,open_n266}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt34_c7 ),
    .o({\adec/lt34_c8 ,open_n267}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt34_cin  (
    .a(1'b1),
    .o({\adec/lt34_c0 ,open_n270}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt34_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt34_c8 ),
    .o({open_n271,\adec/n78 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt35_c0 ),
    .o({\adec/lt35_c1 ,open_n272}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt35_c1 ),
    .o({\adec/lt35_c2 ,open_n273}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt35_c2 ),
    .o({\adec/lt35_c3 ,open_n274}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt35_c3 ),
    .o({\adec/lt35_c4 ,open_n275}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt35_c4 ),
    .o({\adec/lt35_c5 ,open_n276}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt35_c5 ),
    .o({\adec/lt35_c6 ,open_n277}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt35_c6 ),
    .o({\adec/lt35_c7 ,open_n278}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt35_c7 ),
    .o({\adec/lt35_c8 ,open_n279}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt35_cin  (
    .a(1'b0),
    .o({\adec/lt35_c0 ,open_n282}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt35_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt35_c8 ),
    .o({open_n283,\adec/n80 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt36_c0 ),
    .o({\adec/lt36_c1 ,open_n284}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt36_c1 ),
    .o({\adec/lt36_c2 ,open_n285}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt36_c2 ),
    .o({\adec/lt36_c3 ,open_n286}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt36_c3 ),
    .o({\adec/lt36_c4 ,open_n287}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt36_c4 ),
    .o({\adec/lt36_c5 ,open_n288}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt36_c5 ),
    .o({\adec/lt36_c6 ,open_n289}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt36_c6 ),
    .o({\adec/lt36_c7 ,open_n290}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt36_c7 ),
    .o({\adec/lt36_c8 ,open_n291}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt36_cin  (
    .a(1'b1),
    .o({\adec/lt36_c0 ,open_n294}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt36_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt36_c8 ),
    .o({open_n295,\adec/n82 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt37_c0 ),
    .o({\adec/lt37_c1 ,open_n296}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt37_c1 ),
    .o({\adec/lt37_c2 ,open_n297}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt37_c2 ),
    .o({\adec/lt37_c3 ,open_n298}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt37_c3 ),
    .o({\adec/lt37_c4 ,open_n299}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt37_c4 ),
    .o({\adec/lt37_c5 ,open_n300}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt37_c5 ),
    .o({\adec/lt37_c6 ,open_n301}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt37_c6 ),
    .o({\adec/lt37_c7 ,open_n302}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt37_c7 ),
    .o({\adec/lt37_c8 ,open_n303}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt37_cin  (
    .a(1'b0),
    .o({\adec/lt37_c0 ,open_n306}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt37_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt37_c8 ),
    .o({open_n307,\adec/n84 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt38_c0 ),
    .o({\adec/lt38_c1 ,open_n308}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt38_c1 ),
    .o({\adec/lt38_c2 ,open_n309}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt38_c2 ),
    .o({\adec/lt38_c3 ,open_n310}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt38_c3 ),
    .o({\adec/lt38_c4 ,open_n311}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt38_c4 ),
    .o({\adec/lt38_c5 ,open_n312}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt38_c5 ),
    .o({\adec/lt38_c6 ,open_n313}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt38_c6 ),
    .o({\adec/lt38_c7 ,open_n314}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt38_c7 ),
    .o({\adec/lt38_c8 ,open_n315}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt38_cin  (
    .a(1'b1),
    .o({\adec/lt38_c0 ,open_n318}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt38_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt38_c8 ),
    .o({open_n319,\adec/n86 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt39_c0 ),
    .o({\adec/lt39_c1 ,open_n320}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt39_c1 ),
    .o({\adec/lt39_c2 ,open_n321}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt39_c2 ),
    .o({\adec/lt39_c3 ,open_n322}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt39_c3 ),
    .o({\adec/lt39_c4 ,open_n323}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt39_c4 ),
    .o({\adec/lt39_c5 ,open_n324}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt39_c5 ),
    .o({\adec/lt39_c6 ,open_n325}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt39_c6 ),
    .o({\adec/lt39_c7 ,open_n326}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt39_c7 ),
    .o({\adec/lt39_c8 ,open_n327}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt39_cin  (
    .a(1'b0),
    .o({\adec/lt39_c0 ,open_n330}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt39_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt39_c8 ),
    .o({open_n331,\adec/n88 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_0  (
    .a(1'b0),
    .b(badr[0]),
    .c(\adec/lt3_c0 ),
    .o({\adec/lt3_c1 ,open_n332}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_1  (
    .a(1'b0),
    .b(badr[1]),
    .c(\adec/lt3_c1 ),
    .o({\adec/lt3_c2 ,open_n333}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_10  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt3_c10 ),
    .o({\adec/lt3_c11 ,open_n334}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_11  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt3_c11 ),
    .o({\adec/lt3_c12 ,open_n335}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_12  (
    .a(1'b1),
    .b(badr[12]),
    .c(\adec/lt3_c12 ),
    .o({\adec/lt3_c13 ,open_n336}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_13  (
    .a(1'b0),
    .b(badr[13]),
    .c(\adec/lt3_c13 ),
    .o({\adec/lt3_c14 ,open_n337}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_14  (
    .a(1'b1),
    .b(badr[14]),
    .c(\adec/lt3_c14 ),
    .o({\adec/lt3_c15 ,open_n338}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_15  (
    .a(1'b0),
    .b(badr[15]),
    .c(\adec/lt3_c15 ),
    .o({\adec/lt3_c16 ,open_n339}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_2  (
    .a(1'b0),
    .b(badr[2]),
    .c(\adec/lt3_c2 ),
    .o({\adec/lt3_c3 ,open_n340}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_3  (
    .a(1'b0),
    .b(badr[3]),
    .c(\adec/lt3_c3 ),
    .o({\adec/lt3_c4 ,open_n341}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_4  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt3_c4 ),
    .o({\adec/lt3_c5 ,open_n342}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_5  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt3_c5 ),
    .o({\adec/lt3_c6 ,open_n343}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_6  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt3_c6 ),
    .o({\adec/lt3_c7 ,open_n344}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_7  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt3_c7 ),
    .o({\adec/lt3_c8 ,open_n345}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_8  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt3_c8 ),
    .o({\adec/lt3_c9 ,open_n346}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_9  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt3_c9 ),
    .o({\adec/lt3_c10 ,open_n347}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt3_cin  (
    .a(1'b1),
    .o({\adec/lt3_c0 ,open_n350}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt3_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt3_c16 ),
    .o({open_n351,\adec/n7 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt40_c0 ),
    .o({\adec/lt40_c1 ,open_n352}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt40_c1 ),
    .o({\adec/lt40_c2 ,open_n353}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt40_c2 ),
    .o({\adec/lt40_c3 ,open_n354}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt40_c3 ),
    .o({\adec/lt40_c4 ,open_n355}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt40_c4 ),
    .o({\adec/lt40_c5 ,open_n356}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt40_c5 ),
    .o({\adec/lt40_c6 ,open_n357}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt40_c6 ),
    .o({\adec/lt40_c7 ,open_n358}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt40_c7 ),
    .o({\adec/lt40_c8 ,open_n359}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt40_cin  (
    .a(1'b1),
    .o({\adec/lt40_c0 ,open_n362}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt40_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt40_c8 ),
    .o({open_n363,\adec/n90 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt41_c0 ),
    .o({\adec/lt41_c1 ,open_n364}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt41_c1 ),
    .o({\adec/lt41_c2 ,open_n365}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt41_c2 ),
    .o({\adec/lt41_c3 ,open_n366}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt41_c3 ),
    .o({\adec/lt41_c4 ,open_n367}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt41_c4 ),
    .o({\adec/lt41_c5 ,open_n368}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt41_c5 ),
    .o({\adec/lt41_c6 ,open_n369}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt41_c6 ),
    .o({\adec/lt41_c7 ,open_n370}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt41_c7 ),
    .o({\adec/lt41_c8 ,open_n371}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt41_cin  (
    .a(1'b0),
    .o({\adec/lt41_c0 ,open_n374}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt41_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt41_c8 ),
    .o({open_n375,\adec/n92 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt42_c0 ),
    .o({\adec/lt42_c1 ,open_n376}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt42_c1 ),
    .o({\adec/lt42_c2 ,open_n377}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt42_c2 ),
    .o({\adec/lt42_c3 ,open_n378}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt42_c3 ),
    .o({\adec/lt42_c4 ,open_n379}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt42_c4 ),
    .o({\adec/lt42_c5 ,open_n380}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt42_c5 ),
    .o({\adec/lt42_c6 ,open_n381}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt42_c6 ),
    .o({\adec/lt42_c7 ,open_n382}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt42_c7 ),
    .o({\adec/lt42_c8 ,open_n383}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt42_cin  (
    .a(1'b1),
    .o({\adec/lt42_c0 ,open_n386}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt42_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt42_c8 ),
    .o({open_n387,\adec/n94 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt43_c0 ),
    .o({\adec/lt43_c1 ,open_n388}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt43_c1 ),
    .o({\adec/lt43_c2 ,open_n389}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt43_c2 ),
    .o({\adec/lt43_c3 ,open_n390}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt43_c3 ),
    .o({\adec/lt43_c4 ,open_n391}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt43_c4 ),
    .o({\adec/lt43_c5 ,open_n392}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt43_c5 ),
    .o({\adec/lt43_c6 ,open_n393}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt43_c6 ),
    .o({\adec/lt43_c7 ,open_n394}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt43_c7 ),
    .o({\adec/lt43_c8 ,open_n395}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt43_cin  (
    .a(1'b0),
    .o({\adec/lt43_c0 ,open_n398}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt43_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt43_c8 ),
    .o({open_n399,\adec/n96 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt44_c0 ),
    .o({\adec/lt44_c1 ,open_n400}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt44_c1 ),
    .o({\adec/lt44_c2 ,open_n401}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt44_c2 ),
    .o({\adec/lt44_c3 ,open_n402}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt44_c3 ),
    .o({\adec/lt44_c4 ,open_n403}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt44_c4 ),
    .o({\adec/lt44_c5 ,open_n404}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt44_c5 ),
    .o({\adec/lt44_c6 ,open_n405}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt44_c6 ),
    .o({\adec/lt44_c7 ,open_n406}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt44_c7 ),
    .o({\adec/lt44_c8 ,open_n407}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt44_cin  (
    .a(1'b1),
    .o({\adec/lt44_c0 ,open_n410}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt44_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt44_c8 ),
    .o({open_n411,\adec/n98 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt45_c0 ),
    .o({\adec/lt45_c1 ,open_n412}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt45_c1 ),
    .o({\adec/lt45_c2 ,open_n413}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt45_c2 ),
    .o({\adec/lt45_c3 ,open_n414}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt45_c3 ),
    .o({\adec/lt45_c4 ,open_n415}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt45_c4 ),
    .o({\adec/lt45_c5 ,open_n416}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt45_c5 ),
    .o({\adec/lt45_c6 ,open_n417}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt45_c6 ),
    .o({\adec/lt45_c7 ,open_n418}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt45_c7 ),
    .o({\adec/lt45_c8 ,open_n419}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt45_cin  (
    .a(1'b0),
    .o({\adec/lt45_c0 ,open_n422}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt45_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt45_c8 ),
    .o({open_n423,\adec/n100 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt46_c0 ),
    .o({\adec/lt46_c1 ,open_n424}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt46_c1 ),
    .o({\adec/lt46_c2 ,open_n425}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt46_c2 ),
    .o({\adec/lt46_c3 ,open_n426}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt46_c3 ),
    .o({\adec/lt46_c4 ,open_n427}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt46_c4 ),
    .o({\adec/lt46_c5 ,open_n428}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt46_c5 ),
    .o({\adec/lt46_c6 ,open_n429}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt46_c6 ),
    .o({\adec/lt46_c7 ,open_n430}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt46_c7 ),
    .o({\adec/lt46_c8 ,open_n431}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt46_cin  (
    .a(1'b1),
    .o({\adec/lt46_c0 ,open_n434}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt46_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt46_c8 ),
    .o({open_n435,\adec/n102 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt47_c0 ),
    .o({\adec/lt47_c1 ,open_n436}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt47_c1 ),
    .o({\adec/lt47_c2 ,open_n437}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt47_c2 ),
    .o({\adec/lt47_c3 ,open_n438}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt47_c3 ),
    .o({\adec/lt47_c4 ,open_n439}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt47_c4 ),
    .o({\adec/lt47_c5 ,open_n440}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt47_c5 ),
    .o({\adec/lt47_c6 ,open_n441}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt47_c6 ),
    .o({\adec/lt47_c7 ,open_n442}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt47_c7 ),
    .o({\adec/lt47_c8 ,open_n443}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt47_cin  (
    .a(1'b0),
    .o({\adec/lt47_c0 ,open_n446}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt47_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt47_c8 ),
    .o({open_n447,\adec/n104 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt48_c0 ),
    .o({\adec/lt48_c1 ,open_n448}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt48_c1 ),
    .o({\adec/lt48_c2 ,open_n449}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt48_c2 ),
    .o({\adec/lt48_c3 ,open_n450}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt48_c3 ),
    .o({\adec/lt48_c4 ,open_n451}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt48_c4 ),
    .o({\adec/lt48_c5 ,open_n452}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt48_c5 ),
    .o({\adec/lt48_c6 ,open_n453}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt48_c6 ),
    .o({\adec/lt48_c7 ,open_n454}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt48_c7 ),
    .o({\adec/lt48_c8 ,open_n455}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt48_cin  (
    .a(1'b1),
    .o({\adec/lt48_c0 ,open_n458}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt48_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt48_c8 ),
    .o({open_n459,\adec/n106 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt49_c0 ),
    .o({\adec/lt49_c1 ,open_n460}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt49_c1 ),
    .o({\adec/lt49_c2 ,open_n461}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt49_c2 ),
    .o({\adec/lt49_c3 ,open_n462}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt49_c3 ),
    .o({\adec/lt49_c4 ,open_n463}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt49_c4 ),
    .o({\adec/lt49_c5 ,open_n464}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt49_c5 ),
    .o({\adec/lt49_c6 ,open_n465}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt49_c6 ),
    .o({\adec/lt49_c7 ,open_n466}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt49_c7 ),
    .o({\adec/lt49_c8 ,open_n467}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt49_cin  (
    .a(1'b0),
    .o({\adec/lt49_c0 ,open_n470}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt49_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt49_c8 ),
    .o({open_n471,\adec/n108 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_0  (
    .a(badr[0]),
    .b(1'b0),
    .c(\adec/lt4_c0 ),
    .o({\adec/lt4_c1 ,open_n472}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_1  (
    .a(badr[1]),
    .b(1'b0),
    .c(\adec/lt4_c1 ),
    .o({\adec/lt4_c2 ,open_n473}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_10  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt4_c10 ),
    .o({\adec/lt4_c11 ,open_n474}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_11  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt4_c11 ),
    .o({\adec/lt4_c12 ,open_n475}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_12  (
    .a(badr[12]),
    .b(1'b1),
    .c(\adec/lt4_c12 ),
    .o({\adec/lt4_c13 ,open_n476}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_13  (
    .a(badr[13]),
    .b(1'b1),
    .c(\adec/lt4_c13 ),
    .o({\adec/lt4_c14 ,open_n477}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_14  (
    .a(badr[14]),
    .b(1'b1),
    .c(\adec/lt4_c14 ),
    .o({\adec/lt4_c15 ,open_n478}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_15  (
    .a(badr[15]),
    .b(1'b1),
    .c(\adec/lt4_c15 ),
    .o({\adec/lt4_c16 ,open_n479}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_2  (
    .a(badr[2]),
    .b(1'b0),
    .c(\adec/lt4_c2 ),
    .o({\adec/lt4_c3 ,open_n480}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_3  (
    .a(badr[3]),
    .b(1'b0),
    .c(\adec/lt4_c3 ),
    .o({\adec/lt4_c4 ,open_n481}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_4  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt4_c4 ),
    .o({\adec/lt4_c5 ,open_n482}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_5  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt4_c5 ),
    .o({\adec/lt4_c6 ,open_n483}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_6  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt4_c6 ),
    .o({\adec/lt4_c7 ,open_n484}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_7  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt4_c7 ),
    .o({\adec/lt4_c8 ,open_n485}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_8  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt4_c8 ),
    .o({\adec/lt4_c9 ,open_n486}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_9  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt4_c9 ),
    .o({\adec/lt4_c10 ,open_n487}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt4_cin  (
    .a(1'b0),
    .o({\adec/lt4_c0 ,open_n490}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt4_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt4_c16 ),
    .o({open_n491,\adec/n9 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt50_c0 ),
    .o({\adec/lt50_c1 ,open_n492}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt50_c1 ),
    .o({\adec/lt50_c2 ,open_n493}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt50_c2 ),
    .o({\adec/lt50_c3 ,open_n494}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt50_c3 ),
    .o({\adec/lt50_c4 ,open_n495}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt50_c4 ),
    .o({\adec/lt50_c5 ,open_n496}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt50_c5 ),
    .o({\adec/lt50_c6 ,open_n497}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt50_c6 ),
    .o({\adec/lt50_c7 ,open_n498}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt50_c7 ),
    .o({\adec/lt50_c8 ,open_n499}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt50_cin  (
    .a(1'b1),
    .o({\adec/lt50_c0 ,open_n502}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt50_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt50_c8 ),
    .o({open_n503,\adec/n110 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt51_c0 ),
    .o({\adec/lt51_c1 ,open_n504}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt51_c1 ),
    .o({\adec/lt51_c2 ,open_n505}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt51_c2 ),
    .o({\adec/lt51_c3 ,open_n506}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_3  (
    .a(badr[7]),
    .b(1'b1),
    .c(\adec/lt51_c3 ),
    .o({\adec/lt51_c4 ,open_n507}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_4  (
    .a(badr[8]),
    .b(1'b0),
    .c(\adec/lt51_c4 ),
    .o({\adec/lt51_c5 ,open_n508}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt51_c5 ),
    .o({\adec/lt51_c6 ,open_n509}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt51_c6 ),
    .o({\adec/lt51_c7 ,open_n510}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt51_c7 ),
    .o({\adec/lt51_c8 ,open_n511}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt51_cin  (
    .a(1'b0),
    .o({\adec/lt51_c0 ,open_n514}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt51_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt51_c8 ),
    .o({open_n515,\adec/n112 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt52_c0 ),
    .o({\adec/lt52_c1 ,open_n516}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt52_c1 ),
    .o({\adec/lt52_c2 ,open_n517}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt52_c2 ),
    .o({\adec/lt52_c3 ,open_n518}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_3  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt52_c3 ),
    .o({\adec/lt52_c4 ,open_n519}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_4  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt52_c4 ),
    .o({\adec/lt52_c5 ,open_n520}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt52_c5 ),
    .o({\adec/lt52_c6 ,open_n521}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt52_c6 ),
    .o({\adec/lt52_c7 ,open_n522}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt52_c7 ),
    .o({\adec/lt52_c8 ,open_n523}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt52_cin  (
    .a(1'b1),
    .o({\adec/lt52_c0 ,open_n526}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt52_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt52_c8 ),
    .o({open_n527,\adec/n114 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt53_c0 ),
    .o({\adec/lt53_c1 ,open_n528}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt53_c1 ),
    .o({\adec/lt53_c2 ,open_n529}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt53_c2 ),
    .o({\adec/lt53_c3 ,open_n530}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt53_c3 ),
    .o({\adec/lt53_c4 ,open_n531}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_4  (
    .a(badr[8]),
    .b(1'b1),
    .c(\adec/lt53_c4 ),
    .o({\adec/lt53_c5 ,open_n532}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt53_c5 ),
    .o({\adec/lt53_c6 ,open_n533}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt53_c6 ),
    .o({\adec/lt53_c7 ,open_n534}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt53_c7 ),
    .o({\adec/lt53_c8 ,open_n535}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt53_cin  (
    .a(1'b0),
    .o({\adec/lt53_c0 ,open_n538}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt53_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt53_c8 ),
    .o({open_n539,\adec/n116 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt54_c0 ),
    .o({\adec/lt54_c1 ,open_n540}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt54_c1 ),
    .o({\adec/lt54_c2 ,open_n541}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt54_c2 ),
    .o({\adec/lt54_c3 ,open_n542}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt54_c3 ),
    .o({\adec/lt54_c4 ,open_n543}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_4  (
    .a(1'b1),
    .b(badr[8]),
    .c(\adec/lt54_c4 ),
    .o({\adec/lt54_c5 ,open_n544}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt54_c5 ),
    .o({\adec/lt54_c6 ,open_n545}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt54_c6 ),
    .o({\adec/lt54_c7 ,open_n546}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt54_c7 ),
    .o({\adec/lt54_c8 ,open_n547}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt54_cin  (
    .a(1'b1),
    .o({\adec/lt54_c0 ,open_n550}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt54_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt54_c8 ),
    .o({open_n551,\adec/n118 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt55_c0 ),
    .o({\adec/lt55_c1 ,open_n552}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt55_c1 ),
    .o({\adec/lt55_c2 ,open_n553}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt55_c2 ),
    .o({\adec/lt55_c3 ,open_n554}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt55_c3 ),
    .o({\adec/lt55_c4 ,open_n555}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_4  (
    .a(badr[8]),
    .b(1'b1),
    .c(\adec/lt55_c4 ),
    .o({\adec/lt55_c5 ,open_n556}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt55_c5 ),
    .o({\adec/lt55_c6 ,open_n557}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt55_c6 ),
    .o({\adec/lt55_c7 ,open_n558}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt55_c7 ),
    .o({\adec/lt55_c8 ,open_n559}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt55_cin  (
    .a(1'b0),
    .o({\adec/lt55_c0 ,open_n562}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt55_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt55_c8 ),
    .o({open_n563,\adec/n120 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt56_c0 ),
    .o({\adec/lt56_c1 ,open_n564}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt56_c1 ),
    .o({\adec/lt56_c2 ,open_n565}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt56_c2 ),
    .o({\adec/lt56_c3 ,open_n566}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt56_c3 ),
    .o({\adec/lt56_c4 ,open_n567}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_4  (
    .a(1'b1),
    .b(badr[8]),
    .c(\adec/lt56_c4 ),
    .o({\adec/lt56_c5 ,open_n568}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt56_c5 ),
    .o({\adec/lt56_c6 ,open_n569}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt56_c6 ),
    .o({\adec/lt56_c7 ,open_n570}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt56_c7 ),
    .o({\adec/lt56_c8 ,open_n571}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt56_cin  (
    .a(1'b1),
    .o({\adec/lt56_c0 ,open_n574}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt56_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt56_c8 ),
    .o({open_n575,\adec/n122 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt57_c0 ),
    .o({\adec/lt57_c1 ,open_n576}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt57_c1 ),
    .o({\adec/lt57_c2 ,open_n577}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt57_c2 ),
    .o({\adec/lt57_c3 ,open_n578}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt57_c3 ),
    .o({\adec/lt57_c4 ,open_n579}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_4  (
    .a(badr[8]),
    .b(1'b1),
    .c(\adec/lt57_c4 ),
    .o({\adec/lt57_c5 ,open_n580}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt57_c5 ),
    .o({\adec/lt57_c6 ,open_n581}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt57_c6 ),
    .o({\adec/lt57_c7 ,open_n582}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt57_c7 ),
    .o({\adec/lt57_c8 ,open_n583}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt57_cin  (
    .a(1'b0),
    .o({\adec/lt57_c0 ,open_n586}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt57_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt57_c8 ),
    .o({open_n587,\adec/n124 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt58_c0 ),
    .o({\adec/lt58_c1 ,open_n588}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt58_c1 ),
    .o({\adec/lt58_c2 ,open_n589}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt58_c2 ),
    .o({\adec/lt58_c3 ,open_n590}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt58_c3 ),
    .o({\adec/lt58_c4 ,open_n591}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_4  (
    .a(1'b1),
    .b(badr[8]),
    .c(\adec/lt58_c4 ),
    .o({\adec/lt58_c5 ,open_n592}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt58_c5 ),
    .o({\adec/lt58_c6 ,open_n593}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt58_c6 ),
    .o({\adec/lt58_c7 ,open_n594}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt58_c7 ),
    .o({\adec/lt58_c8 ,open_n595}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt58_cin  (
    .a(1'b1),
    .o({\adec/lt58_c0 ,open_n598}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt58_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt58_c8 ),
    .o({open_n599,\adec/n126 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt59_c0 ),
    .o({\adec/lt59_c1 ,open_n600}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt59_c1 ),
    .o({\adec/lt59_c2 ,open_n601}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_2  (
    .a(badr[6]),
    .b(1'b0),
    .c(\adec/lt59_c2 ),
    .o({\adec/lt59_c3 ,open_n602}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt59_c3 ),
    .o({\adec/lt59_c4 ,open_n603}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_4  (
    .a(badr[8]),
    .b(1'b1),
    .c(\adec/lt59_c4 ),
    .o({\adec/lt59_c5 ,open_n604}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt59_c5 ),
    .o({\adec/lt59_c6 ,open_n605}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt59_c6 ),
    .o({\adec/lt59_c7 ,open_n606}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt59_c7 ),
    .o({\adec/lt59_c8 ,open_n607}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt59_cin  (
    .a(1'b0),
    .o({\adec/lt59_c0 ,open_n610}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt59_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt59_c8 ),
    .o({open_n611,\adec/n128 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_0  (
    .a(1'b0),
    .b(badr[0]),
    .c(\adec/lt5_c0 ),
    .o({\adec/lt5_c1 ,open_n612}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_1  (
    .a(1'b0),
    .b(badr[1]),
    .c(\adec/lt5_c1 ),
    .o({\adec/lt5_c2 ,open_n613}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_10  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt5_c10 ),
    .o({\adec/lt5_c11 ,open_n614}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_11  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt5_c11 ),
    .o({\adec/lt5_c12 ,open_n615}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_12  (
    .a(1'b1),
    .b(badr[12]),
    .c(\adec/lt5_c12 ),
    .o({\adec/lt5_c13 ,open_n616}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_13  (
    .a(1'b1),
    .b(badr[13]),
    .c(\adec/lt5_c13 ),
    .o({\adec/lt5_c14 ,open_n617}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_14  (
    .a(1'b1),
    .b(badr[14]),
    .c(\adec/lt5_c14 ),
    .o({\adec/lt5_c15 ,open_n618}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_15  (
    .a(1'b1),
    .b(badr[15]),
    .c(\adec/lt5_c15 ),
    .o({\adec/lt5_c16 ,open_n619}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_2  (
    .a(1'b0),
    .b(badr[2]),
    .c(\adec/lt5_c2 ),
    .o({\adec/lt5_c3 ,open_n620}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_3  (
    .a(1'b0),
    .b(badr[3]),
    .c(\adec/lt5_c3 ),
    .o({\adec/lt5_c4 ,open_n621}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_4  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt5_c4 ),
    .o({\adec/lt5_c5 ,open_n622}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_5  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt5_c5 ),
    .o({\adec/lt5_c6 ,open_n623}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_6  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt5_c6 ),
    .o({\adec/lt5_c7 ,open_n624}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_7  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt5_c7 ),
    .o({\adec/lt5_c8 ,open_n625}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_8  (
    .a(1'b0),
    .b(badr[8]),
    .c(\adec/lt5_c8 ),
    .o({\adec/lt5_c9 ,open_n626}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_9  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt5_c9 ),
    .o({\adec/lt5_c10 ,open_n627}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt5_cin  (
    .a(1'b1),
    .o({\adec/lt5_c0 ,open_n630}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt5_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt5_c16 ),
    .o({open_n631,\adec/n11 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt60_c0 ),
    .o({\adec/lt60_c1 ,open_n632}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_1  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt60_c1 ),
    .o({\adec/lt60_c2 ,open_n633}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_2  (
    .a(1'b0),
    .b(badr[6]),
    .c(\adec/lt60_c2 ),
    .o({\adec/lt60_c3 ,open_n634}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt60_c3 ),
    .o({\adec/lt60_c4 ,open_n635}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_4  (
    .a(1'b1),
    .b(badr[8]),
    .c(\adec/lt60_c4 ),
    .o({\adec/lt60_c5 ,open_n636}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt60_c5 ),
    .o({\adec/lt60_c6 ,open_n637}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt60_c6 ),
    .o({\adec/lt60_c7 ,open_n638}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt60_c7 ),
    .o({\adec/lt60_c8 ,open_n639}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt60_cin  (
    .a(1'b1),
    .o({\adec/lt60_c0 ,open_n642}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt60_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt60_c8 ),
    .o({open_n643,\adec/n130 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt61_c0 ),
    .o({\adec/lt61_c1 ,open_n644}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt61_c1 ),
    .o({\adec/lt61_c2 ,open_n645}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt61_c2 ),
    .o({\adec/lt61_c3 ,open_n646}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt61_c3 ),
    .o({\adec/lt61_c4 ,open_n647}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_4  (
    .a(badr[8]),
    .b(1'b1),
    .c(\adec/lt61_c4 ),
    .o({\adec/lt61_c5 ,open_n648}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt61_c5 ),
    .o({\adec/lt61_c6 ,open_n649}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt61_c6 ),
    .o({\adec/lt61_c7 ,open_n650}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt61_c7 ),
    .o({\adec/lt61_c8 ,open_n651}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt61_cin  (
    .a(1'b0),
    .o({\adec/lt61_c0 ,open_n654}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt61_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt61_c8 ),
    .o({open_n655,\adec/n132 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_0  (
    .a(1'b0),
    .b(badr[4]),
    .c(\adec/lt62_c0 ),
    .o({\adec/lt62_c1 ,open_n656}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt62_c1 ),
    .o({\adec/lt62_c2 ,open_n657}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt62_c2 ),
    .o({\adec/lt62_c3 ,open_n658}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt62_c3 ),
    .o({\adec/lt62_c4 ,open_n659}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_4  (
    .a(1'b1),
    .b(badr[8]),
    .c(\adec/lt62_c4 ),
    .o({\adec/lt62_c5 ,open_n660}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt62_c5 ),
    .o({\adec/lt62_c6 ,open_n661}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt62_c6 ),
    .o({\adec/lt62_c7 ,open_n662}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt62_c7 ),
    .o({\adec/lt62_c8 ,open_n663}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt62_cin  (
    .a(1'b1),
    .o({\adec/lt62_c0 ,open_n666}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt62_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt62_c8 ),
    .o({open_n667,\adec/n134 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_0  (
    .a(badr[4]),
    .b(1'b1),
    .c(\adec/lt63_c0 ),
    .o({\adec/lt63_c1 ,open_n668}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_1  (
    .a(badr[5]),
    .b(1'b0),
    .c(\adec/lt63_c1 ),
    .o({\adec/lt63_c2 ,open_n669}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt63_c2 ),
    .o({\adec/lt63_c3 ,open_n670}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt63_c3 ),
    .o({\adec/lt63_c4 ,open_n671}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_4  (
    .a(badr[8]),
    .b(1'b1),
    .c(\adec/lt63_c4 ),
    .o({\adec/lt63_c5 ,open_n672}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt63_c5 ),
    .o({\adec/lt63_c6 ,open_n673}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt63_c6 ),
    .o({\adec/lt63_c7 ,open_n674}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt63_c7 ),
    .o({\adec/lt63_c8 ,open_n675}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt63_cin  (
    .a(1'b0),
    .o({\adec/lt63_c0 ,open_n678}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt63_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt63_c8 ),
    .o({open_n679,\adec/n136 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_0  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt64_c0 ),
    .o({\adec/lt64_c1 ,open_n680}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_1  (
    .a(1'b0),
    .b(badr[5]),
    .c(\adec/lt64_c1 ),
    .o({\adec/lt64_c2 ,open_n681}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_2  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt64_c2 ),
    .o({\adec/lt64_c3 ,open_n682}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_3  (
    .a(1'b0),
    .b(badr[7]),
    .c(\adec/lt64_c3 ),
    .o({\adec/lt64_c4 ,open_n683}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_4  (
    .a(1'b1),
    .b(badr[8]),
    .c(\adec/lt64_c4 ),
    .o({\adec/lt64_c5 ,open_n684}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_5  (
    .a(1'b0),
    .b(badr[9]),
    .c(\adec/lt64_c5 ),
    .o({\adec/lt64_c6 ,open_n685}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_6  (
    .a(1'b0),
    .b(badr[10]),
    .c(\adec/lt64_c6 ),
    .o({\adec/lt64_c7 ,open_n686}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_7  (
    .a(1'b0),
    .b(badr[11]),
    .c(\adec/lt64_c7 ),
    .o({\adec/lt64_c8 ,open_n687}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt64_cin  (
    .a(1'b1),
    .o({\adec/lt64_c0 ,open_n690}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt64_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt64_c8 ),
    .o({open_n691,\adec/n138 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_0  (
    .a(badr[4]),
    .b(1'b0),
    .c(\adec/lt65_c0 ),
    .o({\adec/lt65_c1 ,open_n692}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_1  (
    .a(badr[5]),
    .b(1'b1),
    .c(\adec/lt65_c1 ),
    .o({\adec/lt65_c2 ,open_n693}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_2  (
    .a(badr[6]),
    .b(1'b1),
    .c(\adec/lt65_c2 ),
    .o({\adec/lt65_c3 ,open_n694}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_3  (
    .a(badr[7]),
    .b(1'b0),
    .c(\adec/lt65_c3 ),
    .o({\adec/lt65_c4 ,open_n695}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_4  (
    .a(badr[8]),
    .b(1'b1),
    .c(\adec/lt65_c4 ),
    .o({\adec/lt65_c5 ,open_n696}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_5  (
    .a(badr[9]),
    .b(1'b0),
    .c(\adec/lt65_c5 ),
    .o({\adec/lt65_c6 ,open_n697}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_6  (
    .a(badr[10]),
    .b(1'b0),
    .c(\adec/lt65_c6 ),
    .o({\adec/lt65_c7 ,open_n698}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_7  (
    .a(badr[11]),
    .b(1'b0),
    .c(\adec/lt65_c7 ),
    .o({\adec/lt65_c8 ,open_n699}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt65_cin  (
    .a(1'b0),
    .o({\adec/lt65_c0 ,open_n702}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt65_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt65_c8 ),
    .o({open_n703,\adec/n140 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_0  (
    .a(1'b0),
    .b(badr[0]),
    .c(\adec/lt6_c0 ),
    .o({\adec/lt6_c1 ,open_n704}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_1  (
    .a(1'b0),
    .b(badr[1]),
    .c(\adec/lt6_c1 ),
    .o({\adec/lt6_c2 ,open_n705}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_10  (
    .a(1'b1),
    .b(badr[10]),
    .c(\adec/lt6_c10 ),
    .o({\adec/lt6_c11 ,open_n706}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_11  (
    .a(1'b1),
    .b(badr[11]),
    .c(\adec/lt6_c11 ),
    .o({\adec/lt6_c12 ,open_n707}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_12  (
    .a(1'b1),
    .b(badr[12]),
    .c(\adec/lt6_c12 ),
    .o({\adec/lt6_c13 ,open_n708}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_13  (
    .a(1'b1),
    .b(badr[13]),
    .c(\adec/lt6_c13 ),
    .o({\adec/lt6_c14 ,open_n709}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_14  (
    .a(1'b1),
    .b(badr[14]),
    .c(\adec/lt6_c14 ),
    .o({\adec/lt6_c15 ,open_n710}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_15  (
    .a(1'b1),
    .b(badr[15]),
    .c(\adec/lt6_c15 ),
    .o({\adec/lt6_c16 ,open_n711}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_2  (
    .a(1'b0),
    .b(badr[2]),
    .c(\adec/lt6_c2 ),
    .o({\adec/lt6_c3 ,open_n712}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_3  (
    .a(1'b0),
    .b(badr[3]),
    .c(\adec/lt6_c3 ),
    .o({\adec/lt6_c4 ,open_n713}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_4  (
    .a(1'b1),
    .b(badr[4]),
    .c(\adec/lt6_c4 ),
    .o({\adec/lt6_c5 ,open_n714}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_5  (
    .a(1'b1),
    .b(badr[5]),
    .c(\adec/lt6_c5 ),
    .o({\adec/lt6_c6 ,open_n715}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_6  (
    .a(1'b1),
    .b(badr[6]),
    .c(\adec/lt6_c6 ),
    .o({\adec/lt6_c7 ,open_n716}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_7  (
    .a(1'b1),
    .b(badr[7]),
    .c(\adec/lt6_c7 ),
    .o({\adec/lt6_c8 ,open_n717}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_8  (
    .a(1'b1),
    .b(badr[8]),
    .c(\adec/lt6_c8 ),
    .o({\adec/lt6_c9 ,open_n718}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_9  (
    .a(1'b1),
    .b(badr[9]),
    .c(\adec/lt6_c9 ),
    .o({\adec/lt6_c10 ,open_n719}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt6_cin  (
    .a(1'b1),
    .o({\adec/lt6_c0 ,open_n722}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt6_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt6_c16 ),
    .o({open_n723,\adec/n13 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_0  (
    .a(badr1[0]),
    .b(1'b0),
    .c(\adec/lt7_c0 ),
    .o({\adec/lt7_c1 ,open_n724}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_1  (
    .a(badr1[1]),
    .b(1'b0),
    .c(\adec/lt7_c1 ),
    .o({\adec/lt7_c2 ,open_n725}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_10  (
    .a(badr1[10]),
    .b(1'b0),
    .c(\adec/lt7_c10 ),
    .o({\adec/lt7_c11 ,open_n726}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_11  (
    .a(badr1[11]),
    .b(1'b0),
    .c(\adec/lt7_c11 ),
    .o({\adec/lt7_c12 ,open_n727}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_12  (
    .a(badr1[12]),
    .b(1'b0),
    .c(\adec/lt7_c12 ),
    .o({\adec/lt7_c13 ,open_n728}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_13  (
    .a(badr1[13]),
    .b(1'b0),
    .c(\adec/lt7_c13 ),
    .o({\adec/lt7_c14 ,open_n729}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_14  (
    .a(badr1[14]),
    .b(1'b1),
    .c(\adec/lt7_c14 ),
    .o({\adec/lt7_c15 ,open_n730}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_15  (
    .a(badr1[15]),
    .b(1'b0),
    .c(\adec/lt7_c15 ),
    .o({\adec/lt7_c16 ,open_n731}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_2  (
    .a(badr1[2]),
    .b(1'b0),
    .c(\adec/lt7_c2 ),
    .o({\adec/lt7_c3 ,open_n732}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_3  (
    .a(badr1[3]),
    .b(1'b0),
    .c(\adec/lt7_c3 ),
    .o({\adec/lt7_c4 ,open_n733}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_4  (
    .a(badr1[4]),
    .b(1'b0),
    .c(\adec/lt7_c4 ),
    .o({\adec/lt7_c5 ,open_n734}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_5  (
    .a(badr1[5]),
    .b(1'b0),
    .c(\adec/lt7_c5 ),
    .o({\adec/lt7_c6 ,open_n735}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_6  (
    .a(badr1[6]),
    .b(1'b0),
    .c(\adec/lt7_c6 ),
    .o({\adec/lt7_c7 ,open_n736}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_7  (
    .a(badr1[7]),
    .b(1'b0),
    .c(\adec/lt7_c7 ),
    .o({\adec/lt7_c8 ,open_n737}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_8  (
    .a(badr1[8]),
    .b(1'b0),
    .c(\adec/lt7_c8 ),
    .o({\adec/lt7_c9 ,open_n738}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_9  (
    .a(badr1[9]),
    .b(1'b0),
    .c(\adec/lt7_c9 ),
    .o({\adec/lt7_c10 ,open_n739}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt7_cin  (
    .a(1'b0),
    .o({\adec/lt7_c0 ,open_n742}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt7_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt7_c16 ),
    .o({open_n743,\adec/n15 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_0  (
    .a(1'b0),
    .b(badr1[0]),
    .c(\adec/lt8_c0 ),
    .o({\adec/lt8_c1 ,open_n744}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_1  (
    .a(1'b0),
    .b(badr1[1]),
    .c(\adec/lt8_c1 ),
    .o({\adec/lt8_c2 ,open_n745}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_10  (
    .a(1'b0),
    .b(badr1[10]),
    .c(\adec/lt8_c10 ),
    .o({\adec/lt8_c11 ,open_n746}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_11  (
    .a(1'b0),
    .b(badr1[11]),
    .c(\adec/lt8_c11 ),
    .o({\adec/lt8_c12 ,open_n747}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_12  (
    .a(1'b1),
    .b(badr1[12]),
    .c(\adec/lt8_c12 ),
    .o({\adec/lt8_c13 ,open_n748}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_13  (
    .a(1'b0),
    .b(badr1[13]),
    .c(\adec/lt8_c13 ),
    .o({\adec/lt8_c14 ,open_n749}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_14  (
    .a(1'b1),
    .b(badr1[14]),
    .c(\adec/lt8_c14 ),
    .o({\adec/lt8_c15 ,open_n750}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_15  (
    .a(1'b0),
    .b(badr1[15]),
    .c(\adec/lt8_c15 ),
    .o({\adec/lt8_c16 ,open_n751}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_2  (
    .a(1'b0),
    .b(badr1[2]),
    .c(\adec/lt8_c2 ),
    .o({\adec/lt8_c3 ,open_n752}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_3  (
    .a(1'b0),
    .b(badr1[3]),
    .c(\adec/lt8_c3 ),
    .o({\adec/lt8_c4 ,open_n753}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_4  (
    .a(1'b0),
    .b(badr1[4]),
    .c(\adec/lt8_c4 ),
    .o({\adec/lt8_c5 ,open_n754}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_5  (
    .a(1'b0),
    .b(badr1[5]),
    .c(\adec/lt8_c5 ),
    .o({\adec/lt8_c6 ,open_n755}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_6  (
    .a(1'b0),
    .b(badr1[6]),
    .c(\adec/lt8_c6 ),
    .o({\adec/lt8_c7 ,open_n756}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_7  (
    .a(1'b0),
    .b(badr1[7]),
    .c(\adec/lt8_c7 ),
    .o({\adec/lt8_c8 ,open_n757}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_8  (
    .a(1'b0),
    .b(badr1[8]),
    .c(\adec/lt8_c8 ),
    .o({\adec/lt8_c9 ,open_n758}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_9  (
    .a(1'b0),
    .b(badr1[9]),
    .c(\adec/lt8_c9 ),
    .o({\adec/lt8_c10 ,open_n759}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt8_cin  (
    .a(1'b1),
    .o({\adec/lt8_c0 ,open_n762}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt8_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt8_c16 ),
    .o({open_n763,\adec/n16 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_0  (
    .a(badr1[0]),
    .b(1'b0),
    .c(\adec/lt9_c0 ),
    .o({\adec/lt9_c1 ,open_n764}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_1  (
    .a(badr1[1]),
    .b(1'b0),
    .c(\adec/lt9_c1 ),
    .o({\adec/lt9_c2 ,open_n765}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_10  (
    .a(badr1[10]),
    .b(1'b0),
    .c(\adec/lt9_c10 ),
    .o({\adec/lt9_c11 ,open_n766}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_11  (
    .a(badr1[11]),
    .b(1'b0),
    .c(\adec/lt9_c11 ),
    .o({\adec/lt9_c12 ,open_n767}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_12  (
    .a(badr1[12]),
    .b(1'b1),
    .c(\adec/lt9_c12 ),
    .o({\adec/lt9_c13 ,open_n768}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_13  (
    .a(badr1[13]),
    .b(1'b1),
    .c(\adec/lt9_c13 ),
    .o({\adec/lt9_c14 ,open_n769}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_14  (
    .a(badr1[14]),
    .b(1'b1),
    .c(\adec/lt9_c14 ),
    .o({\adec/lt9_c15 ,open_n770}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_15  (
    .a(badr1[15]),
    .b(1'b1),
    .c(\adec/lt9_c15 ),
    .o({\adec/lt9_c16 ,open_n771}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_2  (
    .a(badr1[2]),
    .b(1'b0),
    .c(\adec/lt9_c2 ),
    .o({\adec/lt9_c3 ,open_n772}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_3  (
    .a(badr1[3]),
    .b(1'b0),
    .c(\adec/lt9_c3 ),
    .o({\adec/lt9_c4 ,open_n773}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_4  (
    .a(badr1[4]),
    .b(1'b0),
    .c(\adec/lt9_c4 ),
    .o({\adec/lt9_c5 ,open_n774}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_5  (
    .a(badr1[5]),
    .b(1'b0),
    .c(\adec/lt9_c5 ),
    .o({\adec/lt9_c6 ,open_n775}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_6  (
    .a(badr1[6]),
    .b(1'b0),
    .c(\adec/lt9_c6 ),
    .o({\adec/lt9_c7 ,open_n776}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_7  (
    .a(badr1[7]),
    .b(1'b0),
    .c(\adec/lt9_c7 ),
    .o({\adec/lt9_c8 ,open_n777}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_8  (
    .a(badr1[8]),
    .b(1'b0),
    .c(\adec/lt9_c8 ),
    .o({\adec/lt9_c9 ,open_n778}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_9  (
    .a(badr1[9]),
    .b(1'b0),
    .c(\adec/lt9_c9 ),
    .o({\adec/lt9_c10 ,open_n779}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \adec/lt9_cin  (
    .a(1'b0),
    .o({\adec/lt9_c0 ,open_n782}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \adec/lt9_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\adec/lt9_c16 ),
    .o({open_n783,\adec/n17 }));
  reg_ar_ss_w1 \bctl/bctl_brdy_reg  (
    .clk(clk),
    .d(\bctl/brdy_t ),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\bctl/bctl_brdy ));  // rtl/busc_fsm.v(98)
  reg_sr_as_w1 \bctl/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\bctl/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\bctl/stat [0]));  // rtl/busc_fsm.v(106)
  reg_sr_as_w1 \bctl/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\bctl/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\bctl/stat [1]));  // rtl/busc_fsm.v(106)
  reg_sr_as_w1 \bctl/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\bctl/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\bctl/stat [2]));  // rtl/busc_fsm.v(106)

endmodule 

