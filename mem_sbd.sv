class mem_sbd extends uvm_subscriber#(mem_tx);
  `uvm_component_utils(mem_sbd)
mem_tx tx;

bit[`DATA_WIDTH-1:0]sbd_AA[*];

function new(string name="",uvm_component parent);
  super.new(name,parent);
endfunction

//provide the implementation fotr the write method
virtual function void write(mem_tx t);
   $cast(tx,t); //$cast is used to safely convert the received transaction to the expected type and to support polymorphism in UVM, avoiding run-time errors when derived transactions are sent.”
   //sbd logic 
    if(tx.wr_rd==1)begin
	//store the data wr_data into sbd AA
	sbd_AA[tx.addr]=tx.wr_data;
	end
	else begin
     //compare the rd_data the AA contents
	 //compare expected data with actual data
	 if(tx.rd_data==sbd_AA[tx.addr])begin
       mem_common::match_count++;
	 end
	 else begin
       mem_common::miss_match_count++;
      `uvm_error("SBD_ERR",$sformatf("@addr =%h actual data=%h does not match with the expected data=%h",tx.addr,tx.rd_data,sbd_AA[tx.addr]))
	end
	end
endfunction


endclass
