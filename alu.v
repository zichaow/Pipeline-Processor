module alu(aluOp, operand1, operand2, jump, branch, pc, addrInfo, aluResult, targetAddr);

   input wire  [31:0] operand1, operand2;
   input wire [31:0]  pc;
   input wire [25:0]  addrInfo;
   input wire         jump, branch;
   input wire [2:0]   aluOp;
   output reg [31:0]  aluResult, targetAddr;


   // Use your alu module from Homework 3                                                                                                                                                      
   // Set "aluResult" to  the result of the ALU operation indicated by "aluOp".                                                                                                               \
                                                                                                                                                                                               
      // Set "targetAddr" if either "branch" or "jump" signal is  set.                                                                                                                        \
                                                                                                                                                                                               
   always @(aluOp or operand1 or operand2 or jump or  branch or pc or  addrInfo) begin
   // aluOP operations                                                                                                                                                                        \
                                                                                                                                                                                               
         // 1: Add operands.                                                                                                                                                                  \
                                                                                                                                                                                               
         case(aluOp)
           1: aluResult = operand1 + operand2;

           2: aluResult = operand1 - operand2;

           3: aluResult = operand1 & operand2;

           4: aluResult = operand1 | operand2;
// 2: Subtract operand2 from operand1.                                                                                                                                                     \
                                                                                                                                                                                               
              // 3: Bitwise AND of operands.                                                                                                                                                  \
                                                                                                                                                                                               
              // 4: Bitwise OR of operands.                                                                                                                                                   \
                                                                                                                                                                                               
              // 5: Output set to TRUE if operand1 is less than operand2 interpreted as unsigned integers; else set to FALSE.                                                                 \
                                                                                                                                                                                               
                5: begin
                   if($unsigned(operand1) < $unsigned(operand2)) aluResult = 1;

                   else aluResult = 0;

        end
 // 6: Output set to TRUE if operands are equal; else set to FALSE.                                                                                                                         \
                                                                                                                                                                                               
                6: begin
                   if(operand1 == operand2) aluResult = 1;

                   else aluResult = 0;

        end
 // 7: Output set to TRUE if operand1 is less than operand2 interpreted as signed integers; else set to FALSE.                                                                                
                7: begin
        if($signed(operand1) < $signed(operand2))  //???????????????????????????????????????INTEGER?????????????????????????????????????????????????                                          \
                                                                                                                                                                                               
          aluResult = 1;

        else
          aluResult = 0;

        end
     endcase
// Target Address for Branch                                                                                                                                                               \
                                                                                                                                                                                               
              //  Sign-extend the lower 16 bits of  "addrInfo", scale it by 4, and add to  "pc".                                                                                              \
                                                                                                                                                                                               
      if(branch == 1) targetAddr = pc + { {16{addrInfo[15]}}, {addrInfo[15:0]} } << 2;

      // addrInfo = { {16{addrInfo[15]}}, addrInfo };                                                                                                                                         \
                                                                                                                                                                                               
            // addrInfo = addrInfo << 2;                                                                                                                                                      \
                                                                                                                                                                                               
            // pc = pc + addrInfo;                                                                                                                                                            \
                                                                                                                                                                                               
         // Target Address for Jump                                                                                                                                                           \
                                                                                                                                                                                               
      else if(jump == 1) targetAddr = {{pc[31:28]},addrInfo << 2};


     // addrInfo = addrInfo << 2;                                                                                                                                                              
      else targetAddr = 0;

   end // always @ (aluOp or operand1 or operand2 or jump or  branch or pc or  addrInfo)                                                                                                       

                                                     // // // // // // // // // // // // // // // // //                                                                                        
endmodule

