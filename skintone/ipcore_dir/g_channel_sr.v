////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: L.70
//  \   \         Application: netgen
//  /   /         Filename: g_channel_sr.v
// /___/   /\     Timestamp: Sun Dec  4 17:40:11 2011
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog /home/mdl/yux106/Neovision/yux106/trunk/Neovision/GEM5/XC/ise/skintone/_cg/g_channel_sr.ngc /home/mdl/yux106/Neovision/yux106/trunk/Neovision/GEM5/XC/ise/skintone/_cg/g_channel_sr.v 
// Device	: 6vlx240tff784-2
// Input file	: /home/mdl/yux106/Neovision/yux106/trunk/Neovision/GEM5/XC/ise/skintone/_cg/g_channel_sr.ngc
// Output file	: /home/mdl/yux106/Neovision/yux106/trunk/Neovision/GEM5/XC/ise/skintone/_cg/g_channel_sr.v
// # of Modules	: 1
// Design Name	: g_channel_sr
// Xilinx        : /home/mdl/Xilinx64/11.1/ISE
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module g_channel_sr (
  clk, d, q
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input [7 : 0] d;
  output [7 : 0] q;
  
  // synthesis translate_off
  
  wire \BU2/sinit ;
  wire \BU2/sset ;
  wire \BU2/sclr ;
  wire \BU2/ce ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_7_26 ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_6_25 ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_5_24 ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_4_23 ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_3_22 ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_2_21 ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_1_20 ;
  wire \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_0_19 ;
  wire \BU2/U0/i_bb_inst/N1 ;
  wire \BU2/U0/i_bb_inst/N0 ;
  wire NLW_VCC_P_UNCONNECTED;
  wire NLW_GND_G_UNCONNECTED;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_7_Q15_UNCONNECTED ;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_6_Q15_UNCONNECTED ;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_5_Q15_UNCONNECTED ;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_4_Q15_UNCONNECTED ;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_3_Q15_UNCONNECTED ;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_2_Q15_UNCONNECTED ;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_1_Q15_UNCONNECTED ;
  wire \NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_0_Q15_UNCONNECTED ;
  wire [7 : 0] d_2;
  wire [7 : 0] q_3;
  wire [3 : 0] \BU2/a ;
  assign
    d_2[7] = d[7],
    d_2[6] = d[6],
    d_2[5] = d[5],
    d_2[4] = d[4],
    d_2[3] = d[3],
    d_2[2] = d[2],
    d_2[1] = d[1],
    d_2[0] = d[0],
    q[7] = q_3[7],
    q[6] = q_3[6],
    q[5] = q_3[5],
    q[4] = q_3[4],
    q[3] = q_3[3],
    q[2] = q_3[2],
    q[1] = q_3[1],
    q[0] = q_3[0];
  VCC   VCC_0 (
    .P(NLW_VCC_P_UNCONNECTED)
  );
  GND   GND_1 (
    .G(NLW_GND_G_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_7  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_7_26 ),
    .Q(q_3[7])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_7  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[7]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_7_26 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_7_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_6  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_6_25 ),
    .Q(q_3[6])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_6  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[6]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_6_25 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_6_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_5  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_5_24 ),
    .Q(q_3[5])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_5  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[5]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_5_24 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_5_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_4  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_4_23 ),
    .Q(q_3[4])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_4  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[4]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_4_23 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_4_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_3  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_3_22 ),
    .Q(q_3[3])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_3  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[3]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_3_22 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_3_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_2  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_2_21 ),
    .Q(q_3[2])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_2  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[2]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_2_21 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_2_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_1  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_1_20 ),
    .Q(q_3[1])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_1  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[1]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_1_20 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_1_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_bb_inst/f0.srl_sig_1_0  (
    .C(clk),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .D(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_0_19 ),
    .Q(q_3[0])
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  \BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_0  (
    .A0(\BU2/U0/i_bb_inst/N0 ),
    .A1(\BU2/U0/i_bb_inst/N0 ),
    .A2(\BU2/U0/i_bb_inst/N0 ),
    .A3(\BU2/U0/i_bb_inst/N0 ),
    .CE(\BU2/U0/i_bb_inst/N1 ),
    .CLK(clk),
    .D(d_2[0]),
    .Q(\BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_0_19 ),
    .Q15(\NLW_BU2/U0/i_bb_inst/Mshreg_f0.srl_sig_1_0_Q15_UNCONNECTED )
  );
  VCC   \BU2/U0/i_bb_inst/XST_VCC  (
    .P(\BU2/U0/i_bb_inst/N1 )
  );
  GND   \BU2/U0/i_bb_inst/XST_GND  (
    .G(\BU2/U0/i_bb_inst/N0 )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire PRLD;

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

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
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

// synthesis translate_on
