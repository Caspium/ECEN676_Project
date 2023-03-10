// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module dut (
  input  clk0,
  input  clk1,
  input  rstn,
  input  we,
  input  [8:0] datain,
  input  re,
  output readyin,
  output [8:0] dataout,
  output readyout,
  output error
);

  wire readyin_n;
  wire readyout_n;
  wire [7:0] dataout_noparity;

  parity_check #(
    .WIDTH (9)
  ) u_check (
    .clk   ( clk0   ),
    .ena   ( we     ),
    .a     ( datain ),
    .error ( error  )
  );

  fifo #(
    .WIDTH (8),
    .DEPTH (7)
  ) 
  u_fifo (
    .rstn_i ( rstn ),
    .wclk_i ( clk0 ),
    .rclk_i ( clk1 ),
    .we_i   ( we ),
    .d_i    ( datain[7:0] ),
    .re_i   ( re ),
    .q_o    (),
    .qa_o   ( dataout_noparity ),
    .ff_o   ( readyin_n ),
    .hff_o  (),
    .ef_o   ( readyout_n )
  );

  assign readyin = !readyin_n;
  assign readyout = !readyout_n;

  parity #(
    .WIDTH (8)
  )
  u_parity (
    .a   ( dataout_noparity ),
    .par ( parout )
  );

  assign dataout = { parout, dataout_noparity };

endmodule
