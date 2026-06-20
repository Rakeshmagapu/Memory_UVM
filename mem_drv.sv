class mem_drv extends uvm_driver#(mem_tx);

  `uvm_component_utils(mem_drv)

  virtual mem_intf vif;

  function new(string name="",uvm_component parent);
     super.new(name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);

	if(!uvm_config_db#(virtual mem_intf)::get(this,"","MEM_PIF",vif))begin
      `uvm_error(get_type_name(),"CONFIG_DB PIF RETRIVAL FAILED")
	end
  `uvm_info("mem_drv","build_phase is excuted",UVM_HIGH)
   
  endfunction

  task run_phase(uvm_phase phase);		  
  `uvm_info("mem_drv","run_phase is started",UVM_HIGH)	
	forever begin
       seq_item_port.get_next_item(req);
	 
	   drive_tx(req);
	  // req.print();
	   seq_item_port.item_done();
	end
  endtask


task drive_tx(mem_tx tx);
  `uvm_info(get_type_name(),"drive_tx is excuted",UVM_HIGH)	
  @(vif.drv_cb);
  vif.drv_cb.addr_i   <=tx.addr;
  vif.drv_cb.wr_rd_i  <=tx.wr_rd;
    if(tx.wr_rd==1)begin
      vif.drv_cb.wdata_i <=tx.wr_data;
	end
	vif.drv_cb.valid_i <=1;
	wait(vif.drv_cb.ready_o);
    if(tx.wr_rd==0)begin
	@(vif.drv_cb);
     tx.rd_data=vif.drv_cb.rdata_o;
	  vif.drv_cb.wdata_i <=0;
	  tx.wr_data=0;
    end
    `uvm_info($sformatf("%s_drive_tx_task",get_type_name()),
	                   $sformatf("wr_rd=%s addr=%h data=%h",
					   tx.wr_rd?"WR":"RD",
					   tx.addr,
					   tx.wr_rd?tx.wr_data:tx.rd_data),
					   UVM_NONE)
   vif.drv_cb.addr_i<=0;
   vif.drv_cb.wr_rd_i<=0;
   vif.drv_cb.valid_i<=0;
   vif.drv_cb.wdata_i<=0;


  endtask
endclass 
