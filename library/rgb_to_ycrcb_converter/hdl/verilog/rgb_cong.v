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
	input												clk	    							,
	input												rst		    						,
	// Data Input and Valid Signals
	input				[DATAIN_WIDTH-1:0]		datain								,
	input                						datain_valid    					,
	output reg										datain_ready    					,
	// Data Output and Valid Signals
	output reg    	[DATAOUT_WIDTH-1:0]		dataout								,
	output reg                          	dataout_valid   					,
	input												dataout_ready						
);

`define blue    31:24
`define green   23:16
`define red     15:8
	
        localparam                                      YOFFSET                                             = 8'b00000000;
        localparam                                      COFFSET                                             = 8'b10000000;
        localparam                                      CA                                                  = 16'b0100110010001011;
        localparam                                      CB                                                  = 16'b0001110100101111;
        localparam                                      CC                                                  = 16'b1110000010010101;
        localparam                                      CD                                                  = 16'b0111110111111010;

		  reg data_valid_a;
		  reg data_valid_b;
		  reg data_valid_c;
		  reg data_valid_d;
		  reg data_ready_a;
		  reg data_ready_b;
		  reg data_ready_c;
		  reg data_ready_d;
		  
        wire            [7:0]                           R;
        wire            [7:0]                           G;
        wire            [7:0]                           B;

        wire            [7:-16]                         mult_result_Ya;
        wire            [7:-16]                         mult_result_Yb;
        wire            [7:-16]                         mult_result_Cr;
        wire            [7:-16]                         mult_result_Cb;
		  
		  reg 				[7:0]										reg_mult_result_Ya;
		  reg 				[7:0] 									reg_mult_result_Yb;
		  reg 				[7:0] 									reg_mult_result_Cr;
		  reg					[7:0] 									reg_mult_result_Cb;

        wire            [7:0]                            Y;
        wire            [7:0]                            Cr;
        wire            [7:0]                            Cb;
		  wire            [7:0]                            Ypa;
		  wire            [7:0]                            Ypb;
		  
		  reg 				[7:0] 									reg_Ypa;
		  reg 				[7:0] 									reg_Ypb;
		  reg 				[7:0] 									reg_Y;

        assign R                = datain[`red];
        assign G                = datain[`green];
        assign B                = datain[`blue];

        assign mult_result_Ya   = CA * (R - G);
        assign mult_result_Yb   = CB * (B - G);
		  
		  assign Ypa              = (reg_mult_result_Ya + G);
		  assign Ypb              = (reg_mult_result_Yb + YOFFSET);
        assign Y                = reg_Ypa + reg_Ypb;

        assign mult_result_Cr   = CC * (R - reg_Y);
        assign mult_result_Cb   = CD * (B - reg_Y);
        
        assign Cr               = reg_mult_result_Cr + COFFSET;
        assign Cb               = reg_mult_result_Cb + COFFSET;

always @(posedge clk)
begin
        if (rst)
        begin
                datain_ready    					<= 1'b0;
					 data_ready_a    					<= 1'b0;
					 data_ready_b     				<= 1'b0;
					 data_ready_c     				<= 1'b0;
					 data_ready_d     				<= 1'b0;
                dataout								<= {DATAOUT_WIDTH{1'b0}};
					 dataout_valid 					<= 1'b0;
					 data_valid_a 						<= 1'b0;
					 data_valid_b 						<= 1'b0;
					 data_valid_c 						<= 1'b0;
					 data_valid_d 						<= 1'b0;
					 reg_mult_result_Ya				<= 8'b0;
					 reg_mult_result_Yb				<= 8'b0;
					 reg_mult_result_Cr				<=	8'b0;
					 reg_mult_result_Cb				<= 8'b0;
					 reg_Ypa								<= 8'b0;
					 reg_Ypb								<= 8'b0;
					 reg_Y								<= 8'b0;
        end
        else
        begin
                datain_ready    					<= data_ready_d;
					 data_ready_a    					<= dataout_ready;
					 data_ready_b     				<= data_ready_a;
					 data_ready_c     				<= data_ready_b;
					 data_ready_d     				<= data_ready_c;
                dataout         					<= {Y, Cr, Cb, 8'b00000000};
                dataout_valid   					<= data_valid_d;
					 data_valid_a 						<= datain_valid;
					 data_valid_b 						<= data_valid_a;
					 data_valid_c 						<= data_valid_b;
					 data_valid_d 						<= data_valid_c;
					 reg_mult_result_Ya				<= mult_result_Ya[7:0];
					 reg_mult_result_Yb				<= mult_result_Yb[7:0];
					 reg_mult_result_Cr				<=	mult_result_Cr[7:0];
					 reg_mult_result_Cb				<= mult_result_Cb[7:0];
					 reg_Ypa								<= Ypa;
					 reg_Ypb								<= Ypb;
					 reg_Y								<= Y;
        end
end
	
endmodule
