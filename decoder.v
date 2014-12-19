`define RType instruction[31:26]==6'h0
`define ADDI instruction[31:26]==6'h8
`define LOAD instruction[31:26]==6'h20
`define STORE instruction[31:26]==6'h30
`define BEQ instruction[31:26]==6'h4
`define JMP instruction[31:26]==6'h2


`define ADD instruction[31:26]==6'h0 & instruction[5:0]==6'h20
`define SUB instruction[31:26]==6'h0 & instruction[5:0]==6'h22
`define AND instruction[31:26]==6'h0 & instruction[5:0]==6'h24
`define OR instruction[31:26]==6'h0 & instruction[5:0]==6'h25
`define SLT instruction[31:26]==6'h0 & instruction[5:0]==6'h2A
`define NOP instruction[31:26]==6'h0 & instruction[5:0]==6'h0


module insDecoder(instruction, addrInfo, ALUop, writeReg, memRead, memWrite, iType, wbEnable, isBranch, isJump);

input [31:0] instruction;
output [25:0] addrInfo;
output [2:0] ALUop;
output [4:0] writeReg;//destination (dst)
output wbEnable, memRead, memWrite, iType, isBranch, isJump;


   /*
    Input:
                   32-bit "instruction"
    Outputs:

    isBranch, isJump : TRUE  if instruction is branch or jump respectively; FALSE  otherwise.
    memRead: TRUE if instruction will read from data memory; FALSE otherwise.
    memWrite: TRUE if instruction will write to  data memory; FALSE otherwise.
    wbEnable: TRUE if instruction will write a result to a register; FALSE otherwise
    iType: TRUE if it is an IType instruction that is not a Branch; FALSE for Branch and non I-Type istructions.

    writeReg: id of register to be written; dont care if wbEnable is set to FALSE.
    addrInfo: the 26 LSBs of the instruction
    ALUop:  Defined by Table 2/

    */
   assign isBranch=`BEQ;
   assign isJump=`JMP;
   assign memRead=`LOAD;
   assign memWrite=`STORE;
   assign wbEnable=(`ADD)||(`AND)||(`OR)||(`SLT)||(`SUB)||(`ADDI)||(`LOAD);
   assign iType=`ADDI||`LOAD||`STORE;
   assign writeReg[4:0]=((`ADD)||(`AND)||(`OR)||(`SLT)||(`SUB)||(`ADDI)||(`LOAD))? ((instruction[31:26]==6'h0) ? instruction[15:11]:instruction[20:16]):5'hx;
   assign addrInfo[25:0]=instruction[25:0];
   assign ALUop[2:0]=((`ADD)||(`ADDI)||(`LOAD)||(`STORE))? 3'b001:((`SUB)? 3'b010:((`AND)? 3'b011:((`OR)? 3'b100:((`SLT)? 3'b101:((`BEQ)?3'b110:3'bxxx)))));


endmodule
