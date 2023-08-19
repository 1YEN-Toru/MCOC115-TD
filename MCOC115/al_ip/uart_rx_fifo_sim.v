// Verilog netlist created by TD v4.6.18154

`timescale 1ns / 1ps
module uart_rx_fifo  // al_ip/uart_rx_fifo.v(14)
  (
  clk,
  di,
  re,
  rst,
  we,
  aempty_flag,
  afull_flag,
  do,
  empty_flag,
  full_flag
  );

  input clk;  // al_ip/uart_rx_fifo.v(24)
  input [7:0] di;  // al_ip/uart_rx_fifo.v(23)
  input re;  // al_ip/uart_rx_fifo.v(25)
  input rst;  // al_ip/uart_rx_fifo.v(22)
  input we;  // al_ip/uart_rx_fifo.v(24)
  output aempty_flag;  // al_ip/uart_rx_fifo.v(28)
  output afull_flag;  // al_ip/uart_rx_fifo.v(29)
  output [7:0] do;  // al_ip/uart_rx_fifo.v(27)
  output empty_flag;  // al_ip/uart_rx_fifo.v(28)
  output full_flag;  // al_ip/uart_rx_fifo.v(29)

  wire empty_flag_neg;
  wire full_flag_neg;

  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  not empty_flag_inv (empty_flag_neg, empty_flag);
  not full_flag_inv (full_flag_neg, full_flag);
  EG_PHY_FIFO #(
// 1YEN_211106: small AE for simulation
    .AE(32'b00000000000000000000100000000000),
    .AEP1(32'b00000000000000000000100000001000),
    .AF(32'b00000000000000000001100000000000),
    .AFM1(32'b00000000000000000001011111111000),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("9"),
    .DATA_WIDTH_B("9"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000001000),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111000),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("SYNC"))
    logic_fifo_0 (
    .clkr(clk),
    .clkw(clk),
// 1YEN_210205: *_neg signals were 1'bx...?
//    .csr({2'b11,empty_flag_neg}),
.csr(3'b111),
//    .csw({2'b11,full_flag_neg}),
.csw(3'b111),
    .dia({open_n47,di}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .aempty_flag(aempty_flag),
    .afull_flag(afull_flag),
    .dob({open_n66,do}),
    .empty_flag(empty_flag),
    .full_flag(full_flag));

endmodule 

