
module ALU(
        input m,
        input [3:0] s,
        input [7:0] a,
        input [7:0] b,
        output reg [7:0] t,
        output reg cf, zf
    );
    reg [8:0] f;
    always @(*)
        begin
            if (m == 1'b0)
                begin
                    if (s == 4'b1100)
                        begin
                            t = a;
                            f = a;
                            cf = 0;
                            zf = 0;
                        end
                    else
                        begin
                            t = 0;
                            f = 0;
                            cf = 0;
                            zf = 0;
                        end
                end
            else
                begin
                    case (s)
                        4'b1001:
                            begin
                                t = a + b;
                                f = a + b;
                                cf = (f[8] == 1'b1) ? 1'b1 : 1'b0;
                                zf = (f == 8'b00000000) ? 1'b1 : 1'b0;
                            end
                        4'b0110:
                            begin
                                t = b - a;
                                f = b - a;
                                cf = (f[8] == 1'b1) ? 1'b1 : 1'b0;
                                zf = (f == 8'b00000000) ? 1'b1 : 1'b0;
                            end
                        4'b1011:
                            begin
                                t = a & b;
                                f = a;
                                cf = 0;
                                zf = 0;
                            end
                        4'b0101:
                            begin
                                t = ~ b;
                                f = a;
                                cf = 0;
                                zf = 0;
                            end
                        4'b1010:
                            begin
                                t = b;
                                f = a;
                                cf = 0;
                                zf = 0;
                            end
                        4'b0100:
                            begin
                                t = b;
                                f = a;
                                cf = 0;
                                zf = 0;
                            end
                        default:
                            begin
                                t = 0;
                                f = 0;
                                cf = 0;
                                zf = 0;
                            end
                    endcase
                end
        end
endmodule
