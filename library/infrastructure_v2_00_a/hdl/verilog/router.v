/////////////////////////////////////////////////////////////////////////////
// system_c.v
// 7/7/2011
//
// Sungho Park
// Microsystems Design Lab
// Department of Computer Science and Engineering
// Pennsylvania State University
/////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

`define CHANNEL_TYPE_OUTPUT	0
`define CHANNEL_TYPE_INPUT	1
`define CHANNEL_TYPE_BIDIR	2
`define	CHANNEL_TYPE_NONE	3

module router
(
	router_clk1							,
	router_clk2							,
	router_clk3							,
	router_clk4							,
	router_rst							,
	
	controller_slave_address			,
	controller_slave_wrreq				,
	controller_slave_wrack				,
	controller_slave_datain				,
	controller_slave_rdreq				,
	controller_slave_rdack				,
	controller_slave_dataout			,
	
	client0_sap_clksrc1					,
	client0_sap_clksrc2					,
	client0_sap_clksrc3					,
	client0_sap_clksrc4					,
	client0_sap_clk						,
	client0_sap_rst						,
	client0_master_request				,
	client0_master_request_device		,
	client0_master_request_ack			,
	client0_master_request_complete		,
	client0_master_request_address		,
	client0_master_request_length		,
	client0_master_request_rnw			,
	client0_master_datain_src_rdy		,
	client0_master_datain_dst_rdy		,
	client0_master_datain				,
		
	client1_sap_clksrc1					,
	client1_sap_clksrc2					,
	client1_sap_clksrc3					,
	client1_sap_clksrc4					,
	client1_sap_clk						,
	client1_sap_rst						,
	client1_master_request				,
	client1_master_request_device		,
	client1_master_request_ack			,
	client1_master_request_complete		,
	client1_master_request_address		,
	client1_master_request_length		,
	client1_master_request_rnw			,
	client1_master_dataout_src_rdy		,
	client1_master_dataout_dst_rdy		,
	client1_master_dataout				,
	
	disk0_sap_clksrc1					,
	disk0_sap_clksrc2					,
	disk0_sap_clksrc3					,
	disk0_sap_clksrc4					,
	disk0_sap_clk						,
	disk0_sap_rst						,
	disk0_master_request				,
	disk0_master_request_ack			,
	disk0_master_request_complete		,
	disk0_master_request_type			,
	disk0_master_request_error			,
	disk0_master_request_tag			,
	disk0_master_request_flow			,
	disk0_master_request_local_address	,
	disk0_master_request_length			,
	disk0_master_descriptor_src_rdy		,
	disk0_master_descriptor_dst_rdy		,
	disk0_master_descriptor_tag			,
	disk0_master_descriptor				,
	disk0_master_datain_src_rdy			,
	disk0_master_datain_dst_rdy			,
	disk0_master_datain_tag				,
	disk0_master_datain					,
	disk0_master_dataout_src_rdy		,
	disk0_master_dataout_dst_rdy		,
	disk0_master_dataout_tag			,
	disk0_master_dataout				,
	disk0_slave_burst_start				,
	disk0_slave_burst_length			,
	disk0_slave_burst_rnw				,
	disk0_slave_address					,
	disk0_slave_transaction_id			,
	disk0_slave_address_valid			,
	disk0_slave_address_ack				,
	disk0_slave_wrreq					,
	disk0_slave_wrack					,
	disk0_slave_be						,
	disk0_slave_datain					,
	disk0_slave_rdreq					,
	disk0_slave_rdack					,
	disk0_slave_dataout					,
	disk0_send_msg_request				,
	disk0_send_msg_ack					,
	disk0_send_msg_complete				,
	disk0_send_msg_error				,
	disk0_send_msg_src_rdy				,
	disk0_send_msg_dst_rdy				,
	disk0_send_msg_payload				,
	disk0_recv_msg_request				,
	disk0_recv_msg_ack					,
	disk0_recv_msg_src_rdy				,
	disk0_recv_msg_dst_rdy				,
	disk0_recv_msg_payload				,

	disk1_sap_clksrc1					,
	disk1_sap_clksrc2					,
	disk1_sap_clksrc3					,
	disk1_sap_clksrc4					,
	disk1_sap_clk						,
	disk1_sap_rst						,
	disk1_master_request				,
	disk1_master_request_ack			,
	disk1_master_request_complete		,
	disk1_master_request_type			,
	disk1_master_request_error			,
	disk1_master_request_tag			,
	disk1_master_request_flow			,
	disk1_master_request_local_address	,
	disk1_master_request_length			,
	disk1_master_descriptor_src_rdy		,
	disk1_master_descriptor_dst_rdy		,
	disk1_master_descriptor_tag			,
	disk1_master_descriptor				,
	disk1_master_datain_src_rdy			,
	disk1_master_datain_dst_rdy			,
	disk1_master_datain_tag				,
	disk1_master_datain					,
	disk1_master_dataout_src_rdy		,
	disk1_master_dataout_dst_rdy		,
	disk1_master_dataout_tag			,
	disk1_master_dataout				,
	disk1_slave_burst_start				,
	disk1_slave_burst_length			,
	disk1_slave_burst_rnw				,
	disk1_slave_address					,
	disk1_slave_transaction_id			,
	disk1_slave_address_valid			,
	disk1_slave_address_ack				,
	disk1_slave_wrreq					,
	disk1_slave_wrack					,
	disk1_slave_be						,
	disk1_slave_datain					,
	disk1_slave_rdreq					,
	disk1_slave_rdack					,
	disk1_slave_dataout					,
	disk1_send_msg_request				,
	disk1_send_msg_ack					,
	disk1_send_msg_complete				,
	disk1_send_msg_error				,
	disk1_send_msg_src_rdy				,
	disk1_send_msg_dst_rdy				,
	disk1_send_msg_payload				,
	disk1_recv_msg_request				,
	disk1_recv_msg_ack					,
	disk1_recv_msg_src_rdy				,
	disk1_recv_msg_dst_rdy				,
	disk1_recv_msg_payload				
	
);

