// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu May 17 11:27:57 2018
// Host        : DESKTOP-PEMHL9R running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/arohl/Vivado_Projects/turbo_fiesta/turbo_fiesta.srcs/sources_1/ip/uart_clk_div/uart_clk_div_sim_netlist.v
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
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [9:0]Q;

  wire CLK;
  wire [9:0]Q;
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
  (* C_WIDTH = "10" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1101100100" *) 
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
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1101100100" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "1" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "1" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "100000000" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "10" *) 
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
  input [9:0]L;
  output THRESH0;
  output [9:0]Q;

  wire CLK;
  wire [9:0]Q;
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
  (* C_WIDTH = "10" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1101100100" *) 
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
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
Zi7NAzlbyvLWE+nu+ATVIXzWMDG46/PFcqJQPBkHbN6+WfTc1g92HZggCQXIGFD8By370S3q6qxf
EeWw8HPqR/eDkbT2GDdpvYNa7Jp2HCcjd7FMCQPS+64bVyb2uqxwRuBZ6QMElRRxLiJ0gxZoKZBh
2x1ya7iYrGBqybMxwMHyoDpoQwrzJMqKABDn3nw9vf1sp7rMKVa5/zM19SkRlFjAElKz/5u6jXLb
+mWT3yBDPVmvooQLnXJfhlQK48PcFOcNnrK4BRBjoJ5w/ri/5u3l8fhjDIA3lGJN7hglgLs3TYHm
g/D8lm5Q4Bu1vfn7TvNk/wueFQ7v1ttTuFEBSA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cCXJ3vitUTNT+GFy0Lao+8tEoYxfsS7bXxrizJMPA9ChIx2f5TqvLgsFUDk2Aee5uiTUtptro0Tb
g68Jbz6Ow4ziurYlaOOumt1UK7f8EqdERwNLmyvYZq/vwIiXN5OrPPljuToremBNNs6YyJFs17L0
/RzY4Wt4IsGm3w2tsqLm6FPVOmsfcpTqhaeCOvsNEX5JET8LD7ns1SkmadceMKCLC4vJ6CNNuEl1
NVM2eMB6QrOhmSden7QZ/i3DgFldWKai1BzQ+ek9HGoIOm0X0yYOwPwXYKUqrdW0Ju8TDes71viX
t4w0iuJZb1XhQb32OwFEWStuDL8ohQzTjxR7JA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7584)
`pragma protect data_block
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
MsmZ
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
