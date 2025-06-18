`timescale 1ns / 1ps

module pc_target_adder (
    input [31:0] PC,       // Current PC
    input [31:0] ImmExt,   // Extended immediate (already shifted left for B/J)
    output wire [31:0] PCTarget  // Target address for branch/jump
);
    assign PCTarget = PC + ImmExt;
endmodule

