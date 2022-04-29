module SM (
    input clk, sm_en,
    output reg sm
  );
  always @(negedge clk)
  begin
    sm <= sm_en ? ~sm : sm;
  end
endmodule
