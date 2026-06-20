 class mem_agent extends uvm_agent;
 
 `uvm_component_utils(mem_agent)
 
 mem_sqr mem_sqr_h;
 mem_drv mem_drv_h;
 mem_cov mem_cov_h;
 mem_mon mem_mon_h;

 function new(string name="",uvm_component parent);
  super.new(name,parent);
 endfunction 

function void build_phase (uvm_phase phase);
  super.build_phase(phase);
  mem_sqr_h=mem_sqr::type_id::create("mem_sqr_h",this);
  mem_drv_h=mem_drv::type_id::create("mem_drv_h",this);
  mem_mon_h=mem_mon::type_id::create("mem_mon_h",this);
  mem_cov_h=mem_cov::type_id::create("mem_cov_h",this);
  `uvm_info(get_type_name(),"build_phase is excuted",UVM_NONE)
 endfunction

function void connect_phase(uvm_phase phase); 
  `uvm_info("mem_agent","connect_phase is excuted",UVM_NONE)
  //drv to seq connection using tlm 
  mem_drv_h.seq_item_port.connect(mem_sqr_h.seq_item_export);
//mon need to be connected to cov - we use uvm tlm ports
  mem_mon_h.ap_h.connect(mem_cov_h.analysis_export);
endfunction


endclass
