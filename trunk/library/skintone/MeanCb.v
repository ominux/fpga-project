`timescale 1ns / 1ps

//--------------------------------------------------------------
//Filename	: MeanCb
//Description	: calculate mean_cr in skintone detector
//----------------------------------------------------------------
//use (9,9) float point representation
module	MeanCb
(
	input	clk,
	input	rst,

	input	[7:0]	y_value,
	input		y_value_valid,

	output	reg 	[17:0]	mean_cb_result,
	output	reg	mean_cb_result_valid
)

	localparam	k_l_y_min_diff_rev = 18'b000000000000101110; //10 * 1/diff
	localparam	y_max_k_h_diff_rev = 18'b000000000001101100;	//10 * 1/diff
	localparam	k_l = 8'd125;
	localparam	k_h = 8'd188;
	localparam	cons = 8'd108; //108

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
			mean_cb_result_valid <= 1'b0; 
		end
		else
		begin
			if(y_value <= k_l)
			begin
				//stage 1
				temp_reg1	<=	k_l - y_value;	
				valid_reg1	<=	y_value_valid;
	
				//stage2
				temp_reg2	<=	temp_reg1 * k_l_y_min_diff_rev;
				valid_reg2	<=	valid_reg1;

				//stage3
				temp_reg3	<=	cons + temp_reg2[17:9];
				valid_reg2	<=	valid_reg2;
				
				//stage 3
				mean_cb_result	<=	{temp_reg3, temp_reg2[8:0]};
				mean_cb_result_valid	<=	valid_reg3;
			end
			else if(k_h <= y_value)
			begin
				//stage 1
				temp_reg1	<=	y_value - k_h;	
				valid_reg1	<=	y_value_valid;
	
				//stage2
				temp_reg2	<=	temp_reg1 * y_max_k_h_diff_rev;
				valid_reg2	<=	valid_reg1;

				//stage3
				temp_reg3	<=	cons + temp_reg2[17:9];
				valid_reg2	<=	valid_reg2;
				
				//stage 3
				mean_cb_result	<=	{temp_reg3, temp_reg2[8:0]};
				mean_cb_result_valid	<=	valid_reg3;

			end
			else
			begin
				mean_cb_result_valid	<=	y_value_valid;
				mean_cb_result		<=	18'd0;	
			end
		end
	end

endmodule
