 //----------------------------------------------------------------------------
// Filename:          rgb_to_ycrcb_converter.v
// Description:       Empty Implementation of a rgb to ycrcb converter
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------

module rgb_to_ycrcb_converter
#(
	parameter DATAIN_WIDTH 	= 32,
	parameter DATAOUT_WIDTH = 32
)
(
	// Clock and Reset Signals
	input		clk		,
	input		rst		,
	// Data Input and Valid Signals
	input      	[DATAIN_WIDTH-1:0]	datain	,
	input             		datain_valid	,
	output	reg		datain_ready			,
	// Data Output and Valid Signals
	output  reg    	[DATAOUT_WIDTH-1:0]	dataout			,
	output  reg           		dataout_valid ,
	input				dataout_ready						
);

`define BLANK	7:0
`define RED 	15:8
`define GREEN 	23:16
`define BLUE 	31:24

	localparam	YOFFSET	= 16'b0000000000000000; //set to 0 from 16?
	localparam	COFFSET = 16'b0000000010000000;
	
	//fix point, 16bits for fractions
	localparam	CA = 16'b0100110010001011;
	localparam	CB = 16'b0001110100101111;
	localparam	CC = 16'b1110000010010101;
	localparam	CD = 16'b0111110111111010;

	reg  [7:0]	Y;
	reg  [7:0]	Cr;
	reg  [7:0]	Cb;
	reg	[23:0]	result1;
	reg	[23:0]	result2;
	reg	[23:0]	result3;
	reg	[23:0]	result4;
	reg	[DATAIN_WIDTH-1:0]    datain_reg1;
	reg	[DATAIN_WIDTH-1:0]	 datain_reg2;
	reg	[7:0]	Y_reg1;
	reg	[7:0]	Y_reg2;

	reg	valid_reg1;
	reg	valid_reg2;
	reg	valid_reg3;
	reg	valid_reg4;


always @(posedge clk)
begin
	if(rst)
	begin
		datain_ready <= 1'b0;
		dataout_valid <= 1'b0;
	end
	else
	begin
		datain_ready <= dataout_ready;
	
		//4 stage pipeline delay for dataout_valid
		valid_reg1 <= datain_valid;
		valid_reg2 <= valid_reg1;
		valid_reg3 <= valid_reg2;
		valid_reg4 <= valid_reg3;
		dataout_valid <= valid_reg4;
	
		//stage 1
		result1 <= CA * (datain[`RED] - datain[`GREEN]);
 		result2 <= CB * (datain[`BLUE] - datain[`GREEN]);
		datain_reg1 <= datain;
		
		//stage 2
 		Y <= result1[23:16] + datain_reg1[`GREEN] + result2[23:16] + YOFFSET[7:0];
		datain_reg2 <= datain_reg1;
		
	 
		//sgate 3
		Y_reg1 <= Y;
 		result3 <= CC * (datain_reg2[`RED] - Y) ;
		result4 <= CD *(datain_reg2[`BLUE] - Y);
		
		//stage 4
 		Cr <= result3[23:16] + COFFSET[7:0];
	 	Cb <= result4[23:16] + COFFSET[7:0];
		Y_reg2 <= Y_reg1;
		
		//stage 5
		dataout <= {Y_reg2, Cr, Cb, datain[`BLANK]};
	end

end
	
	//assign datain_ready 	= dataout_ready;
	//assign dataout 			= {DATAOUT_WIDTH{1'b0}};
	//assign dataout_valid 	= datain_valid;
	
endmodule
