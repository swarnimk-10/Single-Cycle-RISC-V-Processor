`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2025 15:02:26
// Design Name: 
// Module Name: data_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_memory (
    input        clk,
    input        rst,
    input [31:0] ALUResult,    // Address from ALU (byte address)
    input [31:0] WriteData,    // Data to write (from RD2)
    input        MemWrite,     // Control signal to write
    output reg [31:0] ReadData // Data read from memory
);

    // 16 KB memory = 4096 words (4 bytes each)
    reg [31:0] memory [0:4095];

    integer i;

    initial begin
        // Initialize memory to zero
        for (i = 0; i < 4096; i = i + 1) begin
            memory[i] = 32'b0;
        end

        // Example: set memory at 0x2000 to 10
        // Calculate index: 0x2000 / 4 = 8192 / 4 = 2048
        memory[2048] = 32'd10;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset memory if needed - optional for real hardware
            for (i = 0; i < 4096; i = i + 1)
                memory[i] <= 32'b0;
        end else if (MemWrite) begin
            // Write data on MemWrite signal
            memory[ALUResult[13:2]] <= WriteData;
        end
    end

    always @(*) begin
        // Read is asynchronous
        ReadData = memory[ALUResult[13:2]];
    end

endmodule

