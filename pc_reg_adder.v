`timescale 1ns / 1ps


module pc_reg_adder (
    input clk,
    input reset,
    input [31:0] PCNext,    // Chosen next PC from mux
    output reg  [31:0] PC,        // Current PC
    output [31:0] PCPlus4    // PC + 4
);

    // PC Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'h00000000;   // Start execution at address 0
        else
            PC <= PCNext;
    end

    // PCPlus4 logic (combinational)
    assign PCPlus4 = PC + 32'd4;

endmodule

