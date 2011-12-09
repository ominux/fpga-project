`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:42 12/06/2011 
// Design Name: 
// Module Name:    mean_cr 
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
module mean_cr(
	// --- Clk & Rst ---
	clk,
	clk_400MHz,
	rst,

	// --- luma input ---
	y,
	y_valid,

	// --- luma output ---
   	mean_cr_output,
	mean_cr_output_valid
	

);
	
	//--------------------------
	// Parameters
   	//--------------------------
	parameter	K_l			= 16'd125;
	parameter	K_h			= 16'd188;
	parameter	Y_min		= 16'd16;
	parameter	Y_max		= 16'd235;

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
	wire	[15 : 0]		Kl_Y_difference;
	wire	[15 : 0]		Kl_Ymin_difference;
	wire	[15 : 0]		Y_Kh_difference;
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
	assign	Kl_Y_difference 	= K_l - Y;
	assign	Kl_Ymin_difference	= K_l - Y_min;
	assign	Y_Kh_difference		= Y - K_h;
	assign	Ymax_Kh_difference	= Y_max - K_h;
	
	assign	divident_fifo_din	= (y_valid && y <= K_l) ? K1_Y_difference :
								  (y_valid && y >= K_h) ? Y_Kh_difference : 0;
								  
	assign	divisor_fifo_din	= (y_valid && y <= K_l) ? K1_Y_difference :
								  (y_valid && y >= K_h) ? Y_Kh_difference : 1;

	assign	dividend_fifo_wren	= y_valid;
	assign	divisor_fifo_wren	= y_valid;
	
	assign	dividend_fifo_rden	= ~dividend_fifo_empty & divider_rfd;
	assign	divisor_fifo_rden	= ~divisor_fifo_empty & divider_rfd;

	assign	result_fifo_rden	= ~result_fifo_empty;


	assign	mulitply_gain	 	= (y_valid && y <= K_l) ? 10 : 
								  (y_valid && y >= K_h) ? 22 : 0;

	assign	add_num				= (y_valid && y (<= K_l || y >= K_h)) ? 154 : 0;
	
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
	//---- dividend fifo ----
	dividend_fifo
	dividend_fifo_inst(
		.rst(rst),
		.wr_clk(clk),
		.rd_clk(clk_400MHz),
		.din(divident_fifo_din),
		.wr_en(divident_fifo_wren),
		.rd_en(divident_fifo_rden),
		.dout(divident_fifo_dout),
		.full(),
		.empty(dividend_fifo_empty)
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
		.dividend(divident_fifo_dout),
		.divisor(divisor_fifo_dout),
		.quotient(divider_quotient),
		.fractional(divider_fractional)
	);	

	//--- result fifo ---
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







