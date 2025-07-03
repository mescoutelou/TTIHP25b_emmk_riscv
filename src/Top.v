/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_emmk_riscv (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  // Default
  wire _unused = &{ena, 7'b000000};

  // Boot
  wire w_boot;

  assign w_boot = ui_in[0];

  // UART
  wire w_uart_rx;
  wire w_uart_tx;

  assign w_uart_rx = ui_in[3];

  // GPIO
  wire [7:0] w_gpio_eno;
  wire [7:0] w_gpio_out;
  wire [7:0] w_gpio_in;

  assign w_gpio_in[0] = (!w_gpio_eno[0] & uio_in[0]) | ui_in[0];
  assign w_gpio_in[1] = (!w_gpio_eno[1] & uio_in[1]) | ui_in[1];
  assign w_gpio_in[2] = (!w_gpio_eno[2] & uio_in[2]) | ui_in[2];
  assign w_gpio_in[3] = (!w_gpio_eno[3] & uio_in[3]) | ui_in[3];
  assign w_gpio_in[4] = (!w_gpio_eno[4] & uio_in[4]) | ui_in[4];
  assign w_gpio_in[5] = (!w_gpio_eno[5] & uio_in[5]) | ui_in[5];
  assign w_gpio_in[6] = (!w_gpio_eno[6] & uio_in[6]) | ui_in[6];
  assign w_gpio_in[7] = (!w_gpio_eno[7] & uio_in[7]) | ui_in[7];

  assign uio_oe = w_gpio_eno;

  assign uio_out[0] = w_gpio_out[0];
  assign uio_out[1] = w_gpio_out[1];
  assign uio_out[2] = w_gpio_out[2];
  assign uio_out[3] = w_gpio_out[3];
  assign uio_out[4] = w_gpio_out[4];
  assign uio_out[5] = w_gpio_out[5];
  assign uio_out[6] = w_gpio_out[6];
  assign uio_out[7] = w_gpio_out[7];

  assign uo_out[0] = w_gpio_eno[0] & w_gpio_out[0];
  assign uo_out[1] = w_gpio_eno[1] & w_gpio_out[1];
  assign uo_out[2] = w_gpio_eno[2] & w_gpio_out[2];
  assign uo_out[3] = w_gpio_eno[3] & w_gpio_out[3];
  assign uo_out[4] = w_uart_tx;
  assign uo_out[5] = w_gpio_eno[5] & w_gpio_out[5];
  assign uo_out[6] = w_gpio_eno[6] & w_gpio_out[6];
  assign uo_out[7] = w_gpio_eno[7] & w_gpio_out[7];

  // System (generated with Chisel)
  Sys m_sys (
    .clock          (clk        ),
    .reset          (!rst_n     ),
     
    .io_i_boot      (w_boot     ),
    .io_b_uart_rx   (w_uart_rx  ),
    .io_b_uart_tx   (w_uart_tx  ),

    .io_b_gpio_eno  (w_gpio_eno ),
    .io_b_gpio_out  (w_gpio_out ),
    .io_b_gpio_in   (w_gpio_in  )
  );
endmodule