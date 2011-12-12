`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:42 12/06/2011 
// Design Name: 
// Module Name:    trans_cr 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module trans_cr(
	// --- Clk & Rst ---
	clk,
	clk_400MHz,
	rst,

	// --- luma input ---
	y,
	y_valid,

	// --- luma output ---
   	trans_cr_output,
	trans_cr_output_valid

);
	
	//--------------------------
	// Parameters
   	//--------------------------
	parameter	K_l			= 16'd125;
	parameter	K_h			= 16'd188;
	parameter	Cr
	parameter	W_Cb
	

	//--------------------------
   	// Input Ports
   	//--------------------------
	// --- CLK & RESET ---
	input					clk;
	input					clk_400MHz;
	input					rst;
	
	// --- Data inputs ---
	input	[7 : 0]			y;
	input					y_valid;

	//--------------------------
   	// Output Ports
   	//--------------------------
	// --- Outputs ----

	
	//--------------------------
   	// Bidirectional Ports
   	//--------------------------


   	///////////////////////////////////////////////////////////////////
   	// Begin Design
   	///////////////////////////////////////////////////////////////////
   
   	//-------------------------------------------------
   	// Signal Declarations: reg
   	//-------------------------------------------------
	// --- Combinational ---
	
	// --- Register ---
	reg		[23 : 0]		multiply_product_reg;
	reg		[23 : 0]		add_result_reg;


   	//-------------------------------------------------
   	// Signal Declarations: wire
   	//-------------------------------------------------
	wire	[17 : 0]		mean_cr_output_Kh;
	wire					mean_cr_output_valid_Kh;
	wire	[17 : 0]		mean_cr_output_y;
	wire					mean_cr_output_valid_y;
	wire	[17 : 0]		width_cr_output_y;
	wire					width_cr_output_valid_y;
	
	wire	[17 : 0]		divider_dividend;
	
	wire	[17 : 0]		divisor_fifo_din;
	wire					divisor_fifo_wren;
	wire	[17 : 0]		divisor_fifo_dout;
	wire					divisor_fifo_rden;	
	wire					divisor_fifo_empty;
	
	wire	[17 : 0]		divider_quotient;
	wire					divider_rfd;
	
	wire	[17 : 0]		result_fifo_din;
	wire	 				result_fifo_wren;
	wire	[17 : 0]		result_fifo_dout;
	wire					result_fifo_rden;	
	wire					result_fifo_empty;

	
	
	wire	[17 : 0]		cr_meancr_difference;
	wire	[35 : 0]		multiply_product;

	
	//---------------------------------------------------------------
   	// Assignments
   	//---------------------------------------------------------------
	assign	divider_dividend	= W_Cr;
	assign	divisor_fifo_din	= width_cr_output_y;
	assign	divisor_fifo_wren	= width_cr_output_valid_y;	
	assign	divisor_fifo_rden	= ~divisor_fifo_empty & divider_rfd;
	
	assign	result_fifo_din		= divider_quotient;
	assign	result_fifo_wren	= divider_rfd
	assign	result_fifo_rden	= ~result_fifo_empty;	
	
	
	assign	mulitply_integer		= result_fifo_dout;
	assign	cr_meancr_difference	= Cr - mean_cr_output_y;
	assign	multiply_product		= cr_meancr_difference * result_fifo_dout;
	
	assign	add_result				= multiply_product_reg + mean_cr_output_Kh << 9;
	//---------------------------------------------------------------
   	// Combinatorial Logic
   	//---------------------------------------------------------------
	
	
   	//---------------------------------------------------------------
   	// Sequential Logic
   	//---------------------------------------------------------------
	always @(posedge clk) begin
		if (rst) begin
			multiply_product_reg		= 0;
			add_result_reg				= 0;
		end
		else begin
			multiply_result_reg			= multiply_product;
			add_result_reg				= add_result;
		end
	end
	
	
	//---------------------------------------------------------------
   	// Modules instantiation
   	//---------------------------------------------------------------
	//---- MeanCr for K_h ----
	mean_cr
	mean_cr_kh(
		.clk(clk),
		.clk_400MHz(clk_400MHz),
		.rst(rst),
		.y(K_h),
		.y_valid(y_valid),
		.mean_cr_output(mean_cr_output_Kh),
		.mean_cr_output_valid(mean_cr_output_valid_Kh)
	);
	
	
	//---- MeanCr for Y ----
	mean_cr
	mean_cr_y(
		.clk(clk),
		.clk_400MHz(clk_400MHz),
		.rst(rst),
		.y(y),
		.y_valid(y_valid),
		.mean_cr_output(mean_cr_output_y),
		.mean_cr_output_valid(mean_cr_output_valid_y)
	);
	
	width_cr
	width_cr_y(
		.clk(clk),
		.clk_400MHz(clk_400MHz),
		.rst(rst),
		.y(y),
		.y_valid(y_valid),
		.width_cr_output(width_cr_output_y),
		.width_cr_output_valid(width_cr_output_valid_y)
	);
	
	//--- divisor fifo ---
	divisor_fifo
	divisor_fifo_inst(
		.rst(rst),
		.wr_clk(clk),
		.rd_clk(clk_400MHz),
		.din(divisor_fifo_din),
		.wr_en(divisor_fifo_wren),
		.rd_en(divisor_fifo_rden),
		.dout(divisor_fifo_dout),
		.full(),
		.empty(divisor_fifo_empty)
	);
	
	//--- divider ---	
	divider
	divider_inst(
  		.rfd(divider_rfd),
		.clk(clk_400MHz),
		.dividend(divider_dividend),
		.divisor(divisor_fifo_dout),
		.quotient(divider_quotient),
		.fractional(divider_fractional)
	);	
	
	
	result_fifo
	result_fifo_inst(
		.rst(rst),
		.wr_clk(clk_400Mhz),
		.rd_clk(clk),
		.din(result_fifo_din),
		.wr_en(divider_rfd),
		.rd_en(result_fifo_rden),
		.dout(result_fifo_dout),
		.full(),
		.empty(divisor_fifo_empty)
	);	
endmodule







