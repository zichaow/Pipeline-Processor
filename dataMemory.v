// Data Memory consists of 64  bytes                                                                                                                                                           

`define DATAMEM_SIZE 64
`define MEM_WORD_AT_ADDRESS   {DATAMEM[Address], DATAMEM[Address+1], DATAMEM[Address+2], DATAMEM[Address+3]}


module dataMemory(MemRead, MemWrite, Address, StoreValue, LoadValue);

   input [31:0] Address;         // Memory address to read or write, 4 byte                                                                                                                            
   input [31:0] StoreValue;      // Value to be writeen on memory write, 4 byte                                                                                                                        
   input MemRead, MemWrite;     // Signals indicating read or write of memory                                                                                                                  

   output [31:0] LoadValue;     // Value read from memory                                                                                                                                      

   reg [7:0] DATAMEM[0:`DATAMEM_SIZE-1];   // Declare Data Memory as array of 64 bytes                                                                                                         

   integer   i;
   reg  [31:0] TEMP;


   // Initialize the 16 words of data memory with values from 1 through 16.                                                                                                                    
   initial begin
      for (i=0; i < `DATAMEM_SIZE; i = i+4)  begin
         TEMP = i/4 + 1;
        {DATAMEM[i],DATAMEM[i+1],DATAMEM[i+2],DATAMEM[i+3]} = TEMP;
      end
	end //????????????????? What does this part do? Cannot understand the concatenation 


   assign LoadValue  = (MemRead == 1) ? `MEM_WORD_AT_ADDRESS  : 32'hx;

   always @(MemWrite) begin
     if (MemWrite  == 1)    `MEM_WORD_AT_ADDRESS  = StoreValue;
   end

endmodule
