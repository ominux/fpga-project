module disk  
(
	// SAP Clock and Reset
	input				sap_user_clk1,
	input				sap_user_clk2,
	input				sap_user_clk3,
	input				sap_user_clk4,
	output				sap_clk,
	input				sap_rst,
		
	//SAP NIF Signals
	// SAP Master Command Interface (Unused)
	output 				master_request,
	input				master_request_ack,
	input				master_request_complete,
	input	[6	:0]		master_request_error,
	input	[3  :0]		master_request_tag,
	output	[3  :0]		master_request_type,
	output	[9  :0]		master_request_flow,
	output	[35 :0]		master_request_local_address,
	output	[35 :0]		master_request_length,
	
	// SAP Master Descriptor Interface (Unused)
	output				master_descriptor_src_rdy,
	input				master_descriptor_dst_rdy,
	input	[3  :0]		master_descriptor_tag,
	output	[127:0]		master_descriptor,
	
	// SAP Master Data Interface (Unused
	input      			master_datain_src_rdy,
	output				master_datain_dst_rdy,
	input	[3  :0]		master_datain_tag,
	input	[127:0]		master_datain,
	output				master_dataout_src_rdy,
	input				master_dataout_dst_rdy,
	input	[3  :0]		master_dataout_tag,
	output	[127:0]		master_dataout,
	
	// SAP Slave Interface 
	input				slave_burst_start,
	input	[12:0]		slave_burst_length,
	input				slave_burst_rnw,
	input 	[35 :0]		slave_address,
	input	[3  :0]		slave_transaction_id,
	input				slave_address_valid,
	output				slave_address_ack,
	input 	[3  :0]		slave_wrreq,
	output				slave_wrack,
	input 	[15 :0] 	slave_be,
	input 	[127:0]		slave_datain,
	input 	[3  :0]  	slave_rdreq,
	output      		slave_rdack,
	output 	[127:0]		slave_dataout,
	
	// SAP Message Send Interface (Unused)
	output				send_msg_request,
	input				send_msg_ack,
	input				send_msg_complete,
	input	[1  :0]		send_msg_error,
	output				send_msg_src_rdy,
	input				send_msg_dst_rdy,
	output	[127:0]		send_msg_payload,

	// SAP Message Recv Interface (Unused)
	input				recv_msg_request,
	output				recv_msg_ack,
	input				recv_msg_src_rdy,
	output				recv_msg_dst_rdy,
	input	[127:0]		recv_msg_payload,
	
	output	reg			debug
	
);

	`include "math.vh"
	
	parameter	C_INIT_FILE_NAME		= "";
	parameter	C_RAM_NUM_BYTES			= (1024*64*2);
	localparam	C_RAM_NUM_ENTRIES		= C_RAM_NUM_BYTES/16;
	localparam	C_RAM_ADDRESS_WIDTH		= clog2(C_RAM_NUM_ENTRIES);
	
	assign sap_clk						= sap_user_clk1;
	
	assign master_request 				= 1'b0;
	assign master_request_type 			= 4'b0;
	assign master_request_flow 			= 10'b0;
	assign master_request_local_address = 36'b0;
	assign master_request_length 		= 36'b0;
	
	assign master_descriptor_src_rdy	= 1'b0;
	assign master_descriptor			= 128'b0;
	
	assign master_datain_dst_rdy		= 1'b0;
	
	assign master_dataout_src_rdy		= 1'b0;
	assign master_dataout				= 128'b0;
	
	assign send_msg_request				= 1'b0;
	assign send_msg_src_rdy				= 1'b0;
	assign send_msg_payload				= 128'b0;
	
	assign recv_msg_ack					= 1'b0;
	assign recv_msg_dst_rdy				= 1'b0;
	
	(* KEEP="TRUE" *)
	reg		[127:0]							sram_memory	[C_RAM_NUM_ENTRIES-1:0];
	reg		[127:0]							sram_write_data;
	reg		[C_RAM_ADDRESS_WIDTH-1:0]		sram_write_address;
	reg										sram_write_enable;
	reg		[127:0]							sram_read_data;
	wire	[C_RAM_ADDRESS_WIDTH-1:0]		sram_read_address;
	
	reg					slave_rdack_r;
	
	/////////////////////////////////////////////////////////////
	// Memory Write Interface
	/////////////////////////////////////////////////////////////
	generate 
		if (C_INIT_FILE_NAME != "")
		begin
			initial 
			begin
				$readmemh(C_INIT_FILE_NAME,sram_memory);
			end
		end
	endgenerate
			
	always @(posedge sap_clk)
	begin
		if (sram_write_enable)
		begin
			sram_memory[sram_write_address] <= sram_write_data;
		end
	end
	
	assign slave_address_ack	= slave_address_valid;
	assign slave_wrack 			= |slave_wrreq;
	
	always @(posedge sap_clk)
	begin
		sram_write_data 	<= slave_datain;
		sram_write_address 	<= slave_address[(C_RAM_ADDRESS_WIDTH + 4)-1:4];
		sram_write_enable 	<= |slave_wrreq;
	end
	
	/////////////////////////////////////////////////////////////
	// Memory Read Interface
	/////////////////////////////////////////////////////////////
	assign sram_read_address = slave_address[(C_RAM_ADDRESS_WIDTH + 4)-1:4];
	
	always @(posedge sap_clk)
	begin
		sram_read_data <= sram_memory[sram_read_address];
	end
	
	always @(posedge sap_clk)
	begin
		slave_rdack_r <= |slave_rdreq;
	end
	
	always @(posedge sap_clk)
	begin
		debug <= ^sram_read_data[127:0];
	end
	
	assign slave_rdack = slave_rdack_r & (|slave_rdreq);
	assign slave_dataout = sram_read_data;
	
	
endmodule
