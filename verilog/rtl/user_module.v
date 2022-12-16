module user_module(
  input wire clk,
  input wire [7:0] io_in,
  output wire [7:0] out
);
  // lint_off MULTIPLY
  function automatic [7:0] umul8b_4b_x_4b (input reg [3:0] lhs, input reg [3:0] rhs);
    begin
      umul8b_4b_x_4b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY

  // ===== Pipe stage 0:

  // Registers for pipe stage 0:
  reg [7:0] p0_io_in;
  always @ (posedge clk) begin
    p0_io_in <= io_in;
  end

  // ===== Pipe stage 1:
  wire [3:0] p1_bit_slice_34_comb;
  wire [3:0] p1_bit_slice_35_comb;
  assign p1_bit_slice_34_comb = p0_io_in[3:0];
  assign p1_bit_slice_35_comb = p0_io_in[7:4];

  // Registers for pipe stage 1:
  reg [3:0] p1_bit_slice_34;
  reg [3:0] p1_bit_slice_35;
  always @ (posedge clk) begin
    p1_bit_slice_34 <= p1_bit_slice_34_comb;
    p1_bit_slice_35 <= p1_bit_slice_35_comb;
  end

  // ===== Pipe stage 2:
  wire [7:0] p2_n_comb;
  assign p2_n_comb = umul8b_4b_x_4b(p1_bit_slice_34, p1_bit_slice_35);

  // Registers for pipe stage 2:
  reg [7:0] p2_n;
  always @ (posedge clk) begin
    p2_n <= p2_n_comb;
  end
  assign out = p2_n;
endmodule
