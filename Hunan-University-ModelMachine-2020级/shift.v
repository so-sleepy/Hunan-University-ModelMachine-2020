module shift (
        input fbus,flbus,frbus,
        input [7:0] a,
        output reg cf,
        output reg [7:0] w
    );
    always @(*)
        begin
            case ({fbus,flbus,frbus})
                3'b100:
                    begin
                        w = a;
                        cf = 0;
                    end
                3'b010:
                    begin
                        w = {a[6:0],a[7]};
                        cf = a[7];
                    end
                3'b001:
                    begin
                        w = {a[0],a[7:1]};
                        cf = a[0];
                    end
                default:
                    begin
                        w = 8'hZZ;
                        cf = 0;
                    end
            endcase
        end
endmodule
