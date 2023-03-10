// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module parity_check #(
  parameter WIDTH = 8
)(
  input clk,
  input ena,
  input [WIDTH-1:0] a,
  output reg error
);

  always @(posedge clk) begin
    if (ena)
      error <= ^a;
    else
      error <= 0;
  end

`ifdef ASSERTIONS
  always @(posedge clk)
    sva_parity_error: assert (!error) $display("SVA: Passing assertion"); else $error ("SVA: Parity error detected.");
`endif

endmodule
