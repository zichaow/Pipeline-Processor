





`define MAX_TIME 800

module testbench;	
   reg  Clk;
   processor myProcessor(Clk);

   initial begin
      Clk = 0;
   end

   always @(*) begin
     while ($time < `MAX_TIME)
       begin
          	#5; Clk = ~Clk;
       end
   end
   
	always @(negedge Clk)  begin
		$display("Time:%3d Clk: %d", $time, Clk);
 // PC
		$display("IF Instruction Register = %h, ", myProcessor.instruction);
		$display("PCPlus4F = %x", myProcessor.PCPlus4F);
		$display("ALU.TargetaddrE(address from ALU)= %x",myProcessor.ALU_TargetAddrE);
		$display("the mux will select which PC to use ");
  		$display("  next_PC =%x", myProcessor.PC_in);
		
  		$display("  -------------output from IF/ID register---------------");
		
		$display("  PCPlus4D = %d", myProcessor.PCPlus4D);
  	        $display("  ID Instruction Register = %h", myProcessor.instrD);
		$display("  -----------output from the ID/EX register-----------------");
		$display("  EX Instruction Register = %h", myProcessor.instrE);
		$display("  reg file: EX_DataA = %h", myProcessor.dataAE);
  	    $display("  reg file: EX_DataB = %h", myProcessor.dataBE);
	   
		$display("  decoder: EX Register Destination = %d", myProcessor.RegDestE);
		$display("  decoder: address information = %h", myProcessor.addrInfoE);
		$display("  decoder: aluOp = %d", myProcessor.ALUopE);
		$display("  decoder: memory read = %h", myProcessor.memReadE);
		$display("  decoder: memory write = %h", myProcessor.memWriteE);
		$display("  decoder: iType = %h", myProcessor.iTypeE);
		$display("  decoder: write back enable = %h", myProcessor.wbEnableE);
		$display("  decoder: isBranchD = %h", myProcessor.isBranchE);
		$display("  decoder: isJumpD = %h", myProcessor.isJumpE);
		$display("  sign extended result = %h",myProcessor.SignExtE);
		$display("  output from MUX and give to ALU: ALU_SrcBE = %h", myProcessor.ALU_SrcBE);
		$display("  EX_ALU_TargetAddr = %h", myProcessor.ALU_TargetAddrE);
		$display("  EX_ALU_Result = %h", myProcessor.aluResultE);

		$display("  -----------output from the EX/MEM register-----------------");		
        // Execution Stage
		$display("  MEM Instruction Register = %h", myProcessor.instrM);
  		
                $display(" MEM read_data = %d", myProcessor.ReadDataM);
  		$display(" MEM Register Destination = %d", myProcessor.RegDestM);
		$display(" MEM memoryRead =%d", myProcessor.memReadM);
		$display(" MEM memWrite =%d", myProcessor.memWriteM);
		$display(" MEM wbEnable =%d", myProcessor.wbEnableM);
		$display(" MEM ALUresult =%h", myProcessor.ALU_OutM);
		$display(" MEM writeDataM =%d", myProcessor.WriteDataM);
		$display("  ----------Output from MEM/WB Register------------------");
		
      	// Writeback Stage
		 
      	$display("  WB Instruction Register = %h", myProcessor.instrW);
      	$display("  WB_Read_Data = %d", myProcessor.ReadDataW);
      	$display("  WB_Pass_Data (result from ALU)= %h", myProcessor.PassDataW);
      	$display("  mux after WB register WB_MuxResult = %d", myProcessor.MuxResultW);
      	$display("  WB Register Destination = %d", myProcessor.RegDestW);
      	$display("  WB_wbEnable = %b", myProcessor.wbEnableW);
      	$display("  MEM_memRead = %b", myProcessor.memReadM);
		$display("  ----------------------------");

	end
endmodule
