`timescale 1ns / 1ps

module pc_next_mux (
    input [31:0] PCPlus4,    // PC + 4 (normal next)
    input [31:0] PCTarget,   // Branch or jump target
    input PCSrc,      // Control signal (1 = take branch/jump)
    output wire [31:0] PCNext      // Final next PC
);
    assign PCNext = (PCSrc) ? PCTarget : PCPlus4;
endmodule

