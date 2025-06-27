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
  assign uo_out[7:1]  = ui_in[7:2] + uio_in[7:2];
  wire _unused = &{ena, 7'b000000};

  Sys m_riscV(
    .clock          (clk        ),
    .reset          (!rst_n     ),
     
    .io_i_boot      (ui_in[1]   ),
    .io_b_uart_rx   (ui_in[0]   ),
    .io_b_uart_tx   (uo_out[0]  ),
     
    .io_b_gpio_eno  (uio_oe     ),
    .io_b_gpio_out  (uio_out    ),
    .io_b_gpio_in   (uio_in     )
  );
endmodule