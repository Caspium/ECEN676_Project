// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module fifo_usage_spy #(
  parameter WIDTH=5,
  parameter DEPTH=32
)(
  input  clk,
  input  rstn,
  input  [WIDTH:0] remain
);

  reg [WIDTH:0] min;

  import "DPI-C" context function void fifo_usage_spy_notify (
    input bit[WIDTH:0] min
  );

  always @(posedge clk or negedge rstn)
    if (!rstn)
      min <= DEPTH;
    else
      if (remain < min) begin
        min <= remain;
        fifo_usage_spy_notify(remain);
      end

endmodule
