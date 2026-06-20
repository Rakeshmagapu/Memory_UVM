class mem_wr_rd_test extends uvm_test;

`uvm_component_utils(mem_wr_rd_test)

mem_env mem_env_h;

function new (string name="",uvm_component parent);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
   super.build_phase(phase);
  mem_env_h=mem_env::type_id::create("mem_env_h",this);
   `uvm_info("mem_wr_rd_test","build pahse is executed",UVM_NONE)
endfunction


function void start_of_simulation_phase(uvm_phase phase);
    uvm_top.print_topology();
   `uvm_info("mem_wr_rd_test","start_of_simulation_pahse is executed",UVM_NONE) 
endfunction

task run_phase(uvm_phase phase);
  mem_wr_rd_seq mem_wr_rd_seq_h;
  `uvm_info("mem_wr_rd_test","run_pahse is started",UVM_NONE) 
  mem_wr_rd_seq_h=mem_wr_rd_seq::type_id::create("mem_wr_rd_seq_h",this);
  
  `uvm_info("mem_wr_rd_test","run_pahse has raised objection",UVM_NONE) 
  // raise objection
  phase.raise_objection(this);   
  //set the drain time
  phase.phase_done.set_drain_time(this,100);
  //mapping seq and sqr using start memthod
  mem_wr_rd_seq_h.start(mem_env_h.mem_agent_h.mem_sqr_h); 
   // drop objection 
  phase.drop_objection(this);
  `uvm_info("mem_wr_rd_test","run_pahse has dropped objection",UVM_NONE) 
  `uvm_info("mem_wr_rd_test","run_phase is completed",UVM_NONE) 
endtask

function void extract_phase(uvm_phase phase);
  `uvm_info("mem_wr_rd_test","extract_phase is excuted ",UVM_NONE) 
  
 endfunction

function void check_phase(uvm_phase phase);
 
  `uvm_info("mem_wr_rd_test","check_phase is excuted",UVM_NONE) 
 endfunction


function void report_phase(uvm_phase phase);
 
  `uvm_info("mem_wr_rd_test","report_phase is excuted",UVM_NONE) 
endfunction

endclass


//----------------------------------------------------------------------------------------------------------------------------------------
              //NWR_NRD_TEST
//-----------------------------------------------------------------------------------------------------------------------------------------

class mem_n_wr_rd_test extends uvm_test;

`uvm_component_utils(mem_n_wr_rd_test)

mem_env mem_env_h;

function new (string name="",uvm_component parent);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   mem_env_h=mem_env::type_id::create("mem_env_h",this);
   `uvm_info("mem_n_wr_rd_test","build pahse is executed",UVM_NONE)

   uvm_config_db#(uvm_object_wrapper)::set(this,
                                           // "uvm_test_top.mem_env_h.mem_agent_h.mem_sqr_h.run_phase",
										   //"*"
                                             "mem_env_h.mem_agent_h.mem_sqr_h.run_phase",
											"default_sequence",
											 mem_n_wr_rd_seq::get_type);
endfunction


function void start_of_simulation_phase(uvm_phase phase);
    uvm_top.print_topology();
   `uvm_info("mem_n_wr_rd_test","start_of_simulation_pahse is executed",UVM_NONE) 
endfunction


function void extract_phase(uvm_phase phase);
  `uvm_info("mem_n_wr_rd_test","extract_phase is excuted ",UVM_NONE) 
  
 endfunction

function void check_phase(uvm_phase phase);
 
  `uvm_info("mem_n_wr_rd_test","check_phase is excuted",UVM_NONE) 
 endfunction


function void report_phase(uvm_phase phase);
 
  `uvm_info("mem_n_wr_rd_test","report_phase is excuted",UVM_NONE) 
endfunction

endclass


//--------------------------------------------------------------------
//MEM_FULL_WR_RD_TEST

class mem_full_wr_rd_test extends uvm_test;

`uvm_component_utils(mem_full_wr_rd_test)

mem_env mem_env_h;

bit pass_f;

function new (string name="",uvm_component parent);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   mem_env_h=mem_env::type_id::create("mem_env_h",this);
   `uvm_info("mem_wr_rd_test","build pahse is executed",UVM_NONE)
endfunction


function void start_of_simulation_phase(uvm_phase phase);
    uvm_top.print_topology();
   `uvm_info(get_type_name(),"start_of_simulation_pahse is executed",UVM_NONE) 
endfunction

task run_phase(uvm_phase phase);
  mem_full_wr_rd_seq mem_full_wr_rd_seq_h;
  `uvm_info(get_type_name(),"run_pahse is started",UVM_NONE) 
  mem_full_wr_rd_seq_h=mem_full_wr_rd_seq::type_id::create("mem_full_wr_rd_seq_h",this);
   phase.raise_objection(this);   
   phase.phase_done.set_drain_time(this,100);
   mem_full_wr_rd_seq_h.start(mem_env_h.mem_agent_h.mem_sqr_h); 
   phase.drop_objection(this);
  `uvm_info(get_type_name(),"run_phase is completed",UVM_NONE) 
endtask

function void extract_phase(uvm_phase phase);
  `uvm_info(get_type_name(),"extract_phase is excuted ",UVM_NONE) 
  
 endfunction

function void check_phase(uvm_phase phase);
 `uvm_info(get_type_name(),"check_phase is excuted",UVM_NONE)
 if(mem_common::match_count==`DEPTH && mem_common::miss_match_count==0)begin
    pass_f=1;
 end
 else begin
   pass_f=0;
 end
 endfunction


function void report_phase(uvm_phase phase);
 
  `uvm_info(get_type_name(),"report_phase is excuted",UVM_NONE) 
  if(pass_f)begin
   `uvm_info("TEST_STATUS",$sformatf("test %s has PASSED",get_type_name),UVM_NONE)
  end
  else begin

   `uvm_fatal("TEST_STATUS",$sformatf("test %s has FAILED",get_type_name))
  end
endfunction

endclass




