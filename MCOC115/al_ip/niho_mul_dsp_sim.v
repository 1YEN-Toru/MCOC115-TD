// Verilog netlist created by TD v4.6.18154

`timescale 1ns / 1ps
module niho_mul_dsp  // al_ip/niho_mul_dsp.v(14)
  (
  a,
  b,
  p
  );

  input [32:0] a;  // al_ip/niho_mul_dsp.v(18)
  input [32:0] b;  // al_ip/niho_mul_dsp.v(19)
  output [65:0] p;  // al_ip/niho_mul_dsp.v(16)

  wire [47:0] n0;
  wire [47:0] n1;
  wire inst_0_0_0;
  wire inst_0_0_1;
  wire inst_0_0_10;
  wire inst_0_0_11;
  wire inst_0_0_12;
  wire inst_0_0_13;
  wire inst_0_0_14;
  wire inst_0_0_15;
  wire inst_0_0_16;
  wire inst_0_0_17;
  wire inst_0_0_18;
  wire inst_0_0_19;
  wire inst_0_0_2;
  wire inst_0_0_20;
  wire inst_0_0_21;
  wire inst_0_0_22;
  wire inst_0_0_23;
  wire inst_0_0_24;
  wire inst_0_0_25;
  wire inst_0_0_26;
  wire inst_0_0_27;
  wire inst_0_0_28;
  wire inst_0_0_29;
  wire inst_0_0_3;
  wire inst_0_0_30;
  wire inst_0_0_31;
  wire inst_0_0_32;
  wire inst_0_0_33;
  wire inst_0_0_34;
  wire inst_0_0_35;
  wire inst_0_0_4;
  wire inst_0_0_5;
  wire inst_0_0_6;
  wire inst_0_0_7;
  wire inst_0_0_8;
  wire inst_0_0_9;
  wire inst_0_1_0;
  wire inst_0_1_1;
  wire inst_0_1_10;
  wire inst_0_1_11;
  wire inst_0_1_12;
  wire inst_0_1_13;
  wire inst_0_1_14;
  wire inst_0_1_15;
  wire inst_0_1_16;
  wire inst_0_1_17;
  wire inst_0_1_18;
  wire inst_0_1_19;
  wire inst_0_1_2;
  wire inst_0_1_20;
  wire inst_0_1_21;
  wire inst_0_1_22;
  wire inst_0_1_23;
  wire inst_0_1_24;
  wire inst_0_1_25;
  wire inst_0_1_26;
  wire inst_0_1_27;
  wire inst_0_1_28;
  wire inst_0_1_29;
  wire inst_0_1_3;
  wire inst_0_1_30;
  wire inst_0_1_31;
  wire inst_0_1_32;
  wire inst_0_1_4;
  wire inst_0_1_5;
  wire inst_0_1_6;
  wire inst_0_1_7;
  wire inst_0_1_8;
  wire inst_0_1_9;
  wire inst_1_0_0;
  wire inst_1_0_1;
  wire inst_1_0_10;
  wire inst_1_0_11;
  wire inst_1_0_12;
  wire inst_1_0_13;
  wire inst_1_0_14;
  wire inst_1_0_15;
  wire inst_1_0_16;
  wire inst_1_0_17;
  wire inst_1_0_18;
  wire inst_1_0_19;
  wire inst_1_0_2;
  wire inst_1_0_20;
  wire inst_1_0_21;
  wire inst_1_0_22;
  wire inst_1_0_23;
  wire inst_1_0_24;
  wire inst_1_0_25;
  wire inst_1_0_26;
  wire inst_1_0_27;
  wire inst_1_0_28;
  wire inst_1_0_29;
  wire inst_1_0_3;
  wire inst_1_0_30;
  wire inst_1_0_31;
  wire inst_1_0_32;
  wire inst_1_0_4;
  wire inst_1_0_5;
  wire inst_1_0_6;
  wire inst_1_0_7;
  wire inst_1_0_8;
  wire inst_1_0_9;
  wire inst_1_1_0;
  wire inst_1_1_1;
  wire inst_1_1_10;
  wire inst_1_1_11;
  wire inst_1_1_12;
  wire inst_1_1_13;
  wire inst_1_1_14;
  wire inst_1_1_15;
  wire inst_1_1_16;
  wire inst_1_1_17;
  wire inst_1_1_18;
  wire inst_1_1_19;
  wire inst_1_1_2;
  wire inst_1_1_20;
  wire inst_1_1_21;
  wire inst_1_1_22;
  wire inst_1_1_23;
  wire inst_1_1_24;
  wire inst_1_1_25;
  wire inst_1_1_26;
  wire inst_1_1_27;
  wire inst_1_1_28;
  wire inst_1_1_29;
  wire inst_1_1_3;
  wire inst_1_1_4;
  wire inst_1_1_5;
  wire inst_1_1_6;
  wire inst_1_1_7;
  wire inst_1_1_8;
  wire inst_1_1_9;
  wire \u1/c0 ;
  wire \u1/c1 ;
  wire \u1/c10 ;
  wire \u1/c11 ;
  wire \u1/c12 ;
  wire \u1/c13 ;
  wire \u1/c14 ;
  wire \u1/c15 ;
  wire \u1/c16 ;
  wire \u1/c17 ;
  wire \u1/c18 ;
  wire \u1/c19 ;
  wire \u1/c2 ;
  wire \u1/c20 ;
  wire \u1/c21 ;
  wire \u1/c22 ;
  wire \u1/c23 ;
  wire \u1/c24 ;
  wire \u1/c25 ;
  wire \u1/c26 ;
  wire \u1/c27 ;
  wire \u1/c28 ;
  wire \u1/c29 ;
  wire \u1/c3 ;
  wire \u1/c30 ;
  wire \u1/c31 ;
  wire \u1/c32 ;
  wire \u1/c33 ;
  wire \u1/c34 ;
  wire \u1/c35 ;
  wire \u1/c36 ;
  wire \u1/c37 ;
  wire \u1/c38 ;
  wire \u1/c39 ;
  wire \u1/c4 ;
  wire \u1/c40 ;
  wire \u1/c41 ;
  wire \u1/c42 ;
  wire \u1/c43 ;
  wire \u1/c44 ;
  wire \u1/c45 ;
  wire \u1/c46 ;
  wire \u1/c47 ;
  wire \u1/c5 ;
  wire \u1/c6 ;
  wire \u1/c7 ;
  wire \u1/c8 ;
  wire \u1/c9 ;
  wire \u2/c0 ;
  wire \u2/c1 ;
  wire \u2/c10 ;
  wire \u2/c11 ;
  wire \u2/c12 ;
  wire \u2/c13 ;
  wire \u2/c14 ;
  wire \u2/c15 ;
  wire \u2/c16 ;
  wire \u2/c17 ;
  wire \u2/c18 ;
  wire \u2/c19 ;
  wire \u2/c2 ;
  wire \u2/c20 ;
  wire \u2/c21 ;
  wire \u2/c22 ;
  wire \u2/c23 ;
  wire \u2/c24 ;
  wire \u2/c25 ;
  wire \u2/c26 ;
  wire \u2/c27 ;
  wire \u2/c28 ;
  wire \u2/c29 ;
  wire \u2/c3 ;
  wire \u2/c30 ;
  wire \u2/c31 ;
  wire \u2/c32 ;
  wire \u2/c33 ;
  wire \u2/c34 ;
  wire \u2/c35 ;
  wire \u2/c36 ;
  wire \u2/c37 ;
  wire \u2/c38 ;
  wire \u2/c39 ;
  wire \u2/c4 ;
  wire \u2/c40 ;
  wire \u2/c41 ;
  wire \u2/c42 ;
  wire \u2/c43 ;
  wire \u2/c44 ;
  wire \u2/c45 ;
  wire \u2/c46 ;
  wire \u2/c47 ;
  wire \u2/c5 ;
  wire \u2/c6 ;
  wire \u2/c7 ;
  wire \u2/c8 ;
  wire \u2/c9 ;

  assign p[65] = n1[47];
  assign p[64] = n1[46];
  assign p[63] = n1[45];
  assign p[62] = n1[44];
  assign p[61] = n1[43];
  assign p[60] = n1[42];
  assign p[59] = n1[41];
  assign p[58] = n1[40];
  assign p[57] = n1[39];
  assign p[56] = n1[38];
  assign p[55] = n1[37];
  assign p[54] = n1[36];
  assign p[53] = n1[35];
  assign p[52] = n1[34];
  assign p[51] = n1[33];
  assign p[50] = n1[32];
  assign p[49] = n1[31];
  assign p[48] = n1[30];
  assign p[47] = n1[29];
  assign p[46] = n1[28];
  assign p[45] = n1[27];
  assign p[44] = n1[26];
  assign p[43] = n1[25];
  assign p[42] = n1[24];
  assign p[41] = n1[23];
  assign p[40] = n1[22];
  assign p[39] = n1[21];
  assign p[38] = n1[20];
  assign p[37] = n1[19];
  assign p[36] = n1[18];
  assign p[35] = n1[17];
  assign p[34] = n1[16];
  assign p[33] = n1[15];
  assign p[32] = n1[14];
  assign p[31] = n1[13];
  assign p[30] = n1[12];
  assign p[29] = n1[11];
  assign p[28] = n1[10];
  assign p[27] = n1[9];
  assign p[26] = n1[8];
  assign p[25] = n1[7];
  assign p[24] = n1[6];
  assign p[23] = n1[5];
  assign p[22] = n1[4];
  assign p[21] = n1[3];
  assign p[20] = n1[2];
  assign p[19] = n1[1];
  assign p[18] = n1[0];
  assign p[17] = inst_0_0_17;
  assign p[16] = inst_0_0_16;
  assign p[15] = inst_0_0_15;
  assign p[14] = inst_0_0_14;
  assign p[13] = inst_0_0_13;
  assign p[12] = inst_0_0_12;
  assign p[11] = inst_0_0_11;
  assign p[10] = inst_0_0_10;
  assign p[9] = inst_0_0_9;
  assign p[8] = inst_0_0_8;
  assign p[7] = inst_0_0_7;
  assign p[6] = inst_0_0_6;
  assign p[5] = inst_0_0_5;
  assign p[4] = inst_0_0_4;
  assign p[3] = inst_0_0_3;
  assign p[2] = inst_0_0_2;
  assign p[1] = inst_0_0_1;
  assign p[0] = inst_0_0_0;
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("0"))
    inst_0_0_ (
    .a(a[17:0]),
    .b(b[17:0]),
    .p({inst_0_0_35,inst_0_0_34,inst_0_0_33,inst_0_0_32,inst_0_0_31,inst_0_0_30,inst_0_0_29,inst_0_0_28,inst_0_0_27,inst_0_0_26,inst_0_0_25,inst_0_0_24,inst_0_0_23,inst_0_0_22,inst_0_0_21,inst_0_0_20,inst_0_0_19,inst_0_0_18,inst_0_0_17,inst_0_0_16,inst_0_0_15,inst_0_0_14,inst_0_0_13,inst_0_0_12,inst_0_0_11,inst_0_0_10,inst_0_0_9,inst_0_0_8,inst_0_0_7,inst_0_0_6,inst_0_0_5,inst_0_0_4,inst_0_0_3,inst_0_0_2,inst_0_0_1,inst_0_0_0}));
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("1"))
    inst_0_1_ (
    .a(a[17:0]),
    .b({b[32],b[32],b[32],b[32:18]}),
    .p({open_n213,open_n214,open_n215,inst_0_1_32,inst_0_1_31,inst_0_1_30,inst_0_1_29,inst_0_1_28,inst_0_1_27,inst_0_1_26,inst_0_1_25,inst_0_1_24,inst_0_1_23,inst_0_1_22,inst_0_1_21,inst_0_1_20,inst_0_1_19,inst_0_1_18,inst_0_1_17,inst_0_1_16,inst_0_1_15,inst_0_1_14,inst_0_1_13,inst_0_1_12,inst_0_1_11,inst_0_1_10,inst_0_1_9,inst_0_1_8,inst_0_1_7,inst_0_1_6,inst_0_1_5,inst_0_1_4,inst_0_1_3,inst_0_1_2,inst_0_1_1,inst_0_1_0}));
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("1"),
    .SIGNEDBMUX("0"))
    inst_1_0_ (
    .a({a[32],a[32],a[32],a[32:18]}),
    .b(b[17:0]),
    .p({open_n299,open_n300,open_n301,inst_1_0_32,inst_1_0_31,inst_1_0_30,inst_1_0_29,inst_1_0_28,inst_1_0_27,inst_1_0_26,inst_1_0_25,inst_1_0_24,inst_1_0_23,inst_1_0_22,inst_1_0_21,inst_1_0_20,inst_1_0_19,inst_1_0_18,inst_1_0_17,inst_1_0_16,inst_1_0_15,inst_1_0_14,inst_1_0_13,inst_1_0_12,inst_1_0_11,inst_1_0_10,inst_1_0_9,inst_1_0_8,inst_1_0_7,inst_1_0_6,inst_1_0_5,inst_1_0_4,inst_1_0_3,inst_1_0_2,inst_1_0_1,inst_1_0_0}));
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("1"),
    .SIGNEDBMUX("1"))
    inst_1_1_ (
    .a({a[32],a[32],a[32],a[32:18]}),
    .b({b[32],b[32],b[32],b[32:18]}),
    .p({open_n385,open_n386,open_n387,open_n388,open_n389,open_n390,inst_1_1_29,inst_1_1_28,inst_1_1_27,inst_1_1_26,inst_1_1_25,inst_1_1_24,inst_1_1_23,inst_1_1_22,inst_1_1_21,inst_1_1_20,inst_1_1_19,inst_1_1_18,inst_1_1_17,inst_1_1_16,inst_1_1_15,inst_1_1_14,inst_1_1_13,inst_1_1_12,inst_1_1_11,inst_1_1_10,inst_1_1_9,inst_1_1_8,inst_1_1_7,inst_1_1_6,inst_1_1_5,inst_1_1_4,inst_1_1_3,inst_1_1_2,inst_1_1_1,inst_1_1_0}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u0  (
    .a(inst_1_0_0),
    .b(inst_0_0_18),
    .c(\u1/c0 ),
    .o({\u1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u1  (
    .a(inst_1_0_1),
    .b(inst_0_0_19),
    .c(\u1/c1 ),
    .o({\u1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u10  (
    .a(inst_1_0_10),
    .b(inst_0_0_28),
    .c(\u1/c10 ),
    .o({\u1/c11 ,n0[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u11  (
    .a(inst_1_0_11),
    .b(inst_0_0_29),
    .c(\u1/c11 ),
    .o({\u1/c12 ,n0[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u12  (
    .a(inst_1_0_12),
    .b(inst_0_0_30),
    .c(\u1/c12 ),
    .o({\u1/c13 ,n0[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u13  (
    .a(inst_1_0_13),
    .b(inst_0_0_31),
    .c(\u1/c13 ),
    .o({\u1/c14 ,n0[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u14  (
    .a(inst_1_0_14),
    .b(inst_0_0_32),
    .c(\u1/c14 ),
    .o({\u1/c15 ,n0[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u15  (
    .a(inst_1_0_15),
    .b(inst_0_0_33),
    .c(\u1/c15 ),
    .o({\u1/c16 ,n0[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u16  (
    .a(inst_1_0_16),
    .b(inst_0_0_34),
    .c(\u1/c16 ),
    .o({\u1/c17 ,n0[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u17  (
    .a(inst_1_0_17),
    .b(inst_0_0_35),
    .c(\u1/c17 ),
    .o({\u1/c18 ,n0[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u18  (
    .a(inst_1_0_18),
    .b(inst_1_1_0),
    .c(\u1/c18 ),
    .o({\u1/c19 ,n0[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u19  (
    .a(inst_1_0_19),
    .b(inst_1_1_1),
    .c(\u1/c19 ),
    .o({\u1/c20 ,n0[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u2  (
    .a(inst_1_0_2),
    .b(inst_0_0_20),
    .c(\u1/c2 ),
    .o({\u1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u20  (
    .a(inst_1_0_20),
    .b(inst_1_1_2),
    .c(\u1/c20 ),
    .o({\u1/c21 ,n0[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u21  (
    .a(inst_1_0_21),
    .b(inst_1_1_3),
    .c(\u1/c21 ),
    .o({\u1/c22 ,n0[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u22  (
    .a(inst_1_0_22),
    .b(inst_1_1_4),
    .c(\u1/c22 ),
    .o({\u1/c23 ,n0[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u23  (
    .a(inst_1_0_23),
    .b(inst_1_1_5),
    .c(\u1/c23 ),
    .o({\u1/c24 ,n0[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u24  (
    .a(inst_1_0_24),
    .b(inst_1_1_6),
    .c(\u1/c24 ),
    .o({\u1/c25 ,n0[24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u25  (
    .a(inst_1_0_25),
    .b(inst_1_1_7),
    .c(\u1/c25 ),
    .o({\u1/c26 ,n0[25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u26  (
    .a(inst_1_0_26),
    .b(inst_1_1_8),
    .c(\u1/c26 ),
    .o({\u1/c27 ,n0[26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u27  (
    .a(inst_1_0_27),
    .b(inst_1_1_9),
    .c(\u1/c27 ),
    .o({\u1/c28 ,n0[27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u28  (
    .a(inst_1_0_28),
    .b(inst_1_1_10),
    .c(\u1/c28 ),
    .o({\u1/c29 ,n0[28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u29  (
    .a(inst_1_0_29),
    .b(inst_1_1_11),
    .c(\u1/c29 ),
    .o({\u1/c30 ,n0[29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u3  (
    .a(inst_1_0_3),
    .b(inst_0_0_21),
    .c(\u1/c3 ),
    .o({\u1/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u30  (
    .a(inst_1_0_30),
    .b(inst_1_1_12),
    .c(\u1/c30 ),
    .o({\u1/c31 ,n0[30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u31  (
    .a(inst_1_0_31),
    .b(inst_1_1_13),
    .c(\u1/c31 ),
    .o({\u1/c32 ,n0[31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u32  (
    .a(inst_1_0_32),
    .b(inst_1_1_14),
    .c(\u1/c32 ),
    .o({\u1/c33 ,n0[32]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u33  (
    .a(inst_1_0_32),
    .b(inst_1_1_15),
    .c(\u1/c33 ),
    .o({\u1/c34 ,n0[33]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u34  (
    .a(inst_1_0_32),
    .b(inst_1_1_16),
    .c(\u1/c34 ),
    .o({\u1/c35 ,n0[34]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u35  (
    .a(inst_1_0_32),
    .b(inst_1_1_17),
    .c(\u1/c35 ),
    .o({\u1/c36 ,n0[35]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u36  (
    .a(inst_1_0_32),
    .b(inst_1_1_18),
    .c(\u1/c36 ),
    .o({\u1/c37 ,n0[36]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u37  (
    .a(inst_1_0_32),
    .b(inst_1_1_19),
    .c(\u1/c37 ),
    .o({\u1/c38 ,n0[37]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u38  (
    .a(inst_1_0_32),
    .b(inst_1_1_20),
    .c(\u1/c38 ),
    .o({\u1/c39 ,n0[38]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u39  (
    .a(inst_1_0_32),
    .b(inst_1_1_21),
    .c(\u1/c39 ),
    .o({\u1/c40 ,n0[39]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u4  (
    .a(inst_1_0_4),
    .b(inst_0_0_22),
    .c(\u1/c4 ),
    .o({\u1/c5 ,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u40  (
    .a(inst_1_0_32),
    .b(inst_1_1_22),
    .c(\u1/c40 ),
    .o({\u1/c41 ,n0[40]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u41  (
    .a(inst_1_0_32),
    .b(inst_1_1_23),
    .c(\u1/c41 ),
    .o({\u1/c42 ,n0[41]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u42  (
    .a(inst_1_0_32),
    .b(inst_1_1_24),
    .c(\u1/c42 ),
    .o({\u1/c43 ,n0[42]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u43  (
    .a(inst_1_0_32),
    .b(inst_1_1_25),
    .c(\u1/c43 ),
    .o({\u1/c44 ,n0[43]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u44  (
    .a(inst_1_0_32),
    .b(inst_1_1_26),
    .c(\u1/c44 ),
    .o({\u1/c45 ,n0[44]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u45  (
    .a(inst_1_0_32),
    .b(inst_1_1_27),
    .c(\u1/c45 ),
    .o({\u1/c46 ,n0[45]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u46  (
    .a(inst_1_0_32),
    .b(inst_1_1_28),
    .c(\u1/c46 ),
    .o({\u1/c47 ,n0[46]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u47  (
    .a(inst_1_0_32),
    .b(inst_1_1_29),
    .c(\u1/c47 ),
    .o({open_n391,n0[47]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u5  (
    .a(inst_1_0_5),
    .b(inst_0_0_23),
    .c(\u1/c5 ),
    .o({\u1/c6 ,n0[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u6  (
    .a(inst_1_0_6),
    .b(inst_0_0_24),
    .c(\u1/c6 ),
    .o({\u1/c7 ,n0[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u7  (
    .a(inst_1_0_7),
    .b(inst_0_0_25),
    .c(\u1/c7 ),
    .o({\u1/c8 ,n0[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u8  (
    .a(inst_1_0_8),
    .b(inst_0_0_26),
    .c(\u1/c8 ),
    .o({\u1/c9 ,n0[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u9  (
    .a(inst_1_0_9),
    .b(inst_0_0_27),
    .c(\u1/c9 ),
    .o({\u1/c10 ,n0[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u1/ucin  (
    .a(1'b0),
    .o({\u1/c0 ,open_n394}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u0  (
    .a(inst_0_1_0),
    .b(n0[0]),
    .c(\u2/c0 ),
    .o({\u2/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u1  (
    .a(inst_0_1_1),
    .b(n0[1]),
    .c(\u2/c1 ),
    .o({\u2/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u10  (
    .a(inst_0_1_10),
    .b(n0[10]),
    .c(\u2/c10 ),
    .o({\u2/c11 ,n1[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u11  (
    .a(inst_0_1_11),
    .b(n0[11]),
    .c(\u2/c11 ),
    .o({\u2/c12 ,n1[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u12  (
    .a(inst_0_1_12),
    .b(n0[12]),
    .c(\u2/c12 ),
    .o({\u2/c13 ,n1[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u13  (
    .a(inst_0_1_13),
    .b(n0[13]),
    .c(\u2/c13 ),
    .o({\u2/c14 ,n1[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u14  (
    .a(inst_0_1_14),
    .b(n0[14]),
    .c(\u2/c14 ),
    .o({\u2/c15 ,n1[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u15  (
    .a(inst_0_1_15),
    .b(n0[15]),
    .c(\u2/c15 ),
    .o({\u2/c16 ,n1[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u16  (
    .a(inst_0_1_16),
    .b(n0[16]),
    .c(\u2/c16 ),
    .o({\u2/c17 ,n1[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u17  (
    .a(inst_0_1_17),
    .b(n0[17]),
    .c(\u2/c17 ),
    .o({\u2/c18 ,n1[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u18  (
    .a(inst_0_1_18),
    .b(n0[18]),
    .c(\u2/c18 ),
    .o({\u2/c19 ,n1[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u19  (
    .a(inst_0_1_19),
    .b(n0[19]),
    .c(\u2/c19 ),
    .o({\u2/c20 ,n1[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u2  (
    .a(inst_0_1_2),
    .b(n0[2]),
    .c(\u2/c2 ),
    .o({\u2/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u20  (
    .a(inst_0_1_20),
    .b(n0[20]),
    .c(\u2/c20 ),
    .o({\u2/c21 ,n1[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u21  (
    .a(inst_0_1_21),
    .b(n0[21]),
    .c(\u2/c21 ),
    .o({\u2/c22 ,n1[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u22  (
    .a(inst_0_1_22),
    .b(n0[22]),
    .c(\u2/c22 ),
    .o({\u2/c23 ,n1[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u23  (
    .a(inst_0_1_23),
    .b(n0[23]),
    .c(\u2/c23 ),
    .o({\u2/c24 ,n1[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u24  (
    .a(inst_0_1_24),
    .b(n0[24]),
    .c(\u2/c24 ),
    .o({\u2/c25 ,n1[24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u25  (
    .a(inst_0_1_25),
    .b(n0[25]),
    .c(\u2/c25 ),
    .o({\u2/c26 ,n1[25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u26  (
    .a(inst_0_1_26),
    .b(n0[26]),
    .c(\u2/c26 ),
    .o({\u2/c27 ,n1[26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u27  (
    .a(inst_0_1_27),
    .b(n0[27]),
    .c(\u2/c27 ),
    .o({\u2/c28 ,n1[27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u28  (
    .a(inst_0_1_28),
    .b(n0[28]),
    .c(\u2/c28 ),
    .o({\u2/c29 ,n1[28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u29  (
    .a(inst_0_1_29),
    .b(n0[29]),
    .c(\u2/c29 ),
    .o({\u2/c30 ,n1[29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u3  (
    .a(inst_0_1_3),
    .b(n0[3]),
    .c(\u2/c3 ),
    .o({\u2/c4 ,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u30  (
    .a(inst_0_1_30),
    .b(n0[30]),
    .c(\u2/c30 ),
    .o({\u2/c31 ,n1[30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u31  (
    .a(inst_0_1_31),
    .b(n0[31]),
    .c(\u2/c31 ),
    .o({\u2/c32 ,n1[31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u32  (
    .a(inst_0_1_32),
    .b(n0[32]),
    .c(\u2/c32 ),
    .o({\u2/c33 ,n1[32]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u33  (
    .a(inst_0_1_32),
    .b(n0[33]),
    .c(\u2/c33 ),
    .o({\u2/c34 ,n1[33]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u34  (
    .a(inst_0_1_32),
    .b(n0[34]),
    .c(\u2/c34 ),
    .o({\u2/c35 ,n1[34]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u35  (
    .a(inst_0_1_32),
    .b(n0[35]),
    .c(\u2/c35 ),
    .o({\u2/c36 ,n1[35]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u36  (
    .a(inst_0_1_32),
    .b(n0[36]),
    .c(\u2/c36 ),
    .o({\u2/c37 ,n1[36]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u37  (
    .a(inst_0_1_32),
    .b(n0[37]),
    .c(\u2/c37 ),
    .o({\u2/c38 ,n1[37]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u38  (
    .a(inst_0_1_32),
    .b(n0[38]),
    .c(\u2/c38 ),
    .o({\u2/c39 ,n1[38]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u39  (
    .a(inst_0_1_32),
    .b(n0[39]),
    .c(\u2/c39 ),
    .o({\u2/c40 ,n1[39]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u4  (
    .a(inst_0_1_4),
    .b(n0[4]),
    .c(\u2/c4 ),
    .o({\u2/c5 ,n1[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u40  (
    .a(inst_0_1_32),
    .b(n0[40]),
    .c(\u2/c40 ),
    .o({\u2/c41 ,n1[40]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u41  (
    .a(inst_0_1_32),
    .b(n0[41]),
    .c(\u2/c41 ),
    .o({\u2/c42 ,n1[41]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u42  (
    .a(inst_0_1_32),
    .b(n0[42]),
    .c(\u2/c42 ),
    .o({\u2/c43 ,n1[42]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u43  (
    .a(inst_0_1_32),
    .b(n0[43]),
    .c(\u2/c43 ),
    .o({\u2/c44 ,n1[43]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u44  (
    .a(inst_0_1_32),
    .b(n0[44]),
    .c(\u2/c44 ),
    .o({\u2/c45 ,n1[44]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u45  (
    .a(inst_0_1_32),
    .b(n0[45]),
    .c(\u2/c45 ),
    .o({\u2/c46 ,n1[45]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u46  (
    .a(inst_0_1_32),
    .b(n0[46]),
    .c(\u2/c46 ),
    .o({\u2/c47 ,n1[46]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u47  (
    .a(inst_0_1_32),
    .b(n0[47]),
    .c(\u2/c47 ),
    .o({open_n395,n1[47]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u5  (
    .a(inst_0_1_5),
    .b(n0[5]),
    .c(\u2/c5 ),
    .o({\u2/c6 ,n1[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u6  (
    .a(inst_0_1_6),
    .b(n0[6]),
    .c(\u2/c6 ),
    .o({\u2/c7 ,n1[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u7  (
    .a(inst_0_1_7),
    .b(n0[7]),
    .c(\u2/c7 ),
    .o({\u2/c8 ,n1[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u8  (
    .a(inst_0_1_8),
    .b(n0[8]),
    .c(\u2/c8 ),
    .o({\u2/c9 ,n1[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u9  (
    .a(inst_0_1_9),
    .b(n0[9]),
    .c(\u2/c9 ),
    .o({\u2/c10 ,n1[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u2/ucin  (
    .a(1'b0),
    .o({\u2/c0 ,open_n398}));

endmodule 

