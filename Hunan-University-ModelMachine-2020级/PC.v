module PC (
    input clk, pc_ld, pc_inc,
    input [7:0] a,
    output reg [7:0] add
  );
  always @(negedge clk)
  begin
    if ({pc_inc, pc_ld} == 2'b10)
      add <= add + 1'b1;
    if ({pc_inc, pc_ld} == 2'b01)
      add <= a;
  end
endmodule
