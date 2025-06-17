`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2025 11:22:58
// Design Name: 
// Module Name: pc_next_mux
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

module pc_next_mux (
    input [31:0] PCPlus4,    // PC + 4 (normal next)
    input [31:0] PCTarget,   // Branch or jump target
    input PCSrc,      // Control signal (1 = take branch/jump)
    output wire [31:0] PCNext      // Final next PC
);
    assign PCNext = (PCSrc) ? PCTarget : PCPlus4;
endmodule

