`ifndef dut_re_agent_sv
`define dut_re_agent_sv
class dut_re_agent extends uvm_agent;
   `uvm_component_utils(dut_re_agent)

   function new(string name="dut_re_agent", uvm_component parent);
      super.new(name,parent);
   endfunction

   virtual dut_if vif;
   
   // Instantiate and create the driver, the sequencer and the monitor.
   dut_re_driver re_driver;
   dut_re_seqr re_seqr;
   dut_re_mon re_mon;

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!(uvm_config_db#(virtual dut_if)::get(this,"","vif",vif))) begin
         `uvm_fatal("dut_re_agent","vif is not set with config_db")
      end
      else begin
         if(vif==null) `uvm_error("dut_re_agent","vif is NULL")
      end

      // Create the driver and set the interface
      re_driver = dut_re_driver::type_id::create("re_driver",this);
      re_driver.vif = vif;

      // Create the monitor and set the interface
      re_mon = dut_re_mon::type_id::create("re_monitor",this);
      re_mon.vif = vif;

      // Create the sequencer
      re_seqr = dut_re_seqr::type_id::create("re_seqr",this);

   endfunction

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      re_driver.seq_item_port.connect(re_seqr.seq_item_export);
   endfunction
endclass
`endif
