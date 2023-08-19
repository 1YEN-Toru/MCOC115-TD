
`timescale 1ns / 1ps
module halfpu  // rtl/halfpu.v(1)
  (
  abus,
  bbus,
  ccmd,
  clk,
  hfpu_dsp_c,
  rst_n,
  cbus,
  crdy,
  hfpu_dsp_a,
  hfpu_dsp_b
  );
//
//	Half precision FPU (Half precision floating point unit)
//		(c) 2021	1YEN Toru
//
//
//	2021/07/10	ver.1.02
//		ccmd=HCMP: half compare command
//
//	2021/06/12	ver.1.00
//		half: <1b sign> <5b exponent> <10b fraction>
//		half=pow (-1,<1b sign>)*0x1.<10b fraction>*pow (2,<5b exponent>-15)
//		non normalized number was not supported. it is treated as zero.
//		INF and NaN are available
//

  input [15:0] abus;  // rtl/halfpu.v(18)
  input [15:0] bbus;  // rtl/halfpu.v(19)
  input [4:0] ccmd;  // rtl/halfpu.v(17)
  input clk;  // rtl/halfpu.v(14)
  input [21:0] hfpu_dsp_c;  // rtl/halfpu.v(16)
  input rst_n;  // rtl/halfpu.v(15)
  output [15:0] cbus;  // rtl/halfpu.v(23)
  output crdy;  // rtl/halfpu.v(20)
  output [10:0] hfpu_dsp_a;  // rtl/halfpu.v(21)
  output [10:0] hfpu_dsp_b;  // rtl/halfpu.v(22)

  wire [15:0] \hadd/hlfa_f ;  // rtl/hfpu_hadd.v(22)
  wire [15:0] \hadd/hlfb_f ;  // rtl/hfpu_hadd.v(30)
  wire [15:0] \hadd/hlfc_f_t ;  // rtl/hfpu_hadd.v(61)
  wire [15:0] \hadd/n2 ;
  wire [15:0] \hadd/n3 ;
  wire [15:0] \hadd/n4 ;
  wire [3:0] \hctl/stat ;  // rtl/hfpu_fsm.v(105)
  wire [11:0] \hdiv/den ;  // rtl/hfpu_hdiv.v(71)
  wire [23:0] \hdiv/dso ;  // rtl/hfpu_hdiv.v(59)
  wire [12:0] \hdiv/fdiv/n1 ;
  wire [12:0] \hdiv/fdiv/n3 ;
  wire [12:0] \hdiv/fdiv/n5 ;
  wire [12:0] \hdiv/fdiv/n7 ;
  wire [13:0] \hdiv/fdiv/rem1 ;  // rtl/hfpu_fdiv.v(41)
  wire [13:0] \hdiv/fdiv/rem2 ;  // rtl/hfpu_fdiv.v(40)
  wire [13:0] \hdiv/fdiv/rem3 ;  // rtl/hfpu_fdiv.v(39)
  wire [23:0] \hdiv/n9 ;
  wire [12:0] \hdiv/rem ;  // rtl/hfpu_hdiv.v(21)
  wire [4:0] \hlfa/ccmd_f ;  // rtl/hfpu_hlfa.v(49)
  wire [5:0] \hlfa/hlfa_e_dif ;  // rtl/hfpu_hlfa.v(46)
  wire [5:0] \hlfa/hlfa_e_difl ;  // rtl/hfpu_hlfa.v(47)
  wire [15:0] \hlfa/hlfa_i ;  // rtl/hfpu_hlfa.v(52)
  wire [5:0] \hlfa/hlfb_et ;  // rtl/hfpu_hlfa.v(45)
  wire [5:0] \hlfa/n1 ;
  wire [3:0] \hlfa/n18 ;
  wire [4:0] \hlfa/n25 ;
  wire [5:0] \hlfa/n34 ;
  wire [5:0] \hlfa/n61 ;
  wire [5:0] \hlfa/n62 ;
  wire [5:0] \hlfa/n64 ;
  wire [15:0] \hlfa/n65 ;
  wire [5:0] \hlfa/n66 ;
  wire [15:0] \hlfa/n67 ;
  wire [5:0] \hlfa/n68 ;
  wire [15:0] \hlfa/n69 ;
  wire [5:0] \hlfa/n70 ;
  wire [15:0] \hlfa/n71 ;
  wire [5:0] \hlfa/n72 ;
  wire [15:0] \hlfa/n73 ;
  wire [5:0] \hlfa/n74 ;
  wire [15:0] \hlfa/n75 ;
  wire [15:0] \hlfa/n77 ;
  wire [15:0] \hlfa/n79 ;
  wire [5:0] \hlfa/n81 ;
  wire [15:0] \hlfa/n82 ;
  wire [5:0] hlfa_e;  // rtl/halfpu.v(41)
  wire [25:0] hlfa_r;  // rtl/halfpu.v(44)
  wire [15:0] \hlfb/hlfb_i ;  // rtl/hfpu_hlfb.v(31)
  wire [5:0] \hlfb/n1 ;
  wire [3:0] \hlfb/n27 ;
  wire [4:0] \hlfb/n36 ;
  wire [5:0] \hlfb/n45 ;
  wire [5:0] \hlfb/n49 ;
  wire [15:0] \hlfb/n50 ;
  wire [15:0] \hlfb/n52 ;
  wire [15:0] \hlfb/n54 ;
  wire [5:0] \hlfb/n55 ;
  wire [15:0] \hlfb/n56 ;
  wire [5:0] \hlfb/n58 ;
  wire [15:0] \hlfb/n59 ;
  wire [5:0] hlfb_e;  // rtl/halfpu.v(42)
  wire [25:0] hlfb_r;  // rtl/halfpu.v(45)
  wire [25:0] hlfc_r_hadd;  // rtl/halfpu.v(46)
  wire [25:0] hlfc_r_hdiv;  // rtl/halfpu.v(48)
  wire [25:0] hlfc_r_hmul;  // rtl/halfpu.v(47)
  wire [3:0] n1;
  wire [4:0] n2;
  wire [4:0] n3;
  wire [4:0] n5;
  wire [3:0] n6;
  wire [4:0] n7;
  wire [5:0] \norm/hlfc_e ;  // rtl/hfpu_norm.v(58)
  wire [15:0] \norm/hlfc_f ;  // rtl/hfpu_norm.v(59)
  wire [25:22] \norm/hlfc_i ;  // rtl/hfpu_norm.v(57)
  wire [25:0] \norm/hlfc_r ;  // rtl/hfpu_norm.v(50)
  wire [25:0] \norm/n1 ;
  wire [5:0] \norm/n12 ;
  wire [5:0] \norm/n15 ;
  wire [15:0] \norm/n16 ;
  wire [5:0] \norm/n17 ;
  wire [15:0] \norm/n18 ;
  wire [25:0] \norm/n2 ;
  wire [5:0] \norm/n21 ;
  wire [5:0] \norm/n23 ;
  wire [15:0] \norm/n24 ;
  wire [5:0] \norm/n25 ;
  wire [15:0] \norm/n26 ;
  wire [5:0] \norm/n27 ;
  wire [15:0] \norm/n28 ;
  wire [5:0] \norm/n29 ;
  wire [15:0] \norm/n30 ;
  wire [5:0] \norm/n31 ;
  wire [5:0] \norm/n34 ;
  wire [15:0] \norm/n35 ;
  wire [5:0] \norm/n4 ;
  wire [4:0] \norm/n42 ;
  wire [4:0] \norm/n43 ;
  wire [4:0] \norm/n5 ;
  wire [5:0] \norm/n6 ;
  wire _al_u1000_o;
  wire _al_u1001_o;
  wire _al_u1004_o;
  wire _al_u1005_o;
  wire _al_u1006_o;
  wire _al_u1008_o;
  wire _al_u1009_o;
  wire _al_u1010_o;
  wire _al_u1011_o;
  wire _al_u1012_o;
  wire _al_u1013_o;
  wire _al_u1014_o;
  wire _al_u1015_o;
  wire _al_u1016_o;
  wire _al_u1017_o;
  wire _al_u1019_o;
  wire _al_u1020_o;
  wire _al_u1021_o;
  wire _al_u1022_o;
  wire _al_u1024_o;
  wire _al_u1025_o;
  wire _al_u1027_o;
  wire _al_u1028_o;
  wire _al_u1029_o;
  wire _al_u1030_o;
  wire _al_u1032_o;
  wire _al_u1033_o;
  wire _al_u1035_o;
  wire _al_u1036_o;
  wire _al_u1038_o;
  wire _al_u1039_o;
  wire _al_u1041_o;
  wire _al_u1042_o;
  wire _al_u1044_o;
  wire _al_u1045_o;
  wire _al_u1046_o;
  wire _al_u1047_o;
  wire _al_u1049_o;
  wire _al_u1050_o;
  wire _al_u1052_o;
  wire _al_u1053_o;
  wire _al_u1055_o;
  wire _al_u1056_o;
  wire _al_u1057_o;
  wire _al_u1058_o;
  wire _al_u1059_o;
  wire _al_u1061_o;
  wire _al_u1062_o;
  wire _al_u1064_o;
  wire _al_u1065_o;
  wire _al_u1067_o;
  wire _al_u1068_o;
  wire _al_u1070_o;
  wire _al_u1071_o;
  wire _al_u1073_o;
  wire _al_u1074_o;
  wire _al_u1076_o;
  wire _al_u1077_o;
  wire _al_u477_o;
  wire _al_u479_o;
  wire _al_u496_o;
  wire _al_u509_o;
  wire _al_u510_o;
  wire _al_u514_o;
  wire _al_u515_o;
  wire _al_u520_o;
  wire _al_u539_o;
  wire _al_u541_o;
  wire _al_u542_o;
  wire _al_u543_o;
  wire _al_u547_o;
  wire _al_u550_o;
  wire _al_u551_o;
  wire _al_u552_o;
  wire _al_u553_o;
  wire _al_u554_o;
  wire _al_u558_o;
  wire _al_u561_o;
  wire _al_u562_o;
  wire _al_u563_o;
  wire _al_u565_o;
  wire _al_u566_o;
  wire _al_u570_o;
  wire _al_u572_o;
  wire _al_u574_o;
  wire _al_u575_o;
  wire _al_u577_o;
  wire _al_u578_o;
  wire _al_u580_o;
  wire _al_u581_o;
  wire _al_u584_o;
  wire _al_u586_o;
  wire _al_u587_o;
  wire _al_u589_o;
  wire _al_u593_o;
  wire _al_u594_o;
  wire _al_u596_o;
  wire _al_u597_o;
  wire _al_u599_o;
  wire _al_u600_o;
  wire _al_u601_o;
  wire _al_u602_o;
  wire _al_u604_o;
  wire _al_u605_o;
  wire _al_u607_o;
  wire _al_u614_o;
  wire _al_u615_o;
  wire _al_u617_o;
  wire _al_u618_o;
  wire _al_u622_o;
  wire _al_u625_o;
  wire _al_u627_o;
  wire _al_u628_o;
  wire _al_u629_o;
  wire _al_u630_o;
  wire _al_u634_o;
  wire _al_u635_o;
  wire _al_u637_o;
  wire _al_u638_o;
  wire _al_u639_o;
  wire _al_u641_o;
  wire _al_u642_o;
  wire _al_u644_o;
  wire _al_u645_o;
  wire _al_u646_o;
  wire _al_u647_o;
  wire _al_u648_o;
  wire _al_u649_o;
  wire _al_u650_o;
  wire _al_u651_o;
  wire _al_u652_o;
  wire _al_u653_o;
  wire _al_u654_o;
  wire _al_u655_o;
  wire _al_u656_o;
  wire _al_u657_o;
  wire _al_u658_o;
  wire _al_u659_o;
  wire _al_u660_o;
  wire _al_u661_o;
  wire _al_u662_o;
  wire _al_u663_o;
  wire _al_u664_o;
  wire _al_u665_o;
  wire _al_u666_o;
  wire _al_u667_o;
  wire _al_u668_o;
  wire _al_u669_o;
  wire _al_u671_o;
  wire _al_u672_o;
  wire _al_u675_o;
  wire _al_u676_o;
  wire _al_u677_o;
  wire _al_u679_o;
  wire _al_u681_o;
  wire _al_u686_o;
  wire _al_u687_o;
  wire _al_u688_o;
  wire _al_u692_o;
  wire _al_u697_o;
  wire _al_u698_o;
  wire _al_u699_o;
  wire _al_u702_o;
  wire _al_u703_o;
  wire _al_u706_o;
  wire _al_u707_o;
  wire _al_u710_o;
  wire _al_u711_o;
  wire _al_u714_o;
  wire _al_u715_o;
  wire _al_u719_o;
  wire _al_u722_o;
  wire _al_u723_o;
  wire _al_u724_o;
  wire _al_u728_o;
  wire _al_u731_o;
  wire _al_u732_o;
  wire _al_u733_o;
  wire _al_u737_o;
  wire _al_u740_o;
  wire _al_u741_o;
  wire _al_u742_o;
  wire _al_u746_o;
  wire _al_u752_o;
  wire _al_u753_o;
  wire _al_u759_o;
  wire _al_u760_o;
  wire _al_u763_o;
  wire _al_u764_o;
  wire _al_u766_o;
  wire _al_u767_o;
  wire _al_u768_o;
  wire _al_u769_o;
  wire _al_u771_o;
  wire _al_u772_o;
  wire _al_u774_o;
  wire _al_u775_o;
  wire _al_u776_o;
  wire _al_u777_o;
  wire _al_u779_o;
  wire _al_u780_o;
  wire _al_u782_o;
  wire _al_u783_o;
  wire _al_u784_o;
  wire _al_u785_o;
  wire _al_u786_o;
  wire _al_u788_o;
  wire _al_u789_o;
  wire _al_u790_o;
  wire _al_u794_o;
  wire _al_u795_o;
  wire _al_u798_o;
  wire _al_u803_o;
  wire _al_u804_o;
  wire _al_u806_o;
  wire _al_u820_o;
  wire _al_u821_o;
  wire _al_u822_o;
  wire _al_u824_o;
  wire _al_u825_o;
  wire _al_u827_o;
  wire _al_u828_o;
  wire _al_u830_o;
  wire _al_u833_o;
  wire _al_u835_o;
  wire _al_u837_o;
  wire _al_u839_o;
  wire _al_u845_o;
  wire _al_u847_o;
  wire _al_u849_o;
  wire _al_u850_o;
  wire _al_u851_o;
  wire _al_u852_o;
  wire _al_u853_o;
  wire _al_u854_o;
  wire _al_u855_o;
  wire _al_u856_o;
  wire _al_u857_o;
  wire _al_u860_o;
  wire _al_u861_o;
  wire _al_u864_o;
  wire _al_u866_o;
  wire _al_u867_o;
  wire _al_u869_o;
  wire _al_u874_o;
  wire _al_u877_o;
  wire _al_u880_o;
  wire _al_u883_o;
  wire _al_u886_o;
  wire _al_u887_o;
  wire _al_u890_o;
  wire _al_u891_o;
  wire _al_u892_o;
  wire _al_u895_o;
  wire _al_u901_o;
  wire _al_u903_o;
  wire _al_u912_o;
  wire _al_u914_o;
  wire _al_u918_o;
  wire _al_u919_o;
  wire _al_u920_o;
  wire _al_u922_o;
  wire _al_u923_o;
  wire _al_u924_o;
  wire _al_u925_o;
  wire _al_u926_o;
  wire _al_u928_o;
  wire _al_u929_o;
  wire _al_u930_o;
  wire _al_u933_o;
  wire _al_u934_o;
  wire _al_u935_o;
  wire _al_u938_o;
  wire _al_u939_o;
  wire _al_u940_o;
  wire _al_u943_o;
  wire _al_u944_o;
  wire _al_u945_o;
  wire _al_u951_o;
  wire _al_u952_o;
  wire _al_u954_o;
  wire _al_u955_o;
  wire _al_u957_o;
  wire _al_u959_o;
  wire _al_u960_o;
  wire _al_u962_o;
  wire _al_u966_o;
  wire _al_u972_o;
  wire _al_u978_o;
  wire _al_u984_o;
  wire _al_u989_o;
  wire _al_u990_o;
  wire _al_u993_o;
  wire _al_u994_o;
  wire _al_u999_o;
  wire \hadd/add0/c0 ;
  wire \hadd/add0/c1 ;
  wire \hadd/add0/c10 ;
  wire \hadd/add0/c11 ;
  wire \hadd/add0/c12 ;
  wire \hadd/add0/c13 ;
  wire \hadd/add0/c14 ;
  wire \hadd/add0/c15 ;
  wire \hadd/add0/c2 ;
  wire \hadd/add0/c3 ;
  wire \hadd/add0/c4 ;
  wire \hadd/add0/c5 ;
  wire \hadd/add0/c6 ;
  wire \hadd/add0/c7 ;
  wire \hadd/add0/c8 ;
  wire \hadd/add0/c9 ;
  wire \hadd/eq0/or_xor_i0[14]_i1[14]_o_lutinv ;
  wire \hadd/inf_nan ;  // rtl/hfpu_hadd.v(34)
  wire \hadd/inf_s ;  // rtl/hfpu_hadd.v(35)
  wire \hadd/neg0/c0 ;
  wire \hadd/neg0/c1 ;
  wire \hadd/neg0/c10 ;
  wire \hadd/neg0/c11 ;
  wire \hadd/neg0/c12 ;
  wire \hadd/neg0/c13 ;
  wire \hadd/neg0/c14 ;
  wire \hadd/neg0/c15 ;
  wire \hadd/neg0/c2 ;
  wire \hadd/neg0/c3 ;
  wire \hadd/neg0/c4 ;
  wire \hadd/neg0/c5 ;
  wire \hadd/neg0/c6 ;
  wire \hadd/neg0/c7 ;
  wire \hadd/neg0/c8 ;
  wire \hadd/neg0/c9 ;
  wire \hadd/neg1/c0 ;
  wire \hadd/neg1/c1 ;
  wire \hadd/neg1/c10 ;
  wire \hadd/neg1/c11 ;
  wire \hadd/neg1/c12 ;
  wire \hadd/neg1/c13 ;
  wire \hadd/neg1/c14 ;
  wire \hadd/neg1/c15 ;
  wire \hadd/neg1/c2 ;
  wire \hadd/neg1/c3 ;
  wire \hadd/neg1/c4 ;
  wire \hadd/neg1/c5 ;
  wire \hadd/neg1/c6 ;
  wire \hadd/neg1/c7 ;
  wire \hadd/neg1/c8 ;
  wire \hadd/neg1/c9 ;
  wire \hctl/crdy_f ;  // rtl/hfpu_fsm.v(95)
  wire \hctl/crdy_t ;  // rtl/hfpu_fsm.v(96)
  wire \hctl/mux0_b0_sel_is_1_o ;
  wire \hctl/mux0_b1_sel_is_3_o ;
  wire \hctl/mux0_b2_sel_is_3_o ;
  wire \hctl/mux0_b3_sel_is_3_o ;
  wire \hctl/n10 ;
  wire \hctl/n113_lutinv ;
  wire \hctl/n13 ;
  wire \hctl/n131_lutinv ;
  wire \hctl/n140_lutinv ;
  wire \hctl/n15 ;
  wire \hctl/n16 ;
  wire \hctl/n168 ;
  wire \hctl/n17 ;
  wire \hctl/n27 ;
  wire \hctl/n31 ;
  wire \hctl/n80_lutinv ;
  wire \hctl/n9 ;
  wire hctl_cbus_out_lutinv;  // rtl/halfpu.v(76)
  wire hctl_ccmd_add;  // rtl/halfpu.v(60)
  wire hctl_ccmd_cmp;  // rtl/halfpu.v(62)
  wire hctl_ccmd_div;  // rtl/halfpu.v(64)
  wire hctl_ccmd_hlf;  // rtl/halfpu.v(66)
  wire hctl_ccmd_int;  // rtl/halfpu.v(67)
  wire hctl_ccmd_mul;  // rtl/halfpu.v(63)
  wire hctl_ccmd_reg;  // rtl/halfpu.v(65)
  wire hctl_ccmd_sub;  // rtl/halfpu.v(61)
  wire hctl_dsft_enb;  // rtl/halfpu.v(72)
  wire hctl_load_a;  // rtl/halfpu.v(68)
  wire hctl_load_c;  // rtl/halfpu.v(70)
  wire hctl_norm_enb_lutinv;  // rtl/halfpu.v(75)
  wire hctl_rsft_enb_lutinv;  // rtl/halfpu.v(73)
  wire \hdiv/fdiv/add0_2/c0 ;
  wire \hdiv/fdiv/add0_2/c1 ;
  wire \hdiv/fdiv/add0_2/c10 ;
  wire \hdiv/fdiv/add0_2/c11 ;
  wire \hdiv/fdiv/add0_2/c12 ;
  wire \hdiv/fdiv/add0_2/c2 ;
  wire \hdiv/fdiv/add0_2/c3 ;
  wire \hdiv/fdiv/add0_2/c4 ;
  wire \hdiv/fdiv/add0_2/c5 ;
  wire \hdiv/fdiv/add0_2/c6 ;
  wire \hdiv/fdiv/add0_2/c7 ;
  wire \hdiv/fdiv/add0_2/c8 ;
  wire \hdiv/fdiv/add0_2/c9 ;
  wire \hdiv/fdiv/add1_2/c0 ;
  wire \hdiv/fdiv/add1_2/c1 ;
  wire \hdiv/fdiv/add1_2/c10 ;
  wire \hdiv/fdiv/add1_2/c11 ;
  wire \hdiv/fdiv/add1_2/c12 ;
  wire \hdiv/fdiv/add1_2/c2 ;
  wire \hdiv/fdiv/add1_2/c3 ;
  wire \hdiv/fdiv/add1_2/c4 ;
  wire \hdiv/fdiv/add1_2/c5 ;
  wire \hdiv/fdiv/add1_2/c6 ;
  wire \hdiv/fdiv/add1_2/c7 ;
  wire \hdiv/fdiv/add1_2/c8 ;
  wire \hdiv/fdiv/add1_2/c9 ;
  wire \hdiv/fdiv/add2_2/c0 ;
  wire \hdiv/fdiv/add2_2/c1 ;
  wire \hdiv/fdiv/add2_2/c10 ;
  wire \hdiv/fdiv/add2_2/c11 ;
  wire \hdiv/fdiv/add2_2/c12 ;
  wire \hdiv/fdiv/add2_2/c2 ;
  wire \hdiv/fdiv/add2_2/c3 ;
  wire \hdiv/fdiv/add2_2/c4 ;
  wire \hdiv/fdiv/add2_2/c5 ;
  wire \hdiv/fdiv/add2_2/c6 ;
  wire \hdiv/fdiv/add2_2/c7 ;
  wire \hdiv/fdiv/add2_2/c8 ;
  wire \hdiv/fdiv/add2_2/c9 ;
  wire \hdiv/fdiv/add3_2/c0 ;
  wire \hdiv/fdiv/add3_2/c1 ;
  wire \hdiv/fdiv/add3_2/c10 ;
  wire \hdiv/fdiv/add3_2/c11 ;
  wire \hdiv/fdiv/add3_2/c12 ;
  wire \hdiv/fdiv/add3_2/c2 ;
  wire \hdiv/fdiv/add3_2/c3 ;
  wire \hdiv/fdiv/add3_2/c4 ;
  wire \hdiv/fdiv/add3_2/c5 ;
  wire \hdiv/fdiv/add3_2/c6 ;
  wire \hdiv/fdiv/add3_2/c7 ;
  wire \hdiv/fdiv/add3_2/c8 ;
  wire \hdiv/fdiv/add3_2/c9 ;
  wire \hdiv/fdiv/n0 ;
  wire \hdiv/inf_zer_lutinv ;  // rtl/hfpu_hdiv.v(42)
  wire \hdiv/n15 ;
  wire \hdiv/sub0/c0 ;
  wire \hdiv/sub0/c1 ;
  wire \hdiv/sub0/c2 ;
  wire \hdiv/sub0/c3 ;
  wire \hdiv/sub0/c4 ;
  wire \hdiv/sub0/c5 ;
  wire \hlfa/add2/c0 ;
  wire \hlfa/add2/c1 ;
  wire \hlfa/add2/c2 ;
  wire \hlfa/add2/c3 ;
  wire \hlfa/add3/c0 ;
  wire \hlfa/add3/c1 ;
  wire \hlfa/add3/c2 ;
  wire \hlfa/add3/c3 ;
  wire \hlfa/add3/c4 ;
  wire \hlfa/add4/c0 ;
  wire \hlfa/add4/c1 ;
  wire \hlfa/add4/c2 ;
  wire \hlfa/add4/c3 ;
  wire \hlfa/add4/c4 ;
  wire \hlfa/add4/c5 ;
  wire \hlfa/hlfa_lsft_fin ;  // rtl/hfpu_hlfa.v(44)
  wire \hlfa/hlfa_rsft_fin ;  // rtl/hfpu_hlfa.v(43)
  wire \hlfa/lt0_c0 ;
  wire \hlfa/lt0_c1 ;
  wire \hlfa/lt0_c2 ;
  wire \hlfa/lt0_c3 ;
  wire \hlfa/lt0_c4 ;
  wire \hlfa/lt0_c5 ;
  wire \hlfa/lt0_c6 ;
  wire \hlfa/lt1_c0 ;
  wire \hlfa/lt1_c1 ;
  wire \hlfa/lt1_c2 ;
  wire \hlfa/lt1_c3 ;
  wire \hlfa/lt1_c4 ;
  wire \hlfa/lt1_c5 ;
  wire \hlfa/lt1_c6 ;
  wire \hlfa/mux17_b1_sel_is_2_o ;
  wire \hlfa/mux17_b2_sel_is_0_o ;
  wire \hlfa/mux21_b1_sel_is_0_o ;
  wire \hlfa/mux24_b0_sel_is_0_o ;
  wire \hlfa/mux24_b13_sel_is_2_o ;
  wire \hlfa/mux24_b14_sel_is_2_o ;
  wire \hlfa/mux24_b15_sel_is_2_o ;
  wire \hlfa/mux24_b1_sel_is_2_o ;
  wire \hlfa/mux29_b22_sel_is_2_o ;
  wire \hlfa/mux8_b2_sel_is_0_o ;
  wire \hlfa/n40 ;
  wire \hlfa/n86_lutinv ;
  wire \hlfa/n89_lutinv ;
  wire \hlfa/sub0/c0 ;
  wire \hlfa/sub0/c1 ;
  wire \hlfa/sub0/c2 ;
  wire \hlfa/sub0/c3 ;
  wire \hlfa/sub0/c4 ;
  wire \hlfa/sub0/c5 ;
  wire \hlfa/sub2/c0 ;
  wire \hlfa/sub2/c1 ;
  wire \hlfa/sub2/c2 ;
  wire \hlfa/sub2/c3 ;
  wire \hlfa/sub3/c0 ;
  wire \hlfa/sub3/c1 ;
  wire \hlfa/sub3/c2 ;
  wire \hlfa/sub3/c3 ;
  wire \hlfa/sub3/c4 ;
  wire \hlfa/sub4/c0 ;
  wire \hlfa/sub4/c1 ;
  wire \hlfa/sub4/c2 ;
  wire \hlfa/sub4/c3 ;
  wire \hlfa/sub4/c4 ;
  wire \hlfa/sub4/c5 ;
  wire \hlfa/sub5/c0 ;
  wire \hlfa/sub5/c1 ;
  wire \hlfa/sub5/c2 ;
  wire \hlfa/sub5/c3 ;
  wire \hlfa/sub5/c4 ;
  wire \hlfa/sub5/c5 ;
  wire \hlfa/sub6/c0 ;
  wire \hlfa/sub6/c1 ;
  wire \hlfa/sub6/c2 ;
  wire \hlfa/sub6/c3 ;
  wire \hlfa/sub6/c4 ;
  wire \hlfa/sub6/c5 ;
  wire \hlfb/add2/c0 ;
  wire \hlfb/add2/c1 ;
  wire \hlfb/add2/c2 ;
  wire \hlfb/add2/c3 ;
  wire \hlfb/add3/c0 ;
  wire \hlfb/add3/c1 ;
  wire \hlfb/add3/c2 ;
  wire \hlfb/add3/c3 ;
  wire \hlfb/add3/c4 ;
  wire \hlfb/add4/c0 ;
  wire \hlfb/add4/c1 ;
  wire \hlfb/add4/c2 ;
  wire \hlfb/add4/c3 ;
  wire \hlfb/add4/c4 ;
  wire \hlfb/add4/c5 ;
  wire \hlfb/lt0_c0 ;
  wire \hlfb/lt0_c1 ;
  wire \hlfb/lt0_c2 ;
  wire \hlfb/lt0_c3 ;
  wire \hlfb/lt0_c4 ;
  wire \hlfb/lt0_c5 ;
  wire \hlfb/lt0_c6 ;
  wire \hlfb/mux10_b10_sel_is_0_o ;
  wire \hlfb/mux10_b10_sel_is_1_o ;
  wire \hlfb/mux16_b13_sel_is_2_o ;
  wire \hlfb/mux16_b1_sel_is_2_o ;
  wire \hlfb/n63_lutinv ;
  wire \hlfb/n66_lutinv ;
  wire \hlfb/n67 ;
  wire \hlfb/sub0/c0 ;
  wire \hlfb/sub0/c1 ;
  wire \hlfb/sub0/c2 ;
  wire \hlfb/sub0/c3 ;
  wire \hlfb/sub0/c4 ;
  wire \hlfb/sub0/c5 ;
  wire \hmul/add0/c0 ;
  wire \hmul/add0/c1 ;
  wire \hmul/add0/c2 ;
  wire \hmul/add0/c3 ;
  wire \hmul/add0/c4 ;
  wire \hmul/add0/c5 ;
  wire \norm/add0/c0 ;
  wire \norm/add0/c1 ;
  wire \norm/add0/c2 ;
  wire \norm/add0/c3 ;
  wire \norm/add0/c4 ;
  wire \norm/add0/c5 ;
  wire \norm/add1/c0 ;
  wire \norm/add1/c1 ;
  wire \norm/add1/c2 ;
  wire \norm/add1/c3 ;
  wire \norm/add1/c4 ;
  wire \norm/add2/c0 ;
  wire \norm/add2/c1 ;
  wire \norm/add2/c2 ;
  wire \norm/add2/c3 ;
  wire \norm/add2/c4 ;
  wire \norm/add2/c5 ;
  wire \norm/add3/c0 ;
  wire \norm/add3/c1 ;
  wire \norm/add3/c2 ;
  wire \norm/add3/c3 ;
  wire \norm/add3/c4 ;
  wire \norm/add4/c0 ;
  wire \norm/add4/c1 ;
  wire \norm/add4/c2 ;
  wire \norm/add4/c3 ;
  wire \norm/add4/c4 ;
  wire \norm/lt0_c0 ;
  wire \norm/lt0_c1 ;
  wire \norm/lt0_c2 ;
  wire \norm/lt0_c3 ;
  wire \norm/lt0_c4 ;
  wire \norm/lt0_c5 ;
  wire \norm/lt0_c6 ;
  wire \norm/lt1_c0 ;
  wire \norm/lt1_c1 ;
  wire \norm/lt1_c2 ;
  wire \norm/lt1_c3 ;
  wire \norm/lt1_c4 ;
  wire \norm/lt1_c5 ;
  wire \norm/lt1_c6 ;
  wire \norm/mux1_b0_sel_is_2_o ;
  wire \norm/mux2_b14_sel_is_2_o ;
  wire \norm/mux37_b0_sel_is_2_o ;
  wire \norm/n39_lutinv ;
  wire \norm/ovfl ;  // rtl/hfpu_norm.v(147)
  wire \norm/sub0/c0 ;
  wire \norm/sub0/c1 ;
  wire \norm/sub0/c2 ;
  wire \norm/sub0/c3 ;
  wire \norm/sub0/c4 ;
  wire \norm/sub2/c0 ;
  wire \norm/sub2/c1 ;
  wire \norm/sub2/c2 ;
  wire \norm/sub2/c3 ;
  wire \norm/sub2/c4 ;
  wire \norm/sub3/c0 ;
  wire \norm/sub3/c1 ;
  wire \norm/sub3/c2 ;
  wire \norm/sub3/c3 ;
  wire \norm/sub4/c0 ;
  wire \norm/sub4/c1 ;
  wire \norm/sub4/c2 ;
  wire \norm/sub4/c3 ;
  wire \norm/sub4/c4 ;
  wire \norm/sub5/c0 ;
  wire \norm/sub5/c1 ;
  wire \norm/sub5/c2 ;
  wire \norm/sub5/c3 ;
  wire \norm/sub5/c4 ;
  wire \norm/sub5/c5 ;
  wire \norm/udfl ;  // rtl/hfpu_norm.v(148)

  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1000 (
    .a(_al_u999_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(\hlfa/n25 [3]),
    .e(\hlfa/n18 [2]),
    .o(_al_u1000_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfece0232))
    _al_u1001 (
    .a(_al_u1000_o),
    .b(_al_u589_o),
    .c(_al_u837_o),
    .d(hlfa_e[3]),
    .e(hlfa_e[4]),
    .o(_al_u1001_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1002 (
    .a(_al_u1001_o),
    .b(hctl_load_a),
    .c(\hlfa/n1 [4]),
    .o(\hlfa/n81 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u1003 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(\hlfa/n61 [3]),
    .d(n2[2]),
    .e(hlfa_e[3]),
    .o(\hlfa/n64 [3]));
  AL_MAP_LUT5 #(
    .EQN("(~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~(~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hcdfd0131))
    _al_u1004 (
    .a(\hlfa/n64 [3]),
    .b(_al_u596_o),
    .c(_al_u597_o),
    .d(n1[1]),
    .e(hlfa_e[3]),
    .o(_al_u1004_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'h020ef2fe))
    _al_u1005 (
    .a(_al_u1004_o),
    .b(_al_u639_o),
    .c(_al_u845_o),
    .d(\hlfa/n34 [3]),
    .e(\hlfa/n25 [2]),
    .o(_al_u1005_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+~(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~(~(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+~(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hf2fe020e))
    _al_u1006 (
    .a(_al_u1005_o),
    .b(_al_u839_o),
    .c(_al_u837_o),
    .d(\hlfa/n18 [1]),
    .e(hlfa_e[3]),
    .o(_al_u1006_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*~(C)*~(B)+(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*C*~(B)+~((~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))*C*B+(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*C*B)"),
    .INIT(32'hf3d1c0d1))
    _al_u1007 (
    .a(_al_u1006_o),
    .b(hctl_load_a),
    .c(\hlfa/n1 [3]),
    .d(_al_u589_o),
    .e(hlfa_e[3]),
    .o(\hlfa/n81 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u1008 (
    .a(\hlfa/mux8_b2_sel_is_0_o ),
    .b(_al_u593_o),
    .c(_al_u594_o),
    .d(_al_u639_o),
    .o(_al_u1008_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*~(B)*C*D*E)"),
    .INIT(32'h113351ff))
    _al_u1009 (
    .a(_al_u1008_o),
    .b(_al_u639_o),
    .c(_al_u496_o),
    .d(hlfa_r[0]),
    .e(hlfa_r[1]),
    .o(_al_u1009_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~(~A*~(~C*~B)))"),
    .INIT(16'h00ab))
    _al_u1010 (
    .a(_al_u496_o),
    .b(hlfa_r[0]),
    .c(hlfa_r[1]),
    .d(hlfa_r[2]),
    .o(_al_u1010_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1011 (
    .a(hlfa_r[0]),
    .b(hlfa_r[1]),
    .c(hlfa_r[2]),
    .d(hlfa_r[3]),
    .o(_al_u1011_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(~B*~A))"),
    .INIT(8'h0e))
    _al_u1012 (
    .a(_al_u496_o),
    .b(_al_u1011_o),
    .c(hlfa_r[4]),
    .o(_al_u1012_o));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1013 (
    .a(_al_u1009_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(_al_u1010_o),
    .e(_al_u1012_o),
    .o(_al_u1013_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1014 (
    .a(_al_u1011_o),
    .b(hlfa_r[4]),
    .c(hlfa_r[5]),
    .d(hlfa_r[6]),
    .e(hlfa_r[7]),
    .o(_al_u1014_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((~E*~(~D*~C)))*~(B)+A*(~E*~(~D*~C))*~(B)+~(A)*(~E*~(~D*~C))*B+A*(~E*~(~D*~C))*B)"),
    .INIT(32'h2222eee2))
    _al_u1015 (
    .a(_al_u1013_o),
    .b(_al_u837_o),
    .c(_al_u1014_o),
    .d(_al_u496_o),
    .e(hlfa_r[8]),
    .o(_al_u1015_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1016 (
    .a(hlfa_r[10]),
    .b(hlfa_r[11]),
    .c(hlfa_r[12]),
    .d(hlfa_r[13]),
    .o(_al_u1016_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1017 (
    .a(_al_u1016_o),
    .b(hlfa_r[14]),
    .c(hlfa_r[15]),
    .d(hlfa_r[8]),
    .e(hlfa_r[9]),
    .o(_al_u1017_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((~E*~(D*C)))*~(B)+~A*(~E*~(D*C))*~(B)+~(~A)*(~E*~(D*C))*B+~A*(~E*~(D*C))*B)"),
    .INIT(32'h11111ddd))
    _al_u1018 (
    .a(_al_u1015_o),
    .b(_al_u589_o),
    .c(_al_u1014_o),
    .d(_al_u1017_o),
    .e(_al_u496_o),
    .o(\hlfa/n79 [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1019 (
    .a(\norm/hlfc_r [25]),
    .b(hctl_ccmd_hlf),
    .o(_al_u1019_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1020 (
    .a(hctl_ccmd_hlf),
    .b(hctl_ccmd_reg),
    .c(\norm/hlfc_i [23]),
    .o(_al_u1020_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~E*D)*~(B*~A))"),
    .INIT(32'hb0b000b0))
    _al_u1021 (
    .a(\norm/hlfc_r [22]),
    .b(_al_u1019_o),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_i [22]),
    .o(_al_u1021_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~C*~B*~(~E*~D)))"),
    .INIT(32'h54545455))
    _al_u1022 (
    .a(_al_u1021_o),
    .b(hctl_ccmd_cmp),
    .c(hctl_ccmd_reg),
    .d(\norm/hlfc_i [22]),
    .e(\norm/hlfc_i [25]),
    .o(_al_u1022_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h3050))
    _al_u1023 (
    .a(_al_u1022_o),
    .b(_al_u622_o),
    .c(hctl_cbus_out_lutinv),
    .d(hctl_ccmd_int),
    .o(cbus[15]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1024 (
    .a(\norm/hlfc_r [24]),
    .b(\norm/hlfc_r [25]),
    .o(_al_u1024_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(C*~(B*~A))*~(D)*~(E)+~(C*~(B*~A))*D*~(E)+~(~(C*~(B*~A)))*D*E+~(C*~(B*~A))*D*E)"),
    .INIT(32'h00ffb0b0))
    _al_u1025 (
    .a(\norm/hlfc_r [23]),
    .b(\norm/n43 [4]),
    .c(_al_u1024_o),
    .d(\norm/n42 [4]),
    .e(hctl_ccmd_hlf),
    .o(_al_u1025_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u1026 (
    .a(\norm/ovfl ),
    .b(\norm/udfl ),
    .c(\norm/hlfc_i [23]),
    .d(\norm/hlfc_i [24]),
    .e(\norm/hlfc_i [25]),
    .o(\norm/mux37_b0_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1027 (
    .a(\norm/mux37_b0_sel_is_2_o ),
    .b(hctl_ccmd_cmp),
    .c(hctl_ccmd_reg),
    .o(_al_u1027_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~(~E*~D*~A))"),
    .INIT(32'h03030302))
    _al_u1028 (
    .a(\norm/ovfl ),
    .b(hctl_ccmd_cmp),
    .c(hctl_ccmd_reg),
    .d(\norm/hlfc_i [24]),
    .e(\norm/hlfc_i [25]),
    .o(_al_u1028_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1029 (
    .a(_al_u1028_o),
    .b(hctl_ccmd_int),
    .o(_al_u1029_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*~A))"),
    .INIT(32'h20a030f0))
    _al_u1030 (
    .a(_al_u1025_o),
    .b(_al_u1027_o),
    .c(_al_u1029_o),
    .d(\norm/n42 [4]),
    .e(_al_u1020_o),
    .o(_al_u1030_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*B))"),
    .INIT(16'h1050))
    _al_u1031 (
    .a(_al_u1030_o),
    .b(_al_u625_o),
    .c(hctl_cbus_out_lutinv),
    .d(hctl_ccmd_int),
    .o(cbus[14]));
  AL_MAP_LUT5 #(
    .EQN("~(~(C*~(B*~A))*~(D)*~(E)+~(C*~(B*~A))*D*~(E)+~(~(C*~(B*~A)))*D*E+~(C*~(B*~A))*D*E)"),
    .INIT(32'h00ffb0b0))
    _al_u1032 (
    .a(\norm/hlfc_r [23]),
    .b(\norm/n43 [3]),
    .c(_al_u1024_o),
    .d(\norm/n42 [3]),
    .e(hctl_ccmd_hlf),
    .o(_al_u1032_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*~A))"),
    .INIT(32'h20a030f0))
    _al_u1033 (
    .a(_al_u1032_o),
    .b(_al_u1027_o),
    .c(_al_u1029_o),
    .d(\norm/n42 [3]),
    .e(_al_u1020_o),
    .o(_al_u1033_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*B))"),
    .INIT(16'h1050))
    _al_u1034 (
    .a(_al_u1033_o),
    .b(_al_u804_o),
    .c(hctl_cbus_out_lutinv),
    .d(hctl_ccmd_int),
    .o(cbus[13]));
  AL_MAP_LUT5 #(
    .EQN("~(~(C*~(B*~A))*~(D)*~(E)+~(C*~(B*~A))*D*~(E)+~(~(C*~(B*~A)))*D*E+~(C*~(B*~A))*D*E)"),
    .INIT(32'h00ffb0b0))
    _al_u1035 (
    .a(\norm/hlfc_r [23]),
    .b(\norm/n43 [2]),
    .c(_al_u1024_o),
    .d(\norm/n42 [2]),
    .e(hctl_ccmd_hlf),
    .o(_al_u1035_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*~A))"),
    .INIT(32'h20a030f0))
    _al_u1036 (
    .a(_al_u1035_o),
    .b(_al_u1027_o),
    .c(_al_u1029_o),
    .d(\norm/n42 [2]),
    .e(_al_u1020_o),
    .o(_al_u1036_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*~B))"),
    .INIT(16'h4050))
    _al_u1037 (
    .a(_al_u1036_o),
    .b(\norm/hlfc_r [12]),
    .c(hctl_cbus_out_lutinv),
    .d(hctl_ccmd_int),
    .o(cbus[12]));
  AL_MAP_LUT5 #(
    .EQN("~(~(C*~(B*~A))*~(D)*~(E)+~(C*~(B*~A))*D*~(E)+~(~(C*~(B*~A)))*D*E+~(C*~(B*~A))*D*E)"),
    .INIT(32'h00ffb0b0))
    _al_u1038 (
    .a(\norm/hlfc_r [23]),
    .b(\norm/n43 [1]),
    .c(_al_u1024_o),
    .d(\norm/n42 [1]),
    .e(hctl_ccmd_hlf),
    .o(_al_u1038_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*~A))"),
    .INIT(32'h20a030f0))
    _al_u1039 (
    .a(_al_u1038_o),
    .b(_al_u1027_o),
    .c(_al_u1029_o),
    .d(\norm/n42 [1]),
    .e(_al_u1020_o),
    .o(_al_u1039_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*~B))"),
    .INIT(16'h4050))
    _al_u1040 (
    .a(_al_u1039_o),
    .b(\norm/hlfc_r [11]),
    .c(hctl_cbus_out_lutinv),
    .d(hctl_ccmd_int),
    .o(cbus[11]));
  AL_MAP_LUT5 #(
    .EQN("~(~(C*~(B*~A))*~(D)*~(E)+~(C*~(B*~A))*D*~(E)+~(~(C*~(B*~A)))*D*E+~(C*~(B*~A))*D*E)"),
    .INIT(32'h00ffb0b0))
    _al_u1041 (
    .a(\norm/hlfc_r [23]),
    .b(\norm/n43 [0]),
    .c(_al_u1024_o),
    .d(\norm/n42 [0]),
    .e(hctl_ccmd_hlf),
    .o(_al_u1041_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*~A))"),
    .INIT(32'h20a030f0))
    _al_u1042 (
    .a(_al_u1041_o),
    .b(_al_u1027_o),
    .c(_al_u1029_o),
    .d(\norm/n42 [0]),
    .e(_al_u1020_o),
    .o(_al_u1042_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*~B))"),
    .INIT(16'h4050))
    _al_u1043 (
    .a(_al_u1042_o),
    .b(\norm/hlfc_r [10]),
    .c(hctl_cbus_out_lutinv),
    .d(hctl_ccmd_int),
    .o(cbus[10]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u1044 (
    .a(\norm/hlfc_r [23]),
    .b(_al_u1024_o),
    .c(hctl_ccmd_hlf),
    .o(_al_u1044_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~(~E*D)*~C)*~(B*A))"),
    .INIT(32'h70707770))
    _al_u1045 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [11]),
    .c(_al_u1019_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [11]),
    .o(_al_u1045_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~(~E*~(D*A)))"),
    .INIT(32'h03030200))
    _al_u1046 (
    .a(\norm/mux37_b0_sel_is_2_o ),
    .b(hctl_ccmd_cmp),
    .c(hctl_ccmd_reg),
    .d(\norm/hlfc_f [11]),
    .e(\norm/hlfc_i [25]),
    .o(_al_u1046_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(D*~A))*~(B)*~(E)+~(~C*~(D*~A))*B*~(E)+~(~(~C*~(D*~A)))*B*E+~(~C*~(D*~A))*B*E)"),
    .INIT(32'h33330a0f))
    _al_u1047 (
    .a(_al_u1045_o),
    .b(\norm/hlfc_r [9]),
    .c(_al_u1046_o),
    .d(_al_u1020_o),
    .e(hctl_ccmd_int),
    .o(_al_u1047_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1048 (
    .a(_al_u1047_o),
    .b(hctl_cbus_out_lutinv),
    .o(cbus[9]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1049 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [10]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [10]),
    .o(_al_u1049_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(E*C))*~(B)*~(D)+~(~A*~(E*C))*B*~(D)+~(~(~A*~(E*C)))*B*D+~(~A*~(E*C))*B*D)"),
    .INIT(32'h33053355))
    _al_u1050 (
    .a(_al_u1049_o),
    .b(\norm/hlfc_r [8]),
    .c(_al_u1027_o),
    .d(hctl_ccmd_int),
    .e(\norm/hlfc_f [10]),
    .o(_al_u1050_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1051 (
    .a(_al_u1050_o),
    .b(hctl_cbus_out_lutinv),
    .o(cbus[8]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1052 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [9]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [9]),
    .o(_al_u1052_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~(E*B)*~(A)*~(C)+~(E*B)*A*~(C)+~(~(E*B))*A*C+~(E*B)*A*C))"),
    .INIT(32'h005c0050))
    _al_u1053 (
    .a(_al_u851_o),
    .b(\norm/mux37_b0_sel_is_2_o ),
    .c(hctl_ccmd_cmp),
    .d(hctl_ccmd_reg),
    .e(\norm/hlfc_f [9]),
    .o(_al_u1053_o));
  AL_MAP_LUT5 #(
    .EQN("(D*(~(~B*~A)*~(C)*~(E)+~(~B*~A)*C*~(E)+~(~(~B*~A))*C*E+~(~B*~A)*C*E))"),
    .INIT(32'hf000ee00))
    _al_u1054 (
    .a(_al_u1052_o),
    .b(_al_u1053_o),
    .c(\norm/hlfc_r [7]),
    .d(hctl_cbus_out_lutinv),
    .e(hctl_ccmd_int),
    .o(cbus[7]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1055 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [8]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [8]),
    .o(_al_u1055_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1056 (
    .a(hlfc_r_hadd[23]),
    .b(_al_u850_o),
    .c(hctl_ccmd_cmp),
    .o(_al_u1056_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*(~(A)*~(B)*~(C)+A*B*~(C)+~(A)*~(B)*C))"),
    .INIT(32'h19000000))
    _al_u1057 (
    .a(\hlfa/n89_lutinv ),
    .b(\hlfb/n66_lutinv ),
    .c(_al_u479_o),
    .d(\hlfa/n86_lutinv ),
    .e(\hlfb/n63_lutinv ),
    .o(_al_u1057_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*C)*~(B)*~(D)+(E*C)*B*~(D)+~((E*C))*B*D+(E*C)*B*D))"),
    .INIT(32'h11051155))
    _al_u1058 (
    .a(_al_u1056_o),
    .b(_al_u1057_o),
    .c(\norm/mux37_b0_sel_is_2_o ),
    .d(hctl_ccmd_cmp),
    .e(\norm/hlfc_f [8]),
    .o(_al_u1058_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(~E*~B))*~(C)*~(D)+~(~A*~(~E*~B))*C*~(D)+~(~(~A*~(~E*~B)))*C*D+~(~A*~(~E*~B))*C*D)"),
    .INIT(32'h0f550f44))
    _al_u1059 (
    .a(_al_u1055_o),
    .b(_al_u1058_o),
    .c(\norm/hlfc_r [6]),
    .d(hctl_ccmd_int),
    .e(hctl_ccmd_reg),
    .o(_al_u1059_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1060 (
    .a(_al_u1059_o),
    .b(hctl_cbus_out_lutinv),
    .o(cbus[6]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1061 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [7]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [7]),
    .o(_al_u1061_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~(E*B)*~(A)*~(C)+~(E*B)*A*~(C)+~(~(E*B))*A*C+~(E*B)*A*C))"),
    .INIT(32'h005c0050))
    _al_u1062 (
    .a(_al_u850_o),
    .b(\norm/mux37_b0_sel_is_2_o ),
    .c(hctl_ccmd_cmp),
    .d(hctl_ccmd_reg),
    .e(\norm/hlfc_f [7]),
    .o(_al_u1062_o));
  AL_MAP_LUT5 #(
    .EQN("(D*(~(~C*~A)*~(B)*~(E)+~(~C*~A)*B*~(E)+~(~(~C*~A))*B*E+~(~C*~A)*B*E))"),
    .INIT(32'hcc00fa00))
    _al_u1063 (
    .a(_al_u1061_o),
    .b(\norm/hlfc_r [5]),
    .c(_al_u1062_o),
    .d(hctl_cbus_out_lutinv),
    .e(hctl_ccmd_int),
    .o(cbus[5]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1064 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [6]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [6]),
    .o(_al_u1064_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~A*~(E*~C*B)))"),
    .INIT(32'h00ae00aa))
    _al_u1065 (
    .a(_al_u1056_o),
    .b(\norm/mux37_b0_sel_is_2_o ),
    .c(hctl_ccmd_cmp),
    .d(hctl_ccmd_reg),
    .e(\norm/hlfc_f [6]),
    .o(_al_u1065_o));
  AL_MAP_LUT5 #(
    .EQN("(D*(~(~B*~A)*~(C)*~(E)+~(~B*~A)*C*~(E)+~(~(~B*~A))*C*E+~(~B*~A)*C*E))"),
    .INIT(32'hf000ee00))
    _al_u1066 (
    .a(_al_u1064_o),
    .b(_al_u1065_o),
    .c(\norm/hlfc_r [4]),
    .d(hctl_cbus_out_lutinv),
    .e(hctl_ccmd_int),
    .o(cbus[4]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1067 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [5]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [5]),
    .o(_al_u1067_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(E*C))*~(B)*~(D)+~(~A*~(E*C))*B*~(D)+~(~(~A*~(E*C)))*B*D+~(~A*~(E*C))*B*D)"),
    .INIT(32'h33053355))
    _al_u1068 (
    .a(_al_u1067_o),
    .b(\norm/hlfc_r [3]),
    .c(_al_u1027_o),
    .d(hctl_ccmd_int),
    .e(\norm/hlfc_f [5]),
    .o(_al_u1068_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1069 (
    .a(_al_u1068_o),
    .b(hctl_cbus_out_lutinv),
    .o(cbus[3]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1070 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [4]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [4]),
    .o(_al_u1070_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(E*C))*~(B)*~(D)+~(~A*~(E*C))*B*~(D)+~(~(~A*~(E*C)))*B*D+~(~A*~(E*C))*B*D)"),
    .INIT(32'h33053355))
    _al_u1071 (
    .a(_al_u1070_o),
    .b(\norm/hlfc_r [2]),
    .c(_al_u1027_o),
    .d(hctl_ccmd_int),
    .e(\norm/hlfc_f [4]),
    .o(_al_u1071_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1072 (
    .a(_al_u1071_o),
    .b(hctl_cbus_out_lutinv),
    .o(cbus[2]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1073 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [3]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [3]),
    .o(_al_u1073_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(E*C))*~(B)*~(D)+~(~A*~(E*C))*B*~(D)+~(~(~A*~(E*C)))*B*D+~(~A*~(E*C))*B*D)"),
    .INIT(32'h33053355))
    _al_u1074 (
    .a(_al_u1073_o),
    .b(\norm/hlfc_r [1]),
    .c(_al_u1027_o),
    .d(hctl_ccmd_int),
    .e(\norm/hlfc_f [3]),
    .o(_al_u1074_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1075 (
    .a(_al_u1074_o),
    .b(hctl_cbus_out_lutinv),
    .o(cbus[1]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*D)*~(B*A)))"),
    .INIT(32'hf0808080))
    _al_u1076 (
    .a(_al_u1044_o),
    .b(\norm/hlfc_r [2]),
    .c(_al_u1020_o),
    .d(hctl_ccmd_hlf),
    .e(\norm/hlfc_f [2]),
    .o(_al_u1076_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E*C))*~(B)*~(D)+(~A*~(E*C))*B*~(D)+~((~A*~(E*C)))*B*D+(~A*~(E*C))*B*D)"),
    .INIT(32'hcc05cc55))
    _al_u1077 (
    .a(_al_u1076_o),
    .b(_al_u860_o),
    .c(_al_u1027_o),
    .d(hctl_ccmd_int),
    .e(\norm/hlfc_f [2]),
    .o(_al_u1077_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1078 (
    .a(_al_u1077_o),
    .b(hctl_cbus_out_lutinv),
    .o(cbus[0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1079 (
    .a(\hdiv/fdiv/rem3 [13]),
    .o(hlfc_r_hdiv[4]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1080 (
    .a(\hdiv/fdiv/rem2 [13]),
    .o(hlfc_r_hdiv[3]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1081 (
    .a(\hdiv/fdiv/rem1 [13]),
    .o(hlfc_r_hdiv[2]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1082 (
    .a(\hdiv/rem [12]),
    .o(hlfc_r_hdiv[1]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1083 (
    .a(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n0 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u376 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[0]),
    .o(\hadd/hlfa_f [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u377 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[1]),
    .o(\hadd/hlfa_f [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u378 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[10]),
    .o(\hadd/hlfa_f [10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u379 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[11]),
    .o(\hadd/hlfa_f [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u380 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[12]),
    .o(\hadd/hlfa_f [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u381 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[13]),
    .o(\hadd/hlfa_f [13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u382 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[14]),
    .o(\hadd/hlfa_f [14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u383 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[15]),
    .o(\hadd/hlfa_f [15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u384 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[2]),
    .o(\hadd/hlfa_f [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u385 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[3]),
    .o(\hadd/hlfa_f [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u386 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[4]),
    .o(\hadd/hlfa_f [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u387 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[5]),
    .o(\hadd/hlfa_f [5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u388 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[6]),
    .o(\hadd/hlfa_f [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u389 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[7]),
    .o(\hadd/hlfa_f [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u390 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[8]),
    .o(\hadd/hlfa_f [8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u391 (
    .a(hctl_ccmd_add),
    .b(hlfa_r[9]),
    .o(\hadd/hlfa_f [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u392 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[0]),
    .o(\hadd/hlfb_f [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u393 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[1]),
    .o(\hadd/hlfb_f [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u394 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[10]),
    .o(\hadd/hlfb_f [10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u395 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[11]),
    .o(\hadd/hlfb_f [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u396 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[12]),
    .o(\hadd/hlfb_f [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u397 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[13]),
    .o(\hadd/hlfb_f [13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u398 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[2]),
    .o(\hadd/hlfb_f [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u399 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[3]),
    .o(\hadd/hlfb_f [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u400 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[4]),
    .o(\hadd/hlfb_f [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u401 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[5]),
    .o(\hadd/hlfb_f [5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u402 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[6]),
    .o(\hadd/hlfb_f [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u403 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[7]),
    .o(\hadd/hlfb_f [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u404 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[8]),
    .o(\hadd/hlfb_f [8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u405 (
    .a(hctl_ccmd_add),
    .b(hlfb_r[9]),
    .o(\hadd/hlfb_f [9]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u406 (
    .a(hctl_ccmd_sub),
    .b(\hlfb/hlfb_i [15]),
    .o(hlfb_r[22]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u407 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[9]),
    .o(hfpu_dsp_b[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u408 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[8]),
    .o(hfpu_dsp_b[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u409 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[7]),
    .o(hfpu_dsp_b[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u410 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[6]),
    .o(hfpu_dsp_b[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u411 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[5]),
    .o(hfpu_dsp_b[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u412 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[4]),
    .o(hfpu_dsp_b[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u413 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[3]),
    .o(hfpu_dsp_b[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u414 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[2]),
    .o(hfpu_dsp_b[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u415 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[12]),
    .o(hfpu_dsp_b[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u416 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[11]),
    .o(hfpu_dsp_b[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u417 (
    .a(hctl_ccmd_mul),
    .b(hlfb_r[10]),
    .o(hfpu_dsp_b[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u418 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[9]),
    .o(hfpu_dsp_a[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u419 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[8]),
    .o(hfpu_dsp_a[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u420 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[7]),
    .o(hfpu_dsp_a[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u421 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[6]),
    .o(hfpu_dsp_a[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u422 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[5]),
    .o(hfpu_dsp_a[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u423 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[4]),
    .o(hfpu_dsp_a[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u424 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[3]),
    .o(hfpu_dsp_a[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u425 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[2]),
    .o(hfpu_dsp_a[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u426 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[12]),
    .o(hfpu_dsp_a[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u427 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[11]),
    .o(hfpu_dsp_a[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u428 (
    .a(hctl_ccmd_mul),
    .b(hlfa_r[10]),
    .o(hfpu_dsp_a[8]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u429 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [11]),
    .o(\hdiv/fdiv/n3 [11]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u430 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [10]),
    .o(\hdiv/fdiv/n3 [10]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u431 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [9]),
    .o(\hdiv/fdiv/n3 [9]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u432 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [8]),
    .o(\hdiv/fdiv/n3 [8]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u433 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [7]),
    .o(\hdiv/fdiv/n3 [7]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u434 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [6]),
    .o(\hdiv/fdiv/n3 [6]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u435 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [5]),
    .o(\hdiv/fdiv/n3 [5]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u436 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [4]),
    .o(\hdiv/fdiv/n3 [4]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u437 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [3]),
    .o(\hdiv/fdiv/n3 [3]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u438 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [2]),
    .o(\hdiv/fdiv/n3 [2]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u439 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [1]),
    .o(\hdiv/fdiv/n3 [1]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u440 (
    .a(\hdiv/fdiv/rem3 [13]),
    .b(\hdiv/den [0]),
    .o(\hdiv/fdiv/n3 [0]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u441 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [11]),
    .o(\hdiv/fdiv/n5 [11]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u442 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [10]),
    .o(\hdiv/fdiv/n5 [10]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u443 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [9]),
    .o(\hdiv/fdiv/n5 [9]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u444 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [8]),
    .o(\hdiv/fdiv/n5 [8]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u445 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [7]),
    .o(\hdiv/fdiv/n5 [7]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u446 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [6]),
    .o(\hdiv/fdiv/n5 [6]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u447 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [5]),
    .o(\hdiv/fdiv/n5 [5]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u448 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [4]),
    .o(\hdiv/fdiv/n5 [4]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u449 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [3]),
    .o(\hdiv/fdiv/n5 [3]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u450 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [2]),
    .o(\hdiv/fdiv/n5 [2]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u451 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [1]),
    .o(\hdiv/fdiv/n5 [1]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u452 (
    .a(\hdiv/fdiv/rem2 [13]),
    .b(\hdiv/den [0]),
    .o(\hdiv/fdiv/n5 [0]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u453 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [11]),
    .o(\hdiv/fdiv/n7 [11]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u454 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [10]),
    .o(\hdiv/fdiv/n7 [10]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u455 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [9]),
    .o(\hdiv/fdiv/n7 [9]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u456 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [8]),
    .o(\hdiv/fdiv/n7 [8]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u457 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [7]),
    .o(\hdiv/fdiv/n7 [7]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u458 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [6]),
    .o(\hdiv/fdiv/n7 [6]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u459 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [5]),
    .o(\hdiv/fdiv/n7 [5]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u460 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [4]),
    .o(\hdiv/fdiv/n7 [4]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u461 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [3]),
    .o(\hdiv/fdiv/n7 [3]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u462 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [2]),
    .o(\hdiv/fdiv/n7 [2]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u463 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [1]),
    .o(\hdiv/fdiv/n7 [1]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u464 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(\hdiv/den [0]),
    .o(\hdiv/fdiv/n7 [0]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u465 (
    .a(\hdiv/den [11]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [11]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u466 (
    .a(\hdiv/den [10]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [10]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u467 (
    .a(\hdiv/den [9]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [9]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u468 (
    .a(\hdiv/den [8]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [8]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u469 (
    .a(\hdiv/den [7]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [7]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u470 (
    .a(\hdiv/den [6]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [6]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u471 (
    .a(\hdiv/den [5]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [5]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u472 (
    .a(\hdiv/den [4]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [4]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u473 (
    .a(\hdiv/den [3]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [3]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u474 (
    .a(\hdiv/den [2]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [2]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u475 (
    .a(\hdiv/den [1]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [1]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u476 (
    .a(\hdiv/den [0]),
    .b(\hdiv/dso [23]),
    .o(\hdiv/fdiv/n1 [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u477 (
    .a(\hctl/stat [0]),
    .b(\hctl/stat [3]),
    .o(_al_u477_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*B*A)"),
    .INIT(8'hf7))
    _al_u478 (
    .a(_al_u477_o),
    .b(\hctl/stat [1]),
    .c(\hctl/stat [2]),
    .o(\hctl/n168 ));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u479 (
    .a(hlfb_r[22]),
    .b(hlfa_r[22]),
    .o(_al_u479_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u480 (
    .a(\hadd/n2 [9]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [9]),
    .o(\hadd/n3 [9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u481 (
    .a(\hadd/n2 [8]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [8]),
    .o(\hadd/n3 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u482 (
    .a(\hadd/n2 [7]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [7]),
    .o(\hadd/n3 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u483 (
    .a(\hadd/n2 [6]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [6]),
    .o(\hadd/n3 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u484 (
    .a(\hadd/n2 [5]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [5]),
    .o(\hadd/n3 [5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u485 (
    .a(\hadd/n2 [4]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [4]),
    .o(\hadd/n3 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u486 (
    .a(\hadd/n2 [3]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [3]),
    .o(\hadd/n3 [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u487 (
    .a(\hadd/n2 [2]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [2]),
    .o(\hadd/n3 [2]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u488 (
    .a(\hadd/n2 [15]),
    .b(_al_u479_o),
    .o(\hadd/n3 [15]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u489 (
    .a(\hadd/n2 [14]),
    .b(_al_u479_o),
    .o(\hadd/n3 [14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u490 (
    .a(\hadd/n2 [13]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [13]),
    .o(\hadd/n3 [13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u491 (
    .a(\hadd/n2 [12]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [12]),
    .o(\hadd/n3 [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u492 (
    .a(\hadd/n2 [11]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [11]),
    .o(\hadd/n3 [11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u493 (
    .a(\hadd/n2 [10]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [10]),
    .o(\hadd/n3 [10]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u494 (
    .a(\hadd/n2 [1]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [1]),
    .o(\hadd/n3 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u495 (
    .a(\hadd/n2 [0]),
    .b(_al_u479_o),
    .c(\hadd/hlfb_f [0]),
    .o(\hadd/n3 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*(A*B*C*~(D)+~(A)*~(B)*~(C)*D))"),
    .INIT(32'h01800000))
    _al_u496 (
    .a(\hlfa/ccmd_f [0]),
    .b(\hlfa/ccmd_f [1]),
    .c(\hlfa/ccmd_f [2]),
    .d(\hlfa/ccmd_f [3]),
    .e(\hlfa/ccmd_f [4]),
    .o(_al_u496_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u497 (
    .a(_al_u496_o),
    .b(hlfb_e[3]),
    .o(\hlfa/hlfb_et [3]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u498 (
    .a(_al_u496_o),
    .b(hlfb_e[2]),
    .o(\hlfa/hlfb_et [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u499 (
    .a(_al_u496_o),
    .b(hlfb_e[1]),
    .o(\hlfa/hlfb_et [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u500 (
    .a(_al_u496_o),
    .b(hlfb_e[0]),
    .o(\hlfa/hlfb_et [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u501 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n17 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u502 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*A)"),
    .INIT(32'h02000000))
    _al_u503 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n15 ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u504 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n9 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u505 (
    .a(rst_n),
    .b(\hctl/n168 ),
    .o(\hdiv/n15 ));
  AL_MAP_LUT5 #(
    .EQN("(D*~C*A*~(E@B))"),
    .INIT(32'h08000200))
    _al_u506 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n13 ));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+~(B)*C*D*E))"),
    .INIT(32'h20000008))
    _al_u507 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n31 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(B*A))"),
    .INIT(16'h0070))
    _al_u508 (
    .a(\hctl/stat [0]),
    .b(\hctl/stat [1]),
    .c(\hctl/stat [2]),
    .d(\hctl/stat [3]),
    .o(hctl_dsft_enb));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u509 (
    .a(\hlfa/hlfa_i [5]),
    .b(\hlfa/hlfa_i [6]),
    .c(\hlfa/hlfa_i [7]),
    .d(\hlfa/hlfa_i [8]),
    .e(\hlfa/hlfa_i [9]),
    .o(_al_u509_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u510 (
    .a(\hlfa/hlfa_i [0]),
    .b(\hlfa/hlfa_i [1]),
    .c(\hlfa/hlfa_i [2]),
    .d(\hlfa/hlfa_i [3]),
    .e(\hlfa/hlfa_i [4]),
    .o(_al_u510_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u511 (
    .a(_al_u509_o),
    .b(_al_u510_o),
    .o(\hlfa/n89_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u512 (
    .a(\hlfa/hlfa_i [10]),
    .b(\hlfa/hlfa_i [11]),
    .c(\hlfa/hlfa_i [12]),
    .d(\hlfa/hlfa_i [13]),
    .e(\hlfa/hlfa_i [14]),
    .o(\hlfa/n86_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u513 (
    .a(\hlfa/n89_lutinv ),
    .b(\hlfa/n86_lutinv ),
    .o(hlfa_r[24]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u514 (
    .a(\hlfb/hlfb_i [0]),
    .b(\hlfb/hlfb_i [1]),
    .c(\hlfb/hlfb_i [2]),
    .d(\hlfb/hlfb_i [3]),
    .e(\hlfb/hlfb_i [4]),
    .o(_al_u514_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u515 (
    .a(\hlfb/hlfb_i [5]),
    .b(\hlfb/hlfb_i [6]),
    .c(\hlfb/hlfb_i [7]),
    .d(\hlfb/hlfb_i [8]),
    .e(\hlfb/hlfb_i [9]),
    .o(_al_u515_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u516 (
    .a(_al_u514_o),
    .b(_al_u515_o),
    .o(\hlfb/n66_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u517 (
    .a(\hlfb/hlfb_i [10]),
    .b(\hlfb/hlfb_i [11]),
    .c(\hlfb/hlfb_i [12]),
    .d(\hlfb/hlfb_i [13]),
    .e(\hlfb/hlfb_i [14]),
    .o(\hlfb/n63_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u518 (
    .a(\hlfb/n66_lutinv ),
    .b(\hlfb/n63_lutinv ),
    .o(hlfb_r[24]));
  AL_MAP_LUT5 #(
    .EQN("(~C*A*(~(B)*D*~(E)+~(B)*~(D)*E+B*D*E))"),
    .INIT(32'h08020200))
    _al_u519 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*~A)"),
    .INIT(32'h01000000))
    _al_u520 (
    .a(\hlfa/ccmd_f [0]),
    .b(\hlfa/ccmd_f [1]),
    .c(\hlfa/ccmd_f [2]),
    .d(\hlfa/ccmd_f [3]),
    .e(\hlfa/ccmd_f [4]),
    .o(_al_u520_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*~B))"),
    .INIT(8'hba))
    _al_u521 (
    .a(_al_u520_o),
    .b(_al_u496_o),
    .c(hlfb_e[5]),
    .o(\hlfa/hlfb_et [5]));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*~B))"),
    .INIT(8'hba))
    _al_u522 (
    .a(_al_u520_o),
    .b(_al_u496_o),
    .c(hlfb_e[4]),
    .o(\hlfa/hlfb_et [4]));
  AL_MAP_LUT4 #(
    .EQN("(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h7520))
    _al_u523 (
    .a(\hctl/n168 ),
    .b(hctl_dsft_enb),
    .c(\hdiv/dso [9]),
    .d(hlfa_r[1]),
    .o(\hdiv/n9 [9]));
  AL_MAP_LUT4 #(
    .EQN("(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h7520))
    _al_u524 (
    .a(\hctl/n168 ),
    .b(hctl_dsft_enb),
    .c(\hdiv/dso [8]),
    .d(hlfa_r[0]),
    .o(\hdiv/n9 [8]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbfb3aca0))
    _al_u525 (
    .a(\hdiv/rem [12]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [23]),
    .e(hlfa_r[15]),
    .o(\hdiv/n9 [23]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u526 (
    .a(\hdiv/rem [11]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [22]),
    .e(hlfa_r[14]),
    .o(\hdiv/n9 [22]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u527 (
    .a(\hdiv/rem [10]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [21]),
    .e(hlfa_r[13]),
    .o(\hdiv/n9 [21]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u528 (
    .a(\hdiv/rem [9]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [20]),
    .e(hlfa_r[12]),
    .o(\hdiv/n9 [20]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u529 (
    .a(\hdiv/rem [8]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [19]),
    .e(hlfa_r[11]),
    .o(\hdiv/n9 [19]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u530 (
    .a(\hdiv/rem [7]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [18]),
    .e(hlfa_r[10]),
    .o(\hdiv/n9 [18]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u531 (
    .a(\hdiv/rem [6]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [17]),
    .e(hlfa_r[9]),
    .o(\hdiv/n9 [17]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u532 (
    .a(\hdiv/rem [5]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [16]),
    .e(hlfa_r[8]),
    .o(\hdiv/n9 [16]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u533 (
    .a(\hdiv/rem [4]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [15]),
    .e(hlfa_r[7]),
    .o(\hdiv/n9 [15]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u534 (
    .a(\hdiv/rem [3]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [14]),
    .e(hlfa_r[6]),
    .o(\hdiv/n9 [14]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u535 (
    .a(\hdiv/rem [2]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [13]),
    .e(hlfa_r[5]),
    .o(\hdiv/n9 [13]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u536 (
    .a(\hdiv/rem [1]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [12]),
    .e(hlfa_r[4]),
    .o(\hdiv/n9 [12]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(B)+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(B)+~(E)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B+E*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*B)"),
    .INIT(32'hbfb38c80))
    _al_u537 (
    .a(\hdiv/rem [0]),
    .b(\hctl/n168 ),
    .c(hctl_dsft_enb),
    .d(\hdiv/dso [11]),
    .e(hlfa_r[3]),
    .o(\hdiv/n9 [11]));
  AL_MAP_LUT4 #(
    .EQN("(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h7520))
    _al_u538 (
    .a(\hctl/n168 ),
    .b(hctl_dsft_enb),
    .c(\hdiv/dso [10]),
    .d(hlfa_r[2]),
    .o(\hdiv/n9 [10]));
  AL_MAP_LUT5 #(
    .EQN("(E*B*A*~(~D*~C))"),
    .INIT(32'h88800000))
    _al_u539 (
    .a(\hlfa/hlfa_rsft_fin ),
    .b(\hlfa/hlfa_lsft_fin ),
    .c(\hlfb/n67 ),
    .d(hctl_ccmd_int),
    .e(\hctl/stat [0]),
    .o(_al_u539_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E)"),
    .INIT(32'h0003303a))
    _al_u540 (
    .a(_al_u539_o),
    .b(\hctl/stat [0]),
    .c(\hctl/stat [1]),
    .d(\hctl/stat [2]),
    .e(\hctl/stat [3]),
    .o(hctl_load_c));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u541 (
    .a(ccmd[3]),
    .b(ccmd[2]),
    .c(ccmd[1]),
    .d(ccmd[0]),
    .o(_al_u541_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u542 (
    .a(\hctl/stat [1]),
    .b(\hctl/stat [3]),
    .o(_al_u542_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u543 (
    .a(ccmd[4]),
    .b(_al_u542_o),
    .c(\hctl/stat [0]),
    .d(\hctl/stat [2]),
    .o(_al_u543_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~A*~(D*C))"),
    .INIT(16'h0444))
    _al_u544 (
    .a(_al_u541_o),
    .b(_al_u543_o),
    .c(ccmd[3]),
    .d(ccmd[2]),
    .o(hctl_load_a));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+B*~(C)*~(D)*E+~(B)*C*~(D)*E+~(B)*C*D*E))"),
    .INIT(32'h20282808))
    _al_u545 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n27 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u546 (
    .a(hctl_load_a),
    .b(rst_n),
    .o(\hlfa/mux24_b0_sel_is_0_o ));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+~(B)*C*D*~(E)+~(B)*C*D*E))"),
    .INIT(32'h20002008))
    _al_u547 (
    .a(_al_u543_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(_al_u547_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u548 (
    .a(\hctl/stat [1]),
    .b(\hctl/stat [2]),
    .c(\hctl/stat [3]),
    .o(\hctl/n113_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u549 (
    .a(_al_u539_o),
    .b(\hctl/n113_lutinv ),
    .o(\hctl/n131_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u550 (
    .a(\norm/hlfc_f [12]),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [15]),
    .o(_al_u550_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u551 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [10]),
    .c(\norm/hlfc_f [11]),
    .d(\norm/hlfc_f [9]),
    .o(_al_u551_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u552 (
    .a(_al_u551_o),
    .b(\norm/hlfc_f [7]),
    .c(\norm/hlfc_f [8]),
    .o(_al_u552_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u553 (
    .a(_al_u552_o),
    .b(\norm/hlfc_f [5]),
    .c(\norm/hlfc_f [6]),
    .o(_al_u553_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u554 (
    .a(_al_u553_o),
    .b(\norm/hlfc_f [3]),
    .c(\norm/hlfc_f [4]),
    .o(_al_u554_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u555 (
    .a(\norm/hlfc_f [12]),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [15]),
    .o(\norm/n39_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(~E*~D*~C*A))"),
    .INIT(32'h33333331))
    _al_u556 (
    .a(_al_u554_o),
    .b(\norm/n39_lutinv ),
    .c(\norm/hlfc_f [0]),
    .d(\norm/hlfc_f [1]),
    .e(\norm/hlfc_f [2]),
    .o(\hctl/n140_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u557 (
    .a(\hctl/stat [0]),
    .b(\hctl/stat [1]),
    .c(\hctl/stat [2]),
    .d(\hctl/stat [3]),
    .o(hctl_norm_enb_lutinv));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(D*C))"),
    .INIT(16'h0111))
    _al_u558 (
    .a(hctl_load_c),
    .b(\hctl/n131_lutinv ),
    .c(\hctl/n140_lutinv ),
    .d(hctl_norm_enb_lutinv),
    .o(_al_u558_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~D*B*~A))"),
    .INIT(16'hf0b0))
    _al_u559 (
    .a(_al_u547_o),
    .b(_al_u558_o),
    .c(rst_n),
    .d(\hctl/n113_lutinv ),
    .o(\hctl/mux0_b3_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*A)"),
    .INIT(32'h00200000))
    _al_u560 (
    .a(_al_u543_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\hctl/n80_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~(~B*~A))"),
    .INIT(16'h000e))
    _al_u561 (
    .a(_al_u539_o),
    .b(\hctl/stat [1]),
    .c(\hctl/stat [2]),
    .d(\hctl/stat [3]),
    .o(_al_u561_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~A*~(~E*D))"),
    .INIT(32'h01010001))
    _al_u562 (
    .a(\hctl/n80_lutinv ),
    .b(_al_u561_o),
    .c(hctl_dsft_enb),
    .d(\hctl/n113_lutinv ),
    .e(\hctl/stat [0]),
    .o(_al_u562_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*A*(E@D))"),
    .INIT(32'h00080800))
    _al_u563 (
    .a(_al_u543_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(_al_u563_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~B*A*~(E*D)))"),
    .INIT(32'hf0d0d0d0))
    _al_u564 (
    .a(_al_u562_o),
    .b(_al_u563_o),
    .c(rst_n),
    .d(\hctl/n140_lutinv ),
    .e(hctl_norm_enb_lutinv),
    .o(\hctl/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*(C*~(D)*~(E)+C*~(D)*E+~(C)*D*E))"),
    .INIT(32'h02200020))
    _al_u565 (
    .a(_al_u543_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(_al_u565_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(E*~D*C))"),
    .INIT(32'h11011111))
    _al_u566 (
    .a(_al_u563_o),
    .b(_al_u565_o),
    .c(_al_u477_o),
    .d(\hctl/stat [1]),
    .e(\hctl/stat [2]),
    .o(_al_u566_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*A))"),
    .INIT(8'h70))
    _al_u567 (
    .a(_al_u566_o),
    .b(_al_u558_o),
    .c(rst_n),
    .o(\hctl/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(C*(~(A)*B*D*~(E)+A*B*D*~(E)+~(A)*~(B)*~(D)*E+A*~(B)*~(D)*E+~(A)*B*D*E))"),
    .INIT(32'h4030c000))
    _al_u568 (
    .a(\hctl/n140_lutinv ),
    .b(\hctl/stat [0]),
    .c(\hctl/stat [1]),
    .d(\hctl/stat [2]),
    .e(\hctl/stat [3]),
    .o(hctl_cbus_out_lutinv));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u569 (
    .a(hctl_cbus_out_lutinv),
    .b(\hctl/crdy_f ),
    .o(crdy));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffcf3ffd))
    _al_u570 (
    .a(_al_u541_o),
    .b(\hctl/stat [0]),
    .c(\hctl/stat [1]),
    .d(\hctl/stat [2]),
    .e(\hctl/stat [3]),
    .o(_al_u570_o));
  AL_MAP_LUT4 #(
    .EQN("~(~B*A*~(D*~C))"),
    .INIT(16'hdfdd))
    _al_u571 (
    .a(_al_u570_o),
    .b(\hctl/n131_lutinv ),
    .c(\hctl/n140_lutinv ),
    .d(hctl_norm_enb_lutinv),
    .o(\hctl/crdy_t ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u572 (
    .a(\hlfa/ccmd_f [0]),
    .b(\hlfa/ccmd_f [1]),
    .c(\hlfa/ccmd_f [2]),
    .d(\hlfa/ccmd_f [3]),
    .e(\hlfa/ccmd_f [4]),
    .o(_al_u572_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u573 (
    .a(\hlfa/hlfa_i [10]),
    .b(\hlfa/hlfa_i [11]),
    .c(\hlfa/hlfa_i [12]),
    .d(\hlfa/hlfa_i [13]),
    .e(\hlfa/hlfa_i [14]),
    .o(\hlfa/mux29_b22_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*(A*~(B)*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D))"),
    .INIT(32'h03a00000))
    _al_u574 (
    .a(\hlfa/ccmd_f [0]),
    .b(\hlfa/ccmd_f [1]),
    .c(\hlfa/ccmd_f [2]),
    .d(\hlfa/ccmd_f [3]),
    .e(\hlfa/ccmd_f [4]),
    .o(_al_u574_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(~B*A))"),
    .INIT(8'h0d))
    _al_u575 (
    .a(_al_u572_o),
    .b(\hlfa/mux29_b22_sel_is_2_o ),
    .c(_al_u574_o),
    .o(_al_u575_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u576 (
    .a(hctl_ccmd_div),
    .b(hctl_ccmd_reg),
    .o(\norm/mux1_b0_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("(C*~B*~(~E*~(D*A)))"),
    .INIT(32'h30302000))
    _al_u577 (
    .a(hlfa_r[24]),
    .b(_al_u575_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(_al_u572_o),
    .e(hlfa_e[1]),
    .o(_al_u577_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u578 (
    .a(_al_u577_o),
    .b(hlfc_r_hdiv[17]),
    .c(hctl_ccmd_div),
    .o(_al_u578_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(E)*~(C)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*~(C)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*E*C+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*C)"),
    .INIT(32'hfcf50c05))
    _al_u579 (
    .a(_al_u578_o),
    .b(hlfc_r_hmul[17]),
    .c(hctl_ccmd_add),
    .d(hctl_ccmd_mul),
    .e(hlfa_e[1]),
    .o(\norm/hlfc_r [17]));
  AL_MAP_LUT5 #(
    .EQN("(C*~B*~(~E*~(D*A)))"),
    .INIT(32'h30302000))
    _al_u580 (
    .a(hlfa_r[24]),
    .b(_al_u575_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(_al_u572_o),
    .e(hlfa_e[0]),
    .o(_al_u580_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u581 (
    .a(_al_u580_o),
    .b(hlfc_r_hdiv[16]),
    .c(hctl_ccmd_div),
    .o(_al_u581_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(E)*~(C)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*~(C)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*E*C+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*C)"),
    .INIT(32'hfcf50c05))
    _al_u582 (
    .a(_al_u581_o),
    .b(hlfc_r_hmul[16]),
    .c(hctl_ccmd_add),
    .d(hctl_ccmd_mul),
    .e(hlfa_e[0]),
    .o(\norm/hlfc_r [16]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u583 (
    .a(\hctl/stat [0]),
    .b(\hctl/stat [1]),
    .c(\hctl/stat [2]),
    .o(hctl_rsft_enb_lutinv));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u584 (
    .a(\hlfb/n67 ),
    .b(hlfc_r_hdiv[21]),
    .c(hlfc_r_hdiv[20]),
    .d(hctl_rsft_enb_lutinv),
    .e(hctl_ccmd_int),
    .o(_al_u584_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u585 (
    .a(\hlfa/mux24_b0_sel_is_0_o ),
    .b(_al_u584_o),
    .o(\hlfb/mux16_b1_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u586 (
    .a(\hlfb/n67 ),
    .b(hlfc_r_hdiv[21]),
    .c(hlfc_r_hdiv[17]),
    .d(hctl_rsft_enb_lutinv),
    .e(hctl_ccmd_int),
    .o(_al_u586_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u587 (
    .a(\hlfb/n67 ),
    .b(hlfc_r_hdiv[21]),
    .c(hlfc_r_hdiv[16]),
    .d(hctl_rsft_enb_lutinv),
    .e(hctl_ccmd_int),
    .o(_al_u587_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u588 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[13]),
    .o(\hlfb/n50 [13]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u589 (
    .a(\hlfa/hlfa_rsft_fin ),
    .b(\hlfa/hlfa_e_dif [5]),
    .c(\hlfa/hlfa_e_dif [4]),
    .d(hctl_rsft_enb_lutinv),
    .o(_al_u589_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u590 (
    .a(hctl_load_a),
    .b(_al_u589_o),
    .o(\hlfa/mux21_b1_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u591 (
    .a(\hlfa/mux21_b1_sel_is_0_o ),
    .b(rst_n),
    .o(\hlfa/mux24_b1_sel_is_2_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u592 (
    .a(\hlfa/hlfa_lsft_fin ),
    .b(\hlfa/hlfa_e_difl [5]),
    .c(\hctl/n113_lutinv ),
    .d(\hctl/stat [0]),
    .o(\hlfa/n40 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u593 (
    .a(\hlfa/n40 ),
    .b(\hlfa/hlfa_e_difl [1]),
    .o(_al_u593_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u594 (
    .a(\hlfa/n40 ),
    .b(\hlfa/hlfa_e_difl [0]),
    .o(_al_u594_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u595 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[13]),
    .d(hlfa_r[14]),
    .e(hlfa_r[15]),
    .o(\hlfa/n65 [15]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u596 (
    .a(\hlfa/n40 ),
    .b(\hlfa/hlfa_e_difl [4]),
    .c(\hlfa/hlfa_e_difl [3]),
    .o(_al_u596_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u597 (
    .a(\hlfa/n40 ),
    .b(\hlfa/hlfa_e_difl [2]),
    .o(_al_u597_o));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u598 (
    .a(\hlfa/n65 [15]),
    .b(_al_u596_o),
    .c(_al_u597_o),
    .d(hlfa_r[11]),
    .e(hlfa_r[7]),
    .o(\hlfa/n69 [15]));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*B*~A)"),
    .INIT(32'h00400000))
    _al_u599 (
    .a(\hlfa/ccmd_f [0]),
    .b(\hlfa/ccmd_f [1]),
    .c(\hlfa/ccmd_f [2]),
    .d(\hlfa/ccmd_f [3]),
    .e(\hlfa/ccmd_f [4]),
    .o(_al_u599_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B*A))"),
    .INIT(8'h07))
    _al_u600 (
    .a(hlfa_r[24]),
    .b(_al_u572_o),
    .c(_al_u599_o),
    .o(_al_u600_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*~B)))"),
    .INIT(16'h7050))
    _al_u601 (
    .a(_al_u600_o),
    .b(_al_u575_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_e[3]),
    .o(_al_u601_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u602 (
    .a(_al_u601_o),
    .b(hlfc_r_hdiv[19]),
    .c(hctl_ccmd_div),
    .o(_al_u602_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(E)*~(C)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*~(C)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*E*C+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*C)"),
    .INIT(32'hfcf50c05))
    _al_u603 (
    .a(_al_u602_o),
    .b(hlfc_r_hmul[19]),
    .c(hctl_ccmd_add),
    .d(hctl_ccmd_mul),
    .e(hlfa_e[3]),
    .o(\norm/hlfc_r [19]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*~B)))"),
    .INIT(16'h7050))
    _al_u604 (
    .a(_al_u600_o),
    .b(_al_u575_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_e[2]),
    .o(_al_u604_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u605 (
    .a(_al_u604_o),
    .b(hlfc_r_hdiv[18]),
    .c(hctl_ccmd_div),
    .o(_al_u605_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(E)*~(C)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*~(C)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*E*C+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*C)"),
    .INIT(32'hfcf50c05))
    _al_u606 (
    .a(_al_u605_o),
    .b(hlfc_r_hmul[18]),
    .c(hctl_ccmd_add),
    .d(hctl_ccmd_mul),
    .e(hlfa_e[2]),
    .o(\norm/hlfc_r [18]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u607 (
    .a(\norm/n12 [1]),
    .b(n7[0]),
    .c(\norm/hlfc_f [11]),
    .o(_al_u607_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(A)*~((C*~B))+D*A*~((C*~B))+~(D)*A*(C*~B)+D*A*(C*~B))"),
    .INIT(16'hef20))
    _al_u608 (
    .a(_al_u607_o),
    .b(_al_u551_o),
    .c(_al_u550_o),
    .d(\norm/hlfc_e [1]),
    .o(\norm/n17 [1]));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D)*~((C*~A))+B*D*~((C*~A))+~(B)*D*(C*~A)+B*D*(C*~A))"),
    .INIT(16'hdc8c))
    _al_u609 (
    .a(_al_u553_o),
    .b(\norm/n17 [1]),
    .c(_al_u552_o),
    .d(n5[0]),
    .o(\norm/n21 [1]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(D)*~(A)+B*D*~(A)+~(B)*D*A+B*D*A)*~(C)*~(E)+(B*~(D)*~(A)+B*D*~(A)+~(B)*D*A+B*D*A)*C*~(E)+~((B*~(D)*~(A)+B*D*~(A)+~(B)*D*A+B*D*A))*C*E+(B*~(D)*~(A)+B*D*~(A)+~(B)*D*A+B*D*A)*C*E)"),
    .INIT(32'hf0f0ee44))
    _al_u610 (
    .a(_al_u554_o),
    .b(\norm/n21 [1]),
    .c(\norm/n6 [1]),
    .d(n3[0]),
    .e(\norm/hlfc_f [13]),
    .o(\norm/n25 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~((A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'hccccf0aa))
    _al_u611 (
    .a(\norm/n25 [1]),
    .b(\norm/n4 [1]),
    .c(\norm/n5 [0]),
    .d(\norm/hlfc_f [14]),
    .e(\norm/hlfc_f [15]),
    .o(\norm/n29 [1]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*~(C)*~(A)+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*~(A)+~((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D))*C*A+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*A)"),
    .INIT(32'he4f5e4a0))
    _al_u612 (
    .a(hctl_load_c),
    .b(\norm/n29 [1]),
    .c(\norm/hlfc_r [17]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_e [1]),
    .o(\norm/n34 [1]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(B)*~((D*A))+C*B*~((D*A))+~(C)*B*(D*A)+C*B*(D*A))"),
    .INIT(16'hd8f0))
    _al_u613 (
    .a(_al_u550_o),
    .b(\norm/n12 [0]),
    .c(\norm/hlfc_e [0]),
    .d(\norm/hlfc_f [11]),
    .o(\norm/n23 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u614 (
    .a(\norm/n23 [0]),
    .b(\norm/n6 [0]),
    .c(\norm/hlfc_f [13]),
    .o(_al_u614_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~((~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h33330faa))
    _al_u615 (
    .a(_al_u614_o),
    .b(\norm/n4 [0]),
    .c(\norm/hlfc_e [0]),
    .d(\norm/hlfc_f [14]),
    .e(\norm/hlfc_f [15]),
    .o(_al_u615_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*~(B)*~(A)+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*B*~(A)+~(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D))*B*A+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*B*A)"),
    .INIT(32'h8ddd8d88))
    _al_u616 (
    .a(hctl_load_c),
    .b(\norm/hlfc_r [16]),
    .c(_al_u615_o),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_e [0]),
    .o(\norm/n34 [0]));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(~C*A))"),
    .INIT(8'h31))
    _al_u617 (
    .a(hlfa_r[24]),
    .b(_al_u575_o),
    .c(_al_u574_o),
    .o(_al_u617_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(E*B*A))"),
    .INIT(32'h07770fff))
    _al_u618 (
    .a(_al_u617_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(hlfc_r_hdiv[20]),
    .d(hctl_ccmd_div),
    .e(hlfa_e[4]),
    .o(_al_u618_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(E)*~(C)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*~(C)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*E*C+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*E*C)"),
    .INIT(32'hfcf50c05))
    _al_u619 (
    .a(_al_u618_o),
    .b(hlfc_r_hmul[20]),
    .c(hctl_ccmd_add),
    .d(hctl_ccmd_mul),
    .e(hlfa_e[4]),
    .o(\norm/hlfc_r [20]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u620 (
    .a(\norm/mux1_b0_sel_is_2_o ),
    .b(hctl_ccmd_mul),
    .o(\norm/mux2_b14_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(E*C)*~(D*A)))"),
    .INIT(32'hc8c08800))
    _al_u621 (
    .a(_al_u617_o),
    .b(\norm/mux2_b14_sel_is_2_o ),
    .c(_al_u599_o),
    .d(hlfa_r[15]),
    .e(hlfa_r[22]),
    .o(\norm/n2 [15]));
  AL_MAP_LUT4 #(
    .EQN("~(C*~((B*A))*~(D)+C*(B*A)*~(D)+~(C)*(B*A)*D+C*(B*A)*D)"),
    .INIT(16'h770f))
    _al_u622 (
    .a(\hadd/n4 [15]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\norm/n2 [15]),
    .d(hctl_ccmd_add),
    .o(_al_u622_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(B)*~(A)+~(D*~C)*B*~(A)+~(~(D*~C))*B*A+~(D*~C)*B*A)"),
    .INIT(16'h2722))
    _al_u623 (
    .a(hctl_load_c),
    .b(_al_u622_o),
    .c(hctl_norm_enb_lutinv),
    .d(\norm/hlfc_f [15]),
    .o(\norm/n35 [15]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(E*C)*~(D*A)))"),
    .INIT(32'hc8c08800))
    _al_u624 (
    .a(_al_u617_o),
    .b(\norm/mux2_b14_sel_is_2_o ),
    .c(_al_u599_o),
    .d(hlfa_r[14]),
    .e(\hlfa/hlfa_i [14]),
    .o(\norm/n2 [14]));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B))*~(E)+D*(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)*~(E)+~(D)*(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)*E+D*(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)*E)"),
    .INIT(32'h474700ff))
    _al_u625 (
    .a(\hadd/n4 [14]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [14]),
    .d(\norm/n2 [14]),
    .e(hctl_ccmd_add),
    .o(_al_u625_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(B)*~(A)+~(D*~C)*B*~(A)+~(~(D*~C))*B*A+~(D*~C)*B*A)"),
    .INIT(16'h2722))
    _al_u626 (
    .a(hctl_load_c),
    .b(_al_u625_o),
    .c(hctl_norm_enb_lutinv),
    .d(\norm/hlfc_f [14]),
    .o(\norm/n35 [14]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u627 (
    .a(hlfa_r[24]),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(_al_u574_o),
    .o(_al_u627_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*~C*~B))"),
    .INIT(16'h5455))
    _al_u628 (
    .a(_al_u627_o),
    .b(hlfb_r[24]),
    .c(\hlfa/mux29_b22_sel_is_2_o ),
    .d(hctl_ccmd_div),
    .o(_al_u628_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u629 (
    .a(hlfb_r[24]),
    .b(\hlfa/mux29_b22_sel_is_2_o ),
    .o(_al_u629_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u630 (
    .a(\hlfb/hlfb_i [10]),
    .b(\hlfb/hlfb_i [11]),
    .c(\hlfb/hlfb_i [12]),
    .d(\hlfb/hlfb_i [13]),
    .e(\hlfb/hlfb_i [14]),
    .o(_al_u630_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E)"),
    .INIT(32'h0cfc5550))
    _al_u631 (
    .a(_al_u628_o),
    .b(_al_u629_o),
    .c(hlfa_r[24]),
    .d(_al_u630_o),
    .e(hctl_ccmd_mul),
    .o(\norm/n2 [24]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u632 (
    .a(\norm/n2 [24]),
    .b(hlfc_r_hadd[24]),
    .c(hctl_ccmd_add),
    .o(\norm/hlfc_r [24]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u633 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[1]),
    .d(hlfb_r[2]),
    .e(hlfb_r[3]),
    .o(\hlfb/n50 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u634 (
    .a(\hlfb/n67 ),
    .b(hlfc_r_hdiv[21]),
    .c(hlfc_r_hdiv[18]),
    .d(hctl_rsft_enb_lutinv),
    .e(hctl_ccmd_int),
    .o(_al_u634_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u635 (
    .a(\hlfb/n67 ),
    .b(hlfc_r_hdiv[21]),
    .c(hlfc_r_hdiv[19]),
    .d(hctl_rsft_enb_lutinv),
    .e(hctl_ccmd_int),
    .o(_al_u635_o));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hfef20e02))
    _al_u636 (
    .a(\hlfb/n50 [1]),
    .b(_al_u634_o),
    .c(_al_u635_o),
    .d(hlfb_r[5]),
    .e(hlfb_r[9]),
    .o(\hlfb/n54 [1]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u637 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[12]),
    .d(hlfa_r[13]),
    .e(hlfa_r[14]),
    .o(_al_u637_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u638 (
    .a(_al_u637_o),
    .b(_al_u597_o),
    .c(hlfa_r[10]),
    .o(_al_u638_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u639 (
    .a(\hlfa/hlfa_rsft_fin ),
    .b(\hlfa/hlfa_e_dif [5]),
    .c(\hlfa/hlfa_e_dif [0]),
    .d(hctl_rsft_enb_lutinv),
    .o(_al_u639_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'hfd0df101))
    _al_u640 (
    .a(_al_u638_o),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(hlfa_r[15]),
    .e(hlfa_r[6]),
    .o(\hlfa/n71 [14]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u641 (
    .a(hlfc_r_hdiv[5]),
    .b(hlfc_r_hdiv[6]),
    .c(hlfc_r_hdiv[7]),
    .d(hlfc_r_hdiv[8]),
    .o(_al_u641_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u642 (
    .a(\hdiv/rem [12]),
    .b(\hdiv/fdiv/rem1 [13]),
    .c(\hdiv/fdiv/rem2 [13]),
    .d(\hdiv/fdiv/rem3 [13]),
    .e(_al_u641_o),
    .o(_al_u642_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u643 (
    .a(hlfa_r[24]),
    .b(hlfb_r[24]),
    .o(\hdiv/inf_zer_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u644 (
    .a(hlfc_r_hdiv[9]),
    .b(hlfc_r_hdiv[10]),
    .c(hlfc_r_hdiv[11]),
    .d(hlfc_r_hdiv[12]),
    .o(_al_u644_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~B*~(C*A)))"),
    .INIT(16'hec00))
    _al_u645 (
    .a(_al_u642_o),
    .b(\hdiv/inf_zer_lutinv ),
    .c(_al_u644_o),
    .d(hctl_ccmd_div),
    .o(_al_u645_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*A)"),
    .INIT(32'h02000000))
    _al_u646 (
    .a(\hlfa/ccmd_f [0]),
    .b(\hlfa/ccmd_f [1]),
    .c(\hlfa/ccmd_f [2]),
    .d(\hlfa/ccmd_f [3]),
    .e(\hlfa/ccmd_f [4]),
    .o(_al_u646_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*A)"),
    .INIT(32'h00200000))
    _al_u647 (
    .a(\hlfa/ccmd_f [0]),
    .b(\hlfa/ccmd_f [1]),
    .c(\hlfa/ccmd_f [2]),
    .d(\hlfa/ccmd_f [3]),
    .e(\hlfa/ccmd_f [4]),
    .o(_al_u647_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u648 (
    .a(_al_u496_o),
    .b(_al_u572_o),
    .c(_al_u646_o),
    .d(_al_u647_o),
    .o(_al_u648_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*C*B))"),
    .INIT(16'haa2a))
    _al_u649 (
    .a(_al_u648_o),
    .b(\hlfa/n89_lutinv ),
    .c(_al_u599_o),
    .d(hlfa_r[22]),
    .o(_al_u649_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*~B))"),
    .INIT(16'h4555))
    _al_u650 (
    .a(_al_u645_o),
    .b(_al_u649_o),
    .c(\hlfa/mux29_b22_sel_is_2_o ),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .o(_al_u650_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u651 (
    .a(hfpu_dsp_c[14]),
    .b(hfpu_dsp_c[11]),
    .c(hfpu_dsp_c[10]),
    .d(hfpu_dsp_c[8]),
    .o(_al_u651_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*~A)"),
    .INIT(16'h0100))
    _al_u652 (
    .a(hfpu_dsp_c[20]),
    .b(hfpu_dsp_c[17]),
    .c(hfpu_dsp_c[16]),
    .d(hctl_ccmd_mul),
    .o(_al_u652_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u653 (
    .a(_al_u651_o),
    .b(_al_u652_o),
    .c(hfpu_dsp_c[13]),
    .d(hfpu_dsp_c[12]),
    .e(hfpu_dsp_c[9]),
    .o(_al_u653_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u654 (
    .a(_al_u653_o),
    .b(hfpu_dsp_c[21]),
    .c(hfpu_dsp_c[19]),
    .d(hfpu_dsp_c[18]),
    .e(hfpu_dsp_c[15]),
    .o(_al_u654_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u655 (
    .a(\hadd/n4 [3]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [3]),
    .o(_al_u655_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u656 (
    .a(\hadd/n4 [2]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [2]),
    .o(_al_u656_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u657 (
    .a(\hadd/n4 [1]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [1]),
    .o(_al_u657_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u658 (
    .a(\hadd/hlfc_f_t [15]),
    .b(\hadd/n4 [0]),
    .c(\hadd/hlfc_f_t [0]),
    .o(_al_u658_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u659 (
    .a(_al_u655_o),
    .b(_al_u656_o),
    .c(_al_u657_o),
    .d(_al_u658_o),
    .o(_al_u659_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u660 (
    .a(\hadd/n4 [7]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [7]),
    .o(_al_u660_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u661 (
    .a(\hadd/n4 [6]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [6]),
    .o(_al_u661_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u662 (
    .a(\hadd/n4 [5]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [5]),
    .o(_al_u662_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u663 (
    .a(\hadd/n4 [4]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [4]),
    .o(_al_u663_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u664 (
    .a(_al_u659_o),
    .b(_al_u660_o),
    .c(_al_u661_o),
    .d(_al_u662_o),
    .e(_al_u663_o),
    .o(_al_u664_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u665 (
    .a(\hadd/n4 [13]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [13]),
    .o(_al_u665_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u666 (
    .a(\hadd/n4 [11]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [11]),
    .o(_al_u666_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u667 (
    .a(\hadd/n4 [10]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [10]),
    .o(_al_u667_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u668 (
    .a(\hadd/n4 [9]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [9]),
    .o(_al_u668_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u669 (
    .a(_al_u665_o),
    .b(_al_u666_o),
    .c(_al_u667_o),
    .d(_al_u668_o),
    .o(_al_u669_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~((~B*~A))*~(C)+~D*(~B*~A)*~(C)+~(~D)*(~B*~A)*C+~D*(~B*~A)*C)"),
    .INIT(16'hefe0))
    _al_u670 (
    .a(\hadd/n4 [15]),
    .b(\hadd/n4 [14]),
    .c(\hadd/hlfc_f_t [15]),
    .d(\hadd/hlfc_f_t [14]),
    .o(\hadd/eq0/or_xor_i0[14]_i1[14]_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u671 (
    .a(\hadd/n4 [12]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [12]),
    .o(_al_u671_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u672 (
    .a(\hadd/n4 [8]),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/hlfc_f_t [8]),
    .o(_al_u672_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u673 (
    .a(_al_u664_o),
    .b(_al_u669_o),
    .c(\hadd/eq0/or_xor_i0[14]_i1[14]_o_lutinv ),
    .d(_al_u671_o),
    .e(_al_u672_o),
    .o(hlfc_r_hadd[23]));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(~E*~A))*~(C)*~(D)+~(~B*~(~E*~A))*C*~(D)+~(~(~B*~(~E*~A)))*C*D+~(~B*~(~E*~A))*C*D)"),
    .INIT(32'hf0ccf0dd))
    _al_u674 (
    .a(_al_u650_o),
    .b(_al_u654_o),
    .c(hlfc_r_hadd[23]),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [23]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*A))"),
    .INIT(8'hc4))
    _al_u675 (
    .a(_al_u599_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(\hlfa/hlfa_i [9]),
    .o(_al_u675_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u676 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(_al_u675_o),
    .d(hlfa_r[9]),
    .o(_al_u676_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~B*~(E*C))*~(A)*~(D)+~(~B*~(E*C))*A*~(D)+~(~(~B*~(E*C)))*A*D+~(~B*~(E*C))*A*D)"),
    .INIT(32'h55035533))
    _al_u677 (
    .a(hfpu_dsp_c[17]),
    .b(_al_u676_o),
    .c(hctl_ccmd_div),
    .d(hctl_ccmd_mul),
    .e(hlfc_r_hdiv[9]),
    .o(_al_u677_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u678 (
    .a(_al_u677_o),
    .b(_al_u668_o),
    .c(hctl_ccmd_add),
    .o(\norm/hlfc_r [9]));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'h028a57df))
    _al_u679 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [7]),
    .d(\norm/hlfc_f [8]),
    .e(\norm/hlfc_f [9]),
    .o(_al_u679_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u680 (
    .a(_al_u551_o),
    .b(_al_u679_o),
    .c(\norm/hlfc_f [5]),
    .o(\norm/n18 [9]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u681 (
    .a(\norm/n18 [9]),
    .b(_al_u552_o),
    .c(\norm/hlfc_f [3]),
    .o(_al_u681_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'h5101))
    _al_u682 (
    .a(_al_u554_o),
    .b(_al_u681_o),
    .c(_al_u553_o),
    .d(\norm/hlfc_f [1]),
    .o(\norm/n24 [9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u683 (
    .a(\norm/n24 [9]),
    .b(\norm/hlfc_f [10]),
    .c(\norm/hlfc_f [13]),
    .o(\norm/n26 [9]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u684 (
    .a(\norm/n26 [9]),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [12]),
    .d(\norm/hlfc_f [14]),
    .e(\norm/hlfc_f [15]),
    .o(\norm/n30 [9]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'hb8bbb888))
    _al_u685 (
    .a(\norm/hlfc_r [9]),
    .b(hctl_load_c),
    .c(\norm/n30 [9]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [9]),
    .o(\norm/n35 [9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*A))"),
    .INIT(8'hc4))
    _al_u686 (
    .a(_al_u599_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(\hlfa/hlfa_i [8]),
    .o(_al_u686_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u687 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(_al_u686_o),
    .d(hlfa_r[8]),
    .o(_al_u687_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~B*~(E*C))*~(A)*~(D)+~(~B*~(E*C))*A*~(D)+~(~(~B*~(E*C)))*A*D+~(~B*~(E*C))*A*D)"),
    .INIT(32'h55035533))
    _al_u688 (
    .a(hfpu_dsp_c[16]),
    .b(_al_u687_o),
    .c(hctl_ccmd_div),
    .d(hctl_ccmd_mul),
    .e(hlfc_r_hdiv[8]),
    .o(_al_u688_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u689 (
    .a(_al_u688_o),
    .b(_al_u672_o),
    .c(hctl_ccmd_add),
    .o(\norm/hlfc_r [8]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'hfd75a820))
    _al_u690 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [6]),
    .d(\norm/hlfc_f [7]),
    .e(\norm/hlfc_f [8]),
    .o(\norm/n16 [8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u691 (
    .a(_al_u551_o),
    .b(\norm/n16 [8]),
    .c(\norm/hlfc_f [4]),
    .o(\norm/n18 [8]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u692 (
    .a(\norm/n18 [8]),
    .b(_al_u552_o),
    .c(\norm/hlfc_f [2]),
    .o(_al_u692_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'h5101))
    _al_u693 (
    .a(_al_u554_o),
    .b(_al_u692_o),
    .c(_al_u553_o),
    .d(\norm/hlfc_f [0]),
    .o(\norm/n24 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u694 (
    .a(\norm/n24 [8]),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [9]),
    .o(\norm/n26 [8]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u695 (
    .a(\norm/n26 [8]),
    .b(\norm/hlfc_f [10]),
    .c(\norm/hlfc_f [11]),
    .d(\norm/hlfc_f [14]),
    .e(\norm/hlfc_f [15]),
    .o(\norm/n30 [8]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'hb8bbb888))
    _al_u696 (
    .a(\norm/hlfc_r [8]),
    .b(hctl_load_c),
    .c(\norm/n30 [8]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [8]),
    .o(\norm/n35 [8]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*A))"),
    .INIT(8'hc4))
    _al_u697 (
    .a(_al_u599_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(\hlfa/hlfa_i [7]),
    .o(_al_u697_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u698 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(_al_u697_o),
    .d(hlfa_r[7]),
    .o(_al_u698_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~B*~(E*C))*~(A)*~(D)+~(~B*~(E*C))*A*~(D)+~(~(~B*~(E*C)))*A*D+~(~B*~(E*C))*A*D)"),
    .INIT(32'h55035533))
    _al_u699 (
    .a(hfpu_dsp_c[15]),
    .b(_al_u698_o),
    .c(hctl_ccmd_div),
    .d(hctl_ccmd_mul),
    .e(hlfc_r_hdiv[7]),
    .o(_al_u699_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u700 (
    .a(_al_u699_o),
    .b(_al_u660_o),
    .c(hctl_ccmd_add),
    .o(\norm/hlfc_r [7]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'hfd75a820))
    _al_u701 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [5]),
    .d(\norm/hlfc_f [6]),
    .e(\norm/hlfc_f [7]),
    .o(\norm/n16 [7]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u702 (
    .a(_al_u552_o),
    .b(_al_u551_o),
    .c(\norm/n16 [7]),
    .d(\norm/hlfc_f [1]),
    .e(\norm/hlfc_f [3]),
    .o(_al_u702_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*~A)*~(D)*~(C)+(~B*~A)*D*~(C)+~((~B*~A))*D*C+(~B*~A)*D*C)"),
    .INIT(16'h0efe))
    _al_u703 (
    .a(_al_u553_o),
    .b(_al_u702_o),
    .c(\norm/hlfc_f [13]),
    .d(\norm/hlfc_f [8]),
    .o(_al_u703_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(B)*~(D)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B*~(D)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*B*D+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B*D)"),
    .INIT(32'hccf5cc05))
    _al_u704 (
    .a(_al_u703_o),
    .b(\norm/hlfc_f [10]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [15]),
    .e(\norm/hlfc_f [9]),
    .o(\norm/n30 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'hb8bbb888))
    _al_u705 (
    .a(\norm/hlfc_r [7]),
    .b(hctl_load_c),
    .c(\norm/n30 [7]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [7]),
    .o(\norm/n35 [7]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u706 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[6]),
    .o(_al_u706_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(A*~(~E*B)))"),
    .INIT(32'h05550ddd))
    _al_u707 (
    .a(_al_u706_o),
    .b(_al_u599_o),
    .c(hctl_ccmd_div),
    .d(hlfc_r_hdiv[6]),
    .e(\hlfa/hlfa_i [6]),
    .o(_al_u707_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*~(B)*~(D)+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*~(D)+~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E))*B*D+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*D)"),
    .INIT(32'h33aa330f))
    _al_u708 (
    .a(hfpu_dsp_c[14]),
    .b(_al_u661_o),
    .c(_al_u707_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [6]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'hfd75a820))
    _al_u709 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [4]),
    .d(\norm/hlfc_f [5]),
    .e(\norm/hlfc_f [6]),
    .o(\norm/n16 [6]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u710 (
    .a(_al_u552_o),
    .b(_al_u551_o),
    .c(\norm/n16 [6]),
    .d(\norm/hlfc_f [0]),
    .e(\norm/hlfc_f [2]),
    .o(_al_u710_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*~A)*~(D)*~(C)+(~B*~A)*D*~(C)+~((~B*~A))*D*C+(~B*~A)*D*C)"),
    .INIT(16'h0efe))
    _al_u711 (
    .a(_al_u553_o),
    .b(_al_u710_o),
    .c(\norm/hlfc_f [13]),
    .d(\norm/hlfc_f [7]),
    .o(_al_u711_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hfdf10d01))
    _al_u712 (
    .a(_al_u711_o),
    .b(\norm/hlfc_f [14]),
    .c(\norm/hlfc_f [15]),
    .d(\norm/hlfc_f [8]),
    .e(\norm/hlfc_f [9]),
    .o(\norm/n30 [6]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'hb8bbb888))
    _al_u713 (
    .a(\norm/hlfc_r [6]),
    .b(hctl_load_c),
    .c(\norm/n30 [6]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [6]),
    .o(\norm/n35 [6]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u714 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[5]),
    .o(_al_u714_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(A*~(~E*B)))"),
    .INIT(32'h05550ddd))
    _al_u715 (
    .a(_al_u714_o),
    .b(_al_u599_o),
    .c(hctl_ccmd_div),
    .d(hlfc_r_hdiv[5]),
    .e(\hlfa/hlfa_i [5]),
    .o(_al_u715_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*~(B)*~(D)+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*~(D)+~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E))*B*D+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*D)"),
    .INIT(32'h33aa330f))
    _al_u716 (
    .a(hfpu_dsp_c[13]),
    .b(_al_u662_o),
    .c(_al_u715_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [5]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'hfd75a820))
    _al_u717 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [3]),
    .d(\norm/hlfc_f [4]),
    .e(\norm/hlfc_f [5]),
    .o(\norm/n16 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h5410))
    _al_u718 (
    .a(_al_u552_o),
    .b(_al_u551_o),
    .c(\norm/n16 [5]),
    .d(\norm/hlfc_f [1]),
    .o(\norm/n24 [5]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u719 (
    .a(\norm/n24 [5]),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [6]),
    .e(\norm/hlfc_f [7]),
    .o(_al_u719_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u720 (
    .a(_al_u719_o),
    .b(\norm/hlfc_f [15]),
    .c(\norm/hlfc_f [8]),
    .o(\norm/n30 [5]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf8bbf888))
    _al_u721 (
    .a(\norm/hlfc_r [5]),
    .b(hctl_load_c),
    .c(\norm/n30 [5]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [5]),
    .o(\norm/n35 [5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*A))"),
    .INIT(8'hc4))
    _al_u722 (
    .a(_al_u599_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(\hlfa/hlfa_i [4]),
    .o(_al_u722_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u723 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(_al_u722_o),
    .d(hlfa_r[4]),
    .o(_al_u723_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~B*~(D*~C))*~(A)*~(E)+~(~B*~(D*~C))*A*~(E)+~(~(~B*~(D*~C)))*A*E+~(~B*~(D*~C))*A*E)"),
    .INIT(32'h55553033))
    _al_u724 (
    .a(hfpu_dsp_c[12]),
    .b(_al_u723_o),
    .c(\hdiv/fdiv/rem3 [13]),
    .d(hctl_ccmd_div),
    .e(hctl_ccmd_mul),
    .o(_al_u724_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u725 (
    .a(_al_u724_o),
    .b(_al_u663_o),
    .c(hctl_ccmd_add),
    .o(\norm/hlfc_r [4]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'hfd75a820))
    _al_u726 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [2]),
    .d(\norm/hlfc_f [3]),
    .e(\norm/hlfc_f [4]),
    .o(\norm/n16 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h5410))
    _al_u727 (
    .a(_al_u552_o),
    .b(_al_u551_o),
    .c(\norm/n16 [4]),
    .d(\norm/hlfc_f [0]),
    .o(\norm/n24 [4]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u728 (
    .a(\norm/n24 [4]),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [5]),
    .e(\norm/hlfc_f [6]),
    .o(_al_u728_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u729 (
    .a(_al_u728_o),
    .b(\norm/hlfc_f [15]),
    .c(\norm/hlfc_f [7]),
    .o(\norm/n30 [4]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf8bbf888))
    _al_u730 (
    .a(\norm/hlfc_r [4]),
    .b(hctl_load_c),
    .c(\norm/n30 [4]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [4]),
    .o(\norm/n35 [4]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u731 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[3]),
    .o(_al_u731_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u732 (
    .a(_al_u731_o),
    .b(_al_u599_o),
    .c(\hlfa/hlfa_i [3]),
    .o(_al_u732_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(D*~B))*~(A)*~(E)+~(~C*~(D*~B))*A*~(E)+~(~(~C*~(D*~B)))*A*E+~(~C*~(D*~B))*A*E)"),
    .INIT(32'h55550c0f))
    _al_u733 (
    .a(hfpu_dsp_c[11]),
    .b(\hdiv/fdiv/rem2 [13]),
    .c(_al_u732_o),
    .d(hctl_ccmd_div),
    .e(hctl_ccmd_mul),
    .o(_al_u733_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u734 (
    .a(_al_u733_o),
    .b(_al_u655_o),
    .c(hctl_ccmd_add),
    .o(\norm/hlfc_r [3]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))*~(A)+E*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*~(A)+~(E)*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*A+E*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*A)"),
    .INIT(32'hfd5da808))
    _al_u735 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [1]),
    .c(\norm/hlfc_f [11]),
    .d(\norm/hlfc_f [2]),
    .e(\norm/hlfc_f [3]),
    .o(\norm/n16 [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u736 (
    .a(_al_u551_o),
    .b(\norm/n16 [3]),
    .o(\norm/n24 [3]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u737 (
    .a(\norm/n24 [3]),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [4]),
    .e(\norm/hlfc_f [5]),
    .o(_al_u737_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u738 (
    .a(_al_u737_o),
    .b(\norm/hlfc_f [15]),
    .c(\norm/hlfc_f [6]),
    .o(\norm/n30 [3]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf8bbf888))
    _al_u739 (
    .a(\norm/hlfc_r [3]),
    .b(hctl_load_c),
    .c(\norm/n30 [3]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [3]),
    .o(\norm/n35 [3]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u740 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[2]),
    .o(_al_u740_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u741 (
    .a(_al_u740_o),
    .b(_al_u599_o),
    .c(\hlfa/hlfa_i [2]),
    .o(_al_u741_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(D*~A))*~(B)*~(E)+~(~C*~(D*~A))*B*~(E)+~(~(~C*~(D*~A)))*B*E+~(~C*~(D*~A))*B*E)"),
    .INIT(32'h33330a0f))
    _al_u742 (
    .a(\hdiv/fdiv/rem1 [13]),
    .b(hfpu_dsp_c[10]),
    .c(_al_u741_o),
    .d(hctl_ccmd_div),
    .e(hctl_ccmd_mul),
    .o(_al_u742_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u743 (
    .a(_al_u742_o),
    .b(_al_u656_o),
    .c(hctl_ccmd_add),
    .o(\norm/hlfc_r [2]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(A)+E*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(A)+~(E)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A+E*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A)"),
    .INIT(32'hf5dda088))
    _al_u744 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [0]),
    .c(\norm/hlfc_f [1]),
    .d(\norm/hlfc_f [11]),
    .e(\norm/hlfc_f [2]),
    .o(\norm/n16 [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u745 (
    .a(_al_u551_o),
    .b(\norm/n16 [2]),
    .o(\norm/n24 [2]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u746 (
    .a(\norm/n24 [2]),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [3]),
    .e(\norm/hlfc_f [4]),
    .o(_al_u746_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u747 (
    .a(_al_u746_o),
    .b(\norm/hlfc_f [15]),
    .c(\norm/hlfc_f [5]),
    .o(\norm/n30 [2]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf8bbf888))
    _al_u748 (
    .a(\norm/hlfc_r [2]),
    .b(hctl_load_c),
    .c(\norm/n30 [2]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [2]),
    .o(\norm/n35 [2]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E))*~(C)+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*~(C)+~(D)*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C)"),
    .INIT(32'hafa0cfc0))
    _al_u749 (
    .a(\norm/n12 [3]),
    .b(n7[2]),
    .c(_al_u550_o),
    .d(\norm/hlfc_e [3]),
    .e(\norm/hlfc_f [11]),
    .o(\norm/n15 [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u750 (
    .a(\norm/n15 [3]),
    .b(_al_u551_o),
    .c(n6[1]),
    .o(\norm/n17 [3]));
  AL_MAP_LUT5 #(
    .EQN("~(~(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*~(E)*~(A)+~(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*~(A)+~(~(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))*E*A+~(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*A)"),
    .INIT(32'h5404feae))
    _al_u751 (
    .a(_al_u553_o),
    .b(\norm/n17 [3]),
    .c(_al_u552_o),
    .d(n5[2]),
    .e(\norm/hlfc_e [3]),
    .o(\norm/n21 [3]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u752 (
    .a(_al_u554_o),
    .b(\norm/n21 [3]),
    .c(n3[2]),
    .o(_al_u752_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u753 (
    .a(_al_u752_o),
    .b(\norm/n6 [3]),
    .c(\norm/n5 [2]),
    .d(\norm/hlfc_f [13]),
    .e(\norm/hlfc_f [14]),
    .o(_al_u753_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u754 (
    .a(_al_u753_o),
    .b(\norm/n4 [3]),
    .c(\norm/hlfc_f [15]),
    .o(\norm/n29 [3]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*~(C)*~(A)+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*~(A)+~((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D))*C*A+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*A)"),
    .INIT(32'he4f5e4a0))
    _al_u755 (
    .a(hctl_load_c),
    .b(\norm/n29 [3]),
    .c(\norm/hlfc_r [19]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_e [3]),
    .o(\norm/n34 [3]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E))*~(C)+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*~(C)+~(D)*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C)"),
    .INIT(32'hafa0cfc0))
    _al_u756 (
    .a(\norm/n12 [2]),
    .b(n7[1]),
    .c(_al_u550_o),
    .d(\norm/hlfc_e [2]),
    .e(\norm/hlfc_f [11]),
    .o(\norm/n15 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u757 (
    .a(\norm/n15 [2]),
    .b(_al_u551_o),
    .c(n6[0]),
    .o(\norm/n17 [2]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*~(E)*~(A)+(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*~(A)+~((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))*E*A+(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*A)"),
    .INIT(32'hfeae5404))
    _al_u758 (
    .a(_al_u553_o),
    .b(\norm/n17 [2]),
    .c(_al_u552_o),
    .d(n5[1]),
    .e(\norm/hlfc_e [2]),
    .o(\norm/n21 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u759 (
    .a(_al_u554_o),
    .b(\norm/n21 [2]),
    .c(n3[1]),
    .o(_al_u759_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u760 (
    .a(_al_u759_o),
    .b(\norm/n6 [2]),
    .c(\norm/n5 [1]),
    .d(\norm/hlfc_f [13]),
    .e(\norm/hlfc_f [14]),
    .o(_al_u760_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u761 (
    .a(_al_u760_o),
    .b(\norm/n4 [2]),
    .c(\norm/hlfc_f [15]),
    .o(\norm/n29 [2]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*~(C)*~(A)+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*~(A)+~((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D))*C*A+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*A)"),
    .INIT(32'he4f5e4a0))
    _al_u762 (
    .a(hctl_load_c),
    .b(\norm/n29 [2]),
    .c(\norm/hlfc_r [18]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_e [2]),
    .o(\norm/n34 [2]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u763 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[12]),
    .o(_al_u763_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(A*~(~E*B)))"),
    .INIT(32'h05550ddd))
    _al_u764 (
    .a(_al_u763_o),
    .b(_al_u599_o),
    .c(hctl_ccmd_div),
    .d(hlfc_r_hdiv[12]),
    .e(\hlfa/hlfa_i [12]),
    .o(_al_u764_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*~(B)*~(D)+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*~(D)+~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E))*B*D+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*D)"),
    .INIT(32'h33aa330f))
    _al_u765 (
    .a(hfpu_dsp_c[20]),
    .b(_al_u671_o),
    .c(_al_u764_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [12]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u766 (
    .a(\norm/hlfc_f [10]),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [12]),
    .o(_al_u766_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbbbb33b1))
    _al_u767 (
    .a(_al_u551_o),
    .b(_al_u766_o),
    .c(\norm/hlfc_f [6]),
    .d(\norm/hlfc_f [7]),
    .e(\norm/hlfc_f [8]),
    .o(_al_u767_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u768 (
    .a(_al_u767_o),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [15]),
    .o(_al_u768_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*~(~E*~(~D*C))))"),
    .INIT(32'h2222aa2a))
    _al_u769 (
    .a(_al_u768_o),
    .b(_al_u553_o),
    .c(\norm/hlfc_f [2]),
    .d(\norm/hlfc_f [3]),
    .e(\norm/hlfc_f [4]),
    .o(_al_u769_o));
  AL_MAP_LUT5 #(
    .EQN("((~C*~(~E*~D))*~(A)*~(B)+(~C*~(~E*~D))*A*~(B)+~((~C*~(~E*~D)))*A*B+(~C*~(~E*~D))*A*B)"),
    .INIT(32'h8b8b8b88))
    _al_u770 (
    .a(\norm/hlfc_r [12]),
    .b(hctl_load_c),
    .c(_al_u769_o),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [12]),
    .o(\norm/n35 [12]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*~B)))"),
    .INIT(16'h7050))
    _al_u771 (
    .a(_al_u600_o),
    .b(_al_u575_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[11]),
    .o(_al_u771_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(A*~(~E*B)))"),
    .INIT(32'h05550ddd))
    _al_u772 (
    .a(_al_u771_o),
    .b(_al_u599_o),
    .c(hctl_ccmd_div),
    .d(hlfc_r_hdiv[11]),
    .e(\hlfa/hlfa_i [11]),
    .o(_al_u772_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*~(B)*~(D)+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*~(D)+~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E))*B*D+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*D)"),
    .INIT(32'h33aa330f))
    _al_u773 (
    .a(hfpu_dsp_c[19]),
    .b(_al_u666_o),
    .c(_al_u772_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [11]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*~(B)*C*D*E)"),
    .INIT(32'h25252d2f))
    _al_u774 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [10]),
    .c(\norm/hlfc_f [11]),
    .d(\norm/hlfc_f [7]),
    .e(\norm/hlfc_f [9]),
    .o(_al_u774_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbb33bbb1))
    _al_u775 (
    .a(_al_u552_o),
    .b(_al_u774_o),
    .c(\norm/hlfc_f [3]),
    .d(\norm/hlfc_f [5]),
    .e(\norm/hlfc_f [6]),
    .o(_al_u775_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u776 (
    .a(_al_u554_o),
    .b(_al_u775_o),
    .c(\norm/hlfc_f [1]),
    .o(_al_u776_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E)"),
    .INIT(32'h00ff0f3a))
    _al_u777 (
    .a(_al_u776_o),
    .b(\norm/hlfc_f [12]),
    .c(\norm/hlfc_f [13]),
    .d(\norm/hlfc_f [14]),
    .e(\norm/hlfc_f [15]),
    .o(_al_u777_o));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*B*C*D*E)"),
    .INIT(32'h8fbb8f88))
    _al_u778 (
    .a(\norm/hlfc_r [11]),
    .b(hctl_load_c),
    .c(_al_u777_o),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [11]),
    .o(\norm/n35 [11]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u779 (
    .a(_al_u600_o),
    .b(_al_u617_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[10]),
    .o(_al_u779_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(A*~(~E*B)))"),
    .INIT(32'h05550ddd))
    _al_u780 (
    .a(_al_u779_o),
    .b(_al_u599_o),
    .c(hctl_ccmd_div),
    .d(hlfc_r_hdiv[10]),
    .e(\hlfa/hlfa_i [10]),
    .o(_al_u780_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*~(B)*~(D)+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*~(D)+~(~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E))*B*D+~(~C*~(A)*~(E)+~C*A*~(E)+~(~C)*A*E+~C*A*E)*B*D)"),
    .INIT(32'h33aa330f))
    _al_u781 (
    .a(hfpu_dsp_c[18]),
    .b(_al_u667_o),
    .c(_al_u780_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [10]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'heee44c44))
    _al_u782 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [10]),
    .c(\norm/hlfc_f [11]),
    .d(\norm/hlfc_f [8]),
    .e(\norm/hlfc_f [9]),
    .o(_al_u782_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(E*B))*~(D)*~(A)+~(~C*~(E*B))*D*~(A)+~(~(~C*~(E*B)))*D*A+~(~C*~(E*B))*D*A)"),
    .INIT(32'h01ab05af))
    _al_u783 (
    .a(_al_u552_o),
    .b(_al_u551_o),
    .c(_al_u782_o),
    .d(\norm/hlfc_f [4]),
    .e(\norm/hlfc_f [6]),
    .o(_al_u783_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u784 (
    .a(_al_u554_o),
    .b(_al_u553_o),
    .c(_al_u783_o),
    .d(\norm/hlfc_f [0]),
    .e(\norm/hlfc_f [2]),
    .o(_al_u784_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u785 (
    .a(_al_u784_o),
    .b(\norm/hlfc_f [11]),
    .c(\norm/hlfc_f [12]),
    .d(\norm/hlfc_f [13]),
    .e(\norm/hlfc_f [14]),
    .o(_al_u785_o));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E))*~(B)+C*(~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E)*~(B)+~(C)*(~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E)*B+C*(~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E)*B)"),
    .INIT(32'h03cf8b8b))
    _al_u786 (
    .a(_al_u785_o),
    .b(hctl_norm_enb_lutinv),
    .c(\norm/hlfc_f [10]),
    .d(\norm/hlfc_f [13]),
    .e(\norm/hlfc_f [15]),
    .o(_al_u786_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u787 (
    .a(\norm/hlfc_r [10]),
    .b(hctl_load_c),
    .c(_al_u786_o),
    .o(\norm/n35 [10]));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E))*~(C)+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*~(C)+~(D)*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C)"),
    .INIT(32'h505f303f))
    _al_u788 (
    .a(\norm/n12 [5]),
    .b(n7[4]),
    .c(_al_u550_o),
    .d(\norm/hlfc_e [5]),
    .e(\norm/hlfc_f [11]),
    .o(_al_u788_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*~(D)*~(A)+(~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*D*~(A)+~((~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C))*D*A+(~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*D*A)"),
    .INIT(32'h04ae54fe))
    _al_u789 (
    .a(_al_u552_o),
    .b(_al_u788_o),
    .c(_al_u551_o),
    .d(n5[4]),
    .e(n6[3]),
    .o(_al_u789_o));
  AL_MAP_LUT5 #(
    .EQN("~(~B*~((E@(~D*~C)))*~(A)+~B*(E@(~D*~C))*~(A)+~(~B)*(E@(~D*~C))*A+~B*(E@(~D*~C))*A)"),
    .INIT(32'h444eeee4))
    _al_u790 (
    .a(_al_u553_o),
    .b(_al_u789_o),
    .c(\norm/hlfc_e [3]),
    .d(\norm/hlfc_e [4]),
    .e(\norm/hlfc_e [5]),
    .o(_al_u790_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u791 (
    .a(_al_u790_o),
    .b(_al_u554_o),
    .c(n3[4]),
    .o(\norm/n23 [5]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u792 (
    .a(\norm/n23 [5]),
    .b(\norm/n6 [5]),
    .c(\norm/n5 [4]),
    .d(\norm/hlfc_f [13]),
    .e(\norm/hlfc_f [14]),
    .o(\norm/n27 [5]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u793 (
    .a(\norm/n27 [5]),
    .b(\norm/n4 [5]),
    .c(hctl_norm_enb_lutinv),
    .d(\norm/hlfc_e [5]),
    .e(\norm/hlfc_f [15]),
    .o(\norm/n31 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u794 (
    .a(_al_u617_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(hlfa_e[5]),
    .o(_al_u794_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(C)*~(E)+~(~A*~(D*B))*C*~(E)+~(~(~A*~(D*B)))*C*E+~(~A*~(D*B))*C*E)"),
    .INIT(32'h0f0f1155))
    _al_u795 (
    .a(_al_u794_o),
    .b(hlfc_r_hdiv[21]),
    .c(hlfc_r_hmul[21]),
    .d(hctl_ccmd_div),
    .e(hctl_ccmd_mul),
    .o(_al_u795_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~((~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D))*~(A)+B*(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*~(A)+~(B)*(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*A+B*(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*A)"),
    .INIT(32'hee4e444e))
    _al_u796 (
    .a(hctl_load_c),
    .b(\norm/n31 [5]),
    .c(_al_u795_o),
    .d(hctl_ccmd_add),
    .e(hlfa_e[5]),
    .o(\norm/n34 [5]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E))*~(C)+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*~(C)+~(D)*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C)"),
    .INIT(32'hafa0cfc0))
    _al_u797 (
    .a(\norm/n12 [4]),
    .b(n7[3]),
    .c(_al_u550_o),
    .d(\norm/hlfc_e [4]),
    .e(\norm/hlfc_f [11]),
    .o(\norm/n15 [4]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'h01ab51fb))
    _al_u798 (
    .a(_al_u552_o),
    .b(\norm/n15 [4]),
    .c(_al_u551_o),
    .d(n5[3]),
    .e(n6[2]),
    .o(_al_u798_o));
  AL_MAP_LUT4 #(
    .EQN("~(B*~((D@C))*~(A)+B*(D@C)*~(A)+~(B)*(D@C)*A+B*(D@C)*A)"),
    .INIT(16'hb11b))
    _al_u799 (
    .a(_al_u553_o),
    .b(_al_u798_o),
    .c(\norm/hlfc_e [3]),
    .d(\norm/hlfc_e [4]),
    .o(\norm/n21 [4]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(C)*~(E)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*C*~(E)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*C*E+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*C*E)"),
    .INIT(32'hf0f0ee22))
    _al_u800 (
    .a(\norm/n21 [4]),
    .b(_al_u554_o),
    .c(\norm/n6 [4]),
    .d(n3[3]),
    .e(\norm/hlfc_f [13]),
    .o(\norm/n25 [4]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*~(B)*~(E)+(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*~(E)+~((A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D))*B*E+(A*~(C)*~(D)+A*C*~(D)+~(A)*C*D+A*C*D)*B*E)"),
    .INIT(32'hccccf0aa))
    _al_u801 (
    .a(\norm/n25 [4]),
    .b(\norm/n4 [4]),
    .c(\norm/n5 [3]),
    .d(\norm/hlfc_f [14]),
    .e(\norm/hlfc_f [15]),
    .o(\norm/n29 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*~(C)*~(A)+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*~(A)+~((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D))*C*A+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*C*A)"),
    .INIT(32'he4f5e4a0))
    _al_u802 (
    .a(hctl_load_c),
    .b(\norm/n29 [4]),
    .c(\norm/hlfc_r [20]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_e [4]),
    .o(\norm/n34 [4]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(E*C)*~(D*A)))"),
    .INIT(32'hc8c08800))
    _al_u803 (
    .a(_al_u617_o),
    .b(\norm/mux2_b14_sel_is_2_o ),
    .c(_al_u599_o),
    .d(hlfa_r[13]),
    .e(\hlfa/hlfa_i [13]),
    .o(_al_u803_o));
  AL_MAP_LUT5 #(
    .EQN("((~C*~(E*A))*~(B)*~(D)+(~C*~(E*A))*B*~(D)+~((~C*~(E*A)))*B*D+(~C*~(E*A))*B*D)"),
    .INIT(32'hcc05cc0f))
    _al_u804 (
    .a(hfpu_dsp_c[21]),
    .b(_al_u665_o),
    .c(_al_u803_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(_al_u804_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(A)*~(B)+~(D*~C)*A*~(B)+~(~(D*~C))*A*B+~(D*~C)*A*B)"),
    .INIT(16'h4744))
    _al_u805 (
    .a(_al_u804_o),
    .b(hctl_load_c),
    .c(hctl_norm_enb_lutinv),
    .d(\norm/hlfc_f [13]),
    .o(\norm/n35 [13]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u806 (
    .a(bbus[14]),
    .b(bbus[13]),
    .c(bbus[12]),
    .d(bbus[11]),
    .e(bbus[10]),
    .o(_al_u806_o));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u807 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[10]),
    .d(hlfb_r[11]),
    .e(hlfb_r[9]),
    .o(\hlfb/n50 [9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u808 (
    .a(\hlfb/n50 [9]),
    .b(_al_u634_o),
    .c(hlfb_r[13]),
    .o(\hlfb/n52 [9]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u809 (
    .a(_al_u584_o),
    .b(_al_u635_o),
    .o(\hlfb/mux10_b10_sel_is_0_o ));
  AL_MAP_LUT5 #(
    .EQN("((E*D)*~((C*~B))*~(A)+(E*D)*(C*~B)*~(A)+~((E*D))*(C*~B)*A+(E*D)*(C*~B)*A)"),
    .INIT(32'h75202020))
    _al_u810 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[7]),
    .d(\hlfb/n52 [9]),
    .e(\hlfb/mux10_b10_sel_is_0_o ),
    .o(\hlfb/n59 [9]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*~(C)*~(A)+(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*C*~(A)+~((D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B))*C*A+(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*C*A)"),
    .INIT(32'hf5e4b1a0))
    _al_u811 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[10]),
    .d(hlfb_r[8]),
    .e(hlfb_r[9]),
    .o(\hlfb/n50 [8]));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))"),
    .INIT(16'ha808))
    _al_u812 (
    .a(\hlfb/mux10_b10_sel_is_0_o ),
    .b(\hlfb/n50 [8]),
    .c(_al_u634_o),
    .d(hlfb_r[12]),
    .o(\hlfb/n56 [8]));
  AL_MAP_LUT4 #(
    .EQN("(D*~((C*~B))*~(A)+D*(C*~B)*~(A)+~(D)*(C*~B)*A+D*(C*~B)*A)"),
    .INIT(16'h7520))
    _al_u813 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[6]),
    .d(\hlfb/n56 [8]),
    .o(\hlfb/n59 [8]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u814 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[7]),
    .d(hlfb_r[8]),
    .e(hlfb_r[9]),
    .o(\hlfb/n50 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u815 (
    .a(\hlfb/n50 [7]),
    .b(_al_u634_o),
    .c(hlfb_r[11]),
    .o(\hlfb/n52 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*D)*~((C*~B))*~(A)+(E*D)*(C*~B)*~(A)+~((E*D))*(C*~B)*A+(E*D)*(C*~B)*A)"),
    .INIT(32'h75202020))
    _al_u816 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[5]),
    .d(\hlfb/n52 [7]),
    .e(\hlfb/mux10_b10_sel_is_0_o ),
    .o(\hlfb/n59 [7]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u817 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[6]),
    .d(hlfb_r[7]),
    .e(hlfb_r[8]),
    .o(\hlfb/n50 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u818 (
    .a(\hlfb/n50 [6]),
    .b(_al_u634_o),
    .c(hlfb_r[10]),
    .o(\hlfb/n52 [6]));
  AL_MAP_LUT5 #(
    .EQN("((E*D)*~((C*~B))*~(A)+(E*D)*(C*~B)*~(A)+~((E*D))*(C*~B)*A+(E*D)*(C*~B)*A)"),
    .INIT(32'h75202020))
    _al_u819 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[4]),
    .d(\hlfb/n52 [6]),
    .e(\hlfb/mux10_b10_sel_is_0_o ),
    .o(\hlfb/n59 [6]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~E*~D*~C*~B))"),
    .INIT(32'h55555554))
    _al_u820 (
    .a(\hlfb/mux10_b10_sel_is_0_o ),
    .b(hlfb_r[5]),
    .c(hlfb_r[6]),
    .d(hlfb_r[7]),
    .e(hlfb_r[8]),
    .o(_al_u820_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u821 (
    .a(hlfb_r[10]),
    .b(hlfb_r[11]),
    .c(hlfb_r[12]),
    .d(hlfb_r[13]),
    .e(hlfb_r[9]),
    .o(_al_u821_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*B))"),
    .INIT(8'h51))
    _al_u822 (
    .a(_al_u820_o),
    .b(_al_u584_o),
    .c(_al_u821_o),
    .o(_al_u822_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u823 (
    .a(\hlfb/mux10_b10_sel_is_0_o ),
    .b(_al_u634_o),
    .o(\hlfb/mux10_b10_sel_is_1_o ));
  AL_MAP_LUT5 #(
    .EQN("(~C*(~(A)*~(B)*~(D)*~(E)+A*~(B)*~(D)*~(E)+~(A)*B*~(D)*~(E)+A*B*~(D)*~(E)+~(A)*~(B)*D*~(E)+~(A)*~(B)*~(D)*E+~(A)*B*~(D)*E+~(A)*~(B)*D*E))"),
    .INIT(32'h0105010f))
    _al_u824 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[0]),
    .d(hlfb_r[1]),
    .e(hlfb_r[2]),
    .o(_al_u824_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u825 (
    .a(hlfb_r[0]),
    .b(hlfb_r[1]),
    .c(hlfb_r[2]),
    .d(hlfb_r[3]),
    .e(hlfb_r[4]),
    .o(_al_u825_o));
  AL_MAP_LUT4 #(
    .EQN("~(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h5d7f))
    _al_u826 (
    .a(_al_u822_o),
    .b(\hlfb/mux10_b10_sel_is_1_o ),
    .c(_al_u824_o),
    .d(_al_u825_o),
    .o(\hlfb/n56 [0]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u827 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(\hlfb/n36 [1]),
    .d(\hlfb/n45 [2]),
    .e(hlfb_e[2]),
    .o(_al_u827_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))*~(A)+E*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C)*~(A)+~(E)*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C)*A+E*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C)*A)"),
    .INIT(32'h08a85dfd))
    _al_u828 (
    .a(\hlfb/mux10_b10_sel_is_0_o ),
    .b(_al_u827_o),
    .c(_al_u634_o),
    .d(\hlfb/n27 [0]),
    .e(hlfb_e[2]),
    .o(_al_u828_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u829 (
    .a(hctl_load_a),
    .b(\hlfb/n1 [2]),
    .c(_al_u828_o),
    .o(\hlfb/n58 [2]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u830 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(\hlfb/n45 [1]),
    .d(\hlfb/n36 [0]),
    .e(hlfb_e[1]),
    .o(_al_u830_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*~(D)*~(C)+~E*D*~(C)+~(~E)*D*C+~E*D*C)*~(B)*~(A)+~(~E*~(D)*~(C)+~E*D*~(C)+~(~E)*D*C+~E*D*C)*B*~(A)+~(~(~E*~(D)*~(C)+~E*D*~(C)+~(~E)*D*C+~E*D*C))*B*A+~(~E*~(D)*~(C)+~E*D*~(C)+~(~E)*D*C+~E*D*C)*B*A)"),
    .INIT(32'h8ddd88d8))
    _al_u831 (
    .a(hctl_load_a),
    .b(\hlfb/n1 [1]),
    .c(\hlfb/mux10_b10_sel_is_1_o ),
    .d(_al_u830_o),
    .e(hlfb_e[1]),
    .o(\hlfb/n58 [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u832 (
    .a(\hlfa/mux24_b0_sel_is_0_o ),
    .b(\hlfb/mux10_b10_sel_is_1_o ),
    .o(\hlfb/mux16_b13_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u833 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[11]),
    .d(hlfb_r[12]),
    .e(hlfb_r[13]),
    .o(_al_u833_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*D)*~((C*~B))*~(A)+(~E*D)*(C*~B)*~(A)+~((~E*D))*(C*~B)*A+(~E*D)*(C*~B)*A)"),
    .INIT(32'h20207520))
    _al_u834 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[9]),
    .d(\hlfb/mux10_b10_sel_is_1_o ),
    .e(_al_u833_o),
    .o(\hlfb/n59 [11]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u835 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[10]),
    .d(hlfb_r[11]),
    .e(hlfb_r[12]),
    .o(_al_u835_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*D)*~((C*~B))*~(A)+(~E*D)*(C*~B)*~(A)+~((~E*D))*(C*~B)*A+(~E*D)*(C*~B)*A)"),
    .INIT(32'h20207520))
    _al_u836 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[8]),
    .d(\hlfb/mux10_b10_sel_is_1_o ),
    .e(_al_u835_o),
    .o(\hlfb/n59 [10]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u837 (
    .a(\hlfa/hlfa_rsft_fin ),
    .b(\hlfa/hlfa_e_dif [5]),
    .c(\hlfa/hlfa_e_dif [3]),
    .d(hctl_rsft_enb_lutinv),
    .o(_al_u837_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u838 (
    .a(_al_u589_o),
    .b(_al_u837_o),
    .o(\hlfa/mux17_b2_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u839 (
    .a(\hlfa/hlfa_rsft_fin ),
    .b(\hlfa/hlfa_e_dif [5]),
    .c(\hlfa/hlfa_e_dif [2]),
    .d(hctl_rsft_enb_lutinv),
    .o(_al_u839_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u840 (
    .a(\hlfa/mux17_b2_sel_is_0_o ),
    .b(_al_u839_o),
    .o(\hlfa/mux17_b1_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u841 (
    .a(\hlfa/mux24_b0_sel_is_0_o ),
    .b(\hlfa/mux17_b1_sel_is_2_o ),
    .o(\hlfa/mux24_b13_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u842 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[11]),
    .d(hlfa_r[12]),
    .e(hlfa_r[13]),
    .o(\hlfa/n65 [13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u843 (
    .a(\hlfa/n65 [13]),
    .b(_al_u597_o),
    .c(hlfa_r[9]),
    .o(\hlfa/n67 [13]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u844 (
    .a(\hlfa/n67 [13]),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(hlfa_r[14]),
    .e(hlfa_r[5]),
    .o(\hlfa/n71 [13]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u845 (
    .a(\hlfa/hlfa_rsft_fin ),
    .b(\hlfa/hlfa_e_dif [5]),
    .c(\hlfa/hlfa_e_dif [1]),
    .d(hctl_rsft_enb_lutinv),
    .o(_al_u845_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u846 (
    .a(\hlfa/n71 [13]),
    .b(_al_u845_o),
    .c(hlfa_r[15]),
    .o(\hlfa/n73 [13]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*B*C*D)"),
    .INIT(16'h4ebb))
    _al_u847 (
    .a(hlfc_r_hadd[23]),
    .b(\hadd/hlfc_f_t [15]),
    .c(hlfb_r[22]),
    .d(hlfa_r[22]),
    .o(_al_u847_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u848 (
    .a(\hlfa/n89_lutinv ),
    .b(\hlfa/n86_lutinv ),
    .o(hlfa_r[25]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    _al_u849 (
    .a(hlfa_r[25]),
    .b(\hlfb/n66_lutinv ),
    .c(\hlfb/n63_lutinv ),
    .o(_al_u849_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u850 (
    .a(\hadd/inf_nan ),
    .b(_al_u849_o),
    .o(_al_u850_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))"),
    .INIT(16'h0c88))
    _al_u851 (
    .a(_al_u847_o),
    .b(_al_u850_o),
    .c(\hadd/inf_s ),
    .d(hlfc_r_hadd[24]),
    .o(_al_u851_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u852 (
    .a(_al_u849_o),
    .b(hlfa_r[24]),
    .c(hlfb_r[24]),
    .d(\hlfa/mux29_b22_sel_is_2_o ),
    .e(_al_u630_o),
    .o(_al_u852_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u853 (
    .a(_al_u852_o),
    .b(hctl_ccmd_mul),
    .o(_al_u853_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((C*B)*~(D)*~(E)+(C*B)*D*~(E)+~((C*B))*D*E+(C*B)*D*E))"),
    .INIT(32'h00aa2a2a))
    _al_u854 (
    .a(_al_u849_o),
    .b(hlfa_r[24]),
    .c(hlfb_r[24]),
    .d(\hlfa/mux29_b22_sel_is_2_o ),
    .e(_al_u630_o),
    .o(_al_u854_o));
  AL_MAP_LUT5 #(
    .EQN("(~((~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B))*~(D)*~(E)+(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)*~(D)*~(E)+(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)*~(D)*E+~((~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B))*D*E+(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)*D*E)"),
    .INIT(32'hffd100ff))
    _al_u855 (
    .a(_al_u496_o),
    .b(_al_u572_o),
    .c(\hlfa/mux29_b22_sel_is_2_o ),
    .d(_al_u647_o),
    .e(hlfa_r[22]),
    .o(_al_u855_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u856 (
    .a(_al_u855_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .c(_al_u646_o),
    .d(hlfb_r[22]),
    .o(_al_u856_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~B*~(D*~(C*A)))"),
    .INIT(32'h00002033))
    _al_u857 (
    .a(_al_u854_o),
    .b(_al_u856_o),
    .c(_al_u479_o),
    .d(hctl_ccmd_div),
    .e(hctl_ccmd_mul),
    .o(_al_u857_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(D*B))*~(A)*~(E)+~(~C*~(D*B))*A*~(E)+~(~(~C*~(D*B)))*A*E+~(~C*~(D*B))*A*E)"),
    .INIT(32'h5555030f))
    _al_u858 (
    .a(_al_u851_o),
    .b(_al_u853_o),
    .c(_al_u857_o),
    .d(_al_u479_o),
    .e(hctl_ccmd_add),
    .o(\norm/hlfc_r [22]));
  AL_MAP_LUT5 #(
    .EQN("(C*((D*A)*~(E)*~(B)+(D*A)*E*~(B)+~((D*A))*E*B+(D*A)*E*B))"),
    .INIT(32'he0c02000))
    _al_u859 (
    .a(_al_u617_o),
    .b(_al_u599_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(hlfa_r[0]),
    .e(\hlfa/hlfa_i [0]),
    .o(\norm/n1 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*~(B)*~(D)+~(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*B*~(D)+~(~(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E))*B*D+~(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*B*D)"),
    .INIT(32'hcc55cc0f))
    _al_u860 (
    .a(hfpu_dsp_c[8]),
    .b(_al_u658_o),
    .c(\norm/n1 [0]),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(_al_u860_o));
  AL_MAP_LUT4 #(
    .EQN("~((B*~A)*~(C)*~(D)+(B*~A)*C*~(D)+~((B*~A))*C*D+(B*~A)*C*D)"),
    .INIT(16'h0fbb))
    _al_u861 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [0]),
    .c(\norm/hlfc_f [1]),
    .d(\norm/hlfc_f [13]),
    .o(_al_u861_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hfdf10d01))
    _al_u862 (
    .a(_al_u861_o),
    .b(\norm/hlfc_f [14]),
    .c(\norm/hlfc_f [15]),
    .d(\norm/hlfc_f [2]),
    .e(\norm/hlfc_f [3]),
    .o(\norm/n30 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf477f444))
    _al_u863 (
    .a(_al_u860_o),
    .b(hctl_load_c),
    .c(\norm/n30 [0]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [0]),
    .o(\norm/n35 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~C*B)*~(A)*~(D)+~(E*~C*B)*A*~(D)+~(~(E*~C*B))*A*D+~(E*~C*B)*A*D)"),
    .INIT(32'haaf3aaff))
    _al_u864 (
    .a(_al_u854_o),
    .b(hlfa_r[25]),
    .c(_al_u648_o),
    .d(hctl_ccmd_div),
    .e(hctl_ccmd_reg),
    .o(_al_u864_o));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*~(B)*~(D)+(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*~(D)+~((A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E))*B*D+(A*~(C)*~(E)+A*C*~(E)+~(A)*C*E+A*C*E)*B*D)"),
    .INIT(32'h330f3355))
    _al_u865 (
    .a(_al_u864_o),
    .b(_al_u850_o),
    .c(_al_u852_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [25]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u866 (
    .a(_al_u617_o),
    .b(_al_u599_o),
    .c(hlfa_r[1]),
    .d(\hlfa/hlfa_i [1]),
    .o(_al_u866_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(A)*~(C)+~(D*~B)*A*~(C)+~(~(D*~B))*A*C+~(D*~B)*A*C)"),
    .INIT(16'hacaf))
    _al_u867 (
    .a(\hdiv/rem [12]),
    .b(_al_u866_o),
    .c(hctl_ccmd_div),
    .d(hctl_ccmd_reg),
    .o(_al_u867_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*~(C)*~(D)+~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*C*~(D)+~(~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E))*C*D+~(~A*~(B)*~(E)+~A*B*~(E)+~(~A)*B*E+~A*B*E)*C*D)"),
    .INIT(32'h0fcc0f55))
    _al_u868 (
    .a(_al_u867_o),
    .b(hfpu_dsp_c[9]),
    .c(_al_u657_o),
    .d(hctl_ccmd_add),
    .e(hctl_ccmd_mul),
    .o(\norm/hlfc_r [1]));
  AL_MAP_LUT4 #(
    .EQN("~(C*~((D*B))*~(A)+C*(D*B)*~(A)+~(C)*(D*B)*A+C*(D*B)*A)"),
    .INIT(16'h27af))
    _al_u869 (
    .a(_al_u550_o),
    .b(\norm/hlfc_f [0]),
    .c(\norm/hlfc_f [1]),
    .d(\norm/hlfc_f [11]),
    .o(_al_u869_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hfdf10d01))
    _al_u870 (
    .a(_al_u869_o),
    .b(\norm/hlfc_f [13]),
    .c(\norm/hlfc_f [14]),
    .d(\norm/hlfc_f [2]),
    .e(\norm/hlfc_f [3]),
    .o(\norm/n28 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u871 (
    .a(\norm/n28 [1]),
    .b(\norm/hlfc_f [15]),
    .c(\norm/hlfc_f [4]),
    .o(\norm/n30 [1]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'hb8bbb888))
    _al_u872 (
    .a(\norm/hlfc_r [1]),
    .b(hctl_load_c),
    .c(\norm/n30 [1]),
    .d(hctl_norm_enb_lutinv),
    .e(\norm/hlfc_f [1]),
    .o(\norm/n35 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u873 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[5]),
    .d(hlfb_r[6]),
    .e(hlfb_r[7]),
    .o(\hlfb/n50 [5]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'h01f10dfd))
    _al_u874 (
    .a(\hlfb/n50 [5]),
    .b(_al_u634_o),
    .c(_al_u635_o),
    .d(hlfb_r[13]),
    .e(hlfb_r[9]),
    .o(_al_u874_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~D)*~((C*~B))*~(A)+(~E*~D)*(C*~B)*~(A)+~((~E*~D))*(C*~B)*A+(~E*~D)*(C*~B)*A)"),
    .INIT(32'h20202075))
    _al_u875 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[3]),
    .d(_al_u874_o),
    .e(_al_u584_o),
    .o(\hlfb/n59 [5]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u876 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[4]),
    .d(hlfb_r[5]),
    .e(hlfb_r[6]),
    .o(\hlfb/n50 [4]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'h01f10dfd))
    _al_u877 (
    .a(\hlfb/n50 [4]),
    .b(_al_u634_o),
    .c(_al_u635_o),
    .d(hlfb_r[12]),
    .e(hlfb_r[8]),
    .o(_al_u877_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~D)*~((C*~B))*~(A)+(~E*~D)*(C*~B)*~(A)+~((~E*~D))*(C*~B)*A+(~E*~D)*(C*~B)*A)"),
    .INIT(32'h20202075))
    _al_u878 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[2]),
    .d(_al_u877_o),
    .e(_al_u584_o),
    .o(\hlfb/n59 [4]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u879 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[3]),
    .d(hlfb_r[4]),
    .e(hlfb_r[5]),
    .o(\hlfb/n50 [3]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'h01f10dfd))
    _al_u880 (
    .a(\hlfb/n50 [3]),
    .b(_al_u634_o),
    .c(_al_u635_o),
    .d(hlfb_r[11]),
    .e(hlfb_r[7]),
    .o(_al_u880_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~D)*~((C*~B))*~(A)+(~E*~D)*(C*~B)*~(A)+~((~E*~D))*(C*~B)*A+(~E*~D)*(C*~B)*A)"),
    .INIT(32'h20202075))
    _al_u881 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[1]),
    .d(_al_u880_o),
    .e(_al_u584_o),
    .o(\hlfb/n59 [3]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u882 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(hlfb_r[2]),
    .d(hlfb_r[3]),
    .e(hlfb_r[4]),
    .o(\hlfb/n50 [2]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'h01f10dfd))
    _al_u883 (
    .a(\hlfb/n50 [2]),
    .b(_al_u634_o),
    .c(_al_u635_o),
    .d(hlfb_r[10]),
    .e(hlfb_r[6]),
    .o(_al_u883_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~D)*~((C*~B))*~(A)+(~E*~D)*(C*~B)*~(A)+~((~E*~D))*(C*~B)*A+(~E*~D)*(C*~B)*A)"),
    .INIT(32'h20202075))
    _al_u884 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(bbus[0]),
    .d(_al_u883_o),
    .e(_al_u584_o),
    .o(\hlfb/n59 [2]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u885 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(\hlfb/n36 [4]),
    .d(\hlfb/n45 [5]),
    .e(hlfb_e[5]),
    .o(\hlfb/n49 [5]));
  AL_MAP_LUT3 #(
    .EQN("~(C@(B*A))"),
    .INIT(8'h87))
    _al_u886 (
    .a(hlfb_e[3]),
    .b(hlfb_e[4]),
    .c(hlfb_e[5]),
    .o(_al_u886_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~(~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hf1fd010d))
    _al_u887 (
    .a(\hlfb/n49 [5]),
    .b(_al_u634_o),
    .c(_al_u635_o),
    .d(\hlfb/n27 [3]),
    .e(_al_u886_o),
    .o(_al_u887_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~((D@C))*~(B)+~A*(D@C)*~(B)+~(~A)*(D@C)*B+~A*(D@C)*B)"),
    .INIT(16'h1dd1))
    _al_u888 (
    .a(_al_u887_o),
    .b(_al_u584_o),
    .c(hlfb_e[4]),
    .d(hlfb_e[5]),
    .o(\hlfb/n55 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u889 (
    .a(hctl_load_a),
    .b(\hlfb/n1 [5]),
    .c(\hlfb/n55 [5]),
    .o(\hlfb/n58 [5]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u890 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(\hlfb/n36 [3]),
    .d(\hlfb/n45 [4]),
    .e(hlfb_e[4]),
    .o(_al_u890_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u891 (
    .a(_al_u890_o),
    .b(_al_u634_o),
    .c(\hlfb/n27 [2]),
    .o(_al_u891_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfece0232))
    _al_u892 (
    .a(_al_u891_o),
    .b(_al_u584_o),
    .c(_al_u635_o),
    .d(hlfb_e[3]),
    .e(hlfb_e[4]),
    .o(_al_u892_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u893 (
    .a(hctl_load_a),
    .b(\hlfb/n1 [4]),
    .c(_al_u892_o),
    .o(\hlfb/n58 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u894 (
    .a(_al_u586_o),
    .b(_al_u587_o),
    .c(\hlfb/n36 [2]),
    .d(\hlfb/n45 [3]),
    .e(hlfb_e[3]),
    .o(\hlfb/n49 [3]));
  AL_MAP_LUT5 #(
    .EQN("(~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~(~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hf1fd010d))
    _al_u895 (
    .a(\hlfb/n49 [3]),
    .b(_al_u634_o),
    .c(_al_u635_o),
    .d(\hlfb/n27 [1]),
    .e(hlfb_e[3]),
    .o(_al_u895_o));
  AL_MAP_LUT5 #(
    .EQN("((~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*~(B)*~(A)+(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*B*~(A)+~((~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D))*B*A+(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*B*A)"),
    .INIT(32'hdd8d888d))
    _al_u896 (
    .a(hctl_load_a),
    .b(\hlfb/n1 [3]),
    .c(_al_u895_o),
    .d(_al_u584_o),
    .e(hlfb_e[3]),
    .o(\hlfb/n58 [3]));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h22200200))
    _al_u897 (
    .a(\hlfb/mux10_b10_sel_is_1_o ),
    .b(_al_u586_o),
    .c(_al_u587_o),
    .d(hlfb_r[12]),
    .e(hlfb_r[13]),
    .o(\hlfb/n56 [12]));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h72))
    _al_u898 (
    .a(hctl_load_a),
    .b(_al_u806_o),
    .c(\hlfb/n56 [12]),
    .o(\hlfb/n59 [12]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u899 (
    .a(\hlfa/mux24_b13_sel_is_2_o ),
    .b(_al_u845_o),
    .o(\hlfa/mux24_b14_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u900 (
    .a(_al_u596_o),
    .b(_al_u597_o),
    .o(\hlfa/mux8_b2_sel_is_0_o ));
  AL_MAP_LUT5 #(
    .EQN("~(E*~(D)*~((~C*B*A))+E*D*~((~C*B*A))+~(E)*D*(~C*B*A)+E*D*(~C*B*A))"),
    .INIT(32'h0008f7ff))
    _al_u901 (
    .a(\hlfa/mux8_b2_sel_is_0_o ),
    .b(_al_u594_o),
    .c(\hlfa/hlfa_e_difl [1]),
    .d(\hlfa/n61 [0]),
    .e(hlfa_e[0]),
    .o(_al_u901_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u902 (
    .a(_al_u901_o),
    .b(_al_u639_o),
    .c(\hlfa/n34 [0]),
    .o(\hlfa/n70 [0]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~(A)*~((~C*B))+D*A*~((~C*B))+~(D)*A*(~C*B)+D*A*(~C*B))"),
    .INIT(16'h04f7))
    _al_u903 (
    .a(\hlfa/n70 [0]),
    .b(\hlfa/mux17_b1_sel_is_2_o ),
    .c(_al_u845_o),
    .d(hlfa_e[0]),
    .o(_al_u903_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u904 (
    .a(_al_u903_o),
    .b(hctl_load_a),
    .c(\hlfa/n1 [0]),
    .o(\hlfa/n81 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D)*~((~C*B*A))+E*D*~((~C*B*A))+~(E)*D*(~C*B*A)+E*D*(~C*B*A))"),
    .INIT(32'hfff70800))
    _al_u905 (
    .a(\hlfb/mux10_b10_sel_is_1_o ),
    .b(_al_u587_o),
    .c(hlfc_r_hdiv[17]),
    .d(\hlfb/n45 [0]),
    .e(hlfb_e[0]),
    .o(\hlfb/n55 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u906 (
    .a(hctl_load_a),
    .b(\hlfb/n1 [0]),
    .c(\hlfb/n55 [0]),
    .o(\hlfb/n58 [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u907 (
    .a(\hlfa/mux24_b14_sel_is_2_o ),
    .b(_al_u639_o),
    .o(\hlfa/mux24_b15_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u908 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[10]),
    .d(hlfa_r[11]),
    .e(hlfa_r[12]),
    .o(\hlfa/n65 [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u909 (
    .a(\hlfa/n65 [12]),
    .b(_al_u597_o),
    .c(hlfa_r[8]),
    .o(\hlfa/n67 [12]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u910 (
    .a(\hlfa/n67 [12]),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(hlfa_r[13]),
    .e(hlfa_r[4]),
    .o(\hlfa/n71 [12]));
  AL_MAP_LUT4 #(
    .EQN("(B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'hc808))
    _al_u911 (
    .a(\hlfa/n71 [12]),
    .b(\hlfa/mux17_b1_sel_is_2_o ),
    .c(_al_u845_o),
    .d(hlfa_r[14]),
    .o(\hlfa/n79 [12]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u912 (
    .a(abus[14]),
    .b(abus[13]),
    .c(abus[12]),
    .d(abus[11]),
    .e(abus[10]),
    .o(_al_u912_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u913 (
    .a(\hlfa/n79 [12]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .o(\hlfa/n82 [12]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u914 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(\hlfa/n61 [1]),
    .d(n2[0]),
    .e(hlfa_e[1]),
    .o(_al_u914_o));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h72))
    _al_u915 (
    .a(\hlfa/mux8_b2_sel_is_0_o ),
    .b(_al_u914_o),
    .c(hlfa_e[1]),
    .o(\hlfa/n68 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hfef20e02))
    _al_u916 (
    .a(\hlfa/n68 [1]),
    .b(_al_u639_o),
    .c(_al_u845_o),
    .d(\hlfa/n34 [1]),
    .e(\hlfa/n25 [0]),
    .o(\hlfa/n72 [1]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(A)*~(C)+E*A*~(C)+~(E)*A*C+E*A*C)*~(D)*~(B)+(E*~(A)*~(C)+E*A*~(C)+~(E)*A*C+E*A*C)*D*~(B)+~((E*~(A)*~(C)+E*A*~(C)+~(E)*A*C+E*A*C))*D*B+(E*~(A)*~(C)+E*A*~(C)+~(E)*A*C+E*A*C)*D*B)"),
    .INIT(32'hef23ec20))
    _al_u917 (
    .a(\hlfa/n72 [1]),
    .b(hctl_load_a),
    .c(\hlfa/mux17_b1_sel_is_2_o ),
    .d(\hlfa/n1 [1]),
    .e(hlfa_e[1]),
    .o(\hlfa/n81 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~C*A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))"),
    .INIT(32'h0a020800))
    _al_u918 (
    .a(\hlfa/mux8_b2_sel_is_0_o ),
    .b(_al_u594_o),
    .c(_al_u639_o),
    .d(hlfa_r[0]),
    .e(hlfa_r[1]),
    .o(_al_u918_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u919 (
    .a(_al_u639_o),
    .b(hlfa_r[2]),
    .o(_al_u919_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~C*~(~B*A))*~(E)*~(D)+~(~C*~(~B*A))*E*~(D)+~(~(~C*~(~B*A)))*E*D+~(~C*~(~B*A))*E*D)"),
    .INIT(32'h000dff0d))
    _al_u920 (
    .a(_al_u918_o),
    .b(_al_u593_o),
    .c(_al_u919_o),
    .d(_al_u845_o),
    .e(hlfa_r[3]),
    .o(_al_u920_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hfdf10d01))
    _al_u921 (
    .a(_al_u920_o),
    .b(_al_u839_o),
    .c(_al_u837_o),
    .d(hlfa_r[5]),
    .e(hlfa_r[9]),
    .o(\hlfa/n77 [1]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(B*A*~(~D*~C)))"),
    .INIT(32'h777f0000))
    _al_u922 (
    .a(\hlfa/hlfa_rsft_fin ),
    .b(\hlfa/hlfa_lsft_fin ),
    .c(\hlfb/n67 ),
    .d(hctl_ccmd_int),
    .e(\hctl/stat [0]),
    .o(_al_u922_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*A))"),
    .INIT(8'h70))
    _al_u923 (
    .a(\hctl/stat [0]),
    .b(\hctl/stat [1]),
    .c(\hctl/stat [3]),
    .o(_al_u923_o));
  AL_MAP_LUT4 #(
    .EQN("(~(B)*~((C*A))*~(D)+B*~((C*A))*D+B*(C*A)*D)"),
    .INIT(16'hcc13))
    _al_u924 (
    .a(_al_u922_o),
    .b(_al_u923_o),
    .c(_al_u542_o),
    .d(\hctl/stat [2]),
    .o(_al_u924_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~B*A*(E@C))"),
    .INIT(32'h02002000))
    _al_u925 (
    .a(_al_u543_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(_al_u925_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(C*(E@D)))"),
    .INIT(32'h44040444))
    _al_u926 (
    .a(_al_u925_o),
    .b(rst_n),
    .c(_al_u477_o),
    .d(\hctl/stat [1]),
    .e(\hctl/stat [2]),
    .o(_al_u926_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~A*~(~E*~D*B))"),
    .INIT(32'h50505010))
    _al_u927 (
    .a(\hctl/crdy_t ),
    .b(_al_u924_o),
    .c(_al_u926_o),
    .d(hctl_load_a),
    .e(_al_u561_o),
    .o(\hctl/mux0_b0_sel_is_1_o ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u928 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[7]),
    .d(hlfa_r[8]),
    .e(hlfa_r[9]),
    .o(_al_u928_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u929 (
    .a(_al_u928_o),
    .b(_al_u596_o),
    .c(_al_u597_o),
    .d(hlfa_r[1]),
    .e(hlfa_r[5]),
    .o(_al_u929_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'h020ef2fe))
    _al_u930 (
    .a(_al_u929_o),
    .b(_al_u639_o),
    .c(_al_u845_o),
    .d(hlfa_r[10]),
    .e(hlfa_r[11]),
    .o(_al_u930_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u931 (
    .a(_al_u930_o),
    .b(\hlfa/mux17_b2_sel_is_0_o ),
    .c(_al_u839_o),
    .d(hlfa_r[13]),
    .o(\hlfa/n79 [9]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u932 (
    .a(\hlfa/n79 [9]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[7]),
    .o(\hlfa/n82 [9]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u933 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[6]),
    .d(hlfa_r[7]),
    .e(hlfa_r[8]),
    .o(_al_u933_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u934 (
    .a(_al_u933_o),
    .b(_al_u596_o),
    .c(_al_u597_o),
    .d(hlfa_r[0]),
    .e(hlfa_r[4]),
    .o(_al_u934_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u935 (
    .a(_al_u934_o),
    .b(_al_u639_o),
    .c(_al_u845_o),
    .d(hlfa_r[10]),
    .e(hlfa_r[9]),
    .o(_al_u935_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u936 (
    .a(_al_u935_o),
    .b(\hlfa/mux17_b2_sel_is_0_o ),
    .c(_al_u839_o),
    .d(hlfa_r[12]),
    .o(\hlfa/n79 [8]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u937 (
    .a(\hlfa/n79 [8]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[6]),
    .o(\hlfa/n82 [8]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*~(E)*~(A)+(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*E*~(A)+~((D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))*E*A+(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*E*A)"),
    .INIT(32'h0415aebf))
    _al_u938 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[10]),
    .d(hlfa_r[11]),
    .e(hlfa_r[9]),
    .o(_al_u938_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u939 (
    .a(_al_u938_o),
    .b(_al_u596_o),
    .c(_al_u597_o),
    .d(hlfa_r[3]),
    .e(hlfa_r[7]),
    .o(_al_u939_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'h020ef2fe))
    _al_u940 (
    .a(_al_u939_o),
    .b(_al_u639_o),
    .c(_al_u845_o),
    .d(hlfa_r[12]),
    .e(hlfa_r[13]),
    .o(_al_u940_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u941 (
    .a(_al_u940_o),
    .b(\hlfa/mux17_b2_sel_is_0_o ),
    .c(_al_u839_o),
    .d(hlfa_r[15]),
    .o(\hlfa/n79 [11]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u942 (
    .a(\hlfa/n79 [11]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[9]),
    .o(\hlfa/n82 [11]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u943 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[10]),
    .d(hlfa_r[8]),
    .e(hlfa_r[9]),
    .o(_al_u943_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u944 (
    .a(_al_u943_o),
    .b(_al_u596_o),
    .c(_al_u597_o),
    .d(hlfa_r[2]),
    .e(hlfa_r[6]),
    .o(_al_u944_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'h020ef2fe))
    _al_u945 (
    .a(_al_u944_o),
    .b(_al_u639_o),
    .c(_al_u845_o),
    .d(hlfa_r[11]),
    .e(hlfa_r[12]),
    .o(_al_u945_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u946 (
    .a(_al_u945_o),
    .b(\hlfa/mux17_b2_sel_is_0_o ),
    .c(_al_u839_o),
    .d(hlfa_r[14]),
    .o(\hlfa/n79 [10]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u947 (
    .a(\hlfa/n79 [10]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[8]),
    .o(\hlfa/n82 [10]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u948 (
    .a(_al_u594_o),
    .b(\hlfa/n61 [2]),
    .c(hlfa_e[2]),
    .o(\hlfa/n62 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u949 (
    .a(\hlfa/n62 [2]),
    .b(_al_u597_o),
    .c(_al_u593_o),
    .d(n2[1]),
    .e(n1[0]),
    .o(\hlfa/n66 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*~(D)*~(C)+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*~(C)+~((A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B))*D*C+(A*~(E)*~(B)+A*E*~(B)+~(A)*E*B+A*E*B)*D*C)"),
    .INIT(32'hfe0ef202))
    _al_u950 (
    .a(\hlfa/n66 [2]),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(\hlfa/n34 [2]),
    .e(hlfa_e[2]),
    .o(\hlfa/n70 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u951 (
    .a(\hlfa/n70 [2]),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(\hlfa/n25 [1]),
    .o(_al_u951_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~((~A*~(D*C)))*~(B)+~E*(~A*~(D*C))*~(B)+~(~E)*(~A*~(D*C))*B+~E*(~A*~(D*C))*B)"),
    .INIT(32'h04443777))
    _al_u952 (
    .a(_al_u951_o),
    .b(\hlfa/mux17_b2_sel_is_0_o ),
    .c(_al_u839_o),
    .d(\hlfa/n18 [0]),
    .e(hlfa_e[2]),
    .o(_al_u952_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u953 (
    .a(_al_u952_o),
    .b(hctl_load_a),
    .c(\hlfa/n1 [2]),
    .o(\hlfa/n81 [2]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u954 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[1]),
    .d(hlfa_r[2]),
    .e(hlfa_r[3]),
    .o(_al_u954_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(D)*~(C)+(~B*A)*D*~(C)+~((~B*A))*D*C+(~B*A)*D*C)"),
    .INIT(16'h0dfd))
    _al_u955 (
    .a(\hlfa/mux8_b2_sel_is_0_o ),
    .b(_al_u954_o),
    .c(_al_u639_o),
    .d(hlfa_r[4]),
    .o(_al_u955_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u956 (
    .a(_al_u955_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(hlfa_r[5]),
    .e(hlfa_r[7]),
    .o(\hlfa/n75 [3]));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))"),
    .INIT(16'ha808))
    _al_u957 (
    .a(\hlfa/mux21_b1_sel_is_0_o ),
    .b(\hlfa/n75 [3]),
    .c(_al_u837_o),
    .d(hlfa_r[11]),
    .o(_al_u957_o));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~(D*~C*B))"),
    .INIT(16'haeaa))
    _al_u958 (
    .a(_al_u957_o),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[1]),
    .o(\hlfa/n82 [3]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u959 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[0]),
    .d(hlfa_r[1]),
    .e(hlfa_r[2]),
    .o(_al_u959_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(D)*~(C)+(~B*A)*D*~(C)+~((~B*A))*D*C+(~B*A)*D*C)"),
    .INIT(16'h0dfd))
    _al_u960 (
    .a(\hlfa/mux8_b2_sel_is_0_o ),
    .b(_al_u959_o),
    .c(_al_u639_o),
    .d(hlfa_r[3]),
    .o(_al_u960_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u961 (
    .a(_al_u960_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(hlfa_r[4]),
    .e(hlfa_r[6]),
    .o(\hlfa/n75 [2]));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))"),
    .INIT(16'ha808))
    _al_u962 (
    .a(\hlfa/mux21_b1_sel_is_0_o ),
    .b(\hlfa/n75 [2]),
    .c(_al_u837_o),
    .d(hlfa_r[10]),
    .o(_al_u962_o));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~(D*~C*B))"),
    .INIT(16'haeaa))
    _al_u963 (
    .a(_al_u962_o),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[0]),
    .o(\hlfa/n82 [2]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u964 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[5]),
    .d(hlfa_r[6]),
    .e(hlfa_r[7]),
    .o(\hlfa/n65 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u965 (
    .a(\hlfa/n65 [7]),
    .b(_al_u597_o),
    .c(hlfa_r[3]),
    .o(\hlfa/n67 [7]));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(D)*~(C)+(~B*A)*D*~(C)+~((~B*A))*D*C+(~B*A)*D*C)"),
    .INIT(16'h0dfd))
    _al_u966 (
    .a(\hlfa/n67 [7]),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(hlfa_r[8]),
    .o(_al_u966_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u967 (
    .a(_al_u966_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(hlfa_r[11]),
    .e(hlfa_r[9]),
    .o(\hlfa/n75 [7]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u968 (
    .a(\hlfa/n75 [7]),
    .b(_al_u589_o),
    .c(_al_u837_o),
    .d(hlfa_r[15]),
    .o(\hlfa/n79 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u969 (
    .a(\hlfa/n79 [7]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[5]),
    .o(\hlfa/n82 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u970 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[4]),
    .d(hlfa_r[5]),
    .e(hlfa_r[6]),
    .o(\hlfa/n65 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u971 (
    .a(\hlfa/n65 [6]),
    .b(_al_u597_o),
    .c(hlfa_r[2]),
    .o(\hlfa/n67 [6]));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(D)*~(C)+(~B*A)*D*~(C)+~((~B*A))*D*C+(~B*A)*D*C)"),
    .INIT(16'h0dfd))
    _al_u972 (
    .a(\hlfa/n67 [6]),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(hlfa_r[7]),
    .o(_al_u972_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u973 (
    .a(_al_u972_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(hlfa_r[10]),
    .e(hlfa_r[8]),
    .o(\hlfa/n75 [6]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u974 (
    .a(\hlfa/n75 [6]),
    .b(_al_u589_o),
    .c(_al_u837_o),
    .d(hlfa_r[14]),
    .o(\hlfa/n79 [6]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u975 (
    .a(\hlfa/n79 [6]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[4]),
    .o(\hlfa/n82 [6]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u976 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[3]),
    .d(hlfa_r[4]),
    .e(hlfa_r[5]),
    .o(\hlfa/n65 [5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u977 (
    .a(\hlfa/n65 [5]),
    .b(_al_u597_o),
    .c(hlfa_r[1]),
    .o(\hlfa/n67 [5]));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(D)*~(C)+(~B*A)*D*~(C)+~((~B*A))*D*C+(~B*A)*D*C)"),
    .INIT(16'h0dfd))
    _al_u978 (
    .a(\hlfa/n67 [5]),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(hlfa_r[6]),
    .o(_al_u978_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u979 (
    .a(_al_u978_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(hlfa_r[7]),
    .e(hlfa_r[9]),
    .o(\hlfa/n75 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u980 (
    .a(\hlfa/n75 [5]),
    .b(_al_u589_o),
    .c(_al_u837_o),
    .d(hlfa_r[13]),
    .o(\hlfa/n79 [5]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u981 (
    .a(\hlfa/n79 [5]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[3]),
    .o(\hlfa/n82 [5]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u982 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(hlfa_r[2]),
    .d(hlfa_r[3]),
    .e(hlfa_r[4]),
    .o(\hlfa/n65 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u983 (
    .a(\hlfa/n65 [4]),
    .b(_al_u597_o),
    .c(hlfa_r[0]),
    .o(\hlfa/n67 [4]));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(D)*~(C)+(~B*A)*D*~(C)+~((~B*A))*D*C+(~B*A)*D*C)"),
    .INIT(16'h0dfd))
    _al_u984 (
    .a(\hlfa/n67 [4]),
    .b(_al_u596_o),
    .c(_al_u639_o),
    .d(hlfa_r[5]),
    .o(_al_u984_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u985 (
    .a(_al_u984_o),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(hlfa_r[6]),
    .e(hlfa_r[8]),
    .o(\hlfa/n75 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u986 (
    .a(\hlfa/n75 [4]),
    .b(_al_u589_o),
    .c(_al_u837_o),
    .d(hlfa_r[12]),
    .o(\hlfa/n79 [4]));
  AL_MAP_LUT4 #(
    .EQN("(A*~((D*~C))*~(B)+A*(D*~C)*~(B)+~(A)*(D*~C)*B+A*(D*~C)*B)"),
    .INIT(16'h2e22))
    _al_u987 (
    .a(\hlfa/n79 [4]),
    .b(hctl_load_a),
    .c(_al_u912_o),
    .d(abus[2]),
    .o(\hlfa/n82 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u988 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(\hlfa/n61 [5]),
    .d(n2[4]),
    .e(hlfa_e[5]),
    .o(\hlfa/n64 [5]));
  AL_MAP_LUT3 #(
    .EQN("~(C@(~B*~A))"),
    .INIT(8'h1e))
    _al_u989 (
    .a(hlfa_e[3]),
    .b(hlfa_e[4]),
    .c(hlfa_e[5]),
    .o(_al_u989_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~(~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+~(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hcdfd0131))
    _al_u990 (
    .a(\hlfa/n64 [5]),
    .b(_al_u596_o),
    .c(_al_u597_o),
    .d(n1[3]),
    .e(_al_u989_o),
    .o(_al_u990_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u991 (
    .a(_al_u990_o),
    .b(_al_u639_o),
    .c(\hlfa/n34 [5]),
    .o(\hlfa/n70 [5]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u992 (
    .a(\hlfa/n70 [5]),
    .b(_al_u839_o),
    .c(_al_u845_o),
    .d(\hlfa/n25 [4]),
    .e(\hlfa/n18 [3]),
    .o(\hlfa/n74 [5]));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((E@(D*C)))*~(B)+A*(E@(D*C))*~(B)+~(A)*(E@(D*C))*B+A*(E@(D*C))*B)"),
    .INIT(32'hd1111ddd))
    _al_u993 (
    .a(\hlfa/n74 [5]),
    .b(_al_u837_o),
    .c(hlfa_e[3]),
    .d(hlfa_e[4]),
    .e(hlfa_e[5]),
    .o(_al_u993_o));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~((D@C))*~(B)+~A*(D@C)*~(B)+~(~A)*(D@C)*B+~A*(D@C)*B)"),
    .INIT(16'he22e))
    _al_u994 (
    .a(_al_u993_o),
    .b(_al_u589_o),
    .c(hlfa_e[4]),
    .d(hlfa_e[5]),
    .o(_al_u994_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u995 (
    .a(_al_u994_o),
    .b(hctl_load_a),
    .c(\hlfa/n1 [5]),
    .o(\hlfa/n81 [5]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u996 (
    .a(_al_u593_o),
    .b(_al_u594_o),
    .c(\hlfa/n61 [4]),
    .d(n2[3]),
    .e(hlfa_e[4]),
    .o(\hlfa/n64 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u997 (
    .a(\hlfa/n64 [4]),
    .b(_al_u597_o),
    .c(n1[2]),
    .o(\hlfa/n66 [4]));
  AL_MAP_LUT4 #(
    .EQN("~(~A*~((D@C))*~(B)+~A*(D@C)*~(B)+~(~A)*(D@C)*B+~A*(D@C)*B)"),
    .INIT(16'he22e))
    _al_u998 (
    .a(\hlfa/n66 [4]),
    .b(_al_u596_o),
    .c(hlfa_e[3]),
    .d(hlfa_e[4]),
    .o(\hlfa/n68 [4]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u999 (
    .a(\hlfa/n68 [4]),
    .b(_al_u639_o),
    .c(\hlfa/n34 [4]),
    .o(_al_u999_o));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u0  (
    .a(\hadd/hlfa_f [0]),
    .b(\hadd/n3 [0]),
    .c(\hadd/add0/c0 ),
    .o({\hadd/add0/c1 ,\hadd/hlfc_f_t [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u1  (
    .a(\hadd/hlfa_f [1]),
    .b(\hadd/n3 [1]),
    .c(\hadd/add0/c1 ),
    .o({\hadd/add0/c2 ,\hadd/hlfc_f_t [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u10  (
    .a(\hadd/hlfa_f [10]),
    .b(\hadd/n3 [10]),
    .c(\hadd/add0/c10 ),
    .o({\hadd/add0/c11 ,\hadd/hlfc_f_t [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u11  (
    .a(\hadd/hlfa_f [11]),
    .b(\hadd/n3 [11]),
    .c(\hadd/add0/c11 ),
    .o({\hadd/add0/c12 ,\hadd/hlfc_f_t [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u12  (
    .a(\hadd/hlfa_f [12]),
    .b(\hadd/n3 [12]),
    .c(\hadd/add0/c12 ),
    .o({\hadd/add0/c13 ,\hadd/hlfc_f_t [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u13  (
    .a(\hadd/hlfa_f [13]),
    .b(\hadd/n3 [13]),
    .c(\hadd/add0/c13 ),
    .o({\hadd/add0/c14 ,\hadd/hlfc_f_t [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u14  (
    .a(\hadd/hlfa_f [14]),
    .b(\hadd/n3 [14]),
    .c(\hadd/add0/c14 ),
    .o({\hadd/add0/c15 ,\hadd/hlfc_f_t [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u15  (
    .a(\hadd/hlfa_f [15]),
    .b(\hadd/n3 [15]),
    .c(\hadd/add0/c15 ),
    .o({open_n0,\hadd/hlfc_f_t [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u2  (
    .a(\hadd/hlfa_f [2]),
    .b(\hadd/n3 [2]),
    .c(\hadd/add0/c2 ),
    .o({\hadd/add0/c3 ,\hadd/hlfc_f_t [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u3  (
    .a(\hadd/hlfa_f [3]),
    .b(\hadd/n3 [3]),
    .c(\hadd/add0/c3 ),
    .o({\hadd/add0/c4 ,\hadd/hlfc_f_t [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u4  (
    .a(\hadd/hlfa_f [4]),
    .b(\hadd/n3 [4]),
    .c(\hadd/add0/c4 ),
    .o({\hadd/add0/c5 ,\hadd/hlfc_f_t [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u5  (
    .a(\hadd/hlfa_f [5]),
    .b(\hadd/n3 [5]),
    .c(\hadd/add0/c5 ),
    .o({\hadd/add0/c6 ,\hadd/hlfc_f_t [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u6  (
    .a(\hadd/hlfa_f [6]),
    .b(\hadd/n3 [6]),
    .c(\hadd/add0/c6 ),
    .o({\hadd/add0/c7 ,\hadd/hlfc_f_t [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u7  (
    .a(\hadd/hlfa_f [7]),
    .b(\hadd/n3 [7]),
    .c(\hadd/add0/c7 ),
    .o({\hadd/add0/c8 ,\hadd/hlfc_f_t [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u8  (
    .a(\hadd/hlfa_f [8]),
    .b(\hadd/n3 [8]),
    .c(\hadd/add0/c8 ),
    .o({\hadd/add0/c9 ,\hadd/hlfc_f_t [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hadd/add0/u9  (
    .a(\hadd/hlfa_f [9]),
    .b(\hadd/n3 [9]),
    .c(\hadd/add0/c9 ),
    .o({\hadd/add0/c10 ,\hadd/hlfc_f_t [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hadd/add0/ucin  (
    .a(1'b0),
    .o({\hadd/add0/c0 ,open_n3}));
  AL_MAP_LUT4 #(
    .EQN("(A*B*~C*~D+A*B*C*~D+~A*~B*C*D+A*~B*C*D+A*B*C*D)"),
    .INIT(16'b1011000010001000))
    \hadd/mux2_rom0  (
    .a(hlfb_r[22]),
    .b(hlfb_r[24]),
    .c(hlfa_r[22]),
    .d(hlfa_r[24]),
    .o(\hadd/inf_s ));
  AL_MAP_LUT4 #(
    .EQN("(A*B*~C*D+~A*B*C*D)"),
    .INIT(16'b0100100000000000))
    \hadd/mux3_rom0  (
    .a(hlfb_r[22]),
    .b(hlfb_r[24]),
    .c(hlfa_r[22]),
    .d(hlfa_r[24]),
    .o(\hadd/inf_nan ));
  AL_MAP_LUT4 #(
    .EQN("(~A*B*~C*~D+A*B*~C*~D+~A*B*C*~D+A*B*C*~D+~A*~B*~C*D+A*~B*~C*D+~A*B*~C*D+~A*~B*C*D+A*~B*C*D+A*B*C*D)"),
    .INIT(16'b1011011111001100))
    \hadd/mux4_rom0  (
    .a(hlfb_r[22]),
    .b(hlfb_r[24]),
    .c(hlfa_r[22]),
    .d(hlfa_r[24]),
    .o(hlfc_r_hadd[24]));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u0  (
    .a(1'b0),
    .b(\hadd/hlfb_f [0]),
    .c(\hadd/neg0/c0 ),
    .o({\hadd/neg0/c1 ,\hadd/n2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u1  (
    .a(1'b0),
    .b(\hadd/hlfb_f [1]),
    .c(\hadd/neg0/c1 ),
    .o({\hadd/neg0/c2 ,\hadd/n2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u10  (
    .a(1'b0),
    .b(\hadd/hlfb_f [10]),
    .c(\hadd/neg0/c10 ),
    .o({\hadd/neg0/c11 ,\hadd/n2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u11  (
    .a(1'b0),
    .b(\hadd/hlfb_f [11]),
    .c(\hadd/neg0/c11 ),
    .o({\hadd/neg0/c12 ,\hadd/n2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u12  (
    .a(1'b0),
    .b(\hadd/hlfb_f [12]),
    .c(\hadd/neg0/c12 ),
    .o({\hadd/neg0/c13 ,\hadd/n2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u13  (
    .a(1'b0),
    .b(\hadd/hlfb_f [13]),
    .c(\hadd/neg0/c13 ),
    .o({\hadd/neg0/c14 ,\hadd/n2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u14  (
    .a(1'b0),
    .b(1'b0),
    .c(\hadd/neg0/c14 ),
    .o({\hadd/neg0/c15 ,\hadd/n2 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u15  (
    .a(1'b0),
    .b(1'b0),
    .c(\hadd/neg0/c15 ),
    .o({open_n4,\hadd/n2 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u2  (
    .a(1'b0),
    .b(\hadd/hlfb_f [2]),
    .c(\hadd/neg0/c2 ),
    .o({\hadd/neg0/c3 ,\hadd/n2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u3  (
    .a(1'b0),
    .b(\hadd/hlfb_f [3]),
    .c(\hadd/neg0/c3 ),
    .o({\hadd/neg0/c4 ,\hadd/n2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u4  (
    .a(1'b0),
    .b(\hadd/hlfb_f [4]),
    .c(\hadd/neg0/c4 ),
    .o({\hadd/neg0/c5 ,\hadd/n2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u5  (
    .a(1'b0),
    .b(\hadd/hlfb_f [5]),
    .c(\hadd/neg0/c5 ),
    .o({\hadd/neg0/c6 ,\hadd/n2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u6  (
    .a(1'b0),
    .b(\hadd/hlfb_f [6]),
    .c(\hadd/neg0/c6 ),
    .o({\hadd/neg0/c7 ,\hadd/n2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u7  (
    .a(1'b0),
    .b(\hadd/hlfb_f [7]),
    .c(\hadd/neg0/c7 ),
    .o({\hadd/neg0/c8 ,\hadd/n2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u8  (
    .a(1'b0),
    .b(\hadd/hlfb_f [8]),
    .c(\hadd/neg0/c8 ),
    .o({\hadd/neg0/c9 ,\hadd/n2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg0/u9  (
    .a(1'b0),
    .b(\hadd/hlfb_f [9]),
    .c(\hadd/neg0/c9 ),
    .o({\hadd/neg0/c10 ,\hadd/n2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hadd/neg0/ucin  (
    .a(1'b0),
    .o({\hadd/neg0/c0 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u0  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [0]),
    .c(\hadd/neg1/c0 ),
    .o({\hadd/neg1/c1 ,\hadd/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u1  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [1]),
    .c(\hadd/neg1/c1 ),
    .o({\hadd/neg1/c2 ,\hadd/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u10  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [10]),
    .c(\hadd/neg1/c10 ),
    .o({\hadd/neg1/c11 ,\hadd/n4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u11  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [11]),
    .c(\hadd/neg1/c11 ),
    .o({\hadd/neg1/c12 ,\hadd/n4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u12  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [12]),
    .c(\hadd/neg1/c12 ),
    .o({\hadd/neg1/c13 ,\hadd/n4 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u13  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [13]),
    .c(\hadd/neg1/c13 ),
    .o({\hadd/neg1/c14 ,\hadd/n4 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u14  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [14]),
    .c(\hadd/neg1/c14 ),
    .o({\hadd/neg1/c15 ,\hadd/n4 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u15  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [15]),
    .c(\hadd/neg1/c15 ),
    .o({open_n8,\hadd/n4 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u2  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [2]),
    .c(\hadd/neg1/c2 ),
    .o({\hadd/neg1/c3 ,\hadd/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u3  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [3]),
    .c(\hadd/neg1/c3 ),
    .o({\hadd/neg1/c4 ,\hadd/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u4  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [4]),
    .c(\hadd/neg1/c4 ),
    .o({\hadd/neg1/c5 ,\hadd/n4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u5  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [5]),
    .c(\hadd/neg1/c5 ),
    .o({\hadd/neg1/c6 ,\hadd/n4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u6  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [6]),
    .c(\hadd/neg1/c6 ),
    .o({\hadd/neg1/c7 ,\hadd/n4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u7  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [7]),
    .c(\hadd/neg1/c7 ),
    .o({\hadd/neg1/c8 ,\hadd/n4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u8  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [8]),
    .c(\hadd/neg1/c8 ),
    .o({\hadd/neg1/c9 ,\hadd/n4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hadd/neg1/u9  (
    .a(1'b0),
    .b(\hadd/hlfc_f_t [9]),
    .c(\hadd/neg1/c9 ),
    .o({\hadd/neg1/c10 ,\hadd/n4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hadd/neg1/ucin  (
    .a(1'b0),
    .o({\hadd/neg1/c0 ,open_n11}));
  reg_sr_as_w1 \hctl/crdy_f_reg  (
    .clk(clk),
    .d(\hctl/crdy_t ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hctl/crdy_f ));  // rtl/hfpu_fsm.v(190)
  reg_sr_as_w1 \hctl/hctl_ccmd_add_reg  (
    .clk(clk),
    .d(\hctl/n10 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_add));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/hctl_ccmd_cmp_reg  (
    .clk(clk),
    .d(\hctl/n9 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_cmp));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/hctl_ccmd_div_reg  (
    .clk(clk),
    .d(\hctl/n16 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_div));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/hctl_ccmd_hlf_reg  (
    .clk(clk),
    .d(\hctl/n17 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_hlf));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/hctl_ccmd_int_reg  (
    .clk(clk),
    .d(\hctl/n31 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_int));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/hctl_ccmd_mul_reg  (
    .clk(clk),
    .d(\hctl/n15 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_mul));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/hctl_ccmd_reg_reg  (
    .clk(clk),
    .d(\hctl/n27 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_reg));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/hctl_ccmd_sub_reg  (
    .clk(clk),
    .d(\hctl/n13 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(hctl_ccmd_sub));  // rtl/hfpu_fsm.v(138)
  reg_sr_as_w1 \hctl/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\hctl/mux0_b0_sel_is_1_o ),
    .set(1'b0),
    .q(\hctl/stat [0]));  // rtl/hfpu_fsm.v(182)
  reg_sr_as_w1 \hctl/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\hctl/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\hctl/stat [1]));  // rtl/hfpu_fsm.v(182)
  reg_sr_as_w1 \hctl/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\hctl/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\hctl/stat [2]));  // rtl/hfpu_fsm.v(182)
  reg_sr_as_w1 \hctl/reg0_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\hctl/mux0_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\hctl/stat [3]));  // rtl/hfpu_fsm.v(182)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u0  (
    .a(\hdiv/dso [10]),
    .b(\hdiv/fdiv/n1 [0]),
    .c(\hdiv/fdiv/add0_2/c0 ),
    .o({\hdiv/fdiv/add0_2/c1 ,\hdiv/fdiv/rem3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u1  (
    .a(\hdiv/dso [11]),
    .b(\hdiv/fdiv/n1 [1]),
    .c(\hdiv/fdiv/add0_2/c1 ),
    .o({\hdiv/fdiv/add0_2/c2 ,\hdiv/fdiv/rem3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u10  (
    .a(\hdiv/dso [20]),
    .b(\hdiv/fdiv/n1 [10]),
    .c(\hdiv/fdiv/add0_2/c10 ),
    .o({\hdiv/fdiv/add0_2/c11 ,\hdiv/fdiv/rem3 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u11  (
    .a(\hdiv/dso [21]),
    .b(\hdiv/fdiv/n1 [11]),
    .c(\hdiv/fdiv/add0_2/c11 ),
    .o({\hdiv/fdiv/add0_2/c12 ,\hdiv/fdiv/rem3 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u12  (
    .a(\hdiv/dso [22]),
    .b(\hdiv/fdiv/n0 ),
    .c(\hdiv/fdiv/add0_2/c12 ),
    .o({open_n12,\hdiv/fdiv/rem3 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u2  (
    .a(\hdiv/dso [12]),
    .b(\hdiv/fdiv/n1 [2]),
    .c(\hdiv/fdiv/add0_2/c2 ),
    .o({\hdiv/fdiv/add0_2/c3 ,\hdiv/fdiv/rem3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u3  (
    .a(\hdiv/dso [13]),
    .b(\hdiv/fdiv/n1 [3]),
    .c(\hdiv/fdiv/add0_2/c3 ),
    .o({\hdiv/fdiv/add0_2/c4 ,\hdiv/fdiv/rem3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u4  (
    .a(\hdiv/dso [14]),
    .b(\hdiv/fdiv/n1 [4]),
    .c(\hdiv/fdiv/add0_2/c4 ),
    .o({\hdiv/fdiv/add0_2/c5 ,\hdiv/fdiv/rem3 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u5  (
    .a(\hdiv/dso [15]),
    .b(\hdiv/fdiv/n1 [5]),
    .c(\hdiv/fdiv/add0_2/c5 ),
    .o({\hdiv/fdiv/add0_2/c6 ,\hdiv/fdiv/rem3 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u6  (
    .a(\hdiv/dso [16]),
    .b(\hdiv/fdiv/n1 [6]),
    .c(\hdiv/fdiv/add0_2/c6 ),
    .o({\hdiv/fdiv/add0_2/c7 ,\hdiv/fdiv/rem3 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u7  (
    .a(\hdiv/dso [17]),
    .b(\hdiv/fdiv/n1 [7]),
    .c(\hdiv/fdiv/add0_2/c7 ),
    .o({\hdiv/fdiv/add0_2/c8 ,\hdiv/fdiv/rem3 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u8  (
    .a(\hdiv/dso [18]),
    .b(\hdiv/fdiv/n1 [8]),
    .c(\hdiv/fdiv/add0_2/c8 ),
    .o({\hdiv/fdiv/add0_2/c9 ,\hdiv/fdiv/rem3 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add0_2/u9  (
    .a(\hdiv/dso [19]),
    .b(\hdiv/fdiv/n1 [9]),
    .c(\hdiv/fdiv/add0_2/c9 ),
    .o({\hdiv/fdiv/add0_2/c10 ,\hdiv/fdiv/rem3 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hdiv/fdiv/add0_2/ucin  (
    .a(\hdiv/fdiv/n0 ),
    .o({\hdiv/fdiv/add0_2/c0 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u0  (
    .a(\hdiv/dso [9]),
    .b(\hdiv/fdiv/n3 [0]),
    .c(\hdiv/fdiv/add1_2/c0 ),
    .o({\hdiv/fdiv/add1_2/c1 ,\hdiv/fdiv/rem2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u1  (
    .a(\hdiv/fdiv/rem3 [1]),
    .b(\hdiv/fdiv/n3 [1]),
    .c(\hdiv/fdiv/add1_2/c1 ),
    .o({\hdiv/fdiv/add1_2/c2 ,\hdiv/fdiv/rem2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u10  (
    .a(\hdiv/fdiv/rem3 [10]),
    .b(\hdiv/fdiv/n3 [10]),
    .c(\hdiv/fdiv/add1_2/c10 ),
    .o({\hdiv/fdiv/add1_2/c11 ,\hdiv/fdiv/rem2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u11  (
    .a(\hdiv/fdiv/rem3 [11]),
    .b(\hdiv/fdiv/n3 [11]),
    .c(\hdiv/fdiv/add1_2/c11 ),
    .o({\hdiv/fdiv/add1_2/c12 ,\hdiv/fdiv/rem2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u12  (
    .a(\hdiv/fdiv/rem3 [12]),
    .b(hlfc_r_hdiv[4]),
    .c(\hdiv/fdiv/add1_2/c12 ),
    .o({open_n16,\hdiv/fdiv/rem2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u2  (
    .a(\hdiv/fdiv/rem3 [2]),
    .b(\hdiv/fdiv/n3 [2]),
    .c(\hdiv/fdiv/add1_2/c2 ),
    .o({\hdiv/fdiv/add1_2/c3 ,\hdiv/fdiv/rem2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u3  (
    .a(\hdiv/fdiv/rem3 [3]),
    .b(\hdiv/fdiv/n3 [3]),
    .c(\hdiv/fdiv/add1_2/c3 ),
    .o({\hdiv/fdiv/add1_2/c4 ,\hdiv/fdiv/rem2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u4  (
    .a(\hdiv/fdiv/rem3 [4]),
    .b(\hdiv/fdiv/n3 [4]),
    .c(\hdiv/fdiv/add1_2/c4 ),
    .o({\hdiv/fdiv/add1_2/c5 ,\hdiv/fdiv/rem2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u5  (
    .a(\hdiv/fdiv/rem3 [5]),
    .b(\hdiv/fdiv/n3 [5]),
    .c(\hdiv/fdiv/add1_2/c5 ),
    .o({\hdiv/fdiv/add1_2/c6 ,\hdiv/fdiv/rem2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u6  (
    .a(\hdiv/fdiv/rem3 [6]),
    .b(\hdiv/fdiv/n3 [6]),
    .c(\hdiv/fdiv/add1_2/c6 ),
    .o({\hdiv/fdiv/add1_2/c7 ,\hdiv/fdiv/rem2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u7  (
    .a(\hdiv/fdiv/rem3 [7]),
    .b(\hdiv/fdiv/n3 [7]),
    .c(\hdiv/fdiv/add1_2/c7 ),
    .o({\hdiv/fdiv/add1_2/c8 ,\hdiv/fdiv/rem2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u8  (
    .a(\hdiv/fdiv/rem3 [8]),
    .b(\hdiv/fdiv/n3 [8]),
    .c(\hdiv/fdiv/add1_2/c8 ),
    .o({\hdiv/fdiv/add1_2/c9 ,\hdiv/fdiv/rem2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add1_2/u9  (
    .a(\hdiv/fdiv/rem3 [9]),
    .b(\hdiv/fdiv/n3 [9]),
    .c(\hdiv/fdiv/add1_2/c9 ),
    .o({\hdiv/fdiv/add1_2/c10 ,\hdiv/fdiv/rem2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hdiv/fdiv/add1_2/ucin  (
    .a(hlfc_r_hdiv[4]),
    .o({\hdiv/fdiv/add1_2/c0 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u0  (
    .a(\hdiv/dso [8]),
    .b(\hdiv/fdiv/n5 [0]),
    .c(\hdiv/fdiv/add2_2/c0 ),
    .o({\hdiv/fdiv/add2_2/c1 ,\hdiv/fdiv/rem1 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u1  (
    .a(\hdiv/fdiv/rem2 [1]),
    .b(\hdiv/fdiv/n5 [1]),
    .c(\hdiv/fdiv/add2_2/c1 ),
    .o({\hdiv/fdiv/add2_2/c2 ,\hdiv/fdiv/rem1 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u10  (
    .a(\hdiv/fdiv/rem2 [10]),
    .b(\hdiv/fdiv/n5 [10]),
    .c(\hdiv/fdiv/add2_2/c10 ),
    .o({\hdiv/fdiv/add2_2/c11 ,\hdiv/fdiv/rem1 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u11  (
    .a(\hdiv/fdiv/rem2 [11]),
    .b(\hdiv/fdiv/n5 [11]),
    .c(\hdiv/fdiv/add2_2/c11 ),
    .o({\hdiv/fdiv/add2_2/c12 ,\hdiv/fdiv/rem1 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u12  (
    .a(\hdiv/fdiv/rem2 [12]),
    .b(hlfc_r_hdiv[3]),
    .c(\hdiv/fdiv/add2_2/c12 ),
    .o({open_n20,\hdiv/fdiv/rem1 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u2  (
    .a(\hdiv/fdiv/rem2 [2]),
    .b(\hdiv/fdiv/n5 [2]),
    .c(\hdiv/fdiv/add2_2/c2 ),
    .o({\hdiv/fdiv/add2_2/c3 ,\hdiv/fdiv/rem1 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u3  (
    .a(\hdiv/fdiv/rem2 [3]),
    .b(\hdiv/fdiv/n5 [3]),
    .c(\hdiv/fdiv/add2_2/c3 ),
    .o({\hdiv/fdiv/add2_2/c4 ,\hdiv/fdiv/rem1 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u4  (
    .a(\hdiv/fdiv/rem2 [4]),
    .b(\hdiv/fdiv/n5 [4]),
    .c(\hdiv/fdiv/add2_2/c4 ),
    .o({\hdiv/fdiv/add2_2/c5 ,\hdiv/fdiv/rem1 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u5  (
    .a(\hdiv/fdiv/rem2 [5]),
    .b(\hdiv/fdiv/n5 [5]),
    .c(\hdiv/fdiv/add2_2/c5 ),
    .o({\hdiv/fdiv/add2_2/c6 ,\hdiv/fdiv/rem1 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u6  (
    .a(\hdiv/fdiv/rem2 [6]),
    .b(\hdiv/fdiv/n5 [6]),
    .c(\hdiv/fdiv/add2_2/c6 ),
    .o({\hdiv/fdiv/add2_2/c7 ,\hdiv/fdiv/rem1 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u7  (
    .a(\hdiv/fdiv/rem2 [7]),
    .b(\hdiv/fdiv/n5 [7]),
    .c(\hdiv/fdiv/add2_2/c7 ),
    .o({\hdiv/fdiv/add2_2/c8 ,\hdiv/fdiv/rem1 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u8  (
    .a(\hdiv/fdiv/rem2 [8]),
    .b(\hdiv/fdiv/n5 [8]),
    .c(\hdiv/fdiv/add2_2/c8 ),
    .o({\hdiv/fdiv/add2_2/c9 ,\hdiv/fdiv/rem1 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add2_2/u9  (
    .a(\hdiv/fdiv/rem2 [9]),
    .b(\hdiv/fdiv/n5 [9]),
    .c(\hdiv/fdiv/add2_2/c9 ),
    .o({\hdiv/fdiv/add2_2/c10 ,\hdiv/fdiv/rem1 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hdiv/fdiv/add2_2/ucin  (
    .a(hlfc_r_hdiv[3]),
    .o({\hdiv/fdiv/add2_2/c0 ,open_n23}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u0  (
    .a(hlfc_r_hdiv[2]),
    .b(\hdiv/fdiv/n7 [0]),
    .c(\hdiv/fdiv/add3_2/c0 ),
    .o({\hdiv/fdiv/add3_2/c1 ,\hdiv/rem [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u1  (
    .a(\hdiv/fdiv/rem1 [1]),
    .b(\hdiv/fdiv/n7 [1]),
    .c(\hdiv/fdiv/add3_2/c1 ),
    .o({\hdiv/fdiv/add3_2/c2 ,\hdiv/rem [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u10  (
    .a(\hdiv/fdiv/rem1 [10]),
    .b(\hdiv/fdiv/n7 [10]),
    .c(\hdiv/fdiv/add3_2/c10 ),
    .o({\hdiv/fdiv/add3_2/c11 ,\hdiv/rem [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u11  (
    .a(\hdiv/fdiv/rem1 [11]),
    .b(\hdiv/fdiv/n7 [11]),
    .c(\hdiv/fdiv/add3_2/c11 ),
    .o({\hdiv/fdiv/add3_2/c12 ,\hdiv/rem [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u12  (
    .a(\hdiv/fdiv/rem1 [12]),
    .b(hlfc_r_hdiv[2]),
    .c(\hdiv/fdiv/add3_2/c12 ),
    .o({open_n24,\hdiv/rem [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u2  (
    .a(\hdiv/fdiv/rem1 [2]),
    .b(\hdiv/fdiv/n7 [2]),
    .c(\hdiv/fdiv/add3_2/c2 ),
    .o({\hdiv/fdiv/add3_2/c3 ,\hdiv/rem [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u3  (
    .a(\hdiv/fdiv/rem1 [3]),
    .b(\hdiv/fdiv/n7 [3]),
    .c(\hdiv/fdiv/add3_2/c3 ),
    .o({\hdiv/fdiv/add3_2/c4 ,\hdiv/rem [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u4  (
    .a(\hdiv/fdiv/rem1 [4]),
    .b(\hdiv/fdiv/n7 [4]),
    .c(\hdiv/fdiv/add3_2/c4 ),
    .o({\hdiv/fdiv/add3_2/c5 ,\hdiv/rem [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u5  (
    .a(\hdiv/fdiv/rem1 [5]),
    .b(\hdiv/fdiv/n7 [5]),
    .c(\hdiv/fdiv/add3_2/c5 ),
    .o({\hdiv/fdiv/add3_2/c6 ,\hdiv/rem [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u6  (
    .a(\hdiv/fdiv/rem1 [6]),
    .b(\hdiv/fdiv/n7 [6]),
    .c(\hdiv/fdiv/add3_2/c6 ),
    .o({\hdiv/fdiv/add3_2/c7 ,\hdiv/rem [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u7  (
    .a(\hdiv/fdiv/rem1 [7]),
    .b(\hdiv/fdiv/n7 [7]),
    .c(\hdiv/fdiv/add3_2/c7 ),
    .o({\hdiv/fdiv/add3_2/c8 ,\hdiv/rem [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u8  (
    .a(\hdiv/fdiv/rem1 [8]),
    .b(\hdiv/fdiv/n7 [8]),
    .c(\hdiv/fdiv/add3_2/c8 ),
    .o({\hdiv/fdiv/add3_2/c9 ,\hdiv/rem [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hdiv/fdiv/add3_2/u9  (
    .a(\hdiv/fdiv/rem1 [9]),
    .b(\hdiv/fdiv/n7 [9]),
    .c(\hdiv/fdiv/add3_2/c9 ),
    .o({\hdiv/fdiv/add3_2/c10 ,\hdiv/rem [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hdiv/fdiv/add3_2/ucin  (
    .a(1'b0),
    .o({\hdiv/fdiv/add3_2/c0 ,open_n27}));
  reg_sr_as_w1 \hdiv/reg0_b0  (
    .clk(clk),
    .d(hlfb_r[2]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [0]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b1  (
    .clk(clk),
    .d(hlfb_r[3]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [1]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b10  (
    .clk(clk),
    .d(hlfb_r[12]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [10]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b11  (
    .clk(clk),
    .d(hlfb_r[13]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [11]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b2  (
    .clk(clk),
    .d(hlfb_r[4]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [2]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b3  (
    .clk(clk),
    .d(hlfb_r[5]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [3]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b4  (
    .clk(clk),
    .d(hlfb_r[6]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [4]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b5  (
    .clk(clk),
    .d(hlfb_r[7]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [5]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b6  (
    .clk(clk),
    .d(hlfb_r[8]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [6]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b7  (
    .clk(clk),
    .d(hlfb_r[9]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [7]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b8  (
    .clk(clk),
    .d(hlfb_r[10]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [8]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg0_b9  (
    .clk(clk),
    .d(hlfb_r[11]),
    .en(~\hctl/n168 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/den [9]));  // rtl/hfpu_hdiv.v(78)
  reg_sr_as_w1 \hdiv/reg1_b0  (
    .clk(clk),
    .d(hlfc_r_hdiv[1]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[5]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg1_b1  (
    .clk(clk),
    .d(hlfc_r_hdiv[2]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[6]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg1_b2  (
    .clk(clk),
    .d(hlfc_r_hdiv[3]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[7]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg1_b3  (
    .clk(clk),
    .d(hlfc_r_hdiv[4]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[8]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg1_b4  (
    .clk(clk),
    .d(hlfc_r_hdiv[5]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[9]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg1_b5  (
    .clk(clk),
    .d(hlfc_r_hdiv[6]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[10]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg1_b6  (
    .clk(clk),
    .d(hlfc_r_hdiv[7]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[11]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg1_b7  (
    .clk(clk),
    .d(hlfc_r_hdiv[8]),
    .en(hctl_dsft_enb),
    .reset(\hdiv/n15 ),
    .set(1'b0),
    .q(hlfc_r_hdiv[12]));  // rtl/hfpu_hdiv.v(88)
  reg_sr_as_w1 \hdiv/reg2_b10  (
    .clk(clk),
    .d(\hdiv/n9 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [10]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b11  (
    .clk(clk),
    .d(\hdiv/n9 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [11]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b12  (
    .clk(clk),
    .d(\hdiv/n9 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [12]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b13  (
    .clk(clk),
    .d(\hdiv/n9 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [13]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b14  (
    .clk(clk),
    .d(\hdiv/n9 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [14]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b15  (
    .clk(clk),
    .d(\hdiv/n9 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [15]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b16  (
    .clk(clk),
    .d(\hdiv/n9 [16]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [16]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b17  (
    .clk(clk),
    .d(\hdiv/n9 [17]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [17]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b18  (
    .clk(clk),
    .d(\hdiv/n9 [18]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [18]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b19  (
    .clk(clk),
    .d(\hdiv/n9 [19]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [19]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b20  (
    .clk(clk),
    .d(\hdiv/n9 [20]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [20]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b21  (
    .clk(clk),
    .d(\hdiv/n9 [21]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [21]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b22  (
    .clk(clk),
    .d(\hdiv/n9 [22]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [22]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b23  (
    .clk(clk),
    .d(\hdiv/n9 [23]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [23]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b8  (
    .clk(clk),
    .d(\hdiv/n9 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [8]));  // rtl/hfpu_hdiv.v(68)
  reg_sr_as_w1 \hdiv/reg2_b9  (
    .clk(clk),
    .d(\hdiv/n9 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hdiv/dso [9]));  // rtl/hfpu_hdiv.v(68)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hdiv/sub0/u0  (
    .a(hlfa_e[0]),
    .b(hlfb_e[0]),
    .c(\hdiv/sub0/c0 ),
    .o({\hdiv/sub0/c1 ,hlfc_r_hdiv[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hdiv/sub0/u1  (
    .a(hlfa_e[1]),
    .b(hlfb_e[1]),
    .c(\hdiv/sub0/c1 ),
    .o({\hdiv/sub0/c2 ,hlfc_r_hdiv[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hdiv/sub0/u2  (
    .a(hlfa_e[2]),
    .b(hlfb_e[2]),
    .c(\hdiv/sub0/c2 ),
    .o({\hdiv/sub0/c3 ,hlfc_r_hdiv[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hdiv/sub0/u3  (
    .a(hlfa_e[3]),
    .b(hlfb_e[3]),
    .c(\hdiv/sub0/c3 ),
    .o({\hdiv/sub0/c4 ,hlfc_r_hdiv[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hdiv/sub0/u4  (
    .a(hlfa_e[4]),
    .b(hlfb_e[4]),
    .c(\hdiv/sub0/c4 ),
    .o({\hdiv/sub0/c5 ,hlfc_r_hdiv[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hdiv/sub0/u5  (
    .a(hlfa_e[5]),
    .b(hlfb_e[5]),
    .c(\hdiv/sub0/c5 ),
    .o({open_n28,hlfc_r_hdiv[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hdiv/sub0/ucin  (
    .a(1'b0),
    .o({\hdiv/sub0/c0 ,open_n31}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add2/u0  (
    .a(hlfa_e[2]),
    .b(1'b1),
    .c(\hlfa/add2/c0 ),
    .o({\hlfa/add2/c1 ,\hlfa/n18 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add2/u1  (
    .a(hlfa_e[3]),
    .b(1'b0),
    .c(\hlfa/add2/c1 ),
    .o({\hlfa/add2/c2 ,\hlfa/n18 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add2/u2  (
    .a(hlfa_e[4]),
    .b(1'b0),
    .c(\hlfa/add2/c2 ),
    .o({\hlfa/add2/c3 ,\hlfa/n18 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add2/u3  (
    .a(hlfa_e[5]),
    .b(1'b0),
    .c(\hlfa/add2/c3 ),
    .o({open_n32,\hlfa/n18 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hlfa/add2/ucin  (
    .a(1'b0),
    .o({\hlfa/add2/c0 ,open_n35}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add3/u0  (
    .a(hlfa_e[1]),
    .b(1'b1),
    .c(\hlfa/add3/c0 ),
    .o({\hlfa/add3/c1 ,\hlfa/n25 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add3/u1  (
    .a(hlfa_e[2]),
    .b(1'b0),
    .c(\hlfa/add3/c1 ),
    .o({\hlfa/add3/c2 ,\hlfa/n25 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add3/u2  (
    .a(hlfa_e[3]),
    .b(1'b0),
    .c(\hlfa/add3/c2 ),
    .o({\hlfa/add3/c3 ,\hlfa/n25 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add3/u3  (
    .a(hlfa_e[4]),
    .b(1'b0),
    .c(\hlfa/add3/c3 ),
    .o({\hlfa/add3/c4 ,\hlfa/n25 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add3/u4  (
    .a(hlfa_e[5]),
    .b(1'b0),
    .c(\hlfa/add3/c4 ),
    .o({open_n36,\hlfa/n25 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hlfa/add3/ucin  (
    .a(1'b0),
    .o({\hlfa/add3/c0 ,open_n39}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add4/u0  (
    .a(hlfa_e[0]),
    .b(1'b1),
    .c(\hlfa/add4/c0 ),
    .o({\hlfa/add4/c1 ,\hlfa/n34 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add4/u1  (
    .a(hlfa_e[1]),
    .b(1'b0),
    .c(\hlfa/add4/c1 ),
    .o({\hlfa/add4/c2 ,\hlfa/n34 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add4/u2  (
    .a(hlfa_e[2]),
    .b(1'b0),
    .c(\hlfa/add4/c2 ),
    .o({\hlfa/add4/c3 ,\hlfa/n34 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add4/u3  (
    .a(hlfa_e[3]),
    .b(1'b0),
    .c(\hlfa/add4/c3 ),
    .o({\hlfa/add4/c4 ,\hlfa/n34 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add4/u4  (
    .a(hlfa_e[4]),
    .b(1'b0),
    .c(\hlfa/add4/c4 ),
    .o({\hlfa/add4/c5 ,\hlfa/n34 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfa/add4/u5  (
    .a(hlfa_e[5]),
    .b(1'b0),
    .c(\hlfa/add4/c5 ),
    .o({open_n40,\hlfa/n34 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hlfa/add4/ucin  (
    .a(1'b0),
    .o({\hlfa/add4/c0 ,open_n43}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt0_0  (
    .a(\hlfa/hlfa_e_dif [0]),
    .b(1'b0),
    .c(\hlfa/lt0_c0 ),
    .o({\hlfa/lt0_c1 ,open_n44}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt0_1  (
    .a(\hlfa/hlfa_e_dif [1]),
    .b(1'b0),
    .c(\hlfa/lt0_c1 ),
    .o({\hlfa/lt0_c2 ,open_n45}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt0_2  (
    .a(\hlfa/hlfa_e_dif [2]),
    .b(1'b0),
    .c(\hlfa/lt0_c2 ),
    .o({\hlfa/lt0_c3 ,open_n46}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt0_3  (
    .a(\hlfa/hlfa_e_dif [3]),
    .b(1'b0),
    .c(\hlfa/lt0_c3 ),
    .o({\hlfa/lt0_c4 ,open_n47}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt0_4  (
    .a(\hlfa/hlfa_e_dif [4]),
    .b(1'b0),
    .c(\hlfa/lt0_c4 ),
    .o({\hlfa/lt0_c5 ,open_n48}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt0_5  (
    .a(1'b0),
    .b(\hlfa/hlfa_e_dif [5]),
    .c(\hlfa/lt0_c5 ),
    .o({\hlfa/lt0_c6 ,open_n49}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \hlfa/lt0_cin  (
    .a(1'b1),
    .o({\hlfa/lt0_c0 ,open_n52}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\hlfa/lt0_c6 ),
    .o({open_n53,\hlfa/hlfa_rsft_fin }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt1_0  (
    .a(\hlfa/hlfa_e_difl [0]),
    .b(1'b0),
    .c(\hlfa/lt1_c0 ),
    .o({\hlfa/lt1_c1 ,open_n54}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt1_1  (
    .a(\hlfa/hlfa_e_difl [1]),
    .b(1'b0),
    .c(\hlfa/lt1_c1 ),
    .o({\hlfa/lt1_c2 ,open_n55}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt1_2  (
    .a(\hlfa/hlfa_e_difl [2]),
    .b(1'b0),
    .c(\hlfa/lt1_c2 ),
    .o({\hlfa/lt1_c3 ,open_n56}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt1_3  (
    .a(\hlfa/hlfa_e_difl [3]),
    .b(1'b0),
    .c(\hlfa/lt1_c3 ),
    .o({\hlfa/lt1_c4 ,open_n57}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt1_4  (
    .a(\hlfa/hlfa_e_difl [4]),
    .b(1'b0),
    .c(\hlfa/lt1_c4 ),
    .o({\hlfa/lt1_c5 ,open_n58}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt1_5  (
    .a(1'b0),
    .b(\hlfa/hlfa_e_difl [5]),
    .c(\hlfa/lt1_c5 ),
    .o({\hlfa/lt1_c6 ,open_n59}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \hlfa/lt1_cin  (
    .a(1'b1),
    .o({\hlfa/lt1_c0 ,open_n62}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfa/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\hlfa/lt1_c6 ),
    .o({open_n63,\hlfa/hlfa_lsft_fin }));
  reg_sr_as_w1 \hlfa/reg0_b0  (
    .clk(clk),
    .d(\hlfa/n81 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_e[0]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg0_b1  (
    .clk(clk),
    .d(\hlfa/n81 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_e[1]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg0_b2  (
    .clk(clk),
    .d(\hlfa/n81 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_e[2]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg0_b3  (
    .clk(clk),
    .d(\hlfa/n81 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_e[3]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg0_b4  (
    .clk(clk),
    .d(\hlfa/n81 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_e[4]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg0_b5  (
    .clk(clk),
    .d(\hlfa/n81 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_e[5]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b0  (
    .clk(clk),
    .d(\hlfa/n79 [0]),
    .en(1'b1),
    .reset(~\hlfa/mux24_b0_sel_is_0_o ),
    .set(1'b0),
    .q(hlfa_r[0]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b1  (
    .clk(clk),
    .d(\hlfa/n77 [1]),
    .en(1'b1),
    .reset(~\hlfa/mux24_b1_sel_is_2_o ),
    .set(1'b0),
    .q(hlfa_r[1]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b10  (
    .clk(clk),
    .d(\hlfa/n82 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[10]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b11  (
    .clk(clk),
    .d(\hlfa/n82 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[11]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b12  (
    .clk(clk),
    .d(\hlfa/n82 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[12]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b13  (
    .clk(clk),
    .d(\hlfa/n73 [13]),
    .en(1'b1),
    .reset(~\hlfa/mux24_b13_sel_is_2_o ),
    .set(1'b0),
    .q(hlfa_r[13]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b14  (
    .clk(clk),
    .d(\hlfa/n71 [14]),
    .en(1'b1),
    .reset(~\hlfa/mux24_b14_sel_is_2_o ),
    .set(1'b0),
    .q(hlfa_r[14]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b15  (
    .clk(clk),
    .d(\hlfa/n69 [15]),
    .en(1'b1),
    .reset(~\hlfa/mux24_b15_sel_is_2_o ),
    .set(1'b0),
    .q(hlfa_r[15]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b2  (
    .clk(clk),
    .d(\hlfa/n82 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[2]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b3  (
    .clk(clk),
    .d(\hlfa/n82 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[3]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b4  (
    .clk(clk),
    .d(\hlfa/n82 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[4]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b5  (
    .clk(clk),
    .d(\hlfa/n82 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[5]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b6  (
    .clk(clk),
    .d(\hlfa/n82 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[6]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b7  (
    .clk(clk),
    .d(\hlfa/n82 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[7]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b8  (
    .clk(clk),
    .d(\hlfa/n82 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[8]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg1_b9  (
    .clk(clk),
    .d(\hlfa/n82 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[9]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg2_b0  (
    .clk(clk),
    .d(ccmd[0]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/ccmd_f [0]));  // rtl/hfpu_hlfa.v(169)
  reg_sr_as_w1 \hlfa/reg2_b1  (
    .clk(clk),
    .d(ccmd[1]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/ccmd_f [1]));  // rtl/hfpu_hlfa.v(169)
  reg_sr_as_w1 \hlfa/reg2_b2  (
    .clk(clk),
    .d(ccmd[2]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/ccmd_f [2]));  // rtl/hfpu_hlfa.v(169)
  reg_sr_as_w1 \hlfa/reg2_b3  (
    .clk(clk),
    .d(ccmd[3]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/ccmd_f [3]));  // rtl/hfpu_hlfa.v(169)
  reg_sr_as_w1 \hlfa/reg2_b4  (
    .clk(clk),
    .d(ccmd[4]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/ccmd_f [4]));  // rtl/hfpu_hlfa.v(169)
  reg_sr_as_w1 \hlfa/reg3_b0  (
    .clk(clk),
    .d(abus[0]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [0]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b1  (
    .clk(clk),
    .d(abus[1]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [1]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b10  (
    .clk(clk),
    .d(abus[10]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [10]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b11  (
    .clk(clk),
    .d(abus[11]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [11]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b12  (
    .clk(clk),
    .d(abus[12]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [12]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b13  (
    .clk(clk),
    .d(abus[13]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [13]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b14  (
    .clk(clk),
    .d(abus[14]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [14]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b15  (
    .clk(clk),
    .d(abus[15]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfa_r[22]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b2  (
    .clk(clk),
    .d(abus[2]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [2]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b3  (
    .clk(clk),
    .d(abus[3]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [3]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b4  (
    .clk(clk),
    .d(abus[4]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [4]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b5  (
    .clk(clk),
    .d(abus[5]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [5]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b6  (
    .clk(clk),
    .d(abus[6]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [6]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b7  (
    .clk(clk),
    .d(abus[7]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [7]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b8  (
    .clk(clk),
    .d(abus[8]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [8]));  // rtl/hfpu_hlfa.v(139)
  reg_sr_as_w1 \hlfa/reg3_b9  (
    .clk(clk),
    .d(abus[9]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfa/hlfa_i [9]));  // rtl/hfpu_hlfa.v(139)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub0/u0  (
    .a(abus[10]),
    .b(1'b1),
    .c(\hlfa/sub0/c0 ),
    .o({\hlfa/sub0/c1 ,\hlfa/n1 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub0/u1  (
    .a(abus[11]),
    .b(1'b1),
    .c(\hlfa/sub0/c1 ),
    .o({\hlfa/sub0/c2 ,\hlfa/n1 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub0/u2  (
    .a(abus[12]),
    .b(1'b1),
    .c(\hlfa/sub0/c2 ),
    .o({\hlfa/sub0/c3 ,\hlfa/n1 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub0/u3  (
    .a(abus[13]),
    .b(1'b1),
    .c(\hlfa/sub0/c3 ),
    .o({\hlfa/sub0/c4 ,\hlfa/n1 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub0/u4  (
    .a(abus[14]),
    .b(1'b0),
    .c(\hlfa/sub0/c4 ),
    .o({\hlfa/sub0/c5 ,\hlfa/n1 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hlfa/sub0/ucin  (
    .a(1'b0),
    .o({\hlfa/sub0/c0 ,open_n66}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub0/ucout  (
    .c(\hlfa/sub0/c5 ),
    .o({open_n69,\hlfa/n1 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub2/u0  (
    .a(hlfa_e[2]),
    .b(1'b1),
    .c(\hlfa/sub2/c0 ),
    .o({\hlfa/sub2/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub2/u1  (
    .a(hlfa_e[3]),
    .b(1'b0),
    .c(\hlfa/sub2/c1 ),
    .o({\hlfa/sub2/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub2/u2  (
    .a(hlfa_e[4]),
    .b(1'b0),
    .c(\hlfa/sub2/c2 ),
    .o({\hlfa/sub2/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub2/u3  (
    .a(hlfa_e[5]),
    .b(1'b0),
    .c(\hlfa/sub2/c3 ),
    .o({open_n70,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hlfa/sub2/ucin  (
    .a(1'b0),
    .o({\hlfa/sub2/c0 ,open_n73}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub3/u0  (
    .a(hlfa_e[1]),
    .b(1'b1),
    .c(\hlfa/sub3/c0 ),
    .o({\hlfa/sub3/c1 ,n2[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub3/u1  (
    .a(hlfa_e[2]),
    .b(1'b0),
    .c(\hlfa/sub3/c1 ),
    .o({\hlfa/sub3/c2 ,n2[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub3/u2  (
    .a(hlfa_e[3]),
    .b(1'b0),
    .c(\hlfa/sub3/c2 ),
    .o({\hlfa/sub3/c3 ,n2[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub3/u3  (
    .a(hlfa_e[4]),
    .b(1'b0),
    .c(\hlfa/sub3/c3 ),
    .o({\hlfa/sub3/c4 ,n2[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub3/u4  (
    .a(hlfa_e[5]),
    .b(1'b0),
    .c(\hlfa/sub3/c4 ),
    .o({open_n74,n2[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hlfa/sub3/ucin  (
    .a(1'b0),
    .o({\hlfa/sub3/c0 ,open_n77}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub4/u0  (
    .a(hlfa_e[0]),
    .b(1'b1),
    .c(\hlfa/sub4/c0 ),
    .o({\hlfa/sub4/c1 ,\hlfa/n61 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub4/u1  (
    .a(hlfa_e[1]),
    .b(1'b0),
    .c(\hlfa/sub4/c1 ),
    .o({\hlfa/sub4/c2 ,\hlfa/n61 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub4/u2  (
    .a(hlfa_e[2]),
    .b(1'b0),
    .c(\hlfa/sub4/c2 ),
    .o({\hlfa/sub4/c3 ,\hlfa/n61 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub4/u3  (
    .a(hlfa_e[3]),
    .b(1'b0),
    .c(\hlfa/sub4/c3 ),
    .o({\hlfa/sub4/c4 ,\hlfa/n61 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub4/u4  (
    .a(hlfa_e[4]),
    .b(1'b0),
    .c(\hlfa/sub4/c4 ),
    .o({\hlfa/sub4/c5 ,\hlfa/n61 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub4/u5  (
    .a(hlfa_e[5]),
    .b(1'b0),
    .c(\hlfa/sub4/c5 ),
    .o({open_n78,\hlfa/n61 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hlfa/sub4/ucin  (
    .a(1'b0),
    .o({\hlfa/sub4/c0 ,open_n81}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub5/u0  (
    .a(\hlfa/hlfb_et [0]),
    .b(hlfa_e[0]),
    .c(\hlfa/sub5/c0 ),
    .o({\hlfa/sub5/c1 ,\hlfa/hlfa_e_dif [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub5/u1  (
    .a(\hlfa/hlfb_et [1]),
    .b(hlfa_e[1]),
    .c(\hlfa/sub5/c1 ),
    .o({\hlfa/sub5/c2 ,\hlfa/hlfa_e_dif [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub5/u2  (
    .a(\hlfa/hlfb_et [2]),
    .b(hlfa_e[2]),
    .c(\hlfa/sub5/c2 ),
    .o({\hlfa/sub5/c3 ,\hlfa/hlfa_e_dif [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub5/u3  (
    .a(\hlfa/hlfb_et [3]),
    .b(hlfa_e[3]),
    .c(\hlfa/sub5/c3 ),
    .o({\hlfa/sub5/c4 ,\hlfa/hlfa_e_dif [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub5/u4  (
    .a(\hlfa/hlfb_et [4]),
    .b(hlfa_e[4]),
    .c(\hlfa/sub5/c4 ),
    .o({\hlfa/sub5/c5 ,\hlfa/hlfa_e_dif [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub5/u5  (
    .a(\hlfa/hlfb_et [5]),
    .b(hlfa_e[5]),
    .c(\hlfa/sub5/c5 ),
    .o({open_n82,\hlfa/hlfa_e_dif [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hlfa/sub5/ucin  (
    .a(1'b0),
    .o({\hlfa/sub5/c0 ,open_n85}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub6/u0  (
    .a(hlfa_e[0]),
    .b(\hlfa/hlfb_et [0]),
    .c(\hlfa/sub6/c0 ),
    .o({\hlfa/sub6/c1 ,\hlfa/hlfa_e_difl [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub6/u1  (
    .a(hlfa_e[1]),
    .b(\hlfa/hlfb_et [1]),
    .c(\hlfa/sub6/c1 ),
    .o({\hlfa/sub6/c2 ,\hlfa/hlfa_e_difl [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub6/u2  (
    .a(hlfa_e[2]),
    .b(\hlfa/hlfb_et [2]),
    .c(\hlfa/sub6/c2 ),
    .o({\hlfa/sub6/c3 ,\hlfa/hlfa_e_difl [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub6/u3  (
    .a(hlfa_e[3]),
    .b(\hlfa/hlfb_et [3]),
    .c(\hlfa/sub6/c3 ),
    .o({\hlfa/sub6/c4 ,\hlfa/hlfa_e_difl [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub6/u4  (
    .a(hlfa_e[4]),
    .b(\hlfa/hlfb_et [4]),
    .c(\hlfa/sub6/c4 ),
    .o({\hlfa/sub6/c5 ,\hlfa/hlfa_e_difl [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfa/sub6/u5  (
    .a(hlfa_e[5]),
    .b(\hlfa/hlfb_et [5]),
    .c(\hlfa/sub6/c5 ),
    .o({open_n86,\hlfa/hlfa_e_difl [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hlfa/sub6/ucin  (
    .a(1'b0),
    .o({\hlfa/sub6/c0 ,open_n89}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add2/u0  (
    .a(hlfb_e[2]),
    .b(1'b1),
    .c(\hlfb/add2/c0 ),
    .o({\hlfb/add2/c1 ,\hlfb/n27 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add2/u1  (
    .a(hlfb_e[3]),
    .b(1'b0),
    .c(\hlfb/add2/c1 ),
    .o({\hlfb/add2/c2 ,\hlfb/n27 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add2/u2  (
    .a(hlfb_e[4]),
    .b(1'b0),
    .c(\hlfb/add2/c2 ),
    .o({\hlfb/add2/c3 ,\hlfb/n27 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add2/u3  (
    .a(hlfb_e[5]),
    .b(1'b0),
    .c(\hlfb/add2/c3 ),
    .o({open_n90,\hlfb/n27 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hlfb/add2/ucin  (
    .a(1'b0),
    .o({\hlfb/add2/c0 ,open_n93}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add3/u0  (
    .a(hlfb_e[1]),
    .b(1'b1),
    .c(\hlfb/add3/c0 ),
    .o({\hlfb/add3/c1 ,\hlfb/n36 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add3/u1  (
    .a(hlfb_e[2]),
    .b(1'b0),
    .c(\hlfb/add3/c1 ),
    .o({\hlfb/add3/c2 ,\hlfb/n36 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add3/u2  (
    .a(hlfb_e[3]),
    .b(1'b0),
    .c(\hlfb/add3/c2 ),
    .o({\hlfb/add3/c3 ,\hlfb/n36 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add3/u3  (
    .a(hlfb_e[4]),
    .b(1'b0),
    .c(\hlfb/add3/c3 ),
    .o({\hlfb/add3/c4 ,\hlfb/n36 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add3/u4  (
    .a(hlfb_e[5]),
    .b(1'b0),
    .c(\hlfb/add3/c4 ),
    .o({open_n94,\hlfb/n36 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hlfb/add3/ucin  (
    .a(1'b0),
    .o({\hlfb/add3/c0 ,open_n97}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add4/u0  (
    .a(hlfb_e[0]),
    .b(1'b1),
    .c(\hlfb/add4/c0 ),
    .o({\hlfb/add4/c1 ,\hlfb/n45 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add4/u1  (
    .a(hlfb_e[1]),
    .b(1'b0),
    .c(\hlfb/add4/c1 ),
    .o({\hlfb/add4/c2 ,\hlfb/n45 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add4/u2  (
    .a(hlfb_e[2]),
    .b(1'b0),
    .c(\hlfb/add4/c2 ),
    .o({\hlfb/add4/c3 ,\hlfb/n45 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add4/u3  (
    .a(hlfb_e[3]),
    .b(1'b0),
    .c(\hlfb/add4/c3 ),
    .o({\hlfb/add4/c4 ,\hlfb/n45 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add4/u4  (
    .a(hlfb_e[4]),
    .b(1'b0),
    .c(\hlfb/add4/c4 ),
    .o({\hlfb/add4/c5 ,\hlfb/n45 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hlfb/add4/u5  (
    .a(hlfb_e[5]),
    .b(1'b0),
    .c(\hlfb/add4/c5 ),
    .o({open_n98,\hlfb/n45 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hlfb/add4/ucin  (
    .a(1'b0),
    .o({\hlfb/add4/c0 ,open_n101}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfb/lt0_0  (
    .a(hlfc_r_hdiv[16]),
    .b(1'b0),
    .c(\hlfb/lt0_c0 ),
    .o({\hlfb/lt0_c1 ,open_n102}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfb/lt0_1  (
    .a(hlfc_r_hdiv[17]),
    .b(1'b0),
    .c(\hlfb/lt0_c1 ),
    .o({\hlfb/lt0_c2 ,open_n103}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfb/lt0_2  (
    .a(hlfc_r_hdiv[18]),
    .b(1'b0),
    .c(\hlfb/lt0_c2 ),
    .o({\hlfb/lt0_c3 ,open_n104}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfb/lt0_3  (
    .a(hlfc_r_hdiv[19]),
    .b(1'b0),
    .c(\hlfb/lt0_c3 ),
    .o({\hlfb/lt0_c4 ,open_n105}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfb/lt0_4  (
    .a(hlfc_r_hdiv[20]),
    .b(1'b0),
    .c(\hlfb/lt0_c4 ),
    .o({\hlfb/lt0_c5 ,open_n106}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfb/lt0_5  (
    .a(1'b0),
    .b(hlfc_r_hdiv[21]),
    .c(\hlfb/lt0_c5 ),
    .o({\hlfb/lt0_c6 ,open_n107}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \hlfb/lt0_cin  (
    .a(1'b1),
    .o({\hlfb/lt0_c0 ,open_n110}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \hlfb/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\hlfb/lt0_c6 ),
    .o({open_n111,\hlfb/n67 }));
  reg_sr_as_w1 \hlfb/reg0_b0  (
    .clk(clk),
    .d(\hlfb/n58 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_e[0]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg0_b1  (
    .clk(clk),
    .d(\hlfb/n58 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_e[1]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg0_b2  (
    .clk(clk),
    .d(\hlfb/n58 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_e[2]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg0_b3  (
    .clk(clk),
    .d(\hlfb/n58 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_e[3]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg0_b4  (
    .clk(clk),
    .d(\hlfb/n58 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_e[4]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg0_b5  (
    .clk(clk),
    .d(\hlfb/n58 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_e[5]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b0  (
    .clk(clk),
    .d(\hlfb/n56 [0]),
    .en(1'b1),
    .reset(~\hlfa/mux24_b0_sel_is_0_o ),
    .set(1'b0),
    .q(hlfb_r[0]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b1  (
    .clk(clk),
    .d(\hlfb/n54 [1]),
    .en(1'b1),
    .reset(~\hlfb/mux16_b1_sel_is_2_o ),
    .set(1'b0),
    .q(hlfb_r[1]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b10  (
    .clk(clk),
    .d(\hlfb/n59 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[10]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b11  (
    .clk(clk),
    .d(\hlfb/n59 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[11]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b12  (
    .clk(clk),
    .d(\hlfb/n59 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[12]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b13  (
    .clk(clk),
    .d(\hlfb/n50 [13]),
    .en(1'b1),
    .reset(~\hlfb/mux16_b13_sel_is_2_o ),
    .set(1'b0),
    .q(hlfb_r[13]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b2  (
    .clk(clk),
    .d(\hlfb/n59 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[2]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b3  (
    .clk(clk),
    .d(\hlfb/n59 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[3]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b4  (
    .clk(clk),
    .d(\hlfb/n59 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[4]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b5  (
    .clk(clk),
    .d(\hlfb/n59 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[5]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b6  (
    .clk(clk),
    .d(\hlfb/n59 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[6]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b7  (
    .clk(clk),
    .d(\hlfb/n59 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[7]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b8  (
    .clk(clk),
    .d(\hlfb/n59 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[8]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg1_b9  (
    .clk(clk),
    .d(\hlfb/n59 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(hlfb_r[9]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b0  (
    .clk(clk),
    .d(bbus[0]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [0]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b1  (
    .clk(clk),
    .d(bbus[1]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [1]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b10  (
    .clk(clk),
    .d(bbus[10]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [10]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b11  (
    .clk(clk),
    .d(bbus[11]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [11]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b12  (
    .clk(clk),
    .d(bbus[12]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [12]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b13  (
    .clk(clk),
    .d(bbus[13]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [13]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b14  (
    .clk(clk),
    .d(bbus[14]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [14]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b15  (
    .clk(clk),
    .d(bbus[15]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [15]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b2  (
    .clk(clk),
    .d(bbus[2]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [2]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b3  (
    .clk(clk),
    .d(bbus[3]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [3]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b4  (
    .clk(clk),
    .d(bbus[4]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [4]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b5  (
    .clk(clk),
    .d(bbus[5]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [5]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b6  (
    .clk(clk),
    .d(bbus[6]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [6]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b7  (
    .clk(clk),
    .d(bbus[7]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [7]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b8  (
    .clk(clk),
    .d(bbus[8]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [8]));  // rtl/hfpu_hlfb.v(84)
  reg_sr_as_w1 \hlfb/reg2_b9  (
    .clk(clk),
    .d(bbus[9]),
    .en(hctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\hlfb/hlfb_i [9]));  // rtl/hfpu_hlfb.v(84)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfb/sub0/u0  (
    .a(bbus[10]),
    .b(1'b1),
    .c(\hlfb/sub0/c0 ),
    .o({\hlfb/sub0/c1 ,\hlfb/n1 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfb/sub0/u1  (
    .a(bbus[11]),
    .b(1'b1),
    .c(\hlfb/sub0/c1 ),
    .o({\hlfb/sub0/c2 ,\hlfb/n1 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfb/sub0/u2  (
    .a(bbus[12]),
    .b(1'b1),
    .c(\hlfb/sub0/c2 ),
    .o({\hlfb/sub0/c3 ,\hlfb/n1 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfb/sub0/u3  (
    .a(bbus[13]),
    .b(1'b1),
    .c(\hlfb/sub0/c3 ),
    .o({\hlfb/sub0/c4 ,\hlfb/n1 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfb/sub0/u4  (
    .a(bbus[14]),
    .b(1'b0),
    .c(\hlfb/sub0/c4 ),
    .o({\hlfb/sub0/c5 ,\hlfb/n1 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \hlfb/sub0/ucin  (
    .a(1'b0),
    .o({\hlfb/sub0/c0 ,open_n114}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \hlfb/sub0/ucout  (
    .c(\hlfb/sub0/c5 ),
    .o({open_n117,\hlfb/n1 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hmul/add0/u0  (
    .a(hlfa_e[0]),
    .b(hlfb_e[0]),
    .c(\hmul/add0/c0 ),
    .o({\hmul/add0/c1 ,hlfc_r_hmul[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hmul/add0/u1  (
    .a(hlfa_e[1]),
    .b(hlfb_e[1]),
    .c(\hmul/add0/c1 ),
    .o({\hmul/add0/c2 ,hlfc_r_hmul[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hmul/add0/u2  (
    .a(hlfa_e[2]),
    .b(hlfb_e[2]),
    .c(\hmul/add0/c2 ),
    .o({\hmul/add0/c3 ,hlfc_r_hmul[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hmul/add0/u3  (
    .a(hlfa_e[3]),
    .b(hlfb_e[3]),
    .c(\hmul/add0/c3 ),
    .o({\hmul/add0/c4 ,hlfc_r_hmul[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hmul/add0/u4  (
    .a(hlfa_e[4]),
    .b(hlfb_e[4]),
    .c(\hmul/add0/c4 ),
    .o({\hmul/add0/c5 ,hlfc_r_hmul[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \hmul/add0/u5  (
    .a(hlfa_e[5]),
    .b(hlfb_e[5]),
    .c(\hmul/add0/c5 ),
    .o({open_n118,hlfc_r_hmul[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \hmul/add0/ucin  (
    .a(1'b0),
    .o({\hmul/add0/c0 ,open_n121}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u0  (
    .a(\norm/hlfc_e [0]),
    .b(1'b1),
    .c(\norm/add0/c0 ),
    .o({\norm/add0/c1 ,\norm/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u1  (
    .a(\norm/hlfc_e [1]),
    .b(1'b1),
    .c(\norm/add0/c1 ),
    .o({\norm/add0/c2 ,\norm/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u2  (
    .a(\norm/hlfc_e [2]),
    .b(1'b0),
    .c(\norm/add0/c2 ),
    .o({\norm/add0/c3 ,\norm/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u3  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/add0/c3 ),
    .o({\norm/add0/c4 ,\norm/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u4  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/add0/c4 ),
    .o({\norm/add0/c5 ,\norm/n4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u5  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/add0/c5 ),
    .o({open_n122,\norm/n4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add0/ucin  (
    .a(1'b0),
    .o({\norm/add0/c0 ,open_n125}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u0  (
    .a(\norm/hlfc_e [1]),
    .b(1'b1),
    .c(\norm/add1/c0 ),
    .o({\norm/add1/c1 ,\norm/n5 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u1  (
    .a(\norm/hlfc_e [2]),
    .b(1'b0),
    .c(\norm/add1/c1 ),
    .o({\norm/add1/c2 ,\norm/n5 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u2  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/add1/c2 ),
    .o({\norm/add1/c3 ,\norm/n5 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u3  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/add1/c3 ),
    .o({\norm/add1/c4 ,\norm/n5 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u4  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/add1/c4 ),
    .o({open_n126,\norm/n5 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add1/ucin  (
    .a(1'b0),
    .o({\norm/add1/c0 ,open_n129}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u0  (
    .a(\norm/hlfc_e [0]),
    .b(1'b1),
    .c(\norm/add2/c0 ),
    .o({\norm/add2/c1 ,\norm/n6 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u1  (
    .a(\norm/hlfc_e [1]),
    .b(1'b0),
    .c(\norm/add2/c1 ),
    .o({\norm/add2/c2 ,\norm/n6 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u2  (
    .a(\norm/hlfc_e [2]),
    .b(1'b0),
    .c(\norm/add2/c2 ),
    .o({\norm/add2/c3 ,\norm/n6 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u3  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/add2/c3 ),
    .o({\norm/add2/c4 ,\norm/n6 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u4  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/add2/c4 ),
    .o({\norm/add2/c5 ,\norm/n6 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u5  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/add2/c5 ),
    .o({open_n130,\norm/n6 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add2/ucin  (
    .a(1'b0),
    .o({\norm/add2/c0 ,open_n133}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u0  (
    .a(\norm/hlfc_e [0]),
    .b(1'b1),
    .c(\norm/add3/c0 ),
    .o({\norm/add3/c1 ,\norm/n42 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u1  (
    .a(\norm/hlfc_e [1]),
    .b(1'b1),
    .c(\norm/add3/c1 ),
    .o({\norm/add3/c2 ,\norm/n42 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u2  (
    .a(\norm/hlfc_e [2]),
    .b(1'b1),
    .c(\norm/add3/c2 ),
    .o({\norm/add3/c3 ,\norm/n42 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u3  (
    .a(\norm/hlfc_e [3]),
    .b(1'b1),
    .c(\norm/add3/c3 ),
    .o({\norm/add3/c4 ,\norm/n42 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u4  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/add3/c4 ),
    .o({open_n134,\norm/n42 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add3/ucin  (
    .a(1'b0),
    .o({\norm/add3/c0 ,open_n137}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u0  (
    .a(\norm/hlfc_r [16]),
    .b(1'b1),
    .c(\norm/add4/c0 ),
    .o({\norm/add4/c1 ,\norm/n43 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u1  (
    .a(\norm/hlfc_r [17]),
    .b(1'b1),
    .c(\norm/add4/c1 ),
    .o({\norm/add4/c2 ,\norm/n43 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u2  (
    .a(\norm/hlfc_r [18]),
    .b(1'b1),
    .c(\norm/add4/c2 ),
    .o({\norm/add4/c3 ,\norm/n43 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u3  (
    .a(\norm/hlfc_r [19]),
    .b(1'b1),
    .c(\norm/add4/c3 ),
    .o({\norm/add4/c4 ,\norm/n43 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u4  (
    .a(\norm/hlfc_r [20]),
    .b(1'b0),
    .c(\norm/add4/c4 ),
    .o({open_n138,\norm/n43 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add4/ucin  (
    .a(1'b0),
    .o({\norm/add4/c0 ,open_n141}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_0  (
    .a(1'b1),
    .b(\norm/hlfc_e [0]),
    .c(\norm/lt0_c0 ),
    .o({\norm/lt0_c1 ,open_n142}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_1  (
    .a(1'b1),
    .b(\norm/hlfc_e [1]),
    .c(\norm/lt0_c1 ),
    .o({\norm/lt0_c2 ,open_n143}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_2  (
    .a(1'b1),
    .b(\norm/hlfc_e [2]),
    .c(\norm/lt0_c2 ),
    .o({\norm/lt0_c3 ,open_n144}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_3  (
    .a(1'b1),
    .b(\norm/hlfc_e [3]),
    .c(\norm/lt0_c3 ),
    .o({\norm/lt0_c4 ,open_n145}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_4  (
    .a(1'b0),
    .b(\norm/hlfc_e [4]),
    .c(\norm/lt0_c4 ),
    .o({\norm/lt0_c5 ,open_n146}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_5  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/lt0_c5 ),
    .o({\norm/lt0_c6 ,open_n147}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \norm/lt0_cin  (
    .a(1'b0),
    .o({\norm/lt0_c0 ,open_n150}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\norm/lt0_c6 ),
    .o({open_n151,\norm/ovfl }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_0  (
    .a(\norm/hlfc_e [0]),
    .b(1'b0),
    .c(\norm/lt1_c0 ),
    .o({\norm/lt1_c1 ,open_n152}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_1  (
    .a(\norm/hlfc_e [1]),
    .b(1'b1),
    .c(\norm/lt1_c1 ),
    .o({\norm/lt1_c2 ,open_n153}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_2  (
    .a(\norm/hlfc_e [2]),
    .b(1'b0),
    .c(\norm/lt1_c2 ),
    .o({\norm/lt1_c3 ,open_n154}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_3  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/lt1_c3 ),
    .o({\norm/lt1_c4 ,open_n155}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_4  (
    .a(\norm/hlfc_e [4]),
    .b(1'b1),
    .c(\norm/lt1_c4 ),
    .o({\norm/lt1_c5 ,open_n156}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_5  (
    .a(1'b1),
    .b(\norm/hlfc_e [5]),
    .c(\norm/lt1_c5 ),
    .o({\norm/lt1_c6 ,open_n157}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \norm/lt1_cin  (
    .a(1'b0),
    .o({\norm/lt1_c0 ,open_n160}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\norm/lt1_c6 ),
    .o({open_n161,\norm/udfl }));
  reg_sr_as_w1 \norm/reg0_b0  (
    .clk(clk),
    .d(\norm/n34 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_e [0]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg0_b1  (
    .clk(clk),
    .d(\norm/n34 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_e [1]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg0_b2  (
    .clk(clk),
    .d(\norm/n34 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_e [2]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg0_b3  (
    .clk(clk),
    .d(\norm/n34 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_e [3]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg0_b4  (
    .clk(clk),
    .d(\norm/n34 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_e [4]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg0_b5  (
    .clk(clk),
    .d(\norm/n34 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_e [5]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b0  (
    .clk(clk),
    .d(\norm/n35 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [0]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b1  (
    .clk(clk),
    .d(\norm/n35 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [1]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b10  (
    .clk(clk),
    .d(\norm/n35 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [10]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b11  (
    .clk(clk),
    .d(\norm/n35 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [11]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b12  (
    .clk(clk),
    .d(\norm/n35 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [12]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b13  (
    .clk(clk),
    .d(\norm/n35 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [13]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b14  (
    .clk(clk),
    .d(\norm/n35 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [14]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b15  (
    .clk(clk),
    .d(\norm/n35 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [15]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b2  (
    .clk(clk),
    .d(\norm/n35 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [2]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b3  (
    .clk(clk),
    .d(\norm/n35 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [3]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b4  (
    .clk(clk),
    .d(\norm/n35 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [4]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b5  (
    .clk(clk),
    .d(\norm/n35 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [5]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b6  (
    .clk(clk),
    .d(\norm/n35 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [6]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b7  (
    .clk(clk),
    .d(\norm/n35 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [7]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b8  (
    .clk(clk),
    .d(\norm/n35 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [8]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg1_b9  (
    .clk(clk),
    .d(\norm/n35 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_f [9]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg2_b0  (
    .clk(clk),
    .d(\norm/hlfc_r [22]),
    .en(hctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_i [22]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg2_b1  (
    .clk(clk),
    .d(\norm/hlfc_r [23]),
    .en(hctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_i [23]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg2_b2  (
    .clk(clk),
    .d(\norm/hlfc_r [24]),
    .en(hctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_i [24]));  // rtl/hfpu_norm.v(131)
  reg_sr_as_w1 \norm/reg2_b3  (
    .clk(clk),
    .d(\norm/hlfc_r [25]),
    .en(hctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/hlfc_i [25]));  // rtl/hfpu_norm.v(131)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u0  (
    .a(\norm/hlfc_e [1]),
    .b(1'b1),
    .c(\norm/sub0/c0 ),
    .o({\norm/sub0/c1 ,n3[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u1  (
    .a(\norm/hlfc_e [2]),
    .b(1'b0),
    .c(\norm/sub0/c1 ),
    .o({\norm/sub0/c2 ,n3[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u2  (
    .a(\norm/hlfc_e [3]),
    .b(1'b1),
    .c(\norm/sub0/c2 ),
    .o({\norm/sub0/c3 ,n3[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u3  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/sub0/c3 ),
    .o({\norm/sub0/c4 ,n3[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u4  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/sub0/c4 ),
    .o({open_n162,n3[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub0/ucin  (
    .a(1'b0),
    .o({\norm/sub0/c0 ,open_n165}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u0  (
    .a(\norm/hlfc_e [1]),
    .b(1'b1),
    .c(\norm/sub2/c0 ),
    .o({\norm/sub2/c1 ,n5[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u1  (
    .a(\norm/hlfc_e [2]),
    .b(1'b1),
    .c(\norm/sub2/c1 ),
    .o({\norm/sub2/c2 ,n5[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u2  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/sub2/c2 ),
    .o({\norm/sub2/c3 ,n5[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u3  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/sub2/c3 ),
    .o({\norm/sub2/c4 ,n5[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u4  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/sub2/c4 ),
    .o({open_n166,n5[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub2/ucin  (
    .a(1'b0),
    .o({\norm/sub2/c0 ,open_n169}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u0  (
    .a(\norm/hlfc_e [2]),
    .b(1'b1),
    .c(\norm/sub3/c0 ),
    .o({\norm/sub3/c1 ,n6[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u1  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/sub3/c1 ),
    .o({\norm/sub3/c2 ,n6[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u2  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/sub3/c2 ),
    .o({\norm/sub3/c3 ,n6[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u3  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/sub3/c3 ),
    .o({open_n170,n6[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub3/ucin  (
    .a(1'b0),
    .o({\norm/sub3/c0 ,open_n173}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u0  (
    .a(\norm/hlfc_e [1]),
    .b(1'b1),
    .c(\norm/sub4/c0 ),
    .o({\norm/sub4/c1 ,n7[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u1  (
    .a(\norm/hlfc_e [2]),
    .b(1'b0),
    .c(\norm/sub4/c1 ),
    .o({\norm/sub4/c2 ,n7[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u2  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/sub4/c2 ),
    .o({\norm/sub4/c3 ,n7[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u3  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/sub4/c3 ),
    .o({\norm/sub4/c4 ,n7[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u4  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/sub4/c4 ),
    .o({open_n174,n7[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub4/ucin  (
    .a(1'b0),
    .o({\norm/sub4/c0 ,open_n177}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u0  (
    .a(\norm/hlfc_e [0]),
    .b(1'b1),
    .c(\norm/sub5/c0 ),
    .o({\norm/sub5/c1 ,\norm/n12 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u1  (
    .a(\norm/hlfc_e [1]),
    .b(1'b0),
    .c(\norm/sub5/c1 ),
    .o({\norm/sub5/c2 ,\norm/n12 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u2  (
    .a(\norm/hlfc_e [2]),
    .b(1'b0),
    .c(\norm/sub5/c2 ),
    .o({\norm/sub5/c3 ,\norm/n12 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u3  (
    .a(\norm/hlfc_e [3]),
    .b(1'b0),
    .c(\norm/sub5/c3 ),
    .o({\norm/sub5/c4 ,\norm/n12 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u4  (
    .a(\norm/hlfc_e [4]),
    .b(1'b0),
    .c(\norm/sub5/c4 ),
    .o({\norm/sub5/c5 ,\norm/n12 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u5  (
    .a(\norm/hlfc_e [5]),
    .b(1'b0),
    .c(\norm/sub5/c5 ),
    .o({open_n178,\norm/n12 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub5/ucin  (
    .a(1'b0),
    .o({\norm/sub5/c0 ,open_n181}));

endmodule 

