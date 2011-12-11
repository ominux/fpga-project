//----------------------------------------------------------------
//Filename:	skintone.v
//Description: 	skintone dectector
//Time:	2011
//----------------------------------------------------------------
//use (m,f) = (9, 9) for float point representation
module skintone
#(
	parameter DATAIN_WIDTH = 32,
	parameter DATAOUT_WIDTH = 32
)
(
	input	clk,
	input 	rst,

	input datain_valid,
	input [DATAIN_WIDTH-1:0] 	datain,
	output reg	datain_ready,

	output reg	dataout_valid,
	output reg	[DATAOUT_WIDTH-1:0]	dataout,
	input	dataout_ready
);

	localparam	cost = 9'b111111111;
	localparam	sint = 9'b000010110;
	localparam	ECx = 18'b000000001100110011; //1.6
	localparam	ECy = 18'b000000010011010001; //2.41
	localparam	A2_rev = 9'b000000001; //1/644.6521
	localparam	B2_rev = 9'b000000010; //1/196.8409
	localparam	radius = 9'b100000000; //0.5 
	localparam	fac =	9'b111111110; //510 
	localparam	Cx = 18'b001101101011000010; //109.38
	localparam	Cy = 18'b010001000000001010; //152.02

	`define	Y_VALUE		31:23
	`define	CR_VALUE 	23:16
	`define	CB_VALUE	15:8
	`define BLANK		7:0

	reg	[17:0]	TCr;
	reg	[17:0]	TCb;
	reg	[17:0]	temp_reg1;
	reg	[17:0]	temp_reg2;
	reg	[26:0]	temp_reg3; //9 bit * 18 bit = 27 bits(9, 18), 18 bits for frac
	reg	[26:0]	temp_reg4;
	reg	[26:0]	temp_reg5;
	reg	[26:0]	temp_reg6;

	reg	[17:0]	skin_reg1;
	reg	[17:0]	skin_reg2;
	reg	[35:0]	skin_reg3;	//18 bits * 18 bits = 36 bits (all for frac)
	reg	[35:0]	skin_reg4;
	reg	[26:0]	skin_reg5;	//18bit * 9 bit = 27 bits
	reg	[26:0]	skin_reg6;
	
	reg	[8:0]	skin_diff;	//only fraction left
	reg	[17:0]	skin_result;

	wire	TCr_valid;
	wire	TCb_valid;
	
	reg	[17:0]	xx;
	reg	[17:0]	yy;

	reg	[17:0]	skinScore;

	reg	valid_reg1;
	reg	valid_reg2;
	reg	valid_reg3;
	reg	valid_reg4;
	reg	valid_reg5;
	reg	valid_reg6;
	reg	valid_reg7;
	reg	valid_reg8;

	always @(posedge clk)
	begin
		if(rst)
		begin
			datain_ready 	<=	1'b0;
			dataout_valid	<=	1'b0;
		end	
		else
		begin
			if(TCr_valid & TCb_valid)
			begin
				//stage 1
				temp_reg1	<=	TCb - Cx;
				temp_reg2	<=	TCr - Cy;
				valid_reg1	<=	(TCr_valid & TCb_valid);

				//stage 2
				temp_reg3	<=	temp_reg1 * cost;
				temp_reg4	<=	temp_reg1 * sint;
				temp_reg5	<=	temp_reg2 * cost;
				temp_reg6	<=	temp_reg2 * sint;
				valid_reg2	<=	valid_reg1;

				//stage 3
				xx[8:0]		<=	temp_reg3[17:9] + temp_reg6[17:9];
				yy[8:0]		<=	temp_reg5[17:8] - temp_reg4[17:9];
				xx[17:9]	<=	temp_reg3[26:18] + temp_reg6[26:18];
				yy[17:9]	<=	temp_reg5[26:18] - temp_reg4[26:18];
				valid_reg3	<=	valid_reg2;

				//stage 4
				skin_reg1	<=	xx - ECx;
				skin_reg2	<=	yy - ECy;
				valid_reg4	<=	valid_reg3;

				//stage5
				skin_reg3	<=	skin_reg1 * skin_reg1;
				skin_reg4	<=	skin_reg2 * skin_reg2;
				valid_reg5	<=	valid_reg4;

				//stage 6
				skin_reg5	<=	skin_reg3[26:9] * A2_rev;
				skin_reg6	<=	skin_reg4[26:9] * B2_rev;
				valid_reg6	<=	valid_reg5;
		
				//stage 7
				skinScore 	<= 	skin_reg5[26:9] + skin_reg6[26:9];
				valid_reg7	<=	valid_reg6;				

				//final stage
				if(skinScore <= radius)
				begin
					skin_diff	<= 	radius - skinScore[8:0];
					valid_reg8	<=	valid_reg7;

					skin_result	<=	fac * skin_diff;
					dataout_valid	<=	valid_reg8;		
					dataout <= {datain[`Y_VALUE], datain[`CR_VALUE], datain[`CB_VALUE], skin_result[16:9]};
				end	
				else
				begin
					dataout	<= {datain[`Y_VALUE], datain[`CR_VALUE], datain[`CB_VALUE], 8'b0};	
					dataout_valid	<=	valid_reg7;
				end
			end
		end	
	end
	
	TransCr	
	instance_trans_cr
	(
		.clk			(clk),
		.clk_400MHz		(clk),

		.y_value		(datain[`Y_VALUE]),
		.cr_value		(datain[`CR_VALUE]),

		.datain_valid		(datain_valid),
	
		.trans_result	(TCr),
		.dataout_valid	(TCr_valid)
	);

	trans_cb
	instance_trans_cb
	(
		.clk			(clk),
		.clk_400MHz		(clk),

		.y			(datain[`Y_VALUE]),
		.y_valid		(datain_valid),

		.trans_cb_output	(TCb),
		.trans_cb_output_valid	(TCb_valid)
	);


endmodule
