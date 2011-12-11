`timescale 1ns / 1ps
//----------------------------------------------------
//Filename: TransCr
//Descripton: function trans_cr in skintone
//Time: 2011-12-11
//------------------------------------------------------

module TransCr
(
	input	clk,
	input	clk_400MHz,
	input	rst,
	
	input	[7:0]	y_value;
	input	[7:0]	cr_value;

	input 	datain_valid;
	
	output	reg	[17:0]	trans_result;
	output	reg	dataout_valid;
);

	localparam	k_l = 8'd125;
	localparam	k_h = 8'd188;
	localparam	meancr_k_h = 8'd154;
	localparam	w_cr = 18'b000101110111110000 ;

	wire	mean_cr_result_valid;
	wire	width_cr_result_valid

	wire	[17:0]	mean_cr_result;
	wire	[17:0]	width_cr_result;

	MeanCr
	inst_mean_cr
	(
		.clk	(clk),
		.rst	(rst),

		.y_value			(y_value),
		.y_valud_valid			(datain_valid),

		.mean_cr_result			(mean_cr_result),
		.mean_cr_result_valid		(mean_cr_result_valid)
	);

	WidthCr
	inst_width_cr
	(
		.clk		(clk),
		.rst		(rst),

		.y_value		(y_value),
		.y_value_valid		(datain_valid),
		
		.width_cr_result	(width_cr_result),
		.width_cr_result_valie	(width_cr_result_valid)
	);


	always @ (posedge clk)
	begin
		if(rst)
			dataout_valid <= 1'b0;
		else
		begin
			if(y_value >= k_l && y_value <= k_h)
			begin
				trans_result = {1'b0, cr_value, 9'd0};
				dataout_valid	<=	datain_valid;
			end
			else
			begin
				if(mean_cr_result_valid & width_cr_result_valid)
				begin
					temp_reg1 <= cr_value - mean_cr_result[17:9];
					valid_reg1 <=	datain_valid;

					
				end
			end
		end
	end
