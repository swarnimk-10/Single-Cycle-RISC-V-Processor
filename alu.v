`timescale 1ns / 1ps

module alu (
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [2:0]  ALUControl,  // 3-bit control signal
    output reg  [31:0] ALUResult,
    output Zero
);

    // Zero flag is high when ALUResult is zero
    assign Zero = (ALUResult == 32'b0);

    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB;                      // ADD
            3'b001: ALUResult = SrcA - SrcB;                      // SUB
            3'b010: ALUResult = SrcA & SrcB;                      // AND
            3'b011: ALUResult = SrcA | SrcB;                      // OR
            3'b101: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0;    // SLT
            default: ALUResult = 32'b0;
        endcase
    end

endmodule
