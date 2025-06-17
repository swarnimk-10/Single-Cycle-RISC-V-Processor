`timescale 1ns / 1ps

module instruction_memory (
    input [31:0] addr,       
    output reg [31:0] instruction 
);

    reg [31:0] rom [0:255];
    integer i;
    initial begin
    
        // Address 0x00: addi x5, x0, 6
        rom[0] = 32'h00600293;  // addi x5, x0, 6

        // Address 0x04: lui x9, 0x2
        rom[1] = 32'h002004b7;  // lui x9, 0x2

        // Address 0x08: addi x9, x9, 4
        rom[2] = 32'h00448493;  // addi x9, x9, 4

        // Address 0x0C: lw x6, -4(x9)
        rom[3] = 32'hffc4a303; // lw x6, -4(x9)

        // Address 0x10: or x4, x5, x6
        rom[4] = 32'h0062a2b3;  // or x4, x5, x6 

        // Address 0x14: sw x6, 8(x9)
        rom[5] = 32'h0084a223;  // sw x6, 8(x9)

        // Address 0x18: jal x1, Label (assuming Label at 0x24, offset = (0x24 - 0x18)/4=3)
        rom[6] = 32'h003000ef;  // jal x1, +12

        // Address 0x1C: beq x4, x4, Label (assuming Label at 0x24, offset = 2 instructions)
        rom[7] = 32'h0042c063;  // beq x4, x4, +8

        // Address 0x20: (NOP or something else)
        rom[8] = 32'h00000013;  // nop (addi x0,x0,0)

        // Address 0x24: Label:
        rom[9] = 32'h00100313;  // addi x6, x0, 1 (dummy instr)

        for (i = 10; i < 256; i = i + 1) begin
            rom[i] = 32'b0;
        end
    end

    always @(*) begin
        instruction = rom[addr[9:2]];
    end

endmodule
