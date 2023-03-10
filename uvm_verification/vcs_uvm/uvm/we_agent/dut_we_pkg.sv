`ifndef dut_we_pkg_sv
`define dut_we_pkg_sv
package dut_we_pkg;
   `include "uvm_macros.svh"
   import uvm_pkg::*;
   import fifo_data_item_pkg::*;

   `include "dut_we_seq.sv"
   `include "dut_we_seqr.sv"
   `include "dut_we_driver.sv"
   `include "dut_we_mon.sv"
   `include "dut_we_agent.sv"
endpackage
`endif
