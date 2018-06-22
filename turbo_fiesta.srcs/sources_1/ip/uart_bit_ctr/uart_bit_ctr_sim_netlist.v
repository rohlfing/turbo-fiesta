// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu May 17 11:20:50 2018
// Host        : DESKTOP-PEMHL9R running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/arohl/Vivado_Projects/turbo_fiesta/turbo_fiesta.srcs/sources_1/ip/uart_bit_ctr/uart_bit_ctr_sim_netlist.v
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
  (* c_count_to = "1110" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "1101" *) 
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
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1110" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "1" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "1" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1101" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "4" *) 
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
  (* c_count_to = "1110" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "1101" *) 
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
p+l9GnXyKg6WNo3irDDz7Qpq8uL18xmUQBNH8+7TxGArkMNYSE/D3ZtMEEhDKXaQuvAkAP8g3YVq
DUVQAvT0mSMcFXiQO/HwGxTKTFaAy3yPZnvlFHeoLZbXrDEQGY+2LTTdV/dFeK4MzTpVy4U7mLlV
YDMH/iS/wL0uMCKpzuet/OeOHepF7o8ib+t51r1liGHRPPzCGVvPPbJ62eYHrMaKIXQMyqexXz93
f3RlssIsyqtRBfR5R6VOhjVKkze+CdLQ/dlUgfm6gHUrA2KvGPieplm/SPeJTNG/OxVnRTpF58Zh
tNwfzFXMkX86xam4XZ+w14bgk6AUqGis+C0HrQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BWdSprXOA589yjgV6J1ER5qT40QysLODuYG1mxNjM1i0EO9x6hEN1QoQd+yUS1bz9ERsZ2i78TO1
5J/zluKNGKg2X9eSm+Hcd+D26JUmI4JauP84HaOU3dv7FXrV6oMwlOih2cAHJk0NKauf2eWqMCSD
wQc3QZkHxHEUAMEMljTkGVDVAu5/yG3FJswlgFEGslmgSGH3AjFOG4YIVDY0wgVzQKBdgxQm0Y1M
vWIo5hILpWdAK+qP2zaHMovmJ4PYm5hXkvoQ/pH1eYfjF+97emj2gmAxcRm9z/ycnVqCumPWVltT
SWz+ErCd28TnAhQ4ZtXJeCwfbe/uo2GAS2cS9Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 4960)
`pragma protect data_block
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
iw==
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
