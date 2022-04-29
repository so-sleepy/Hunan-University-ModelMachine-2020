module InstructionDecoder (
        input                           en,
        input [7:0]                   ir,
        output reg movea,moveb,movec,
        output reg add,sub,and1,not1,rsr,rsl,
        output reg jmp,jz,jc,in1,out1,nop,halt
    );
    always @(*)
        begin
            {movea,moveb,movec,add,sub,and1,not1,rsr,rsl,jmp,jz,jc,in1,out1,nop,halt} = 0;
            if (en)
                begin
                    case (ir[7:4])
                        4'b1100:
                            if (ir[3:0] != 4'b1111)
                                begin
                                    if (ir[1:0] == 2'b11)
                                        movec = 1;
                                    else if (ir[3:2] == 2'b11)
                                        moveb = 1;
                                    else
                                        movea = 1;
                                end
                        4'b1001:
                            add = 1;
                        4'b0110:
                            sub = 1;
                        4'b1011:
                            and1 = 1;
                        4'b0101:
                            not1 = 1;
                        4'b1010:
                            if (ir[1:0] == 2'b00)
                                rsr = 1;
                            else
                                rsl = 1;
                        4'b0011:
                            if (ir[3:2] == 2'b00)
                                begin
                                    case (ir[1:0])
                                        2'b00:
                                            jmp = 1;
                                        2'b01:
                                            jz = 1;
                                        2'b10:
                                            jc = 1;
                                        default:
                                            begin
                                                jmp = jmp;
                                                jz = jz;
                                                jc = jc;
                                            end

                                    endcase
                                end
                        4'b0010:
                            in1 = 1;
                        4'b0100 :
                            out1 = 1;
                        4'b0111:
                            if (ir[3:0] == 4'b0000)
                                nop = 1;
                        4'b1000:
                            if (ir[3:0] == 4'b0000)
                                halt = 1;
                        default:
                            halt = halt;
                    endcase
                end
        end
endmodule
