`timescale 1 ns/1 ps

module top_wrapper
#(
	parameter MSG_WIDTH	=	36,	
	parameter DATA_WIDTH	= 	128
)
(
	input	clk1,
	input 	clk2,
	input 	rst,
	
	input 	slave_address[MSG_WIDTH-1:0],
	input 	slave_wrreq,
	output	slave_wrack,
	
	input	slave_datain[DATA_WIDTH-1:0],
	input 	slave_rdreq,
	output	slave_rdack,
	output	slave_dataout[DATA_WIDTH-1:0],

	input 		fetcher_network_request_ack,
	output		fetcher_network_request,
	output	 [15:0]		fetcher_network_request_device,
	output	 [35:0]		fetcher_network_request_address,
	output	 [35:0]		fetcher_network_request_length,
	input		fetcher_netowkr_request_complete,
	input	[DATA_WIDTH-1:0]	fetcher_network_datain,
	input		fetcher_network_datain_valid,
	output		fetcher_network_datain_ready,

	output		storer_network_request,
	output	[15:0]	storer_network_request_device,
	output	[35:0]	storer_network_reqeust_address,
	output	[35:0]	storer_network_request_length,
	input		storer_network_request_ack,
	input		storer_network_request_complete,
	output		storer_network_dataout_valid,
	input		storer_network_dataout_ready,
	output	[DATA_WIDTH-1:0]	storer_network_dataout
	
);

wire	[DATA_WIDTH-1:0]	fetcher_command;
wire	fetcher_command_valid;
wire	fetcher_command_complete;
wire	[DATA_WIDTH-1:0]	storer_command;
wire	storer_command_valid;
wire	storer_command_complete;

wire	[31:0]	fetcher_dataout;
wire		fetcher_dataout_valid;
wire		fetcher_dataout_ready;

wire	skintone_detector_dataout;
wire	skintone_detector_dataout_ready;
wire	skintone_detector_dataout_valid;

wire	converter_dataout;
wire	converter_dataout_ready;
wire	converter_dataout_valid;

//---------------------------------------------------------------------------
//instantiate controller
//--------------------------------------------------------------------------
controller
#(
	.ADDRESS_SIZE	(36),
	.DATA_WIDTH	(128)
)
my_controller
(
	.clk	(clk1),
	.rst	(rst),
	
	.slave_address	(slave_address),
	.slave_wrreq	(slave_wrreq),
	.slave_wrrack	(slave_wrrack),
	.slave_datain	(slave_datain),

	.slave_rdreq	(slave_rdreq),
	.slave_rdack	(slave_rdack),
	.slave_dataout	(slave_dataout),

	.fetcher_command	(fetcher_command),
	.fetcher_command_valid	(fetcher_command_valid),
	.fetcher_command_complete	(fetcher_command_complete),

	.storer_command	(storer_command),
	.storer_command_valid	(storer_command_valid),
	.storer_command_complete	(storer_command_complete)
);

//------------------------------------------------------------------------
//instantiate fetcher
//------------------------------------------------------------------------
data_fetch
#(
	.DATAIN_WIDTH 						(128),
	.DATAOUT_WIDTH 						(32),
	.MSG_WIDTH							(128)
)
fetcher
(
	// Clock and Reset Signals
	.clk1			(clk1),
	.clk2			(clk2),
	.rst			(rst),
	// Transaction Request Signals
	.network_request				(fetcher_network_request),
	.network_request_device				(fetcher_network_request_device),
	.network_request_address			(fetcher_network_request_address),
	.network_request_length				(fetcher_network_request_length),
	.network_request_acknowledge			(fetcher_network_request_ack),
	.network_request_complete			(fetcher_network_request_complete),
	// Transaction Data and Data handshake Signals
	.network_datain_valid				(fetcher_network_datain_valid),
	.network_datain_ready				(fetcher_network_datain_ready),
	.network_datain					(fetcher_network_datain),
	// Message Interface
	.command					(fetcher_command),
	.command_valid					(fetcher_command_valid),
	.command_complete				(fetcher_command_complete),
	// Data Output and Valid Signals
	.dataout					(fetcher_dataout),
	.dataout_valid					(fetcher_dataout_valid),
	.dataout_ready                     		(fetcher_dataout_ready)
);

//----------------------------------------------------------------------------------------------------------
//instantiate data store 
//-------------------------------------------------------------------------------------------------------
data_store
#(
	.DATAIN_WIDTH 						(32),
	.DATAOUT_WIDTH 						(128),
	.MSG_WIDTH							(128)
)
storer
(
	// Clock and Reset Signals
	.clk1			(clk1),
	.clk2			(clk2),
	.rst			(rst),
	// Transaction Request Signals
	.network_request				(storer_master_request),
	.network_request_device				(storer_master_request_device),
	.network_request_address			(storer_master_request_address),
	.network_request_length				(storer_master_request_length),
	.network_request_acknowledge			(storer_master_request_ack),
	.network_request_complete			(storer_master_request_complete),
	// Transaction Data and Data handshake Signals
	.network_dataout_valid				(storer_master_dataout_src_rdy),
	.network_dataout_ready				(storer_master_dataout_dst_rdy),
	.network_dataout				(storer_master_dataout),
	// Message Interface
	.command					(storer_command),
	.command_valid					(storer_command_valid),
	.command_complete				(storer_command_complete),
	// Data Output and Valid Signals
	.datain						(skintone_detector_dataout),
	.datain_valid					(skintone_detector_dataout_valid),
	.datain_ready                     		(skintone_detector_dataout_ready)
);

//----------------------------------------------------------------------------------------------------------
//instantiate rgb-to-ycrcb-converter 
//-------------------------------------------------------------------------------------------------------
rgb_to_ycrcb_converter
#(
	.DATAIN_WIDTH 						(32),
	.DATAOUT_WIDTH						(32)
)
converter
(
	// Clock and Reset Signals
	.clk								(clk2),
	.rst								(rst),
	// Data Input and Valid Signals
	.datain								(fetcher_dataout),
	.datain_valid							(fetcher_dataout_valid),
	.datain_ready							(fetcher_dataout_ready),
	// Data Output and Valid Signals
	.dataout							(converter_dataout),
	.dataout_valid							(converter_dataout_valid),
	.dataout_ready							(converter_dataout_ready)
);



endmodule
