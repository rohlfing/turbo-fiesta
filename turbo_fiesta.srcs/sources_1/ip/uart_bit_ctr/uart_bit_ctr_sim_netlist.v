// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Fri Jun 29 21:12:56 2018
// Host        : DESKTOP-PEMHL9R running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/arohl/Vivado_Projects/turbo_fiesta/turbo_fiesta.srcs/sources_1/ip/uart_bit_ctr/uart_bit_ctr_sim_netlist.v
// Design      : uart_bit_ctr
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "uart_bit_ctr,c_counter_binary_v12_0_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_11,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module uart_bit_ctr
   (CLK,
    THRESH0,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 thresh0_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME thresh0_intf, LAYERED_METADATA undef" *) output THRESH0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [3:0]Q;

  wire CLK;
  wire [3:0]Q;
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
  (* C_WIDTH = "4" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1010" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "1001" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  uart_bit_ctr_c_counter_binary_v12_0_11 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1010" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "1" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "1" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1001" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "4" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "c_counter_binary_v12_0_11" *) (* downgradeipidentifiedwarnings = "yes" *) 
module uart_bit_ctr_c_counter_binary_v12_0_11
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
  input [3:0]L;
  output THRESH0;
  output [3:0]Q;

  wire CLK;
  wire [3:0]Q;
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
  (* C_WIDTH = "4" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1010" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "1001" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  uart_bit_ctr_c_counter_binary_v12_0_11_viv i_synth
       (.CE(1'b0),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0}),
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
m7aAZPuMpsG1iS0FT+xbm9A53plxFN5GD7uhUuC4CLcQ039FoxxqdkWVRctvfr17kOLPX03nuVv/
h9K9t3Pj7RzhnKvCujWWi+VV6KyuM1kQa5JnRkqqEJ6PsQ9GISjMM6Sk+Zh3+9c+xCbiMUGBKcJe
5bYhD0kKyHCExbKzW33bv8XrM3swmifXFZzi25Qgs7S/HgE8gjmSSF2L6mZF9q+0tb2YiyVxdIVI
PDDrXgrcXAj40FPDV0IvFrP7hHE+DMCV2mLcwK91w3HzFSRS+CXtf7r2HzNXDRfdCSPNvNxEOBxO
vOHF0yFf2pjehTAl/PWq0C9GSUFITyykVs/Row==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
24t+1uJJHaaLtdI0JIrafwEWb2N8FjTvQOf+fBtc9pLNeleUU/ZtHpux9FC6aVWG9sPaOlx1pEJd
uosFTXC0/80pxvc3nsdYaJZmbOj+Hhw5ApRXOAjR5ZMZTLjRF3pYkEsmpC+kO0g1VyrtNSgKN+Yw
id6FUNXPeS6j/cEOeYvWW7THRpXdcxXUShcdfwNieKtxi+S8+inkC/NCZsHxLOoV+zFehwTe/Dn9
mjMQfsvI3r2vbY9yvEiuVuEG9GOvsG9sn2Yo0IqzJ+6eGmTghX/NLQEHp76rFEMMtpLeAdqxbebt
UvuMjrkPflnDoBIIyQTombLYz12tr1K4q2PmZQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 4896)
`pragma protect data_block
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
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
