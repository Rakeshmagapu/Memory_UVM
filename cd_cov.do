vlib work
vlib uvm

vmap work ./work
vmap uvm  ./uvm

# Compile UVM ONCE
vlog -sv \
     +incdir+C:/questasim64_2024.1/uvm-1.2/src \
     -work uvm \
     C:/questasim64_2024.1/uvm-1.2/src/uvm_pkg.sv

# Compile your TB
vlog -sv list.svh

vopt top +cover=fcbest -o mem_full_wr_rd_test
vsim -coverage mem_full_wr_rd_test +TESTNAME=mem_full_wr_rd_test
run -all




//vlog list.svh
//vopt top +cover=fcbest -o mem_full_wr_rd_test
//vsim -coverage test_lib +TESTNAME=mem_full_wr_rd_test
//coverage save -onexit mem_full_wr_rd_test.ucdb
//do exclusion.do
//add wave -r sim:/top/pif/*
//run -all
