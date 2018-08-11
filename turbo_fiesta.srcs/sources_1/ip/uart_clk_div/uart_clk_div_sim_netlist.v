// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Aug  2 18:58:52 2018
// Host        : DESKTOP-PEMHL9R running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/arohl/Vivado_Projects/turbo_fiesta/turbo_fiesta.srcs/sources_1/ip/uart_clk_div/uart_clk_div_sim_netlist.v
// Design      : uart_clk_div
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "uart_clk_div,c_counter_binary_v12_0_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_11,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module uart_clk_div
   (CLK,
    THRESH0,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 thresh0_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME thresh0_intf, LAYERED_METADATA undef" *) output THRESH0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [31:0]Q;

  wire CLK;
  wire [31:0]Q;
  wire THRESH0;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1101100011" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "100000000" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  uart_clk_div_c_counter_binary_v12_0_11 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1101100011" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "1" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "1" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "100000000" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "32" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "c_counter_binary_v12_0_11" *) (* downgradeipidentifiedwarnings = "yes" *) 
module uart_clk_div_c_counter_binary_v12_0_11
   (CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    UP,
    LOAD,
    L,
    THRESH0,
    Q);
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  input UP;
  input LOAD;
  input [31:0]L;
  output THRESH0;
  output [31:0]Q;

  wire CLK;
  wire [31:0]Q;
  wire THRESH0;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1101100011" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "100000000" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  uart_clk_div_c_counter_binary_v12_0_11_viv i_synth
       (.CE(1'b0),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
iO2Bdkfy0dqqValMR4KhTWXpD0gDQF+kyoly3tZBTZTVs0CbWJ4Owhu4jxMCf8X2gbWR6iweF6Ks
B5dmLHZTDA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
dbcEbgyZfx3YLmYpvjegvD9sRQCV1qBv0GqFBvCakC3SMR/H82zqo5uv5MZldBGUVmNHnxF3Vejx
zSqxUKfTNc90CS6quuoQe0eeq3T5XSdgwbNtjPZKvJuJTmQKT96yB3CfQOz13fGjaLrn/8NBUBBh
I7OEoGGg7ADph9V3vRg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bD3a4YgAnaoJx9/hljj2C1rODcUhawTVE1gtdPkNj8/YjemaFM6/sF7Q0CXbDJ7a+OBrB5pUgj3O
Vesi4yVmFp+mGmFarftWat5KmZiP3RVWrXwdzMj+f8T7p+lE3iD4njqUxIUz0TsUaNvFeW0xVNNb
OwTEX04nyt5HrU82dltJCclpFxE6yrP9YvI7l328bphwnC63xxk8T3yXwCrvj3VrIYuDT2yMRxrB
TBCv/Fe2f07JQyV73J7+DGAeJG0B1dTHeu48auQT63g1HsYaUXREihEUKgZe70QlOqlPbrr6Quhx
2LXE8LSdCA+FbJ7LlQc/Sgasj3ZYjM5lhEKleQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GCfR7acMSeEtOw1DhZKkUXjh9Uw/vUar7CGDRG9rZcB9NFDtQTltJeuKjFg8eaeKH9HFBMryuX72
/tmzhtFaiSTjr2na4ncL2XV3QRXe7nQaiHdc7cKBcZDvdSSMzOSYcIxLunwLwQTLC7sCvINmlxO1
NXnYzJVL1xb9HP8QVnSYpo1p+gCXcRBZzrOjZjCUnl7F2t3ZZStSGjBEyXVLnV+ouU3+247oJAOa
kC7v+pOtG2ho4KclIg0MGijjPs+jyOFU+b5C+ufQp/zL9GiZ5waCjb/0Y1vkBc9jZKR7YRnv+ASG
ju1uP8oqEXR9742kXRnW4HkMKkCK1MLDgWYdqw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L+AGKmFZ1zoRJFd2cA+zxJhkgQ1R0aEjGQCGRFLNNhLHZXpzGDIjdSLjralBVRJ2rD6UcJutapF5
YaMoV9kphGGG2B07dxBuIimVjOxS3ZQJ7ru59ddfGBxUe9EHrv00Q5hTwoxig0lxqnmjSSnfsDeF
weTIqNnXkG5kqqezKC8a2FvUD5QWQBibhK69OAdmhhIOwZmpfvQKbEKgLX70BzcNlmLnttRL7G+q
XZ3fabZ42+JJHDLiIfveB3Gp2Lf2tzTH1u2xx5aEUr9154pnC9PWIwL3y3VBAT1oHR7ScdoGDOEy
HoYUiDibldOidIeKW0KrTeAIuBNmtM4R0R+RSA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
V5ClnklUs5Wo++EDemG/KeowZlAfqB8SUrvSxPQGrdIwGfUvoCajhuABAWdS/L/pQl7Eyz51aiuw
KzPMrWtQozAEITf1xzvzgKbWZqoi4PQD3rThywFsFq60u8DdvHYM/kEvit0cZVFvG8rAbtlseHLu
0vU1kbrNgxb3bxjOovg=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cRqAgScIUeXUwYGfCC0XDtpcc+mFNm3p8oTcFdtIU1nnlMagpBMqRm5ELc+m/Yw8jBwvcvt4tUFv
u/ypEEw+y12B+5Pr6SmnLJ+NVB3Q3Eyh4Q/d7p3jReIIsUxrlENpCTi4PVXMKr1B1Htzm8F8mXDq
y2UV+0SC+4yrBIntsdS0S8jPBERhfJhzNC5z38pPHANtM4wGGIUuKxIALLz1aq+2AjLbEgFHNrzw
2bJiDwRSTwrY4Yx2MSzYJk3O+cQBUe8nJDPx+aGEvDzQ4ZdJMNg2z+iaiE7OTaqK492Jb/1jvU0j
wlI+n35s2rrnc9QgfljdOJuueruPuYDi5vTTxA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FrxsOL7WWNmq0Fq6rI7m+n63sC7a/OPLcp7lUd9EByaucJOV2w2S689mZZ1EubMK4lIjGMdsU54L
TwLbJcfTaaPyF+t1xiku/jQgSI62yK+Sp4gHALvyUc1JTAW2p9N959YslQsqNy3UevuFALS/dgyz
F7OOIqvtHLCPUOahauvYrMkjcaSyHqfsQTH72avw8HWM154aCIigToWp11vnVGlCQNkpBE84neQJ
YdkugzK4iUvAZ2gMQ+1utGeZK8fGc6rCivTPIqEHFGl62kpIp0qIOL3NThpQWBH1FZN/xvxQuaDV
RXCarhvxm1fSeelNBBxzvWg0Ccsf+IwlXtlBLQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1sOSHx1MX8eiLCIAVnp/5ZD9w/HxJOZRumVyG3bOzgOhAcRdw1Q2BPIzCtQAqK9KqVlx/FKEf75S
CwxC/RhYYsYL7hNHsZQ1nRH+FGhpnWdBUZdGDP+FqCuRK02pqV5nxHvfFMJ9TZG+oTkGfigP4XwJ
lic7p4R/i7rdw/Wor4QUqOgSSPbPO0GyMoPn5wHTtS0HPCQk6kQ2KlmrBx6yF7if775U3VtScI0I
i5nzr5b6d9VOLIymVRB+/VIEn6xTuBtMnomMnHOyBL8h/ig7kOVeGTDxihltJm80zj0iSarlEG6m
tc17fEEggYdHv4OwB2smqW74gcY2ryLaHFDxcA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 14768)
`pragma protect data_block
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
M4x320Q=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
