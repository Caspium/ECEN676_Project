`ifndef dut_env_sv
`define dut_env_sv
class dut_env extends uvm_env;
   `uvm_component_utils(dut_env)

   function new(string name="dut_env", uvm_component parent);
      super.new(name,parent);
   endfunction

   // Instantiate the interface, the read agent and the write agent
   virtual dut_if vif;
   dut_re_agent re_agent;
   dut_we_agent we_agent;  
   

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!(uvm_config_db#(virtual dut_if)::get(this,"","vif",vif))) begin
         `uvm_fatal("dut_env","vif is not set with config_db")
      end
      else begin
         if(vif==null) `uvm_error("dut_env","vif is NULL")
      end
      
      uvm_config_db#(virtual dut_if)::set(this,"we_agent","vif",vif);
      
      // Create the write agent
      we_agent = dut_we_agent::type_id::create("we_agent",this);
      
      uvm_config_db#(virtual dut_if)::set(this,"re_agent","vif",vif);
      
      // Create the read agent
      re_agent = dut_re_agent::type_id::create("re_agent",this);
      
   endfunction

endclass
`endif
