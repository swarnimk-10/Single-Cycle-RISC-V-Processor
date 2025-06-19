`timescale 1ns / 1ps

module alu_mux (
    input [31:0] RD2,
    input [31:0] ImmExt,
    input ALUSrc,
    output [31:0] SrcB
);

    assign SrcB = ALUSrc ? ImmExt : RD2;

endmodule

