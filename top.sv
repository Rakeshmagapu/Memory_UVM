module top;

//1.clk and rst declaration
 bit clk,rst;
 int num_tx=16;


 //2.clk and rst generation
 always #5 clk=~clk; //100MHZ

 initial begin
   rst=1;
   repeat(2)begin
     @(posedge clk);
   end
    rst=0;
 end


//4.point the pif interface handle to vif of monitor and bfm
 mem_intf pif(clk,rst);


//3.design instantiation

 memory dut (
             .clk_i(pif.clk_i),
			 .rst_i(pif.rst_i),
			 .wr_rd_i(pif.wr_rd_i),
			 .addr_i(pif.addr_i),
			 .wdata_i(pif.wdata_i),
			 .valid_i(pif.valid_i),
			 .rdata_o(pif.rdata_o),
			 .ready_o(pif.ready_o)
			 );


//calling the run_test method
initial begin
   run_test("mem_n_wr_rd_test");
end

//set the interface handle into the congig_db 
  
  initial begin
   
//   $value$plusargs("num_tx=%d",num_tx);
      uvm_config_db#(virtual mem_intf)::set(null,
                                "*",
								"MEM_PIF",
								pif);
     uvm_config_db#(int)::set(null,
	                          "*",
							  "INT_NUM_TX",
							   num_tx);
  end


endmodule
