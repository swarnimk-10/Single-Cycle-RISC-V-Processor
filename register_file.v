`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2025 11:37:44
// Design Name: 
// Module Name: register_file
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

module register_file (
    input clk,
    input rst,
    input RegWrite,            // Control signal to enable write
    input [4:0] A1,            // Read register 1 (rs1) 19:15
    input [4:0] A2,            // Read register 2 (rs2) 24:20
    input [4:0] A3,            // Write register (rd) 11:7
    input [31:0] WD3,          // Write data
    output [31:0] RD1,         // Read data 1
    output [31:0] RD2          // Read data 2
);

    // Register file: 32 x 32-bit registers
    reg [31:0] registers [0:31];
    integer i;

    always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] <= 32'b0;
    end else if (RegWrite && A3 != 5'd0) begin
        registers[A3] <= WD3;
    end
end


    // Asynchronous reads
    assign RD1 = (A1 != 5'd0) ? registers[A1] : 32'b0;
    assign RD2 = (A2 != 5'd0) ? registers[A2] : 32'b0;

endmodule


//✅ Asynchronous read: outputs (RD1, RD2) change instantly when A1, A2 change → perfect for one-cycle design.

//❌ Synchronous read: outputs update only on clock edge → introduces a full cycle delay → not okay for single-cycle RISC-V.
