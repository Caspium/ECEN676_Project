`ifndef dut_re_pkg_sv
`define dut_re_pkg_sv
package dut_re_pkg;
   `include "uvm_macros.svh"
   import uvm_pkg::*;
   import fifo_data_item_pkg::*;

   `include "dut_re_seq.sv"
   `include "dut_re_seqr.sv"
   `include "dut_re_driver.sv"
   `include "dut_re_mon.sv"
   `include "dut_re_agent.sv"
endpackage
`endif