////////////////////////////////////////
//{{{ PORTS
////////////////////////////////////////

input				router_clk1							;
input				router_clk2							;
input				router_clk3							;
input				router_clk4							;
input				router_rst							;

output		[35:0]	controller_slave_address			;
output 				controller_slave_wrreq				;
input				controller_slave_wrack				;
output		[127:0]	controller_slave_datain				;
output				controller_slave_rdreq				;
input				controller_slave_rdack				;
input		[127:0]	controller_slave_dataout			;

output				client0_sap_clksrc1					;
output				client0_sap_clksrc2					;
output				client0_sap_clksrc3					;
output				client0_sap_clksrc4					;
input				client0_sap_clk						;
output				client0_sap_rst						;
input 				client0_master_request				;
input		[15:0]	client0_master_request_device		;
output				client0_master_request_ack			;
output				client0_master_request_complete		;
input		[35 :0]	client0_master_request_address		;
input  		[35 :0] client0_master_request_length		;
input  				client0_master_request_rnw			;
output  	        client0_master_datain_src_rdy		;
input				client0_master_datain_dst_rdy		;
output		[127:0]	client0_master_datain				;

output				client1_sap_clksrc1					;
output				client1_sap_clksrc2					;
output				client1_sap_clksrc3					;
output				client1_sap_clksrc4					;
input				client1_sap_clk						;
output				client1_sap_rst						;
input 				client1_master_request				;
input		[15:0]	client1_master_request_device		;
output				client1_master_request_ack			;
output				client1_master_request_complete		;
input		[35 :0]	client1_master_request_address		;
input  		[35 :0] client1_master_request_length		;
input  				client1_master_request_rnw			;
input  	        	client1_master_dataout_src_rdy		;
output				client1_master_dataout_dst_rdy		;
input		[127:0]	client1_master_dataout				;

