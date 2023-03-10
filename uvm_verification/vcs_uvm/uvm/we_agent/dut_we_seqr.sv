`ifndef dut_we_seqr_sv
`define dut_we_seqr_sv
class dut_we_seqr extends uvm_sequencer#(fifo_data_item);
    `uvm_sequencer_utils(dut_we_seqr)
    function new(string name="dut_we_seqr",uvm_component parent);
       super.new(name,parent);
    endfunction
endclass
`endif
