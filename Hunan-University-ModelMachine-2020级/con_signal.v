module con_signal (
        input movea, moveb, movec,
        input add, sub, and1, not1, rsr, rsl,
        input jmp, jz, zf, jc, cf, in1, out1, nop, halt,
        input [7:0] ir,
        input sm,
        output reg [1:0] reg_ra, reg_wa, madd,
        output reg [3:0] alu_s,
        output reg pc_ld, pc_inc, reg_we, ram_xl, ram_dl, alu_m,
        output reg shi_fbus, shi_flbus, shi_frbus, ir_ld,
        output reg cf_en ,zf_en, sm_en, in_en, out_en
    );
    always @(*)
        begin
            shi_fbus = add | sub | and1 | not1 | out1 | movea | moveb;
            shi_flbus = rsl;
            shi_frbus = rsr;
            alu_m = add | sub | and1 | not1 | rsr | rsl | out1;
            pc_ld = jmp | (jz & zf) | (jc & cf);
            cf_en = add | sub | rsr | rsl;
            zf_en = add | sub;
            sm_en = ~halt;
            in_en = in1;
            out_en = out1;
            madd = 0;
            reg_ra = 0;
            reg_wa = 0;
            alu_s = 4'b0000;
            if (~sm)
                begin
                    ram_dl = 1;
                    ram_xl = 1;
                    madd = 2'b00;
                    pc_inc = 1;
                    ir_ld = 1;
                    reg_we = 1;
                end
            else
                begin
                    if (add | sub | and1 | movea | moveb | movec)
                        reg_ra = ir[1:0];
                    if (add | sub | and1 | not1 | rsr | rsl | in1 | out1 | movea | moveb | movec)
                        reg_wa = ir[3:2];
                    if (moveb | movec)
                        madd = moveb ? 2'b10 : 2'b01;
                    if (add | sub | and1 | not1 | rsr | rsl | out1 | movea | moveb)
                        alu_s = add ? 4'b1001 : sub ? 4'b0110 : and1 ? 4'b1011 :
                              not1 ? 4'b0101 : rsr ? 4'b1010 : rsl ? 4'b1010 :
                              out1 ? 4'b0100 : movea ? 4'b1100 : 4'b1100;
                    pc_inc = (jz & ~zf) | (jc & ~cf);
                    reg_we = out1 | moveb | jmp |
                           jz | jc | nop | halt;
                    ram_xl = moveb;
                    ram_dl = movec | jmp | (jz & zf) | (jc & cf);
                    ir_ld = ~sm;
                end
        end

endmodule
