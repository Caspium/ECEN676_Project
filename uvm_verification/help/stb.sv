// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module stb (
  output  reg       clk0,
  output  reg       clk1,
  output  reg       rstn,
  output  reg       we,
  output      [8:0] data_wr,
  output  reg       re,
  input             ready_wr,
  input       [8:0] data_rd,
  input             ready_rd,
  input             error
);

  integer       cnt_error_in, cnt_error_out;
  reg     [7:0] addr_wr;
  wire    [7:0] addr_wr_nxt;
  reg     [7:0] addr_rd, addr_rd_nxt;
  reg     [9:0] proba_wr = 10'h200;
  reg     [9:0] proba_rd = 10'h200;
  wire          write, read;
  reg    [47:0] clk0_cycle_counter;
  reg    [47:0] clk1_cycle_counter;


  // Clock generator for clk0

`ifndef ZEBU
  always  #1  clk0 = ~clk0;
`else
zceiClockPort u_clk0 ( .cclock (clk0));
`endif
 
  // Clock generator for clk1
`ifndef ZEBU
  always  #1  clk1 = ~clk1;
`else
zceiClockPort u_clk1 ( .cclock (clk1));
`endif


  // Generate input pattern for Write
  proba #(
    .INIT( 10'h111 )
  ) u0_proba (
    .clk   ( clk0     ),
    .rstn  ( rstn     ),
    .level ( proba_wr ),
    .hit   ( write    )
  );

  always @(posedge clk0 or negedge rstn)
    if (!rstn) begin
      we      <= 0;
      addr_wr <= 0;
    end
    else begin
      if (ready_wr)
        if (write)
          we <= 1;
        else
          we <= 0;
    
      addr_wr <= addr_wr_nxt;
    end

  assign addr_wr_nxt = addr_wr + (ready_wr && we);

  rom u_rom (
    .clk ( clk0        ),
    .a   ( addr_wr_nxt ),
    .q   ( data_wr     )
  );

  // Generate input pattern for Read
  proba #(
    .INIT( 10'h222 )
  ) u1_proba (
    .clk   ( clk1     ),
    .rstn  ( rstn     ),
    .level ( proba_rd ),
    .hit   ( read     )
  );

  always @(posedge clk1 or negedge rstn)
    if (!rstn) begin
      re      <= 0;
    end
    else begin
      if (ready_rd)
        if (read)
          re <= 1;
        else
          re <= 0;
    end
    
  // Output monitor
  always @(posedge clk1 or negedge rstn)
    if (!rstn) begin
      addr_rd <= 0;
    end
    else if (re & ready_rd)
      addr_rd <= addr_rd + 1;

  assign ram_we = ready_rd & re;

  ram u_ram (
    .clk ( clk1    ),
    .a   ( addr_rd ),
    .d   ( data_rd ),
    .we  ( ram_we  )
  );

  parity_check #(
    .WIDTH (9)
  ) u_check (
    .clk   ( clk1    ),
    .ena   ( ram_we  ),
    .a     ( data_rd ),
    .error ( error   )
  );

  // Counter for errors on output
  always @(posedge clk1) begin

    // count test cycles
    clk1_cycle_counter <= clk1_cycle_counter + 1;

    if (error) begin
      cnt_error_out <= cnt_error_out + 1;
      $display("Parity error detected on output at cycle %d of clk1", clk1_cycle_counter);
    end

  end

  // Counter for errors on input
  always @(posedge clk0) begin
    // count test cycles
    clk0_cycle_counter <= clk0_cycle_counter + 1;

    if (top.u_dut.error) begin
      cnt_error_in <= cnt_error_in + 1;
      $display("Parity error detected on input at cycle %d of clk0", clk0_cycle_counter);
    end
  end

endmodule
