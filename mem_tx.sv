class mem_tx extends uvm_sequence_item;

rand bit wr_rd;
rand bit[`DATA_WIDTH-1:0]wr_data;
rand bit[`ADDR_WIDTH-1:0]addr;
     bit [`DATA_WIDTH-1:0] rd_data;

//factory registeration + property/field registeration
`uvm_object_utils_begin(mem_tx)
   `uvm_field_int(wr_rd,UVM_ALL_ON)
   `uvm_field_int(addr,UVM_ALL_ON)
   `uvm_field_int(wr_data,UVM_ALL_ON)
   `uvm_field_int(rd_data,UVM_ALL_ON)
`uvm_object_utils_end


function new(string name="");
  super.new(name);
endfunction

endclass
