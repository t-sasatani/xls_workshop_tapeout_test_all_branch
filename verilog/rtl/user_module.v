module user_module(
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
  wire [7:0] n;
  assign n = umul8b_4b_x_4b(io_in[3:0], io_in[7:4]);
  assign out = n;
endmodule
