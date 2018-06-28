// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Wed Jun 27 22:00:00 2018
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
  (* c_count_to = "1001" *) 
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
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1001" *) (* C_FB_LATENCY = "0" *) 
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
  (* c_count_to = "1001" *) 
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
oleHrfY+kfMnPT9CzB+MAhv3PHnrwpeBBWP9mhyubmDekwiDY6H8jrTI43A7O6t7aQMKsgHifakK
uQ4ozcoNcgeSSA+CXp5bqEjldi2H1TltFST5C3MxhPpbr9L3rRfObgHkM+s9XXGWZfMKCiJrzXfH
LF/pdaVekF15RCjchWGXwYpvJ/P4Qk625ipAzf5zZ0zhy5JDrZjxUKEaKyf/6RQqPsWhiPIknkzr
l/tfkeJiYw7sbF7MBhqnZ+FHMWHc1nJVUL02KuVjkbuhfA8C92GlKbSzArygHvamf1dfSQlaCKzO
6UP245OQ+pBO7T3kSnhR1fmAGRKz0x0JxY13tQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
J5vFZBECZr0ShSbySloagLvK2HjIlMxBKwZz2zTs0mrWALODjQa1OpNhvT7BZmGIFNZK45lz/02i
R/tzfTrTpgi19wvPtFPHEYeojBX+nlfl7IFyHhf7IrSFUYqNIy4QhAbUUo6QceAm+xglXvF7XhKd
3M0xDVl82pmChXgW4DCH2jl9S1nhkd1DaeLsjyRzTUxUL/wnmOr+IroTvspgeDHty2JR6J9l2cJ5
q335lgxCF5OI4VvQWmbHewrdCVAzsIloVaaX4I2yRpXFUduXSpNtolGD9EZvXBU9GV2G/U6tdtpQ
xHcg8jjjiO+d0IW3eNDurLB5j/2RSLZ7Xl9Epw==

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
