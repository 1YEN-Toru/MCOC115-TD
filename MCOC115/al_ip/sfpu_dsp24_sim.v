// Verilog netlist created by TD v5.0.27252

`timescale 1ns / 1ps
module sfpu_dsp24  // sfpu_dsp24.v(14)
  (
  a,
  b,
  p
  );

  input [23:0] a;  // sfpu_dsp24.v(18)
  input [23:0] b;  // sfpu_dsp24.v(19)
  output [47:0] p;  // sfpu_dsp24.v(16)

  wire [24:0] n0;
  wire [29:0] n1;
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
  wire inst_0_1_3;
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
  wire inst_1_0_3;
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
  wire inst_1_1_2;
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
  wire \u1/c3 ;
  wire \u1/c4 ;
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
  wire \u2/c4 ;
  wire \u2/c5 ;
  wire \u2/c6 ;
  wire \u2/c7 ;
  wire \u2/c8 ;
  wire \u2/c9 ;

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
    .SIGNEDBMUX("0"))
    inst_0_1_ (
    .a(a[17:0]),
    .b({12'b000000000000,b[23:18]}),
    .p({open_n213,open_n214,open_n215,open_n216,open_n217,open_n218,open_n219,open_n220,open_n221,open_n222,open_n223,open_n224,inst_0_1_23,inst_0_1_22,inst_0_1_21,inst_0_1_20,inst_0_1_19,inst_0_1_18,inst_0_1_17,inst_0_1_16,inst_0_1_15,inst_0_1_14,inst_0_1_13,inst_0_1_12,inst_0_1_11,inst_0_1_10,inst_0_1_9,inst_0_1_8,inst_0_1_7,inst_0_1_6,inst_0_1_5,inst_0_1_4,inst_0_1_3,inst_0_1_2,inst_0_1_1,inst_0_1_0}));
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("0"))
    inst_1_0_ (
    .a({12'b000000000000,a[23:18]}),
    .b(b[17:0]),
    .p({open_n308,open_n309,open_n310,open_n311,open_n312,open_n313,open_n314,open_n315,open_n316,open_n317,open_n318,open_n319,inst_1_0_23,inst_1_0_22,inst_1_0_21,inst_1_0_20,inst_1_0_19,inst_1_0_18,inst_1_0_17,inst_1_0_16,inst_1_0_15,inst_1_0_14,inst_1_0_13,inst_1_0_12,inst_1_0_11,inst_1_0_10,inst_1_0_9,inst_1_0_8,inst_1_0_7,inst_1_0_6,inst_1_0_5,inst_1_0_4,inst_1_0_3,inst_1_0_2,inst_1_0_1,inst_1_0_0}));
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT9X9C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("0"))
    inst_1_1_ (
    .a({open_n320,open_n321,open_n322,open_n323,open_n324,open_n325,open_n326,open_n327,open_n328,3'b000,a[23:18]}),
    .b({open_n347,open_n348,open_n349,open_n350,open_n351,open_n352,open_n353,open_n354,open_n355,3'b000,b[23:18]}),
    .p({open_n421,open_n422,open_n423,open_n424,open_n425,open_n426,open_n427,open_n428,open_n429,open_n430,open_n431,open_n432,open_n433,open_n434,open_n435,open_n436,open_n437,open_n438,open_n439,open_n440,open_n441,open_n442,open_n443,open_n444,inst_1_1_11,inst_1_1_10,inst_1_1_9,inst_1_1_8,inst_1_1_7,inst_1_1_6,inst_1_1_5,inst_1_1_4,inst_1_1_3,inst_1_1_2,inst_1_1_1,inst_1_1_0}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u0  (
    .a(inst_0_1_0),
    .b(inst_0_0_18),
    .c(\u1/c0 ),
    .o({\u1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u1  (
    .a(inst_0_1_1),
    .b(inst_0_0_19),
    .c(\u1/c1 ),
    .o({\u1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u10  (
    .a(inst_0_1_10),
    .b(inst_0_0_28),
    .c(\u1/c10 ),
    .o({\u1/c11 ,n0[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u11  (
    .a(inst_0_1_11),
    .b(inst_0_0_29),
    .c(\u1/c11 ),
    .o({\u1/c12 ,n0[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u12  (
    .a(inst_0_1_12),
    .b(inst_0_0_30),
    .c(\u1/c12 ),
    .o({\u1/c13 ,n0[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u13  (
    .a(inst_0_1_13),
    .b(inst_0_0_31),
    .c(\u1/c13 ),
    .o({\u1/c14 ,n0[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u14  (
    .a(inst_0_1_14),
    .b(inst_0_0_32),
    .c(\u1/c14 ),
    .o({\u1/c15 ,n0[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u15  (
    .a(inst_0_1_15),
    .b(inst_0_0_33),
    .c(\u1/c15 ),
    .o({\u1/c16 ,n0[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u16  (
    .a(inst_0_1_16),
    .b(inst_0_0_34),
    .c(\u1/c16 ),
    .o({\u1/c17 ,n0[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u17  (
    .a(inst_0_1_17),
    .b(inst_0_0_35),
    .c(\u1/c17 ),
    .o({\u1/c18 ,n0[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u18  (
    .a(inst_0_1_18),
    .b(inst_1_1_0),
    .c(\u1/c18 ),
    .o({\u1/c19 ,n0[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u19  (
    .a(inst_0_1_19),
    .b(inst_1_1_1),
    .c(\u1/c19 ),
    .o({\u1/c20 ,n0[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u2  (
    .a(inst_0_1_2),
    .b(inst_0_0_20),
    .c(\u1/c2 ),
    .o({\u1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u20  (
    .a(inst_0_1_20),
    .b(inst_1_1_2),
    .c(\u1/c20 ),
    .o({\u1/c21 ,n0[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u21  (
    .a(inst_0_1_21),
    .b(inst_1_1_3),
    .c(\u1/c21 ),
    .o({\u1/c22 ,n0[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u22  (
    .a(inst_0_1_22),
    .b(inst_1_1_4),
    .c(\u1/c22 ),
    .o({\u1/c23 ,n0[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u23  (
    .a(inst_0_1_23),
    .b(inst_1_1_5),
    .c(\u1/c23 ),
    .o({\u1/c24 ,n0[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u3  (
    .a(inst_0_1_3),
    .b(inst_0_0_21),
    .c(\u1/c3 ),
    .o({\u1/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u4  (
    .a(inst_0_1_4),
    .b(inst_0_0_22),
    .c(\u1/c4 ),
    .o({\u1/c5 ,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u5  (
    .a(inst_0_1_5),
    .b(inst_0_0_23),
    .c(\u1/c5 ),
    .o({\u1/c6 ,n0[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u6  (
    .a(inst_0_1_6),
    .b(inst_0_0_24),
    .c(\u1/c6 ),
    .o({\u1/c7 ,n0[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u7  (
    .a(inst_0_1_7),
    .b(inst_0_0_25),
    .c(\u1/c7 ),
    .o({\u1/c8 ,n0[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u8  (
    .a(inst_0_1_8),
    .b(inst_0_0_26),
    .c(\u1/c8 ),
    .o({\u1/c9 ,n0[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u9  (
    .a(inst_0_1_9),
    .b(inst_0_0_27),
    .c(\u1/c9 ),
    .o({\u1/c10 ,n0[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u1/ucin  (
    .a(1'b0),
    .o({\u1/c0 ,open_n447}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/ucout  (
    .c(\u1/c24 ),
    .o({open_n450,n0[24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u0  (
    .a(inst_1_0_0),
    .b(n0[0]),
    .c(\u2/c0 ),
    .o({\u2/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u1  (
    .a(inst_1_0_1),
    .b(n0[1]),
    .c(\u2/c1 ),
    .o({\u2/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u10  (
    .a(inst_1_0_10),
    .b(n0[10]),
    .c(\u2/c10 ),
    .o({\u2/c11 ,n1[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u11  (
    .a(inst_1_0_11),
    .b(n0[11]),
    .c(\u2/c11 ),
    .o({\u2/c12 ,n1[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u12  (
    .a(inst_1_0_12),
    .b(n0[12]),
    .c(\u2/c12 ),
    .o({\u2/c13 ,n1[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u13  (
    .a(inst_1_0_13),
    .b(n0[13]),
    .c(\u2/c13 ),
    .o({\u2/c14 ,n1[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u14  (
    .a(inst_1_0_14),
    .b(n0[14]),
    .c(\u2/c14 ),
    .o({\u2/c15 ,n1[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u15  (
    .a(inst_1_0_15),
    .b(n0[15]),
    .c(\u2/c15 ),
    .o({\u2/c16 ,n1[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u16  (
    .a(inst_1_0_16),
    .b(n0[16]),
    .c(\u2/c16 ),
    .o({\u2/c17 ,n1[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u17  (
    .a(inst_1_0_17),
    .b(n0[17]),
    .c(\u2/c17 ),
    .o({\u2/c18 ,n1[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u18  (
    .a(inst_1_0_18),
    .b(n0[18]),
    .c(\u2/c18 ),
    .o({\u2/c19 ,n1[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u19  (
    .a(inst_1_0_19),
    .b(n0[19]),
    .c(\u2/c19 ),
    .o({\u2/c20 ,n1[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u2  (
    .a(inst_1_0_2),
    .b(n0[2]),
    .c(\u2/c2 ),
    .o({\u2/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u20  (
    .a(inst_1_0_20),
    .b(n0[20]),
    .c(\u2/c20 ),
    .o({\u2/c21 ,n1[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u21  (
    .a(inst_1_0_21),
    .b(n0[21]),
    .c(\u2/c21 ),
    .o({\u2/c22 ,n1[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u22  (
    .a(inst_1_0_22),
    .b(n0[22]),
    .c(\u2/c22 ),
    .o({\u2/c23 ,n1[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u23  (
    .a(inst_1_0_23),
    .b(n0[23]),
    .c(\u2/c23 ),
    .o({\u2/c24 ,n1[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u24  (
    .a(inst_1_1_6),
    .b(n0[24]),
    .c(\u2/c24 ),
    .o({\u2/c25 ,n1[24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u25  (
    .a(1'b0),
    .b(inst_1_1_7),
    .c(\u2/c25 ),
    .o({\u2/c26 ,n1[25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u26  (
    .a(1'b0),
    .b(inst_1_1_8),
    .c(\u2/c26 ),
    .o({\u2/c27 ,n1[26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u27  (
    .a(1'b0),
    .b(inst_1_1_9),
    .c(\u2/c27 ),
    .o({\u2/c28 ,n1[27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u28  (
    .a(1'b0),
    .b(inst_1_1_10),
    .c(\u2/c28 ),
    .o({\u2/c29 ,n1[28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u29  (
    .a(1'b0),
    .b(inst_1_1_11),
    .c(\u2/c29 ),
    .o({open_n451,n1[29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u3  (
    .a(inst_1_0_3),
    .b(n0[3]),
    .c(\u2/c3 ),
    .o({\u2/c4 ,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u4  (
    .a(inst_1_0_4),
    .b(n0[4]),
    .c(\u2/c4 ),
    .o({\u2/c5 ,n1[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u5  (
    .a(inst_1_0_5),
    .b(n0[5]),
    .c(\u2/c5 ),
    .o({\u2/c6 ,n1[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u6  (
    .a(inst_1_0_6),
    .b(n0[6]),
    .c(\u2/c6 ),
    .o({\u2/c7 ,n1[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u7  (
    .a(inst_1_0_7),
    .b(n0[7]),
    .c(\u2/c7 ),
    .o({\u2/c8 ,n1[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u8  (
    .a(inst_1_0_8),
    .b(n0[8]),
    .c(\u2/c8 ),
    .o({\u2/c9 ,n1[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u9  (
    .a(inst_1_0_9),
    .b(n0[9]),
    .c(\u2/c9 ),
    .o({\u2/c10 ,n1[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u2/ucin  (
    .a(1'b0),
    .o({\u2/c0 ,open_n454}));

endmodule 

