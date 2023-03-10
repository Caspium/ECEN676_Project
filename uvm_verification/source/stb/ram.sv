// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module ram (
  input  clk,
  input  [7:0] a,
  input  [8:0] d,
  input  we
);

  reg [8:0] mem [0:255];

  always @(posedge clk) begin
    if (we)
      mem[a] <= d;
  end

endmodule

