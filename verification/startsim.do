vlib work

#vlib data_fetch_v1_00_a
#vlog -timescale "1ns / 1ps" -work data_fetch_v1_00_a +incdir+/home/grads/irick/cse417/Libraries/sources/data_fetch_v1_00_a/hdl/verilog/ /home/grads/irick/cse417/Libraries/sources/data_fetch_v1_00_a/hdl/verilog/*.v

#vlib data_store_v1_00_a
#vlog -timescale "1ns / 1ps" -work data_store_v1_00_a +incdir+/home/grads/irick/cse417/Libraries/sources/data_store_v1_00_a/hdl/verilog/ /home/grads/irick/cse417/Libraries/sources/data_store_v1_00_a/hdl/verilog/*.v

#vlib skintone_controller_v1_00_a
#vlog -timescale "1ns / 1ps" -work skintone_controller_v1_00_a +incdir+/home/grads/irick/cse417/Libraries/sources/skintone_controller_v1_00_a/hdl/verilog/ /home/grads/irick/cse417/Libraries/sources/skintone_controller_v1_00_a/hdl/verilog/*.v

vlib disk_v1_00_a
vlog -timescale "1ns / 1ps" -work disk_v1_00_a +incdir+../library/disk_v1_00_a/hdl/verilog/ ../library/disk_v1_00_a/hdl/verilog/*.v

vlib host_emulator_v1_00_a
vlog -timescale "1ns / 1ps" -work host_emulator_v1_00_a +incdir+../library/host_emulator_v1_00_a/hdl/verilog/ ../library/host_emulator_v1_00_a/hdl/verilog/*.v

vlog -sv +define+SIMULATION -timescale "1ns / 1ps" +incdir+./ ./*.v 
vlog -sv +define+SIMULATION -timescale "1ns / 1ps" +incdir+./ /home/software/xilinx-13.2/ISE_DS/ISE/verilog/src/glbl.v

vsim -voptargs="+acc" -t 1ps  -L infrastructure_v2_00_a -L host_emulator_v1_00_a -L disk_v1_00_a -L xilinxcorelib_ver -L unisims_ver -L secureip -lib work work.system_tb_synth glbl


