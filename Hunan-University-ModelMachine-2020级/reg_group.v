module reg_group (
        input clk, we,
        input [1:0] raa,
        input [1:0] rwba,
        input [7:0] i,
        output reg [7:0] s,
        output reg [7:0] d
    );
    reg [7:0] A = 8'b00001010;
    reg [7:0] B = 8'b00001011;
    reg [7:0] C = 8'b11000000;
    always @(*)
        begin
            if (raa != 2'b10)
                s = raa == 2'b00 ? A : raa == 2'b01 ? B : C;
            else
                s = 0;
            if (rwba != 2'b10)
                d = rwba == 2'b00 ? A : rwba == 2'b01 ? B : C;
            else
                d = 0;
        end
    always @(negedge clk)
        begin
            if (~we)
                case (rwba)
                    2'b00:
                        A <= i;
                    2'b01:
                        B <= i;
                    2'b11:
                        C <= i;
                endcase
        end
endmodule
