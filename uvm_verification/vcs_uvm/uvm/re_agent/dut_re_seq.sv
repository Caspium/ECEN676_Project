`ifndef dut_re_seq_sv
`define dut_re_seq_sv
class dut_re_seq extends uvm_sequence#(fifo_data_item);
   `uvm_object_utils(dut_re_seq)
   function new(string name="dut_re_seq");
      super.new(name);
   endfunction 
   virtual task body();

      // Create fifo data item
      fifo_data_item fifo_data = new();
      fifo_data_item rsp = new();

      // Begin processing a transaction request
      start_item(fifo_data);

      if(!(fifo_data.randomize())) begin
         `uvm_fatal("dut_re_seq","fifo_data randomization failure")
      end

      // Finish processing a transaction request
      finish_item(fifo_data);

      get_response(rsp);
      `uvm_info("dut_re_seq",$psprintf("get one data from fifo: %0x",rsp.data),UVM_LOW)
   endtask
endclass
`endif
