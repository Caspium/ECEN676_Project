`ifndef dut_we_seq_sv
`define dut_we_seq_sv
class dut_we_seq extends uvm_sequence#(fifo_data_item);
   `uvm_object_utils(dut_we_seq)
   function new(string name="dut_we_seq");
      super.new(name);
   endfunction 
   virtual task body();

      // Create fifo data item
      fifo_data_item fifo_data = new();

      // Begin processing a transaction request
      start_item(fifo_data);
      
      if(!(fifo_data.randomize())) begin
         `uvm_fatal("dut_we_seq","fifo_data randomization failure")
      end
      else begin
          `uvm_info("dut_we_seq",$psprintf("fifo_we_data: %s",fifo_data.psprint()),UVM_LOW)
      end

      // Finish processing a transaction request
      finish_item(fifo_data);
      
   endtask
endclass
`endif
