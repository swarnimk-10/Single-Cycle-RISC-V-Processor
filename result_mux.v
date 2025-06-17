module result_mux (
    input  [1:0]  ResultSrc,
    input  [31:0] ALUResult,
    input  [31:0] ReadData,
    input  [31:0] PCPlus4,
    input  [31:0] ImmExt,       // Added this input for LUI immediate
    output reg [31:0] WD3
);

    always @(*) begin
        case (ResultSrc)
            2'b00: WD3 = ALUResult;
            2'b01: WD3 = ReadData;
            2'b10: WD3 = PCPlus4;
            2'b11: WD3 = ImmExt;   // For LUI instruction
            default: WD3 = 32'b0;  
        endcase
    end

endmodule
