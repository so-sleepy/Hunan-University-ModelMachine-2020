module IR (
    input clk, ir_ld,
    input [7:0] d,
    output reg [7:0] ir
  );
  always @(negedge clk)
  begin
    if (ir_ld)
      ir <= d;
  end
endmodule
