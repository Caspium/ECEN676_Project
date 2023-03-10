// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module wave;
  initial begin: fwc_essential_signals
    (* fwc *) $dumpvars (1, top.clk0);
    (* fwc *) $dumpvars (1, top.clk1);
  end
  initial begin: fwc_fifo_ports
    (* fwc *) $dumpports (top.u_dut.u_fifo);
  end
endmodule
