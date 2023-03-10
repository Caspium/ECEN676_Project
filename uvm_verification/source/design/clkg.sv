// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module clkg (
  input  clkin,
  input  enable,
  output clkout
);

  reg enable_r;

  always @(*)
    if (!clkin)
      enable_r <= enable;

  assign clkout = enable_r && clkin;

endmodule
