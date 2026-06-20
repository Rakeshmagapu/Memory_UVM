class mem_wr_rd_seq extends uvm_sequence#(mem_tx);
  
  `uvm_object_utils(mem_wr_rd_seq)

  bit[7:0] addr_q[$];
  bit[7:0]addr_t;

  function new(string name="");
     super.new(name);
  endfunction

task pre_body();
  `uvm_info("mem_wr_rd_seq","pre_body is excuted",UVM_NONE)  
endtask

task body();
  `uvm_info("mem_wr_rd_seq","body is started",UVM_NONE)  
  //1WR_1RD
  //wr tx
  //tx=req;
  //re
  `uvm_do_with(req,{req.wr_rd==1;})
  addr_q.push_back(req.addr);

  //rd tx
  addr_t=addr_q.pop_front();
  `uvm_do_with(req,{req.wr_rd==0;
                    req.addr==addr_t;})
  					
  `uvm_info("mem_wr_rd_seq","body is completed",UVM_NONE)  
endtask

task post_body();
  `uvm_info("mem_wr_rd_seq","post_body is excuted",UVM_NONE)  
endtask

endclass



//------------------------------------------------------------------------------------------------------------------------------------------
                //NWR_NRD_SEQ
//------------------------------------------------------------------------------------------------------------------------------------------

class mem_n_wr_rd_seq extends uvm_sequence#(mem_tx);
 `uvm_object_utils(mem_n_wr_rd_seq)
  
  mem_wr_rd_seq mem_wr_rd_seq_h;
  uvm_phase phase;
  int num_tx;
  
  function new(string name="");
     super.new(name);
  endfunction

 
task pre_body();
  phase=get_starting_phase();
    if(phase!=null)begin
     phase.raise_objection(this);
	 phase.phase_done.set_drain_time(this,100);
	 `uvm_info(get_type_name(),"raise_objection",UVM_NONE)
   end
  
endtask


  task body();
 `uvm_info(get_type_name(),"body of mem_n_wr_rd_seq start",UVM_NONE)
  if(!uvm_config_db#(int)::get(null,"","INT_NUM_TX",num_tx))begin
    `uvm_error(get_type_name(),"FAILED TO RETRIVE VALUE FROM CONFIG_DB")
  end
     repeat(num_tx)begin
       `uvm_do(mem_wr_rd_seq_h)
	 end
  endtask
 
 task post_body();
   if(phase!=null)begin
     phase.drop_objection(this);
  end
  `uvm_info(get_type_name(),"drop_objection",UVM_NONE)
 endtask
 
endclass



//------------------------------------------------------------------------------------------------------------------------------------
//mem_full_wr_rd seq
//entire DEPTH location of memeory seq is genetare the tx
//random unique address

class mem_full_wr_rd_seq extends uvm_sequence#(mem_tx);

`uvm_object_utils(mem_full_wr_rd_seq)
//property
rand bit [`ADDR_WIDTH-1:0]addr_q[$];

  constraint addr_c{
    addr_q.size== 16;
    unique {addr_q};
  }

   function new(string name="");
     super.new(name);
   endfunction


task body();
  this.randomize();
  `uvm_info("RAND VALUE",$sformatf("addr_q=%p",addr_q),UVM_NONE)
 //generate mem DEPTH TX making sure all the addres are unique
 //WR 

  `uvm_info(get_type_name(),"WR TX START",UVM_NONE)
 for(int i=0;i<`DEPTH;i++)begin
   `uvm_do_with(req,{req.wr_rd==1;
                     req.addr==addr_q[i];
					 })   
  end
  //RD
  `uvm_info(get_type_name(),"RD TX START",UVM_NONE)

   for(int i=0;i<`DEPTH;i++)begin
   `uvm_do_with(req,{req.wr_rd==0;
                     req.addr==addr_q[i];
					 })   
  end


endtask

endclass
