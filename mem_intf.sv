interface mem_intf(input logic clk_i,rst_i);
 
 bit wr_rd_i;
 bit valid_i;
 bit [`DATA_WIDTH-1:0]wdata_i;
 bit [`DATA_WIDTH-1:0]rdata_o;
 bit [`ADDR_WIDTH-1:0]addr_i;
 bit  ready_o;

//drv clocking blockings
clocking drv_cb@(posedge clk_i);
  default input #0 output #1;
  input ready_o;
  input rdata_o;
  output wr_rd_i;
  output valid_i;
  output wdata_i;
  output addr_i;
endclocking

//mon_cb
clocking mon_cb@(posedge clk_i);
  default input #0;
  input ready_o;
  input rdata_o;
  input wr_rd_i;
  input valid_i;
  input wdata_i;
  input addr_i;
endclocking


endinterface
