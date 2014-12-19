// Instruction Memory consists of 64  bytes                                                                                                                                                    

`define INSMEM_SIZE  64  // 64 byte instruction memory                                                                                                                                         


module insMemory(PC, Instruction);
   input [31:0] PC;
   output [31:0] Instruction;

    reg [7:0] IM[0:`INSMEM_SIZE-1]; // Instruction Memory is declared as array of 64 bytes.                                                                                                    

   initial begin
      $readmemh("program.list", IM);  // Reads 64 bytes from file and initializes IM with the values.                                                                                          
      end

   // Read current instruction pointed to by PC                                                                                                                                                
   assign   Instruction = {IM[PC], IM[PC+1], IM[PC+2], IM[PC+3]};  // Read 4 consecutive bytes (word)                                                                                          

endmodule

