
`timescale 1ns / 1ps
module rtc400_sub  // rtl/rtc400_sub.v(1)
  (
  clk32k,
  rctl_wrt_req,
  rsys_reg,
  rsub_reg,
  rsub_wrt_ack
  );
//
//	Real Time Clock Unit (sub(32kHz) clock domain)
//		(c) 2022	1YEN Toru
//
//
//	2022/10/08	ver.1.00
//

  input clk32k;  // rtl/rtc400_sub.v(9)
  input rctl_wrt_req;  // rtl/rtc400_sub.v(10)
  input [79:0] rsys_reg;  // rtl/rtc400_sub.v(11)
  output [79:0] rsub_reg;  // rtl/rtc400_sub.v(13)
  output rsub_wrt_ack;  // rtl/rtc400_sub.v(12)

  wire [4:0] n0;
  wire [2:0] \rclk/rctl_wrt_req_s ;  // rtl/rtc400_sub.v(57)
  wire [2:0] \rclk/rfsm/stat ;  // rtl/rtc_sub_fsm.v(24)
  wire [5:0] \rcnt/bcd_dinm ;  // rtl/rtc400_sub.v(120)
  wire [8:0] \rcnt/bin_yea ;  // rtl/rtc400_sub.v(220)
  wire [8:0] \rcnt/bin_yea3 ;  // rtl/rtc400_sub.v(218)
  wire [14:0] \rcnt/n0 ;
  wire [14:0] \rcnt/n1 ;
  wire [4:0] \rcnt/n40 ;
  wire [5:0] \rcnt/n48 ;
  wire [6:0] \rcnt/n68 ;
  wire [6:0] \rcnt/n80 ;
  wire [4:0] \rcnt/n82 ;
  wire [5:0] \rcnt/n83 ;
  wire [6:0] \rcnt/n86 ;
  wire [6:0] \rcnt/n87 ;
  wire [9:0] \rcnt/n88 ;
  wire [4:0] \rcnt/n89 ;
  wire [5:0] \rcnt/n90 ;
  wire [2:0] \rcnt/n91 ;
  wire [5:0] \rcnt/n92 ;
  wire [6:0] \rcnt/n93 ;
  wire [6:0] \rcnt/n94 ;
  wire [3:0] \rcnt/nxt_day0 ;  // rtl/rtc400_sub.v(149)
  wire [3:0] \rcnt/nxt_hou0 ;  // rtl/rtc400_sub.v(145)
  wire [3:0] \rcnt/nxt_min0 ;  // rtl/rtc400_sub.v(143)
  wire [3:0] \rcnt/nxt_mon0 ;  // rtl/rtc400_sub.v(152)
  wire [3:0] \rcnt/nxt_sec0 ;  // rtl/rtc400_sub.v(141)
  wire [3:0] \rcnt/nxt_yea0 ;  // rtl/rtc400_sub.v(155)
  wire [3:0] \rcnt/nxt_yea1 ;  // rtl/rtc400_sub.v(157)
  wire [14:0] \rcnt/rcnt_psc ;  // rtl/rtc400_sub.v(98)
  wire _al_u166_o;
  wire _al_u167_o;
  wire _al_u168_o;
  wire _al_u172_o;
  wire _al_u175_o;
  wire _al_u178_o;
  wire _al_u181_o;
  wire _al_u185_o;
  wire _al_u186_o;
  wire _al_u187_o;
  wire _al_u193_o;
  wire _al_u195_o;
  wire _al_u201_o;
  wire _al_u207_o;
  wire _al_u210_o;
  wire _al_u212_o;
  wire _al_u214_o;
  wire _al_u218_o;
  wire _al_u241_o;
  wire _al_u243_o;
  wire _al_u245_o;
  wire _al_u247_o;
  wire _al_u248_o;
  wire _al_u249_o;
  wire _al_u250_o;
  wire _al_u251_o;
  wire _al_u252_o;
  wire \rclk/rfsm/sel0_b0_sel_o ;  // rtl/rtc_sub_fsm.v(38)
  wire \rcnt/add0/c0 ;
  wire \rcnt/add0/c1 ;
  wire \rcnt/add0/c10 ;
  wire \rcnt/add0/c11 ;
  wire \rcnt/add0/c12 ;
  wire \rcnt/add0/c13 ;
  wire \rcnt/add0/c14 ;
  wire \rcnt/add0/c2 ;
  wire \rcnt/add0/c3 ;
  wire \rcnt/add0/c4 ;
  wire \rcnt/add0/c5 ;
  wire \rcnt/add0/c6 ;
  wire \rcnt/add0/c7 ;
  wire \rcnt/add0/c8 ;
  wire \rcnt/add0/c9 ;
  wire \rcnt/add1/c0 ;
  wire \rcnt/add1/c1 ;
  wire \rcnt/add1/c2 ;
  wire \rcnt/add1/c3 ;
  wire \rcnt/add10/c0 ;
  wire \rcnt/add10/c1 ;
  wire \rcnt/add10/c2 ;
  wire \rcnt/add10/c3 ;
  wire \rcnt/add12/c0 ;
  wire \rcnt/add12/c1 ;
  wire \rcnt/add12/c2 ;
  wire \rcnt/add12/c3 ;
  wire \rcnt/add13/c0 ;
  wire \rcnt/add13/c1 ;
  wire \rcnt/add13/c2 ;
  wire \rcnt/add13/c3 ;
  wire \rcnt/add14/net_cout0_lutinv ;
  wire \rcnt/add15_rcnt/add16/c0 ;
  wire \rcnt/add15_rcnt/add16/c1 ;
  wire \rcnt/add15_rcnt/add16/c2 ;
  wire \rcnt/add15_rcnt/add16/c3 ;
  wire \rcnt/add15_rcnt/add16/c4 ;
  wire \rcnt/add2/net_cout0_lutinv ;
  wire \rcnt/add3/c0 ;
  wire \rcnt/add3/c1 ;
  wire \rcnt/add3/c2 ;
  wire \rcnt/add3/c3 ;
  wire \rcnt/add4/net_cout0_lutinv ;
  wire \rcnt/add5/c0 ;
  wire \rcnt/add5/c1 ;
  wire \rcnt/add5/c2 ;
  wire \rcnt/add5/c3 ;
  wire \rcnt/add6/net_cout0_lutinv ;
  wire \rcnt/add8/c0 ;
  wire \rcnt/add8/c1 ;
  wire \rcnt/add8/c2 ;
  wire \rcnt/add8/c3 ;
  wire \rcnt/mux12_b0_sel_is_2_o ;
  wire \rcnt/mux8_b1_sel_is_2_o ;
  wire \rcnt/n20_lutinv ;
  wire \rcnt/n21 ;
  wire \rcnt/n22_lutinv ;
  wire \rcnt/n23 ;
  wire \rcnt/n24_lutinv ;
  wire \rcnt/n25 ;
  wire \rcnt/n27_lutinv ;
  wire \rcnt/n28 ;
  wire \rcnt/n30 ;
  wire \rcnt/n31 ;
  wire \rcnt/n32_lutinv ;
  wire \rcnt/rcnt_psc_ovf_lutinv ;  // rtl/rtc400_sub.v(116)
  wire rsub_lat_reg;  // rtl/rtc400_sub.v(30)
  wire \u1/c0 ;
  wire \u1/c1 ;
  wire \u1/c2 ;
  wire \u1/c3 ;
  wire \u1/c4 ;
  wire \u2/c0 ;
  wire \u2/c1 ;
  wire \u2/c2 ;
  wire \u2/c3 ;
  wire \u2/c4 ;
  wire \u2/c5 ;
  wire \u2/c6 ;
  wire \u2/c7 ;

  assign rsub_reg[78] = 1'b0;
  assign rsub_reg[77] = 1'b0;
  assign rsub_reg[76] = 1'b0;
  assign rsub_reg[75] = 1'b0;
  assign rsub_reg[74] = 1'b0;
  assign rsub_reg[63] = 1'b0;
  assign rsub_reg[62] = 1'b0;
  assign rsub_reg[61] = 1'b0;
  assign rsub_reg[55] = 1'b0;
  assign rsub_reg[54] = 1'b0;
  assign rsub_reg[47] = 1'b0;
  assign rsub_reg[46] = 1'b0;
  assign rsub_reg[39] = 1'b0;
  assign rsub_reg[31] = 1'b0;
  assign rsub_reg[15] = 1'b0;
  assign rsub_reg[14] = 1'b0;
  assign rsub_reg[13] = 1'b0;
  assign rsub_reg[12] = 1'b0;
  assign rsub_reg[11] = 1'b0;
  assign rsub_reg[10] = 1'b0;
  assign rsub_reg[9] = 1'b0;
  assign rsub_reg[8] = 1'b0;
  assign rsub_reg[7] = 1'b0;
  assign rsub_reg[6] = 1'b0;
  assign rsub_reg[5] = 1'b0;
  assign rsub_reg[4] = 1'b0;
  assign rsub_reg[3] = 1'b0;
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u153 (
    .a(\rclk/rfsm/sel0_b0_sel_o ),
    .b(\rclk/rfsm/stat [0]),
    .o(rsub_lat_reg));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u154 (
    .a(\rclk/rfsm/sel0_b0_sel_o ),
    .b(\rclk/rfsm/stat [0]),
    .o(rsub_wrt_ack));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u155 (
    .a(\rcnt/n0 [9]),
    .b(rsub_lat_reg),
    .c(rsys_reg[18]),
    .o(\rcnt/n1 [9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u156 (
    .a(\rcnt/n0 [8]),
    .b(rsub_lat_reg),
    .c(rsys_reg[17]),
    .o(\rcnt/n1 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u157 (
    .a(\rcnt/n0 [7]),
    .b(rsub_lat_reg),
    .c(rsys_reg[16]),
    .o(\rcnt/n1 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u158 (
    .a(\rcnt/n0 [14]),
    .b(rsub_lat_reg),
    .c(rsys_reg[23]),
    .o(\rcnt/n1 [14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u159 (
    .a(\rcnt/n0 [13]),
    .b(rsub_lat_reg),
    .c(rsys_reg[22]),
    .o(\rcnt/n1 [13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u160 (
    .a(\rcnt/n0 [12]),
    .b(rsub_lat_reg),
    .c(rsys_reg[21]),
    .o(\rcnt/n1 [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u161 (
    .a(\rcnt/n0 [11]),
    .b(rsub_lat_reg),
    .c(rsys_reg[20]),
    .o(\rcnt/n1 [11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u162 (
    .a(\rcnt/n0 [10]),
    .b(rsub_lat_reg),
    .c(rsys_reg[19]),
    .o(\rcnt/n1 [10]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u163 (
    .a(\rcnt/nxt_yea0 [3]),
    .b(\rcnt/nxt_yea0 [2]),
    .c(\rcnt/nxt_yea0 [1]),
    .d(\rcnt/nxt_yea0 [0]),
    .o(\rcnt/n31 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u164 (
    .a(\rcnt/nxt_yea1 [3]),
    .b(\rcnt/nxt_yea1 [2]),
    .c(\rcnt/nxt_yea1 [1]),
    .d(\rcnt/nxt_yea1 [0]),
    .o(\rcnt/n32_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u165 (
    .a(\rcnt/n32_lutinv ),
    .b(rsub_reg[72]),
    .o(\rcnt/add14/net_cout0_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u166 (
    .a(\rcnt/rcnt_psc [0]),
    .b(\rcnt/rcnt_psc [1]),
    .c(rsub_reg[19]),
    .d(rsub_reg[20]),
    .o(_al_u166_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u167 (
    .a(_al_u166_o),
    .b(rsub_reg[21]),
    .c(rsub_reg[22]),
    .d(rsub_reg[23]),
    .e(\rcnt/rcnt_psc [2]),
    .o(_al_u167_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u168 (
    .a(\rcnt/rcnt_psc [3]),
    .b(\rcnt/rcnt_psc [4]),
    .c(\rcnt/rcnt_psc [5]),
    .d(\rcnt/rcnt_psc [6]),
    .o(_al_u168_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u169 (
    .a(_al_u167_o),
    .b(_al_u168_o),
    .c(rsub_reg[16]),
    .d(rsub_reg[17]),
    .e(rsub_reg[18]),
    .o(\rcnt/rcnt_psc_ovf_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h77b84788))
    _al_u170 (
    .a(\rcnt/add14/net_cout0_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[73]),
    .e(rsys_reg[73]),
    .o(\rcnt/n88 [9]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h77b84788))
    _al_u171 (
    .a(\rcnt/n32_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[72]),
    .e(rsys_reg[72]),
    .o(\rcnt/n88 [8]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u172 (
    .a(rsub_lat_reg),
    .b(rsub_reg[71]),
    .c(rsys_reg[71]),
    .o(_al_u172_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~((B*~A))*~(C)+~D*(B*~A)*~(C)+~(~D)*(B*~A)*C+~D*(B*~A)*C)"),
    .INIT(16'h404f))
    _al_u173 (
    .a(\rcnt/n32_lutinv ),
    .b(\rcnt/nxt_yea1 [3]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u172_o),
    .o(\rcnt/n88 [7]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u174 (
    .a(\rcnt/nxt_yea1 [2]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[70]),
    .e(rsys_reg[70]),
    .o(\rcnt/n88 [6]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u175 (
    .a(rsub_lat_reg),
    .b(rsub_reg[69]),
    .c(rsys_reg[69]),
    .o(_al_u175_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~((B*~A))*~(C)+~D*(B*~A)*~(C)+~(~D)*(B*~A)*C+~D*(B*~A)*C)"),
    .INIT(16'h404f))
    _al_u176 (
    .a(\rcnt/n32_lutinv ),
    .b(\rcnt/nxt_yea1 [1]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u175_o),
    .o(\rcnt/n88 [5]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u177 (
    .a(\rcnt/nxt_yea1 [0]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[68]),
    .e(rsys_reg[68]),
    .o(\rcnt/n88 [4]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u178 (
    .a(rsub_lat_reg),
    .b(rsub_reg[67]),
    .c(rsys_reg[67]),
    .o(_al_u178_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~((B*~A))*~(C)+~D*(B*~A)*~(C)+~(~D)*(B*~A)*C+~D*(B*~A)*C)"),
    .INIT(16'h404f))
    _al_u179 (
    .a(\rcnt/n31 ),
    .b(\rcnt/nxt_yea0 [3]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u178_o),
    .o(\rcnt/n88 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u180 (
    .a(\rcnt/nxt_yea0 [2]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[66]),
    .e(rsys_reg[66]),
    .o(\rcnt/n88 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u181 (
    .a(rsub_lat_reg),
    .b(rsub_reg[65]),
    .c(rsys_reg[65]),
    .o(_al_u181_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~((B*~A))*~(C)+~D*(B*~A)*~(C)+~(~D)*(B*~A)*C+~D*(B*~A)*C)"),
    .INIT(16'h404f))
    _al_u182 (
    .a(\rcnt/n31 ),
    .b(\rcnt/nxt_yea0 [1]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u181_o),
    .o(\rcnt/n88 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u183 (
    .a(\rcnt/nxt_yea0 [0]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[64]),
    .e(rsys_reg[64]),
    .o(\rcnt/n88 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*~A)"),
    .INIT(32'h10000000))
    _al_u184 (
    .a(\rcnt/nxt_mon0 [3]),
    .b(\rcnt/nxt_mon0 [2]),
    .c(\rcnt/nxt_mon0 [1]),
    .d(\rcnt/nxt_mon0 [0]),
    .e(rsub_reg[60]),
    .o(\rcnt/n30 ));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hfbdf))
    _al_u185 (
    .a(\rcnt/bin_yea [7]),
    .b(\rcnt/bin_yea [5]),
    .c(\rcnt/bin_yea [3]),
    .d(\rcnt/bin_yea [2]),
    .o(_al_u185_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u186 (
    .a(\rcnt/bin_yea [7]),
    .b(\rcnt/bin_yea [5]),
    .c(\rcnt/bin_yea [3]),
    .d(\rcnt/bin_yea [2]),
    .o(_al_u186_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*(~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+~(A)*B*~(C)*D))"),
    .INIT(32'h000005c0))
    _al_u187 (
    .a(_al_u185_o),
    .b(_al_u186_o),
    .c(\rcnt/bin_yea [8]),
    .d(\rcnt/bin_yea [6]),
    .e(\rcnt/bin_yea [4]),
    .o(_al_u187_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u188 (
    .a(_al_u187_o),
    .b(\rcnt/bin_yea [1]),
    .c(rsub_reg[64]),
    .o(rsub_reg[79]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u189 (
    .a(\rcnt/nxt_sec0 [3]),
    .b(\rcnt/nxt_sec0 [2]),
    .c(\rcnt/nxt_sec0 [1]),
    .d(\rcnt/nxt_sec0 [0]),
    .o(\rcnt/n20_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*(A*B*~(C)+~(A)*~(B)*C))"),
    .INIT(16'h1800))
    _al_u190 (
    .a(\rcnt/n20_lutinv ),
    .b(rsub_reg[28]),
    .c(rsub_reg[29]),
    .d(rsub_reg[30]),
    .o(\rcnt/n21 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u191 (
    .a(\rcnt/nxt_min0 [3]),
    .b(\rcnt/nxt_min0 [2]),
    .c(\rcnt/nxt_min0 [1]),
    .d(\rcnt/nxt_min0 [0]),
    .o(\rcnt/n22_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*(A*B*~(C)+~(A)*~(B)*C))"),
    .INIT(16'h1800))
    _al_u192 (
    .a(\rcnt/n22_lutinv ),
    .b(rsub_reg[36]),
    .c(rsub_reg[37]),
    .d(rsub_reg[38]),
    .o(\rcnt/n23 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*~A)"),
    .INIT(32'h00000004))
    _al_u193 (
    .a(\rcnt/nxt_hou0 [3]),
    .b(\rcnt/nxt_hou0 [2]),
    .c(\rcnt/nxt_hou0 [1]),
    .d(\rcnt/nxt_hou0 [0]),
    .e(rsub_reg[44]),
    .o(_al_u193_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u194 (
    .a(_al_u193_o),
    .b(rsub_reg[45]),
    .o(\rcnt/n25 ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~((C*~B))*~(D)*~(E)+A*~((C*~B))*~(D)*~(E)+~(A)*(C*~B)*~(D)*~(E)+~(A)*~((C*~B))*D*~(E)+A*~((C*~B))*D*~(E)+~(A)*(C*~B)*D*~(E)+A*(C*~B)*D*~(E)+A*(C*~B)*~(D)*E+~(A)*(C*~B)*D*E)"),
    .INIT(32'h1020ffdf))
    _al_u195 (
    .a(\rcnt/nxt_mon0 [3]),
    .b(\rcnt/nxt_mon0 [2]),
    .c(\rcnt/nxt_mon0 [1]),
    .d(\rcnt/nxt_mon0 [0]),
    .e(rsub_reg[60]),
    .o(_al_u195_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u196 (
    .a(_al_u195_o),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[60]),
    .e(rsys_reg[60]),
    .o(\rcnt/n89 [4]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u197 (
    .a(\rcnt/nxt_mon0 [0]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[56]),
    .e(rsys_reg[56]),
    .o(\rcnt/n89 [0]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*~D*C*~B))"),
    .INIT(32'haaaaaa8a))
    _al_u198 (
    .a(\rcnt/nxt_mon0 [3]),
    .b(\rcnt/nxt_mon0 [2]),
    .c(\rcnt/nxt_mon0 [1]),
    .d(\rcnt/nxt_mon0 [0]),
    .e(rsub_reg[60]),
    .o(\rcnt/n40 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u199 (
    .a(\rcnt/n40 [3]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[59]),
    .e(rsys_reg[59]),
    .o(\rcnt/n89 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u200 (
    .a(\rcnt/nxt_mon0 [2]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[58]),
    .e(rsys_reg[58]),
    .o(\rcnt/n89 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(C)*~(D)+~(A)*C*D))"),
    .INIT(16'h1002))
    _al_u201 (
    .a(\rcnt/nxt_mon0 [3]),
    .b(\rcnt/nxt_mon0 [2]),
    .c(\rcnt/nxt_mon0 [0]),
    .d(rsub_reg[60]),
    .o(_al_u201_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u202 (
    .a(rsub_lat_reg),
    .b(rsub_reg[57]),
    .c(rsys_reg[57]),
    .o(\rcnt/n82 [1]));
  AL_MAP_LUT4 #(
    .EQN("(D*~((B*~A))*~(C)+D*(B*~A)*~(C)+~(D)*(B*~A)*C+D*(B*~A)*C)"),
    .INIT(16'h4f40))
    _al_u203 (
    .a(_al_u201_o),
    .b(\rcnt/nxt_mon0 [1]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(\rcnt/n82 [1]),
    .o(\rcnt/n89 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u204 (
    .a(\rcnt/nxt_hou0 [3]),
    .b(\rcnt/nxt_hou0 [2]),
    .c(\rcnt/nxt_hou0 [1]),
    .d(\rcnt/nxt_hou0 [0]),
    .o(\rcnt/n24_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h77b84788))
    _al_u205 (
    .a(\rcnt/n24_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[44]),
    .e(rsys_reg[44]),
    .o(\rcnt/n92 [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u206 (
    .a(\rcnt/n24_lutinv ),
    .b(rsub_reg[44]),
    .o(\rcnt/add6/net_cout0_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u207 (
    .a(rsub_lat_reg),
    .b(rsub_reg[45]),
    .c(rsys_reg[45]),
    .o(_al_u207_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~((~B*(E@A)))*~(C)+~D*(~B*(E@A))*~(C)+~(~D)*(~B*(E@A))*C+~D*(~B*(E@A))*C)"),
    .INIT(32'h101f202f))
    _al_u208 (
    .a(\rcnt/add6/net_cout0_lutinv ),
    .b(_al_u193_o),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u207_o),
    .e(rsub_reg[45]),
    .o(\rcnt/n92 [5]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*B))"),
    .INIT(8'h51))
    _al_u209 (
    .a(\rcnt/n25 ),
    .b(\rcnt/n24_lutinv ),
    .c(rsub_reg[45]),
    .o(\rcnt/mux12_b0_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u210 (
    .a(rsub_lat_reg),
    .b(rsub_reg[43]),
    .c(rsys_reg[43]),
    .o(_al_u210_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~((B*A))*~(C)+~D*(B*A)*~(C)+~(~D)*(B*A)*C+~D*(B*A)*C)"),
    .INIT(16'h808f))
    _al_u211 (
    .a(\rcnt/mux12_b0_sel_is_2_o ),
    .b(\rcnt/nxt_hou0 [3]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u210_o),
    .o(\rcnt/n92 [3]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u212 (
    .a(rsub_lat_reg),
    .b(rsub_reg[42]),
    .c(rsys_reg[42]),
    .o(_al_u212_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~((B*A))*~(C)+~D*(B*A)*~(C)+~(~D)*(B*A)*C+~D*(B*A)*C)"),
    .INIT(16'h808f))
    _al_u213 (
    .a(\rcnt/mux12_b0_sel_is_2_o ),
    .b(\rcnt/nxt_hou0 [2]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u212_o),
    .o(\rcnt/n92 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u214 (
    .a(rsub_lat_reg),
    .b(rsub_reg[41]),
    .c(rsys_reg[41]),
    .o(_al_u214_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~((B*A))*~(C)+~D*(B*A)*~(C)+~(~D)*(B*A)*C+~D*(B*A)*C)"),
    .INIT(16'h808f))
    _al_u215 (
    .a(\rcnt/mux12_b0_sel_is_2_o ),
    .b(\rcnt/nxt_hou0 [1]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(_al_u214_o),
    .o(\rcnt/n92 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u216 (
    .a(\rcnt/nxt_hou0 [0]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[40]),
    .e(rsys_reg[40]),
    .o(\rcnt/n92 [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u217 (
    .a(\rcnt/n20_lutinv ),
    .b(rsub_reg[28]),
    .o(\rcnt/add2/net_cout0_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u218 (
    .a(rsub_lat_reg),
    .b(rsub_reg[30]),
    .c(rsys_reg[30]),
    .o(_al_u218_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~((A*D*~(E)+~(A)*~(D)*E+~(A)*D*E))*~(B)+~C*(A*D*~(E)+~(A)*~(D)*E+~(A)*D*E)*~(B)+~(~C)*(A*D*~(E)+~(A)*~(D)*E+~(A)*D*E)*B+~C*(A*D*~(E)+~(A)*~(D)*E+~(A)*D*E)*B)"),
    .INIT(32'h47478b03))
    _al_u219 (
    .a(\rcnt/add2/net_cout0_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(_al_u218_o),
    .d(rsub_reg[29]),
    .e(rsub_reg[30]),
    .o(\rcnt/n94 [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u220 (
    .a(\rcnt/n22_lutinv ),
    .b(rsub_reg[36]),
    .o(\rcnt/add4/net_cout0_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u221 (
    .a(rsub_lat_reg),
    .b(rsub_reg[38]),
    .c(rsys_reg[38]),
    .o(\rcnt/n86 [6]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*D*~(E)+~(A)*~(D)*E+~(A)*D*E))*~(B)+C*(A*D*~(E)+~(A)*~(D)*E+~(A)*D*E)*~(B)+~(C)*(A*D*~(E)+~(A)*~(D)*E+~(A)*D*E)*B+C*(A*D*~(E)+~(A)*~(D)*E+~(A)*D*E)*B)"),
    .INIT(32'h7474b830))
    _al_u222 (
    .a(\rcnt/add4/net_cout0_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(\rcnt/n86 [6]),
    .d(rsub_reg[37]),
    .e(rsub_reg[38]),
    .o(\rcnt/n93 [6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u223 (
    .a(rsub_lat_reg),
    .b(rsub_reg[29]),
    .c(rsys_reg[29]),
    .o(\rcnt/n87 [5]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E))*~(B)+C*(A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E)*~(B)+~(C)*(A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E)*B+C*(A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E)*B)"),
    .INIT(32'h743074b8))
    _al_u224 (
    .a(\rcnt/add2/net_cout0_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(\rcnt/n87 [5]),
    .d(rsub_reg[29]),
    .e(rsub_reg[30]),
    .o(\rcnt/n94 [5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u225 (
    .a(rsub_lat_reg),
    .b(rsub_reg[37]),
    .c(rsys_reg[37]),
    .o(\rcnt/n86 [5]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E))*~(B)+C*(A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E)*~(B)+~(C)*(A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E)*B+C*(A*~(D)*~(E)+~(A)*D*~(E)+~(A)*D*E)*B)"),
    .INIT(32'h743074b8))
    _al_u226 (
    .a(\rcnt/add4/net_cout0_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(\rcnt/n86 [5]),
    .d(rsub_reg[37]),
    .e(rsub_reg[38]),
    .o(\rcnt/n93 [5]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h77d82788))
    _al_u227 (
    .a(\rcnt/rcnt_psc_ovf_lutinv ),
    .b(\rcnt/n20_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[28]),
    .e(rsys_reg[28]),
    .o(\rcnt/n94 [4]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h77b84788))
    _al_u228 (
    .a(\rcnt/n22_lutinv ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[36]),
    .e(rsys_reg[36]),
    .o(\rcnt/n93 [4]));
  AL_MAP_LUT4 #(
    .EQN("(B*~(A*~(D*C)))"),
    .INIT(16'hc444))
    _al_u229 (
    .a(\rcnt/n20_lutinv ),
    .b(\rcnt/nxt_sec0 [3]),
    .c(rsub_reg[29]),
    .d(rsub_reg[30]),
    .o(\rcnt/n80 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u230 (
    .a(\rcnt/n80 [3]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[27]),
    .e(rsys_reg[27]),
    .o(\rcnt/n94 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(B)*~(A)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B*~(A)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*B*A+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*B*A)"),
    .INIT(32'hddd88d88))
    _al_u231 (
    .a(\rcnt/rcnt_psc_ovf_lutinv ),
    .b(\rcnt/nxt_sec0 [2]),
    .c(rsub_lat_reg),
    .d(rsub_reg[26]),
    .e(rsys_reg[26]),
    .o(\rcnt/n94 [2]));
  AL_MAP_LUT4 #(
    .EQN("(B*~(A*~(D*C)))"),
    .INIT(16'hc444))
    _al_u232 (
    .a(\rcnt/n20_lutinv ),
    .b(\rcnt/nxt_sec0 [1]),
    .c(rsub_reg[29]),
    .d(rsub_reg[30]),
    .o(\rcnt/n80 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u233 (
    .a(\rcnt/n80 [1]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[25]),
    .e(rsys_reg[25]),
    .o(\rcnt/n94 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*~(C)*~(A)+(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*C*~(A)+~((D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B))*C*A+(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*C*A)"),
    .INIT(32'hf5e4b1a0))
    _al_u234 (
    .a(\rcnt/rcnt_psc_ovf_lutinv ),
    .b(rsub_lat_reg),
    .c(\rcnt/nxt_sec0 [0]),
    .d(rsub_reg[24]),
    .e(rsys_reg[24]),
    .o(\rcnt/n94 [0]));
  AL_MAP_LUT4 #(
    .EQN("(B*~(A*~(D*C)))"),
    .INIT(16'hc444))
    _al_u235 (
    .a(\rcnt/n22_lutinv ),
    .b(\rcnt/nxt_min0 [3]),
    .c(rsub_reg[37]),
    .d(rsub_reg[38]),
    .o(\rcnt/n68 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u236 (
    .a(\rcnt/n68 [3]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[35]),
    .e(rsys_reg[35]),
    .o(\rcnt/n93 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u237 (
    .a(\rcnt/nxt_min0 [2]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[34]),
    .e(rsys_reg[34]),
    .o(\rcnt/n93 [2]));
  AL_MAP_LUT4 #(
    .EQN("(B*~(A*~(D*C)))"),
    .INIT(16'hc444))
    _al_u238 (
    .a(\rcnt/n22_lutinv ),
    .b(\rcnt/nxt_min0 [1]),
    .c(rsub_reg[37]),
    .d(rsub_reg[38]),
    .o(\rcnt/n68 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u239 (
    .a(\rcnt/n68 [1]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[33]),
    .e(rsys_reg[33]),
    .o(\rcnt/n93 [1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u240 (
    .a(\rcnt/nxt_min0 [0]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[32]),
    .e(rsys_reg[32]),
    .o(\rcnt/n93 [0]));
  AL_MAP_LUT5 #(
    .EQN("(B*(A*C*D*~(E)+~(A)*~(C)*~(D)*E+A*~(C)*~(D)*E+~(A)*C*~(D)*E+A*C*~(D)*E+~(A)*~(C)*D*E))"),
    .INIT(32'h04cc8000))
    _al_u241 (
    .a(\rcnt/n25 ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_reg[0]),
    .d(rsub_reg[1]),
    .e(rsub_reg[2]),
    .o(_al_u241_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(~B*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)))"),
    .INIT(32'hbbbaabaa))
    _al_u242 (
    .a(_al_u241_o),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[2]),
    .e(rsys_reg[2]),
    .o(\rcnt/n91 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'he787))
    _al_u243 (
    .a(\rcnt/n25 ),
    .b(rsub_reg[0]),
    .c(rsub_reg[1]),
    .d(rsub_reg[2]),
    .o(_al_u243_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~(~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+~(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'h77744744))
    _al_u244 (
    .a(_al_u243_o),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[1]),
    .e(rsys_reg[1]),
    .o(\rcnt/n91 [1]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(E*D)*(C@A))"),
    .INIT(32'h00484848))
    _al_u245 (
    .a(\rcnt/n25 ),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_reg[0]),
    .d(rsub_reg[1]),
    .e(rsub_reg[2]),
    .o(_al_u245_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(~B*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)))"),
    .INIT(32'hbbbaabaa))
    _al_u246 (
    .a(_al_u245_o),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[0]),
    .e(rsys_reg[0]),
    .o(\rcnt/n91 [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u247 (
    .a(rsub_reg[59]),
    .b(rsub_reg[60]),
    .o(_al_u247_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u248 (
    .a(_al_u247_o),
    .b(rsub_reg[56]),
    .c(rsub_reg[57]),
    .d(rsub_reg[58]),
    .o(_al_u248_o));
  AL_MAP_LUT3 #(
    .EQN("(C*(B@A))"),
    .INIT(8'h60))
    _al_u249 (
    .a(_al_u248_o),
    .b(rsub_reg[52]),
    .c(rsub_reg[53]),
    .o(_al_u249_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u250 (
    .a(rsub_reg[79]),
    .b(_al_u247_o),
    .c(rsub_reg[56]),
    .d(rsub_reg[57]),
    .o(_al_u250_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfffdfdaf))
    _al_u251 (
    .a(rsub_reg[56]),
    .b(rsub_reg[57]),
    .c(rsub_reg[58]),
    .d(rsub_reg[59]),
    .e(rsub_reg[60]),
    .o(_al_u251_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*(~(B)*C*~((E*~D))+B*~(C)*(E*~D)))"),
    .INIT(32'h10041010))
    _al_u252 (
    .a(\rcnt/nxt_day0 [2]),
    .b(\rcnt/nxt_day0 [1]),
    .c(\rcnt/nxt_day0 [0]),
    .d(_al_u250_o),
    .e(_al_u251_o),
    .o(_al_u252_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D@C))"),
    .INIT(16'h8008))
    _al_u253 (
    .a(_al_u249_o),
    .b(_al_u252_o),
    .c(\rcnt/nxt_day0 [3]),
    .d(_al_u248_o),
    .o(\rcnt/n28 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u254 (
    .a(\rcnt/nxt_day0 [3]),
    .b(\rcnt/nxt_day0 [2]),
    .c(\rcnt/nxt_day0 [1]),
    .d(\rcnt/nxt_day0 [0]),
    .o(\rcnt/n27_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u255 (
    .a(rsub_lat_reg),
    .b(rsub_reg[52]),
    .c(rsys_reg[52]),
    .o(\rcnt/n83 [4]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((~A*(E@B)))*~(C)+D*(~A*(E@B))*~(C)+~(D)*(~A*(E@B))*C+D*(~A*(E@B))*C)"),
    .INIT(32'h1f104f40))
    _al_u256 (
    .a(\rcnt/n28 ),
    .b(\rcnt/n27_lutinv ),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(\rcnt/n83 [4]),
    .e(rsub_reg[52]),
    .o(\rcnt/n90 [4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u257 (
    .a(rsub_lat_reg),
    .b(rsub_reg[48]),
    .c(rsys_reg[48]),
    .o(\rcnt/n83 [0]));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~((~B*~A))*~(C)+~D*(~B*~A)*~(C)+~(~D)*(~B*~A)*C+~D*(~B*~A)*C)"),
    .INIT(16'hefe0))
    _al_u258 (
    .a(\rcnt/n28 ),
    .b(\rcnt/nxt_day0 [0]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(\rcnt/n83 [0]),
    .o(\rcnt/n90 [0]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(D@(C*B)))"),
    .INIT(16'h1540))
    _al_u259 (
    .a(\rcnt/n28 ),
    .b(\rcnt/n27_lutinv ),
    .c(rsub_reg[52]),
    .d(rsub_reg[53]),
    .o(\rcnt/n48 [5]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u260 (
    .a(\rcnt/n48 [5]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[53]),
    .e(rsys_reg[53]),
    .o(\rcnt/n90 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(B*~(D*C)))"),
    .INIT(16'h5111))
    _al_u261 (
    .a(\rcnt/n28 ),
    .b(\rcnt/n27_lutinv ),
    .c(rsub_reg[52]),
    .d(rsub_reg[53]),
    .o(\rcnt/mux8_b1_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u262 (
    .a(rsub_lat_reg),
    .b(rsub_reg[51]),
    .c(rsys_reg[51]),
    .o(\rcnt/n83 [3]));
  AL_MAP_LUT4 #(
    .EQN("(D*~((B*A))*~(C)+D*(B*A)*~(C)+~(D)*(B*A)*C+D*(B*A)*C)"),
    .INIT(16'h8f80))
    _al_u263 (
    .a(\rcnt/mux8_b1_sel_is_2_o ),
    .b(\rcnt/nxt_day0 [3]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(\rcnt/n83 [3]),
    .o(\rcnt/n90 [3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    _al_u264 (
    .a(\rcnt/nxt_day0 [2]),
    .b(\rcnt/rcnt_psc_ovf_lutinv ),
    .c(rsub_lat_reg),
    .d(rsub_reg[50]),
    .e(rsys_reg[50]),
    .o(\rcnt/n90 [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u265 (
    .a(rsub_lat_reg),
    .b(rsub_reg[49]),
    .c(rsys_reg[49]),
    .o(\rcnt/n83 [1]));
  AL_MAP_LUT4 #(
    .EQN("(D*~((B*A))*~(C)+D*(B*A)*~(C)+~(D)*(B*A)*C+D*(B*A)*C)"),
    .INIT(16'h8f80))
    _al_u266 (
    .a(\rcnt/mux8_b1_sel_is_2_o ),
    .b(\rcnt/nxt_day0 [1]),
    .c(\rcnt/rcnt_psc_ovf_lutinv ),
    .d(\rcnt/n83 [1]),
    .o(\rcnt/n90 [1]));
  reg_ar_as_w1 \rclk/reg0_b0  (
    .clk(clk32k),
    .d(rctl_wrt_req),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rclk/rctl_wrt_req_s [0]));  // rtl/rtc400_sub.v(61)
  reg_ar_as_w1 \rclk/reg0_b1  (
    .clk(clk32k),
    .d(\rclk/rctl_wrt_req_s [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rclk/rfsm/sel0_b0_sel_o ));  // rtl/rtc400_sub.v(61)
  reg_sr_as_w1 \rclk/rfsm/reg0_b0  (
    .clk(clk32k),
    .d(1'b1),
    .en(1'b1),
    .reset(~\rclk/rfsm/sel0_b0_sel_o ),
    .set(1'b0),
    .q(\rclk/rfsm/stat [0]));  // rtl/rtc_sub_fsm.v(44)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u0  (
    .a(\rcnt/rcnt_psc [0]),
    .b(1'b1),
    .c(\rcnt/add0/c0 ),
    .o({\rcnt/add0/c1 ,\rcnt/n0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u1  (
    .a(\rcnt/rcnt_psc [1]),
    .b(1'b0),
    .c(\rcnt/add0/c1 ),
    .o({\rcnt/add0/c2 ,\rcnt/n0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u10  (
    .a(rsub_reg[19]),
    .b(1'b0),
    .c(\rcnt/add0/c10 ),
    .o({\rcnt/add0/c11 ,\rcnt/n0 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u11  (
    .a(rsub_reg[20]),
    .b(1'b0),
    .c(\rcnt/add0/c11 ),
    .o({\rcnt/add0/c12 ,\rcnt/n0 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u12  (
    .a(rsub_reg[21]),
    .b(1'b0),
    .c(\rcnt/add0/c12 ),
    .o({\rcnt/add0/c13 ,\rcnt/n0 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u13  (
    .a(rsub_reg[22]),
    .b(1'b0),
    .c(\rcnt/add0/c13 ),
    .o({\rcnt/add0/c14 ,\rcnt/n0 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u14  (
    .a(rsub_reg[23]),
    .b(1'b0),
    .c(\rcnt/add0/c14 ),
    .o({open_n0,\rcnt/n0 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u2  (
    .a(\rcnt/rcnt_psc [2]),
    .b(1'b0),
    .c(\rcnt/add0/c2 ),
    .o({\rcnt/add0/c3 ,\rcnt/n0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u3  (
    .a(\rcnt/rcnt_psc [3]),
    .b(1'b0),
    .c(\rcnt/add0/c3 ),
    .o({\rcnt/add0/c4 ,\rcnt/n0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u4  (
    .a(\rcnt/rcnt_psc [4]),
    .b(1'b0),
    .c(\rcnt/add0/c4 ),
    .o({\rcnt/add0/c5 ,\rcnt/n0 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u5  (
    .a(\rcnt/rcnt_psc [5]),
    .b(1'b0),
    .c(\rcnt/add0/c5 ),
    .o({\rcnt/add0/c6 ,\rcnt/n0 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u6  (
    .a(\rcnt/rcnt_psc [6]),
    .b(1'b0),
    .c(\rcnt/add0/c6 ),
    .o({\rcnt/add0/c7 ,\rcnt/n0 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u7  (
    .a(rsub_reg[16]),
    .b(1'b0),
    .c(\rcnt/add0/c7 ),
    .o({\rcnt/add0/c8 ,\rcnt/n0 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u8  (
    .a(rsub_reg[17]),
    .b(1'b0),
    .c(\rcnt/add0/c8 ),
    .o({\rcnt/add0/c9 ,\rcnt/n0 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add0/u9  (
    .a(rsub_reg[18]),
    .b(1'b0),
    .c(\rcnt/add0/c9 ),
    .o({\rcnt/add0/c10 ,\rcnt/n0 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add0/ucin  (
    .a(1'b0),
    .o({\rcnt/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u0  (
    .a(rsub_reg[24]),
    .b(1'b1),
    .c(\rcnt/add1/c0 ),
    .o({\rcnt/add1/c1 ,\rcnt/nxt_sec0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u1  (
    .a(rsub_reg[25]),
    .b(1'b0),
    .c(\rcnt/add1/c1 ),
    .o({\rcnt/add1/c2 ,\rcnt/nxt_sec0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u2  (
    .a(rsub_reg[26]),
    .b(1'b0),
    .c(\rcnt/add1/c2 ),
    .o({\rcnt/add1/c3 ,\rcnt/nxt_sec0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add1/u3  (
    .a(rsub_reg[27]),
    .b(1'b0),
    .c(\rcnt/add1/c3 ),
    .o({open_n4,\rcnt/nxt_sec0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add1/ucin  (
    .a(1'b0),
    .o({\rcnt/add1/c0 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add10/u0  (
    .a(rsub_reg[56]),
    .b(\rcnt/n28 ),
    .c(\rcnt/add10/c0 ),
    .o({\rcnt/add10/c1 ,\rcnt/nxt_mon0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add10/u1  (
    .a(rsub_reg[57]),
    .b(1'b0),
    .c(\rcnt/add10/c1 ),
    .o({\rcnt/add10/c2 ,\rcnt/nxt_mon0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add10/u2  (
    .a(rsub_reg[58]),
    .b(1'b0),
    .c(\rcnt/add10/c2 ),
    .o({\rcnt/add10/c3 ,\rcnt/nxt_mon0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add10/u3  (
    .a(rsub_reg[59]),
    .b(1'b0),
    .c(\rcnt/add10/c3 ),
    .o({open_n8,\rcnt/nxt_mon0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add10/ucin  (
    .a(1'b0),
    .o({\rcnt/add10/c0 ,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add12/u0  (
    .a(rsub_reg[64]),
    .b(\rcnt/n30 ),
    .c(\rcnt/add12/c0 ),
    .o({\rcnt/add12/c1 ,\rcnt/nxt_yea0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add12/u1  (
    .a(rsub_reg[65]),
    .b(1'b0),
    .c(\rcnt/add12/c1 ),
    .o({\rcnt/add12/c2 ,\rcnt/nxt_yea0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add12/u2  (
    .a(rsub_reg[66]),
    .b(1'b0),
    .c(\rcnt/add12/c2 ),
    .o({\rcnt/add12/c3 ,\rcnt/nxt_yea0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add12/u3  (
    .a(rsub_reg[67]),
    .b(1'b0),
    .c(\rcnt/add12/c3 ),
    .o({open_n12,\rcnt/nxt_yea0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add12/ucin  (
    .a(1'b0),
    .o({\rcnt/add12/c0 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add13/u0  (
    .a(rsub_reg[68]),
    .b(\rcnt/n31 ),
    .c(\rcnt/add13/c0 ),
    .o({\rcnt/add13/c1 ,\rcnt/nxt_yea1 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add13/u1  (
    .a(rsub_reg[69]),
    .b(1'b0),
    .c(\rcnt/add13/c1 ),
    .o({\rcnt/add13/c2 ,\rcnt/nxt_yea1 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add13/u2  (
    .a(rsub_reg[70]),
    .b(1'b0),
    .c(\rcnt/add13/c2 ),
    .o({\rcnt/add13/c3 ,\rcnt/nxt_yea1 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add13/u3  (
    .a(rsub_reg[71]),
    .b(1'b0),
    .c(\rcnt/add13/c3 ),
    .o({open_n16,\rcnt/nxt_yea1 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add13/ucin  (
    .a(1'b0),
    .o({\rcnt/add13/c0 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add15_rcnt/add16/u0  (
    .a(rsub_reg[72]),
    .b(rsub_reg[69]),
    .c(\rcnt/add15_rcnt/add16/c0 ),
    .o({\rcnt/add15_rcnt/add16/c1 ,\rcnt/bin_yea3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add15_rcnt/add16/u1  (
    .a(rsub_reg[73]),
    .b(rsub_reg[70]),
    .c(\rcnt/add15_rcnt/add16/c1 ),
    .o({\rcnt/add15_rcnt/add16/c2 ,\rcnt/bin_yea3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add15_rcnt/add16/u2  (
    .a(rsub_reg[72]),
    .b(rsub_reg[71]),
    .c(\rcnt/add15_rcnt/add16/c2 ),
    .o({\rcnt/add15_rcnt/add16/c3 ,\rcnt/bin_yea3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add15_rcnt/add16/u3  (
    .a(rsub_reg[73]),
    .b(1'b0),
    .c(\rcnt/add15_rcnt/add16/c3 ),
    .o({\rcnt/add15_rcnt/add16/c4 ,\rcnt/bin_yea3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add15_rcnt/add16/ucin  (
    .a(1'b0),
    .o({\rcnt/add15_rcnt/add16/c0 ,open_n22}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add15_rcnt/add16/ucout  (
    .c(\rcnt/add15_rcnt/add16/c4 ),
    .o({open_n25,\rcnt/bin_yea3 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add3/u0  (
    .a(rsub_reg[32]),
    .b(\rcnt/n21 ),
    .c(\rcnt/add3/c0 ),
    .o({\rcnt/add3/c1 ,\rcnt/nxt_min0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add3/u1  (
    .a(rsub_reg[33]),
    .b(1'b0),
    .c(\rcnt/add3/c1 ),
    .o({\rcnt/add3/c2 ,\rcnt/nxt_min0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add3/u2  (
    .a(rsub_reg[34]),
    .b(1'b0),
    .c(\rcnt/add3/c2 ),
    .o({\rcnt/add3/c3 ,\rcnt/nxt_min0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add3/u3  (
    .a(rsub_reg[35]),
    .b(1'b0),
    .c(\rcnt/add3/c3 ),
    .o({open_n26,\rcnt/nxt_min0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add3/ucin  (
    .a(1'b0),
    .o({\rcnt/add3/c0 ,open_n29}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add5/u0  (
    .a(rsub_reg[40]),
    .b(\rcnt/n23 ),
    .c(\rcnt/add5/c0 ),
    .o({\rcnt/add5/c1 ,\rcnt/nxt_hou0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add5/u1  (
    .a(rsub_reg[41]),
    .b(1'b0),
    .c(\rcnt/add5/c1 ),
    .o({\rcnt/add5/c2 ,\rcnt/nxt_hou0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add5/u2  (
    .a(rsub_reg[42]),
    .b(1'b0),
    .c(\rcnt/add5/c2 ),
    .o({\rcnt/add5/c3 ,\rcnt/nxt_hou0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add5/u3  (
    .a(rsub_reg[43]),
    .b(1'b0),
    .c(\rcnt/add5/c3 ),
    .o({open_n30,\rcnt/nxt_hou0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add5/ucin  (
    .a(1'b0),
    .o({\rcnt/add5/c0 ,open_n33}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add8/u0  (
    .a(rsub_reg[48]),
    .b(\rcnt/n25 ),
    .c(\rcnt/add8/c0 ),
    .o({\rcnt/add8/c1 ,\rcnt/nxt_day0 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add8/u1  (
    .a(rsub_reg[49]),
    .b(1'b0),
    .c(\rcnt/add8/c1 ),
    .o({\rcnt/add8/c2 ,\rcnt/nxt_day0 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add8/u2  (
    .a(rsub_reg[50]),
    .b(1'b0),
    .c(\rcnt/add8/c2 ),
    .o({\rcnt/add8/c3 ,\rcnt/nxt_day0 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rcnt/add8/u3  (
    .a(rsub_reg[51]),
    .b(1'b0),
    .c(\rcnt/add8/c3 ),
    .o({open_n34,\rcnt/nxt_day0 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rcnt/add8/ucin  (
    .a(1'b0),
    .o({\rcnt/add8/c0 ,open_n37}));
  reg_ar_as_w1 \rcnt/reg0_b0  (
    .clk(clk32k),
    .d(\rcnt/n88 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[64]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b1  (
    .clk(clk32k),
    .d(\rcnt/n88 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[65]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b2  (
    .clk(clk32k),
    .d(\rcnt/n88 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[66]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b3  (
    .clk(clk32k),
    .d(\rcnt/n88 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[67]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b4  (
    .clk(clk32k),
    .d(\rcnt/n88 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[68]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b5  (
    .clk(clk32k),
    .d(\rcnt/n88 [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[69]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b6  (
    .clk(clk32k),
    .d(\rcnt/n88 [6]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[70]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b7  (
    .clk(clk32k),
    .d(\rcnt/n88 [7]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[71]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b8  (
    .clk(clk32k),
    .d(\rcnt/n88 [8]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[72]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg0_b9  (
    .clk(clk32k),
    .d(\rcnt/n88 [9]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[73]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg1_b0  (
    .clk(clk32k),
    .d(\rcnt/n89 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[56]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg1_b1  (
    .clk(clk32k),
    .d(\rcnt/n89 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[57]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg1_b2  (
    .clk(clk32k),
    .d(\rcnt/n89 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[58]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg1_b3  (
    .clk(clk32k),
    .d(\rcnt/n89 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[59]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg1_b4  (
    .clk(clk32k),
    .d(\rcnt/n89 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[60]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg2_b0  (
    .clk(clk32k),
    .d(\rcnt/n90 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[48]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg2_b1  (
    .clk(clk32k),
    .d(\rcnt/n90 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[49]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg2_b2  (
    .clk(clk32k),
    .d(\rcnt/n90 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[50]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg2_b3  (
    .clk(clk32k),
    .d(\rcnt/n90 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[51]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg2_b4  (
    .clk(clk32k),
    .d(\rcnt/n90 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[52]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg2_b5  (
    .clk(clk32k),
    .d(\rcnt/n90 [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[53]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg3_b0  (
    .clk(clk32k),
    .d(\rcnt/n91 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[0]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg3_b1  (
    .clk(clk32k),
    .d(\rcnt/n91 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[1]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg3_b2  (
    .clk(clk32k),
    .d(\rcnt/n91 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[2]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg4_b0  (
    .clk(clk32k),
    .d(\rcnt/n92 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[40]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg4_b1  (
    .clk(clk32k),
    .d(\rcnt/n92 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[41]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg4_b2  (
    .clk(clk32k),
    .d(\rcnt/n92 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[42]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg4_b3  (
    .clk(clk32k),
    .d(\rcnt/n92 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[43]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg4_b4  (
    .clk(clk32k),
    .d(\rcnt/n92 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[44]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg4_b5  (
    .clk(clk32k),
    .d(\rcnt/n92 [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[45]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg5_b0  (
    .clk(clk32k),
    .d(\rcnt/n93 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[32]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg5_b1  (
    .clk(clk32k),
    .d(\rcnt/n93 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[33]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg5_b2  (
    .clk(clk32k),
    .d(\rcnt/n93 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[34]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg5_b3  (
    .clk(clk32k),
    .d(\rcnt/n93 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[35]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg5_b4  (
    .clk(clk32k),
    .d(\rcnt/n93 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[36]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg5_b5  (
    .clk(clk32k),
    .d(\rcnt/n93 [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[37]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg5_b6  (
    .clk(clk32k),
    .d(\rcnt/n93 [6]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[38]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg6_b0  (
    .clk(clk32k),
    .d(\rcnt/n94 [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[24]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg6_b1  (
    .clk(clk32k),
    .d(\rcnt/n94 [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[25]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg6_b2  (
    .clk(clk32k),
    .d(\rcnt/n94 [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[26]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg6_b3  (
    .clk(clk32k),
    .d(\rcnt/n94 [3]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[27]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg6_b4  (
    .clk(clk32k),
    .d(\rcnt/n94 [4]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[28]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg6_b5  (
    .clk(clk32k),
    .d(\rcnt/n94 [5]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[29]));  // rtl/rtc400_sub.v(212)
  reg_ar_as_w1 \rcnt/reg6_b6  (
    .clk(clk32k),
    .d(\rcnt/n94 [6]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[30]));  // rtl/rtc400_sub.v(212)
  reg_sr_as_w1 \rcnt/reg7_b0  (
    .clk(clk32k),
    .d(\rcnt/n0 [0]),
    .en(1'b1),
    .reset(rsub_lat_reg),
    .set(1'b0),
    .q(\rcnt/rcnt_psc [0]));  // rtl/rtc400_sub.v(115)
  reg_sr_as_w1 \rcnt/reg7_b1  (
    .clk(clk32k),
    .d(\rcnt/n0 [1]),
    .en(1'b1),
    .reset(rsub_lat_reg),
    .set(1'b0),
    .q(\rcnt/rcnt_psc [1]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b10  (
    .clk(clk32k),
    .d(\rcnt/n1 [10]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[19]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b11  (
    .clk(clk32k),
    .d(\rcnt/n1 [11]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[20]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b12  (
    .clk(clk32k),
    .d(\rcnt/n1 [12]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[21]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b13  (
    .clk(clk32k),
    .d(\rcnt/n1 [13]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[22]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b14  (
    .clk(clk32k),
    .d(\rcnt/n1 [14]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[23]));  // rtl/rtc400_sub.v(115)
  reg_sr_as_w1 \rcnt/reg7_b2  (
    .clk(clk32k),
    .d(\rcnt/n0 [2]),
    .en(1'b1),
    .reset(rsub_lat_reg),
    .set(1'b0),
    .q(\rcnt/rcnt_psc [2]));  // rtl/rtc400_sub.v(115)
  reg_sr_as_w1 \rcnt/reg7_b3  (
    .clk(clk32k),
    .d(\rcnt/n0 [3]),
    .en(1'b1),
    .reset(rsub_lat_reg),
    .set(1'b0),
    .q(\rcnt/rcnt_psc [3]));  // rtl/rtc400_sub.v(115)
  reg_sr_as_w1 \rcnt/reg7_b4  (
    .clk(clk32k),
    .d(\rcnt/n0 [4]),
    .en(1'b1),
    .reset(rsub_lat_reg),
    .set(1'b0),
    .q(\rcnt/rcnt_psc [4]));  // rtl/rtc400_sub.v(115)
  reg_sr_as_w1 \rcnt/reg7_b5  (
    .clk(clk32k),
    .d(\rcnt/n0 [5]),
    .en(1'b1),
    .reset(rsub_lat_reg),
    .set(1'b0),
    .q(\rcnt/rcnt_psc [5]));  // rtl/rtc400_sub.v(115)
  reg_sr_as_w1 \rcnt/reg7_b6  (
    .clk(clk32k),
    .d(\rcnt/n0 [6]),
    .en(1'b1),
    .reset(rsub_lat_reg),
    .set(1'b0),
    .q(\rcnt/rcnt_psc [6]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b7  (
    .clk(clk32k),
    .d(\rcnt/n1 [7]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[16]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b8  (
    .clk(clk32k),
    .d(\rcnt/n1 [8]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[17]));  // rtl/rtc400_sub.v(115)
  reg_ar_as_w1 \rcnt/reg7_b9  (
    .clk(clk32k),
    .d(\rcnt/n1 [9]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(rsub_reg[18]));  // rtl/rtc400_sub.v(115)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u0  (
    .a(rsub_reg[67]),
    .b(\rcnt/bin_yea3 [2]),
    .c(\u1/c0 ),
    .o({\u1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u1  (
    .a(1'b0),
    .b(\rcnt/bin_yea3 [3]),
    .c(\u1/c1 ),
    .o({\u1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u2  (
    .a(1'b0),
    .b(\rcnt/bin_yea3 [4]),
    .c(\u1/c2 ),
    .o({\u1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/u3  (
    .a(1'b0),
    .b(\rcnt/bin_yea3 [5]),
    .c(\u1/c3 ),
    .o({\u1/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u1/ucin  (
    .a(1'b0),
    .o({\u1/c0 ,open_n40}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1/ucout  (
    .c(\u1/c4 ),
    .o({open_n43,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u0  (
    .a(rsub_reg[65]),
    .b(rsub_reg[68]),
    .c(\u2/c0 ),
    .o({\u2/c1 ,\rcnt/bin_yea [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u1  (
    .a(rsub_reg[66]),
    .b(\rcnt/bin_yea3 [1]),
    .c(\u2/c1 ),
    .o({\u2/c2 ,\rcnt/bin_yea [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u2  (
    .a(rsub_reg[68]),
    .b(n0[0]),
    .c(\u2/c2 ),
    .o({\u2/c3 ,\rcnt/bin_yea [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u3  (
    .a(\rcnt/bin_yea3 [1]),
    .b(n0[1]),
    .c(\u2/c3 ),
    .o({\u2/c4 ,\rcnt/bin_yea [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u4  (
    .a(\rcnt/bin_yea3 [2]),
    .b(n0[2]),
    .c(\u2/c4 ),
    .o({\u2/c5 ,\rcnt/bin_yea [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u5  (
    .a(\rcnt/bin_yea3 [3]),
    .b(n0[3]),
    .c(\u2/c5 ),
    .o({\u2/c6 ,\rcnt/bin_yea [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u6  (
    .a(\rcnt/bin_yea3 [4]),
    .b(n0[4]),
    .c(\u2/c6 ),
    .o({\u2/c7 ,\rcnt/bin_yea [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u2/u7  (
    .a(\rcnt/bin_yea3 [5]),
    .b(1'b0),
    .c(\u2/c7 ),
    .o({open_n44,\rcnt/bin_yea [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u2/ucin  (
    .a(1'b0),
    .o({\u2/c0 ,open_n47}));

endmodule 

