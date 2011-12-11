`timescale 1ns / 1ps

//--------------------------------------------------------------
//Filename	: WidthCb
//Description	: calculate mean_cr in skintone detector
//----------------------------------------------------------------
//use (9,9) float point representation
module	WidthCb
(
	input	clk,
	input	rst,

	input	[7:0]	y_value,
	input		y_value_valid,

	output	reg 	[17:0]	width_cb_result,
	output	reg	width_cb_result_valid
)

	localparam	k_l_y_min_diff_rev = 18'b000000000001000001; //(w_cb - wl_cb)/(k_l - Y_min)
	localparam	y_max_k_h_diff_rev = 18'b000000000101100111;	//(w_cb - wh_cb)/(y_max-k_h)
	localparam	k_l = 8'd125;
	localparam	k_h = 8'd188;
	localparam	WL_Cb = 8'd23;
	localparam	WH_Cb = 8'd14;
	localparam	y_min = 8'd16;
	localparam	y_max = 8'd235;

	reg	[7:0]	temp_reg1; //keep the value of sub, need only 8 bits
	reg	[25:0]	temp_reg2; // keep the value of mult, need 18+8 = 26bits
	reg	[8:0]	temp_reg3; //keep the add, need 8+1=9 bits
	
	reg	valid_reg1;
	reg	valid_reg2;
	reg	valid_reg3;

	always @(posedge clk)
	begin
		if(rst)
		begin
			width_cb_result_valid <= 1'b0; 
		end
		else
		begin
			if(y_value <= k_l)
			begin
				//stage 1
				temp_reg1	<=	y_value - y_min;	
				valid_reg1	<=	y_value_valid;
	
				//stage2
				temp_reg2	<=	temp_reg1 * k_l_y_min_diff_rev;
				valid_reg2	<=	valid_reg1;

				//stage3
				temp_reg3	<=	WL_Cb + temp_reg2[17:9];
				valid_reg2	<=	valid_reg2;
				
				//stage 3
				width_cb_result	<=	{temp_reg3, temp_reg2[8:0]};
				width_cb_result_valid	<=	valid_reg3;
			end
			else if(k_h <= y_value)
			begin
				//stage 1
				temp_reg1	<=	y_max - y_value;	
				valid_reg1	<=	y_value_valid;
	
				//stage2
				temp_reg2	<=	temp_reg1 * y_max_k_h_diff_rev;
				valid_reg2	<=	valid_reg1;

				//stage3
				temp_reg3	<=	WH_Cb + temp_reg2[17:9];
				valid_reg2	<=	valid_reg2;
				
				//stage 3
				width_cb_result	<=	{temp_reg3, temp_reg2[8:0]};
				width_cb_result_valid	<=	valid_reg3;

			end
			else
			begin
				width_cb_result_valid	<=	y_value_valid;
				width_cb_result		<=	18'd0;	
			end
		end
	end

endmodule
