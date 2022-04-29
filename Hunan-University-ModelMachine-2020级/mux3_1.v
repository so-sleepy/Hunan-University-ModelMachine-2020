module mux3_1 (
        input [7:0] a,
        input [7:0] b,
        input [7:0] c,
        input [1:0] madd,
        output reg [7:0] y
    );
    always @(*)
        begin
            if (madd != 2'b11)
                begin
                    y = madd == 2'b00 ? a : madd == 2'b01 ? b : c;
                end
            else
                y = 0;
        end
endmodule
