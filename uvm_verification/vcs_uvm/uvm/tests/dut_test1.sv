`ifndef dut_test1_sv
`define dut_test1_sv
class dut_test1 extends dut_test_base;
   `uvm_component_utils(dut_test1)

   function new(string name="dut_test1", uvm_component parent);
      super.new(name,parent);
   endfunction
   task we_task();
     dut_we_seq we_seq;
     we_seq=dut_we_seq::type_id::create("we_seq");
     repeat(10) begin
        bit timeout;
        `uvm_info("dut_test1.we_task","Writing one data...",UVM_LOW)
        fork 
           begin
              we_seq.start(env.we_agent.we_seqr); 
              timeout=1'b0;
           end
           begin    
               #500;
               timeout=1'b1;
           end
        join_any
        disable fork;
        if(timeout==1'b1) `uvm_fatal("dut_test1","TIMEOUT")
     end
   endtask
   task re_task();
     dut_re_seq re_seq;
     re_seq=dut_re_seq::type_id::create("re_seq");
     repeat(10) begin
        bit timeout;
        `uvm_info("dut_test1.re_task","Reading one data...",UVM_LOW)
        fork 
           begin
              re_seq.start(env.re_agent.re_seqr); 
              timeout=1'b0;
           end
           begin    
               #500;
               timeout=1'b1;
           end
        join_any
        disable fork;
        if(timeout==1'b1) `uvm_fatal("dut_test1.re_task","TIMEOUT")
     end
   endtask
   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     `uvm_info("dut_test1","Test is running...",UVM_LOW)
     phase.raise_objection(this);

     fork
         we_task();     
         re_task();
     join

     phase.drop_objection(this);
   endtask
endclass
`endif
