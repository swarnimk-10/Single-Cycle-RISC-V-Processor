`timescale 1ns / 1ps

module control_unit (
    input  wire [6:0] op,         // instruction[6:0]
    input  wire [2:0] funct3,     // instruction[14:12]
    input  wire       funct7,     // instruction[30]
    input  wire       zero,       // from ALU

    output wire       PCSrc,      // branch taken or jump
    output reg  [1:0] ResultSrc,  // 00: ALUResult, 01: ReadData, 10: PC+4, 11: ImmExt (for LUI)
    output reg        MemWrite,
    output reg  [2:0] ALUControl,
    output reg        ALUSrc,
    output reg  [2:0] ImmSrc,    // changed to 3 bits
    output reg        RegWrite
);

    reg [1:0] ALUOp;
    reg       Branch;
    reg       Jump;

    // -------- Main Decoder ----------
    always @(*) begin
        // Default values
        RegWrite   = 1'b0;
        ImmSrc     = 3'b000;
        ALUSrc     = 1'b0;
        MemWrite   = 1'b0;
        ResultSrc  = 2'b00;
        ALUOp      = 2'b00;
        Branch     = 1'b0;
        Jump       = 1'b0;

        case (op)
            7'b0000011: begin // lw
                RegWrite   = 1'b1;
                ImmSrc     = 3'b000;   // I-type
                ALUSrc     = 1'b1;
                MemWrite   = 1'b0;
                ResultSrc  = 2'b01;    // Memory data
                ALUOp      = 2'b00;
                Branch     = 1'b0;
                Jump       = 1'b0;
            end
            7'b0100011: begin // sw
                RegWrite   = 1'b0;
                ImmSrc     = 3'b001;   // S-type
                ALUSrc     = 1'b1;
                MemWrite   = 1'b1;
                ResultSrc  = 2'b00;    // don't care
                ALUOp      = 2'b00;
                Branch     = 1'b0;
                Jump       = 1'b0;
            end
            7'b0110011: begin // R-type
                RegWrite   = 1'b1;
                ImmSrc     = 3'b000;   // don't care
                ALUSrc     = 1'b0;
                MemWrite   = 1'b0;
                ResultSrc  = 2'b00;    // ALU result
                ALUOp      = 2'b10;
                Branch     = 1'b0;
                Jump       = 1'b0;
            end
            7'b1100011: begin // beq
                RegWrite   = 1'b0;
                ImmSrc     = 3'b010;   // B-type
                ALUSrc     = 1'b0;
                MemWrite   = 1'b0;
                ResultSrc  = 2'b00;    // don't care
                ALUOp      = 2'b01;
                Branch     = 1'b1;
                Jump       = 1'b0;
            end
            7'b0010011: begin // I-type ALU (e.g. addi)
                RegWrite   = 1'b1;
                ImmSrc     = 3'b000;   // I-type
                ALUSrc     = 1'b1;
                MemWrite   = 1'b0;
                ResultSrc  = 2'b00;    // ALU result
                ALUOp      = 2'b10;
                Branch     = 1'b0;
                Jump       = 1'b0;
            end
            7'b1101111: begin // jal
                RegWrite   = 1'b1;
                ImmSrc     = 3'b011;   // J-type
                ALUSrc     = 1'b1;     // don't care
                MemWrite   = 1'b0;
                ResultSrc  = 2'b10;    // PC+4
                ALUOp      = 2'b00;    // don't care
                Branch     = 1'b0;
                Jump       = 1'b1;
            end
            7'b0110111: begin // LUI
                RegWrite   = 1'b1;
                ImmSrc     = 3'b100;   // U-type
                ALUSrc     = 1'b0;     // don't care
                MemWrite   = 1'b0;
                ResultSrc  = 2'b11;    // Immediate directly as result
                ALUOp      = 2'b00;    // don't care
                Branch     = 1'b0;
                Jump       = 1'b0;
            end
            default: begin
                RegWrite   = 1'b0;
                ImmSrc     = 3'b000;
                ALUSrc     = 1'b0;
                MemWrite   = 1'b0;
                ResultSrc  = 2'b00;
                ALUOp      = 2'b00;
                Branch     = 1'b0;
                Jump       = 1'b0;
            end
        endcase
    end

    // -------- ALU Decoder ----------
    always @(*) begin
        case (ALUOp)
            2'b00:  ALUControl = 3'b000; // add
            2'b01:  ALUControl = 3'b001; // subtract
            2'b10: begin
                case (funct3)
                    3'b000: ALUControl = (funct7 == 1'b1) ? 3'b001 : 3'b000; // sub or add
                    3'b010: ALUControl = 3'b101; // slt
                    3'b110: ALUControl = 3'b011; // or
                    3'b111: ALUControl = 3'b010; // and
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end

    // -------- Final PCSrc Logic --------
    assign PCSrc = (Branch && zero) || Jump;

endmodule
