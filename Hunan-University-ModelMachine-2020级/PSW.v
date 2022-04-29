module PSW (
    input clk, cf_en, zf_en, cf, zf,
    output reg out_c, out_z
  );
  always @(negedge clk)
  begin
    if (cf_en)
      out_c <= cf;
    if(zf_en)
      out_z <= zf;
  end
endmodule
