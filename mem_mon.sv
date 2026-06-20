class mem_mon extends uvm_monitor;
`uvm_component_utils(mem_mon)

//analysis
uvm_analysis_port#(mem_tx)ap_h;

//virtual interface 
  virtual mem_intf vif;
  mem_tx tx;


function new(string name="",uvm_component parent);
  super.new(name,parent);
endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
	tx=mem_tx::type_id::create("tx");
    ap_h=new("ap_h",this);

	if(!uvm_config_db#(virtual mem_intf)::get(this,"","MEM_PIF",vif))begin
      `uvm_error(get_type_name(),"CONFIG_DB PIF RETRIVAL FAILED")
	end
  `uvm_info("mem_drv","build_phase is excuted",UVM_HIGH)
   
  endfunction

task run_phase(uvm_phase phase);
   forever begin
    @(vif.mon_cb);
	if(vif.valid_i && vif.ready_o)begin
	//collect all valid tx
       tx.wr_rd=vif.mon_cb.wr_rd_i;
       tx.addr=vif.mon_cb.addr_i;
	   if(tx.wr_rd)//WR
	     tx.wr_data=vif.mon_cb.wdata_i;
    //injecting error in monitor to see if score board captures
	//   if(tx.wr_rd==0 && tx.addr==14)begin
	//     tx.rd_data='h100;
	//   end	 

	   else//RD
	   tx.rd_data=vif.mon_cb.rdata_o;
	   //call the write method
	   //so that tx will rech cov and sbd
	   tx.print();
	   ap_h.write(tx);
	end
   end
endtask



endclass
