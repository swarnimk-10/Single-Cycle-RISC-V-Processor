`timescale 1ns / 1ps

module risc_single_cycle_top(
    input clk,rst,
    output [31:0] x5,
    output [31:0] x6
);

wire [31:0] PCNext, PC, PCPlus4, instruction, Result, RD1, RD2, SrcB, ALUResult, ReadData, ImmExt, PCTarget;
wire RegWrite, Zero, MemWrite, ALUSrc, PCSrc;
wire [2:0] ImmSrc, ALUControl;
wire [1:0] ResultSrc;

pc_reg_adder uut0(clk,rst,PCNext,PC,PCPlus4);
instruction_memory uut1(PC, instruction);
sign_extend uut2(instruction[31:7],ImmSrc, ImmExt);
pc_target_adder uut3(PC,ImmExt,PCTarget);
pc_next_mux uut4(PCPlus4,PCTarget,PCSrc,PCNext);
register_file uut5(clk,rst,RegWrite,instruction[19:15],instruction[24:20],instruction[11:7],Result,RD1,RD2);
alu_mux uut6(RD2,ImmExt,ALUSrc,SrcB);
alu uut7(RD1,SrcB,ALUControl,ALUResult,Zero);
data_memory uut8(clk,rst,ALUResult,RD2,MemWrite,ReadData);
result_mux uut9(ResultSrc,ALUResult,ReadData,PCPlus4,ImmExt,Result);
control_unit uut(instruction[6:0],instruction[14:12],instruction[30],Zero,PCSrc,ResultSrc,MemWrite,ALUControl,ALUSrc,ImmSrc,RegWrite);

assign x5 = uut5.registers[5];
assign x6 = uut5.registers[6];

endmodule
