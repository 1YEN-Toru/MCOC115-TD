
`timescale 1ns / 1ps
module uart8n1  // rtl/uart8n1.v(1)
  (
  badr,
  bcmdr,
  bcmdw,
  bcs_uart_n,
  bdatw,
  brdy,
  clk,
  rst_n,
  uart_cts,
  uart_rxd,
  urxf_aempty,
  urxf_afull,
  urxf_dato,
  urxf_empty,
  urxf_full,
  bdatr,
  uart_brdr,
  uart_rts,
  uart_txd,
  urxf_dati,
  urxf_frst,
  urxf_read,
  urxf_write
  );
//
//	UART Unit (Format 8N1, LSB first)
//		(c) 2021	1YEN Toru
//
//
//	2021/11/06	ver.1.02
//		corresponding to hardware flow control (cts, rts)
//		revised: baud rate detection function
//
//	2021/03/27	ver.1.00
//		frame format was fixed: 8 bit lsb first, no parity, 1 stop bit
//		baud rate is variable by setting uartbaud register.
//

  input [3:0] badr;  // rtl/uart8n1.v(36)
  input bcmdr;  // rtl/uart8n1.v(34)
  input bcmdw;  // rtl/uart8n1.v(35)
  input bcs_uart_n;  // rtl/uart8n1.v(32)
  input [15:0] bdatw;  // rtl/uart8n1.v(37)
  input brdy;  // rtl/uart8n1.v(33)
  input clk;  // rtl/uart8n1.v(28)
  input rst_n;  // rtl/uart8n1.v(29)
  input uart_cts;  // rtl/uart8n1.v(31)
  input uart_rxd;  // rtl/uart8n1.v(30)
  input urxf_aempty;  // rtl/uart8n1.v(44)
  input urxf_afull;  // rtl/uart8n1.v(46)
  input [7:0] urxf_dato;  // rtl/uart8n1.v(47)
  input urxf_empty;  // rtl/uart8n1.v(43)
  input urxf_full;  // rtl/uart8n1.v(45)
  output [15:0] bdatr;  // rtl/uart8n1.v(41)
  output uart_brdr;  // rtl/uart8n1.v(40)
  output uart_rts;  // rtl/uart8n1.v(39)
  output uart_txd;  // rtl/uart8n1.v(38)
  output [7:0] urxf_dati;  // rtl/uart8n1.v(51)
  output urxf_frst;  // rtl/uart8n1.v(49)
  output urxf_read;  // rtl/uart8n1.v(48)
  output urxf_write;  // rtl/uart8n1.v(50)

  wire [7:0] \buso/n0 ;
  wire [15:0] uartbaud;  // rtl/uart8n1.v(69)
  wire [16:0] \ubr/bitr_diff ;  // rtl/uart_br.v(62)
  wire [3:0] \ubr/bitr_sft ;  // rtl/uart_br.v(19)
  wire [18:0] \ubr/brcnt ;  // rtl/uart_br.v(67)
  wire [15:0] \ubr/brcnt_f ;  // rtl/uart_br.v(82)
  wire [15:0] \ubr/bwcnt ;  // rtl/uart_br.v(32)
  wire [16:0] \ubr/bwdat0 ;  // rtl/uart_br.v(47)
  wire [16:0] \ubr/bwdat1 ;  // rtl/uart_br.v(48)
  wire [3:0] \ubr/fsm/stat ;  // rtl/uart_br_fsm.v(48)
  wire [16:0] \ubr/n10 ;
  wire [18:0] \ubr/n14 ;
  wire [15:0] \ubr/n17 ;
  wire [15:0] \ubr/n18 ;
  wire [15:0] \ubr/n3 ;
  wire [15:0] \ubr/uartbres ;  // rtl/uart_br.v(83)
  wire [3:0] \uctl/uartctl ;  // rtl/uart_uctl.v(109)
  wire [3:0] \uctl/uartflow ;  // rtl/uart_uctl.v(127)
  wire [3:0] \uctl/uctl_cts_sft ;  // rtl/uart_uctl.v(152)
  wire [15:0] \urx/bcnt ;  // rtl/uart_rx.v(38)
  wire [15:0] \urx/n16 ;
  wire [3:0] \urx/rxctl/urx_stat ;  // rtl/uart_rx_fsm.v(58)
  wire [3:0] \urx/sync_rxd ;  // rtl/uart_rx.v(25)
  wire [15:0] \utx/bcnt ;  // rtl/uart_tx.v(50)
  wire [15:0] \utx/n14 ;
  wire [3:0] \utx/txctl/utx_stat ;  // rtl/uart_tx_fsm.v(52)
  wire [7:0] \utx/uarttdat ;  // rtl/uart_tx.v(29)
  wire [9:0] \utx/utx_tran ;  // rtl/uart_tx.v(25)
  wire _al_u100_o;
  wire _al_u101_o;
  wire _al_u105_o;
  wire _al_u108_o;
  wire _al_u109_o;
  wire _al_u110_o;
  wire _al_u111_o;
  wire _al_u115_o;
  wire _al_u121_o;
  wire _al_u124_o;
  wire _al_u126_o;
  wire _al_u129_o;
  wire _al_u130_o;
  wire _al_u131_o;
  wire _al_u132_o;
  wire _al_u134_o;
  wire _al_u136_o;
  wire _al_u137_o;
  wire _al_u138_o;
  wire _al_u139_o;
  wire _al_u140_o;
  wire _al_u141_o;
  wire _al_u142_o;
  wire _al_u143_o;
  wire _al_u144_o;
  wire _al_u145_o;
  wire _al_u146_o;
  wire _al_u147_o;
  wire _al_u149_o;
  wire _al_u153_o;
  wire _al_u161_o;
  wire _al_u162_o;
  wire _al_u163_o;
  wire _al_u164_o;
  wire _al_u165_o;
  wire _al_u168_o;
  wire _al_u169_o;
  wire _al_u170_o;
  wire _al_u172_o;
  wire _al_u173_o;
  wire _al_u175_o;
  wire _al_u176_o;
  wire _al_u177_o;
  wire _al_u178_o;
  wire _al_u180_o;
  wire _al_u181_o;
  wire _al_u182_o;
  wire _al_u183_o;
  wire _al_u184_o;
  wire _al_u186_o;
  wire _al_u187_o;
  wire _al_u188_o;
  wire _al_u189_o;
  wire _al_u190_o;
  wire _al_u191_o;
  wire _al_u194_o;
  wire _al_u196_o;
  wire _al_u200_o;
  wire _al_u201_o;
  wire _al_u202_o;
  wire _al_u203_o;
  wire _al_u205_o;
  wire _al_u206_o;
  wire _al_u207_o;
  wire _al_u208_o;
  wire _al_u212_o;
  wire _al_u213_o;
  wire _al_u214_o;
  wire _al_u218_o;
  wire _al_u219_o;
  wire _al_u220_o;
  wire _al_u221_o;
  wire _al_u222_o;
  wire _al_u223_o;
  wire _al_u224_o;
  wire _al_u225_o;
  wire _al_u226_o;
  wire _al_u227_o;
  wire _al_u229_o;
  wire _al_u231_o;
  wire _al_u47_o;
  wire _al_u51_o;
  wire _al_u62_o;
  wire _al_u66_o;
  wire _al_u69_o;
  wire _al_u72_o;
  wire _al_u75_o;
  wire _al_u78_o;
  wire _al_u88_o;
  wire _al_u91_o;
  wire _al_u92_o;
  wire _al_u93_o;
  wire _al_u94_o;
  wire _al_u96_o;
  wire _al_u98_o;
  wire \ubr/_al_n0_en ;
  wire \ubr/add0/c0 ;
  wire \ubr/add0/c1 ;
  wire \ubr/add0/c10 ;
  wire \ubr/add0/c11 ;
  wire \ubr/add0/c12 ;
  wire \ubr/add0/c13 ;
  wire \ubr/add0/c14 ;
  wire \ubr/add0/c15 ;
  wire \ubr/add0/c2 ;
  wire \ubr/add0/c3 ;
  wire \ubr/add0/c4 ;
  wire \ubr/add0/c5 ;
  wire \ubr/add0/c6 ;
  wire \ubr/add0/c7 ;
  wire \ubr/add0/c8 ;
  wire \ubr/add0/c9 ;
  wire \ubr/add1/c0 ;
  wire \ubr/add1/c1 ;
  wire \ubr/add1/c10 ;
  wire \ubr/add1/c11 ;
  wire \ubr/add1/c12 ;
  wire \ubr/add1/c13 ;
  wire \ubr/add1/c14 ;
  wire \ubr/add1/c15 ;
  wire \ubr/add1/c16 ;
  wire \ubr/add1/c17 ;
  wire \ubr/add1/c18 ;
  wire \ubr/add1/c2 ;
  wire \ubr/add1/c3 ;
  wire \ubr/add1/c4 ;
  wire \ubr/add1/c5 ;
  wire \ubr/add1/c6 ;
  wire \ubr/add1/c7 ;
  wire \ubr/add1/c8 ;
  wire \ubr/add1/c9 ;
  wire \ubr/bitr_fovf ;  // rtl/uart_br.v(66)
  wire \ubr/bitr_late ;  // rtl/uart_br.v(111)
  wire \ubr/bitr_ovf ;  // rtl/uart_br.v(31)
  wire \ubr/bitr_tgl ;  // rtl/uart_br.v(27)
  wire \ubr/fsm/bitr_late_t ;  // rtl/uart_br_fsm.v(46)
  wire \ubr/fsm/mux0_b0_sel_is_1_o ;
  wire \ubr/fsm/mux0_b1_sel_is_3_o ;
  wire \ubr/fsm/mux0_b2_sel_is_3_o ;
  wire \ubr/fsm/mux0_b3_sel_is_3_o ;
  wire \ubr/fsm/n118_lutinv ;
  wire \ubr/fsm/n177_lutinv ;
  wire \ubr/fsm/n18_lutinv ;
  wire \ubr/fsm/n23_lutinv ;
  wire \ubr/fsm/n28_lutinv ;
  wire \ubr/fsm/n38_lutinv ;
  wire \ubr/fsm/n97 ;
  wire \ubr/fsm/n97_neg ;
  wire \ubr/fsm/n98_lutinv ;
  wire \ubr/lt0_c0 ;
  wire \ubr/lt0_c1 ;
  wire \ubr/lt0_c10 ;
  wire \ubr/lt0_c11 ;
  wire \ubr/lt0_c12 ;
  wire \ubr/lt0_c13 ;
  wire \ubr/lt0_c14 ;
  wire \ubr/lt0_c15 ;
  wire \ubr/lt0_c16 ;
  wire \ubr/lt0_c17 ;
  wire \ubr/lt0_c2 ;
  wire \ubr/lt0_c3 ;
  wire \ubr/lt0_c4 ;
  wire \ubr/lt0_c5 ;
  wire \ubr/lt0_c6 ;
  wire \ubr/lt0_c7 ;
  wire \ubr/lt0_c8 ;
  wire \ubr/lt0_c9 ;
  wire \ubr/lt1_c0 ;
  wire \ubr/lt1_c1 ;
  wire \ubr/lt1_c10 ;
  wire \ubr/lt1_c11 ;
  wire \ubr/lt1_c12 ;
  wire \ubr/lt1_c13 ;
  wire \ubr/lt1_c14 ;
  wire \ubr/lt1_c15 ;
  wire \ubr/lt1_c16 ;
  wire \ubr/lt1_c17 ;
  wire \ubr/lt1_c2 ;
  wire \ubr/lt1_c3 ;
  wire \ubr/lt1_c4 ;
  wire \ubr/lt1_c5 ;
  wire \ubr/lt1_c6 ;
  wire \ubr/lt1_c7 ;
  wire \ubr/lt1_c8 ;
  wire \ubr/lt1_c9 ;
  wire \ubr/n11 ;
  wire \ubr/n12 ;
  wire \ubr/n13 ;
  wire \ubr/n2 ;
  wire \ubr/neg0/c0 ;
  wire \ubr/neg0/c1 ;
  wire \ubr/neg0/c10 ;
  wire \ubr/neg0/c11 ;
  wire \ubr/neg0/c12 ;
  wire \ubr/neg0/c13 ;
  wire \ubr/neg0/c14 ;
  wire \ubr/neg0/c15 ;
  wire \ubr/neg0/c16 ;
  wire \ubr/neg0/c2 ;
  wire \ubr/neg0/c3 ;
  wire \ubr/neg0/c4 ;
  wire \ubr/neg0/c5 ;
  wire \ubr/neg0/c6 ;
  wire \ubr/neg0/c7 ;
  wire \ubr/neg0/c8 ;
  wire \ubr/neg0/c9 ;
  wire \ubr/sub0/c0 ;
  wire \ubr/sub0/c1 ;
  wire \ubr/sub0/c10 ;
  wire \ubr/sub0/c11 ;
  wire \ubr/sub0/c12 ;
  wire \ubr/sub0/c13 ;
  wire \ubr/sub0/c14 ;
  wire \ubr/sub0/c15 ;
  wire \ubr/sub0/c16 ;
  wire \ubr/sub0/c2 ;
  wire \ubr/sub0/c3 ;
  wire \ubr/sub0/c4 ;
  wire \ubr/sub0/c5 ;
  wire \ubr/sub0/c6 ;
  wire \ubr/sub0/c7 ;
  wire \ubr/sub0/c8 ;
  wire \ubr/sub0/c9 ;
  wire \ubr/sub1/c0 ;
  wire \ubr/sub1/c1 ;
  wire \ubr/sub1/c10 ;
  wire \ubr/sub1/c11 ;
  wire \ubr/sub1/c12 ;
  wire \ubr/sub1/c13 ;
  wire \ubr/sub1/c14 ;
  wire \ubr/sub1/c15 ;
  wire \ubr/sub1/c2 ;
  wire \ubr/sub1/c3 ;
  wire \ubr/sub1/c4 ;
  wire \ubr/sub1/c5 ;
  wire \ubr/sub1/c6 ;
  wire \ubr/sub1/c7 ;
  wire \ubr/sub1/c8 ;
  wire \ubr/sub1/c9 ;
  wire \uctl/mux1_b3_sel_is_3_o ;
  wire \uctl/mux9_b10_sel_is_2_o ;
  wire \uctl/n10 ;
  wire \uctl/n2 ;
  wire \uctl/n24 ;
  wire \uctl/n27 ;
  wire \uctl/n4 ;
  wire \uctl/n53 ;
  wire \uctl/n6 ;
  wire \uctl/n8 ;
  wire \uctl/uctl_brdf ;  // rtl/uart_uctl.v(96)
  wire \uctl/uctl_uartbaud_rd ;  // rtl/uart_uctl.v(62)
  wire \uctl/uctl_uartbaud_wr ;  // rtl/uart_uctl.v(91)
  wire \uctl/uctl_uartctl_rd ;  // rtl/uart_uctl.v(61)
  wire \uctl/uctl_uartctl_wr ;  // rtl/uart_uctl.v(90)
  wire \uctl/uctl_uartflow_rd ;  // rtl/uart_uctl.v(64)
  wire \uctl/uctl_uartflow_wr ;  // rtl/uart_uctl.v(93)
  wire uctl_rx_enb;  // rtl/uart8n1.v(93)
  wire uctl_tx_enb;  // rtl/uart8n1.v(94)
  wire uctl_uartbres_rd;  // rtl/uart8n1.v(95)
  wire \urx/add0/c0 ;
  wire \urx/add0/c1 ;
  wire \urx/add0/c10 ;
  wire \urx/add0/c11 ;
  wire \urx/add0/c12 ;
  wire \urx/add0/c13 ;
  wire \urx/add0/c14 ;
  wire \urx/add0/c15 ;
  wire \urx/add0/c2 ;
  wire \urx/add0/c3 ;
  wire \urx/add0/c4 ;
  wire \urx/add0/c5 ;
  wire \urx/add0/c6 ;
  wire \urx/add0/c7 ;
  wire \urx/add0/c8 ;
  wire \urx/add0/c9 ;
  wire \urx/lt0_c0 ;
  wire \urx/lt0_c1 ;
  wire \urx/lt0_c10 ;
  wire \urx/lt0_c11 ;
  wire \urx/lt0_c12 ;
  wire \urx/lt0_c13 ;
  wire \urx/lt0_c14 ;
  wire \urx/lt0_c15 ;
  wire \urx/lt0_c16 ;
  wire \urx/lt0_c2 ;
  wire \urx/lt0_c3 ;
  wire \urx/lt0_c4 ;
  wire \urx/lt0_c5 ;
  wire \urx/lt0_c6 ;
  wire \urx/lt0_c7 ;
  wire \urx/lt0_c8 ;
  wire \urx/lt0_c9 ;
  wire \urx/mux2_b0_sel_is_3_o ;
  wire \urx/mux2_b1_sel_is_3_o ;
  wire \urx/mux2_b2_sel_is_3_o ;
  wire \urx/mux2_b3_sel_is_3_o ;
  wire \urx/mux2_b4_sel_is_3_o ;
  wire \urx/mux2_b5_sel_is_3_o ;
  wire \urx/mux2_b6_sel_is_3_o ;
  wire \urx/mux2_b7_sel_is_3_o ;
  wire \urx/n14 ;
  wire \urx/rxctl/mux0_b0_sel_is_3_o ;
  wire \urx/rxctl/mux0_b1_sel_is_3_o ;
  wire \urx/rxctl/mux0_b2_sel_is_3_o ;
  wire \urx/rxctl/mux0_b3_sel_is_3_o ;
  wire \urx/rxctl/mux0_b4_sel_is_3_o ;
  wire \urx/rxctl/mux0_b5_sel_is_3_o ;
  wire \urx/rxctl/mux0_b6_sel_is_3_o ;
  wire \urx/rxctl/mux0_b7_sel_is_3_o ;
  wire \urx/rxctl/mux1_b0_sel_is_3_o ;
  wire \urx/rxctl/mux1_b1_sel_is_3_o ;
  wire \urx/rxctl/mux1_b2_sel_is_3_o ;
  wire \urx/rxctl/mux1_b3_sel_is_3_o ;
  wire \urx/rxctl/n113_lutinv ;
  wire \urx/rxctl/n143 ;
  wire \urx/rxctl/urx_cnte_t ;  // rtl/uart_rx_fsm.v(53)
  wire \urx/urx_cnte ;  // rtl/uart_rx.v(60)
  wire \urx/urx_ovfl ;  // rtl/uart_rx.v(47)
  wire urx_rxd;  // rtl/uart8n1.v(123)
  wire urxf_drive;  // rtl/uart8n1.v(92)
  wire \utx/add0/c0 ;
  wire \utx/add0/c1 ;
  wire \utx/add0/c10 ;
  wire \utx/add0/c11 ;
  wire \utx/add0/c12 ;
  wire \utx/add0/c13 ;
  wire \utx/add0/c14 ;
  wire \utx/add0/c15 ;
  wire \utx/add0/c2 ;
  wire \utx/add0/c3 ;
  wire \utx/add0/c4 ;
  wire \utx/add0/c5 ;
  wire \utx/add0/c6 ;
  wire \utx/add0/c7 ;
  wire \utx/add0/c8 ;
  wire \utx/add0/c9 ;
  wire \utx/lt0_c0 ;
  wire \utx/lt0_c1 ;
  wire \utx/lt0_c10 ;
  wire \utx/lt0_c11 ;
  wire \utx/lt0_c12 ;
  wire \utx/lt0_c13 ;
  wire \utx/lt0_c14 ;
  wire \utx/lt0_c15 ;
  wire \utx/lt0_c16 ;
  wire \utx/lt0_c2 ;
  wire \utx/lt0_c3 ;
  wire \utx/lt0_c4 ;
  wire \utx/lt0_c5 ;
  wire \utx/lt0_c6 ;
  wire \utx/lt0_c7 ;
  wire \utx/lt0_c8 ;
  wire \utx/lt0_c9 ;
  wire \utx/n13 ;
  wire \utx/n2 ;
  wire \utx/n8 ;
  wire \utx/txctl/mux0_b1_sel_is_3_o ;
  wire \utx/txctl/mux0_b2_sel_is_3_o ;
  wire \utx/txctl/mux0_b3_sel_is_3_o ;
  wire \utx/txctl/mux0_b4_sel_is_3_o ;
  wire \utx/txctl/mux0_b5_sel_is_3_o ;
  wire \utx/txctl/mux0_b6_sel_is_3_o ;
  wire \utx/txctl/mux0_b7_sel_is_3_o ;
  wire \utx/txctl/mux0_b8_sel_is_3_o ;
  wire \utx/txctl/mux0_b9_sel_is_1_o ;
  wire \utx/txctl/mux1_b0_sel_is_3_o ;
  wire \utx/txctl/mux1_b1_sel_is_3_o ;
  wire \utx/txctl/mux1_b2_sel_is_3_o ;
  wire \utx/txctl/mux1_b3_sel_is_3_o ;
  wire \utx/txctl/n41_lutinv ;
  wire \utx/txctl/sel0_b1_sel_o_lutinv ;  // rtl/uart_tx_fsm.v(84)
  wire \utx/txctl/sel0_b5_sel_o_lutinv ;  // rtl/uart_tx_fsm.v(84)
  wire \utx/utx_ovfl ;  // rtl/uart_tx.v(59)
  wire utx_full;  // rtl/uart8n1.v(79)
  wire utx_full_d;

  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u100 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .o(_al_u100_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u101 (
    .a(\utx/txctl/utx_stat [1]),
    .b(\utx/txctl/utx_stat [2]),
    .c(\utx/txctl/utx_stat [3]),
    .o(_al_u101_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*~(B*A))"),
    .INIT(16'h8fff))
    _al_u102 (
    .a(_al_u100_o),
    .b(_al_u101_o),
    .c(uctl_tx_enb),
    .d(rst_n),
    .o(\utx/n8 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*(A*B*~(C)+~(A)*~(B)*C))"),
    .INIT(32'h00000018))
    _al_u103 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .c(\utx/txctl/utx_stat [1]),
    .d(\utx/txctl/utx_stat [2]),
    .e(\utx/txctl/utx_stat [3]),
    .o(\utx/txctl/sel0_b1_sel_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u104 (
    .a(\utx/txctl/sel0_b1_sel_o_lutinv ),
    .b(rst_n),
    .o(\utx/txctl/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*(B@A))"),
    .INIT(8'h60))
    _al_u105 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .c(rst_n),
    .o(_al_u105_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u106 (
    .a(_al_u105_o),
    .b(\utx/txctl/utx_stat [1]),
    .c(\utx/txctl/utx_stat [2]),
    .d(\utx/txctl/utx_stat [3]),
    .o(\utx/txctl/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u107 (
    .a(\uctl/n27 ),
    .b(_al_u51_o),
    .c(_al_u88_o),
    .d(uctl_tx_enb),
    .e(utx_full),
    .o(\utx/n2 ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u108 (
    .a(\ubr/brcnt [0]),
    .b(\ubr/brcnt [1]),
    .c(\ubr/brcnt [15]),
    .d(\ubr/brcnt [2]),
    .o(_al_u108_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u109 (
    .a(_al_u108_o),
    .b(\ubr/brcnt [10]),
    .c(\ubr/brcnt [11]),
    .d(\ubr/brcnt [12]),
    .e(\ubr/brcnt [13]),
    .o(_al_u109_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u110 (
    .a(\ubr/brcnt [3]),
    .b(\ubr/brcnt [4]),
    .c(\ubr/brcnt [5]),
    .d(\ubr/brcnt [6]),
    .o(_al_u110_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u111 (
    .a(_al_u110_o),
    .b(\ubr/brcnt [14]),
    .c(\ubr/brcnt [16]),
    .d(\ubr/brcnt [17]),
    .e(\ubr/brcnt [18]),
    .o(_al_u111_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u112 (
    .a(_al_u109_o),
    .b(_al_u111_o),
    .c(\ubr/brcnt [7]),
    .d(\ubr/brcnt [8]),
    .e(\ubr/brcnt [9]),
    .o(\ubr/bitr_fovf ));
  AL_MAP_LUT3 #(
    .EQN("(A*B*~(C)+A*~(B)*C+~(A)*B*C+A*B*C)"),
    .INIT(8'he8))
    _al_u113 (
    .a(\urx/sync_rxd [1]),
    .b(\urx/sync_rxd [2]),
    .c(\urx/sync_rxd [3]),
    .o(urx_rxd));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u114 (
    .a(_al_u105_o),
    .b(\utx/txctl/utx_stat [1]),
    .c(\utx/txctl/utx_stat [2]),
    .d(\utx/txctl/utx_stat [3]),
    .o(\utx/txctl/mux0_b6_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~E*(A*B*C*~(D)+~(A)*~(B)*~(C)*D))"),
    .INIT(32'h00000180))
    _al_u115 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .c(\utx/txctl/utx_stat [1]),
    .d(\utx/txctl/utx_stat [2]),
    .e(\utx/txctl/utx_stat [3]),
    .o(_al_u115_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u116 (
    .a(_al_u115_o),
    .b(rst_n),
    .o(\utx/txctl/mux0_b3_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u117 (
    .a(_al_u105_o),
    .b(\utx/txctl/utx_stat [1]),
    .c(\utx/txctl/utx_stat [2]),
    .d(\utx/txctl/utx_stat [3]),
    .o(\utx/txctl/mux0_b4_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*(C@(B*A)))"),
    .INIT(32'h00780000))
    _al_u118 (
    .a(_al_u100_o),
    .b(\utx/txctl/utx_stat [1]),
    .c(\utx/txctl/utx_stat [2]),
    .d(\utx/txctl/utx_stat [3]),
    .e(rst_n),
    .o(\utx/txctl/mux1_b2_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*(A*B*~(C)+~(A)*~(B)*C))"),
    .INIT(32'h00001800))
    _al_u119 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .c(\utx/txctl/utx_stat [1]),
    .d(\utx/txctl/utx_stat [2]),
    .e(\utx/txctl/utx_stat [3]),
    .o(\utx/txctl/sel0_b5_sel_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u120 (
    .a(\utx/txctl/sel0_b5_sel_o_lutinv ),
    .b(rst_n),
    .o(\utx/txctl/mux0_b5_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfffe7fff))
    _al_u121 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .c(\utx/txctl/utx_stat [1]),
    .d(\utx/txctl/utx_stat [2]),
    .e(\utx/txctl/utx_stat [3]),
    .o(_al_u121_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u122 (
    .a(_al_u121_o),
    .b(rst_n),
    .o(\utx/txctl/mux0_b7_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u123 (
    .a(_al_u105_o),
    .b(_al_u101_o),
    .o(\utx/txctl/mux0_b8_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffe07fff))
    _al_u124 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .c(\utx/txctl/utx_stat [1]),
    .d(\utx/txctl/utx_stat [2]),
    .e(\utx/txctl/utx_stat [3]),
    .o(_al_u124_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u125 (
    .a(_al_u124_o),
    .b(rst_n),
    .o(\utx/txctl/mux1_b3_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffe78787))
    _al_u126 (
    .a(\utx/utx_ovfl ),
    .b(\utx/txctl/utx_stat [0]),
    .c(\utx/txctl/utx_stat [1]),
    .d(\utx/txctl/utx_stat [2]),
    .e(\utx/txctl/utx_stat [3]),
    .o(_al_u126_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u127 (
    .a(_al_u126_o),
    .b(rst_n),
    .o(\utx/txctl/mux1_b1_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u128 (
    .a(\utx/n2 ),
    .b(utx_full),
    .o(utx_full_d));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u129 (
    .a(\utx/uarttdat [0]),
    .b(\utx/uarttdat [3]),
    .c(\utx/utx_tran [1]),
    .d(\utx/utx_tran [4]),
    .o(_al_u129_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u130 (
    .a(_al_u129_o),
    .b(\utx/uarttdat [1]),
    .c(\utx/uarttdat [2]),
    .d(\utx/utx_tran [2]),
    .e(\utx/utx_tran [3]),
    .o(_al_u130_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u131 (
    .a(_al_u130_o),
    .b(\utx/uarttdat [4]),
    .c(\utx/uarttdat [5]),
    .d(\utx/utx_tran [5]),
    .e(\utx/utx_tran [6]),
    .o(_al_u131_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u132 (
    .a(_al_u131_o),
    .b(\utx/uarttdat [6]),
    .c(\utx/uarttdat [7]),
    .d(\utx/utx_tran [7]),
    .e(\utx/utx_tran [8]),
    .o(_al_u132_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*A)"),
    .INIT(4'hd))
    _al_u133 (
    .a(_al_u132_o),
    .b(\utx/utx_tran [9]),
    .o(uart_txd));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u134 (
    .a(\ubr/fsm/stat [1]),
    .b(\ubr/fsm/stat [2]),
    .c(\ubr/fsm/stat [3]),
    .o(_al_u134_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u135 (
    .a(\ubr/bitr_fovf ),
    .b(_al_u134_o),
    .c(\ubr/fsm/stat [0]),
    .o(\ubr/fsm/n97_neg ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u136 (
    .a(uartbaud[11]),
    .b(uartbaud[12]),
    .c(\urx/bcnt [10]),
    .d(\urx/bcnt [11]),
    .o(_al_u136_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D@C)*~(E@B))"),
    .INIT(32'h80082002))
    _al_u137 (
    .a(_al_u136_o),
    .b(uartbaud[10]),
    .c(uartbaud[9]),
    .d(\urx/bcnt [8]),
    .e(\urx/bcnt [9]),
    .o(_al_u137_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u138 (
    .a(uartbaud[13]),
    .b(uartbaud[14]),
    .c(\urx/bcnt [12]),
    .d(\urx/bcnt [13]),
    .o(_al_u138_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*A*~(C@B))"),
    .INIT(16'h0082))
    _al_u139 (
    .a(_al_u138_o),
    .b(uartbaud[15]),
    .c(\urx/bcnt [14]),
    .d(\urx/bcnt [15]),
    .o(_al_u139_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u140 (
    .a(uartbaud[5]),
    .b(uartbaud[6]),
    .c(\urx/bcnt [4]),
    .d(\urx/bcnt [5]),
    .o(_al_u140_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u141 (
    .a(_al_u140_o),
    .b(uartbaud[7]),
    .c(uartbaud[8]),
    .d(\urx/bcnt [6]),
    .e(\urx/bcnt [7]),
    .o(_al_u141_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    _al_u142 (
    .a(uartbaud[3]),
    .b(uartbaud[4]),
    .c(\urx/bcnt [2]),
    .d(\urx/bcnt [3]),
    .o(_al_u142_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E@C)*~(D@B))"),
    .INIT(32'h80200802))
    _al_u143 (
    .a(_al_u142_o),
    .b(uartbaud[1]),
    .c(uartbaud[2]),
    .d(\urx/bcnt [0]),
    .e(\urx/bcnt [1]),
    .o(_al_u143_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u144 (
    .a(_al_u137_o),
    .b(_al_u139_o),
    .c(_al_u141_o),
    .d(_al_u143_o),
    .o(_al_u144_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u145 (
    .a(_al_u144_o),
    .b(\urx/rxctl/urx_stat [0]),
    .o(_al_u145_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u146 (
    .a(_al_u145_o),
    .b(rst_n),
    .o(_al_u146_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u147 (
    .a(\urx/rxctl/urx_stat [1]),
    .b(\urx/rxctl/urx_stat [2]),
    .o(_al_u147_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u148 (
    .a(_al_u146_o),
    .b(_al_u147_o),
    .c(\urx/rxctl/urx_stat [3]),
    .o(\urx/rxctl/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u149 (
    .a(\urx/rxctl/urx_stat [2]),
    .b(\urx/rxctl/urx_stat [3]),
    .o(_al_u149_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u150 (
    .a(_al_u146_o),
    .b(_al_u149_o),
    .c(\urx/rxctl/urx_stat [1]),
    .o(\urx/rxctl/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u151 (
    .a(_al_u146_o),
    .b(_al_u149_o),
    .c(\urx/rxctl/urx_stat [1]),
    .o(\urx/rxctl/mux0_b4_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u152 (
    .a(_al_u146_o),
    .b(\urx/rxctl/urx_stat [1]),
    .c(\urx/rxctl/urx_stat [2]),
    .d(\urx/rxctl/urx_stat [3]),
    .o(\urx/rxctl/mux0_b6_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u153 (
    .a(_al_u144_o),
    .b(\urx/rxctl/urx_stat [0]),
    .o(_al_u153_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u154 (
    .a(_al_u153_o),
    .b(_al_u147_o),
    .c(\urx/rxctl/urx_stat [3]),
    .d(rst_n),
    .o(\urx/rxctl/mux0_b7_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u155 (
    .a(_al_u153_o),
    .b(_al_u149_o),
    .c(\urx/rxctl/urx_stat [1]),
    .d(rst_n),
    .o(\urx/rxctl/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u156 (
    .a(_al_u153_o),
    .b(_al_u149_o),
    .c(\urx/rxctl/urx_stat [1]),
    .d(rst_n),
    .o(\urx/rxctl/mux0_b3_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*A)"),
    .INIT(32'h02000000))
    _al_u157 (
    .a(_al_u153_o),
    .b(\urx/rxctl/urx_stat [1]),
    .c(\urx/rxctl/urx_stat [2]),
    .d(\urx/rxctl/urx_stat [3]),
    .e(rst_n),
    .o(\urx/rxctl/mux0_b5_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u158 (
    .a(_al_u145_o),
    .b(_al_u147_o),
    .c(\urx/rxctl/urx_stat [3]),
    .o(\urx/rxctl/n113_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u159 (
    .a(\urx/rxctl/n113_lutinv ),
    .b(urx_rxd),
    .c(urxf_full),
    .o(\urx/rxctl/n143 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u160 (
    .a(\ubr/bitr_ovf ),
    .b(\ubr/bitr_fovf ),
    .o(\ubr/fsm/n28_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u161 (
    .a(\ubr/n11 ),
    .b(\ubr/n12 ),
    .o(_al_u161_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u162 (
    .a(\ubr/fsm/n28_lutinv ),
    .b(_al_u161_o),
    .o(_al_u162_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u163 (
    .a(\ubr/fsm/stat [2]),
    .b(\ubr/fsm/stat [3]),
    .o(_al_u163_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u164 (
    .a(_al_u163_o),
    .b(\ubr/fsm/stat [1]),
    .o(_al_u164_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u165 (
    .a(\ubr/bitr_tgl ),
    .b(\ubr/fsm/stat [0]),
    .o(_al_u165_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u166 (
    .a(_al_u162_o),
    .b(_al_u164_o),
    .c(_al_u165_o),
    .o(\ubr/fsm/bitr_late_t ));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u167 (
    .a(\ubr/fsm/n97_neg ),
    .b(\uctl/uctl_uartctl_wr ),
    .c(bdatw[5]),
    .o(\ubr/_al_n0_en ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u168 (
    .a(_al_u144_o),
    .b(\urx/urx_ovfl ),
    .o(_al_u168_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*(A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D))"),
    .INIT(32'h00006780))
    _al_u169 (
    .a(_al_u168_o),
    .b(\urx/rxctl/urx_stat [0]),
    .c(\urx/rxctl/urx_stat [1]),
    .d(\urx/rxctl/urx_stat [2]),
    .e(\urx/rxctl/urx_stat [3]),
    .o(_al_u169_o));
  AL_MAP_LUT5 #(
    .EQN("(C*((B*~A)*D*~(E)+~((B*~A))*~(D)*E))"),
    .INIT(32'h00b04000))
    _al_u170 (
    .a(_al_u144_o),
    .b(\urx/urx_ovfl ),
    .c(_al_u149_o),
    .d(\urx/rxctl/urx_stat [0]),
    .e(\urx/rxctl/urx_stat [1]),
    .o(_al_u170_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u171 (
    .a(_al_u169_o),
    .b(_al_u170_o),
    .c(rst_n),
    .o(\urx/rxctl/mux1_b2_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u172 (
    .a(_al_u168_o),
    .b(\urx/rxctl/urx_stat [0]),
    .o(_al_u172_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffc05fff))
    _al_u173 (
    .a(_al_u172_o),
    .b(_al_u145_o),
    .c(\urx/rxctl/urx_stat [1]),
    .d(\urx/rxctl/urx_stat [2]),
    .e(\urx/rxctl/urx_stat [3]),
    .o(_al_u173_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u174 (
    .a(_al_u173_o),
    .b(rst_n),
    .o(\urx/rxctl/mux1_b3_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(B*(C@A))"),
    .INIT(8'h48))
    _al_u175 (
    .a(_al_u168_o),
    .b(_al_u149_o),
    .c(\urx/rxctl/urx_stat [0]),
    .o(_al_u175_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*(B@A))"),
    .INIT(32'h00060000))
    _al_u176 (
    .a(_al_u168_o),
    .b(\urx/rxctl/urx_stat [0]),
    .c(\urx/rxctl/urx_stat [1]),
    .d(\urx/rxctl/urx_stat [2]),
    .e(\urx/rxctl/urx_stat [3]),
    .o(_al_u176_o));
  AL_MAP_LUT5 #(
    .EQN("(C*(~(A)*B*~(D)*~(E)+A*B*~(D)*~(E)+~(A)*~(B)*D*~(E)+A*~(B)*D*~(E)+A*B*D*~(E)+~(A)*B*~(D)*E+~(A)*~(B)*D*E+~(A)*B*D*E))"),
    .INIT(32'h5040b0c0))
    _al_u177 (
    .a(_al_u144_o),
    .b(\urx/urx_ovfl ),
    .c(_al_u147_o),
    .d(\urx/rxctl/urx_stat [0]),
    .e(\urx/rxctl/urx_stat [3]),
    .o(_al_u177_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u178 (
    .a(urx_rxd),
    .b(uctl_rx_enb),
    .c(\urx/rxctl/urx_stat [1]),
    .d(\urx/rxctl/urx_stat [2]),
    .e(\urx/rxctl/urx_stat [3]),
    .o(_al_u178_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~D*~C*~B*~A))"),
    .INIT(32'hfffe0000))
    _al_u179 (
    .a(_al_u175_o),
    .b(_al_u176_o),
    .c(_al_u177_o),
    .d(_al_u178_o),
    .e(rst_n),
    .o(\urx/rxctl/mux1_b0_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(32'h003a0000))
    _al_u180 (
    .a(_al_u172_o),
    .b(_al_u145_o),
    .c(\urx/rxctl/urx_stat [1]),
    .d(\urx/rxctl/urx_stat [2]),
    .e(\urx/rxctl/urx_stat [3]),
    .o(_al_u180_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u181 (
    .a(urx_rxd),
    .b(uctl_rx_enb),
    .c(\urx/rxctl/urx_stat [0]),
    .o(_al_u181_o));
  AL_MAP_LUT4 #(
    .EQN("(A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D)"),
    .INIT(16'h0fd8))
    _al_u182 (
    .a(\urx/rxctl/urx_stat [0]),
    .b(\urx/rxctl/urx_stat [1]),
    .c(\urx/rxctl/urx_stat [2]),
    .d(\urx/rxctl/urx_stat [3]),
    .o(_al_u182_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~(~B*~A))"),
    .INIT(16'h000e))
    _al_u183 (
    .a(_al_u181_o),
    .b(\urx/rxctl/urx_stat [1]),
    .c(\urx/rxctl/urx_stat [2]),
    .d(_al_u182_o),
    .o(_al_u183_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C*(D@B)))"),
    .INIT(32'h45155555))
    _al_u184 (
    .a(_al_u183_o),
    .b(_al_u168_o),
    .c(_al_u149_o),
    .d(\urx/rxctl/urx_stat [0]),
    .e(\urx/rxctl/urx_stat [1]),
    .o(_al_u184_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(~E*~C*B*~A))"),
    .INIT(32'hff00fb00))
    _al_u185 (
    .a(_al_u180_o),
    .b(_al_u184_o),
    .c(_al_u170_o),
    .d(rst_n),
    .e(_al_u177_o),
    .o(\urx/rxctl/mux1_b1_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u186 (
    .a(\ubr/fsm/stat [2]),
    .b(\ubr/fsm/stat [3]),
    .o(_al_u186_o));
  AL_MAP_LUT4 #(
    .EQN("(C*A*(D@B))"),
    .INIT(16'h2080))
    _al_u187 (
    .a(_al_u162_o),
    .b(\ubr/bitr_tgl ),
    .c(_al_u186_o),
    .d(\ubr/fsm/stat [0]),
    .o(_al_u187_o));
  AL_MAP_LUT5 #(
    .EQN("(C*A*(B*D*~(E)+~(B)*~(D)*E))"),
    .INIT(32'h00208000))
    _al_u188 (
    .a(_al_u162_o),
    .b(\ubr/bitr_tgl ),
    .c(_al_u186_o),
    .d(\ubr/fsm/stat [0]),
    .e(\ubr/fsm/stat [1]),
    .o(_al_u188_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*~A))"),
    .INIT(8'hc8))
    _al_u189 (
    .a(_al_u161_o),
    .b(_al_u134_o),
    .c(\ubr/fsm/stat [0]),
    .o(_al_u189_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*A*~(D*B))"),
    .INIT(16'h020a))
    _al_u190 (
    .a(_al_u189_o),
    .b(\ubr/bitr_fovf ),
    .c(_al_u165_o),
    .d(\ubr/fsm/stat [0]),
    .o(_al_u190_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u191 (
    .a(\ubr/fsm/n28_lutinv ),
    .b(_al_u186_o),
    .c(\ubr/fsm/stat [0]),
    .d(\ubr/fsm/stat [1]),
    .o(_al_u191_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u192 (
    .a(\ubr/fsm/stat [1]),
    .b(\ubr/fsm/stat [2]),
    .c(\ubr/fsm/stat [3]),
    .o(\ubr/fsm/n118_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u193 (
    .a(\ubr/fsm/n28_lutinv ),
    .b(_al_u165_o),
    .c(\ubr/fsm/n118_lutinv ),
    .o(\ubr/fsm/n38_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u194 (
    .a(_al_u187_o),
    .b(_al_u188_o),
    .c(_al_u190_o),
    .d(_al_u191_o),
    .e(\ubr/fsm/n38_lutinv ),
    .o(_al_u194_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*A))"),
    .INIT(8'hd0))
    _al_u195 (
    .a(_al_u194_o),
    .b(\ubr/fsm/bitr_late_t ),
    .c(rst_n),
    .o(\ubr/fsm/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u196 (
    .a(_al_u186_o),
    .b(\ubr/fsm/stat [1]),
    .o(_al_u196_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u197 (
    .a(_al_u162_o),
    .b(_al_u165_o),
    .c(_al_u196_o),
    .o(\ubr/fsm/n98_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~B*~A*~(D*C)))"),
    .INIT(32'hfeee0000))
    _al_u198 (
    .a(\ubr/fsm/n98_lutinv ),
    .b(_al_u190_o),
    .c(_al_u162_o),
    .d(_al_u163_o),
    .e(rst_n),
    .o(\ubr/fsm/mux0_b3_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*~A)"),
    .INIT(16'h0040))
    _al_u199 (
    .a(urx_rxd),
    .b(\ubr/fsm/n118_lutinv ),
    .c(\ubr/bitr_tgl ),
    .d(\ubr/fsm/stat [0]),
    .o(\ubr/fsm/n23_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u200 (
    .a(\ubr/bitr_tgl ),
    .b(\ubr/fsm/stat [0]),
    .c(\ubr/fsm/stat [2]),
    .d(\ubr/fsm/stat [3]),
    .o(_al_u200_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(C*~(~D*~A)))"),
    .INIT(16'h0313))
    _al_u201 (
    .a(\ubr/bitr_fovf ),
    .b(\ubr/fsm/n23_lutinv ),
    .c(_al_u200_o),
    .d(\ubr/fsm/stat [1]),
    .o(_al_u201_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~D*C*A))"),
    .INIT(16'hcc4c))
    _al_u202 (
    .a(\ubr/fsm/n28_lutinv ),
    .b(_al_u201_o),
    .c(\ubr/fsm/n118_lutinv ),
    .d(\ubr/bitr_tgl ),
    .o(_al_u202_o));
  AL_MAP_LUT5 #(
    .EQN("((E@D)*(C@(B*A)))"),
    .INIT(32'h00787800))
    _al_u203 (
    .a(\ubr/bitr_tgl ),
    .b(\ubr/fsm/stat [0]),
    .c(\ubr/fsm/stat [1]),
    .d(\ubr/fsm/stat [2]),
    .e(\ubr/fsm/stat [3]),
    .o(_al_u203_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(A*~(C*B)))"),
    .INIT(16'hd500))
    _al_u204 (
    .a(_al_u202_o),
    .b(_al_u162_o),
    .c(_al_u203_o),
    .d(rst_n),
    .o(\ubr/fsm/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u205 (
    .a(_al_u161_o),
    .b(_al_u196_o),
    .c(\ubr/fsm/stat [0]),
    .o(_al_u205_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E))"),
    .INIT(32'ha000c000))
    _al_u206 (
    .a(\ubr/fsm/n28_lutinv ),
    .b(urx_rxd),
    .c(\ubr/fsm/n118_lutinv ),
    .d(\ubr/bitr_tgl ),
    .e(\ubr/fsm/stat [0]),
    .o(_al_u206_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(~E*D*~C))"),
    .INIT(32'h11111011))
    _al_u207 (
    .a(_al_u205_o),
    .b(_al_u206_o),
    .c(\ubr/fsm/n28_lutinv ),
    .d(_al_u186_o),
    .e(\ubr/fsm/stat [0]),
    .o(_al_u207_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(C*~(D*~B)))"),
    .INIT(16'h2a0a))
    _al_u208 (
    .a(_al_u207_o),
    .b(\ubr/bitr_fovf ),
    .c(_al_u134_o),
    .d(\ubr/fsm/stat [0]),
    .o(_al_u208_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(B*A))"),
    .INIT(16'h0070))
    _al_u209 (
    .a(\ubr/fsm/n28_lutinv ),
    .b(_al_u161_o),
    .c(_al_u163_o),
    .d(\ubr/fsm/stat [0]),
    .o(\ubr/fsm/n177_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u210 (
    .a(_al_u165_o),
    .b(urx_rxd),
    .c(\ubr/fsm/stat [1]),
    .d(\ubr/fsm/stat [2]),
    .e(\ubr/fsm/stat [3]),
    .o(\ubr/fsm/n18_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("~(E*~D*~C*~B*A)"),
    .INIT(32'hfffdffff))
    _al_u211 (
    .a(_al_u208_o),
    .b(\ubr/fsm/n177_lutinv ),
    .c(\ubr/fsm/n18_lutinv ),
    .d(\ubr/fsm/n23_lutinv ),
    .e(rst_n),
    .o(\ubr/n13 ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*~(~C*~B)))"),
    .INIT(16'h02aa))
    _al_u212 (
    .a(_al_u105_o),
    .b(\utx/txctl/utx_stat [1]),
    .c(\utx/txctl/utx_stat [2]),
    .d(\utx/txctl/utx_stat [3]),
    .o(_al_u212_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(B@(C*D*~(E)+C*~(D)*E+~(C)*D*E+C*D*E)))"),
    .INIT(32'h22282888))
    _al_u213 (
    .a(\uctl/uartflow [1]),
    .b(\uctl/uartflow [3]),
    .c(\uctl/uctl_cts_sft [1]),
    .d(\uctl/uctl_cts_sft [2]),
    .e(\uctl/uctl_cts_sft [3]),
    .o(_al_u213_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u214 (
    .a(_al_u213_o),
    .b(uctl_tx_enb),
    .c(utx_full),
    .o(_al_u214_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u215 (
    .a(\utx/txctl/utx_stat [0]),
    .b(\utx/txctl/utx_stat [1]),
    .c(\utx/txctl/utx_stat [2]),
    .d(\utx/txctl/utx_stat [3]),
    .o(\utx/txctl/n41_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+A*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hca8a))
    _al_u216 (
    .a(_al_u212_o),
    .b(_al_u214_o),
    .c(\utx/txctl/n41_lutinv ),
    .d(rst_n),
    .o(\utx/txctl/mux1_b0_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*~C*~B))"),
    .INIT(16'h5554))
    _al_u217 (
    .a(\urx/rxctl/n113_lutinv ),
    .b(_al_u183_o),
    .c(_al_u182_o),
    .d(_al_u149_o),
    .o(\urx/rxctl/urx_cnte_t ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u218 (
    .a(\ubr/fsm/stat [1]),
    .b(\ubr/fsm/stat [2]),
    .c(\ubr/fsm/stat [3]),
    .o(_al_u218_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u219 (
    .a(\ubr/bitr_fovf ),
    .b(_al_u218_o),
    .c(\ubr/bitr_tgl ),
    .o(_al_u219_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u220 (
    .a(\ubr/fsm/stat [0]),
    .b(\ubr/fsm/stat [1]),
    .o(_al_u220_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u221 (
    .a(_al_u189_o),
    .b(_al_u219_o),
    .c(_al_u220_o),
    .d(\ubr/fsm/n118_lutinv ),
    .o(_al_u221_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u222 (
    .a(_al_u221_o),
    .b(_al_u163_o),
    .c(_al_u186_o),
    .o(_al_u222_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u223 (
    .a(_al_u200_o),
    .b(rst_n),
    .o(_al_u223_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*A*~(E*C))"),
    .INIT(32'h00020022))
    _al_u224 (
    .a(_al_u223_o),
    .b(\ubr/fsm/n97_neg ),
    .c(_al_u219_o),
    .d(\ubr/fsm/n18_lutinv ),
    .e(urx_rxd),
    .o(_al_u224_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u225 (
    .a(_al_u188_o),
    .b(\ubr/fsm/n98_lutinv ),
    .c(_al_u224_o),
    .o(_al_u225_o));
  AL_MAP_LUT4 #(
    .EQN("(C*A*~(D@B))"),
    .INIT(16'h8020))
    _al_u226 (
    .a(_al_u162_o),
    .b(\ubr/bitr_tgl ),
    .c(_al_u163_o),
    .d(\ubr/fsm/stat [0]),
    .o(_al_u226_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(~D*B))"),
    .INIT(16'h0501))
    _al_u227 (
    .a(_al_u226_o),
    .b(_al_u191_o),
    .c(\ubr/fsm/n177_lutinv ),
    .d(\ubr/bitr_tgl ),
    .o(_al_u227_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u228 (
    .a(_al_u222_o),
    .b(_al_u225_o),
    .c(_al_u227_o),
    .d(_al_u207_o),
    .o(\ubr/fsm/mux0_b0_sel_is_1_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*~(~C*~B*~A)))"),
    .INIT(32'h01ff0000))
    _al_u229 (
    .a(_al_u100_o),
    .b(\utx/txctl/utx_stat [1]),
    .c(\utx/txctl/utx_stat [2]),
    .d(\utx/txctl/utx_stat [3]),
    .e(rst_n),
    .o(_al_u229_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u230 (
    .a(_al_u229_o),
    .b(_al_u214_o),
    .c(\utx/txctl/n41_lutinv ),
    .o(\utx/txctl/mux0_b9_sel_is_1_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u231 (
    .a(\utx/utx_ovfl ),
    .b(rst_n),
    .o(_al_u231_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*(B*~(C)*~(D)*~(E)+~(B)*C*~(D)*~(E)+B*C*~(D)*~(E)+~(B)*~(C)*D*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+B*C*D*~(E)+~(B)*~(C)*~(D)*E+B*~(C)*~(D)*E+~(B)*C*~(D)*E))"),
    .INIT(32'hffd55557))
    _al_u232 (
    .a(_al_u231_o),
    .b(\utx/txctl/utx_stat [0]),
    .c(\utx/txctl/utx_stat [1]),
    .d(\utx/txctl/utx_stat [2]),
    .e(\utx/txctl/utx_stat [3]),
    .o(\utx/n13 ));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u233 (
    .a(\ubr/fsm/n97_neg ),
    .o(\ubr/fsm/n97 ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u27 (
    .a(\ubr/bitr_sft [2]),
    .b(\ubr/bitr_sft [3]),
    .o(\ubr/bitr_tgl ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u28 (
    .a(\ubr/n17 [0]),
    .b(\ubr/brcnt [2]),
    .c(\ubr/brcnt [3]),
    .o(\ubr/n18 [0]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u29 (
    .a(\ubr/n17 [1]),
    .b(\ubr/brcnt [2]),
    .c(\ubr/brcnt [4]),
    .o(\ubr/n18 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u30 (
    .a(\ubr/n17 [10]),
    .b(\ubr/brcnt [13]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [10]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u31 (
    .a(\ubr/n17 [11]),
    .b(\ubr/brcnt [14]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u32 (
    .a(\ubr/n17 [12]),
    .b(\ubr/brcnt [15]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u33 (
    .a(\ubr/n17 [13]),
    .b(\ubr/brcnt [16]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u34 (
    .a(\ubr/n17 [14]),
    .b(\ubr/brcnt [17]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u35 (
    .a(\ubr/n17 [15]),
    .b(\ubr/brcnt [18]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [15]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u36 (
    .a(\ubr/n17 [2]),
    .b(\ubr/brcnt [2]),
    .c(\ubr/brcnt [5]),
    .o(\ubr/n18 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u37 (
    .a(\ubr/n17 [3]),
    .b(\ubr/brcnt [2]),
    .c(\ubr/brcnt [6]),
    .o(\ubr/n18 [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u38 (
    .a(\ubr/n17 [4]),
    .b(\ubr/brcnt [2]),
    .c(\ubr/brcnt [7]),
    .o(\ubr/n18 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u39 (
    .a(\ubr/n17 [5]),
    .b(\ubr/brcnt [2]),
    .c(\ubr/brcnt [8]),
    .o(\ubr/n18 [5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u40 (
    .a(\ubr/n17 [6]),
    .b(\ubr/brcnt [2]),
    .c(\ubr/brcnt [9]),
    .o(\ubr/n18 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u41 (
    .a(\ubr/n17 [7]),
    .b(\ubr/brcnt [10]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u42 (
    .a(\ubr/n17 [8]),
    .b(\ubr/brcnt [11]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u43 (
    .a(\ubr/n17 [9]),
    .b(\ubr/brcnt [12]),
    .c(\ubr/brcnt [2]),
    .o(\ubr/n18 [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u44 (
    .a(\uctl/uartctl [2]),
    .b(\uctl/uctl_brdf ),
    .o(uart_brdr));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u45 (
    .a(\uctl/uartctl [3]),
    .b(rst_n),
    .o(urxf_frst));
  AL_MAP_LUT2 #(
    .EQN("~(B*~A)"),
    .INIT(4'hb))
    _al_u46 (
    .a(\ubr/bitr_tgl ),
    .b(rst_n),
    .o(\ubr/n2 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u47 (
    .a(\uctl/uartflow [0]),
    .b(rst_n),
    .o(_al_u47_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h6666cce4))
    _al_u48 (
    .a(_al_u47_o),
    .b(\uctl/uartflow [2]),
    .c(uart_rts),
    .d(urxf_aempty),
    .e(urxf_afull),
    .o(\uctl/n53 ));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*~A)"),
    .INIT(8'hbf))
    _al_u49 (
    .a(\urx/urx_ovfl ),
    .b(\urx/urx_cnte ),
    .c(rst_n),
    .o(\urx/n14 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u50 (
    .a(bcmdr),
    .b(bcs_uart_n),
    .o(\uctl/n2 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u51 (
    .a(badr[1]),
    .b(badr[0]),
    .o(_al_u51_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u52 (
    .a(\uctl/n2 ),
    .b(_al_u51_o),
    .c(badr[3]),
    .d(badr[2]),
    .o(\uctl/n4 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u53 (
    .a(bcmdw),
    .b(bcs_uart_n),
    .c(brdy),
    .o(\uctl/n27 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u54 (
    .a(\uctl/n27 ),
    .b(_al_u51_o),
    .c(badr[3]),
    .d(badr[2]),
    .o(\uctl/uctl_uartctl_wr ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u55 (
    .a(\uctl/n2 ),
    .b(_al_u51_o),
    .c(badr[3]),
    .d(badr[2]),
    .o(\uctl/n8 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u56 (
    .a(\uctl/n27 ),
    .b(_al_u51_o),
    .c(badr[3]),
    .d(badr[2]),
    .o(\uctl/uctl_uartflow_wr ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u57 (
    .a(\uctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\uctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u58 (
    .a(\uctl/n2 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\uctl/n6 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*A)"),
    .INIT(32'h00000200))
    _al_u59 (
    .a(\uctl/n27 ),
    .b(badr[3]),
    .c(badr[2]),
    .d(badr[1]),
    .e(badr[0]),
    .o(\uctl/uctl_uartbaud_wr ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u60 (
    .a(\uctl/uctl_uartctl_wr ),
    .b(rst_n),
    .o(\uctl/mux1_b3_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u61 (
    .a(urxf_drive),
    .b(urxf_dato[7]),
    .o(\buso/n0 [7]));
  AL_MAP_LUT5 #(
    .EQN("(~A*(~(D*B)*~(E)*~(C)+~(D*B)*E*~(C)+~(~(D*B))*E*C+~(D*B)*E*C))"),
    .INIT(32'h51550105))
    _al_u62 (
    .a(\buso/n0 [7]),
    .b(\uctl/uctl_cts_sft [1]),
    .c(\uctl/uctl_uartctl_rd ),
    .d(\uctl/uctl_uartflow_rd ),
    .e(urxf_empty),
    .o(_al_u62_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u63 (
    .a(\uctl/uctl_uartbaud_rd ),
    .b(\uctl/uctl_uartctl_rd ),
    .c(\uctl/uctl_uartflow_rd ),
    .o(\uctl/mux9_b10_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u64 (
    .a(_al_u62_o),
    .b(\uctl/mux9_b10_sel_is_2_o ),
    .c(\ubr/uartbres [7]),
    .d(uartbaud[7]),
    .e(uctl_uartbres_rd),
    .o(bdatr[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u65 (
    .a(urxf_drive),
    .b(urxf_dato[6]),
    .o(\buso/n0 [6]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*B)*~(E)*~(C)+(D*B)*E*~(C)+~((D*B))*E*C+(D*B)*E*C))"),
    .INIT(32'h01055155))
    _al_u66 (
    .a(\buso/n0 [6]),
    .b(uart_rts),
    .c(\uctl/uctl_uartctl_rd ),
    .d(\uctl/uctl_uartflow_rd ),
    .e(urxf_full),
    .o(_al_u66_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u67 (
    .a(_al_u66_o),
    .b(\uctl/mux9_b10_sel_is_2_o ),
    .c(\ubr/uartbres [6]),
    .d(uartbaud[6]),
    .e(uctl_uartbres_rd),
    .o(bdatr[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u68 (
    .a(urxf_drive),
    .b(urxf_dato[3]),
    .o(\buso/n0 [3]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*C)*~(B)*~(D)+(E*C)*B*~(D)+~((E*C))*B*D+(E*C)*B*D))"),
    .INIT(32'h11051155))
    _al_u69 (
    .a(\buso/n0 [3]),
    .b(\uctl/uartctl [3]),
    .c(\uctl/uartflow [3]),
    .d(\uctl/uctl_uartctl_rd ),
    .e(\uctl/uctl_uartflow_rd ),
    .o(_al_u69_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u70 (
    .a(_al_u69_o),
    .b(\uctl/mux9_b10_sel_is_2_o ),
    .c(\ubr/uartbres [3]),
    .d(uartbaud[3]),
    .e(uctl_uartbres_rd),
    .o(bdatr[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u71 (
    .a(urxf_drive),
    .b(urxf_dato[2]),
    .o(\buso/n0 [2]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*C)*~(B)*~(D)+(E*C)*B*~(D)+~((E*C))*B*D+(E*C)*B*D))"),
    .INIT(32'h11051155))
    _al_u72 (
    .a(\buso/n0 [2]),
    .b(\uctl/uartctl [2]),
    .c(\uctl/uartflow [2]),
    .d(\uctl/uctl_uartctl_rd ),
    .e(\uctl/uctl_uartflow_rd ),
    .o(_al_u72_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u73 (
    .a(_al_u72_o),
    .b(\uctl/mux9_b10_sel_is_2_o ),
    .c(\ubr/uartbres [2]),
    .d(uartbaud[2]),
    .e(uctl_uartbres_rd),
    .o(bdatr[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u74 (
    .a(urxf_drive),
    .b(urxf_dato[1]),
    .o(\buso/n0 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*C)*~(B)*~(D)+(E*C)*B*~(D)+~((E*C))*B*D+(E*C)*B*D))"),
    .INIT(32'h11051155))
    _al_u75 (
    .a(\buso/n0 [1]),
    .b(uctl_rx_enb),
    .c(\uctl/uartflow [1]),
    .d(\uctl/uctl_uartctl_rd ),
    .e(\uctl/uctl_uartflow_rd ),
    .o(_al_u75_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u76 (
    .a(_al_u75_o),
    .b(\uctl/mux9_b10_sel_is_2_o ),
    .c(\ubr/uartbres [1]),
    .d(uartbaud[1]),
    .e(uctl_uartbres_rd),
    .o(bdatr[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u77 (
    .a(urxf_drive),
    .b(urxf_dato[0]),
    .o(\buso/n0 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*C)*~(B)*~(D)+(E*C)*B*~(D)+~((E*C))*B*D+(E*C)*B*D))"),
    .INIT(32'h11051155))
    _al_u78 (
    .a(\buso/n0 [0]),
    .b(uctl_tx_enb),
    .c(\uctl/uartflow [0]),
    .d(\uctl/uctl_uartctl_rd ),
    .e(\uctl/uctl_uartflow_rd ),
    .o(_al_u78_o));
  AL_MAP_LUT5 #(
    .EQN("~(A*~(E*C)*~(D*B))"),
    .INIT(32'hfdf5dd55))
    _al_u79 (
    .a(_al_u78_o),
    .b(\uctl/mux9_b10_sel_is_2_o ),
    .c(\ubr/uartbres [0]),
    .d(uartbaud[0]),
    .e(uctl_uartbres_rd),
    .o(bdatr[0]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u80 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [9]),
    .c(uartbaud[9]),
    .d(uctl_uartbres_rd),
    .o(bdatr[9]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u81 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [8]),
    .c(uartbaud[8]),
    .d(uctl_uartbres_rd),
    .o(bdatr[8]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u82 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [15]),
    .c(uartbaud[15]),
    .d(uctl_uartbres_rd),
    .o(bdatr[15]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u83 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [14]),
    .c(uartbaud[14]),
    .d(uctl_uartbres_rd),
    .o(bdatr[14]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u84 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [13]),
    .c(uartbaud[13]),
    .d(uctl_uartbres_rd),
    .o(bdatr[13]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u85 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [12]),
    .c(uartbaud[12]),
    .d(uctl_uartbres_rd),
    .o(bdatr[12]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u86 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [11]),
    .c(uartbaud[11]),
    .d(uctl_uartbres_rd),
    .o(bdatr[11]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u87 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(\ubr/uartbres [10]),
    .c(uartbaud[10]),
    .d(uctl_uartbres_rd),
    .o(bdatr[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u88 (
    .a(badr[3]),
    .b(badr[2]),
    .o(_al_u88_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*B*A)"),
    .INIT(32'h00800000))
    _al_u89 (
    .a(\uctl/n2 ),
    .b(_al_u88_o),
    .c(badr[1]),
    .d(badr[0]),
    .e(brdy),
    .o(\uctl/n24 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u90 (
    .a(\uctl/n24 ),
    .b(urxf_empty),
    .o(urxf_read));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u91 (
    .a(\ubr/bwcnt [12]),
    .b(\ubr/bwcnt [13]),
    .c(\ubr/bwcnt [14]),
    .d(\ubr/bwcnt [15]),
    .o(_al_u91_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u92 (
    .a(_al_u91_o),
    .b(\ubr/bwcnt [0]),
    .c(\ubr/bwcnt [1]),
    .d(\ubr/bwcnt [10]),
    .e(\ubr/bwcnt [11]),
    .o(_al_u92_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u93 (
    .a(\ubr/bwcnt [2]),
    .b(\ubr/bwcnt [3]),
    .c(\ubr/bwcnt [4]),
    .d(\ubr/bwcnt [5]),
    .o(_al_u93_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u94 (
    .a(_al_u93_o),
    .b(\ubr/bwcnt [6]),
    .c(\ubr/bwcnt [7]),
    .d(\ubr/bwcnt [8]),
    .e(\ubr/bwcnt [9]),
    .o(_al_u94_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u95 (
    .a(_al_u92_o),
    .b(_al_u94_o),
    .o(\ubr/bitr_ovf ));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u96 (
    .a(\ubr/uartbres [5]),
    .b(uctl_uartbres_rd),
    .c(urxf_drive),
    .d(urxf_dato[5]),
    .o(_al_u96_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(E*D)*~(C*A))"),
    .INIT(32'hffb3b3b3))
    _al_u97 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(_al_u96_o),
    .c(uartbaud[5]),
    .d(\uctl/uctl_brdf ),
    .e(\uctl/uctl_uartctl_rd ),
    .o(bdatr[5]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(B*A))"),
    .INIT(16'h0777))
    _al_u98 (
    .a(\ubr/uartbres [4]),
    .b(uctl_uartbres_rd),
    .c(urxf_drive),
    .d(urxf_dato[4]),
    .o(_al_u98_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(E*D)*~(C*A))"),
    .INIT(32'hffb3b3b3))
    _al_u99 (
    .a(\uctl/mux9_b10_sel_is_2_o ),
    .b(_al_u98_o),
    .c(uartbaud[4]),
    .d(\uctl/uctl_uartctl_rd ),
    .e(utx_full),
    .o(bdatr[4]));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u0  (
    .a(\ubr/bwcnt [0]),
    .b(1'b1),
    .c(\ubr/add0/c0 ),
    .o({\ubr/add0/c1 ,\ubr/n3 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u1  (
    .a(\ubr/bwcnt [1]),
    .b(1'b0),
    .c(\ubr/add0/c1 ),
    .o({\ubr/add0/c2 ,\ubr/n3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u10  (
    .a(\ubr/bwcnt [10]),
    .b(1'b0),
    .c(\ubr/add0/c10 ),
    .o({\ubr/add0/c11 ,\ubr/n3 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u11  (
    .a(\ubr/bwcnt [11]),
    .b(1'b0),
    .c(\ubr/add0/c11 ),
    .o({\ubr/add0/c12 ,\ubr/n3 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u12  (
    .a(\ubr/bwcnt [12]),
    .b(1'b0),
    .c(\ubr/add0/c12 ),
    .o({\ubr/add0/c13 ,\ubr/n3 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u13  (
    .a(\ubr/bwcnt [13]),
    .b(1'b0),
    .c(\ubr/add0/c13 ),
    .o({\ubr/add0/c14 ,\ubr/n3 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u14  (
    .a(\ubr/bwcnt [14]),
    .b(1'b0),
    .c(\ubr/add0/c14 ),
    .o({\ubr/add0/c15 ,\ubr/n3 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u15  (
    .a(\ubr/bwcnt [15]),
    .b(1'b0),
    .c(\ubr/add0/c15 ),
    .o({open_n0,\ubr/n3 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u2  (
    .a(\ubr/bwcnt [2]),
    .b(1'b0),
    .c(\ubr/add0/c2 ),
    .o({\ubr/add0/c3 ,\ubr/n3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u3  (
    .a(\ubr/bwcnt [3]),
    .b(1'b0),
    .c(\ubr/add0/c3 ),
    .o({\ubr/add0/c4 ,\ubr/n3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u4  (
    .a(\ubr/bwcnt [4]),
    .b(1'b0),
    .c(\ubr/add0/c4 ),
    .o({\ubr/add0/c5 ,\ubr/n3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u5  (
    .a(\ubr/bwcnt [5]),
    .b(1'b0),
    .c(\ubr/add0/c5 ),
    .o({\ubr/add0/c6 ,\ubr/n3 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u6  (
    .a(\ubr/bwcnt [6]),
    .b(1'b0),
    .c(\ubr/add0/c6 ),
    .o({\ubr/add0/c7 ,\ubr/n3 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u7  (
    .a(\ubr/bwcnt [7]),
    .b(1'b0),
    .c(\ubr/add0/c7 ),
    .o({\ubr/add0/c8 ,\ubr/n3 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u8  (
    .a(\ubr/bwcnt [8]),
    .b(1'b0),
    .c(\ubr/add0/c8 ),
    .o({\ubr/add0/c9 ,\ubr/n3 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add0/u9  (
    .a(\ubr/bwcnt [9]),
    .b(1'b0),
    .c(\ubr/add0/c9 ),
    .o({\ubr/add0/c10 ,\ubr/n3 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \ubr/add0/ucin  (
    .a(1'b0),
    .o({\ubr/add0/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u0  (
    .a(\ubr/brcnt [0]),
    .b(1'b1),
    .c(\ubr/add1/c0 ),
    .o({\ubr/add1/c1 ,\ubr/n14 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u1  (
    .a(\ubr/brcnt [1]),
    .b(1'b0),
    .c(\ubr/add1/c1 ),
    .o({\ubr/add1/c2 ,\ubr/n14 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u10  (
    .a(\ubr/brcnt [10]),
    .b(1'b0),
    .c(\ubr/add1/c10 ),
    .o({\ubr/add1/c11 ,\ubr/n14 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u11  (
    .a(\ubr/brcnt [11]),
    .b(1'b0),
    .c(\ubr/add1/c11 ),
    .o({\ubr/add1/c12 ,\ubr/n14 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u12  (
    .a(\ubr/brcnt [12]),
    .b(1'b0),
    .c(\ubr/add1/c12 ),
    .o({\ubr/add1/c13 ,\ubr/n14 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u13  (
    .a(\ubr/brcnt [13]),
    .b(1'b0),
    .c(\ubr/add1/c13 ),
    .o({\ubr/add1/c14 ,\ubr/n14 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u14  (
    .a(\ubr/brcnt [14]),
    .b(1'b0),
    .c(\ubr/add1/c14 ),
    .o({\ubr/add1/c15 ,\ubr/n14 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u15  (
    .a(\ubr/brcnt [15]),
    .b(1'b0),
    .c(\ubr/add1/c15 ),
    .o({\ubr/add1/c16 ,\ubr/n14 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u16  (
    .a(\ubr/brcnt [16]),
    .b(1'b0),
    .c(\ubr/add1/c16 ),
    .o({\ubr/add1/c17 ,\ubr/n14 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u17  (
    .a(\ubr/brcnt [17]),
    .b(1'b0),
    .c(\ubr/add1/c17 ),
    .o({\ubr/add1/c18 ,\ubr/n14 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u18  (
    .a(\ubr/brcnt [18]),
    .b(1'b0),
    .c(\ubr/add1/c18 ),
    .o({open_n4,\ubr/n14 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u2  (
    .a(\ubr/brcnt [2]),
    .b(1'b0),
    .c(\ubr/add1/c2 ),
    .o({\ubr/add1/c3 ,\ubr/n14 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u3  (
    .a(\ubr/brcnt [3]),
    .b(1'b0),
    .c(\ubr/add1/c3 ),
    .o({\ubr/add1/c4 ,\ubr/n14 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u4  (
    .a(\ubr/brcnt [4]),
    .b(1'b0),
    .c(\ubr/add1/c4 ),
    .o({\ubr/add1/c5 ,\ubr/n14 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u5  (
    .a(\ubr/brcnt [5]),
    .b(1'b0),
    .c(\ubr/add1/c5 ),
    .o({\ubr/add1/c6 ,\ubr/n14 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u6  (
    .a(\ubr/brcnt [6]),
    .b(1'b0),
    .c(\ubr/add1/c6 ),
    .o({\ubr/add1/c7 ,\ubr/n14 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u7  (
    .a(\ubr/brcnt [7]),
    .b(1'b0),
    .c(\ubr/add1/c7 ),
    .o({\ubr/add1/c8 ,\ubr/n14 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u8  (
    .a(\ubr/brcnt [8]),
    .b(1'b0),
    .c(\ubr/add1/c8 ),
    .o({\ubr/add1/c9 ,\ubr/n14 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \ubr/add1/u9  (
    .a(\ubr/brcnt [9]),
    .b(1'b0),
    .c(\ubr/add1/c9 ),
    .o({\ubr/add1/c10 ,\ubr/n14 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \ubr/add1/ucin  (
    .a(1'b0),
    .o({\ubr/add1/c0 ,open_n7}));
  reg_sr_as_w1 \ubr/fsm/bitr_late_reg  (
    .clk(clk),
    .d(\ubr/fsm/bitr_late_t ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bitr_late ));  // rtl/uart_br_fsm.v(123)
  reg_sr_as_w1 \ubr/fsm/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ubr/fsm/mux0_b0_sel_is_1_o ),
    .set(1'b0),
    .q(\ubr/fsm/stat [0]));  // rtl/uart_br_fsm.v(115)
  reg_sr_as_w1 \ubr/fsm/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ubr/fsm/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\ubr/fsm/stat [1]));  // rtl/uart_br_fsm.v(115)
  reg_sr_as_w1 \ubr/fsm/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ubr/fsm/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\ubr/fsm/stat [2]));  // rtl/uart_br_fsm.v(115)
  reg_sr_as_w1 \ubr/fsm/reg0_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ubr/fsm/mux0_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\ubr/fsm/stat [3]));  // rtl/uart_br_fsm.v(115)
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_0  (
    .a(\ubr/n10 [0]),
    .b(\ubr/bitr_diff [0]),
    .c(\ubr/lt0_c0 ),
    .o({\ubr/lt0_c1 ,open_n8}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_1  (
    .a(\ubr/n10 [1]),
    .b(\ubr/bitr_diff [1]),
    .c(\ubr/lt0_c1 ),
    .o({\ubr/lt0_c2 ,open_n9}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_10  (
    .a(\ubr/n10 [10]),
    .b(\ubr/bitr_diff [10]),
    .c(\ubr/lt0_c10 ),
    .o({\ubr/lt0_c11 ,open_n10}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_11  (
    .a(\ubr/n10 [11]),
    .b(\ubr/bitr_diff [11]),
    .c(\ubr/lt0_c11 ),
    .o({\ubr/lt0_c12 ,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_12  (
    .a(\ubr/n10 [12]),
    .b(\ubr/bitr_diff [12]),
    .c(\ubr/lt0_c12 ),
    .o({\ubr/lt0_c13 ,open_n12}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_13  (
    .a(\ubr/n10 [13]),
    .b(\ubr/bitr_diff [13]),
    .c(\ubr/lt0_c13 ),
    .o({\ubr/lt0_c14 ,open_n13}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_14  (
    .a(\ubr/n10 [14]),
    .b(\ubr/bitr_diff [14]),
    .c(\ubr/lt0_c14 ),
    .o({\ubr/lt0_c15 ,open_n14}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_15  (
    .a(\ubr/n10 [15]),
    .b(\ubr/bitr_diff [15]),
    .c(\ubr/lt0_c15 ),
    .o({\ubr/lt0_c16 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_16  (
    .a(\ubr/bitr_diff [16]),
    .b(\ubr/n10 [16]),
    .c(\ubr/lt0_c16 ),
    .o({\ubr/lt0_c17 ,open_n16}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_2  (
    .a(\ubr/n10 [2]),
    .b(\ubr/bitr_diff [2]),
    .c(\ubr/lt0_c2 ),
    .o({\ubr/lt0_c3 ,open_n17}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_3  (
    .a(\ubr/n10 [3]),
    .b(\ubr/bitr_diff [3]),
    .c(\ubr/lt0_c3 ),
    .o({\ubr/lt0_c4 ,open_n18}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_4  (
    .a(\ubr/n10 [4]),
    .b(\ubr/bitr_diff [4]),
    .c(\ubr/lt0_c4 ),
    .o({\ubr/lt0_c5 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_5  (
    .a(\ubr/n10 [5]),
    .b(\ubr/bitr_diff [5]),
    .c(\ubr/lt0_c5 ),
    .o({\ubr/lt0_c6 ,open_n20}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_6  (
    .a(\ubr/n10 [6]),
    .b(\ubr/bitr_diff [6]),
    .c(\ubr/lt0_c6 ),
    .o({\ubr/lt0_c7 ,open_n21}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_7  (
    .a(\ubr/n10 [7]),
    .b(\ubr/bitr_diff [7]),
    .c(\ubr/lt0_c7 ),
    .o({\ubr/lt0_c8 ,open_n22}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_8  (
    .a(\ubr/n10 [8]),
    .b(\ubr/bitr_diff [8]),
    .c(\ubr/lt0_c8 ),
    .o({\ubr/lt0_c9 ,open_n23}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_9  (
    .a(\ubr/n10 [9]),
    .b(\ubr/bitr_diff [9]),
    .c(\ubr/lt0_c9 ),
    .o({\ubr/lt0_c10 ,open_n24}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \ubr/lt0_cin  (
    .a(1'b1),
    .o({\ubr/lt0_c0 ,open_n27}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\ubr/lt0_c17 ),
    .o({open_n28,\ubr/n11 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_0  (
    .a(\ubr/bitr_diff [0]),
    .b(\ubr/bwdat1 [3]),
    .c(\ubr/lt1_c0 ),
    .o({\ubr/lt1_c1 ,open_n29}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_1  (
    .a(\ubr/bitr_diff [1]),
    .b(\ubr/bwdat1 [4]),
    .c(\ubr/lt1_c1 ),
    .o({\ubr/lt1_c2 ,open_n30}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_10  (
    .a(\ubr/bitr_diff [10]),
    .b(\ubr/bwdat1 [13]),
    .c(\ubr/lt1_c10 ),
    .o({\ubr/lt1_c11 ,open_n31}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_11  (
    .a(\ubr/bitr_diff [11]),
    .b(\ubr/bwdat1 [14]),
    .c(\ubr/lt1_c11 ),
    .o({\ubr/lt1_c12 ,open_n32}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_12  (
    .a(\ubr/bitr_diff [12]),
    .b(\ubr/bwdat1 [15]),
    .c(\ubr/lt1_c12 ),
    .o({\ubr/lt1_c13 ,open_n33}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_13  (
    .a(\ubr/bitr_diff [13]),
    .b(1'b0),
    .c(\ubr/lt1_c13 ),
    .o({\ubr/lt1_c14 ,open_n34}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_14  (
    .a(\ubr/bitr_diff [14]),
    .b(1'b0),
    .c(\ubr/lt1_c14 ),
    .o({\ubr/lt1_c15 ,open_n35}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_15  (
    .a(\ubr/bitr_diff [15]),
    .b(1'b0),
    .c(\ubr/lt1_c15 ),
    .o({\ubr/lt1_c16 ,open_n36}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_16  (
    .a(1'b0),
    .b(\ubr/bitr_diff [16]),
    .c(\ubr/lt1_c16 ),
    .o({\ubr/lt1_c17 ,open_n37}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_2  (
    .a(\ubr/bitr_diff [2]),
    .b(\ubr/bwdat1 [5]),
    .c(\ubr/lt1_c2 ),
    .o({\ubr/lt1_c3 ,open_n38}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_3  (
    .a(\ubr/bitr_diff [3]),
    .b(\ubr/bwdat1 [6]),
    .c(\ubr/lt1_c3 ),
    .o({\ubr/lt1_c4 ,open_n39}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_4  (
    .a(\ubr/bitr_diff [4]),
    .b(\ubr/bwdat1 [7]),
    .c(\ubr/lt1_c4 ),
    .o({\ubr/lt1_c5 ,open_n40}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_5  (
    .a(\ubr/bitr_diff [5]),
    .b(\ubr/bwdat1 [8]),
    .c(\ubr/lt1_c5 ),
    .o({\ubr/lt1_c6 ,open_n41}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_6  (
    .a(\ubr/bitr_diff [6]),
    .b(\ubr/bwdat1 [9]),
    .c(\ubr/lt1_c6 ),
    .o({\ubr/lt1_c7 ,open_n42}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_7  (
    .a(\ubr/bitr_diff [7]),
    .b(\ubr/bwdat1 [10]),
    .c(\ubr/lt1_c7 ),
    .o({\ubr/lt1_c8 ,open_n43}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_8  (
    .a(\ubr/bitr_diff [8]),
    .b(\ubr/bwdat1 [11]),
    .c(\ubr/lt1_c8 ),
    .o({\ubr/lt1_c9 ,open_n44}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_9  (
    .a(\ubr/bitr_diff [9]),
    .b(\ubr/bwdat1 [12]),
    .c(\ubr/lt1_c9 ),
    .o({\ubr/lt1_c10 ,open_n45}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \ubr/lt1_cin  (
    .a(1'b1),
    .o({\ubr/lt1_c0 ,open_n48}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \ubr/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\ubr/lt1_c17 ),
    .o({open_n49,\ubr/n12 }));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u0  (
    .a(1'b0),
    .b(\ubr/bwdat1 [3]),
    .c(\ubr/neg0/c0 ),
    .o({\ubr/neg0/c1 ,\ubr/n10 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u1  (
    .a(1'b0),
    .b(\ubr/bwdat1 [4]),
    .c(\ubr/neg0/c1 ),
    .o({\ubr/neg0/c2 ,\ubr/n10 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u10  (
    .a(1'b0),
    .b(\ubr/bwdat1 [13]),
    .c(\ubr/neg0/c10 ),
    .o({\ubr/neg0/c11 ,\ubr/n10 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u11  (
    .a(1'b0),
    .b(\ubr/bwdat1 [14]),
    .c(\ubr/neg0/c11 ),
    .o({\ubr/neg0/c12 ,\ubr/n10 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u12  (
    .a(1'b0),
    .b(\ubr/bwdat1 [15]),
    .c(\ubr/neg0/c12 ),
    .o({\ubr/neg0/c13 ,\ubr/n10 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u13  (
    .a(1'b0),
    .b(1'b0),
    .c(\ubr/neg0/c13 ),
    .o({\ubr/neg0/c14 ,\ubr/n10 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u14  (
    .a(1'b0),
    .b(1'b0),
    .c(\ubr/neg0/c14 ),
    .o({\ubr/neg0/c15 ,\ubr/n10 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u15  (
    .a(1'b0),
    .b(1'b0),
    .c(\ubr/neg0/c15 ),
    .o({\ubr/neg0/c16 ,\ubr/n10 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u16  (
    .a(1'b0),
    .b(1'b0),
    .c(\ubr/neg0/c16 ),
    .o({open_n50,\ubr/n10 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u2  (
    .a(1'b0),
    .b(\ubr/bwdat1 [5]),
    .c(\ubr/neg0/c2 ),
    .o({\ubr/neg0/c3 ,\ubr/n10 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u3  (
    .a(1'b0),
    .b(\ubr/bwdat1 [6]),
    .c(\ubr/neg0/c3 ),
    .o({\ubr/neg0/c4 ,\ubr/n10 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u4  (
    .a(1'b0),
    .b(\ubr/bwdat1 [7]),
    .c(\ubr/neg0/c4 ),
    .o({\ubr/neg0/c5 ,\ubr/n10 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u5  (
    .a(1'b0),
    .b(\ubr/bwdat1 [8]),
    .c(\ubr/neg0/c5 ),
    .o({\ubr/neg0/c6 ,\ubr/n10 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u6  (
    .a(1'b0),
    .b(\ubr/bwdat1 [9]),
    .c(\ubr/neg0/c6 ),
    .o({\ubr/neg0/c7 ,\ubr/n10 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u7  (
    .a(1'b0),
    .b(\ubr/bwdat1 [10]),
    .c(\ubr/neg0/c7 ),
    .o({\ubr/neg0/c8 ,\ubr/n10 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u8  (
    .a(1'b0),
    .b(\ubr/bwdat1 [11]),
    .c(\ubr/neg0/c8 ),
    .o({\ubr/neg0/c9 ,\ubr/n10 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/neg0/u9  (
    .a(1'b0),
    .b(\ubr/bwdat1 [12]),
    .c(\ubr/neg0/c9 ),
    .o({\ubr/neg0/c10 ,\ubr/n10 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \ubr/neg0/ucin  (
    .a(1'b0),
    .o({\ubr/neg0/c0 ,open_n53}));
  reg_sr_as_w1 \ubr/reg0_b0  (
    .clk(clk),
    .d(\ubr/n3 [0]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [0]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b1  (
    .clk(clk),
    .d(\ubr/n3 [1]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [1]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b10  (
    .clk(clk),
    .d(\ubr/n3 [10]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [10]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b11  (
    .clk(clk),
    .d(\ubr/n3 [11]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [11]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b12  (
    .clk(clk),
    .d(\ubr/n3 [12]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [12]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b13  (
    .clk(clk),
    .d(\ubr/n3 [13]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [13]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b14  (
    .clk(clk),
    .d(\ubr/n3 [14]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [14]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b15  (
    .clk(clk),
    .d(\ubr/n3 [15]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [15]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b2  (
    .clk(clk),
    .d(\ubr/n3 [2]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [2]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b3  (
    .clk(clk),
    .d(\ubr/n3 [3]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [3]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b4  (
    .clk(clk),
    .d(\ubr/n3 [4]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [4]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b5  (
    .clk(clk),
    .d(\ubr/n3 [5]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [5]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b6  (
    .clk(clk),
    .d(\ubr/n3 [6]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [6]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b7  (
    .clk(clk),
    .d(\ubr/n3 [7]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [7]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b8  (
    .clk(clk),
    .d(\ubr/n3 [8]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [8]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg0_b9  (
    .clk(clk),
    .d(\ubr/n3 [9]),
    .en(~\ubr/bitr_ovf ),
    .reset(\ubr/n2 ),
    .set(1'b0),
    .q(\ubr/bwcnt [9]));  // rtl/uart_br.v(39)
  reg_sr_as_w1 \ubr/reg1_b0  (
    .clk(clk),
    .d(\ubr/bwcnt [0]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [0]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b1  (
    .clk(clk),
    .d(\ubr/bwcnt [1]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [1]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b10  (
    .clk(clk),
    .d(\ubr/bwcnt [10]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [10]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b11  (
    .clk(clk),
    .d(\ubr/bwcnt [11]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [11]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b12  (
    .clk(clk),
    .d(\ubr/bwcnt [12]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [12]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b13  (
    .clk(clk),
    .d(\ubr/bwcnt [13]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [13]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b14  (
    .clk(clk),
    .d(\ubr/bwcnt [14]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [14]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b15  (
    .clk(clk),
    .d(\ubr/bwcnt [15]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [15]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b2  (
    .clk(clk),
    .d(\ubr/bwcnt [2]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [2]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b3  (
    .clk(clk),
    .d(\ubr/bwcnt [3]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [3]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b4  (
    .clk(clk),
    .d(\ubr/bwcnt [4]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [4]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b5  (
    .clk(clk),
    .d(\ubr/bwcnt [5]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [5]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b6  (
    .clk(clk),
    .d(\ubr/bwcnt [6]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [6]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b7  (
    .clk(clk),
    .d(\ubr/bwcnt [7]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [7]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b8  (
    .clk(clk),
    .d(\ubr/bwcnt [8]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [8]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg1_b9  (
    .clk(clk),
    .d(\ubr/bwcnt [9]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat0 [9]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b0  (
    .clk(clk),
    .d(\ubr/bwdat0 [0]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [0]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b1  (
    .clk(clk),
    .d(\ubr/bwdat0 [1]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [1]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b10  (
    .clk(clk),
    .d(\ubr/bwdat0 [10]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [10]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b11  (
    .clk(clk),
    .d(\ubr/bwdat0 [11]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [11]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b12  (
    .clk(clk),
    .d(\ubr/bwdat0 [12]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [12]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b13  (
    .clk(clk),
    .d(\ubr/bwdat0 [13]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [13]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b14  (
    .clk(clk),
    .d(\ubr/bwdat0 [14]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [14]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b15  (
    .clk(clk),
    .d(\ubr/bwdat0 [15]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [15]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b2  (
    .clk(clk),
    .d(\ubr/bwdat0 [2]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [2]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b3  (
    .clk(clk),
    .d(\ubr/bwdat0 [3]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [3]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b4  (
    .clk(clk),
    .d(\ubr/bwdat0 [4]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [4]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b5  (
    .clk(clk),
    .d(\ubr/bwdat0 [5]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [5]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b6  (
    .clk(clk),
    .d(\ubr/bwdat0 [6]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [6]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b7  (
    .clk(clk),
    .d(\ubr/bwdat0 [7]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [7]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b8  (
    .clk(clk),
    .d(\ubr/bwdat0 [8]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [8]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg2_b9  (
    .clk(clk),
    .d(\ubr/bwdat0 [9]),
    .en(\ubr/bitr_tgl ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/bwdat1 [9]));  // rtl/uart_br.v(61)
  reg_sr_as_w1 \ubr/reg3_b0  (
    .clk(clk),
    .d(\ubr/n14 [0]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [0]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b1  (
    .clk(clk),
    .d(\ubr/n14 [1]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [1]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b10  (
    .clk(clk),
    .d(\ubr/n14 [10]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [10]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b11  (
    .clk(clk),
    .d(\ubr/n14 [11]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [11]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b12  (
    .clk(clk),
    .d(\ubr/n14 [12]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [12]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b13  (
    .clk(clk),
    .d(\ubr/n14 [13]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [13]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b14  (
    .clk(clk),
    .d(\ubr/n14 [14]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [14]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b15  (
    .clk(clk),
    .d(\ubr/n14 [15]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [15]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b16  (
    .clk(clk),
    .d(\ubr/n14 [16]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [16]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b17  (
    .clk(clk),
    .d(\ubr/n14 [17]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [17]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b18  (
    .clk(clk),
    .d(\ubr/n14 [18]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [18]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b2  (
    .clk(clk),
    .d(\ubr/n14 [2]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [2]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b3  (
    .clk(clk),
    .d(\ubr/n14 [3]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [3]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b4  (
    .clk(clk),
    .d(\ubr/n14 [4]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [4]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b5  (
    .clk(clk),
    .d(\ubr/n14 [5]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [5]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b6  (
    .clk(clk),
    .d(\ubr/n14 [6]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [6]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b7  (
    .clk(clk),
    .d(\ubr/n14 [7]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [7]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b8  (
    .clk(clk),
    .d(\ubr/n14 [8]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [8]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg3_b9  (
    .clk(clk),
    .d(\ubr/n14 [9]),
    .en(~\ubr/bitr_fovf ),
    .reset(\ubr/n13 ),
    .set(1'b0),
    .q(\ubr/brcnt [9]));  // rtl/uart_br.v(74)
  reg_sr_as_w1 \ubr/reg4_b0  (
    .clk(clk),
    .d(\ubr/n18 [0]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [0]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b1  (
    .clk(clk),
    .d(\ubr/n18 [1]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [1]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b10  (
    .clk(clk),
    .d(\ubr/n18 [10]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [10]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b11  (
    .clk(clk),
    .d(\ubr/n18 [11]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [11]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b12  (
    .clk(clk),
    .d(\ubr/n18 [12]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [12]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b13  (
    .clk(clk),
    .d(\ubr/n18 [13]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [13]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b14  (
    .clk(clk),
    .d(\ubr/n18 [14]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [14]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b15  (
    .clk(clk),
    .d(\ubr/n18 [15]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [15]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b2  (
    .clk(clk),
    .d(\ubr/n18 [2]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [2]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b3  (
    .clk(clk),
    .d(\ubr/n18 [3]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [3]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b4  (
    .clk(clk),
    .d(\ubr/n18 [4]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [4]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b5  (
    .clk(clk),
    .d(\ubr/n18 [5]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [5]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b6  (
    .clk(clk),
    .d(\ubr/n18 [6]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [6]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b7  (
    .clk(clk),
    .d(\ubr/n18 [7]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [7]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b8  (
    .clk(clk),
    .d(\ubr/n18 [8]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [8]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg4_b9  (
    .clk(clk),
    .d(\ubr/n18 [9]),
    .en(\ubr/bitr_late ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/brcnt_f [9]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b0  (
    .clk(clk),
    .d(\ubr/brcnt_f [0]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [0]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b1  (
    .clk(clk),
    .d(\ubr/brcnt_f [1]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [1]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b10  (
    .clk(clk),
    .d(\ubr/brcnt_f [10]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [10]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b11  (
    .clk(clk),
    .d(\ubr/brcnt_f [11]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [11]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b12  (
    .clk(clk),
    .d(\ubr/brcnt_f [12]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [12]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b13  (
    .clk(clk),
    .d(\ubr/brcnt_f [13]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [13]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b14  (
    .clk(clk),
    .d(\ubr/brcnt_f [14]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [14]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b15  (
    .clk(clk),
    .d(\ubr/brcnt_f [15]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [15]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b2  (
    .clk(clk),
    .d(\ubr/brcnt_f [2]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [2]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b3  (
    .clk(clk),
    .d(\ubr/brcnt_f [3]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [3]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b4  (
    .clk(clk),
    .d(\ubr/brcnt_f [4]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [4]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b5  (
    .clk(clk),
    .d(\ubr/brcnt_f [5]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [5]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b6  (
    .clk(clk),
    .d(\ubr/brcnt_f [6]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [6]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b7  (
    .clk(clk),
    .d(\ubr/brcnt_f [7]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [7]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b8  (
    .clk(clk),
    .d(\ubr/brcnt_f [8]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [8]));  // rtl/uart_br.v(96)
  reg_sr_as_w1 \ubr/reg5_b9  (
    .clk(clk),
    .d(\ubr/brcnt_f [9]),
    .en(~\ubr/fsm/n97 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\ubr/uartbres [9]));  // rtl/uart_br.v(96)
  reg_ar_ss_w1 \ubr/reg6_b0  (
    .clk(clk),
    .d(urx_rxd),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\ubr/bitr_sft [0]));  // rtl/uart_br.v(26)
  reg_ar_ss_w1 \ubr/reg6_b1  (
    .clk(clk),
    .d(\ubr/bitr_sft [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\ubr/bitr_sft [1]));  // rtl/uart_br.v(26)
  reg_ar_ss_w1 \ubr/reg6_b2  (
    .clk(clk),
    .d(\ubr/bitr_sft [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\ubr/bitr_sft [2]));  // rtl/uart_br.v(26)
  reg_ar_ss_w1 \ubr/reg6_b3  (
    .clk(clk),
    .d(\ubr/bitr_sft [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\ubr/bitr_sft [3]));  // rtl/uart_br.v(26)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u0  (
    .a(\ubr/bwdat0 [0]),
    .b(\ubr/bwdat1 [0]),
    .c(\ubr/sub0/c0 ),
    .o({\ubr/sub0/c1 ,\ubr/bitr_diff [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u1  (
    .a(\ubr/bwdat0 [1]),
    .b(\ubr/bwdat1 [1]),
    .c(\ubr/sub0/c1 ),
    .o({\ubr/sub0/c2 ,\ubr/bitr_diff [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u10  (
    .a(\ubr/bwdat0 [10]),
    .b(\ubr/bwdat1 [10]),
    .c(\ubr/sub0/c10 ),
    .o({\ubr/sub0/c11 ,\ubr/bitr_diff [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u11  (
    .a(\ubr/bwdat0 [11]),
    .b(\ubr/bwdat1 [11]),
    .c(\ubr/sub0/c11 ),
    .o({\ubr/sub0/c12 ,\ubr/bitr_diff [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u12  (
    .a(\ubr/bwdat0 [12]),
    .b(\ubr/bwdat1 [12]),
    .c(\ubr/sub0/c12 ),
    .o({\ubr/sub0/c13 ,\ubr/bitr_diff [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u13  (
    .a(\ubr/bwdat0 [13]),
    .b(\ubr/bwdat1 [13]),
    .c(\ubr/sub0/c13 ),
    .o({\ubr/sub0/c14 ,\ubr/bitr_diff [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u14  (
    .a(\ubr/bwdat0 [14]),
    .b(\ubr/bwdat1 [14]),
    .c(\ubr/sub0/c14 ),
    .o({\ubr/sub0/c15 ,\ubr/bitr_diff [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u15  (
    .a(\ubr/bwdat0 [15]),
    .b(\ubr/bwdat1 [15]),
    .c(\ubr/sub0/c15 ),
    .o({\ubr/sub0/c16 ,\ubr/bitr_diff [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u2  (
    .a(\ubr/bwdat0 [2]),
    .b(\ubr/bwdat1 [2]),
    .c(\ubr/sub0/c2 ),
    .o({\ubr/sub0/c3 ,\ubr/bitr_diff [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u3  (
    .a(\ubr/bwdat0 [3]),
    .b(\ubr/bwdat1 [3]),
    .c(\ubr/sub0/c3 ),
    .o({\ubr/sub0/c4 ,\ubr/bitr_diff [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u4  (
    .a(\ubr/bwdat0 [4]),
    .b(\ubr/bwdat1 [4]),
    .c(\ubr/sub0/c4 ),
    .o({\ubr/sub0/c5 ,\ubr/bitr_diff [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u5  (
    .a(\ubr/bwdat0 [5]),
    .b(\ubr/bwdat1 [5]),
    .c(\ubr/sub0/c5 ),
    .o({\ubr/sub0/c6 ,\ubr/bitr_diff [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u6  (
    .a(\ubr/bwdat0 [6]),
    .b(\ubr/bwdat1 [6]),
    .c(\ubr/sub0/c6 ),
    .o({\ubr/sub0/c7 ,\ubr/bitr_diff [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u7  (
    .a(\ubr/bwdat0 [7]),
    .b(\ubr/bwdat1 [7]),
    .c(\ubr/sub0/c7 ),
    .o({\ubr/sub0/c8 ,\ubr/bitr_diff [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u8  (
    .a(\ubr/bwdat0 [8]),
    .b(\ubr/bwdat1 [8]),
    .c(\ubr/sub0/c8 ),
    .o({\ubr/sub0/c9 ,\ubr/bitr_diff [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/u9  (
    .a(\ubr/bwdat0 [9]),
    .b(\ubr/bwdat1 [9]),
    .c(\ubr/sub0/c9 ),
    .o({\ubr/sub0/c10 ,\ubr/bitr_diff [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \ubr/sub0/ucin  (
    .a(1'b0),
    .o({\ubr/sub0/c0 ,open_n56}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub0/ucout  (
    .c(\ubr/sub0/c16 ),
    .o({open_n59,\ubr/bitr_diff [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u0  (
    .a(\ubr/brcnt [3]),
    .b(1'b1),
    .c(\ubr/sub1/c0 ),
    .o({\ubr/sub1/c1 ,\ubr/n17 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u1  (
    .a(\ubr/brcnt [4]),
    .b(1'b0),
    .c(\ubr/sub1/c1 ),
    .o({\ubr/sub1/c2 ,\ubr/n17 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u10  (
    .a(\ubr/brcnt [13]),
    .b(1'b0),
    .c(\ubr/sub1/c10 ),
    .o({\ubr/sub1/c11 ,\ubr/n17 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u11  (
    .a(\ubr/brcnt [14]),
    .b(1'b0),
    .c(\ubr/sub1/c11 ),
    .o({\ubr/sub1/c12 ,\ubr/n17 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u12  (
    .a(\ubr/brcnt [15]),
    .b(1'b0),
    .c(\ubr/sub1/c12 ),
    .o({\ubr/sub1/c13 ,\ubr/n17 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u13  (
    .a(\ubr/brcnt [16]),
    .b(1'b0),
    .c(\ubr/sub1/c13 ),
    .o({\ubr/sub1/c14 ,\ubr/n17 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u14  (
    .a(\ubr/brcnt [17]),
    .b(1'b0),
    .c(\ubr/sub1/c14 ),
    .o({\ubr/sub1/c15 ,\ubr/n17 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u15  (
    .a(\ubr/brcnt [18]),
    .b(1'b0),
    .c(\ubr/sub1/c15 ),
    .o({open_n60,\ubr/n17 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u2  (
    .a(\ubr/brcnt [5]),
    .b(1'b0),
    .c(\ubr/sub1/c2 ),
    .o({\ubr/sub1/c3 ,\ubr/n17 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u3  (
    .a(\ubr/brcnt [6]),
    .b(1'b0),
    .c(\ubr/sub1/c3 ),
    .o({\ubr/sub1/c4 ,\ubr/n17 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u4  (
    .a(\ubr/brcnt [7]),
    .b(1'b0),
    .c(\ubr/sub1/c4 ),
    .o({\ubr/sub1/c5 ,\ubr/n17 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u5  (
    .a(\ubr/brcnt [8]),
    .b(1'b0),
    .c(\ubr/sub1/c5 ),
    .o({\ubr/sub1/c6 ,\ubr/n17 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u6  (
    .a(\ubr/brcnt [9]),
    .b(1'b0),
    .c(\ubr/sub1/c6 ),
    .o({\ubr/sub1/c7 ,\ubr/n17 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u7  (
    .a(\ubr/brcnt [10]),
    .b(1'b0),
    .c(\ubr/sub1/c7 ),
    .o({\ubr/sub1/c8 ,\ubr/n17 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u8  (
    .a(\ubr/brcnt [11]),
    .b(1'b0),
    .c(\ubr/sub1/c8 ),
    .o({\ubr/sub1/c9 ,\ubr/n17 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \ubr/sub1/u9  (
    .a(\ubr/brcnt [12]),
    .b(1'b0),
    .c(\ubr/sub1/c9 ),
    .o({\ubr/sub1/c10 ,\ubr/n17 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \ubr/sub1/ucin  (
    .a(1'b0),
    .o({\ubr/sub1/c0 ,open_n63}));
  reg_sr_as_w1 \uctl/reg0_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\uctl/uctl_uartctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uctl_tx_enb));  // rtl/uart_uctl.v(118)
  reg_sr_as_w1 \uctl/reg0_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\uctl/uctl_uartctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uctl_rx_enb));  // rtl/uart_uctl.v(118)
  reg_sr_as_w1 \uctl/reg0_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\uctl/uctl_uartctl_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uartctl [2]));  // rtl/uart_uctl.v(118)
  reg_sr_as_w1 \uctl/reg0_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(1'b1),
    .reset(~\uctl/mux1_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\uctl/uartctl [3]));  // rtl/uart_uctl.v(118)
  reg_sr_as_w1 \uctl/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\uctl/uctl_uartflow_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uartflow [0]));  // rtl/uart_uctl.v(134)
  reg_sr_as_w1 \uctl/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\uctl/uctl_uartflow_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uartflow [1]));  // rtl/uart_uctl.v(134)
  reg_sr_as_w1 \uctl/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\uctl/uctl_uartflow_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uartflow [2]));  // rtl/uart_uctl.v(134)
  reg_sr_as_w1 \uctl/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\uctl/uctl_uartflow_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uartflow [3]));  // rtl/uart_uctl.v(134)
  reg_sr_as_w1 \uctl/reg2_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[0]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[1]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b10  (
    .clk(clk),
    .d(bdatw[10]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[10]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b11  (
    .clk(clk),
    .d(bdatw[11]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[11]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b12  (
    .clk(clk),
    .d(bdatw[12]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[12]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b13  (
    .clk(clk),
    .d(bdatw[13]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[13]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b14  (
    .clk(clk),
    .d(bdatw[14]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[14]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b15  (
    .clk(clk),
    .d(bdatw[15]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[15]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[2]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[3]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[4]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[5]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[6]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[7]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b8  (
    .clk(clk),
    .d(bdatw[8]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[8]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg2_b9  (
    .clk(clk),
    .d(bdatw[9]),
    .en(\uctl/uctl_uartbaud_wr ),
    .reset(~rst_n),
    .set(1'b0),
    .q(uartbaud[9]));  // rtl/uart_uctl.v(148)
  reg_sr_as_w1 \uctl/reg3_b0  (
    .clk(clk),
    .d(uart_cts),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_cts_sft [0]));  // rtl/uart_uctl.v(159)
  reg_sr_as_w1 \uctl/reg3_b1  (
    .clk(clk),
    .d(\uctl/uctl_cts_sft [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_cts_sft [1]));  // rtl/uart_uctl.v(159)
  reg_sr_as_w1 \uctl/reg3_b2  (
    .clk(clk),
    .d(\uctl/uctl_cts_sft [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_cts_sft [2]));  // rtl/uart_uctl.v(159)
  reg_sr_as_w1 \uctl/reg3_b3  (
    .clk(clk),
    .d(\uctl/uctl_cts_sft [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_cts_sft [3]));  // rtl/uart_uctl.v(159)
  reg_ar_as_w1 \uctl/uart_rts_reg  (
    .clk(clk),
    .d(\uctl/n53 ),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(uart_rts));  // rtl/uart_uctl.v(176)
  reg_sr_as_w1 \uctl/uctl_brdf_reg  (
    .clk(clk),
    .d(\ubr/fsm/n97_neg ),
    .en(\ubr/_al_n0_en ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_brdf ));  // rtl/uart_uctl.v(105)
  reg_sr_as_w1 \uctl/uctl_uartbaud_rd_reg  (
    .clk(clk),
    .d(\uctl/n6 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_uartbaud_rd ));  // rtl/uart_uctl.v(84)
  reg_sr_as_w1 \uctl/uctl_uartbres_rd_reg  (
    .clk(clk),
    .d(\uctl/n10 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(uctl_uartbres_rd));  // rtl/uart_uctl.v(84)
  reg_sr_as_w1 \uctl/uctl_uartctl_rd_reg  (
    .clk(clk),
    .d(\uctl/n4 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_uartctl_rd ));  // rtl/uart_uctl.v(84)
  reg_sr_as_w1 \uctl/uctl_uartflow_rd_reg  (
    .clk(clk),
    .d(\uctl/n8 ),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\uctl/uctl_uartflow_rd ));  // rtl/uart_uctl.v(84)
  reg_sr_as_w1 \uctl/urxf_drive_reg  (
    .clk(clk),
    .d(urxf_read),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_drive));  // rtl/uart_uctl.v(84)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u0  (
    .a(\urx/bcnt [0]),
    .b(1'b1),
    .c(\urx/add0/c0 ),
    .o({\urx/add0/c1 ,\urx/n16 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u1  (
    .a(\urx/bcnt [1]),
    .b(1'b0),
    .c(\urx/add0/c1 ),
    .o({\urx/add0/c2 ,\urx/n16 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u10  (
    .a(\urx/bcnt [10]),
    .b(1'b0),
    .c(\urx/add0/c10 ),
    .o({\urx/add0/c11 ,\urx/n16 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u11  (
    .a(\urx/bcnt [11]),
    .b(1'b0),
    .c(\urx/add0/c11 ),
    .o({\urx/add0/c12 ,\urx/n16 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u12  (
    .a(\urx/bcnt [12]),
    .b(1'b0),
    .c(\urx/add0/c12 ),
    .o({\urx/add0/c13 ,\urx/n16 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u13  (
    .a(\urx/bcnt [13]),
    .b(1'b0),
    .c(\urx/add0/c13 ),
    .o({\urx/add0/c14 ,\urx/n16 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u14  (
    .a(\urx/bcnt [14]),
    .b(1'b0),
    .c(\urx/add0/c14 ),
    .o({\urx/add0/c15 ,\urx/n16 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u15  (
    .a(\urx/bcnt [15]),
    .b(1'b0),
    .c(\urx/add0/c15 ),
    .o({open_n64,\urx/n16 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u2  (
    .a(\urx/bcnt [2]),
    .b(1'b0),
    .c(\urx/add0/c2 ),
    .o({\urx/add0/c3 ,\urx/n16 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u3  (
    .a(\urx/bcnt [3]),
    .b(1'b0),
    .c(\urx/add0/c3 ),
    .o({\urx/add0/c4 ,\urx/n16 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u4  (
    .a(\urx/bcnt [4]),
    .b(1'b0),
    .c(\urx/add0/c4 ),
    .o({\urx/add0/c5 ,\urx/n16 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u5  (
    .a(\urx/bcnt [5]),
    .b(1'b0),
    .c(\urx/add0/c5 ),
    .o({\urx/add0/c6 ,\urx/n16 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u6  (
    .a(\urx/bcnt [6]),
    .b(1'b0),
    .c(\urx/add0/c6 ),
    .o({\urx/add0/c7 ,\urx/n16 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u7  (
    .a(\urx/bcnt [7]),
    .b(1'b0),
    .c(\urx/add0/c7 ),
    .o({\urx/add0/c8 ,\urx/n16 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u8  (
    .a(\urx/bcnt [8]),
    .b(1'b0),
    .c(\urx/add0/c8 ),
    .o({\urx/add0/c9 ,\urx/n16 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \urx/add0/u9  (
    .a(\urx/bcnt [9]),
    .b(1'b0),
    .c(\urx/add0/c9 ),
    .o({\urx/add0/c10 ,\urx/n16 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \urx/add0/ucin  (
    .a(1'b0),
    .o({\urx/add0/c0 ,open_n67}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_0  (
    .a(uartbaud[0]),
    .b(\urx/bcnt [0]),
    .c(\urx/lt0_c0 ),
    .o({\urx/lt0_c1 ,open_n68}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_1  (
    .a(uartbaud[1]),
    .b(\urx/bcnt [1]),
    .c(\urx/lt0_c1 ),
    .o({\urx/lt0_c2 ,open_n69}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_10  (
    .a(uartbaud[10]),
    .b(\urx/bcnt [10]),
    .c(\urx/lt0_c10 ),
    .o({\urx/lt0_c11 ,open_n70}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_11  (
    .a(uartbaud[11]),
    .b(\urx/bcnt [11]),
    .c(\urx/lt0_c11 ),
    .o({\urx/lt0_c12 ,open_n71}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_12  (
    .a(uartbaud[12]),
    .b(\urx/bcnt [12]),
    .c(\urx/lt0_c12 ),
    .o({\urx/lt0_c13 ,open_n72}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_13  (
    .a(uartbaud[13]),
    .b(\urx/bcnt [13]),
    .c(\urx/lt0_c13 ),
    .o({\urx/lt0_c14 ,open_n73}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_14  (
    .a(uartbaud[14]),
    .b(\urx/bcnt [14]),
    .c(\urx/lt0_c14 ),
    .o({\urx/lt0_c15 ,open_n74}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_15  (
    .a(uartbaud[15]),
    .b(\urx/bcnt [15]),
    .c(\urx/lt0_c15 ),
    .o({\urx/lt0_c16 ,open_n75}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_2  (
    .a(uartbaud[2]),
    .b(\urx/bcnt [2]),
    .c(\urx/lt0_c2 ),
    .o({\urx/lt0_c3 ,open_n76}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_3  (
    .a(uartbaud[3]),
    .b(\urx/bcnt [3]),
    .c(\urx/lt0_c3 ),
    .o({\urx/lt0_c4 ,open_n77}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_4  (
    .a(uartbaud[4]),
    .b(\urx/bcnt [4]),
    .c(\urx/lt0_c4 ),
    .o({\urx/lt0_c5 ,open_n78}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_5  (
    .a(uartbaud[5]),
    .b(\urx/bcnt [5]),
    .c(\urx/lt0_c5 ),
    .o({\urx/lt0_c6 ,open_n79}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_6  (
    .a(uartbaud[6]),
    .b(\urx/bcnt [6]),
    .c(\urx/lt0_c6 ),
    .o({\urx/lt0_c7 ,open_n80}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_7  (
    .a(uartbaud[7]),
    .b(\urx/bcnt [7]),
    .c(\urx/lt0_c7 ),
    .o({\urx/lt0_c8 ,open_n81}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_8  (
    .a(uartbaud[8]),
    .b(\urx/bcnt [8]),
    .c(\urx/lt0_c8 ),
    .o({\urx/lt0_c9 ,open_n82}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_9  (
    .a(uartbaud[9]),
    .b(\urx/bcnt [9]),
    .c(\urx/lt0_c9 ),
    .o({\urx/lt0_c10 ,open_n83}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \urx/lt0_cin  (
    .a(1'b1),
    .o({\urx/lt0_c0 ,open_n86}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \urx/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\urx/lt0_c16 ),
    .o({open_n87,\urx/urx_ovfl }));
  reg_sr_as_w1 \urx/reg0_b0  (
    .clk(clk),
    .d(\urx/n16 [0]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [0]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b1  (
    .clk(clk),
    .d(\urx/n16 [1]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [1]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b10  (
    .clk(clk),
    .d(\urx/n16 [10]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [10]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b11  (
    .clk(clk),
    .d(\urx/n16 [11]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [11]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b12  (
    .clk(clk),
    .d(\urx/n16 [12]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [12]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b13  (
    .clk(clk),
    .d(\urx/n16 [13]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [13]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b14  (
    .clk(clk),
    .d(\urx/n16 [14]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [14]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b15  (
    .clk(clk),
    .d(\urx/n16 [15]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [15]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b2  (
    .clk(clk),
    .d(\urx/n16 [2]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [2]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b3  (
    .clk(clk),
    .d(\urx/n16 [3]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [3]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b4  (
    .clk(clk),
    .d(\urx/n16 [4]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [4]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b5  (
    .clk(clk),
    .d(\urx/n16 [5]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [5]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b6  (
    .clk(clk),
    .d(\urx/n16 [6]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [6]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b7  (
    .clk(clk),
    .d(\urx/n16 [7]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [7]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b8  (
    .clk(clk),
    .d(\urx/n16 [8]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [8]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg0_b9  (
    .clk(clk),
    .d(\urx/n16 [9]),
    .en(1'b1),
    .reset(\urx/n14 ),
    .set(1'b0),
    .q(\urx/bcnt [9]));  // rtl/uart_rx.v(45)
  reg_sr_as_w1 \urx/reg1_b0  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b0_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[0]));  // rtl/uart_rx.v(75)
  reg_sr_as_w1 \urx/reg1_b1  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b1_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[1]));  // rtl/uart_rx.v(75)
  reg_sr_as_w1 \urx/reg1_b2  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b2_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[2]));  // rtl/uart_rx.v(75)
  reg_sr_as_w1 \urx/reg1_b3  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b3_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[3]));  // rtl/uart_rx.v(75)
  reg_sr_as_w1 \urx/reg1_b4  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b4_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[4]));  // rtl/uart_rx.v(75)
  reg_sr_as_w1 \urx/reg1_b5  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b5_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[5]));  // rtl/uart_rx.v(75)
  reg_sr_as_w1 \urx/reg1_b6  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b6_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[6]));  // rtl/uart_rx.v(75)
  reg_sr_as_w1 \urx/reg1_b7  (
    .clk(clk),
    .d(urx_rxd),
    .en(\urx/mux2_b7_sel_is_3_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_dati[7]));  // rtl/uart_rx.v(75)
  reg_ar_ss_w1 \urx/reg2_b0  (
    .clk(clk),
    .d(uart_rxd),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\urx/sync_rxd [0]));  // rtl/uart_rx.v(32)
  reg_ar_ss_w1 \urx/reg2_b1  (
    .clk(clk),
    .d(\urx/sync_rxd [0]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\urx/sync_rxd [1]));  // rtl/uart_rx.v(32)
  reg_ar_ss_w1 \urx/reg2_b2  (
    .clk(clk),
    .d(\urx/sync_rxd [1]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\urx/sync_rxd [2]));  // rtl/uart_rx.v(32)
  reg_ar_ss_w1 \urx/reg2_b3  (
    .clk(clk),
    .d(\urx/sync_rxd [2]),
    .en(1'b1),
    .reset(1'b0),
    .set(~rst_n),
    .q(\urx/sync_rxd [3]));  // rtl/uart_rx.v(32)
  reg_sr_as_w1 \urx/rxctl/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b0_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b1_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b2_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg0_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b3_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg0_b4  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b4_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b4_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg0_b5  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b5_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b5_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg0_b6  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b6_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b6_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg0_b7  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux0_b7_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/mux2_b7_sel_is_3_o ));  // rtl/uart_rx_fsm.v(127)
  reg_sr_as_w1 \urx/rxctl/reg1_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux1_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/rxctl/urx_stat [0]));  // rtl/uart_rx_fsm.v(135)
  reg_sr_as_w1 \urx/rxctl/reg1_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux1_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/rxctl/urx_stat [1]));  // rtl/uart_rx_fsm.v(135)
  reg_sr_as_w1 \urx/rxctl/reg1_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux1_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/rxctl/urx_stat [2]));  // rtl/uart_rx_fsm.v(135)
  reg_sr_as_w1 \urx/rxctl/reg1_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\urx/rxctl/mux1_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\urx/rxctl/urx_stat [3]));  // rtl/uart_rx_fsm.v(135)
  reg_sr_as_w1 \urx/rxctl/urx_cnte_reg  (
    .clk(clk),
    .d(\urx/rxctl/urx_cnte_t ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\urx/urx_cnte ));  // rtl/uart_rx_fsm.v(111)
  reg_sr_as_w1 \urx/rxctl/urxf_write_reg  (
    .clk(clk),
    .d(\urx/rxctl/n143 ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(urxf_write));  // rtl/uart_rx_fsm.v(119)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u0  (
    .a(\utx/bcnt [0]),
    .b(1'b1),
    .c(\utx/add0/c0 ),
    .o({\utx/add0/c1 ,\utx/n14 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u1  (
    .a(\utx/bcnt [1]),
    .b(1'b0),
    .c(\utx/add0/c1 ),
    .o({\utx/add0/c2 ,\utx/n14 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u10  (
    .a(\utx/bcnt [10]),
    .b(1'b0),
    .c(\utx/add0/c10 ),
    .o({\utx/add0/c11 ,\utx/n14 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u11  (
    .a(\utx/bcnt [11]),
    .b(1'b0),
    .c(\utx/add0/c11 ),
    .o({\utx/add0/c12 ,\utx/n14 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u12  (
    .a(\utx/bcnt [12]),
    .b(1'b0),
    .c(\utx/add0/c12 ),
    .o({\utx/add0/c13 ,\utx/n14 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u13  (
    .a(\utx/bcnt [13]),
    .b(1'b0),
    .c(\utx/add0/c13 ),
    .o({\utx/add0/c14 ,\utx/n14 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u14  (
    .a(\utx/bcnt [14]),
    .b(1'b0),
    .c(\utx/add0/c14 ),
    .o({\utx/add0/c15 ,\utx/n14 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u15  (
    .a(\utx/bcnt [15]),
    .b(1'b0),
    .c(\utx/add0/c15 ),
    .o({open_n88,\utx/n14 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u2  (
    .a(\utx/bcnt [2]),
    .b(1'b0),
    .c(\utx/add0/c2 ),
    .o({\utx/add0/c3 ,\utx/n14 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u3  (
    .a(\utx/bcnt [3]),
    .b(1'b0),
    .c(\utx/add0/c3 ),
    .o({\utx/add0/c4 ,\utx/n14 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u4  (
    .a(\utx/bcnt [4]),
    .b(1'b0),
    .c(\utx/add0/c4 ),
    .o({\utx/add0/c5 ,\utx/n14 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u5  (
    .a(\utx/bcnt [5]),
    .b(1'b0),
    .c(\utx/add0/c5 ),
    .o({\utx/add0/c6 ,\utx/n14 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u6  (
    .a(\utx/bcnt [6]),
    .b(1'b0),
    .c(\utx/add0/c6 ),
    .o({\utx/add0/c7 ,\utx/n14 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u7  (
    .a(\utx/bcnt [7]),
    .b(1'b0),
    .c(\utx/add0/c7 ),
    .o({\utx/add0/c8 ,\utx/n14 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u8  (
    .a(\utx/bcnt [8]),
    .b(1'b0),
    .c(\utx/add0/c8 ),
    .o({\utx/add0/c9 ,\utx/n14 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \utx/add0/u9  (
    .a(\utx/bcnt [9]),
    .b(1'b0),
    .c(\utx/add0/c9 ),
    .o({\utx/add0/c10 ,\utx/n14 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \utx/add0/ucin  (
    .a(1'b0),
    .o({\utx/add0/c0 ,open_n91}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_0  (
    .a(uartbaud[0]),
    .b(\utx/bcnt [0]),
    .c(\utx/lt0_c0 ),
    .o({\utx/lt0_c1 ,open_n92}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_1  (
    .a(uartbaud[1]),
    .b(\utx/bcnt [1]),
    .c(\utx/lt0_c1 ),
    .o({\utx/lt0_c2 ,open_n93}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_10  (
    .a(uartbaud[10]),
    .b(\utx/bcnt [10]),
    .c(\utx/lt0_c10 ),
    .o({\utx/lt0_c11 ,open_n94}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_11  (
    .a(uartbaud[11]),
    .b(\utx/bcnt [11]),
    .c(\utx/lt0_c11 ),
    .o({\utx/lt0_c12 ,open_n95}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_12  (
    .a(uartbaud[12]),
    .b(\utx/bcnt [12]),
    .c(\utx/lt0_c12 ),
    .o({\utx/lt0_c13 ,open_n96}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_13  (
    .a(uartbaud[13]),
    .b(\utx/bcnt [13]),
    .c(\utx/lt0_c13 ),
    .o({\utx/lt0_c14 ,open_n97}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_14  (
    .a(uartbaud[14]),
    .b(\utx/bcnt [14]),
    .c(\utx/lt0_c14 ),
    .o({\utx/lt0_c15 ,open_n98}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_15  (
    .a(uartbaud[15]),
    .b(\utx/bcnt [15]),
    .c(\utx/lt0_c15 ),
    .o({\utx/lt0_c16 ,open_n99}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_2  (
    .a(uartbaud[2]),
    .b(\utx/bcnt [2]),
    .c(\utx/lt0_c2 ),
    .o({\utx/lt0_c3 ,open_n100}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_3  (
    .a(uartbaud[3]),
    .b(\utx/bcnt [3]),
    .c(\utx/lt0_c3 ),
    .o({\utx/lt0_c4 ,open_n101}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_4  (
    .a(uartbaud[4]),
    .b(\utx/bcnt [4]),
    .c(\utx/lt0_c4 ),
    .o({\utx/lt0_c5 ,open_n102}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_5  (
    .a(uartbaud[5]),
    .b(\utx/bcnt [5]),
    .c(\utx/lt0_c5 ),
    .o({\utx/lt0_c6 ,open_n103}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_6  (
    .a(uartbaud[6]),
    .b(\utx/bcnt [6]),
    .c(\utx/lt0_c6 ),
    .o({\utx/lt0_c7 ,open_n104}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_7  (
    .a(uartbaud[7]),
    .b(\utx/bcnt [7]),
    .c(\utx/lt0_c7 ),
    .o({\utx/lt0_c8 ,open_n105}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_8  (
    .a(uartbaud[8]),
    .b(\utx/bcnt [8]),
    .c(\utx/lt0_c8 ),
    .o({\utx/lt0_c9 ,open_n106}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_9  (
    .a(uartbaud[9]),
    .b(\utx/bcnt [9]),
    .c(\utx/lt0_c9 ),
    .o({\utx/lt0_c10 ,open_n107}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \utx/lt0_cin  (
    .a(1'b1),
    .o({\utx/lt0_c0 ,open_n110}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \utx/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\utx/lt0_c16 ),
    .o({open_n111,\utx/utx_ovfl }));
  reg_sr_as_w1 \utx/reg0_b0  (
    .clk(clk),
    .d(\utx/n14 [0]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [0]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b1  (
    .clk(clk),
    .d(\utx/n14 [1]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [1]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b10  (
    .clk(clk),
    .d(\utx/n14 [10]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [10]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b11  (
    .clk(clk),
    .d(\utx/n14 [11]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [11]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b12  (
    .clk(clk),
    .d(\utx/n14 [12]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [12]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b13  (
    .clk(clk),
    .d(\utx/n14 [13]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [13]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b14  (
    .clk(clk),
    .d(\utx/n14 [14]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [14]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b15  (
    .clk(clk),
    .d(\utx/n14 [15]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [15]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b2  (
    .clk(clk),
    .d(\utx/n14 [2]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [2]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b3  (
    .clk(clk),
    .d(\utx/n14 [3]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [3]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b4  (
    .clk(clk),
    .d(\utx/n14 [4]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [4]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b5  (
    .clk(clk),
    .d(\utx/n14 [5]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [5]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b6  (
    .clk(clk),
    .d(\utx/n14 [6]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [6]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b7  (
    .clk(clk),
    .d(\utx/n14 [7]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [7]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b8  (
    .clk(clk),
    .d(\utx/n14 [8]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [8]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg0_b9  (
    .clk(clk),
    .d(\utx/n14 [9]),
    .en(1'b1),
    .reset(\utx/n13 ),
    .set(1'b0),
    .q(\utx/bcnt [9]));  // rtl/uart_tx.v(57)
  reg_sr_as_w1 \utx/reg1_b0  (
    .clk(clk),
    .d(bdatw[0]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [0]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/reg1_b1  (
    .clk(clk),
    .d(bdatw[1]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [1]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/reg1_b2  (
    .clk(clk),
    .d(bdatw[2]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [2]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/reg1_b3  (
    .clk(clk),
    .d(bdatw[3]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [3]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/reg1_b4  (
    .clk(clk),
    .d(bdatw[4]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [4]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/reg1_b5  (
    .clk(clk),
    .d(bdatw[5]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [5]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/reg1_b6  (
    .clk(clk),
    .d(bdatw[6]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [6]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/reg1_b7  (
    .clk(clk),
    .d(bdatw[7]),
    .en(\utx/n2 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\utx/uarttdat [7]));  // rtl/uart_tx.v(36)
  reg_sr_as_w1 \utx/txctl/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux1_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/txctl/utx_stat [0]));  // rtl/uart_tx_fsm.v(101)
  reg_sr_as_w1 \utx/txctl/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux1_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/txctl/utx_stat [1]));  // rtl/uart_tx_fsm.v(101)
  reg_sr_as_w1 \utx/txctl/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux1_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/txctl/utx_stat [2]));  // rtl/uart_tx_fsm.v(101)
  reg_sr_as_w1 \utx/txctl/reg0_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux1_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/txctl/utx_stat [3]));  // rtl/uart_tx_fsm.v(101)
  reg_sr_as_w1 \utx/txctl/reg1_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [1]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [2]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [3]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b4  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b4_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [4]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b5  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b5_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [5]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b6  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b6_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [6]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b7  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b7_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [7]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b8  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\utx/txctl/mux0_b8_sel_is_3_o ),
    .set(1'b0),
    .q(\utx/utx_tran [8]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/txctl/reg1_b9  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(\utx/txctl/mux0_b9_sel_is_1_o ),
    .set(1'b0),
    .q(\utx/utx_tran [9]));  // rtl/uart_tx_fsm.v(93)
  reg_sr_as_w1 \utx/utx_avail_reg  (
    .clk(clk),
    .d(utx_full_d),
    .en(1'b1),
    .reset(\utx/n8 ),
    .set(1'b0),
    .q(utx_full));  // rtl/uart_tx.v(46)

endmodule 

