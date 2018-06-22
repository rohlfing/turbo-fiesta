// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu May 17 11:20:50 2018
// Host        : DESKTOP-PEMHL9R running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/arohl/Vivado_Projects/turbo_fiesta/turbo_fiesta.srcs/sources_1/ip/uart_bit_ctr/uart_bit_ctr_stub.v
// Design      : uart_bit_ctr
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_counter_binary_v12_0_11,Vivado 2017.4" *)
module uart_bit_ctr(CLK, THRESH0, Q)
/* synthesis syn_black_box black_box_pad_pin="CLK,THRESH0,Q[3:0]" */;
  input CLK;
  output THRESH0;
  output [3:0]Q;
endmodule
