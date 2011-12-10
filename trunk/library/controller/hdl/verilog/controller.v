//---------------------------------------------------------------------
//Filename:	controller.v
//Description:	slave interface towards host
//Author:	Qiaosha Zou
//----------------------------------------------------------------------

module controller
#(
	parameter ADDRESS_SIZE = 36,
	parameter DATA_WIDTH = 128
)
(
	input 	clk,
	input	rst,
	
	input 	[ADDRESS_SIZE-1:0]	slave_address,
	input 	slave_wrreq,
	output	reg	slave_wrack,
	input 	[DATA_WIDTH-1:0]		slave_datain,
	
	input	 slave_rdreq,
	output	reg slave_rdack,
	output	reg	[DATA_WIDTH-1:0]	slave_dataout,

	output	[DATA_WIDTH-1:0]	fetcher_command,
	output	fetcher_command_valid,
	input		fetcher_command_complete,

	output	[DATA_WIDTH-1:0]	storer_command,
	output	storer_command_valid,
	input	storer_command_complete
);

`define	REG_ADDRESS	6:4

reg	[DATA_WIDTH-1:0]	configuration_reg0;
reg	[DATA_WIDTH-1:0]	configuration_reg1;
reg	[DATA_WIDTH-1:0]	configuration_reg2;
reg	[DATA_WIDTH-1:0]	configuration_reg3;
reg	[DATA_WIDTH-1:0]	configuration_reg4;

reg	[35:0]			pixel_length;

always @(posedge clk)
begin
	if(rst)
	begin	
		slave_wrack <=1'b0;
		slave_rdack <= 1'b0;
		configuration_reg0	<=	128'b0;
		configuration_reg1	<=	128'b0;	
		configuration_reg2	<=	128'b0;
		configuration_reg3	<=	128'b0;
		configuration_reg4	<=	128'b0;
	end
	else
	begin
		slave_wrack	<=	slave_wrreq;
		slave_rdack	<=	slave_rdreq;
		pixel_length	<=	configuration_reg0[11:0] * configuration_reg0[23:12];
		
		if(slave_wrreq)
		begin
			case(slave_address[6:4])
				3'b000	:
				begin
					configuration_reg0	<=	slave_datain;
				end
				3'b001	:
				begin
					configuration_reg1	<=	slave_datain;
				end
				3'b010	:
				begin	
					configuration_reg2	<=	slave_datain;
				end
				3'b011	:
				begin	
					configuration_reg3	<=	slave_datain;
					configuration_reg4	<=	slave_datain;
				end
				3'b100	:
				begin	
				end
			endcase
		end
		if(slave_rdreq)
		begin
			case(slave_address[6:4])
				3'b000	:
				begin
					slave_dataout	<=	configuration_reg0;
				end
				3'b001	:
				begin
					slave_dataout	<=	configuration_reg1;
				end
				3'b010	:
				begin	
					slave_dataout	<=	configuration_reg2;
				end
				3'b011	:
				begin	
					slave_dataout	<=	configuration_reg3;
				end
				3'b100	:
				begin	
					slave_dataout	<=	configuration_reg4;
				end
			endcase
		end

		if(fetcher_command_complete & storer_command_complete)
			configuration_reg4[3:0] <= 4'b0000;	
			
	end
end

assign	fetcher_command_valid	=	((configuration_reg3[3:0] == 4'b1111) & slave_wrack);
assign	storer_command_valid	=	((configuration_reg3[3:0] == 4'b1111) & slave_wrack);

assign	fetcher_command		=	{36'b0, configuration_reg1[35:0], pixel_length, configuration_reg1[51:36], 4'b0111};
assign	 storer_command		=	{36'b0, configuration_reg2[35:0], pixel_length, configuration_reg2[51:36], 4'b0011};

endmodule
