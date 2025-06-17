`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2025 14:37:53
// Design Name: 
// Module Name: alu_mux
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

module alu_mux (
    input [31:0] RD2,
    input [31:0] ImmExt,
    input ALUSrc,
    output [31:0] SrcB
);

    assign SrcB = ALUSrc ? ImmExt : RD2;

endmodule

