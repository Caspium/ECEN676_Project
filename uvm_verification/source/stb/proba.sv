// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module proba #(
  parameter WIDTH = 10,
  parameter INIT = 32'h0000_0001
)(
  input  clk,
  input  rstn,
  input  [WIDTH-1:0] level,
  output reg         hit 
);

  wire [WIDTH-1:0] mask;
  reg  [WIDTH-1:0] sht;
  wire [WIDTH-1:0] sht_a;

  assign mask = 10'b00_0000_1001;
//  assign mask = 20'b0000_0000_0000_0000_1001;

  always @(posedge clk or negedge rstn)
    if (!rstn)
      sht <= INIT;
    else
      sht <= sht_a;

  assign sht_a = (mask & {WIDTH{sht[WIDTH - 1]}}) ^ {sht[WIDTH-2:0], 1'b0};

  always @(posedge clk or negedge rstn)
    if (!rstn)
      hit <= 0;
    else if (sht <= level)
      hit <= 1;
    else
      hit <= 0;

endmodule
