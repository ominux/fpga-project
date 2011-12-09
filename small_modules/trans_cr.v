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
   	output	[23 : 0]		mean_cr_output;
	output					mean_cr_output_valid;
	
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
	reg		[23 : 0]		multiply_result_reg;
	reg		[23 : 0]		add_result_reg;
	reg		[1 : 0]			mean_cr_output_valid_reg;

   	//-------------------------------------------------
   	// Signal Declarations: wire
   	//-------------------------------------------------
	wire	[15 : 0]		Y_Ymin_difference;
	wire	[15 : 0]		WCr_WLCr_difference;
	wire	[15 : 0]		Kl_Ymin_difference;
	wire	[15 : 0]		Ymax_Y_difference;
	wire	[15 : 0]		WCr_WHCr_difference;
	wire	[15 : 0]		Ymax_Kh_difference;
	
	wire	[15 : 0]		dividend_fifo_din;
	wire					dividend_fifo_wren;
	wire	[15 : 0]		dividend_fifo_dout;
	wire					dividend_fifo_rden;
	wire					divident_fifo_empty;
	
	wire	[15 : 0]		divisor_fifo_din;
	wire					divisor_fifo_wren;
	wire	[15 : 0]		divisor_fifo_dout;
	wire					divisor_fifo_rden;	
	wire					divisor_fifo_empty;

	wire					divider_rdf;	


	wire	[23 : 0]		result_fifo_din;
	wire	 				result_fifo_wren;
	wire	[23 : 0]		result_fifo_dout;
	wire					result_fifo_rden;	
	wire					result_fifo_empty;
	//---------------------------------------------------------------
   	// Assignments
   	//---------------------------------------------------------------
	assign	Y_Ymin_difference		= Y - Y_min;
	assign	WCr_WLCr_difference		= W_Cb - WL_Cb;
	assign	Kl_Ymin_difference		= K_l - Y_min;
	assign	Ymax_Y_difference		= Y_max - Y;
	assign	WCr_WHCr_difference		= W_Cb - WH_Cb;
	assign	Ymax_Kh_difference		= Y_max - K_h;
		
	
	assign	divider_dividend	= W_Cr;							  
	assign	divisor_fifo_din	= (y_valid && y <= K_l) ? Kl_Ymin_difference :
								  (y_valid && y >= K_h) ? Ymax_Kh_difference : 0;

	assign	divisor_fifo_wren	= y_valid;
	
	assign	divisor_fifo_rden	= ~divisor_fifo_empty & divider_rfd;

	assign	result_fifo_rden	= ~result_fifo_empty;


	assign	mulitply_gain	 	= (y_valid && y <= K_l) ? Y_Ymin_difference : 
								  (y_valid && y >= K_h) ? Ymax_Y_difference : 0;

	assign	add_num			 	= (y_valid && y <= K_l) ? WL_Cb : 
								  (y_valid && y >= K_h) ? WH_Cb : 0;
	
	assign	multiply_result		= (result_fifo_rden == 1) ? (result_fifo_dout * (multiply_gain << 8)) : 0;
	assign	add_result			= (add_num << 8) + multiply_result_reg;
	//---------------------------------------------------------------
   	// Combinatorial Logic
   	//---------------------------------------------------------------
	
	
   	//---------------------------------------------------------------
   	// Sequential Logic
   	//---------------------------------------------------------------
	always @(posedge clk) begin
		if (rst) begin
			multiply_result_reg			= 0;
			add_result_reg				= 0;
			mean_cr_output_valid_reg 	= 0;
		end
		else begin
			multiply_result_reg			= multiply_result;
			add_result_reg				= add_result;
			mean_cr_output_valid_reg[0]	= result_fifo_rden;
			mean_cr_output_valid_reg[1]	= mean_cr_output_valid_reg[0];
		end
	end
	
	
	//---------------------------------------------------------------
   	// Modules instantiation
   	//---------------------------------------------------------------
	//---- MeanCr for K_h ----
	mean_cr
	mean_cr_kh(
		.clk,
		.clk_400MHz,
		.rst,
		.y,
		.y_valid,
		.mean_cr_output,
		.mean_cr_output_valid
	);
	
	
	//---- MeanCr for Y ----
	mean_cr
	mean_cr_y(
		.clk,
		.clk_400MHz,
		.rst,
		.y,
		.y_valid,
		.mean_cr_output,
		.mean_cr_output_valid
	);
	
	width_cr
	width_cr_y(
		.clk,
		.clk_400MHz,
		.rst,
		.y,
		.y_valid,
		.width_cr_output(divisor_fifo_din),
		.width_cr_output_valid(divisor_fifo_wren)
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
endmodule







