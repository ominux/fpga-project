module host_emulator
(
	// Clock and Reset Signals
	input									clk									,
	input									rst									,
	// Transaction Request Signals
	output	reg	[35:0]						slave_address						,
	output 	reg								slave_wrreq							,
	input									slave_wrack							,
	output	reg	[127:0]						slave_datain						,
	output	reg								slave_rdreq							,
	input									slave_rdack							,
	input		[127:0]						slave_dataout						
);
	
	localparam	ST_WAIT_DELAY 	= 0;
	localparam	ST_CONFIG_REG0	= 1;
	localparam	ST_CONFIG_REG1	= 2;
	localparam	ST_CONFIG_REG2	= 3;
	localparam	ST_CONFIG_REG3	= 4;
	localparam 	ST_READ_REG4	= 5;
	
	localparam 	C_MAX_DELAY 	= 128;
	
	reg		[63:0]	job_parameters[5:0];
	reg		[2:0]	state;
	reg		[7:0]	delay_count;
	
	wire 	[11:0]	image_width;
	wire	[11:0]	image_height;
	wire	[35:0]	image_source_address;
	wire	[15:0]	image_source_device;
	wire	[35:0]	result_target_address;
	wire	[15:0]	result_target_device;
	
	initial
	begin
		$readmemh("image_parameters.dat",job_parameters);
	end
	
	assign image_width 				= job_parameters[0][11:0];
	assign image_height 			= job_parameters[1][11:0];
	assign image_source_address		= job_parameters[2][35:0];
	assign image_source_device		= job_parameters[3][15:0];
	assign result_target_address	= job_parameters[4][35:0];
	assign result_target_device		= job_parameters[5][15:0];
	
	always @(posedge clk)
	begin
		if (rst)
		begin
			delay_count 	<= 8'd0;
			
			slave_address 	<= 36'd0;
			slave_wrreq		<= 1'b0;
			slave_datain	<= 128'b0;
			slave_rdreq		<= 1'b0;
						
			state 			<= ST_WAIT_DELAY;
		end
		else
		begin
			case (state)
				ST_WAIT_DELAY :
					begin
						delay_count 	<= delay_count - 8'd1;
						if (delay_count == 8'd1)
						begin
							state 		<= ST_CONFIG_REG0;
						end
						else if (delay_count == 0)
						begin
							delay_count <= C_MAX_DELAY;
						end
					end
				ST_CONFIG_REG0 :
					begin
						slave_address 	<= 36'd0;
						slave_wrreq		<= 1'b1;
						slave_datain	<= {104'b0,image_height,image_width};
						
						if (slave_wrack)
						begin
							slave_wrreq	<= 1'b0;
							state		<= ST_CONFIG_REG1;
						end
					end
				ST_CONFIG_REG1 :
					begin
						slave_address 	<= 36'd16;
						slave_wrreq		<= 1'b1;
						slave_datain	<= {56'b0,image_source_device,image_source_address};
						
						if (slave_wrack)
						begin
							slave_wrreq	<= 1'b0;
							state		<= ST_CONFIG_REG2;
						end
					end
				ST_CONFIG_REG2 :
					begin
						slave_address 	<= 36'd32;
						slave_wrreq		<= 1'b1;
						slave_datain	<= {56'b0,result_target_device,result_target_address};
						
						if (slave_wrack)
						begin
							slave_wrreq	<= 1'b0;
							state		<= ST_CONFIG_REG3;
						end
					end
				ST_CONFIG_REG3 :
					begin
						slave_address 	<= 36'd48;
						slave_wrreq		<= 1'b1;
						slave_datain	<= {124'b0,4'b1111};
						
						if (slave_wrack)
						begin
							slave_wrreq	<= 1'b0;
							state		<= ST_READ_REG4;
						end
					end
				ST_READ_REG4 :
					begin
						slave_address 	<= 36'd64;
						slave_rdreq		<= 1'b1;
												
						if (slave_rdack)
						begin
							slave_rdreq	<= 1'b0;
							if (slave_dataout[3:0] == 4'b0000)
							begin
								state	<= ST_WAIT_DELAY;
							end
						end
					end
			endcase
		end
	end
	
endmodule
