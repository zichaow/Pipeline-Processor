`define NUM_REGS 32
`define REG_WIDTH 32
`define MUX_CNTRL 5   // Number of bits to specify a register                                                                                                                                  


module regFile(Clk, SrcRegA, SrcRegB, DestReg, WriteData, WE, DataA, DataB);
   input Clk;
   input [`MUX_CNTRL-1:0] SrcRegA, SrcRegB;
   input [`MUX_CNTRL-1:0] DestReg;
   input [`REG_WIDTH-1:0] WriteData;
   input WE;
   output [`REG_WIDTH-1:0] DataA, DataB;

   reg [`REG_WIDTH-1:0]  REG_FILE [0:`NUM_REGS-1];  // Create required Register File                                                                                                           
   integer i;

 initial begin
    for (i=0; i < `NUM_REGS; i=i+1) begin
      REG_FILE[i] = 0;
    end
// Initialize registers to non-zero values as needed by your program.                                                                                                                          
// For the program provided initialize R1 to 5.                                                                                                                                                
end

always @(negedge Clk)
       begin
        if (WE)
          REG_FILE[DestReg] <=  WriteData;
        end

   assign   DataA = REG_FILE[SrcRegA];
   assign   DataB = REG_FILE[SrcRegB];


endmodule
