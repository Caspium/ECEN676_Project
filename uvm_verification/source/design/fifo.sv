// © 2015-2019 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

module fifo #(
  parameter WIDTH = 8,
  parameter DEPTH = 4,

  parameter ADD_WIDTH = $clog2(DEPTH)
) (
  input  rstn_i,
  input  wclk_i,
  input  rclk_i,
  input  we_i,
  input  [ WIDTH-1 : 0 ] d_i,
  input  re_i,
  output [ WIDTH-1 : 0 ] q_o,
  output [ WIDTH-1 : 0 ] qa_o,
  output ff_o,
  output hff_o,
  output ef_o
);

  reg  [ WIDTH-1 : 0 ] mem [0: DEPTH];
  reg  [ ADD_WIDTH-1 : 0 ] wa;
  wire [ ADD_WIDTH-1 : 0 ] wa_nxt;
  wire [ ADD_WIDTH-1 : 0 ] wag;
  wire [ ADD_WIDTH-1 : 0 ] wag_nxt;
  reg  [ ADD_WIDTH-1 : 0 ] ra;
  wire [ ADD_WIDTH-1 : 0 ] ra_nxt;
  wire [ ADD_WIDTH-1 : 0 ] rag;
  wire [ ADD_WIDTH-1 : 0 ] rag_nxt;
  wire we;
  wire re;
  reg  [ WIDTH-1 : 0 ] q;
  wire [ WIDTH-1 : 0 ] q_a;
  reg  ef, ff, hff;
  reg  [ ADD_WIDTH-1 : 0 ] w_rag;
  wire [ ADD_WIDTH-1 : 0 ] w_ra;
  wire [ ADD_WIDTH : 0 ] w_remain;

  // Write process
  assign we      = we_i && !ff;
  assign wa_nxt  = wa + 1;
  assign wag     = wa ^ {1'b0, wa[ ADD_WIDTH-1:1]};
  assign wag_nxt = wa_nxt ^ {1'b0, wa_nxt[ ADD_WIDTH-1:1]};

  always @(posedge wclk_i or negedge rstn_i)
    if (!rstn_i) begin
      wa <= 0;
      ff <= 0;
      w_rag <= 0;
      hff   <= 0;
    end
    else begin
      if (we) wa <= wa_nxt;
      ff <= (we && (wag_nxt == rag)) || (ff && (wag == rag));
      w_rag <= rag;
      hff   <= w_remain[ ADD_WIDTH: ADD_WIDTH-1] == 0;
    end

  assign w_ra = w_rag ^ {1'b0, w_rag[ ADD_WIDTH-1:1]};
  assign w_remain = wa_nxt >= w_ra ? {1'b1, w_ra} - {1'b0, wa_nxt} : {1'b0, w_ra} - {1'b0, wa_nxt};

  // Read process
  assign re      = re_i && !ef;
  assign ra_nxt  = ra + 1;
  assign rag     = ra ^ {1'b0, ra[ ADD_WIDTH-1:1]};
  assign rag_nxt = ra_nxt ^ {1'b0, ra_nxt[ ADD_WIDTH-1:1]};

  always @(posedge rclk_i or negedge rstn_i)
    if (!rstn_i) begin
      ra <= 0;
      ef <= 1;
      q  <= 0;
    end
    else begin
      if (re) ra <= ra_nxt;
      ef <= (re && (rag_nxt == wag)) || (ef && (rag == wag));
      if (re) q <= q_a;
    end

  // Memory
  clkg u0_clkg(
    .clkin  ( wclk_i ),
    .enable ( we     ),
    .clkout ( wclk_g )
  );

  always @(posedge wclk_g)
      mem[wa] <= d_i;

  assign q_a = mem[ra];

  assign ff_o  = ff;
  assign hff_o = hff;
  assign ef_o  = ef;
  assign qa_o  = q_a;
  assign q_o   = q;

endmodule
