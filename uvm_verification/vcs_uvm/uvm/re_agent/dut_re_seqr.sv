`ifndef dut_re_seqr_sv
`define dut_re_seqr_sv
class dut_re_seqr extends uvm_sequencer#(fifo_data_item);
    `uvm_sequencer_utils(dut_re_seqr)
    function new(string name="dut_re_seqr",uvm_component parent);
       super.new(name,parent);
    endfunction
endclass
`endif
