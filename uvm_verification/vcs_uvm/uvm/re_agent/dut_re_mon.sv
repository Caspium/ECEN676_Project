`ifndef dut_re_mon_sv
`define dut_re_mon_sv
class dut_re_mon extends uvm_driver#(fifo_data_item);
   `uvm_component_utils(dut_re_mon)
   uvm_analysis_port#(fifo_data_item) re_mon_port;
   virtual dut_if.re_mon_mp vif;
   function new(string name="dut_re_mon",uvm_component parent);
      super.new(name,parent);
      re_mon_port=new("re_mon_port",this);
   endfunction

   task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("dut_re_mon","Start...",UVM_LOW)
      forever begin

         // Create fifo data item
         fifo_data_item item=new();

         @(posedge vif.clk1);
         if(vif.re_mon_cb.re==1'b1 && vif.re_mon_cb.readyout==1'b1) begin

            // Capture the fifo_data_item
            item.data=vif.re_mon_cb.dataout;

            `uvm_info("dut_re_mon",$psprintf("WE_MON gets one data: %s",item.psprint()),UVM_LOW)
            
            // Write data item to the uvm_analysis_port
            re_mon_port.write(item);

         end
      end
   endtask
endclass

`endif

