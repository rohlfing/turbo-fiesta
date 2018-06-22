-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Thu May 17 11:27:57 2018
-- Host        : DESKTOP-PEMHL9R running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/arohl/Vivado_Projects/turbo_fiesta/turbo_fiesta.srcs/sources_1/ip/uart_clk_div/uart_clk_div_stub.vhdl
-- Design      : uart_clk_div
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_clk_div is
  Port ( 
    CLK : in STD_LOGIC;
    THRESH0 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );

end uart_clk_div;

architecture stub of uart_clk_div is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,THRESH0,Q[9:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_counter_binary_v12_0_11,Vivado 2017.4";
begin
end;
