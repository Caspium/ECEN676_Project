`include "uvm_macros.svh"

module tb();
   import uvm_pkg::*;
   import fifo_data_item_pkg::*;
   import dut_we_pkg::*;
   import dut_re_pkg::*;
   `include "./uvm/tests/dut_env.sv"
   `include "./uvm/tests/fifo_sb.sv"
   `include "./uvm/tests/dut_test_base.sv"
   `include "./uvm/tests/dut_test1.sv"

   initial begin
      run_test();
   end
endmodule
module top();
   import uvm_pkg::*;

   logic clk0,clk1;
   logic[8:0] datain;
   logic we;
   logic rstn;
   logic re;
   
   logic readyin;
   logic[8:0] dataout;
   logic readyout;
   logic error;

   dut dut_inst(
     .clk0(clk0),
     .clk1(clk1),
     .rstn(rstn),
     .we(we),
     .datain(datain),
     .re(re),
     .readyin(readyin),
     .dataout(dataout),
     .readyout(readyout),
     .error(error)
  );

   dut_if dut_if_inst(clk0,clk1,rstn);
   assign datain = dut_if_inst.datain;
   assign we = dut_if_inst.we;
   assign re = dut_if_inst.re;

   assign dut_if_inst.readyin = readyin;
   assign dut_if_inst.dataout = dataout;
   assign dut_if_inst.readyout = readyout;
   assign dut_if_inst.error = error;
   initial begin
     clk0=0;
     forever #7 clk0=~clk0;
   end 
   initial begin
     clk1=0;
     forever #5 clk1=~clk1;
   end 

   //rstn
   initial begin
      rstn=1'b0;
      #40;
      rstn=1'b1;
   end

   initial begin
      uvm_config_db#(virtual dut_if) ::set(null,"*","vif",dut_if_inst);
   end
endmodule