output				disk0_sap_clksrc1					;
output				disk0_sap_clksrc2					;
output				disk0_sap_clksrc3					;
output				disk0_sap_clksrc4					;
input				disk0_sap_clk						;
output				disk0_sap_rst						;
input 				disk0_master_request				;
output				disk0_master_request_ack			;
output				disk0_master_request_complete		;
output		[6	:0]	disk0_master_request_error			;
output		[3  :0]	disk0_master_request_tag			;
input		[3  :0]	disk0_master_request_type			;
input		[9  :0]	disk0_master_request_flow			;
input		[35 :0]	disk0_master_request_local_address	;
input  		[35 :0] disk0_master_request_length			;
input				disk0_master_descriptor_src_rdy		;
output				disk0_master_descriptor_dst_rdy		;
output		[3  :0]	disk0_master_descriptor_tag			;
input		[127:0]	disk0_master_descriptor				;
output  	        disk0_master_datain_src_rdy			;
input				disk0_master_datain_dst_rdy			;
output		[3  :0]	disk0_master_datain_tag				;
output		[127:0]	disk0_master_datain					;
input				disk0_master_dataout_src_rdy		;
output				disk0_master_dataout_dst_rdy		;
output		[3  :0]	disk0_master_dataout_tag			;
input		[127:0]	disk0_master_dataout				;
output				disk0_slave_burst_start				;
output		[12 :0]	disk0_slave_burst_length			;
output				disk0_slave_burst_rnw				;
output 		[35 :0] disk0_slave_address					;
output		[3  :0]	disk0_slave_transaction_id			;
output				disk0_slave_address_valid			;
input				disk0_slave_address_ack				;
output 		[3  :0]	disk0_slave_wrreq					;
input				disk0_slave_wrack					;
output 		[15 :0] disk0_slave_be						;
output 		[127:0]	disk0_slave_datain					;
output 		[3  :0] disk0_slave_rdreq					;
input   	      	disk0_slave_rdack					;
input  		[127:0]	disk0_slave_dataout					;
input				disk0_send_msg_request				;
output				disk0_send_msg_ack					;
output				disk0_send_msg_complete				;
output		[1  :0]	disk0_send_msg_error				;
input				disk0_send_msg_src_rdy				;
output				disk0_send_msg_dst_rdy				;
input		[127:0]	disk0_send_msg_payload				;
output				disk0_recv_msg_request				;
input				disk0_recv_msg_ack					;
output				disk0_recv_msg_src_rdy				;
input				disk0_recv_msg_dst_rdy				;
output		[127:0]	disk0_recv_msg_payload				;

output				disk1_sap_clksrc1					;
output				disk1_sap_clksrc2					;
output				disk1_sap_clksrc3					;
output				disk1_sap_clksrc4					;
input				disk1_sap_clk						;
output				disk1_sap_rst						;
input 				disk1_master_request				;
output				disk1_master_request_ack			;
output				disk1_master_request_complete		;
output		[6	:0]	disk1_master_request_error			;
output		[3  :0]	disk1_master_request_tag			;
input		[3  :0]	disk1_master_request_type			;
input		[9  :0]	disk1_master_request_flow			;
input		[35 :0]	disk1_master_request_local_address	;
input  		[35 :0] disk1_master_request_length			;
input				disk1_master_descriptor_src_rdy		;
output				disk1_master_descriptor_dst_rdy		;
output		[3  :0]	disk1_master_descriptor_tag			;
input		[127:0]	disk1_master_descriptor				;
output  	        disk1_master_datain_src_rdy			;
input				disk1_master_datain_dst_rdy			;
output		[3  :0]	disk1_master_datain_tag				;
output		[127:0]	disk1_master_datain					;
input				disk1_master_dataout_src_rdy		;
output				disk1_master_dataout_dst_rdy		;
output		[3  :0]	disk1_master_dataout_tag			;
input		[127:0]	disk1_master_dataout				;
output				disk1_slave_burst_start				;
output		[12 :0]	disk1_slave_burst_length			;
output				disk1_slave_burst_rnw				;
output 		[35 :0] disk1_slave_address					;
output		[3  :0]	disk1_slave_transaction_id			;
output				disk1_slave_address_valid			;
input				disk1_slave_address_ack				;
output 		[3  :0]	disk1_slave_wrreq					;
input				disk1_slave_wrack					;
output 		[15 :0] disk1_slave_be						;
output 		[127:0]	disk1_slave_datain					;
output 		[3  :0] disk1_slave_rdreq					;
input   	      	disk1_slave_rdack					;
input  		[127:0]	disk1_slave_dataout					;
input				disk1_send_msg_request				;
output				disk1_send_msg_ack					;
output				disk1_send_msg_complete				;
output		[1  :0]	disk1_send_msg_error				;
input				disk1_send_msg_src_rdy				;
output				disk1_send_msg_dst_rdy				;
input		[127:0]	disk1_send_msg_payload				;
output				disk1_recv_msg_request				;
input				disk1_recv_msg_ack					;
output				disk1_recv_msg_src_rdy				;
input				disk1_recv_msg_dst_rdy				;
output		[127:0]	disk1_recv_msg_payload				;
////////////////////////////////////////
//}}} PORTS
////////////////////////////////////////




endmodule
