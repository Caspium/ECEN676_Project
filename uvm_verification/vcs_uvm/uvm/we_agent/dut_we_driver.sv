`ifndef dut_we_driver_sv
`define dut_we_driver_sv
class dut_we_driver extends uvm_driver#(fifo_data_item);
    `uvm_component_utils(dut_we_driver)
    virtual dut_if.we_drv_mp vif;
    function new(string name="dut_we_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
       super.run_phase(phase);
       vif.we_drv_cb.we<=1'b0;
       vif.we_drv_cb.datain<=0;
       wait(vif.rstn==1'b1);
       `uvm_info("dut_we_driver","RSTN is 1'b1",UVM_LOW)
       forever begin
          seq_item_port.get_next_item(req);
          `uvm_info("dut_we_driver",$psprintf("WE_DRV gets one data: %s",req.psprint()),UVM_LOW)
          @(posedge vif.clk0);
          vif.we_drv_cb.we<=1'b1;
          vif.we_drv_cb.datain<=req.data;
          @(posedge vif.clk0);
          while(vif.we_drv_cb.readyin!=1) begin
             `uvm_info("dut_we_driver",$psprintf("readyin is low"),UVM_LOW)
             @(posedge vif.clk0);
          end
          vif.we_drv_cb.we<=1'b0;
          `uvm_info("dut_we_driver",$psprintf("WE_DRV drives one data: %s",req.psprint()),UVM_LOW)
          seq_item_port.item_done();
       end
    endtask
endclass

`endif

