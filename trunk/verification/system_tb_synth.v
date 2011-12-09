`timescale 1 ns/1 ps

module system_tb_synth
(
	input				sys_clk_p,
	input				sys_clk_n,
	output		[1:0]	debug
);

wire	[35:0]		controller_slave_address			;
wire				controller_slave_wrreq				;
wire				controller_slave_wrack				;
wire	[127:0]		controller_slave_datain				;
wire				controller_slave_rdreq				;
wire				controller_slave_rdack				;
wire	[127:0]		controller_slave_dataout			;
	
wire				data_fetcher_master_request			;
wire		[15:0]	data_fetcher_master_request_device	;
wire				data_fetcher_master_request_ack		;
wire				data_fetcher_master_request_complete;
wire		[35 :0]	data_fetcher_master_request_address	;
wire 		[35 :0] data_fetcher_master_request_length	;
wire  	        	data_fetcher_master_datain_src_rdy	;
wire				data_fetcher_master_datain_dst_rdy	;
wire		[127:0]	data_fetcher_master_datain			;
reg			[127:0]	data_fetcher_command				;
reg					data_fetcher_command_valid			;
wire				data_fetcher_command_complete		;
reg					data_fetcher_command_completed		;
wire		[31:0]	data_fetcher_dataout				;
wire				data_fetcher_dataout_valid			;
wire				data_fetcher_dataout_ready			;
wire				data_fetcher_sap_clk1				;
wire				data_fetcher_sap_clk2				;
wire				data_fetcher_sap_rst				;

wire				data_storer_master_request			;
wire		[15:0]	data_storer_master_request_device	;
wire				data_storer_master_request_ack		;
wire				data_storer_master_request_complete	;
wire		[35 :0]	data_storer_master_request_address	;
wire 		[35 :0] data_storer_master_request_length	;
wire  	        	data_storer_master_dataout_src_rdy	;
wire				data_storer_master_dataout_dst_rdy	;
wire		[127:0]	data_storer_master_dataout			;
reg			[127:0]	data_storer_command					;
reg					data_storer_command_valid			;
wire				data_storer_command_complete		;
reg					data_storer_command_completed		;
wire		[31:0]	data_storer_datain					;
wire				data_storer_datain_valid			;
wire				data_storer_datain_ready			;
wire				data_storer_sap_clk1				;
wire				data_storer_sap_clk2				;
wire				data_storer_sap_rst					;

wire				disk0_sap_clksrc1					;
wire				disk0_sap_clksrc2					;
wire				disk0_sap_clksrc3					;
wire				disk0_sap_clksrc4					;
wire				disk0_sap_clk						;
wire				disk0_sap_rst						;
wire				disk0_master_request				;
wire				disk0_master_request_ack			;
wire				disk0_master_request_complete		;
wire		[6	:0]	disk0_master_request_error			;
wire		[3  :0]	disk0_master_request_tag			;
wire		[3  :0]	disk0_master_request_type			;
wire		[9  :0]	disk0_master_request_flow			;
wire		[35 :0]	disk0_master_request_local_address	;
wire 		[35 :0] disk0_master_request_length			;
wire				disk0_master_descriptor_src_rdy		;
wire				disk0_master_descriptor_dst_rdy		;
wire		[3  :0]	disk0_master_descriptor_tag			;
wire		[127:0]	disk0_master_descriptor				;
wire  	        	disk0_master_datain_src_rdy			;
wire				disk0_master_datain_dst_rdy			;
wire		[3  :0]	disk0_master_datain_tag				;
wire		[127:0]	disk0_master_datain					;
wire				disk0_master_dataout_src_rdy		;
wire				disk0_master_dataout_dst_rdy		;
wire		[3  :0]	disk0_master_dataout_tag			;
wire		[127:0]	disk0_master_dataout				;
wire				disk0_slave_burst_start				;
wire		[12 :0]	disk0_slave_burst_length			;
wire				disk0_slave_burst_rnw				;
wire 		[35 :0] disk0_slave_address					;
wire		[3  :0]	disk0_slave_transaction_id			;
wire				disk0_slave_address_valid			;
wire				disk0_slave_address_ack				;
wire 		[3  :0]	disk0_slave_wrreq					;
wire				disk0_slave_wrack					;
wire 		[15 :0] disk0_slave_be						;
wire 		[127:0]	disk0_slave_datain					;
wire 		[3  :0] disk0_slave_rdreq					;
wire  	      		disk0_slave_rdack					;
wire 		[127:0]	disk0_slave_dataout					;
wire				disk0_send_msg_request				;
wire				disk0_send_msg_ack					;
wire				disk0_send_msg_complete				;
wire		[1  :0]	disk0_send_msg_error				;
wire				disk0_send_msg_src_rdy				;
wire				disk0_send_msg_dst_rdy				;
wire		[127:0]	disk0_send_msg_payload				;
wire				disk0_recv_msg_request				;
wire				disk0_recv_msg_ack					;
wire				disk0_recv_msg_src_rdy				;
wire				disk0_recv_msg_dst_rdy				;
wire		[127:0]	disk0_recv_msg_payload				;

wire				disk1_sap_clksrc1					;
wire				disk1_sap_clksrc2					;
wire				disk1_sap_clksrc3					;
wire				disk1_sap_clksrc4					;
wire				disk1_sap_clk						;
wire				disk1_sap_rst						;
wire				disk1_master_request				;
wire				disk1_master_request_ack			;
wire				disk1_master_request_complete		;
wire		[6	:0]	disk1_master_request_error			;
wire		[3  :0]	disk1_master_request_tag			;
wire		[3  :0]	disk1_master_request_type			;
wire		[9  :0]	disk1_master_request_flow			;
wire		[35 :0]	disk1_master_request_local_address	;
wire 		[35 :0] disk1_master_request_length			;
wire				disk1_master_descriptor_src_rdy		;
wire				disk1_master_descriptor_dst_rdy		;
wire		[3  :0]	disk1_master_descriptor_tag			;
wire		[127:0]	disk1_master_descriptor				;
wire  	        	disk1_master_datain_src_rdy			;
wire				disk1_master_datain_dst_rdy			;
wire		[3  :0]	disk1_master_datain_tag				;
wire		[127:0]	disk1_master_datain					;
wire				disk1_master_dataout_src_rdy		;
wire				disk1_master_dataout_dst_rdy		;
wire		[3  :0]	disk1_master_dataout_tag			;
wire		[127:0]	disk1_master_dataout				;
wire				disk1_slave_burst_start				;
wire		[12 :0]	disk1_slave_burst_length			;
wire				disk1_slave_burst_rnw				;
wire 		[35 :0] disk1_slave_address					;
wire		[3  :0]	disk1_slave_transaction_id			;
wire				disk1_slave_address_valid			;
wire				disk1_slave_address_ack				;
wire 		[3  :0]	disk1_slave_wrreq					;
wire				disk1_slave_wrack					;
wire 		[15 :0] disk1_slave_be						;
wire 		[127:0]	disk1_slave_datain					;
wire 		[3  :0] disk1_slave_rdreq					;
wire  	      		disk1_slave_rdack					;
wire 		[127:0]	disk1_slave_dataout					;
wire				disk1_send_msg_request				;
wire				disk1_send_msg_ack					;
wire				disk1_send_msg_complete				;
wire		[1  :0]	disk1_send_msg_error				;
wire				disk1_send_msg_src_rdy				;
wire				disk1_send_msg_dst_rdy				;
wire		[127:0]	disk1_send_msg_payload				;
wire				disk1_recv_msg_request				;
wire				disk1_recv_msg_ack					;
wire				disk1_recv_msg_src_rdy				;
wire				disk1_recv_msg_dst_rdy				;
wire		[127:0]	disk1_recv_msg_payload				;
                                                                       
reg			[27:0]	rst_cnt = 0;
wire				system_rst;
wire				system_clk;
wire				clk2;

`ifdef SIMULATION
	reg sys_clk_p_sim = 0;
	
	initial
	begin
		
		forever
		begin
			#5;
			sys_clk_p_sim = ~sys_clk_p_sim;
		end
	end
	
	clock_generator 
	clock_gen
	(
		.CLK_IN1_P	(sys_clk_p_sim	),
		.CLK_IN1_N	(!sys_clk_p_sim	),
		.CLK_OUT1	(system_clk		),
		.CLK_OUT2	(clk2			)
	);
	
	always @(posedge system_clk)
	begin
		rst_cnt <= (!rst_cnt[7])? rst_cnt + 1 : rst_cnt;
	end
	
	assign system_rst = !rst_cnt[7];
