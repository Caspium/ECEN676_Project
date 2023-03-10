`ifndef dut_we_mon_sv
`define dut_we_mon_sv
class dut_we_mon extends uvm_driver#(fifo_data_item);
   `uvm_component_utils(dut_we_mon)
   uvm_analysis_port#(fifo_data_item) we_mon_port;
   virtual dut_if.we_mon_mp vif;
   function new(string name="dut_we_mon",uvm_component parent);
      super.new(name,parent);
      we_mon_port=new("we_mon_port",this);
   endfunction

   task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("dut_we_mon","Start...",UVM_LOW)
      forever begin

         // Create fifo data item
         fifo_data_item item=new();

         @(posedge vif.clk0);
         if(vif.we_mon_cb.we==1'b1 && vif.we_mon_cb.readyin==1'b1) begin

            // Capture the fifo_data_item
            item.data=vif.we_mon_cb.datain;

            `uvm_info("dut_we_mon",$psprintf("WE_MON gets one data: %s",item.psprint()),UVM_LOW)

            // Write data item to the uvm_analysis_port
            we_mon_port.write(item);

         end
      end
   endtask
endclass

`endif

