`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2025 11:21:59
// Design Name: 
// Module Name: pc_target_adder
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


module pc_target_adder (
    input [31:0] PC,       // Current PC
    input [31:0] ImmExt,   // Extended immediate (already shifted left for B/J)
    output wire [31:0] PCTarget  // Target address for branch/jump
);
    assign PCTarget = PC + ImmExt;
endmodule