`else
	
	clock_generator 
	clock_gen
	(
		.CLK_IN1_P	(sys_clk_p		),
		.CLK_IN1_N	(sys_clk_n		),
		.CLK_OUT1	(system_clk		),
		.CLK_OUT2	(clk2			)
	);
	
	always @(posedge system_clk)
	begin
		rst_cnt <= (!rst_cnt[27])? rst_cnt + 1 : rst_cnt;
	end
	
	assign system_rst = !rst_cnt[27];
`endif


disk
#(
	.C_INIT_FILE_NAME				("disk0_init.dat"					)
)
disk0 
(
	// SAP Clock and Reset
	.sap_user_clk1					(disk0_sap_clksrc1					),
	.sap_user_clk2					(disk0_sap_clksrc2					),
	.sap_user_clk3					(disk0_sap_clksrc3					),
	.sap_user_clk4					(disk0_sap_clksrc4					),
	.sap_clk						(disk0_sap_clk						),
	.sap_rst						(disk0_sap_rst						),
	//SAP NIF Signals
	.master_request					(disk0_master_request				),
	.master_request_ack				(disk0_master_request_ack			),
	.master_request_complete		(disk0_master_request_complete		),
	.master_request_error			(disk0_master_request_error			),
	.master_request_tag				(disk0_master_request_tag			),
	.master_request_type			(disk0_master_request_type			),
	.master_request_flow			(disk0_master_request_flow			),
	.master_request_local_address	(disk0_master_request_local_address	),
	.master_request_length			(disk0_master_request_length		),
	.master_descriptor_src_rdy		(disk0_master_descriptor_src_rdy	),
	.master_descriptor_dst_rdy		(disk0_master_descriptor_dst_rdy	),
	.master_descriptor_tag			(disk0_master_descriptor_tag		),
	.master_descriptor				(disk0_master_descriptor			),
	.master_datain_src_rdy			(disk0_master_datain_src_rdy		),
	.master_datain_dst_rdy			(disk0_master_datain_dst_rdy		),
	.master_datain_tag				(disk0_master_datain_tag			),
	.master_datain					(disk0_master_datain				),
	.master_dataout_src_rdy			(disk0_master_dataout_src_rdy		),
	.master_dataout_dst_rdy			(disk0_master_dataout_dst_rdy		),
	.master_dataout_tag				(disk0_master_dataout_tag			),
	.master_dataout					(disk0_master_dataout				),
	.slave_burst_start				(disk0_slave_burst_start			),
	.slave_burst_length				(disk0_slave_burst_length			),
	.slave_burst_rnw				(disk0_slave_burst_rnw				),
	.slave_address					(disk0_slave_address				),
	.slave_transaction_id			(disk0_slave_transaction_id			),
	.slave_address_valid			(disk0_slave_address_valid			),
	.slave_address_ack				(disk0_slave_address_ack			),
	.slave_wrreq					(disk0_slave_wrreq					),
	.slave_wrack					(disk0_slave_wrack					),
	.slave_be						(disk0_slave_be						),
	.slave_datain					(disk0_slave_datain					),
	.slave_rdreq					(disk0_slave_rdreq					),
	.slave_rdack					(disk0_slave_rdack					),
	.slave_dataout					(disk0_slave_dataout				),
	// SAP Message Send Interface (Unused)
	.send_msg_request				(disk0_send_msg_request				),
	.send_msg_ack					(1'b0								),
	.send_msg_complete				(1'b0								),
	.send_msg_error					(2'b00								),
	.send_msg_src_rdy				(disk0_send_msg_src_rdy				),							
	.send_msg_dst_rdy				(1'b0								),
	.send_msg_payload				(disk0_send_msg_payload				),
	// SAP Message Recv Interface (Unused)							
	.recv_msg_request				(1'b0								),
	.recv_msg_ack					(disk0_recv_msg_ack					),
	.recv_msg_src_rdy				(1'b0								),
	.recv_msg_dst_rdy				(disk0_recv_msg_dst_rdy				),
	.recv_msg_payload				(128'b0								),
	.debug							(debug[0]							)
);

disk 
#(
	.C_INIT_FILE_NAME				("disk1_init.dat"					)
)
disk1 
(
	// SAP Clock and Reset
	.sap_user_clk1					(disk1_sap_clksrc1					),
	.sap_user_clk2					(disk1_sap_clksrc2					),
	.sap_user_clk3					(disk1_sap_clksrc3					),
	.sap_user_clk4					(disk1_sap_clksrc4					),
	.sap_clk						(disk1_sap_clk						),
	.sap_rst						(disk1_sap_rst						),
	//SAP NIF Signals
	.master_request					(disk1_master_request				),
	.master_request_ack				(disk1_master_request_ack			),
	.master_request_complete		(disk1_master_request_complete		),
	.master_request_error			(disk1_master_request_error			),
	.master_request_tag				(disk1_master_request_tag			),
	.master_request_type			(disk1_master_request_type			),
	.master_request_flow			(disk1_master_request_flow			),
	.master_request_local_address	(disk1_master_request_local_address	),
	.master_request_length			(disk1_master_request_length		),
	.master_descriptor_src_rdy		(disk1_master_descriptor_src_rdy	),
	.master_descriptor_dst_rdy		(disk1_master_descriptor_dst_rdy	),
	.master_descriptor_tag			(disk1_master_descriptor_tag		),
	.master_descriptor				(disk1_master_descriptor			),
	.master_datain_src_rdy			(disk1_master_datain_src_rdy		),
	.master_datain_dst_rdy			(disk1_master_datain_dst_rdy		),
	.master_datain_tag				(disk1_master_datain_tag			),
	.master_datain					(disk1_master_datain				),
	.master_dataout_src_rdy			(disk1_master_dataout_src_rdy		),
	.master_dataout_dst_rdy			(disk1_master_dataout_dst_rdy		),
	.master_dataout_tag				(disk1_master_dataout_tag			),
	.master_dataout					(disk1_master_dataout				),
	.slave_burst_start				(disk1_slave_burst_start			),
	.slave_burst_length				(disk1_slave_burst_length			),
	.slave_burst_rnw				(disk1_slave_burst_rnw				),
	.slave_address					(disk1_slave_address				),
	.slave_transaction_id			(disk1_slave_transaction_id			),
	.slave_address_valid			(disk1_slave_address_valid			),
	.slave_address_ack				(disk1_slave_address_ack			),
	.slave_wrreq					(disk1_slave_wrreq					),
	.slave_wrack					(disk1_slave_wrack					),
	.slave_be						(disk1_slave_be						),
	.slave_datain					(disk1_slave_datain					),
	.slave_rdreq					(disk1_slave_rdreq					),
	.slave_rdack					(disk1_slave_rdack					),
	.slave_dataout					(disk1_slave_dataout				),
	// SAP Message Send Interface (Unused)
	.send_msg_request				(disk1_send_msg_request				),
	.send_msg_ack					(1'b0								),
	.send_msg_complete				(1'b0								),
	.send_msg_error					(2'b00								),
	.send_msg_src_rdy				(disk1_send_msg_src_rdy				),							
	.send_msg_dst_rdy				(1'b0								),
	.send_msg_payload				(disk1_send_msg_payload				),
	// SAP Message Recv Interface (Unused)							
	.recv_msg_request				(1'b0								),
	.recv_msg_ack					(disk1_recv_msg_ack					),
	.recv_msg_src_rdy				(1'b0								),
	.recv_msg_dst_rdy				(disk1_recv_msg_dst_rdy				),
	.recv_msg_payload				(128'b0								),
	.debug							(debug[1]							)
);


router
i_router
(
	.router_clk1						(system_clk								),
	.router_clk2						(system_clk								),
	.router_clk3						(system_clk								),
	.router_clk4						(system_clk								),
	.router_rst							(system_rst								),
	
	.controller_slave_address			(controller_slave_address				),
	.controller_slave_wrreq				(controller_slave_wrreq					),
	.controller_slave_wrack				(controller_slave_wrack					),
	.controller_slave_datain			(controller_slave_datain				),
	.controller_slave_rdreq				(controller_slave_rdreq					),
	.controller_slave_rdack				(controller_slave_rdack					),
	.controller_slave_dataout			(controller_slave_dataout				),
	
	.client0_sap_clksrc1				(data_fetcher_sap_clksrc1				),
	.client0_sap_clksrc2				(data_fetcher_sap_clksrc2				),
	.client0_sap_clksrc3				(data_fetcher_sap_clksrc3				),
	.client0_sap_clksrc4				(data_fetcher_sap_clksrc4				),
	.client0_sap_clk					(data_fetcher_sap_clk1					),
	.client0_sap_rst					(data_fetcher_sap_rst					),
	.client0_master_request				(data_fetcher_master_request			),
	.client0_master_request_device		(data_fetcher_master_request_device		),
	.client0_master_request_ack			(data_fetcher_master_request_ack		),
	.client0_master_request_complete	(data_fetcher_master_request_complete	),
	.client0_master_request_address		(data_fetcher_master_request_address	),
	.client0_master_request_length		(data_fetcher_master_request_length		),
	.client0_master_request_rnw			(1'b1									),
	.client0_master_datain_src_rdy		(data_fetcher_master_datain_src_rdy		),
	.client0_master_datain_dst_rdy		(data_fetcher_master_datain_dst_rdy		),
	.client0_master_datain				(data_fetcher_master_datain				),
		
	.client1_sap_clksrc1				(data_storer_sap_clksrc1				),
	.client1_sap_clksrc2				(data_storer_sap_clksrc2				),
	.client1_sap_clksrc3				(data_storer_sap_clksrc3				),
	.client1_sap_clksrc4				(data_storer_sap_clksrc4				),
	.client1_sap_clk					(data_storer_sap_clk1					),
	.client1_sap_rst					(data_storer_sap_rst					),
	.client1_master_request				(data_storer_master_request				),
	.client1_master_request_device		(data_storer_master_request_device		),
	.client1_master_request_ack			(data_storer_master_request_ack			),
	.client1_master_request_complete	(data_storer_master_request_complete	),
	.client1_master_request_address		(data_storer_master_request_address		),
	.client1_master_request_length		(data_storer_master_request_length		),
	.client1_master_request_rnw			(1'b0									),
	.client1_master_dataout_src_rdy		(data_storer_master_dataout_src_rdy		),
	.client1_master_dataout_dst_rdy		(data_storer_master_dataout_dst_rdy		),
	.client1_master_dataout				(data_storer_master_dataout				),
	
	.disk0_sap_clksrc1					(disk0_sap_clksrc1						),
	.disk0_sap_clksrc2					(disk0_sap_clksrc2						),
	.disk0_sap_clksrc3					(disk0_sap_clksrc3						),
	.disk0_sap_clksrc4					(disk0_sap_clksrc4						),
	.disk0_sap_clk						(disk0_sap_clk							),
	.disk0_sap_rst						(disk0_sap_rst							),
	.disk0_master_request				(disk0_master_request					),
	.disk0_master_request_ack			(disk0_master_request_ack				),
	.disk0_master_request_complete		(disk0_master_request_complete			),
	.disk0_master_request_type			(disk0_master_request_type				),
	.disk0_master_request_error			(disk0_master_request_error				),
	.disk0_master_request_tag			(disk0_master_request_tag				),
	.disk0_master_request_flow			(disk0_master_request_flow				),
	.disk0_master_request_local_address	(disk0_master_request_local_address		),
	.disk0_master_request_length		(disk0_master_request_length			),
	.disk0_master_descriptor_src_rdy	(disk0_master_descriptor_src_rdy		),
	.disk0_master_descriptor_dst_rdy	(disk0_master_descriptor_dst_rdy		),
	.disk0_master_descriptor_tag		(disk0_master_descriptor_tag			),
	.disk0_master_descriptor			(disk0_master_descriptor				),
	.disk0_master_datain_src_rdy		(disk0_master_datain_src_rdy			),
	.disk0_master_datain_dst_rdy		(disk0_master_datain_dst_rdy			),
	.disk0_master_datain_tag			(disk0_master_datain_tag				),
	.disk0_master_datain				(disk0_master_datain					),
	.disk0_master_dataout_src_rdy		(disk0_master_dataout_src_rdy			),
	.disk0_master_dataout_dst_rdy		(disk0_master_dataout_dst_rdy			),
	.disk0_master_dataout_tag			(disk0_master_dataout_tag				),
	.disk0_master_dataout				(disk0_master_dataout					),
	.disk0_slave_burst_start			(disk0_slave_burst_start				),
	.disk0_slave_burst_length			(disk0_slave_burst_length				),
	.disk0_slave_burst_rnw				(disk0_slave_burst_rnw					),
	.disk0_slave_address				(disk0_slave_address					),
	.disk0_slave_transaction_id			(disk0_slave_transaction_id				),
	.disk0_slave_address_valid			(disk0_slave_address_valid				),
	.disk0_slave_address_ack			(disk0_slave_address_ack				),
	.disk0_slave_wrreq					(disk0_slave_wrreq						),
	.disk0_slave_wrack					(disk0_slave_wrack						),
	.disk0_slave_be						(disk0_slave_be							),
	.disk0_slave_datain					(disk0_slave_datain						),
	.disk0_slave_rdreq					(disk0_slave_rdreq						),
	.disk0_slave_rdack					(disk0_slave_rdack						),
	.disk0_slave_dataout				(disk0_slave_dataout					),
	.disk0_send_msg_request				(disk0_send_msg_request					),
	.disk0_send_msg_ack					(disk0_send_msg_ack						),
	.disk0_send_msg_complete			(disk0_send_msg_complete				),
	.disk0_send_msg_error				(disk0_send_msg_error					),
	.disk0_send_msg_src_rdy				(disk0_send_msg_src_rdy					),
	.disk0_send_msg_dst_rdy				(disk0_send_msg_dst_rdy					),
	.disk0_send_msg_payload				(disk0_send_msg_payload					),
	.disk0_recv_msg_request				(disk0_recv_msg_request					),
	.disk0_recv_msg_ack					(disk0_recv_msg_ack						),
	.disk0_recv_msg_src_rdy				(disk0_recv_msg_src_rdy					),
	.disk0_recv_msg_dst_rdy				(disk0_recv_msg_dst_rdy					),
	.disk0_recv_msg_payload				(disk0_recv_msg_payload					),

	.disk1_sap_clksrc1					(disk1_sap_clksrc1						),
	.disk1_sap_clksrc2					(disk1_sap_clksrc2						),
	.disk1_sap_clksrc3					(disk1_sap_clksrc3						),
	.disk1_sap_clksrc4					(disk1_sap_clksrc4						),
	.disk1_sap_clk						(disk1_sap_clk							),
	.disk1_sap_rst						(disk1_sap_rst							),
	.disk1_master_request				(disk1_master_request					),
	.disk1_master_request_ack			(disk1_master_request_ack				),
	.disk1_master_request_complete		(disk1_master_request_complete			),
	.disk1_master_request_type			(disk1_master_request_type				),
	.disk1_master_request_error			(disk1_master_request_error				),
	.disk1_master_request_tag			(disk1_master_request_tag				),
	.disk1_master_request_flow			(disk1_master_request_flow				),
	.disk1_master_request_local_address	(disk1_master_request_local_address		),
	.disk1_master_request_length		(disk1_master_request_length			),
	.disk1_master_descriptor_src_rdy	(disk1_master_descriptor_src_rdy		),
	.disk1_master_descriptor_dst_rdy	(disk1_master_descriptor_dst_rdy		),
	.disk1_master_descriptor_tag		(disk1_master_descriptor_tag			),
	.disk1_master_descriptor			(disk1_master_descriptor				),
	.disk1_master_datain_src_rdy		(disk1_master_datain_src_rdy			),
	.disk1_master_datain_dst_rdy		(disk1_master_datain_dst_rdy			),
	.disk1_master_datain_tag			(disk1_master_datain_tag				),
	.disk1_master_datain				(disk1_master_datain					),
	.disk1_master_dataout_src_rdy		(disk1_master_dataout_src_rdy			),
	.disk1_master_dataout_dst_rdy		(disk1_master_dataout_dst_rdy			),
	.disk1_master_dataout_tag			(disk1_master_dataout_tag				),
	.disk1_master_dataout				(disk1_master_dataout					),
	.disk1_slave_burst_start			(disk1_slave_burst_start				),
	.disk1_slave_burst_length			(disk1_slave_burst_length				),
	.disk1_slave_burst_rnw				(disk1_slave_burst_rnw					),
	.disk1_slave_address				(disk1_slave_address					),
	.disk1_slave_transaction_id			(disk1_slave_transaction_id				),
	.disk1_slave_address_valid			(disk1_slave_address_valid				),
	.disk1_slave_address_ack			(disk1_slave_address_ack				),
	.disk1_slave_wrreq					(disk1_slave_wrreq						),
	.disk1_slave_wrack					(disk1_slave_wrack						),
	.disk1_slave_be						(disk1_slave_be							),
	.disk1_slave_datain					(disk1_slave_datain						),
	.disk1_slave_rdreq					(disk1_slave_rdreq						),
	.disk1_slave_rdack					(disk1_slave_rdack						),
	.disk1_slave_dataout				(disk1_slave_dataout					),
	.disk1_send_msg_request				(disk1_send_msg_request					),
	.disk1_send_msg_ack					(disk1_send_msg_ack						),
	.disk1_send_msg_complete			(disk1_send_msg_complete				),
	.disk1_send_msg_error				(disk1_send_msg_error					),
	.disk1_send_msg_src_rdy				(disk1_send_msg_src_rdy					),
	.disk1_send_msg_dst_rdy				(disk1_send_msg_dst_rdy					),
	.disk1_send_msg_payload				(disk1_send_msg_payload					),
	.disk1_recv_msg_request				(disk1_recv_msg_request					),
	.disk1_recv_msg_ack					(disk1_recv_msg_ack						),
	.disk1_recv_msg_src_rdy				(disk1_recv_msg_src_rdy					),
	.disk1_recv_msg_dst_rdy				(disk1_recv_msg_dst_rdy					),
	.disk1_recv_msg_payload				(disk1_recv_msg_payload					)
);


endmodule
