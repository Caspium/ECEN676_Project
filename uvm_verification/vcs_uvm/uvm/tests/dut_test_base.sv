`ifndef dut_test_base_sv
`define dut_test_base_sv
class dut_test_base extends uvm_test;
   `uvm_component_utils(dut_test_base)

   function new(string name="dut_test_base", uvm_component parent);
      super.new(name,parent);
   endfunction

   virtual dut_if vif;

   // Instantiate the environment and the scoreboard 
   dut_env env;
   fifo_sb sb;

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!(uvm_config_db#(virtual dut_if)::get(this,"","vif",vif))) begin
         `uvm_fatal("dut_test_base","vif is not set with config_db")
      end
      else begin
         if(vif==null) `uvm_error("dut_test_base","vif is NULL")
      end
      uvm_config_db#(virtual dut_if)::set(this,"env","vif",vif);
      
      // Create the environment
      env = dut_env::type_id::create("env",this);
      
      // Create the scoreboard
      sb = new("sb",this);
      
   endfunction

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);   
      env.we_agent.we_mon.we_mon_port.connect(sb.we_export);
      env.re_agent.re_mon.re_mon_port.connect(sb.re_export);
   endfunction
endclass
`endif
