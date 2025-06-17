`timescale 1ns / 1ps

module risc_single_cycle_top_tb;

    // Inputs
    reg clk;
    reg rst;

    // Instantiate the Unit Under Test (UUT)
    risc_single_cycle_top uut (
        .clk(clk), 
        .rst(rst)
    );

    // Clock generation: 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize Reset
        rst = 1;
        #12;        // Hold reset for a few cycles
        rst = 0;

        // Run simulation for some cycles
        #100;

        // Finish simulation
        $stop;
    end
    initial begin
    $dumpfile("riscv_top_tb.vcd");
    $dumpvars(0, uut);

    $display("Time\tPC\t\tInstruction\tRD1\t\tRD2\t\tImmExt\t\tSrcA\t\tSrcB\t\tALUCtrl\tALUResult\tReadData\tResult");
    $monitor("%0t\t%h\t%h\t%h\t%h\t%h\t%h\t%b\t%h\t%h\t%h\t%h\t%h", 
         $time, 
         uut.PC, 
         uut.instruction,
         uut.RD2, 
         uut.ImmExt, 
         uut.RD1,       // corrected from uut.RD1 to SrcA
         uut.SrcB, 
         uut.ALUControl, 
         uut.ALUResult, 
         uut.ReadData, 
         uut.Result,
         uut.x5,         // added x5
         uut.x6); 
end


endmodule
