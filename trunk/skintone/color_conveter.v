`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:14 12/04/2011 
// Design Name: 
// Module Name:    color_conveter 
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
module color_conveter(
	//-------- CLK, RST --------
	clk,
	rst,
	//------ RGB input -----
	RGB_input,
	RGB_input_valid,

	//------ YCrCb output -------
	YCrCb_output,
	YCrCb_output_valid	
);

	//--------------------------
	// Parameters
	//--------------------------
	parameter	CA		= 16'd38;
	parameter	CB		= 16'd15;
	parameter	CC		= 16'd112;
	parameter	CD		= 16'd63;
	parameter	YOFFSET	= 16'd2048;
	parameter	COFFSET	= 16'd16384;
	
	//--------------------------
	// Input Ports
	//--------------------------
	//-------- CLK, RST --------
	input					clk,
	input					rst,
	//------ RGB input -----
	input	[31 : 0]		RGB_input,
	input					RGB_input_valid,

	//--------------------------
	// Output Ports
	//--------------------------
	//------ YCrCb output -------
	output	[31 : 0]		YCrCb_output,
	output					YCrCb_output_valid	
	
	//--------------------------
	// Bidirectional Ports
	//--------------------------
	// < Enter Bidirectional Ports in Alphabetical Order >
	
	
	///////////////////////////////////////////////////////////////////
	// Begin Design
	///////////////////////////////////////////////////////////////////
	
	//-------------------------------------------------
	// Signal Declarations: reg
	//-------------------------------------------------
	reg		[8 : 0]			RG_difference_reg;
	reg		[8 : 0]			BG_difference_reg;
	reg		[8 : 0]			RY_difference_reg;
	reg		[8 : 0]			BY_difference_reg;

	reg		[24 : 0]		CA_product_reg;	
	reg		[24 : 0]		CB_product_reg;	
	reg		[24 : 0]		CC_product_reg;	
	reg		[24 : 0]		CD_product_reg;	

	reg		[7 : 0]			Y_reg;
	reg		[7 : 0]			Cr_reg;
	reg		[7 : 0]			Cb_reg;

	reg		[2 : 0]			valid_reg;
	//-------------------------------------------------
	// Signal Declarations: wire
	//-------------------------------------------------
	wire	[7 : 0]			R_channel;
	wire	[7 : 0]			G_channel;
	wire	[7 : 0]			B_channel;
	
	wire	[8 : 0]			RG_difference;
	wire	[8 : 0]			BG_difference;
	wire	[8 : 0]			RY_difference;
	wire	[8 : 0]			BY_difference;
	
	wire	[24 : 0]		CA_product;	
	wire	[24 : 0]		CB_product;	
	wire	[24 : 0]		CC_product;	
	wire	[24 : 0]		CD_product;	

	wire	[7 : 0]			G;	
	wire	[24 : 0]		Y;
	wire	[24 : 0]		Cr;
	wire	[24 : 0]		Cb;
	//---------------------------------------------------------------
	// Assignments
	//---------------------------------------------------------------
	assign	R_channel		= RGB_input[15 : 8];		
	assign	G_channel		= RGB_input[23 : 16];	
	assign	B_channel		= RGB_input[31 : 24];

	assign	RG_difference	= R_Channel - G_channel; 
	assign	BG_difference	= B_Channel - G_channel;
	assign	RY_difference	= R_channel - Y_channel;
	assign	BY_difference	= B_channel - Y_channel;

	assign	CA_product		= CA * RG_difference;	
	assign	CB_product		= CB * BG_difference;	
	assign	CC_product		= CC * RY_difference;	
	assign	CD_product		= CD * BY_difference;	
	
	assign	Y				= CA_product_reg + (G >> 9) + CB_product_reg + (YOFFSET >> 9);
	assign	Cr				= CC_product_reg + (COFFEST >> 9);
	assign	Cb 				= CD_product_reg + (COFFSET >> 9);
	
	assign	YCrCb_output[15 : 8]	= Cb_reg;
	assign	YCrCb_output[23 : 16]	= Cr_reg;
	assign	YCrCb_output[31 : 24]	= Y_reg;

	assign	YCrCb_output_valid		= valid_reg[2];
	//---------------------------------------------------------------
	// Combinatorial Logic
	//---------------------------------------------------------------
	
	//---------------------------------------------------------------
	// Sequential Logic
	//---------------------------------------------------------------
	always @(posedge clk) begin
		if (rst) begin
			RG_difference_reg		= 0;
			BG_difference_reg		= 0;
			RY_difference_reg		= 0;
			BY_difference_reg		= 0;
			CA_product_reg			= 0;	
			CB_product_reg			= 0;	
			CC_product_reg			= 0;	
			CD_product_reg			= 0;	
			Y_reg					= 0;
			Cr_reg					= 0;
			Cb_reg					= 0;
			valid_reg				= 0;
		end
		else begin
			if (RGB_input_valid) begin
				RG_difference_reg	= RG_difference;
				BG_difference_reg	= BG_difference;
				RY_difference_reg	= RY_difference;
				BY_difference_reg	= BY_difference;
			end
			
			CA_product_reg			= CA_product;	
			CB_product_reg			= CB_product;	
			CC_product_reg			= CC_product;	
			CD_product_reg			= CD_product;	
			Y_reg					= Y[14 : 7];		//-----------------Ignore the fraction parts ------------------
			Cr_reg					= Cr[14 : 7];
			Cb_reg					= Cb[14 : 7];
			valid_reg[0]			= RGB_input_valid;
			valid_reg[2 : 1]		= valid_reg[1 : 0];
		end
	end
	
	//-----------------------------------------
	// Module Instantiation
	//-----------------------------------------
	g_channel_sr
	g_channel_sr_inst(
		.clk(clk),
		.d(G_channel),
		.q(G)	
	);


endmodule
