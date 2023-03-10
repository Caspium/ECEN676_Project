`ifndef dut_re_driver_sv
`define dut_re_driver_sv
class dut_re_driver extends uvm_driver#(fifo_data_item);
    `uvm_component_utils(dut_re_driver)
    virtual dut_if.re_drv_mp vif;
    function new(string name="dut_re_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
       super.run_phase(phase);
       vif.re_drv_cb.re<=1'b0;
       wait(vif.rstn==1'b1);
       `uvm_info("dut_re_driver","RSTN is 1'b1",UVM_LOW)
       forever begin
          seq_item_port.get_next_item(req);
          `uvm_info("dut_re_driver",$psprintf("RE_DRV starts Reading data"),UVM_LOW)
          @(posedge vif.clk1);
          vif.re_drv_cb.re<=1'b1;
          @(posedge vif.clk1);
          while(vif.re_drv_cb.readyout!=1'b1) begin
             `uvm_info("dut_re_driver",$psprintf("readyout is low"),UVM_LOW)
             @(posedge vif.clk1);
          end
          vif.re_drv_cb.re<=1'b0;
          rsp = fifo_data_item::type_id::create("rsp");
          rsp.set_id_info(req);
          rsp.data=vif.re_drv_cb.dataout;
          `uvm_info("dut_re_driver",$psprintf("RE_DRV gets one data: %s",rsp.psprint()),UVM_LOW)
          seq_item_port.item_done();
          seq_item_port.put_response(rsp);
       end
    endtask
endclass

`endif

