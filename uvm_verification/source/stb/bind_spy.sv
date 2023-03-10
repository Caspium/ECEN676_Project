// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

bind top.u_dut.u_fifo fifo_usage_spy #(.WIDTH( ADD_WIDTH )) u_fifo_usage_spy (
  .clk    ( wclk_i   ),
  .rstn   ( rstn_i   ),
  .remain ( w_remain )
);
