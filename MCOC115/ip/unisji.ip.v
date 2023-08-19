
`timescale 1ns / 1ps
module unisji  // rtl/unisji.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_unsj_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  ulut_dat0,
  ulut_dat1,
  bdatr,
  ulut_adr0,
  ulut_adr1
  );
//
//	Code Conversion (unicode <-> S-JIS) Unit
//		(c) 2022	1YEN Toru
//
//
//	2022/08/06	ver.1.00
//

  input [3:0] badr;  // rtl/unisji.v(24)
  input bcmdr;  // rtl/unisji.v(22)
  input bcmdw;  // rtl/unisji.v(21)
  input bcs_unsj_n;  // rtl/unisji.v(23)
  input [15:0] bdatw;  // rtl/unisji.v(25)
  input brdy;  // rtl/unisji.v(20)
  input clk;  // rtl/unisji.v(18)
  input rst_n;  // rtl/unisji.v(19)
  input [95:0] ulut_dat0;  // rtl/unisji.v(28)
  input [95:0] ulut_dat1;  // rtl/unisji.v(29)
  output [15:0] bdatr;  // rtl/unisji.v(26)
  output [10:0] ulut_adr0;  // rtl/unisji.v(30)
  output [10:0] ulut_adr1;  // rtl/unisji.v(31)

  wire [3:0] n0;
  wire [5:0] n1;
  wire  n2;
  wire [5:0] ucmp_match1;  // rtl/unisji.v(44)
  wire  \uctl/mux0_b1/B5_1 ;
  wire  \uctl/mux0_b2/B5_1 ;
  wire  \uctl/mux1_b0/B5_1 ;
  wire  \uctl/mux1_b1/B5_1 ;
  wire  \uctl/mux1_b3/B5_1 ;
  wire [9:0] \uctl/n0 ;
  wire [15:0] \uctl/n57 ;
  wire [10:0] \uctl/uctl_adr ;  // rtl/unisji.v(391)
  wire [10:0] \uctl/uctl_adr0 ;  // rtl/unisji.v(376)
  wire [10:0] \uctl/uctl_adr1 ;  // rtl/unisji.v(377)
  wire [7:0] \uctl/uctl_kutn_l_1 ;  // rtl/unisji.v(394)
  wire [2:0] \uctl/ufsm/stat ;  // rtl/unsj_fsm.v(65)
  wire [15:0] uctl_kutn;  // rtl/unisji.v(46)
  wire [15:0] uctl_unic;  // rtl/unisji.v(45)
  wire [15:0] \uktn/codk_2 ;  // rtl/unisji.v(628)
  wire [15:0] \uktn/codt_2 ;  // rtl/unisji.v(623)
  wire [15:0] \uktn/codt_3 ;  // rtl/unisji.v(625)
  wire [15:0] \uktn/codt_4 ;  // rtl/unisji.v(627)
  wire [15:0] \uktn/n10 ;
  wire [1:0] \uktn/n3 ;
  wire [15:0] \uktn/n9 ;
  wire [15:0] unsjkutn;  // rtl/unisji.v(50)
  wire [15:0] unsjsjis;  // rtl/unisji.v(49)
  wire [15:0] unsjunic;  // rtl/unisji.v(48)
  wire [15:0] \usjs/cods_4 ;  // rtl/unisji.v(548)
  wire [15:0] \usjs/n10 ;
  wire [9:0] \usjs/n25 ;
  wire [7:0] \usjs/n4 ;
  wire [15:0] \uuni/n3 ;
  wire [15:0] \uuni/n4 ;
  wire _al_u100_o;
  wire _al_u101_o;
  wire _al_u102_o;
  wire _al_u103_o;
  wire _al_u104_o;
  wire _al_u105_o;
  wire _al_u107_o;
  wire _al_u108_o;
  wire _al_u109_o;
  wire _al_u110_o;
  wire _al_u111_o;
  wire _al_u112_o;
  wire _al_u113_o;
  wire _al_u114_o;
  wire _al_u115_o;
  wire _al_u116_o;
  wire _al_u117_o;
  wire _al_u118_o;
  wire _al_u119_o;
  wire _al_u120_o;
  wire _al_u121_o;
  wire _al_u122_o;
  wire _al_u123_o;
  wire _al_u125_o;
  wire _al_u126_o;
  wire _al_u128_o;
  wire _al_u130_o;
  wire _al_u131_o;
  wire _al_u132_o;
  wire _al_u133_o;
  wire _al_u134_o;
  wire _al_u135_o;
  wire _al_u136_o;
  wire _al_u139_o;
  wire _al_u140_o;
  wire _al_u142_o;
  wire _al_u147_o;
  wire _al_u148_o;
  wire _al_u150_o;
  wire _al_u151_o;
  wire _al_u152_o;
  wire _al_u153_o;
  wire _al_u154_o;
  wire _al_u155_o;
  wire _al_u156_o;
  wire _al_u157_o;
  wire _al_u158_o;
  wire _al_u159_o;
  wire _al_u160_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u163_o;
  wire _al_u164_o;
  wire _al_u165_o;
  wire _al_u166_o;
  wire _al_u167_o;
  wire _al_u168_o;
  wire _al_u170_o;
  wire _al_u171_o;
  wire _al_u172_o;
  wire _al_u173_o;
  wire _al_u174_o;
  wire _al_u175_o;
  wire _al_u176_o;
  wire _al_u181_o;
  wire _al_u182_o;
  wire _al_u183_o;
  wire _al_u184_o;
  wire _al_u185_o;
  wire _al_u186_o;
  wire _al_u187_o;
  wire _al_u188_o;
  wire _al_u190_o;
  wire _al_u191_o;
  wire _al_u192_o;
  wire _al_u193_o;
  wire _al_u194_o;
  wire _al_u195_o;
  wire _al_u196_o;
  wire _al_u197_o;
  wire _al_u198_o;
  wire _al_u199_o;
  wire _al_u200_o;
  wire _al_u201_o;
  wire _al_u202_o;
  wire _al_u203_o;
  wire _al_u204_o;
  wire _al_u205_o;
  wire _al_u206_o;
  wire _al_u209_o;
  wire _al_u213_o;
  wire _al_u214_o;
  wire _al_u215_o;
  wire _al_u216_o;
  wire _al_u217_o;
  wire _al_u219_o;
  wire _al_u220_o;
  wire _al_u221_o;
  wire _al_u222_o;
  wire _al_u223_o;
  wire _al_u224_o;
  wire _al_u225_o;
  wire _al_u226_o;
  wire _al_u227_o;
  wire _al_u228_o;
  wire _al_u230_o;
  wire _al_u231_o;
  wire _al_u233_o;
  wire _al_u234_o;
  wire _al_u235_o;
  wire _al_u236_o;
  wire _al_u237_o;
  wire _al_u238_o;
  wire _al_u239_o;
  wire _al_u240_o;
  wire _al_u241_o;
  wire _al_u242_o;
  wire _al_u246_o;
  wire _al_u247_o;
  wire _al_u248_o;
  wire _al_u249_o;
  wire _al_u250_o;
  wire _al_u251_o;
  wire _al_u252_o;
  wire _al_u253_o;
  wire _al_u255_o;
  wire _al_u256_o;
  wire _al_u257_o;
  wire _al_u258_o;
  wire _al_u259_o;
  wire _al_u260_o;
  wire _al_u261_o;
  wire _al_u264_o;
  wire _al_u266_o;
  wire _al_u268_o;
  wire _al_u277_o;
  wire _al_u279_o;
  wire _al_u281_o;
  wire _al_u283_o;
  wire _al_u285_o;
  wire _al_u288_o;
  wire _al_u289_o;
  wire _al_u290_o;
  wire _al_u292_o;
  wire _al_u295_o;
  wire _al_u296_o;
  wire _al_u298_o;
  wire _al_u299_o;
  wire _al_u300_o;
  wire _al_u301_o;
  wire _al_u305_o;
  wire _al_u307_o;
  wire _al_u310_o;
  wire _al_u311_o;
  wire _al_u313_o;
  wire _al_u314_o;
  wire _al_u318_o;
  wire _al_u320_o;
  wire _al_u321_o;
  wire _al_u323_o;
  wire _al_u325_o;
  wire _al_u326_o;
  wire _al_u328_o;
  wire _al_u331_o;
  wire _al_u332_o;
  wire _al_u334_o;
  wire _al_u337_o;
  wire _al_u338_o;
  wire _al_u340_o;
  wire _al_u342_o;
  wire _al_u343_o;
  wire _al_u345_o;
  wire _al_u347_o;
  wire _al_u348_o;
  wire _al_u350_o;
  wire _al_u352_o;
  wire _al_u353_o;
  wire _al_u355_o;
  wire _al_u357_o;
  wire _al_u358_o;
  wire _al_u359_o;
  wire _al_u360_o;
  wire _al_u363_o;
  wire _al_u364_o;
  wire _al_u366_o;
  wire _al_u368_o;
  wire _al_u369_o;
  wire _al_u36_o;
  wire _al_u370_o;
  wire _al_u371_o;
  wire _al_u373_o;
  wire _al_u374_o;
  wire _al_u376_o;
  wire _al_u378_o;
  wire _al_u379_o;
  wire _al_u381_o;
  wire _al_u383_o;
  wire _al_u384_o;
  wire _al_u386_o;
  wire _al_u388_o;
  wire _al_u389_o;
  wire _al_u38_o;
  wire _al_u390_o;
  wire _al_u391_o;
  wire _al_u393_o;
  wire _al_u394_o;
  wire _al_u396_o;
  wire _al_u398_o;
  wire _al_u400_o;
  wire _al_u401_o;
  wire _al_u403_o;
  wire _al_u406_o;
  wire _al_u408_o;
  wire _al_u40_o;
  wire _al_u410_o;
  wire _al_u412_o;
  wire _al_u414_o;
  wire _al_u416_o;
  wire _al_u418_o;
  wire _al_u420_o;
  wire _al_u422_o;
  wire _al_u424_o;
  wire _al_u426_o;
  wire _al_u428_o;
  wire _al_u42_o;
  wire _al_u431_o;
  wire _al_u432_o;
  wire _al_u433_o;
  wire _al_u435_o;
  wire _al_u437_o;
  wire _al_u439_o;
  wire _al_u441_o;
  wire _al_u442_o;
  wire _al_u443_o;
  wire _al_u445_o;
  wire _al_u447_o;
  wire _al_u449_o;
  wire _al_u44_o;
  wire _al_u451_o;
  wire _al_u453_o;
  wire _al_u455_o;
  wire _al_u457_o;
  wire _al_u459_o;
  wire _al_u461_o;
  wire _al_u463_o;
  wire _al_u465_o;
  wire _al_u46_o;
  wire _al_u48_o;
  wire _al_u50_o;
  wire _al_u52_o;
  wire _al_u54_o;
  wire _al_u56_o;
  wire _al_u58_o;
  wire _al_u60_o;
  wire _al_u73_o;
  wire _al_u75_o;
  wire _al_u76_o;
  wire _al_u77_o;
  wire _al_u80_o;
  wire _al_u82_o;
  wire _al_u84_o;
  wire _al_u86_o;
  wire _al_u89_o;
  wire _al_u91_o;
  wire _al_u94_o;
  wire _al_u95_o;
  wire _al_u98_o;
  wire _al_u99_o;
  wire \u1/c0 ;
  wire \u1/c1 ;
  wire \u1/c2 ;
  wire \u1/c3 ;
  wire \u2/c0 ;
  wire \u2/c1 ;
  wire \u2/c2 ;
  wire \u2/c3 ;
  wire \u2/c4 ;
  wire \u2/c5 ;
  wire \ucmp0/eq0/xor_i0[0]_i1[0]_o_lutinv ;
  wire \ucmp0/eq0/xor_i0[13]_i1[13]_o_lutinv ;
  wire \ucmp0/eq0/xor_i0[3]_i1[3]_o_lutinv ;
  wire \ucmp0/eq0/xor_i0[4]_i1[4]_o_lutinv ;
  wire \ucmp0/eq1/xor_i0[12]_i1[12]_o_lutinv ;
  wire \ucmp0/eq2/xor_i0[2]_i1[2]_o_lutinv ;
  wire \ucmp0/eq3/xor_i0[10]_i1[10]_o_lutinv ;
  wire \ucmp0/eq3/xor_i0[12]_i1[12]_o_lutinv ;
  wire \ucmp0/eq3/xor_i0[14]_i1[14]_o_lutinv ;
  wire \ucmp0/eq3/xor_i0[15]_i1[15]_o_lutinv ;
  wire \ucmp0/eq3/xor_i0[8]_i1[8]_o_lutinv ;
  wire \ucmp0/eq3/xor_i0[9]_i1[9]_o_lutinv ;
  wire \ucmp0/eq4/xor_i0[7]_i1[7]_o_lutinv ;
  wire \ucmp1/eq0/xor_i0[1]_i1[1]_o_lutinv ;
  wire \ucmp1/eq1/xor_i0[15]_i1[15]_o_lutinv ;
  wire \ucmp1/eq1/xor_i0[2]_i1[2]_o_lutinv ;
  wire \ucmp1/eq1/xor_i0[6]_i1[6]_o_lutinv ;
  wire \ucmp1/eq3/xor_i0[10]_i1[10]_o_lutinv ;
  wire \ucmp1/eq3/xor_i0[11]_i1[11]_o_lutinv ;
  wire \ucmp1/eq3/xor_i0[14]_i1[14]_o_lutinv ;
  wire \ucmp1/eq3/xor_i0[4]_i1[4]_o_lutinv ;
  wire \ucmp1/eq3/xor_i0[9]_i1[9]_o_lutinv ;
  wire \uctl/add0/c0 ;
  wire \uctl/add0/c1 ;
  wire \uctl/add0/c2 ;
  wire \uctl/add0/c3 ;
  wire \uctl/add0/c4 ;
  wire \uctl/add0/c5 ;
  wire \uctl/add0/c6 ;
  wire \uctl/add0/c7 ;
  wire \uctl/add0/c8 ;
  wire \uctl/add0/c9 ;
  wire \uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ;
  wire \uctl/mux3_b0_sel_is_3_o ;
  wire \uctl/n15 ;
  wire \uctl/n24 ;
  wire \uctl/n26 ;
  wire \uctl/n28 ;
  wire \uctl/n31 ;
  wire \uctl/n35 ;
  wire \uctl/n5_lutinv ;
  wire \uctl/uctl_busy ;  // rtl/unisji.v(228)
  wire \uctl/uctl_rom_rd_lutinv ;  // rtl/unisji.v(230)
  wire \uctl/ufsm/mux0_b0_sel_is_3_o ;
  wire \uctl/ufsm/mux0_b1_sel_is_3_o ;
  wire \uctl/ufsm/mux0_b2_sel_is_3_o ;
  wire \uctl/ufsm/uctl_busy_t ;  // rtl/unsj_fsm.v(54)
  wire \uctl/unsjctl_rd ;  // rtl/unisji.v(409)
  wire \uctl/unsjkutn_rd ;  // rtl/unisji.v(412)
  wire \uctl/unsjsjis_rd ;  // rtl/unisji.v(411)
  wire \uctl/unsjunic_rd ;  // rtl/unisji.v(410)
  wire uctl_cvt_kutn_lutinv;  // rtl/unisji.v(79)
  wire uctl_err_ktn_lutinv;  // rtl/unisji.v(74)
  wire uctl_err_uni_lutinv;  // rtl/unisji.v(72)
  wire uctl_lat_unic_lutinv;  // rtl/unisji.v(76)
  wire \uktn/lt0_c0 ;
  wire \uktn/lt0_c1 ;
  wire \uktn/lt0_c10 ;
  wire \uktn/lt0_c11 ;
  wire \uktn/lt0_c12 ;
  wire \uktn/lt0_c13 ;
  wire \uktn/lt0_c14 ;
  wire \uktn/lt0_c15 ;
  wire \uktn/lt0_c16 ;
  wire \uktn/lt0_c2 ;
  wire \uktn/lt0_c3 ;
  wire \uktn/lt0_c4 ;
  wire \uktn/lt0_c5 ;
  wire \uktn/lt0_c6 ;
  wire \uktn/lt0_c7 ;
  wire \uktn/lt0_c8 ;
  wire \uktn/lt0_c9 ;
  wire \uktn/lt1_c0 ;
  wire \uktn/lt1_c1 ;
  wire \uktn/lt1_c2 ;
  wire \uktn/lt1_c3 ;
  wire \uktn/lt1_c4 ;
  wire \uktn/lt1_c5 ;
  wire \uktn/lt1_c6 ;
  wire \uktn/lt1_c7 ;
  wire \uktn/lt1_c8 ;
  wire \uktn/lt2_2_c0 ;
  wire \uktn/lt2_2_c1 ;
  wire \uktn/lt2_2_c2 ;
  wire \uktn/lt2_2_c3 ;
  wire \uktn/lt2_2_c4 ;
  wire \uktn/lt2_2_c5 ;
  wire \uktn/lt2_2_c6 ;
  wire \uktn/lt2_2_c7 ;
  wire \uktn/lt2_2_c8 ;
  wire \uktn/lt2_2_c9 ;
  wire \uktn/mux4_b15_sel_is_1_o ;
  wire \uktn/n0 ;
  wire \uktn/n1 ;
  wire \uktn/n2 ;
  wire \uktn/sub1/c0 ;
  wire \uktn/sub1/c1 ;
  wire \uktn/sub1/c10 ;
  wire \uktn/sub1/c11 ;
  wire \uktn/sub1/c12 ;
  wire \uktn/sub1/c13 ;
  wire \uktn/sub1/c14 ;
  wire \uktn/sub1/c2 ;
  wire \uktn/sub1/c3 ;
  wire \uktn/sub1/c4 ;
  wire \uktn/sub1/c5 ;
  wire \uktn/sub1/c6 ;
  wire \uktn/sub1/c7 ;
  wire \uktn/sub1/c8 ;
  wire \uktn/sub1/c9 ;
  wire \uktn/sub2/c0 ;
  wire \uktn/sub2/c1 ;
  wire \uktn/sub2/c2 ;
  wire \uktn/sub2/c3 ;
  wire \uktn/sub2/c4 ;
  wire \uktn/sub2/c5 ;
  wire \uktn/sub2/c6 ;
  wire \uktn/sub2/c7 ;
  wire \uktn/sub2/c8 ;
  wire \uktn/sub3/c0 ;
  wire \uktn/sub3/c1 ;
  wire \uktn/sub3/c2 ;
  wire \uktn/sub3/c3 ;
  wire \uktn/sub3/c4 ;
  wire \uktn/sub3/c5 ;
  wire \uktn/sub3/c6 ;
  wire \uktn/sub3/c7 ;
  wire \uktn/sub4/c0 ;
  wire \uktn/sub4/c1 ;
  wire \uktn/sub4/c2 ;
  wire \uktn/sub4/c3 ;
  wire \uktn/sub4/c4 ;
  wire \uktn/sub4/c5 ;
  wire \uktn/sub4/c6 ;
  wire \uktn/sub4/c7 ;
  wire \usjs/add0_usjs/add3/c0 ;
  wire \usjs/add0_usjs/add3/c1 ;
  wire \usjs/add0_usjs/add3/c10 ;
  wire \usjs/add0_usjs/add3/c11 ;
  wire \usjs/add0_usjs/add3/c12 ;
  wire \usjs/add0_usjs/add3/c13 ;
  wire \usjs/add0_usjs/add3/c14 ;
  wire \usjs/add0_usjs/add3/c15 ;
  wire \usjs/add0_usjs/add3/c2 ;
  wire \usjs/add0_usjs/add3/c3 ;
  wire \usjs/add0_usjs/add3/c4 ;
  wire \usjs/add0_usjs/add3/c5 ;
  wire \usjs/add0_usjs/add3/c6 ;
  wire \usjs/add0_usjs/add3/c7 ;
  wire \usjs/add0_usjs/add3/c8 ;
  wire \usjs/add0_usjs/add3/c9 ;
  wire \usjs/add5/c0 ;
  wire \usjs/add5/c1 ;
  wire \usjs/add5/c2 ;
  wire \usjs/add5/c3 ;
  wire \usjs/add5/c4 ;
  wire \usjs/add5/c5 ;
  wire \usjs/add5/c6 ;
  wire \usjs/add5/c7 ;
  wire \usjs/add5/c8 ;
  wire \usjs/add5/c9 ;
  wire \usjs/lt0_2_c0 ;
  wire \usjs/lt0_2_c1 ;
  wire \usjs/lt0_2_c2 ;
  wire \usjs/lt0_2_c3 ;
  wire \usjs/lt0_2_c4 ;
  wire \usjs/lt0_2_c5 ;
  wire \usjs/lt0_2_c6 ;
  wire \usjs/lt0_2_c7 ;
  wire \usjs/lt1_c0 ;
  wire \usjs/lt1_c1 ;
  wire \usjs/lt1_c2 ;
  wire \usjs/lt1_c3 ;
  wire \usjs/lt1_c4 ;
  wire \usjs/lt1_c5 ;
  wire \usjs/lt1_c6 ;
  wire \usjs/lt1_c7 ;
  wire \usjs/lt1_c8 ;
  wire \usjs/lt2_c0 ;
  wire \usjs/lt2_c1 ;
  wire \usjs/lt2_c2 ;
  wire \usjs/lt2_c3 ;
  wire \usjs/lt2_c4 ;
  wire \usjs/lt2_c5 ;
  wire \usjs/lt2_c6 ;
  wire \usjs/lt2_c7 ;
  wire \usjs/lt2_c8 ;
  wire \usjs/lt3_c0 ;
  wire \usjs/lt3_c1 ;
  wire \usjs/lt3_c2 ;
  wire \usjs/lt3_c3 ;
  wire \usjs/lt3_c4 ;
  wire \usjs/lt3_c5 ;
  wire \usjs/lt3_c6 ;
  wire \usjs/lt3_c7 ;
  wire \usjs/lt3_c8 ;
  wire \usjs/lt4_c0 ;
  wire \usjs/lt4_c1 ;
  wire \usjs/lt4_c2 ;
  wire \usjs/lt4_c3 ;
  wire \usjs/lt4_c4 ;
  wire \usjs/lt4_c5 ;
  wire \usjs/lt4_c6 ;
  wire \usjs/lt4_c7 ;
  wire \usjs/lt4_c8 ;
  wire \usjs/lt5_c0 ;
  wire \usjs/lt5_c1 ;
  wire \usjs/lt5_c2 ;
  wire \usjs/lt5_c3 ;
  wire \usjs/lt5_c4 ;
  wire \usjs/lt5_c5 ;
  wire \usjs/lt5_c6 ;
  wire \usjs/lt5_c7 ;
  wire \usjs/lt5_c8 ;
  wire \usjs/lt6_c0 ;
  wire \usjs/lt6_c1 ;
  wire \usjs/lt6_c2 ;
  wire \usjs/lt6_c3 ;
  wire \usjs/lt6_c4 ;
  wire \usjs/lt6_c5 ;
  wire \usjs/lt6_c6 ;
  wire \usjs/lt6_c7 ;
  wire \usjs/lt6_c8 ;
  wire \usjs/lt7_c0 ;
  wire \usjs/lt7_c1 ;
  wire \usjs/lt7_c2 ;
  wire \usjs/lt7_c3 ;
  wire \usjs/lt7_c4 ;
  wire \usjs/lt7_c5 ;
  wire \usjs/lt7_c6 ;
  wire \usjs/lt7_c7 ;
  wire \usjs/lt7_c8 ;
  wire \usjs/lt8_c0 ;
  wire \usjs/lt8_c1 ;
  wire \usjs/lt8_c2 ;
  wire \usjs/lt8_c3 ;
  wire \usjs/lt8_c4 ;
  wire \usjs/lt8_c5 ;
  wire \usjs/lt8_c6 ;
  wire \usjs/lt8_c7 ;
  wire \usjs/lt8_c8 ;
  wire \usjs/lt9_c0 ;
  wire \usjs/lt9_c1 ;
  wire \usjs/lt9_c2 ;
  wire \usjs/lt9_c3 ;
  wire \usjs/lt9_c4 ;
  wire \usjs/lt9_c5 ;
  wire \usjs/lt9_c6 ;
  wire \usjs/lt9_c7 ;
  wire \usjs/lt9_c8 ;
  wire \usjs/n1 ;
  wire \usjs/n12 ;
  wire \usjs/n13 ;
  wire \usjs/n15 ;
  wire \usjs/n16 ;
  wire \usjs/n18 ;
  wire \usjs/n19 ;
  wire \usjs/n2 ;
  wire \usjs/n21 ;
  wire \usjs/n22 ;
  wire \usjs/n8 ;
  wire \uuni/n1 ;

  assign ulut_adr1[0] = 1'b1;
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u100 (
    .a(unsjunic[6]),
    .b(unsjunic[7]),
    .c(unsjunic[8]),
    .d(unsjunic[9]),
    .o(_al_u100_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u101 (
    .a(unsjunic[2]),
    .b(unsjunic[3]),
    .c(unsjunic[4]),
    .d(unsjunic[5]),
    .o(_al_u101_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u102 (
    .a(_al_u99_o),
    .b(_al_u100_o),
    .c(_al_u101_o),
    .o(_al_u102_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u103 (
    .a(unsjunic[0]),
    .b(unsjunic[14]),
    .c(ulut_dat0[62]),
    .d(ulut_dat0[48]),
    .o(_al_u103_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u104 (
    .a(_al_u103_o),
    .b(unsjunic[3]),
    .c(unsjunic[7]),
    .d(ulut_dat0[55]),
    .e(ulut_dat0[51]),
    .o(_al_u104_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u105 (
    .a(unsjunic[1]),
    .b(unsjunic[15]),
    .c(ulut_dat0[63]),
    .d(ulut_dat0[49]),
    .o(_al_u105_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u106 (
    .a(unsjunic[2]),
    .b(ulut_dat0[50]),
    .o(\ucmp0/eq2/xor_i0[2]_i1[2]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*A*~(E@D))"),
    .INIT(32'h08000008))
    _al_u107 (
    .a(_al_u104_o),
    .b(_al_u105_o),
    .c(\ucmp0/eq2/xor_i0[2]_i1[2]_o_lutinv ),
    .d(unsjunic[11]),
    .e(ulut_dat0[59]),
    .o(_al_u107_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u108 (
    .a(unsjunic[4]),
    .b(unsjunic[5]),
    .c(ulut_dat0[53]),
    .d(ulut_dat0[52]),
    .o(_al_u108_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*~B)*~(D*~A))"),
    .INIT(16'h8acf))
    _al_u109 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat0[57]),
    .d(ulut_dat0[56]),
    .o(_al_u109_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u110 (
    .a(unsjunic[12]),
    .b(unsjunic[13]),
    .c(ulut_dat0[61]),
    .d(ulut_dat0[60]),
    .o(_al_u110_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u111 (
    .a(unsjunic[10]),
    .b(unsjunic[11]),
    .c(ulut_dat0[59]),
    .d(ulut_dat0[58]),
    .o(_al_u111_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u112 (
    .a(_al_u108_o),
    .b(_al_u109_o),
    .c(_al_u110_o),
    .d(_al_u111_o),
    .e(\ucmp0/eq2/xor_i0[2]_i1[2]_o_lutinv ),
    .o(_al_u112_o));
  AL_MAP_LUT4 #(
    .EQN("(~(~C*B)*~(~D*A))"),
    .INIT(16'hf351))
    _al_u113 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat0[57]),
    .d(ulut_dat0[56]),
    .o(_al_u113_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u114 (
    .a(unsjunic[6]),
    .b(unsjunic[7]),
    .c(ulut_dat0[55]),
    .d(ulut_dat0[54]),
    .o(_al_u114_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E@D))"),
    .INIT(32'h80000080))
    _al_u115 (
    .a(_al_u112_o),
    .b(_al_u113_o),
    .c(_al_u114_o),
    .d(unsjunic[3]),
    .e(ulut_dat0[51]),
    .o(_al_u115_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u116 (
    .a(_al_u102_o),
    .b(_al_u107_o),
    .c(_al_u115_o),
    .o(_al_u116_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u117 (
    .a(unsjunic[4]),
    .b(unsjunic[6]),
    .c(ulut_dat0[70]),
    .d(ulut_dat0[68]),
    .o(_al_u117_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u118 (
    .a(_al_u117_o),
    .b(unsjunic[10]),
    .c(unsjunic[13]),
    .d(ulut_dat0[77]),
    .e(ulut_dat0[74]),
    .o(_al_u118_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u119 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat0[73]),
    .d(ulut_dat0[72]),
    .o(_al_u119_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u120 (
    .a(_al_u119_o),
    .b(unsjunic[0]),
    .c(unsjunic[14]),
    .d(ulut_dat0[78]),
    .e(ulut_dat0[64]),
    .o(_al_u120_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u121 (
    .a(unsjunic[11]),
    .b(unsjunic[5]),
    .c(ulut_dat0[75]),
    .d(ulut_dat0[69]),
    .o(_al_u121_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u122 (
    .a(_al_u121_o),
    .b(unsjunic[15]),
    .c(unsjunic[3]),
    .d(ulut_dat0[79]),
    .e(ulut_dat0[67]),
    .o(_al_u122_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u123 (
    .a(unsjunic[1]),
    .b(unsjunic[7]),
    .c(ulut_dat0[71]),
    .d(ulut_dat0[65]),
    .o(_al_u123_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u124 (
    .a(unsjunic[12]),
    .b(ulut_dat0[76]),
    .o(\ucmp0/eq1/xor_i0[12]_i1[12]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D@C))"),
    .INIT(16'h2002))
    _al_u125 (
    .a(_al_u123_o),
    .b(\ucmp0/eq1/xor_i0[12]_i1[12]_o_lutinv ),
    .c(unsjunic[2]),
    .d(ulut_dat0[66]),
    .o(_al_u125_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u126 (
    .a(_al_u102_o),
    .b(_al_u118_o),
    .c(_al_u120_o),
    .d(_al_u122_o),
    .e(_al_u125_o),
    .o(_al_u126_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u127 (
    .a(unsjunic[4]),
    .b(ulut_dat0[84]),
    .o(\ucmp0/eq0/xor_i0[4]_i1[4]_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C@B))"),
    .INIT(8'h41))
    _al_u128 (
    .a(\ucmp0/eq0/xor_i0[4]_i1[4]_o_lutinv ),
    .b(unsjunic[5]),
    .c(ulut_dat0[85]),
    .o(_al_u128_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u129 (
    .a(unsjunic[13]),
    .b(ulut_dat0[93]),
    .o(\ucmp0/eq0/xor_i0[13]_i1[13]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D@C))"),
    .INIT(16'h2002))
    _al_u130 (
    .a(_al_u128_o),
    .b(\ucmp0/eq0/xor_i0[13]_i1[13]_o_lutinv ),
    .c(unsjunic[9]),
    .d(ulut_dat0[89]),
    .o(_al_u130_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u131 (
    .a(unsjunic[14]),
    .b(unsjunic[15]),
    .c(ulut_dat0[95]),
    .d(ulut_dat0[94]),
    .o(_al_u131_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u132 (
    .a(unsjunic[10]),
    .b(unsjunic[12]),
    .c(ulut_dat0[92]),
    .d(ulut_dat0[90]),
    .o(_al_u132_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u133 (
    .a(_al_u130_o),
    .b(_al_u131_o),
    .c(_al_u132_o),
    .o(_al_u133_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u134 (
    .a(unsjunic[1]),
    .b(unsjunic[2]),
    .c(ulut_dat0[82]),
    .d(ulut_dat0[81]),
    .o(_al_u134_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u135 (
    .a(unsjunic[6]),
    .b(unsjunic[7]),
    .c(ulut_dat0[87]),
    .d(ulut_dat0[86]),
    .o(_al_u135_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u136 (
    .a(unsjunic[11]),
    .b(unsjunic[8]),
    .c(ulut_dat0[91]),
    .d(ulut_dat0[88]),
    .o(_al_u136_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u137 (
    .a(unsjunic[3]),
    .b(ulut_dat0[83]),
    .o(\ucmp0/eq0/xor_i0[3]_i1[3]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u138 (
    .a(unsjunic[0]),
    .b(ulut_dat0[80]),
    .o(\ucmp0/eq0/xor_i0[0]_i1[0]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u139 (
    .a(_al_u134_o),
    .b(_al_u135_o),
    .c(_al_u136_o),
    .d(\ucmp0/eq0/xor_i0[3]_i1[3]_o_lutinv ),
    .e(\ucmp0/eq0/xor_i0[0]_i1[0]_o_lutinv ),
    .o(_al_u139_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u140 (
    .a(unsjunic[6]),
    .b(unsjunic[7]),
    .c(ulut_dat0[39]),
    .d(ulut_dat0[38]),
    .o(_al_u140_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u141 (
    .a(unsjunic[14]),
    .b(ulut_dat0[46]),
    .o(\ucmp0/eq3/xor_i0[14]_i1[14]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D@C))"),
    .INIT(16'h2002))
    _al_u142 (
    .a(_al_u140_o),
    .b(\ucmp0/eq3/xor_i0[14]_i1[14]_o_lutinv ),
    .c(unsjunic[11]),
    .d(ulut_dat0[43]),
    .o(_al_u142_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u143 (
    .a(unsjunic[9]),
    .b(ulut_dat0[41]),
    .o(\ucmp0/eq3/xor_i0[9]_i1[9]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u144 (
    .a(unsjunic[12]),
    .b(ulut_dat0[44]),
    .o(\ucmp0/eq3/xor_i0[12]_i1[12]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u145 (
    .a(unsjunic[15]),
    .b(ulut_dat0[47]),
    .o(\ucmp0/eq3/xor_i0[15]_i1[15]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u146 (
    .a(unsjunic[10]),
    .b(ulut_dat0[42]),
    .o(\ucmp0/eq3/xor_i0[10]_i1[10]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u147 (
    .a(_al_u142_o),
    .b(\ucmp0/eq3/xor_i0[9]_i1[9]_o_lutinv ),
    .c(\ucmp0/eq3/xor_i0[12]_i1[12]_o_lutinv ),
    .d(\ucmp0/eq3/xor_i0[15]_i1[15]_o_lutinv ),
    .e(\ucmp0/eq3/xor_i0[10]_i1[10]_o_lutinv ),
    .o(_al_u147_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u148 (
    .a(unsjunic[0]),
    .b(unsjunic[1]),
    .c(ulut_dat0[33]),
    .d(ulut_dat0[32]),
    .o(_al_u148_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u149 (
    .a(unsjunic[8]),
    .b(ulut_dat0[40]),
    .o(\ucmp0/eq3/xor_i0[8]_i1[8]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D@C))"),
    .INIT(16'h2002))
    _al_u150 (
    .a(_al_u148_o),
    .b(\ucmp0/eq3/xor_i0[8]_i1[8]_o_lutinv ),
    .c(unsjunic[13]),
    .d(ulut_dat0[45]),
    .o(_al_u150_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u151 (
    .a(unsjunic[2]),
    .b(unsjunic[3]),
    .c(ulut_dat0[35]),
    .d(ulut_dat0[34]),
    .o(_al_u151_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u152 (
    .a(unsjunic[4]),
    .b(unsjunic[5]),
    .c(ulut_dat0[37]),
    .d(ulut_dat0[36]),
    .o(_al_u152_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u153 (
    .a(_al_u102_o),
    .b(_al_u147_o),
    .c(_al_u150_o),
    .d(_al_u151_o),
    .e(_al_u152_o),
    .o(_al_u153_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(~D*~(C*A)))"),
    .INIT(16'h3320))
    _al_u154 (
    .a(_al_u133_o),
    .b(_al_u102_o),
    .c(_al_u139_o),
    .d(_al_u153_o),
    .o(_al_u154_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u155 (
    .a(_al_u116_o),
    .b(_al_u126_o),
    .c(_al_u154_o),
    .o(_al_u155_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u156 (
    .a(unsjunic[0]),
    .b(unsjunic[1]),
    .c(ulut_dat0[1]),
    .d(ulut_dat0[0]),
    .o(_al_u156_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u157 (
    .a(_al_u156_o),
    .b(unsjunic[14]),
    .c(unsjunic[7]),
    .d(ulut_dat0[14]),
    .e(ulut_dat0[7]),
    .o(_al_u157_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u158 (
    .a(unsjunic[2]),
    .b(unsjunic[3]),
    .c(ulut_dat0[3]),
    .d(ulut_dat0[2]),
    .o(_al_u158_o));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u159 (
    .a(unsjunic[12]),
    .b(ulut_dat0[12]),
    .o(_al_u159_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E@D))"),
    .INIT(32'h80000080))
    _al_u160 (
    .a(_al_u157_o),
    .b(_al_u158_o),
    .c(_al_u159_o),
    .d(unsjunic[15]),
    .e(ulut_dat0[15]),
    .o(_al_u160_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u161 (
    .a(unsjunic[10]),
    .b(unsjunic[11]),
    .c(ulut_dat0[11]),
    .d(ulut_dat0[10]),
    .o(_al_u161_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u162 (
    .a(_al_u161_o),
    .b(unsjunic[13]),
    .c(unsjunic[5]),
    .d(ulut_dat0[13]),
    .e(ulut_dat0[5]),
    .o(_al_u162_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u163 (
    .a(unsjunic[4]),
    .b(unsjunic[6]),
    .c(ulut_dat0[6]),
    .d(ulut_dat0[4]),
    .o(_al_u163_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u164 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat0[9]),
    .d(ulut_dat0[8]),
    .o(_al_u164_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u165 (
    .a(_al_u102_o),
    .b(_al_u160_o),
    .c(_al_u162_o),
    .d(_al_u163_o),
    .e(_al_u164_o),
    .o(_al_u165_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u166 (
    .a(unsjunic[1]),
    .b(unsjunic[2]),
    .c(ulut_dat0[18]),
    .d(ulut_dat0[17]),
    .o(_al_u166_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u167 (
    .a(_al_u166_o),
    .b(unsjunic[14]),
    .c(unsjunic[8]),
    .d(ulut_dat0[30]),
    .e(ulut_dat0[24]),
    .o(_al_u167_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u168 (
    .a(unsjunic[12]),
    .b(unsjunic[13]),
    .c(ulut_dat0[29]),
    .d(ulut_dat0[28]),
    .o(_al_u168_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u169 (
    .a(unsjunic[7]),
    .b(ulut_dat0[23]),
    .o(\ucmp0/eq4/xor_i0[7]_i1[7]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*A*~(E@D))"),
    .INIT(32'h08000008))
    _al_u170 (
    .a(_al_u167_o),
    .b(_al_u168_o),
    .c(\ucmp0/eq4/xor_i0[7]_i1[7]_o_lutinv ),
    .d(unsjunic[4]),
    .e(ulut_dat0[20]),
    .o(_al_u170_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u171 (
    .a(unsjunic[10]),
    .b(unsjunic[11]),
    .c(ulut_dat0[27]),
    .d(ulut_dat0[26]),
    .o(_al_u171_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u172 (
    .a(_al_u171_o),
    .b(unsjunic[0]),
    .c(unsjunic[3]),
    .d(ulut_dat0[19]),
    .e(ulut_dat0[16]),
    .o(_al_u172_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u173 (
    .a(unsjunic[15]),
    .b(unsjunic[9]),
    .c(ulut_dat0[31]),
    .d(ulut_dat0[25]),
    .o(_al_u173_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u174 (
    .a(_al_u173_o),
    .b(unsjunic[5]),
    .c(unsjunic[6]),
    .d(ulut_dat0[22]),
    .e(ulut_dat0[21]),
    .o(_al_u174_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D*C*~B))"),
    .INIT(32'h45555555))
    _al_u175 (
    .a(_al_u165_o),
    .b(_al_u102_o),
    .c(_al_u170_o),
    .d(_al_u172_o),
    .e(_al_u174_o),
    .o(_al_u175_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u176 (
    .a(_al_u155_o),
    .b(_al_u175_o),
    .o(_al_u176_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u177 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [3]),
    .c(\uctl/uctl_adr1 [3]),
    .o(\uctl/uctl_adr [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u178 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [2]),
    .c(\uctl/uctl_adr1 [2]),
    .o(\uctl/uctl_adr [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u179 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [1]),
    .c(\uctl/uctl_adr1 [1]),
    .o(\uctl/uctl_adr [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u180 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [0]),
    .c(\uctl/uctl_adr1 [0]),
    .o(\uctl/uctl_adr [0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u181 (
    .a(unsjunic[12]),
    .b(unsjunic[6]),
    .c(ulut_dat1[12]),
    .d(ulut_dat1[6]),
    .o(_al_u181_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u182 (
    .a(_al_u181_o),
    .b(unsjunic[0]),
    .c(unsjunic[2]),
    .d(ulut_dat1[2]),
    .e(ulut_dat1[0]),
    .o(_al_u182_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u183 (
    .a(unsjunic[1]),
    .b(unsjunic[11]),
    .c(ulut_dat1[11]),
    .d(ulut_dat1[1]),
    .o(_al_u183_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u184 (
    .a(_al_u183_o),
    .b(unsjunic[10]),
    .c(unsjunic[4]),
    .d(ulut_dat1[10]),
    .e(ulut_dat1[4]),
    .o(_al_u184_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u185 (
    .a(unsjunic[14]),
    .b(unsjunic[15]),
    .c(ulut_dat1[15]),
    .d(ulut_dat1[14]),
    .o(_al_u185_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u186 (
    .a(_al_u185_o),
    .b(unsjunic[3]),
    .c(unsjunic[7]),
    .d(ulut_dat1[7]),
    .e(ulut_dat1[3]),
    .o(_al_u186_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u187 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat1[9]),
    .d(ulut_dat1[8]),
    .o(_al_u187_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u188 (
    .a(_al_u187_o),
    .b(unsjunic[13]),
    .c(unsjunic[5]),
    .d(ulut_dat1[13]),
    .e(ulut_dat1[5]),
    .o(_al_u188_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u189 (
    .a(_al_u102_o),
    .b(_al_u182_o),
    .c(_al_u184_o),
    .d(_al_u186_o),
    .e(_al_u188_o),
    .o(ucmp_match1[0]));
  AL_MAP_LUT4 #(
    .EQN("(~(C*~B)*~(~D*A))"),
    .INIT(16'hcf45))
    _al_u190 (
    .a(unsjunic[1]),
    .b(unsjunic[14]),
    .c(ulut_dat1[30]),
    .d(ulut_dat1[17]),
    .o(_al_u190_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u191 (
    .a(_al_u190_o),
    .b(unsjunic[2]),
    .c(ulut_dat1[18]),
    .o(_al_u191_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u192 (
    .a(unsjunic[8]),
    .b(ulut_dat1[24]),
    .o(_al_u192_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    _al_u193 (
    .a(_al_u192_o),
    .b(unsjunic[2]),
    .c(ulut_dat1[18]),
    .o(_al_u193_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u194 (
    .a(unsjunic[4]),
    .b(ulut_dat1[20]),
    .o(_al_u194_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D@C)*~(~E*B))"),
    .INIT(32'h50051001))
    _al_u195 (
    .a(_al_u194_o),
    .b(unsjunic[14]),
    .c(unsjunic[15]),
    .d(ulut_dat1[31]),
    .e(ulut_dat1[30]),
    .o(_al_u195_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u196 (
    .a(unsjunic[1]),
    .b(ulut_dat1[17]),
    .o(_al_u196_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*~A)"),
    .INIT(32'h00004000))
    _al_u197 (
    .a(_al_u102_o),
    .b(_al_u191_o),
    .c(_al_u193_o),
    .d(_al_u195_o),
    .e(_al_u196_o),
    .o(_al_u197_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u198 (
    .a(unsjunic[0]),
    .b(unsjunic[9]),
    .c(ulut_dat1[25]),
    .d(ulut_dat1[16]),
    .o(_al_u198_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u199 (
    .a(_al_u198_o),
    .b(unsjunic[11]),
    .c(unsjunic[5]),
    .d(ulut_dat1[27]),
    .e(ulut_dat1[21]),
    .o(_al_u199_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u200 (
    .a(unsjunic[3]),
    .b(unsjunic[6]),
    .c(ulut_dat1[22]),
    .d(ulut_dat1[19]),
    .o(_al_u200_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u201 (
    .a(_al_u200_o),
    .b(unsjunic[10]),
    .c(unsjunic[7]),
    .d(ulut_dat1[26]),
    .e(ulut_dat1[23]),
    .o(_al_u201_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u202 (
    .a(unsjunic[12]),
    .b(unsjunic[13]),
    .c(ulut_dat1[29]),
    .d(ulut_dat1[28]),
    .o(_al_u202_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~D*C)*~(~E*B))"),
    .INIT(32'haa0a2202))
    _al_u203 (
    .a(_al_u202_o),
    .b(unsjunic[4]),
    .c(unsjunic[8]),
    .d(ulut_dat1[24]),
    .e(ulut_dat1[20]),
    .o(_al_u203_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D*C*B))"),
    .INIT(32'h15555555))
    _al_u204 (
    .a(ucmp_match1[0]),
    .b(_al_u197_o),
    .c(_al_u199_o),
    .d(_al_u201_o),
    .e(_al_u203_o),
    .o(_al_u204_o));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u205 (
    .a(unsjunic[12]),
    .b(ulut_dat1[44]),
    .o(_al_u205_o));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u206 (
    .a(unsjunic[0]),
    .b(ulut_dat1[32]),
    .o(_al_u206_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u207 (
    .a(unsjunic[14]),
    .b(ulut_dat1[46]),
    .o(\ucmp1/eq3/xor_i0[14]_i1[14]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u208 (
    .a(unsjunic[11]),
    .b(ulut_dat1[43]),
    .o(\ucmp1/eq3/xor_i0[11]_i1[11]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u209 (
    .a(_al_u205_o),
    .b(_al_u206_o),
    .c(\ucmp1/eq3/xor_i0[14]_i1[14]_o_lutinv ),
    .d(\ucmp1/eq3/xor_i0[11]_i1[11]_o_lutinv ),
    .o(_al_u209_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u210 (
    .a(unsjunic[4]),
    .b(ulut_dat1[36]),
    .o(\ucmp1/eq3/xor_i0[4]_i1[4]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u211 (
    .a(unsjunic[9]),
    .b(ulut_dat1[41]),
    .o(\ucmp1/eq3/xor_i0[9]_i1[9]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u212 (
    .a(unsjunic[10]),
    .b(ulut_dat1[42]),
    .o(\ucmp1/eq3/xor_i0[10]_i1[10]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~A*~(E@D))"),
    .INIT(32'h01000001))
    _al_u213 (
    .a(\ucmp1/eq3/xor_i0[4]_i1[4]_o_lutinv ),
    .b(\ucmp1/eq3/xor_i0[9]_i1[9]_o_lutinv ),
    .c(\ucmp1/eq3/xor_i0[10]_i1[10]_o_lutinv ),
    .d(unsjunic[15]),
    .e(ulut_dat1[47]),
    .o(_al_u213_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u214 (
    .a(unsjunic[5]),
    .b(unsjunic[8]),
    .c(ulut_dat1[40]),
    .d(ulut_dat1[37]),
    .o(_al_u214_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u215 (
    .a(_al_u214_o),
    .b(unsjunic[1]),
    .c(unsjunic[13]),
    .d(ulut_dat1[45]),
    .e(ulut_dat1[33]),
    .o(_al_u215_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u216 (
    .a(unsjunic[2]),
    .b(unsjunic[3]),
    .c(ulut_dat1[35]),
    .d(ulut_dat1[34]),
    .o(_al_u216_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u217 (
    .a(_al_u216_o),
    .b(unsjunic[6]),
    .c(unsjunic[7]),
    .d(ulut_dat1[39]),
    .e(ulut_dat1[38]),
    .o(_al_u217_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u218 (
    .a(_al_u102_o),
    .b(_al_u209_o),
    .c(_al_u213_o),
    .d(_al_u215_o),
    .e(_al_u217_o),
    .o(ucmp_match1[2]));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u219 (
    .a(unsjunic[15]),
    .b(unsjunic[6]),
    .c(ulut_dat1[63]),
    .d(ulut_dat1[54]),
    .o(_al_u219_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u220 (
    .a(_al_u219_o),
    .b(unsjunic[14]),
    .c(unsjunic[3]),
    .d(ulut_dat1[62]),
    .e(ulut_dat1[51]),
    .o(_al_u220_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*~B)*~(D*~A))"),
    .INIT(16'h8acf))
    _al_u221 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat1[57]),
    .d(ulut_dat1[56]),
    .o(_al_u221_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u222 (
    .a(unsjunic[10]),
    .b(unsjunic[11]),
    .c(ulut_dat1[59]),
    .d(ulut_dat1[58]),
    .o(_al_u222_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E@D))"),
    .INIT(32'h80000080))
    _al_u223 (
    .a(_al_u220_o),
    .b(_al_u221_o),
    .c(_al_u222_o),
    .d(unsjunic[2]),
    .e(ulut_dat1[50]),
    .o(_al_u223_o));
  AL_MAP_LUT4 #(
    .EQN("(~(~C*B)*~(~D*A))"),
    .INIT(16'hf351))
    _al_u224 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat1[57]),
    .d(ulut_dat1[56]),
    .o(_al_u224_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u225 (
    .a(unsjunic[0]),
    .b(unsjunic[7]),
    .c(ulut_dat1[55]),
    .d(ulut_dat1[48]),
    .o(_al_u225_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D@C))"),
    .INIT(16'h8008))
    _al_u226 (
    .a(_al_u224_o),
    .b(_al_u225_o),
    .c(unsjunic[1]),
    .d(ulut_dat1[49]),
    .o(_al_u226_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u227 (
    .a(unsjunic[12]),
    .b(unsjunic[13]),
    .c(ulut_dat1[61]),
    .d(ulut_dat1[60]),
    .o(_al_u227_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u228 (
    .a(unsjunic[4]),
    .b(unsjunic[5]),
    .c(ulut_dat1[53]),
    .d(ulut_dat1[52]),
    .o(_al_u228_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u229 (
    .a(_al_u102_o),
    .b(_al_u223_o),
    .c(_al_u226_o),
    .d(_al_u227_o),
    .e(_al_u228_o),
    .o(ucmp_match1[3]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u230 (
    .a(_al_u204_o),
    .b(ucmp_match1[2]),
    .c(ucmp_match1[3]),
    .o(_al_u230_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u231 (
    .a(unsjunic[14]),
    .b(unsjunic[3]),
    .c(ulut_dat1[94]),
    .d(ulut_dat1[83]),
    .o(_al_u231_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u232 (
    .a(unsjunic[1]),
    .b(ulut_dat1[81]),
    .o(\ucmp1/eq0/xor_i0[1]_i1[1]_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D@C))"),
    .INIT(16'h2002))
    _al_u233 (
    .a(_al_u231_o),
    .b(\ucmp1/eq0/xor_i0[1]_i1[1]_o_lutinv ),
    .c(unsjunic[12]),
    .d(ulut_dat1[92]),
    .o(_al_u233_o));
  AL_MAP_LUT4 #(
    .EQN("(~(~D*B)*~(~C*A))"),
    .INIT(16'hf531))
    _al_u234 (
    .a(unsjunic[10]),
    .b(unsjunic[7]),
    .c(ulut_dat1[90]),
    .d(ulut_dat1[87]),
    .o(_al_u234_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u235 (
    .a(unsjunic[15]),
    .b(unsjunic[9]),
    .c(ulut_dat1[95]),
    .d(ulut_dat1[89]),
    .o(_al_u235_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E@D))"),
    .INIT(32'h80000080))
    _al_u236 (
    .a(_al_u233_o),
    .b(_al_u234_o),
    .c(_al_u235_o),
    .d(unsjunic[8]),
    .e(ulut_dat1[88]),
    .o(_al_u236_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(C*~A))"),
    .INIT(16'h8caf))
    _al_u237 (
    .a(unsjunic[10]),
    .b(unsjunic[7]),
    .c(ulut_dat1[90]),
    .d(ulut_dat1[87]),
    .o(_al_u237_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C@B))"),
    .INIT(8'h82))
    _al_u238 (
    .a(_al_u237_o),
    .b(unsjunic[6]),
    .c(ulut_dat1[86]),
    .o(_al_u238_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u239 (
    .a(unsjunic[11]),
    .b(unsjunic[2]),
    .c(ulut_dat1[91]),
    .d(ulut_dat1[82]),
    .o(_al_u239_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u240 (
    .a(_al_u239_o),
    .b(unsjunic[0]),
    .c(unsjunic[13]),
    .d(ulut_dat1[93]),
    .e(ulut_dat1[80]),
    .o(_al_u240_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u241 (
    .a(unsjunic[4]),
    .b(unsjunic[5]),
    .c(ulut_dat1[85]),
    .d(ulut_dat1[84]),
    .o(_al_u241_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u242 (
    .a(_al_u236_o),
    .b(_al_u238_o),
    .c(_al_u240_o),
    .d(_al_u241_o),
    .o(_al_u242_o));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u243 (
    .a(unsjunic[15]),
    .b(ulut_dat1[79]),
    .o(\ucmp1/eq1/xor_i0[15]_i1[15]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u244 (
    .a(unsjunic[2]),
    .b(ulut_dat1[66]),
    .o(\ucmp1/eq1/xor_i0[2]_i1[2]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u245 (
    .a(unsjunic[6]),
    .b(ulut_dat1[70]),
    .o(\ucmp1/eq1/xor_i0[6]_i1[6]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~A*~(E@D))"),
    .INIT(32'h01000001))
    _al_u246 (
    .a(\ucmp1/eq1/xor_i0[15]_i1[15]_o_lutinv ),
    .b(\ucmp1/eq1/xor_i0[2]_i1[2]_o_lutinv ),
    .c(\ucmp1/eq1/xor_i0[6]_i1[6]_o_lutinv ),
    .d(unsjunic[12]),
    .e(ulut_dat1[76]),
    .o(_al_u246_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C@B)*~(D@A))"),
    .INIT(16'h8241))
    _al_u247 (
    .a(unsjunic[8]),
    .b(unsjunic[9]),
    .c(ulut_dat1[73]),
    .d(ulut_dat1[72]),
    .o(_al_u247_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u248 (
    .a(_al_u247_o),
    .b(unsjunic[13]),
    .c(unsjunic[5]),
    .d(ulut_dat1[77]),
    .e(ulut_dat1[69]),
    .o(_al_u248_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u249 (
    .a(unsjunic[14]),
    .b(unsjunic[7]),
    .c(ulut_dat1[78]),
    .d(ulut_dat1[71]),
    .o(_al_u249_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u250 (
    .a(_al_u249_o),
    .b(unsjunic[0]),
    .c(unsjunic[3]),
    .d(ulut_dat1[67]),
    .e(ulut_dat1[64]),
    .o(_al_u250_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u251 (
    .a(unsjunic[10]),
    .b(unsjunic[4]),
    .c(ulut_dat1[74]),
    .d(ulut_dat1[68]),
    .o(_al_u251_o));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u252 (
    .a(unsjunic[1]),
    .b(ulut_dat1[65]),
    .o(_al_u252_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D@C))"),
    .INIT(16'h8008))
    _al_u253 (
    .a(_al_u251_o),
    .b(_al_u252_o),
    .c(unsjunic[11]),
    .d(ulut_dat1[75]),
    .o(_al_u253_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u254 (
    .a(_al_u102_o),
    .b(_al_u246_o),
    .c(_al_u248_o),
    .d(_al_u250_o),
    .e(_al_u253_o),
    .o(ucmp_match1[4]));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(~C*~A))"),
    .INIT(8'h32))
    _al_u255 (
    .a(_al_u242_o),
    .b(_al_u102_o),
    .c(ucmp_match1[4]),
    .o(_al_u255_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u256 (
    .a(_al_u230_o),
    .b(_al_u175_o),
    .c(_al_u255_o),
    .d(_al_u155_o),
    .o(_al_u256_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u257 (
    .a(_al_u256_o),
    .b(\uctl/ufsm/stat [0]),
    .c(\uctl/ufsm/stat [1]),
    .d(\uctl/ufsm/stat [2]),
    .o(_al_u257_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u258 (
    .a(ulut_adr1[6]),
    .b(ulut_adr1[7]),
    .c(ulut_adr1[8]),
    .d(ulut_adr1[9]),
    .o(_al_u258_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u259 (
    .a(ulut_adr1[2]),
    .b(ulut_adr1[3]),
    .c(ulut_adr1[4]),
    .d(ulut_adr1[5]),
    .o(_al_u259_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u260 (
    .a(_al_u258_o),
    .b(_al_u259_o),
    .c(ulut_adr1[1]),
    .d(ulut_adr1[10]),
    .o(_al_u260_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u261 (
    .a(_al_u257_o),
    .b(_al_u260_o),
    .o(_al_u261_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u262 (
    .a(_al_u261_o),
    .b(rst_n),
    .o(\uctl/mux3_b0_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(~B*A))"),
    .INIT(8'h2f))
    _al_u263 (
    .a(_al_u155_o),
    .b(_al_u204_o),
    .c(_al_u175_o),
    .o(\uctl/uctl_kutn_l_1 [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u264 (
    .a(_al_u257_o),
    .b(_al_u260_o),
    .o(_al_u264_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u265 (
    .a(_al_u264_o),
    .b(rst_n),
    .o(\usjs/n8 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u266 (
    .a(\uctl/ufsm/stat [0]),
    .b(\uctl/ufsm/stat [1]),
    .c(\uctl/ufsm/stat [2]),
    .d(_al_u256_o),
    .o(_al_u266_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u267 (
    .a(_al_u266_o),
    .b(rst_n),
    .o(\uktn/mux4_b15_sel_is_1_o ));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u268 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [5]),
    .c(\uctl/uctl_adr1 [5]),
    .o(_al_u268_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u269 (
    .a(_al_u266_o),
    .b(_al_u268_o),
    .o(uctl_kutn[9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u270 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [4]),
    .c(\uctl/uctl_adr1 [4]),
    .o(\uctl/uctl_adr [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u271 (
    .a(_al_u266_o),
    .b(\uctl/uctl_adr [4]),
    .o(\usjs/n4 [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u272 (
    .a(n1[5]),
    .b(_al_u266_o),
    .o(uctl_kutn[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u273 (
    .a(n1[4]),
    .b(_al_u266_o),
    .o(uctl_kutn[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u274 (
    .a(n1[3]),
    .b(_al_u266_o),
    .o(uctl_kutn[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u275 (
    .a(n1[2]),
    .b(_al_u266_o),
    .o(uctl_kutn[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u276 (
    .a(n1[1]),
    .b(_al_u266_o),
    .o(uctl_kutn[2]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u277 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [10]),
    .c(\uctl/uctl_adr1 [10]),
    .o(_al_u277_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u278 (
    .a(_al_u266_o),
    .b(_al_u277_o),
    .o(uctl_kutn[14]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u279 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [9]),
    .c(\uctl/uctl_adr1 [9]),
    .o(_al_u279_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u280 (
    .a(_al_u266_o),
    .b(_al_u279_o),
    .o(uctl_kutn[13]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u281 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [8]),
    .c(\uctl/uctl_adr1 [8]),
    .o(_al_u281_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u282 (
    .a(_al_u266_o),
    .b(_al_u281_o),
    .o(uctl_kutn[12]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u283 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [7]),
    .c(\uctl/uctl_adr1 [7]),
    .o(_al_u283_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u284 (
    .a(_al_u266_o),
    .b(_al_u283_o),
    .o(uctl_kutn[11]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u285 (
    .a(_al_u176_o),
    .b(\uctl/uctl_adr0 [6]),
    .c(\uctl/uctl_adr1 [6]),
    .o(_al_u285_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u286 (
    .a(_al_u266_o),
    .b(_al_u285_o),
    .o(uctl_kutn[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u287 (
    .a(n1[0]),
    .b(_al_u266_o),
    .o(uctl_kutn[1]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u288 (
    .a(\uctl/uctl_busy ),
    .b(bcmdw),
    .c(bcs_unsj_n),
    .o(_al_u288_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u289 (
    .a(_al_u288_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(_al_u289_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~E*~D*~C*B))"),
    .INIT(32'h55555551))
    _al_u290 (
    .a(_al_u261_o),
    .b(_al_u289_o),
    .c(\uctl/ufsm/stat [0]),
    .d(\uctl/ufsm/stat [1]),
    .e(\uctl/ufsm/stat [2]),
    .o(_al_u290_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u291 (
    .a(_al_u290_o),
    .b(rst_n),
    .o(\uctl/ufsm/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u292 (
    .a(_al_u76_o),
    .b(_al_u95_o),
    .c(\uctl/ufsm/stat [1]),
    .o(_al_u292_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u293 (
    .a(_al_u292_o),
    .b(\uctl/ufsm/stat [0]),
    .c(\uctl/ufsm/stat [2]),
    .o(uctl_cvt_kutn_lutinv));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*~B*A))"),
    .INIT(16'hfd00))
    _al_u294 (
    .a(_al_u290_o),
    .b(uctl_cvt_kutn_lutinv),
    .c(\uctl/uctl_rom_rd_lutinv ),
    .d(rst_n),
    .o(\uctl/ufsm/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u295 (
    .a(_al_u288_o),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(_al_u295_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u296 (
    .a(_al_u289_o),
    .b(_al_u295_o),
    .c(\uctl/ufsm/stat [1]),
    .o(_al_u296_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~A*~(~D*~C*~B)))"),
    .INIT(32'haaab0000))
    _al_u297 (
    .a(_al_u261_o),
    .b(_al_u296_o),
    .c(\uctl/ufsm/stat [0]),
    .d(\uctl/ufsm/stat [2]),
    .e(rst_n),
    .o(\uctl/ufsm/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u298 (
    .a(_al_u176_o),
    .b(_al_u116_o),
    .c(ucmp_match1[3]),
    .o(_al_u298_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u299 (
    .a(_al_u176_o),
    .b(_al_u153_o),
    .c(ucmp_match1[2]),
    .o(_al_u299_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~A*~(~D*~(E*C))))"),
    .INIT(32'h888c88cc))
    _al_u300 (
    .a(_al_u298_o),
    .b(_al_u299_o),
    .c(_al_u176_o),
    .d(_al_u126_o),
    .e(ucmp_match1[4]),
    .o(_al_u300_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*B*~(C)*D*E)"),
    .INIT(32'h08c83afa))
    _al_u301 (
    .a(_al_u300_o),
    .b(_al_u176_o),
    .c(\uctl/uctl_kutn_l_1 [2]),
    .d(ucmp_match1[0]),
    .e(_al_u165_o),
    .o(_al_u301_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u302 (
    .a(_al_u301_o),
    .b(_al_u266_o),
    .o(uctl_kutn[0]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*A)"),
    .INIT(4'hd))
    _al_u303 (
    .a(\usjs/n2 ),
    .b(\usjs/n4 [1]),
    .o(\usjs/n4 [0]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B*~A))"),
    .INIT(8'h0b))
    _al_u304 (
    .a(_al_u298_o),
    .b(_al_u299_o),
    .c(\uctl/uctl_kutn_l_1 [2]),
    .o(\uctl/uctl_kutn_l_1 [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u305 (
    .a(\uctl/mux1_b3/B5_1 ),
    .b(unsjkutn[0]),
    .c(unsjkutn[6]),
    .o(_al_u305_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*(~(A)*B*~(C)*~(D)+A*~(B)*C*~(D)+~(A)*~(B)*~(C)*D+A*B*~(C)*D+~(A)*B*C*D))"),
    .INIT(32'h00004924))
    _al_u306 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .c(unsjkutn[3]),
    .d(unsjkutn[4]),
    .e(unsjkutn[5]),
    .o(\uctl/mux0_b1/B5_1 ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h6db6db6d))
    _al_u307 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .c(unsjkutn[3]),
    .d(unsjkutn[4]),
    .e(unsjkutn[5]),
    .o(_al_u307_o));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u308 (
    .a(\uctl/mux0_b1/B5_1 ),
    .b(_al_u307_o),
    .c(unsjkutn[6]),
    .o(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u309 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .o(\uctl/n5_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u310 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[41]),
    .d(ulut_dat0[25]),
    .e(ulut_dat0[9]),
    .o(_al_u310_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hdb6db6db))
    _al_u311 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .c(unsjkutn[3]),
    .d(unsjkutn[4]),
    .e(unsjkutn[5]),
    .o(_al_u311_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*(~(A)*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+~(A)*~(B)*C*D))"),
    .INIT(32'h00001249))
    _al_u312 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .c(unsjkutn[3]),
    .d(unsjkutn[4]),
    .e(unsjkutn[5]),
    .o(\uctl/mux0_b2/B5_1 ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D))"),
    .INIT(16'h0a88))
    _al_u313 (
    .a(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .b(_al_u311_o),
    .c(\uctl/mux0_b2/B5_1 ),
    .d(unsjkutn[6]),
    .o(_al_u313_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u314 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u310_o),
    .c(_al_u313_o),
    .d(ulut_dat0[57]),
    .o(_al_u314_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u315 (
    .a(_al_u314_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[89]),
    .e(ulut_dat0[73]),
    .o(uctl_unic[9]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u316 (
    .a(_al_u95_o),
    .b(\uctl/ufsm/stat [0]),
    .c(\uctl/ufsm/stat [1]),
    .d(\uctl/ufsm/stat [2]),
    .o(uctl_err_ktn_lutinv));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u317 (
    .a(\uctl/ufsm/stat [0]),
    .b(\uctl/ufsm/stat [1]),
    .c(\uctl/ufsm/stat [2]),
    .o(uctl_lat_unic_lutinv));
  AL_MAP_LUT5 #(
    .EQN("(~D*(E*~((C*B))*~(A)+E*(C*B)*~(A)+~(E)*(C*B)*A+E*(C*B)*A))"),
    .INIT(32'h00d50080))
    _al_u318 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [3]),
    .d(uctl_lat_unic_lutinv),
    .e(unsjunic[9]),
    .o(_al_u318_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(D*A))*~(E)*~(C)+~(~B*~(D*A))*E*~(C)+~(~(~B*~(D*A)))*E*C+~(~B*~(D*A))*E*C)"),
    .INIT(32'hfefc0e0c))
    _al_u319 (
    .a(uctl_unic[9]),
    .b(_al_u318_o),
    .c(_al_u289_o),
    .d(uctl_lat_unic_lutinv),
    .e(bdatw[9]),
    .o(\uuni/n4 [9]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u320 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[40]),
    .d(ulut_dat0[24]),
    .e(ulut_dat0[8]),
    .o(_al_u320_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u321 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u320_o),
    .c(_al_u313_o),
    .d(ulut_dat0[56]),
    .o(_al_u321_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u322 (
    .a(_al_u321_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[88]),
    .e(ulut_dat0[72]),
    .o(uctl_unic[8]));
  AL_MAP_LUT5 #(
    .EQN("(~D*(E*~((C*B))*~(A)+E*(C*B)*~(A)+~(E)*(C*B)*A+E*(C*B)*A))"),
    .INIT(32'h00d50080))
    _al_u323 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [2]),
    .d(uctl_lat_unic_lutinv),
    .e(unsjunic[8]),
    .o(_al_u323_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(D*A))*~(E)*~(C)+~(~B*~(D*A))*E*~(C)+~(~(~B*~(D*A)))*E*C+~(~B*~(D*A))*E*C)"),
    .INIT(32'hfefc0e0c))
    _al_u324 (
    .a(uctl_unic[8]),
    .b(_al_u323_o),
    .c(_al_u289_o),
    .d(uctl_lat_unic_lutinv),
    .e(bdatw[8]),
    .o(\uuni/n4 [8]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u325 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[39]),
    .d(ulut_dat0[23]),
    .e(ulut_dat0[7]),
    .o(_al_u325_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u326 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u325_o),
    .c(_al_u313_o),
    .d(ulut_dat0[55]),
    .o(_al_u326_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u327 (
    .a(_al_u326_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[87]),
    .e(ulut_dat0[71]),
    .o(uctl_unic[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u328 (
    .a(\usjs/n21 ),
    .b(\usjs/n25 [1]),
    .c(unsjsjis[7]),
    .o(_al_u328_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C)*~(A)*~(D)+(E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C)*A*~(D)+~((E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C))*A*D+(E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C)*A*D)"),
    .INIT(32'haacfaac0))
    _al_u329 (
    .a(uctl_unic[7]),
    .b(_al_u328_o),
    .c(uctl_err_ktn_lutinv),
    .d(uctl_lat_unic_lutinv),
    .e(unsjunic[7]),
    .o(\uuni/n3 [7]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u33 (
    .a(\uktn/n0 ),
    .b(unsjsjis[14]),
    .o(n2));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u330 (
    .a(\uuni/n3 [7]),
    .b(_al_u289_o),
    .c(bdatw[7]),
    .o(\uuni/n4 [7]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u331 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[38]),
    .d(ulut_dat0[22]),
    .e(ulut_dat0[6]),
    .o(_al_u331_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u332 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u331_o),
    .c(_al_u313_o),
    .d(ulut_dat0[54]),
    .o(_al_u332_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u333 (
    .a(_al_u332_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[86]),
    .e(ulut_dat0[70]),
    .o(uctl_unic[6]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u334 (
    .a(\usjs/n21 ),
    .b(\usjs/n25 [0]),
    .c(unsjsjis[6]),
    .o(_al_u334_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C)*~(A)*~(D)+(E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C)*A*~(D)+~((E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C))*A*D+(E*~(B)*~(C)+E*B*~(C)+~(E)*B*C+E*B*C)*A*D)"),
    .INIT(32'haacfaac0))
    _al_u335 (
    .a(uctl_unic[6]),
    .b(_al_u334_o),
    .c(uctl_err_ktn_lutinv),
    .d(uctl_lat_unic_lutinv),
    .e(unsjunic[6]),
    .o(\uuni/n3 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u336 (
    .a(\uuni/n3 [6]),
    .b(_al_u289_o),
    .c(bdatw[6]),
    .o(\uuni/n4 [6]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u337 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[37]),
    .d(ulut_dat0[21]),
    .e(ulut_dat0[5]),
    .o(_al_u337_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u338 (
    .a(_al_u305_o),
    .b(ulut_dat0[85]),
    .c(ulut_dat0[69]),
    .o(_al_u338_o));
  AL_MAP_LUT5 #(
    .EQN("((B*~(~E*A))*~(C)*~(D)+(B*~(~E*A))*C*~(D)+~((B*~(~E*A)))*C*D+(B*~(~E*A))*C*D)"),
    .INIT(32'hf0ccf044))
    _al_u339 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u337_o),
    .c(_al_u338_o),
    .d(_al_u313_o),
    .e(ulut_dat0[53]),
    .o(uctl_unic[5]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u34 (
    .a(bcmdr),
    .b(bcs_unsj_n),
    .o(\uctl/n24 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(A)*~(C)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*~(C)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*A*C+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*C)"),
    .INIT(32'h505c535f))
    _al_u340 (
    .a(uctl_unic[5]),
    .b(uctl_err_ktn_lutinv),
    .c(uctl_lat_unic_lutinv),
    .d(unsjsjis[5]),
    .e(unsjunic[5]),
    .o(_al_u340_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u341 (
    .a(_al_u340_o),
    .b(_al_u289_o),
    .c(bdatw[5]),
    .o(\uuni/n4 [5]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u342 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[36]),
    .d(ulut_dat0[20]),
    .e(ulut_dat0[4]),
    .o(_al_u342_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u343 (
    .a(_al_u305_o),
    .b(ulut_dat0[84]),
    .c(ulut_dat0[68]),
    .o(_al_u343_o));
  AL_MAP_LUT5 #(
    .EQN("((B*~(~E*A))*~(C)*~(D)+(B*~(~E*A))*C*~(D)+~((B*~(~E*A)))*C*D+(B*~(~E*A))*C*D)"),
    .INIT(32'hf0ccf044))
    _al_u344 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u342_o),
    .c(_al_u343_o),
    .d(_al_u313_o),
    .e(ulut_dat0[52]),
    .o(uctl_unic[4]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(A)*~(C)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*~(C)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*A*C+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*C)"),
    .INIT(32'h505c535f))
    _al_u345 (
    .a(uctl_unic[4]),
    .b(uctl_err_ktn_lutinv),
    .c(uctl_lat_unic_lutinv),
    .d(unsjsjis[4]),
    .e(unsjunic[4]),
    .o(_al_u345_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u346 (
    .a(_al_u345_o),
    .b(_al_u289_o),
    .c(bdatw[4]),
    .o(\uuni/n4 [4]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u347 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[35]),
    .d(ulut_dat0[19]),
    .e(ulut_dat0[3]),
    .o(_al_u347_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u348 (
    .a(_al_u305_o),
    .b(ulut_dat0[83]),
    .c(ulut_dat0[67]),
    .o(_al_u348_o));
  AL_MAP_LUT5 #(
    .EQN("((B*~(~E*A))*~(C)*~(D)+(B*~(~E*A))*C*~(D)+~((B*~(~E*A)))*C*D+(B*~(~E*A))*C*D)"),
    .INIT(32'hf0ccf044))
    _al_u349 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u347_o),
    .c(_al_u348_o),
    .d(_al_u313_o),
    .e(ulut_dat0[51]),
    .o(uctl_unic[3]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u35 (
    .a(\uctl/n24 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\uctl/n26 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(A)*~(C)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*~(C)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*A*C+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*C)"),
    .INIT(32'h505c535f))
    _al_u350 (
    .a(uctl_unic[3]),
    .b(uctl_err_ktn_lutinv),
    .c(uctl_lat_unic_lutinv),
    .d(unsjsjis[3]),
    .e(unsjunic[3]),
    .o(_al_u350_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u351 (
    .a(_al_u350_o),
    .b(_al_u289_o),
    .c(bdatw[3]),
    .o(\uuni/n4 [3]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u352 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[34]),
    .d(ulut_dat0[18]),
    .e(ulut_dat0[2]),
    .o(_al_u352_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u353 (
    .a(_al_u305_o),
    .b(ulut_dat0[82]),
    .c(ulut_dat0[66]),
    .o(_al_u353_o));
  AL_MAP_LUT5 #(
    .EQN("((B*~(~E*A))*~(C)*~(D)+(B*~(~E*A))*C*~(D)+~((B*~(~E*A)))*C*D+(B*~(~E*A))*C*D)"),
    .INIT(32'hf0ccf044))
    _al_u354 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u352_o),
    .c(_al_u353_o),
    .d(_al_u313_o),
    .e(ulut_dat0[50]),
    .o(uctl_unic[2]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(A)*~(C)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*~(C)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*A*C+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*C)"),
    .INIT(32'h505c535f))
    _al_u355 (
    .a(uctl_unic[2]),
    .b(uctl_err_ktn_lutinv),
    .c(uctl_lat_unic_lutinv),
    .d(unsjsjis[2]),
    .e(unsjunic[2]),
    .o(_al_u355_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u356 (
    .a(_al_u355_o),
    .b(_al_u289_o),
    .c(bdatw[2]),
    .o(\uuni/n4 [2]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(C*~(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)))"),
    .INIT(32'h55451505))
    _al_u357 (
    .a(_al_u313_o),
    .b(_al_u305_o),
    .c(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .d(ulut_dat0[31]),
    .e(ulut_dat0[15]),
    .o(_al_u357_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(A*(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)))"),
    .INIT(32'h5070d0f0))
    _al_u358 (
    .a(_al_u313_o),
    .b(_al_u305_o),
    .c(uctl_lat_unic_lutinv),
    .d(ulut_dat0[95]),
    .e(ulut_dat0[79]),
    .o(_al_u358_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(E*~((C*B))*~(A)+E*(C*B)*~(A)+~(E)*(C*B)*A+E*(C*B)*A))"),
    .INIT(32'h002a007f))
    _al_u359 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [9]),
    .d(uctl_lat_unic_lutinv),
    .e(unsjunic[15]),
    .o(_al_u359_o));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u36 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[10]),
    .d(unsjsjis[10]),
    .o(_al_u36_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))"),
    .INIT(16'h0123))
    _al_u360 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[63]),
    .d(ulut_dat0[47]),
    .o(_al_u360_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(B*~(~D*A)))"),
    .INIT(16'h030b))
    _al_u361 (
    .a(_al_u357_o),
    .b(_al_u358_o),
    .c(_al_u359_o),
    .d(_al_u360_o),
    .o(\uuni/n3 [15]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u362 (
    .a(\uuni/n3 [15]),
    .b(_al_u289_o),
    .c(bdatw[15]),
    .o(\uuni/n4 [15]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u363 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[46]),
    .d(ulut_dat0[30]),
    .e(ulut_dat0[14]),
    .o(_al_u363_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u364 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u363_o),
    .c(_al_u313_o),
    .d(ulut_dat0[62]),
    .o(_al_u364_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u365 (
    .a(_al_u364_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[94]),
    .e(ulut_dat0[78]),
    .o(uctl_unic[14]));
  AL_MAP_LUT5 #(
    .EQN("(~D*(E*~((C*B))*~(A)+E*(C*B)*~(A)+~(E)*(C*B)*A+E*(C*B)*A))"),
    .INIT(32'h00d50080))
    _al_u366 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [8]),
    .d(uctl_lat_unic_lutinv),
    .e(unsjunic[14]),
    .o(_al_u366_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(D*A))*~(E)*~(C)+~(~B*~(D*A))*E*~(C)+~(~(~B*~(D*A)))*E*C+~(~B*~(D*A))*E*C)"),
    .INIT(32'hfefc0e0c))
    _al_u367 (
    .a(uctl_unic[14]),
    .b(_al_u366_o),
    .c(_al_u289_o),
    .d(uctl_lat_unic_lutinv),
    .e(bdatw[14]),
    .o(\uuni/n4 [14]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u368 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[45]),
    .d(ulut_dat0[29]),
    .e(ulut_dat0[13]),
    .o(_al_u368_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u369 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u368_o),
    .c(_al_u313_o),
    .d(ulut_dat0[61]),
    .o(_al_u369_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u37 (
    .a(_al_u36_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[10]),
    .o(bdatr[10]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)))"),
    .INIT(32'h11155155))
    _al_u370 (
    .a(_al_u369_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[93]),
    .e(ulut_dat0[77]),
    .o(_al_u370_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*B))*~(A)+D*(C*B)*~(A)+~(D)*(C*B)*A+D*(C*B)*A)"),
    .INIT(16'h2a7f))
    _al_u371 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [7]),
    .d(unsjunic[13]),
    .o(_al_u371_o));
  AL_MAP_LUT5 #(
    .EQN("(~(B*~(A)*~(D)+B*A*~(D)+~(B)*A*D+B*A*D)*~(E)*~(C)+~(B*~(A)*~(D)+B*A*~(D)+~(B)*A*D+B*A*D)*E*~(C)+~(~(B*~(A)*~(D)+B*A*~(D)+~(B)*A*D+B*A*D))*E*C+~(B*~(A)*~(D)+B*A*~(D)+~(B)*A*D+B*A*D)*E*C)"),
    .INIT(32'hf5f30503))
    _al_u372 (
    .a(_al_u370_o),
    .b(_al_u371_o),
    .c(_al_u289_o),
    .d(uctl_lat_unic_lutinv),
    .e(bdatw[13]),
    .o(\uuni/n4 [13]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u373 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[44]),
    .d(ulut_dat0[28]),
    .e(ulut_dat0[12]),
    .o(_al_u373_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u374 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u373_o),
    .c(_al_u313_o),
    .d(ulut_dat0[60]),
    .o(_al_u374_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u375 (
    .a(_al_u374_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[92]),
    .e(ulut_dat0[76]),
    .o(uctl_unic[12]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*B))*~(A)+D*(C*B)*~(A)+~(D)*(C*B)*A+D*(C*B)*A)"),
    .INIT(16'h2a7f))
    _al_u376 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [6]),
    .d(unsjunic[12]),
    .o(_al_u376_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u377 (
    .a(uctl_unic[12]),
    .b(_al_u376_o),
    .c(_al_u289_o),
    .d(uctl_lat_unic_lutinv),
    .e(bdatw[12]),
    .o(\uuni/n4 [12]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u378 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[43]),
    .d(ulut_dat0[27]),
    .e(ulut_dat0[11]),
    .o(_al_u378_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u379 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u378_o),
    .c(_al_u313_o),
    .d(ulut_dat0[59]),
    .o(_al_u379_o));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u38 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[11]),
    .d(unsjsjis[11]),
    .o(_al_u38_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u380 (
    .a(_al_u379_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[91]),
    .e(ulut_dat0[75]),
    .o(uctl_unic[11]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((C*B))*~(A)+D*(C*B)*~(A)+~(D)*(C*B)*A+D*(C*B)*A)"),
    .INIT(16'h2a7f))
    _al_u381 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [5]),
    .d(unsjunic[11]),
    .o(_al_u381_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u382 (
    .a(uctl_unic[11]),
    .b(_al_u381_o),
    .c(_al_u289_o),
    .d(uctl_lat_unic_lutinv),
    .e(bdatw[11]),
    .o(\uuni/n4 [11]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u383 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[42]),
    .d(ulut_dat0[26]),
    .e(ulut_dat0[10]),
    .o(_al_u383_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*B*~(~D*A))"),
    .INIT(16'h0c04))
    _al_u384 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u383_o),
    .c(_al_u313_o),
    .d(ulut_dat0[58]),
    .o(_al_u384_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee2aea2))
    _al_u385 (
    .a(_al_u384_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[90]),
    .e(ulut_dat0[74]),
    .o(uctl_unic[10]));
  AL_MAP_LUT5 #(
    .EQN("(~D*(E*~((C*B))*~(A)+E*(C*B)*~(A)+~(E)*(C*B)*A+E*(C*B)*A))"),
    .INIT(32'h00d50080))
    _al_u386 (
    .a(uctl_err_ktn_lutinv),
    .b(\usjs/n21 ),
    .c(\usjs/n25 [4]),
    .d(uctl_lat_unic_lutinv),
    .e(unsjunic[10]),
    .o(_al_u386_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(D*A))*~(E)*~(C)+~(~B*~(D*A))*E*~(C)+~(~(~B*~(D*A)))*E*C+~(~B*~(D*A))*E*C)"),
    .INIT(32'hfefc0e0c))
    _al_u387 (
    .a(uctl_unic[10]),
    .b(_al_u386_o),
    .c(_al_u289_o),
    .d(uctl_lat_unic_lutinv),
    .e(bdatw[10]),
    .o(\uuni/n4 [10]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u388 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[33]),
    .d(ulut_dat0[17]),
    .e(ulut_dat0[1]),
    .o(_al_u388_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*A))"),
    .INIT(8'hc4))
    _al_u389 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u388_o),
    .c(ulut_dat0[49]),
    .o(_al_u389_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u39 (
    .a(_al_u38_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[11]),
    .o(bdatr[11]));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(B)+A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)+~(A)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B+A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B)"),
    .INIT(32'h111dd1dd))
    _al_u390 (
    .a(_al_u389_o),
    .b(_al_u313_o),
    .c(_al_u305_o),
    .d(ulut_dat0[81]),
    .e(ulut_dat0[65]),
    .o(_al_u390_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(A)*~(C)+~(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*~(C)+~(~(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*A*C+~(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*C)"),
    .INIT(32'h5f535c50))
    _al_u391 (
    .a(_al_u390_o),
    .b(uctl_err_ktn_lutinv),
    .c(uctl_lat_unic_lutinv),
    .d(unsjsjis[1]),
    .e(unsjunic[1]),
    .o(_al_u391_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u392 (
    .a(_al_u391_o),
    .b(_al_u289_o),
    .c(bdatw[1]),
    .o(\uuni/n4 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfdb97531))
    _al_u393 (
    .a(_al_u305_o),
    .b(\uctl/eq3/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(ulut_dat0[32]),
    .d(ulut_dat0[16]),
    .e(ulut_dat0[0]),
    .o(_al_u393_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u394 (
    .a(_al_u305_o),
    .b(ulut_dat0[80]),
    .c(ulut_dat0[64]),
    .o(_al_u394_o));
  AL_MAP_LUT5 #(
    .EQN("((B*~(~E*A))*~(C)*~(D)+(B*~(~E*A))*C*~(D)+~((B*~(~E*A)))*C*D+(B*~(~E*A))*C*D)"),
    .INIT(32'hf0ccf044))
    _al_u395 (
    .a(\uctl/n5_lutinv ),
    .b(_al_u393_o),
    .c(_al_u394_o),
    .d(_al_u313_o),
    .e(ulut_dat0[48]),
    .o(uctl_unic[0]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(A)*~(C)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*~(C)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*A*C+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*A*C)"),
    .INIT(32'h505c535f))
    _al_u396 (
    .a(uctl_unic[0]),
    .b(uctl_err_ktn_lutinv),
    .c(uctl_lat_unic_lutinv),
    .d(unsjsjis[0]),
    .e(unsjunic[0]),
    .o(_al_u396_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u397 (
    .a(_al_u396_o),
    .b(_al_u289_o),
    .c(bdatw[0]),
    .o(\uuni/n4 [0]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u398 (
    .a(_al_u264_o),
    .b(_al_u76_o),
    .c(uctl_err_ktn_lutinv),
    .o(_al_u398_o));
  AL_MAP_LUT4 #(
    .EQN("((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'hcac0))
    _al_u399 (
    .a(_al_u398_o),
    .b(\uktn/codk_2 [7]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[15]),
    .o(\uktn/n9 [15]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u40 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[12]),
    .d(unsjsjis[12]),
    .o(_al_u40_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u400 (
    .a(_al_u398_o),
    .b(\uktn/codk_2 [1]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[9]),
    .o(_al_u400_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u401 (
    .a(_al_u256_o),
    .b(\uctl/ufsm/stat [0]),
    .c(\uctl/ufsm/stat [1]),
    .d(\uctl/ufsm/stat [2]),
    .o(_al_u401_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u402 (
    .a(_al_u400_o),
    .b(_al_u401_o),
    .c(_al_u268_o),
    .o(\uktn/n10 [9]));
  AL_MAP_LUT5 #(
    .EQN("(~B*((E*A)*~(C)*~(D)+(E*A)*C*~(D)+~((E*A))*C*D+(E*A)*C*D))"),
    .INIT(32'h30223000))
    _al_u403 (
    .a(_al_u398_o),
    .b(_al_u401_o),
    .c(\uktn/codk_2 [0]),
    .d(uctl_cvt_kutn_lutinv),
    .e(unsjkutn[8]),
    .o(_al_u403_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u404 (
    .a(_al_u403_o),
    .b(\usjs/n4 [1]),
    .o(\uktn/n10 [8]));
  AL_MAP_LUT5 #(
    .EQN("(~C*((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h0c0a0c00))
    _al_u405 (
    .a(_al_u398_o),
    .b(\uktn/codt_4 [7]),
    .c(_al_u401_o),
    .d(uctl_cvt_kutn_lutinv),
    .e(unsjkutn[7]),
    .o(\uktn/n10 [7]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u406 (
    .a(_al_u398_o),
    .b(\uktn/codt_4 [6]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[6]),
    .o(_al_u406_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u407 (
    .a(n1[5]),
    .b(_al_u406_o),
    .c(_al_u401_o),
    .o(\uktn/n10 [6]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u408 (
    .a(_al_u398_o),
    .b(\uktn/codt_4 [5]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[5]),
    .o(_al_u408_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u409 (
    .a(n1[4]),
    .b(_al_u408_o),
    .c(_al_u401_o),
    .o(\uktn/n10 [5]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u41 (
    .a(_al_u40_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[12]),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u410 (
    .a(_al_u398_o),
    .b(\uktn/codt_4 [4]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[4]),
    .o(_al_u410_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u411 (
    .a(n1[3]),
    .b(_al_u410_o),
    .c(_al_u401_o),
    .o(\uktn/n10 [4]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u412 (
    .a(_al_u398_o),
    .b(\uktn/codt_4 [3]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[3]),
    .o(_al_u412_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u413 (
    .a(n1[2]),
    .b(_al_u412_o),
    .c(_al_u401_o),
    .o(\uktn/n10 [3]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u414 (
    .a(_al_u398_o),
    .b(\uktn/codt_4 [2]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[2]),
    .o(_al_u414_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u415 (
    .a(n1[1]),
    .b(_al_u414_o),
    .c(_al_u401_o),
    .o(\uktn/n10 [2]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u416 (
    .a(_al_u398_o),
    .b(\uktn/codk_2 [6]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[14]),
    .o(_al_u416_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u417 (
    .a(_al_u416_o),
    .b(_al_u401_o),
    .c(_al_u277_o),
    .o(\uktn/n10 [14]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u418 (
    .a(_al_u398_o),
    .b(\uktn/codk_2 [5]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[13]),
    .o(_al_u418_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u419 (
    .a(_al_u418_o),
    .b(_al_u401_o),
    .c(_al_u279_o),
    .o(\uktn/n10 [13]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u42 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[13]),
    .d(unsjsjis[13]),
    .o(_al_u42_o));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u420 (
    .a(_al_u398_o),
    .b(\uktn/codk_2 [4]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[12]),
    .o(_al_u420_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u421 (
    .a(_al_u420_o),
    .b(_al_u401_o),
    .c(_al_u281_o),
    .o(\uktn/n10 [12]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u422 (
    .a(_al_u398_o),
    .b(\uktn/codk_2 [3]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[11]),
    .o(_al_u422_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u423 (
    .a(_al_u422_o),
    .b(_al_u401_o),
    .c(_al_u283_o),
    .o(\uktn/n10 [11]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u424 (
    .a(_al_u398_o),
    .b(\uktn/codk_2 [2]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[10]),
    .o(_al_u424_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u425 (
    .a(_al_u424_o),
    .b(_al_u401_o),
    .c(_al_u285_o),
    .o(\uktn/n10 [10]));
  AL_MAP_LUT4 #(
    .EQN("~((D*A)*~(B)*~(C)+(D*A)*B*~(C)+~((D*A))*B*C+(D*A)*B*C)"),
    .INIT(16'h353f))
    _al_u426 (
    .a(_al_u398_o),
    .b(\uktn/codt_4 [1]),
    .c(uctl_cvt_kutn_lutinv),
    .d(unsjkutn[1]),
    .o(_al_u426_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u427 (
    .a(n1[0]),
    .b(_al_u426_o),
    .c(_al_u401_o),
    .o(\uktn/n10 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~B*((E*A)*~(D)*~(C)+(E*A)*D*~(C)+~((E*A))*D*C+(E*A)*D*C))"),
    .INIT(32'h32023000))
    _al_u428 (
    .a(_al_u398_o),
    .b(_al_u401_o),
    .c(uctl_cvt_kutn_lutinv),
    .d(\uktn/codt_4 [0]),
    .e(unsjkutn[0]),
    .o(_al_u428_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u429 (
    .a(_al_u428_o),
    .b(uctl_kutn[0]),
    .o(\uktn/n10 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u43 (
    .a(_al_u42_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[13]),
    .o(bdatr[13]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf000a3a3))
    _al_u430 (
    .a(_al_u292_o),
    .b(_al_u296_o),
    .c(\uctl/ufsm/stat [0]),
    .d(\uctl/ufsm/stat [1]),
    .e(\uctl/ufsm/stat [2]),
    .o(\uctl/ufsm/uctl_busy_t ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u431 (
    .a(_al_u268_o),
    .b(\uctl/uctl_adr [4]),
    .c(_al_u281_o),
    .d(_al_u283_o),
    .e(_al_u285_o),
    .o(_al_u431_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u432 (
    .a(_al_u431_o),
    .b(_al_u277_o),
    .c(_al_u279_o),
    .o(_al_u432_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u433 (
    .a(\usjs/cods_4 [9]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[9]),
    .o(_al_u433_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u434 (
    .a(_al_u433_o),
    .b(_al_u295_o),
    .c(bdatw[9]),
    .o(\usjs/n10 [9]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u435 (
    .a(\usjs/cods_4 [8]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[8]),
    .o(_al_u435_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u436 (
    .a(_al_u435_o),
    .b(_al_u295_o),
    .c(bdatw[8]),
    .o(\usjs/n10 [8]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~A*~((C*B))*~(D)+~A*(C*B)*~(D)+~(~A)*(C*B)*D+~A*(C*B)*D))"),
    .INIT(32'h3faa0000))
    _al_u437 (
    .a(\usjs/cods_4 [7]),
    .b(n1[5]),
    .c(n1[4]),
    .d(_al_u432_o),
    .e(_al_u401_o),
    .o(_al_u437_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~A*~(D*~B))*~(E)*~(C)+~(~A*~(D*~B))*E*~(C)+~(~(~A*~(D*~B)))*E*C+~(~A*~(D*~B))*E*C)"),
    .INIT(32'hfbfa0b0a))
    _al_u438 (
    .a(_al_u437_o),
    .b(_al_u401_o),
    .c(_al_u295_o),
    .d(unsjsjis[7]),
    .e(bdatw[7]),
    .o(\usjs/n10 [7]));
  AL_MAP_LUT5 #(
    .EQN("(E*(A*~((C@B))*~(D)+A*(C@B)*~(D)+~(A)*(C@B)*D+A*(C@B)*D))"),
    .INIT(32'h3caa0000))
    _al_u439 (
    .a(\usjs/cods_4 [6]),
    .b(n1[5]),
    .c(n1[4]),
    .d(_al_u432_o),
    .e(_al_u401_o),
    .o(_al_u439_o));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u44 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[14]),
    .d(unsjsjis[14]),
    .o(_al_u44_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~A*~(D*~B))*~(E)*~(C)+~(~A*~(D*~B))*E*~(C)+~(~(~A*~(D*~B)))*E*C+~(~A*~(D*~B))*E*C)"),
    .INIT(32'hfbfa0b0a))
    _al_u440 (
    .a(_al_u439_o),
    .b(_al_u401_o),
    .c(_al_u295_o),
    .d(unsjsjis[6]),
    .e(bdatw[6]),
    .o(\usjs/n10 [6]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u441 (
    .a(_al_u268_o),
    .b(\uctl/uctl_adr [4]),
    .c(_al_u277_o),
    .d(_al_u279_o),
    .o(_al_u441_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u442 (
    .a(_al_u441_o),
    .b(_al_u281_o),
    .c(_al_u283_o),
    .d(_al_u285_o),
    .o(_al_u442_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u443 (
    .a(\usjs/cods_4 [5]),
    .b(n1[4]),
    .c(_al_u442_o),
    .o(_al_u443_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*~(E)*~(C)+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*~(C)+~(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B))*E*C+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*C)"),
    .INIT(32'hf7f40704))
    _al_u444 (
    .a(_al_u443_o),
    .b(_al_u266_o),
    .c(_al_u295_o),
    .d(unsjsjis[5]),
    .e(bdatw[5]),
    .o(\usjs/n10 [5]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u445 (
    .a(\usjs/cods_4 [4]),
    .b(n1[3]),
    .c(_al_u442_o),
    .o(_al_u445_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*~(E)*~(C)+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*~(C)+~(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B))*E*C+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*C)"),
    .INIT(32'hf7f40704))
    _al_u446 (
    .a(_al_u445_o),
    .b(_al_u266_o),
    .c(_al_u295_o),
    .d(unsjsjis[4]),
    .e(bdatw[4]),
    .o(\usjs/n10 [4]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u447 (
    .a(\usjs/cods_4 [3]),
    .b(n1[2]),
    .c(_al_u442_o),
    .o(_al_u447_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*~(E)*~(C)+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*~(C)+~(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B))*E*C+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*C)"),
    .INIT(32'hf7f40704))
    _al_u448 (
    .a(_al_u447_o),
    .b(_al_u266_o),
    .c(_al_u295_o),
    .d(unsjsjis[3]),
    .e(bdatw[3]),
    .o(\usjs/n10 [3]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u449 (
    .a(\usjs/cods_4 [2]),
    .b(n1[1]),
    .c(_al_u442_o),
    .o(_al_u449_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u45 (
    .a(_al_u44_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[14]),
    .o(bdatr[14]));
  AL_MAP_LUT5 #(
    .EQN("(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*~(E)*~(C)+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*~(C)+~(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B))*E*C+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*C)"),
    .INIT(32'hf7f40704))
    _al_u450 (
    .a(_al_u449_o),
    .b(_al_u266_o),
    .c(_al_u295_o),
    .d(unsjsjis[2]),
    .e(bdatw[2]),
    .o(\usjs/n10 [2]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u451 (
    .a(\usjs/cods_4 [15]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[15]),
    .o(_al_u451_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u452 (
    .a(_al_u451_o),
    .b(_al_u295_o),
    .c(bdatw[15]),
    .o(\usjs/n10 [15]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u453 (
    .a(\usjs/cods_4 [14]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[14]),
    .o(_al_u453_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u454 (
    .a(_al_u453_o),
    .b(_al_u295_o),
    .c(bdatw[14]),
    .o(\usjs/n10 [14]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u455 (
    .a(\usjs/cods_4 [13]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[13]),
    .o(_al_u455_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u456 (
    .a(_al_u455_o),
    .b(_al_u295_o),
    .c(bdatw[13]),
    .o(\usjs/n10 [13]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u457 (
    .a(\usjs/cods_4 [12]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[12]),
    .o(_al_u457_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u458 (
    .a(_al_u457_o),
    .b(_al_u295_o),
    .c(bdatw[12]),
    .o(\usjs/n10 [12]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u459 (
    .a(\usjs/cods_4 [11]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[11]),
    .o(_al_u459_o));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u46 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[15]),
    .d(unsjsjis[15]),
    .o(_al_u46_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u460 (
    .a(_al_u459_o),
    .b(_al_u295_o),
    .c(bdatw[11]),
    .o(\usjs/n10 [11]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~((~B*A))*~(C)+D*(~B*A)*~(C)+~(D)*(~B*A)*C+D*(~B*A)*C)"),
    .INIT(16'hd0df))
    _al_u461 (
    .a(\usjs/cods_4 [10]),
    .b(_al_u432_o),
    .c(_al_u401_o),
    .d(unsjsjis[10]),
    .o(_al_u461_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u462 (
    .a(_al_u461_o),
    .b(_al_u295_o),
    .c(bdatw[10]),
    .o(\usjs/n10 [10]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u463 (
    .a(\usjs/cods_4 [1]),
    .b(n1[0]),
    .c(_al_u442_o),
    .o(_al_u463_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*~(E)*~(C)+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*~(C)+~(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B))*E*C+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*C)"),
    .INIT(32'hf7f40704))
    _al_u464 (
    .a(_al_u463_o),
    .b(_al_u266_o),
    .c(_al_u295_o),
    .d(unsjsjis[1]),
    .e(bdatw[1]),
    .o(\usjs/n10 [1]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u465 (
    .a(\usjs/cods_4 [0]),
    .b(_al_u442_o),
    .c(_al_u301_o),
    .o(_al_u465_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*~(E)*~(C)+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*~(C)+~(~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B))*E*C+~(~D*~(A)*~(B)+~D*A*~(B)+~(~D)*A*B+~D*A*B)*E*C)"),
    .INIT(32'hf7f40704))
    _al_u466 (
    .a(_al_u465_o),
    .b(_al_u266_o),
    .c(_al_u295_o),
    .d(unsjsjis[0]),
    .e(bdatw[0]),
    .o(\usjs/n10 [0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u467 (
    .a(\uktn/n2 ),
    .o(\uktn/n3 [1]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u468 (
    .a(\uctl/mux3_b0_sel_is_3_o ),
    .o(\uctl/n15 ));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u469 (
    .a(\usjs/n4 [1]),
    .o(\usjs/n4 [6]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u47 (
    .a(_al_u46_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[15]),
    .o(bdatr[15]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u48 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[2]),
    .d(unsjsjis[2]),
    .o(_al_u48_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u49 (
    .a(_al_u48_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[2]),
    .o(bdatr[2]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u50 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[3]),
    .d(unsjsjis[3]),
    .o(_al_u50_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u51 (
    .a(_al_u50_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[3]),
    .o(bdatr[3]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u52 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[4]),
    .d(unsjsjis[4]),
    .o(_al_u52_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u53 (
    .a(_al_u52_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[4]),
    .o(bdatr[4]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u54 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[5]),
    .d(unsjsjis[5]),
    .o(_al_u54_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u55 (
    .a(_al_u54_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[5]),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u56 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[6]),
    .d(unsjsjis[6]),
    .o(_al_u56_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u57 (
    .a(_al_u56_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[6]),
    .o(bdatr[6]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u58 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[8]),
    .d(unsjsjis[8]),
    .o(_al_u58_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u59 (
    .a(_al_u58_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[8]),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u60 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[9]),
    .d(unsjsjis[9]),
    .o(_al_u60_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h03010001))
    _al_u61 (
    .a(_al_u60_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[9]),
    .o(bdatr[9]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u62 (
    .a(\uctl/n24 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\uctl/n31 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u63 (
    .a(\uctl/n24 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\uctl/n28 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u64 (
    .a(\uctl/n24 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\uctl/n35 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u65 (
    .a(\uctl/ufsm/stat [0]),
    .b(\uctl/ufsm/stat [1]),
    .c(\uctl/ufsm/stat [2]),
    .o(\uctl/uctl_rom_rd_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u66 (
    .a(\uctl/uctl_rom_rd_lutinv ),
    .b(ulut_adr1[9]),
    .c(unsjkutn[13]),
    .o(ulut_adr0[9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u67 (
    .a(\uctl/uctl_rom_rd_lutinv ),
    .b(ulut_adr1[8]),
    .c(unsjkutn[12]),
    .o(ulut_adr0[8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u68 (
    .a(\uctl/uctl_rom_rd_lutinv ),
    .b(ulut_adr1[7]),
    .c(unsjkutn[11]),
    .o(ulut_adr0[7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u69 (
    .a(\uctl/uctl_rom_rd_lutinv ),
    .b(ulut_adr1[6]),
    .c(unsjkutn[10]),
    .o(ulut_adr0[6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u70 (
    .a(\uctl/uctl_rom_rd_lutinv ),
    .b(ulut_adr1[5]),
    .c(unsjkutn[9]),
    .o(ulut_adr0[5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u71 (
    .a(\uctl/uctl_rom_rd_lutinv ),
    .b(ulut_adr1[4]),
    .c(unsjkutn[8]),
    .o(ulut_adr0[4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u72 (
    .a(\uctl/uctl_rom_rd_lutinv ),
    .b(ulut_adr1[10]),
    .c(unsjkutn[14]),
    .o(ulut_adr0[10]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u73 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[0]),
    .d(unsjsjis[0]),
    .o(_al_u73_o));
  AL_MAP_LUT5 #(
    .EQN("(B*C*~((~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))+~(B)*~(C)*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)+B*C*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'hc3c1c0c1))
    _al_u74 (
    .a(_al_u73_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[0]),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u75 (
    .a(\usjs/n12 ),
    .b(\usjs/n13 ),
    .c(\usjs/n15 ),
    .d(\usjs/n16 ),
    .o(_al_u75_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(E*D)*~(C*B)))"),
    .INIT(32'h55404040))
    _al_u76 (
    .a(_al_u75_o),
    .b(\usjs/n18 ),
    .c(\usjs/n19 ),
    .d(\usjs/n21 ),
    .e(\usjs/n22 ),
    .o(_al_u76_o));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u77 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[1]),
    .d(unsjsjis[1]),
    .o(_al_u77_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'h3101))
    _al_u78 (
    .a(_al_u77_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjunic_rd ),
    .d(unsjunic[1]),
    .o(\uctl/n57 [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u79 (
    .a(_al_u76_o),
    .b(\uctl/n57 [1]),
    .c(\uctl/unsjctl_rd ),
    .o(bdatr[1]));
  AL_MAP_LUT4 #(
    .EQN("~((C*A)*~(D)*~(B)+(C*A)*D*~(B)+~((C*A))*D*B+(C*A)*D*B)"),
    .INIT(16'h13df))
    _al_u80 (
    .a(\uctl/unsjkutn_rd ),
    .b(\uctl/unsjsjis_rd ),
    .c(unsjkutn[7]),
    .d(unsjsjis[7]),
    .o(_al_u80_o));
  AL_MAP_LUT5 #(
    .EQN("~(~C*~(~B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)))"),
    .INIT(32'hf3f1f0f1))
    _al_u81 (
    .a(_al_u80_o),
    .b(\uctl/uctl_busy ),
    .c(\uctl/unsjctl_rd ),
    .d(\uctl/unsjunic_rd ),
    .e(unsjunic[7]),
    .o(bdatr[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u82 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .o(_al_u82_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~(C*B*A))"),
    .INIT(16'h007f))
    _al_u83 (
    .a(_al_u82_o),
    .b(unsjkutn[3]),
    .c(unsjkutn[4]),
    .d(unsjkutn[5]),
    .o(\uctl/mux1_b3/B5_1 ));
  AL_MAP_LUT4 #(
    .EQN("~((C*B)*~(A)*~(D)+(C*B)*A*~(D)+~((C*B))*A*D+(C*B)*A*D)"),
    .INIT(16'h553f))
    _al_u84 (
    .a(\uctl/mux1_b3/B5_1 ),
    .b(unsjkutn[4]),
    .c(unsjkutn[5]),
    .d(unsjkutn[6]),
    .o(_al_u84_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h74))
    _al_u85 (
    .a(_al_u84_o),
    .b(\uctl/uctl_rom_rd_lutinv ),
    .c(ulut_adr1[3]),
    .o(ulut_adr0[3]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff83f03f))
    _al_u86 (
    .a(_al_u82_o),
    .b(unsjkutn[3]),
    .c(unsjkutn[4]),
    .d(unsjkutn[5]),
    .e(unsjkutn[6]),
    .o(_al_u86_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h74))
    _al_u87 (
    .a(_al_u86_o),
    .b(\uctl/uctl_rom_rd_lutinv ),
    .c(ulut_adr1[2]),
    .o(ulut_adr0[2]));
  AL_MAP_LUT5 #(
    .EQN("(~E*(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D))"),
    .INIT(32'h00007c0f))
    _al_u88 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .c(unsjkutn[3]),
    .d(unsjkutn[4]),
    .e(unsjkutn[5]),
    .o(\uctl/mux1_b1/B5_1 ));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h71c7))
    _al_u89 (
    .a(unsjkutn[2]),
    .b(unsjkutn[3]),
    .c(unsjkutn[4]),
    .d(unsjkutn[5]),
    .o(_al_u89_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E))*~(C)+D*(~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E)*~(C)+~(D)*(~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E)*C+D*(~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E)*C)"),
    .INIT(32'hafa03f30))
    _al_u90 (
    .a(\uctl/mux1_b1/B5_1 ),
    .b(_al_u89_o),
    .c(\uctl/uctl_rom_rd_lutinv ),
    .d(ulut_adr1[1]),
    .e(unsjkutn[6]),
    .o(ulut_adr0[1]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hc71c71c7))
    _al_u91 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .c(unsjkutn[3]),
    .d(unsjkutn[4]),
    .e(unsjkutn[5]),
    .o(_al_u91_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*(A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+A*~(B)*C*D+~(A)*B*C*D))"),
    .INIT(32'h0000638e))
    _al_u92 (
    .a(unsjkutn[1]),
    .b(unsjkutn[2]),
    .c(unsjkutn[3]),
    .d(unsjkutn[4]),
    .e(unsjkutn[5]),
    .o(\uctl/mux1_b0/B5_1 ));
  AL_MAP_LUT4 #(
    .EQN("(C*(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))"),
    .INIT(16'hc050))
    _al_u93 (
    .a(_al_u91_o),
    .b(\uctl/mux1_b0/B5_1 ),
    .c(\uctl/uctl_rom_rd_lutinv ),
    .d(unsjkutn[6]),
    .o(ulut_adr0[0]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u94 (
    .a(unsjsjis[14]),
    .b(unsjsjis[15]),
    .c(unsjsjis[8]),
    .d(unsjsjis[9]),
    .o(_al_u94_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u95 (
    .a(_al_u94_o),
    .b(unsjsjis[10]),
    .c(unsjsjis[11]),
    .d(unsjsjis[12]),
    .e(unsjsjis[13]),
    .o(_al_u95_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*~A)"),
    .INIT(32'h00000010))
    _al_u96 (
    .a(_al_u76_o),
    .b(_al_u95_o),
    .c(\uctl/ufsm/stat [0]),
    .d(\uctl/ufsm/stat [1]),
    .e(\uctl/ufsm/stat [2]),
    .o(uctl_err_uni_lutinv));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u97 (
    .a(uctl_err_uni_lutinv),
    .b(rst_n),
    .o(\uuni/n1 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u98 (
    .a(unsjunic[0]),
    .b(unsjunic[1]),
    .c(unsjunic[10]),
    .d(unsjunic[11]),
    .o(_al_u98_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u99 (
    .a(_al_u98_o),
    .b(unsjunic[12]),
    .c(unsjunic[13]),
    .d(unsjunic[14]),
    .e(unsjunic[15]),
    .o(_al_u99_o));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u0  (
    .a(\uctl/uctl_kutn_l_1 [2]),
    .b(\uctl/uctl_adr [1]),
    .c(\u1/c0 ),
    .o({\u1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u1  (
    .a(1'b0),
    .b(\uctl/uctl_adr [2]),
    .c(\u1/c1 ),
    .o({\u1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u2  (
    .a(1'b0),
    .b(\uctl/uctl_adr [3]),
    .c(\u1/c2 ),
    .o({\u1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u1/ucin  (
    .a(1'b0),
    .o({\u1/c0 ,open_n2}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/ucout  (
    .c(\u1/c3 ),
    .o({open_n5,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u0  (
    .a(\uctl/uctl_adr [0]),
    .b(\uctl/uctl_kutn_l_1 [1]),
    .c(\u2/c0 ),
    .o({\u2/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u1  (
    .a(\uctl/uctl_adr [0]),
    .b(n0[0]),
    .c(\u2/c1 ),
    .o({\u2/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u2  (
    .a(\uctl/uctl_adr [1]),
    .b(n0[1]),
    .c(\u2/c2 ),
    .o({\u2/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u3  (
    .a(\uctl/uctl_adr [2]),
    .b(n0[2]),
    .c(\u2/c3 ),
    .o({\u2/c4 ,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u4  (
    .a(\uctl/uctl_adr [3]),
    .b(n0[3]),
    .c(\u2/c4 ),
    .o({\u2/c5 ,n1[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u2/ucin  (
    .a(1'b0),
    .o({\u2/c0 ,open_n8}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/ucout  (
    .c(\u2/c5 ),
    .o({open_n11,n1[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u0  (
    .a(ulut_adr1[1]),
    .b(1'b1),
    .c(\uctl/add0/c0 ),
    .o({\uctl/add0/c1 ,\uctl/n0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u1  (
    .a(ulut_adr1[2]),
    .b(1'b0),
    .c(\uctl/add0/c1 ),
    .o({\uctl/add0/c2 ,\uctl/n0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u2  (
    .a(ulut_adr1[3]),
    .b(1'b0),
    .c(\uctl/add0/c2 ),
    .o({\uctl/add0/c3 ,\uctl/n0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u3  (
    .a(ulut_adr1[4]),
    .b(1'b0),
    .c(\uctl/add0/c3 ),
    .o({\uctl/add0/c4 ,\uctl/n0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u4  (
    .a(ulut_adr1[5]),
    .b(1'b0),
    .c(\uctl/add0/c4 ),
    .o({\uctl/add0/c5 ,\uctl/n0 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u5  (
    .a(ulut_adr1[6]),
    .b(1'b0),
    .c(\uctl/add0/c5 ),
    .o({\uctl/add0/c6 ,\uctl/n0 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u6  (
    .a(ulut_adr1[7]),
    .b(1'b0),
    .c(\uctl/add0/c6 ),
    .o({\uctl/add0/c7 ,\uctl/n0 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u7  (
    .a(ulut_adr1[8]),
    .b(1'b0),
    .c(\uctl/add0/c7 ),
    .o({\uctl/add0/c8 ,\uctl/n0 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u8  (
    .a(ulut_adr1[9]),
    .b(1'b0),
    .c(\uctl/add0/c8 ),
    .o({\uctl/add0/c9 ,\uctl/n0 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \uctl/add0/u9  (
    .a(ulut_adr1[10]),
    .b(1'b0),
    .c(\uctl/add0/c9 ),
    .o({open_n12,\uctl/n0 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \uctl/add0/ucin  (
    .a(1'b0),
    .o({\uctl/add0/c0 ,open_n15}));
  reg_sr_as_w1 \uctl/reg0_b0  (
    .clk(clk),
    .d(ulut_adr0[0]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [0]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b1  (
    .clk(clk),
    .d(ulut_adr0[1]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [1]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b10  (
    .clk(clk),
    .d(ulut_adr0[10]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [10]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b2  (
    .clk(clk),
    .d(ulut_adr0[2]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [2]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b3  (
    .clk(clk),
    .d(ulut_adr0[3]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [3]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b4  (
    .clk(clk),
    .d(ulut_adr0[4]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [4]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b5  (
    .clk(clk),
    .d(ulut_adr0[5]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [5]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b6  (
    .clk(clk),
    .d(ulut_adr0[6]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [6]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b7  (
    .clk(clk),
    .d(ulut_adr0[7]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [7]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b8  (
    .clk(clk),
    .d(ulut_adr0[8]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [8]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg0_b9  (
    .clk(clk),
    .d(ulut_adr0[9]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr0 [9]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [0]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b1  (
    .clk(clk),
    .d(ulut_adr1[1]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [1]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b10  (
    .clk(clk),
    .d(ulut_adr1[10]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [10]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b2  (
    .clk(clk),
    .d(ulut_adr1[2]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [2]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b3  (
    .clk(clk),
    .d(ulut_adr1[3]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [3]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b4  (
    .clk(clk),
    .d(ulut_adr1[4]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [4]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b5  (
    .clk(clk),
    .d(ulut_adr1[5]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [5]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b6  (
    .clk(clk),
    .d(ulut_adr1[6]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [6]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b7  (
    .clk(clk),
    .d(ulut_adr1[7]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [7]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b8  (
    .clk(clk),
    .d(ulut_adr1[8]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [8]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg1_b9  (
    .clk(clk),
    .d(ulut_adr1[9]),
    .en(1'b1),
    .reset(\uctl/n15 ),
    .set(1'b0),
    .q(\uctl/uctl_adr1 [9]));  // rtl/unisji.v(390)
  reg_sr_as_w1 \uctl/reg2_b1  (
    .clk(clk),
    .d(\uctl/n0 [0]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[1]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b10  (
    .clk(clk),
    .d(\uctl/n0 [9]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[10]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b2  (
    .clk(clk),
    .d(\uctl/n0 [1]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[2]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b3  (
    .clk(clk),
    .d(\uctl/n0 [2]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[3]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b4  (
    .clk(clk),
    .d(\uctl/n0 [3]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[4]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b5  (
    .clk(clk),
    .d(\uctl/n0 [4]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[5]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b6  (
    .clk(clk),
    .d(\uctl/n0 [5]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[6]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b7  (
    .clk(clk),
    .d(\uctl/n0 [6]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[7]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b8  (
    .clk(clk),
    .d(\uctl/n0 [7]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[8]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/reg2_b9  (
    .clk(clk),
    .d(\uctl/n0 [8]),
    .en(1'b1),
    .reset(~\uctl/mux3_b0_sel_is_3_o ),
    .set(1'b0),
    .q(ulut_adr1[9]));  // rtl/unisji.v(359)
  reg_sr_as_w1 \uctl/ufsm/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\uctl/ufsm/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\uctl/ufsm/stat [0]));  // rtl/unsj_fsm.v(102)
  reg_sr_as_w1 \uctl/ufsm/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\uctl/ufsm/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\uctl/ufsm/stat [1]));  // rtl/unsj_fsm.v(102)
  reg_sr_as_w1 \uctl/ufsm/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\uctl/ufsm/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\uctl/ufsm/stat [2]));  // rtl/unsj_fsm.v(102)
  reg_sr_as_w1 \uctl/ufsm/uctl_busy_reg  (
    .clk(clk),
    .d(\uctl/ufsm/uctl_busy_t ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_busy ));  // rtl/unsj_fsm.v(94)
  reg_sr_as_w1 \uctl/unsjctl_rd_reg  (
    .clk(clk),
    .d(\uctl/n26 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/unsjctl_rd ));  // rtl/unisji.v(429)
  reg_sr_as_w1 \uctl/unsjkutn_rd_reg  (
    .clk(clk),
    .d(\uctl/n35 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/unsjkutn_rd ));  // rtl/unisji.v(429)
  reg_sr_as_w1 \uctl/unsjsjis_rd_reg  (
    .clk(clk),
    .d(\uctl/n31 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/unsjsjis_rd ));  // rtl/unisji.v(429)
  reg_sr_as_w1 \uctl/unsjunic_rd_reg  (
    .clk(clk),
    .d(\uctl/n28 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/unsjunic_rd ));  // rtl/unisji.v(429)
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_0  (
    .a(1'b0),
    .b(unsjsjis[0]),
    .c(\uktn/lt0_c0 ),
    .o({\uktn/lt0_c1 ,open_n16}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_1  (
    .a(1'b0),
    .b(unsjsjis[1]),
    .c(\uktn/lt0_c1 ),
    .o({\uktn/lt0_c2 ,open_n17}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_10  (
    .a(1'b0),
    .b(unsjsjis[10]),
    .c(\uktn/lt0_c10 ),
    .o({\uktn/lt0_c11 ,open_n18}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_11  (
    .a(1'b0),
    .b(unsjsjis[11]),
    .c(\uktn/lt0_c11 ),
    .o({\uktn/lt0_c12 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_12  (
    .a(1'b0),
    .b(unsjsjis[12]),
    .c(\uktn/lt0_c12 ),
    .o({\uktn/lt0_c13 ,open_n20}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_13  (
    .a(1'b1),
    .b(unsjsjis[13]),
    .c(\uktn/lt0_c13 ),
    .o({\uktn/lt0_c14 ,open_n21}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_14  (
    .a(1'b1),
    .b(unsjsjis[14]),
    .c(\uktn/lt0_c14 ),
    .o({\uktn/lt0_c15 ,open_n22}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_15  (
    .a(1'b1),
    .b(unsjsjis[15]),
    .c(\uktn/lt0_c15 ),
    .o({\uktn/lt0_c16 ,open_n23}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_2  (
    .a(1'b0),
    .b(unsjsjis[2]),
    .c(\uktn/lt0_c2 ),
    .o({\uktn/lt0_c3 ,open_n24}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_3  (
    .a(1'b0),
    .b(unsjsjis[3]),
    .c(\uktn/lt0_c3 ),
    .o({\uktn/lt0_c4 ,open_n25}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_4  (
    .a(1'b0),
    .b(unsjsjis[4]),
    .c(\uktn/lt0_c4 ),
    .o({\uktn/lt0_c5 ,open_n26}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_5  (
    .a(1'b0),
    .b(unsjsjis[5]),
    .c(\uktn/lt0_c5 ),
    .o({\uktn/lt0_c6 ,open_n27}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_6  (
    .a(1'b0),
    .b(unsjsjis[6]),
    .c(\uktn/lt0_c6 ),
    .o({\uktn/lt0_c7 ,open_n28}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_7  (
    .a(1'b0),
    .b(unsjsjis[7]),
    .c(\uktn/lt0_c7 ),
    .o({\uktn/lt0_c8 ,open_n29}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_8  (
    .a(1'b0),
    .b(unsjsjis[8]),
    .c(\uktn/lt0_c8 ),
    .o({\uktn/lt0_c9 ,open_n30}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_9  (
    .a(1'b0),
    .b(unsjsjis[9]),
    .c(\uktn/lt0_c9 ),
    .o({\uktn/lt0_c10 ,open_n31}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \uktn/lt0_cin  (
    .a(1'b1),
    .o({\uktn/lt0_c0 ,open_n34}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\uktn/lt0_c16 ),
    .o({open_n35,\uktn/n0 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_0  (
    .a(1'b1),
    .b(unsjsjis[0]),
    .c(\uktn/lt1_c0 ),
    .o({\uktn/lt1_c1 ,open_n36}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_1  (
    .a(1'b1),
    .b(unsjsjis[1]),
    .c(\uktn/lt1_c1 ),
    .o({\uktn/lt1_c2 ,open_n37}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_2  (
    .a(1'b1),
    .b(unsjsjis[2]),
    .c(\uktn/lt1_c2 ),
    .o({\uktn/lt1_c3 ,open_n38}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_3  (
    .a(1'b1),
    .b(unsjsjis[3]),
    .c(\uktn/lt1_c3 ),
    .o({\uktn/lt1_c4 ,open_n39}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_4  (
    .a(1'b1),
    .b(unsjsjis[4]),
    .c(\uktn/lt1_c4 ),
    .o({\uktn/lt1_c5 ,open_n40}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_5  (
    .a(1'b1),
    .b(unsjsjis[5]),
    .c(\uktn/lt1_c5 ),
    .o({\uktn/lt1_c6 ,open_n41}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_6  (
    .a(1'b1),
    .b(unsjsjis[6]),
    .c(\uktn/lt1_c6 ),
    .o({\uktn/lt1_c7 ,open_n42}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_7  (
    .a(1'b0),
    .b(unsjsjis[7]),
    .c(\uktn/lt1_c7 ),
    .o({\uktn/lt1_c8 ,open_n43}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \uktn/lt1_cin  (
    .a(1'b1),
    .o({\uktn/lt1_c0 ,open_n46}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\uktn/lt1_c8 ),
    .o({open_n47,\uktn/n1 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_0  (
    .a(1'b0),
    .b(\uktn/codt_3 [0]),
    .c(\uktn/lt2_2_c0 ),
    .o({\uktn/lt2_2_c1 ,open_n48}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_1  (
    .a(1'b1),
    .b(\uktn/codt_3 [1]),
    .c(\uktn/lt2_2_c1 ),
    .o({\uktn/lt2_2_c2 ,open_n49}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_2  (
    .a(1'b1),
    .b(\uktn/codt_3 [2]),
    .c(\uktn/lt2_2_c2 ),
    .o({\uktn/lt2_2_c3 ,open_n50}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_3  (
    .a(1'b1),
    .b(\uktn/codt_3 [3]),
    .c(\uktn/lt2_2_c3 ),
    .o({\uktn/lt2_2_c4 ,open_n51}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_4  (
    .a(1'b1),
    .b(\uktn/codt_3 [4]),
    .c(\uktn/lt2_2_c4 ),
    .o({\uktn/lt2_2_c5 ,open_n52}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_5  (
    .a(1'b0),
    .b(\uktn/codt_3 [5]),
    .c(\uktn/lt2_2_c5 ),
    .o({\uktn/lt2_2_c6 ,open_n53}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_6  (
    .a(1'b1),
    .b(\uktn/codt_3 [6]),
    .c(\uktn/lt2_2_c6 ),
    .o({\uktn/lt2_2_c7 ,open_n54}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_7  (
    .a(1'b0),
    .b(\uktn/codt_3 [7]),
    .c(\uktn/lt2_2_c7 ),
    .o({\uktn/lt2_2_c8 ,open_n55}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_8  (
    .a(1'b0),
    .b(\uktn/codt_3 [15]),
    .c(\uktn/lt2_2_c8 ),
    .o({\uktn/lt2_2_c9 ,open_n56}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \uktn/lt2_2_cin  (
    .a(1'b0),
    .o({\uktn/lt2_2_c0 ,open_n59}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \uktn/lt2_2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\uktn/lt2_2_c9 ),
    .o({open_n60,\uktn/n2 }));
  reg_sr_as_w1 \uktn/reg0_b0  (
    .clk(clk),
    .d(\uktn/n10 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[0]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b1  (
    .clk(clk),
    .d(\uktn/n10 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[1]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b10  (
    .clk(clk),
    .d(\uktn/n10 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[10]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b11  (
    .clk(clk),
    .d(\uktn/n10 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[11]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b12  (
    .clk(clk),
    .d(\uktn/n10 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[12]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b13  (
    .clk(clk),
    .d(\uktn/n10 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[13]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b14  (
    .clk(clk),
    .d(\uktn/n10 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[14]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b15  (
    .clk(clk),
    .d(\uktn/n9 [15]),
    .en(1'b1),
    .reset(~\uktn/mux4_b15_sel_is_1_o ),
    .set(1'b0),
    .q(unsjkutn[15]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b2  (
    .clk(clk),
    .d(\uktn/n10 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[2]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b3  (
    .clk(clk),
    .d(\uktn/n10 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[3]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b4  (
    .clk(clk),
    .d(\uktn/n10 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[4]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b5  (
    .clk(clk),
    .d(\uktn/n10 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[5]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b6  (
    .clk(clk),
    .d(\uktn/n10 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[6]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b7  (
    .clk(clk),
    .d(\uktn/n10 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[7]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b8  (
    .clk(clk),
    .d(\uktn/n10 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[8]));  // rtl/unisji.v(644)
  reg_sr_as_w1 \uktn/reg0_b9  (
    .clk(clk),
    .d(\uktn/n10 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(unsjkutn[9]));  // rtl/unisji.v(644)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u0  (
    .a(unsjsjis[0]),
    .b(\uktn/n1 ),
    .c(\uktn/sub1/c0 ),
    .o({\uktn/sub1/c1 ,\uktn/codt_2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u1  (
    .a(unsjsjis[1]),
    .b(1'b0),
    .c(\uktn/sub1/c1 ),
    .o({\uktn/sub1/c2 ,\uktn/codt_2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u10  (
    .a(unsjsjis[10]),
    .b(1'b0),
    .c(\uktn/sub1/c10 ),
    .o({\uktn/sub1/c11 ,\uktn/codt_2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u11  (
    .a(unsjsjis[11]),
    .b(1'b0),
    .c(\uktn/sub1/c11 ),
    .o({\uktn/sub1/c12 ,\uktn/codt_2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u12  (
    .a(unsjsjis[12]),
    .b(1'b0),
    .c(\uktn/sub1/c12 ),
    .o({\uktn/sub1/c13 ,\uktn/codt_2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u13  (
    .a(unsjsjis[13]),
    .b(1'b0),
    .c(\uktn/sub1/c13 ),
    .o({\uktn/sub1/c14 ,\uktn/codt_2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u14  (
    .a(n2),
    .b(1'b0),
    .c(\uktn/sub1/c14 ),
    .o({open_n61,\uktn/codt_2 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u2  (
    .a(unsjsjis[2]),
    .b(1'b0),
    .c(\uktn/sub1/c2 ),
    .o({\uktn/sub1/c3 ,\uktn/codt_2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u3  (
    .a(unsjsjis[3]),
    .b(1'b0),
    .c(\uktn/sub1/c3 ),
    .o({\uktn/sub1/c4 ,\uktn/codt_2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u4  (
    .a(unsjsjis[4]),
    .b(1'b0),
    .c(\uktn/sub1/c4 ),
    .o({\uktn/sub1/c5 ,\uktn/codt_2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u5  (
    .a(unsjsjis[5]),
    .b(1'b0),
    .c(\uktn/sub1/c5 ),
    .o({\uktn/sub1/c6 ,\uktn/codt_2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u6  (
    .a(unsjsjis[6]),
    .b(1'b0),
    .c(\uktn/sub1/c6 ),
    .o({\uktn/sub1/c7 ,\uktn/codt_2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u7  (
    .a(unsjsjis[7]),
    .b(1'b0),
    .c(\uktn/sub1/c7 ),
    .o({\uktn/sub1/c8 ,\uktn/codt_2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u8  (
    .a(unsjsjis[8]),
    .b(1'b0),
    .c(\uktn/sub1/c8 ),
    .o({\uktn/sub1/c9 ,\uktn/codt_2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub1/u9  (
    .a(unsjsjis[9]),
    .b(1'b0),
    .c(\uktn/sub1/c9 ),
    .o({\uktn/sub1/c10 ,\uktn/codt_2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \uktn/sub1/ucin  (
    .a(1'b0),
    .o({\uktn/sub1/c0 ,open_n64}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u0  (
    .a(\uktn/codt_2 [0]),
    .b(1'b1),
    .c(\uktn/sub2/c0 ),
    .o({\uktn/sub2/c1 ,\uktn/codt_3 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u1  (
    .a(\uktn/codt_2 [1]),
    .b(1'b1),
    .c(\uktn/sub2/c1 ),
    .o({\uktn/sub2/c2 ,\uktn/codt_3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u2  (
    .a(\uktn/codt_2 [2]),
    .b(1'b1),
    .c(\uktn/sub2/c2 ),
    .o({\uktn/sub2/c3 ,\uktn/codt_3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u3  (
    .a(\uktn/codt_2 [3]),
    .b(1'b1),
    .c(\uktn/sub2/c3 ),
    .o({\uktn/sub2/c4 ,\uktn/codt_3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u4  (
    .a(\uktn/codt_2 [4]),
    .b(1'b1),
    .c(\uktn/sub2/c4 ),
    .o({\uktn/sub2/c5 ,\uktn/codt_3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u5  (
    .a(\uktn/codt_2 [5]),
    .b(1'b1),
    .c(\uktn/sub2/c5 ),
    .o({\uktn/sub2/c6 ,\uktn/codt_3 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u6  (
    .a(\uktn/codt_2 [6]),
    .b(1'b0),
    .c(\uktn/sub2/c6 ),
    .o({\uktn/sub2/c7 ,\uktn/codt_3 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/u7  (
    .a(\uktn/codt_2 [7]),
    .b(1'b0),
    .c(\uktn/sub2/c7 ),
    .o({\uktn/sub2/c8 ,\uktn/codt_3 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \uktn/sub2/ucin  (
    .a(1'b0),
    .o({\uktn/sub2/c0 ,open_n67}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub2/ucout  (
    .c(\uktn/sub2/c8 ),
    .o({open_n70,\uktn/codt_3 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u0  (
    .a(\uktn/codt_3 [0]),
    .b(1'b1),
    .c(\uktn/sub3/c0 ),
    .o({\uktn/sub3/c1 ,\uktn/codt_4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u1  (
    .a(\uktn/codt_3 [1]),
    .b(\uktn/n2 ),
    .c(\uktn/sub3/c1 ),
    .o({\uktn/sub3/c2 ,\uktn/codt_4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u2  (
    .a(\uktn/codt_3 [2]),
    .b(\uktn/n2 ),
    .c(\uktn/sub3/c2 ),
    .o({\uktn/sub3/c3 ,\uktn/codt_4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u3  (
    .a(\uktn/codt_3 [3]),
    .b(\uktn/n2 ),
    .c(\uktn/sub3/c3 ),
    .o({\uktn/sub3/c4 ,\uktn/codt_4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u4  (
    .a(\uktn/codt_3 [4]),
    .b(\uktn/n2 ),
    .c(\uktn/sub3/c4 ),
    .o({\uktn/sub3/c5 ,\uktn/codt_4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u5  (
    .a(\uktn/codt_3 [5]),
    .b(1'b0),
    .c(\uktn/sub3/c5 ),
    .o({\uktn/sub3/c6 ,\uktn/codt_4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u6  (
    .a(\uktn/codt_3 [6]),
    .b(\uktn/n2 ),
    .c(\uktn/sub3/c6 ),
    .o({\uktn/sub3/c7 ,\uktn/codt_4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub3/u7  (
    .a(\uktn/codt_3 [7]),
    .b(1'b0),
    .c(\uktn/sub3/c7 ),
    .o({open_n71,\uktn/codt_4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \uktn/sub3/ucin  (
    .a(1'b0),
    .o({\uktn/sub3/c0 ,open_n74}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u0  (
    .a(1'b0),
    .b(\uktn/n2 ),
    .c(\uktn/sub4/c0 ),
    .o({\uktn/sub4/c1 ,\uktn/codk_2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u1  (
    .a(\uktn/codt_2 [8]),
    .b(\uktn/n3 [1]),
    .c(\uktn/sub4/c1 ),
    .o({\uktn/sub4/c2 ,\uktn/codk_2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u2  (
    .a(\uktn/codt_2 [9]),
    .b(1'b0),
    .c(\uktn/sub4/c2 ),
    .o({\uktn/sub4/c3 ,\uktn/codk_2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u3  (
    .a(\uktn/codt_2 [10]),
    .b(1'b0),
    .c(\uktn/sub4/c3 ),
    .o({\uktn/sub4/c4 ,\uktn/codk_2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u4  (
    .a(\uktn/codt_2 [11]),
    .b(1'b0),
    .c(\uktn/sub4/c4 ),
    .o({\uktn/sub4/c5 ,\uktn/codk_2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u5  (
    .a(\uktn/codt_2 [12]),
    .b(1'b0),
    .c(\uktn/sub4/c5 ),
    .o({\uktn/sub4/c6 ,\uktn/codk_2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u6  (
    .a(\uktn/codt_2 [13]),
    .b(1'b0),
    .c(\uktn/sub4/c6 ),
    .o({\uktn/sub4/c7 ,\uktn/codk_2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \uktn/sub4/u7  (
    .a(\uktn/codt_2 [14]),
    .b(1'b0),
    .c(\uktn/sub4/c7 ),
    .o({open_n75,\uktn/codk_2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \uktn/sub4/ucin  (
    .a(1'b0),
    .o({\uktn/sub4/c0 ,open_n78}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u0  (
    .a(uctl_kutn[0]),
    .b(\usjs/n4 [0]),
    .c(\usjs/add0_usjs/add3/c0 ),
    .o({\usjs/add0_usjs/add3/c1 ,\usjs/cods_4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u1  (
    .a(uctl_kutn[1]),
    .b(\usjs/n4 [1]),
    .c(\usjs/add0_usjs/add3/c1 ),
    .o({\usjs/add0_usjs/add3/c2 ,\usjs/cods_4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u10  (
    .a(1'b0),
    .b(uctl_kutn[11]),
    .c(\usjs/add0_usjs/add3/c10 ),
    .o({\usjs/add0_usjs/add3/c11 ,\usjs/cods_4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u11  (
    .a(1'b0),
    .b(uctl_kutn[12]),
    .c(\usjs/add0_usjs/add3/c11 ),
    .o({\usjs/add0_usjs/add3/c12 ,\usjs/cods_4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u12  (
    .a(1'b0),
    .b(uctl_kutn[13]),
    .c(\usjs/add0_usjs/add3/c12 ),
    .o({\usjs/add0_usjs/add3/c13 ,\usjs/cods_4 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u13  (
    .a(1'b0),
    .b(uctl_kutn[14]),
    .c(\usjs/add0_usjs/add3/c13 ),
    .o({\usjs/add0_usjs/add3/c14 ,\usjs/cods_4 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u14  (
    .a(1'b0),
    .b(\usjs/n1 ),
    .c(\usjs/add0_usjs/add3/c14 ),
    .o({\usjs/add0_usjs/add3/c15 ,\usjs/cods_4 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u15  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/add0_usjs/add3/c15 ),
    .o({open_n79,\usjs/cods_4 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u2  (
    .a(uctl_kutn[2]),
    .b(\usjs/n4 [1]),
    .c(\usjs/add0_usjs/add3/c2 ),
    .o({\usjs/add0_usjs/add3/c3 ,\usjs/cods_4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u3  (
    .a(uctl_kutn[3]),
    .b(\usjs/n4 [1]),
    .c(\usjs/add0_usjs/add3/c3 ),
    .o({\usjs/add0_usjs/add3/c4 ,\usjs/cods_4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u4  (
    .a(uctl_kutn[4]),
    .b(\usjs/n4 [1]),
    .c(\usjs/add0_usjs/add3/c4 ),
    .o({\usjs/add0_usjs/add3/c5 ,\usjs/cods_4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u5  (
    .a(uctl_kutn[5]),
    .b(1'b0),
    .c(\usjs/add0_usjs/add3/c5 ),
    .o({\usjs/add0_usjs/add3/c6 ,\usjs/cods_4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u6  (
    .a(uctl_kutn[6]),
    .b(\usjs/n4 [6]),
    .c(\usjs/add0_usjs/add3/c6 ),
    .o({\usjs/add0_usjs/add3/c7 ,\usjs/cods_4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u7  (
    .a(1'b0),
    .b(\usjs/n4 [1]),
    .c(\usjs/add0_usjs/add3/c7 ),
    .o({\usjs/add0_usjs/add3/c8 ,\usjs/cods_4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u8  (
    .a(1'b1),
    .b(uctl_kutn[9]),
    .c(\usjs/add0_usjs/add3/c8 ),
    .o({\usjs/add0_usjs/add3/c9 ,\usjs/cods_4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add0_usjs/add3/u9  (
    .a(1'b0),
    .b(uctl_kutn[10]),
    .c(\usjs/add0_usjs/add3/c9 ),
    .o({\usjs/add0_usjs/add3/c10 ,\usjs/cods_4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \usjs/add0_usjs/add3/ucin  (
    .a(1'b0),
    .o({\usjs/add0_usjs/add3/c0 ,open_n82}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u0  (
    .a(unsjsjis[6]),
    .b(1'b1),
    .c(\usjs/add5/c0 ),
    .o({\usjs/add5/c1 ,\usjs/n25 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u1  (
    .a(unsjsjis[7]),
    .b(1'b1),
    .c(\usjs/add5/c1 ),
    .o({\usjs/add5/c2 ,\usjs/n25 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u2  (
    .a(unsjsjis[8]),
    .b(1'b0),
    .c(\usjs/add5/c2 ),
    .o({\usjs/add5/c3 ,\usjs/n25 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u3  (
    .a(unsjsjis[9]),
    .b(1'b1),
    .c(\usjs/add5/c3 ),
    .o({\usjs/add5/c4 ,\usjs/n25 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u4  (
    .a(unsjsjis[10]),
    .b(1'b1),
    .c(\usjs/add5/c4 ),
    .o({\usjs/add5/c5 ,\usjs/n25 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u5  (
    .a(unsjsjis[11]),
    .b(1'b1),
    .c(\usjs/add5/c5 ),
    .o({\usjs/add5/c6 ,\usjs/n25 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u6  (
    .a(unsjsjis[12]),
    .b(1'b1),
    .c(\usjs/add5/c6 ),
    .o({\usjs/add5/c7 ,\usjs/n25 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u7  (
    .a(unsjsjis[13]),
    .b(1'b1),
    .c(\usjs/add5/c7 ),
    .o({\usjs/add5/c8 ,\usjs/n25 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u8  (
    .a(unsjsjis[14]),
    .b(1'b1),
    .c(\usjs/add5/c8 ),
    .o({\usjs/add5/c9 ,\usjs/n25 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \usjs/add5/u9  (
    .a(unsjsjis[15]),
    .b(1'b1),
    .c(\usjs/add5/c9 ),
    .o({open_n83,\usjs/n25 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \usjs/add5/ucin  (
    .a(1'b0),
    .o({\usjs/add5/c0 ,open_n86}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_0  (
    .a(1'b0),
    .b(\usjs/n4 [1]),
    .c(\usjs/lt0_2_c0 ),
    .o({\usjs/lt0_2_c1 ,open_n87}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_1  (
    .a(1'b1),
    .b(uctl_kutn[9]),
    .c(\usjs/lt0_2_c1 ),
    .o({\usjs/lt0_2_c2 ,open_n88}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_2  (
    .a(1'b1),
    .b(uctl_kutn[10]),
    .c(\usjs/lt0_2_c2 ),
    .o({\usjs/lt0_2_c3 ,open_n89}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_3  (
    .a(1'b1),
    .b(uctl_kutn[11]),
    .c(\usjs/lt0_2_c3 ),
    .o({\usjs/lt0_2_c4 ,open_n90}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_4  (
    .a(1'b1),
    .b(uctl_kutn[12]),
    .c(\usjs/lt0_2_c4 ),
    .o({\usjs/lt0_2_c5 ,open_n91}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_5  (
    .a(1'b1),
    .b(uctl_kutn[13]),
    .c(\usjs/lt0_2_c5 ),
    .o({\usjs/lt0_2_c6 ,open_n92}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_6  (
    .a(1'b0),
    .b(uctl_kutn[14]),
    .c(\usjs/lt0_2_c6 ),
    .o({\usjs/lt0_2_c7 ,open_n93}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt0_2_cin  (
    .a(1'b1),
    .o({\usjs/lt0_2_c0 ,open_n96}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt0_2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt0_2_c7 ),
    .o({open_n97,\usjs/n1 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_0  (
    .a(uctl_kutn[0]),
    .b(1'b0),
    .c(\usjs/lt1_c0 ),
    .o({\usjs/lt1_c1 ,open_n98}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_1  (
    .a(uctl_kutn[1]),
    .b(1'b1),
    .c(\usjs/lt1_c1 ),
    .o({\usjs/lt1_c2 ,open_n99}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_2  (
    .a(uctl_kutn[2]),
    .b(1'b1),
    .c(\usjs/lt1_c2 ),
    .o({\usjs/lt1_c3 ,open_n100}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_3  (
    .a(uctl_kutn[3]),
    .b(1'b1),
    .c(\usjs/lt1_c3 ),
    .o({\usjs/lt1_c4 ,open_n101}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_4  (
    .a(uctl_kutn[4]),
    .b(1'b1),
    .c(\usjs/lt1_c4 ),
    .o({\usjs/lt1_c5 ,open_n102}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_5  (
    .a(uctl_kutn[5]),
    .b(1'b1),
    .c(\usjs/lt1_c5 ),
    .o({\usjs/lt1_c6 ,open_n103}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_6  (
    .a(uctl_kutn[6]),
    .b(1'b0),
    .c(\usjs/lt1_c6 ),
    .o({\usjs/lt1_c7 ,open_n104}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_7  (
    .a(1'b0),
    .b(1'b0),
    .c(\usjs/lt1_c7 ),
    .o({\usjs/lt1_c8 ,open_n105}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt1_cin  (
    .a(1'b1),
    .o({\usjs/lt1_c0 ,open_n108}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt1_c8 ),
    .o({open_n109,\usjs/n2 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_0  (
    .a(1'b1),
    .b(unsjsjis[8]),
    .c(\usjs/lt2_c0 ),
    .o({\usjs/lt2_c1 ,open_n110}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_1  (
    .a(1'b0),
    .b(unsjsjis[9]),
    .c(\usjs/lt2_c1 ),
    .o({\usjs/lt2_c2 ,open_n111}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_2  (
    .a(1'b0),
    .b(unsjsjis[10]),
    .c(\usjs/lt2_c2 ),
    .o({\usjs/lt2_c3 ,open_n112}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_3  (
    .a(1'b0),
    .b(unsjsjis[11]),
    .c(\usjs/lt2_c3 ),
    .o({\usjs/lt2_c4 ,open_n113}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_4  (
    .a(1'b0),
    .b(unsjsjis[12]),
    .c(\usjs/lt2_c4 ),
    .o({\usjs/lt2_c5 ,open_n114}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_5  (
    .a(1'b0),
    .b(unsjsjis[13]),
    .c(\usjs/lt2_c5 ),
    .o({\usjs/lt2_c6 ,open_n115}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_6  (
    .a(1'b0),
    .b(unsjsjis[14]),
    .c(\usjs/lt2_c6 ),
    .o({\usjs/lt2_c7 ,open_n116}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_7  (
    .a(1'b1),
    .b(unsjsjis[15]),
    .c(\usjs/lt2_c7 ),
    .o({\usjs/lt2_c8 ,open_n117}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt2_cin  (
    .a(1'b1),
    .o({\usjs/lt2_c0 ,open_n120}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt2_c8 ),
    .o({open_n121,\usjs/n12 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_0  (
    .a(unsjsjis[8]),
    .b(1'b1),
    .c(\usjs/lt3_c0 ),
    .o({\usjs/lt3_c1 ,open_n122}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_1  (
    .a(unsjsjis[9]),
    .b(1'b1),
    .c(\usjs/lt3_c1 ),
    .o({\usjs/lt3_c2 ,open_n123}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_2  (
    .a(unsjsjis[10]),
    .b(1'b1),
    .c(\usjs/lt3_c2 ),
    .o({\usjs/lt3_c3 ,open_n124}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_3  (
    .a(unsjsjis[11]),
    .b(1'b1),
    .c(\usjs/lt3_c3 ),
    .o({\usjs/lt3_c4 ,open_n125}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_4  (
    .a(unsjsjis[12]),
    .b(1'b1),
    .c(\usjs/lt3_c4 ),
    .o({\usjs/lt3_c5 ,open_n126}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_5  (
    .a(unsjsjis[13]),
    .b(1'b0),
    .c(\usjs/lt3_c5 ),
    .o({\usjs/lt3_c6 ,open_n127}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_6  (
    .a(unsjsjis[14]),
    .b(1'b0),
    .c(\usjs/lt3_c6 ),
    .o({\usjs/lt3_c7 ,open_n128}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_7  (
    .a(unsjsjis[15]),
    .b(1'b1),
    .c(\usjs/lt3_c7 ),
    .o({\usjs/lt3_c8 ,open_n129}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt3_cin  (
    .a(1'b1),
    .o({\usjs/lt3_c0 ,open_n132}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt3_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt3_c8 ),
    .o({open_n133,\usjs/n13 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_0  (
    .a(1'b0),
    .b(unsjsjis[8]),
    .c(\usjs/lt4_c0 ),
    .o({\usjs/lt4_c1 ,open_n134}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_1  (
    .a(1'b0),
    .b(unsjsjis[9]),
    .c(\usjs/lt4_c1 ),
    .o({\usjs/lt4_c2 ,open_n135}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_2  (
    .a(1'b0),
    .b(unsjsjis[10]),
    .c(\usjs/lt4_c2 ),
    .o({\usjs/lt4_c3 ,open_n136}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_3  (
    .a(1'b0),
    .b(unsjsjis[11]),
    .c(\usjs/lt4_c3 ),
    .o({\usjs/lt4_c4 ,open_n137}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_4  (
    .a(1'b0),
    .b(unsjsjis[12]),
    .c(\usjs/lt4_c4 ),
    .o({\usjs/lt4_c5 ,open_n138}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_5  (
    .a(1'b1),
    .b(unsjsjis[13]),
    .c(\usjs/lt4_c5 ),
    .o({\usjs/lt4_c6 ,open_n139}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_6  (
    .a(1'b1),
    .b(unsjsjis[14]),
    .c(\usjs/lt4_c6 ),
    .o({\usjs/lt4_c7 ,open_n140}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_7  (
    .a(1'b1),
    .b(unsjsjis[15]),
    .c(\usjs/lt4_c7 ),
    .o({\usjs/lt4_c8 ,open_n141}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt4_cin  (
    .a(1'b1),
    .o({\usjs/lt4_c0 ,open_n144}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt4_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt4_c8 ),
    .o({open_n145,\usjs/n15 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_0  (
    .a(unsjsjis[8]),
    .b(1'b0),
    .c(\usjs/lt5_c0 ),
    .o({\usjs/lt5_c1 ,open_n146}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_1  (
    .a(unsjsjis[9]),
    .b(1'b1),
    .c(\usjs/lt5_c1 ),
    .o({\usjs/lt5_c2 ,open_n147}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_2  (
    .a(unsjsjis[10]),
    .b(1'b0),
    .c(\usjs/lt5_c2 ),
    .o({\usjs/lt5_c3 ,open_n148}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_3  (
    .a(unsjsjis[11]),
    .b(1'b1),
    .c(\usjs/lt5_c3 ),
    .o({\usjs/lt5_c4 ,open_n149}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_4  (
    .a(unsjsjis[12]),
    .b(1'b0),
    .c(\usjs/lt5_c4 ),
    .o({\usjs/lt5_c5 ,open_n150}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_5  (
    .a(unsjsjis[13]),
    .b(1'b1),
    .c(\usjs/lt5_c5 ),
    .o({\usjs/lt5_c6 ,open_n151}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_6  (
    .a(unsjsjis[14]),
    .b(1'b1),
    .c(\usjs/lt5_c6 ),
    .o({\usjs/lt5_c7 ,open_n152}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_7  (
    .a(unsjsjis[15]),
    .b(1'b1),
    .c(\usjs/lt5_c7 ),
    .o({\usjs/lt5_c8 ,open_n153}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt5_cin  (
    .a(1'b1),
    .o({\usjs/lt5_c0 ,open_n156}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt5_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt5_c8 ),
    .o({open_n157,\usjs/n16 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_0  (
    .a(1'b0),
    .b(unsjsjis[0]),
    .c(\usjs/lt6_c0 ),
    .o({\usjs/lt6_c1 ,open_n158}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_1  (
    .a(1'b0),
    .b(unsjsjis[1]),
    .c(\usjs/lt6_c1 ),
    .o({\usjs/lt6_c2 ,open_n159}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_2  (
    .a(1'b0),
    .b(unsjsjis[2]),
    .c(\usjs/lt6_c2 ),
    .o({\usjs/lt6_c3 ,open_n160}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_3  (
    .a(1'b0),
    .b(unsjsjis[3]),
    .c(\usjs/lt6_c3 ),
    .o({\usjs/lt6_c4 ,open_n161}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_4  (
    .a(1'b0),
    .b(unsjsjis[4]),
    .c(\usjs/lt6_c4 ),
    .o({\usjs/lt6_c5 ,open_n162}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_5  (
    .a(1'b0),
    .b(unsjsjis[5]),
    .c(\usjs/lt6_c5 ),
    .o({\usjs/lt6_c6 ,open_n163}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_6  (
    .a(1'b1),
    .b(unsjsjis[6]),
    .c(\usjs/lt6_c6 ),
    .o({\usjs/lt6_c7 ,open_n164}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_7  (
    .a(1'b0),
    .b(unsjsjis[7]),
    .c(\usjs/lt6_c7 ),
    .o({\usjs/lt6_c8 ,open_n165}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt6_cin  (
    .a(1'b1),
    .o({\usjs/lt6_c0 ,open_n168}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt6_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt6_c8 ),
    .o({open_n169,\usjs/n18 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_0  (
    .a(unsjsjis[0]),
    .b(1'b0),
    .c(\usjs/lt7_c0 ),
    .o({\usjs/lt7_c1 ,open_n170}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_1  (
    .a(unsjsjis[1]),
    .b(1'b1),
    .c(\usjs/lt7_c1 ),
    .o({\usjs/lt7_c2 ,open_n171}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_2  (
    .a(unsjsjis[2]),
    .b(1'b1),
    .c(\usjs/lt7_c2 ),
    .o({\usjs/lt7_c3 ,open_n172}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_3  (
    .a(unsjsjis[3]),
    .b(1'b1),
    .c(\usjs/lt7_c3 ),
    .o({\usjs/lt7_c4 ,open_n173}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_4  (
    .a(unsjsjis[4]),
    .b(1'b1),
    .c(\usjs/lt7_c4 ),
    .o({\usjs/lt7_c5 ,open_n174}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_5  (
    .a(unsjsjis[5]),
    .b(1'b1),
    .c(\usjs/lt7_c5 ),
    .o({\usjs/lt7_c6 ,open_n175}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_6  (
    .a(unsjsjis[6]),
    .b(1'b1),
    .c(\usjs/lt7_c6 ),
    .o({\usjs/lt7_c7 ,open_n176}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_7  (
    .a(unsjsjis[7]),
    .b(1'b0),
    .c(\usjs/lt7_c7 ),
    .o({\usjs/lt7_c8 ,open_n177}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt7_cin  (
    .a(1'b1),
    .o({\usjs/lt7_c0 ,open_n180}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt7_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt7_c8 ),
    .o({open_n181,\usjs/n19 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_0  (
    .a(1'b0),
    .b(unsjsjis[0]),
    .c(\usjs/lt8_c0 ),
    .o({\usjs/lt8_c1 ,open_n182}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_1  (
    .a(1'b0),
    .b(unsjsjis[1]),
    .c(\usjs/lt8_c1 ),
    .o({\usjs/lt8_c2 ,open_n183}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_2  (
    .a(1'b0),
    .b(unsjsjis[2]),
    .c(\usjs/lt8_c2 ),
    .o({\usjs/lt8_c3 ,open_n184}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_3  (
    .a(1'b0),
    .b(unsjsjis[3]),
    .c(\usjs/lt8_c3 ),
    .o({\usjs/lt8_c4 ,open_n185}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_4  (
    .a(1'b0),
    .b(unsjsjis[4]),
    .c(\usjs/lt8_c4 ),
    .o({\usjs/lt8_c5 ,open_n186}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_5  (
    .a(1'b0),
    .b(unsjsjis[5]),
    .c(\usjs/lt8_c5 ),
    .o({\usjs/lt8_c6 ,open_n187}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_6  (
    .a(1'b0),
    .b(unsjsjis[6]),
    .c(\usjs/lt8_c6 ),
    .o({\usjs/lt8_c7 ,open_n188}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_7  (
    .a(1'b1),
    .b(unsjsjis[7]),
    .c(\usjs/lt8_c7 ),
    .o({\usjs/lt8_c8 ,open_n189}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt8_cin  (
    .a(1'b1),
    .o({\usjs/lt8_c0 ,open_n192}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt8_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt8_c8 ),
    .o({open_n193,\usjs/n21 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_0  (
    .a(unsjsjis[0]),
    .b(1'b0),
    .c(\usjs/lt9_c0 ),
    .o({\usjs/lt9_c1 ,open_n194}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_1  (
    .a(unsjsjis[1]),
    .b(1'b0),
    .c(\usjs/lt9_c1 ),
    .o({\usjs/lt9_c2 ,open_n195}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_2  (
    .a(unsjsjis[2]),
    .b(1'b1),
    .c(\usjs/lt9_c2 ),
    .o({\usjs/lt9_c3 ,open_n196}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_3  (
    .a(unsjsjis[3]),
    .b(1'b1),
    .c(\usjs/lt9_c3 ),
    .o({\usjs/lt9_c4 ,open_n197}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_4  (
    .a(unsjsjis[4]),
    .b(1'b1),
    .c(\usjs/lt9_c4 ),
    .o({\usjs/lt9_c5 ,open_n198}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_5  (
    .a(unsjsjis[5]),
    .b(1'b1),
    .c(\usjs/lt9_c5 ),
    .o({\usjs/lt9_c6 ,open_n199}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_6  (
    .a(unsjsjis[6]),
    .b(1'b1),
    .c(\usjs/lt9_c6 ),
    .o({\usjs/lt9_c7 ,open_n200}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_7  (
    .a(unsjsjis[7]),
    .b(1'b1),
    .c(\usjs/lt9_c7 ),
    .o({\usjs/lt9_c8 ,open_n201}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \usjs/lt9_cin  (
    .a(1'b1),
    .o({\usjs/lt9_c0 ,open_n204}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \usjs/lt9_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\usjs/lt9_c8 ),
    .o({open_n205,\usjs/n22 }));
  reg_sr_as_w1 \usjs/reg0_b0  (
    .clk(clk),
    .d(\usjs/n10 [0]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[0]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b1  (
    .clk(clk),
    .d(\usjs/n10 [1]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[1]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b10  (
    .clk(clk),
    .d(\usjs/n10 [10]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[10]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b11  (
    .clk(clk),
    .d(\usjs/n10 [11]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[11]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b12  (
    .clk(clk),
    .d(\usjs/n10 [12]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[12]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b13  (
    .clk(clk),
    .d(\usjs/n10 [13]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[13]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b14  (
    .clk(clk),
    .d(\usjs/n10 [14]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[14]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b15  (
    .clk(clk),
    .d(\usjs/n10 [15]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[15]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b2  (
    .clk(clk),
    .d(\usjs/n10 [2]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[2]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b3  (
    .clk(clk),
    .d(\usjs/n10 [3]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[3]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b4  (
    .clk(clk),
    .d(\usjs/n10 [4]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[4]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b5  (
    .clk(clk),
    .d(\usjs/n10 [5]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[5]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b6  (
    .clk(clk),
    .d(\usjs/n10 [6]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[6]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b7  (
    .clk(clk),
    .d(\usjs/n10 [7]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[7]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b8  (
    .clk(clk),
    .d(\usjs/n10 [8]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[8]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \usjs/reg0_b9  (
    .clk(clk),
    .d(\usjs/n10 [9]),
    .en(1'b1),
    .reset(\usjs/n8 ),
    .set(1'b0),
    .q(unsjsjis[9]));  // rtl/unisji.v(568)
  reg_sr_as_w1 \uuni/reg0_b0  (
    .clk(clk),
    .d(\uuni/n4 [0]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[0]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b1  (
    .clk(clk),
    .d(\uuni/n4 [1]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[1]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b10  (
    .clk(clk),
    .d(\uuni/n4 [10]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[10]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b11  (
    .clk(clk),
    .d(\uuni/n4 [11]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[11]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b12  (
    .clk(clk),
    .d(\uuni/n4 [12]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[12]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b13  (
    .clk(clk),
    .d(\uuni/n4 [13]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[13]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b14  (
    .clk(clk),
    .d(\uuni/n4 [14]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[14]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b15  (
    .clk(clk),
    .d(\uuni/n4 [15]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[15]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b2  (
    .clk(clk),
    .d(\uuni/n4 [2]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[2]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b3  (
    .clk(clk),
    .d(\uuni/n4 [3]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[3]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b4  (
    .clk(clk),
    .d(\uuni/n4 [4]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[4]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b5  (
    .clk(clk),
    .d(\uuni/n4 [5]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[5]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b6  (
    .clk(clk),
    .d(\uuni/n4 [6]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[6]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b7  (
    .clk(clk),
    .d(\uuni/n4 [7]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[7]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b8  (
    .clk(clk),
    .d(\uuni/n4 [8]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[8]));  // rtl/unisji.v(508)
  reg_sr_as_w1 \uuni/reg0_b9  (
    .clk(clk),
    .d(\uuni/n4 [9]),
    .en(1'b1),
    .reset(\uuni/n1 ),
    .set(1'b0),
    .q(unsjunic[9]));  // rtl/unisji.v(508)

endmodule 

