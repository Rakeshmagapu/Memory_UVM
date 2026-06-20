class mem_cov extends uvm_subscriber#(mem_tx);

`uvm_component_utils(mem_cov)
 mem_tx tx;
   
//covergrou

covergroup cg;
   WR_RD_CP:coverpoint(tx.wr_rd); //implicit auto bin creation
   ADDR_CP:coverpoint(tx.addr){
      option.auto_bin_max=16;
   }
 WR_RD_X_ADDR:cross WR_RD_CP,ADDR_CP; //32bins   
endgroup

function new(string name="",uvm_component parent);
  super.new(name,parent);
  cg=new();
endfunction


function void build_phase (uvm_phase phase);
 super.build_phase(phase);
endfunction

//provide the implimentation for write method-broadcast
virtual function void write(mem_tx t);
 $cast(tx,t);
 cg.sample();
endfunction

endclass
