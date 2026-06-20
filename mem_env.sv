class mem_env extends uvm_env;
`uvm_component_utils(mem_env)

mem_agent mem_agent_h;
mem_sbd mem_sbd_h;

function new(string name="",uvm_component parent);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  mem_agent_h=mem_agent::type_id::create("mem_agent_h",this);
  mem_sbd_h=mem_sbd::type_id::create("mem_sbd_h",this);
  `uvm_info(get_type_name(),"build_phase is excuted",UVM_NONE)  
 endfunction 

function void connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(),"connect_phase is excuted",UVM_NONE) 
  //mon and sbd connection using analysis using connect method
  //master.connect(slave);
  mem_agent_h.mem_mon_h.ap_h.connect(mem_sbd_h.analysis_export);
endfunction
endclass
