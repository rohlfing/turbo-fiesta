// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu May 17 11:17:28 2018
// Host        : DESKTOP-PEMHL9R running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/arohl/Vivado_Projects/turbo_fiesta/turbo_fiesta.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_stub.v
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2017.4" *)
module blk_mem_gen_0(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[7:0],addra[9:0],dina[63:0],douta[63:0],clkb,enb,web[7:0],addrb[9:0],dinb[63:0],doutb[63:0]" */;
  input clka;
  input ena;
  input [7:0]wea;
  input [9:0]addra;
  input [63:0]dina;
  output [63:0]douta;
  input clkb;
  input enb;
  input [7:0]web;
  input [9:0]addrb;
  input [63:0]dinb;
  output [63:0]doutb;
endmodule
