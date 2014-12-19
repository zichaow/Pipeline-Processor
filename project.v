/*pipeline register modules
defines registers used at different stages in pipeline processor.
Need four registers: 
	one between IF and ID stage
	one between ID and EX stage
	one between EX and MEM stage
	one between MEM and WB stage
*/


/*clock need a register????*/
module register_PC(clock,PC,PCF);
	input [31:0] PC_in;
	input clock;
	output [31:0] PCF;
	
	reg [31:0] PCF;
	
	initial begin
		PCF = 0;
	end
	always@(posedge clock)
	begin
		PCF <= PC;
	end
endmodule


//register between IF and ID stage
module register_IFID(clock,PCPlus4F,RD,InstrD,PCPlus4D);
	input [31:0] PCPlus4F, RD;//pc incremented value, output from IM
	input clock;
	output [31:0] InstrD, PCPlus4D;//output incremented pc value, and output from IM
	
	reg [31:0] InstrD, PCPlus4D;//registers to store the two values above
	
	initial begin//initialize output from this register
		InstrD = 0;
		PCPlus4D = 0;
	end
	
	always@(posedge clock)//assign the corresponding input to output
	begin
		InstrD <= RD;
		PCPlus4D <= PCPlus4F;
	end
	
endmodule	


//register between ID and EX stage
module register_IDEX(
clock,addrInfo_in,ALUop_in,writeReg_in,memRead_in,memWrite_in,iType_in,wbEnable_in,isBranch_in,isJump_in,RD1,RD2,InstrD,SignExt_in,PCPlus4D,
addrInfo_out,ALUop_out,writeReg_out,memRead_out,memWrite_out,iType_out,wbEnable_out,isBranch_out,isJump_out,DataA,DataB,InstrE,SignExt_out,PCPlus4E);
	input clock;
	input [31:0] RD1,RD2,InstrD,SignExt_in,PCPlus4D;
	input [25:0] addrInfo_in;
	input [2:0] ALUop_in;
	input [4:0] writeReg_in;//writeReg = destination register
	input wbEnable_in, memRead_in, memWrite_in, iType_in, isBranch_in, isJump_in;
	
	output reg [31:0] DataA,DataB,InstrE,SignExt_out,PCPlus4E;
	output reg [25:0] addrInfo_out;
	output reg [2:0] ALUop_out;
	output reg [4:0] writeReg_out;
	output reg wbEnable_out, memRead_out, memWrite_out, iType_out, isBranch_out, isJump_out;
	
	initial begin
		DataA = 0;
		DataB = 0;
		InstrE = 0;
		SignExt_out = 0;
		addrInfo_out = 0;
		ALUop_out = 0;
		writeReg_out = 0;
		wbEnable_out = 0;
		memRead_out = 0;
		memWrite_out = 0;
		iType_out = 0;
		isBranch_out = 0;
		isJump_out = 0;
		PCPlus4E = 0;
	end
	
	always@(posedge clock)//assign the corresponding input to output
	begin
		DataA <= RD1;//output1 from register file
		DataB <= RD2;//output2 from register file
		InstrE <= InstrD;//instruction 
		SignExt_out <= SignExt_out;//sign extended input
		addrInfo_out <= addrInfo_out;//addrInfo from decoder
		ALUop_out <= ALUop_out;//ALUop from decoder
		writeReg_out <= writeReg_out;//writeReg from decoder (destination register)
		wbEnable_out <= wbEnable_out;//wbEnable from decoder
		memRead_out <= memRead_out;//memRead from decoder
		memWrite_out <= memWrite_out;//memWrite from decoder
		iType_out <= iType_out;//iType from decoder
		isBranch_out <= isBranch_out;//isBranch from decoder
		isJump_out <= isJump_out;//isJump from decoder
		PCPlus4E <= PCPlus4D;//PCPlus from PC
	end
	
endmodule


//register between EX and MEM stage
module register_EXMEM(clock,wbEnableE,memWriteE,memReadE,writeRegE,aluResult,DataB,InstrE,
wbEnableM,memWriteM,memReadM,writeRegM,aluResultM,DataBM,InstrM);	
input wbEnableE,memWriteE,memReadE,writeRegE;
	input [31:0] aluResult,DataB,InstrE;
	input clock;
	
	output reg wbEnableM,memWriteM,memReadM,writeRegM;
	output reg [31:0] aluResultM,DataBM,InstrM;
	
	initial begin//initialize output from this register
		wbEnableM = 0;
		memWriteM = 0;
		memReadM = 0;
		writeRegM = 0;
		aluResultM = 0;
		DataBM = 0;
		InstrM = 0;
	end
	
	always@(posedge clock)//assign the corresponding input to output
	begin
		wbEnableM <= wbEnableE;
		memWriteM <= memWriteE;
		memReadM <= memReadE;
		writeRegM <= writeRegE;
		aluResultM <= aluResult;
		DataBM <= DataB;
		InstrM <= InstrE;
	end
	
endmodule	


//register between MEM and WB stage
module register_MEMWB(clock,wbEnableM,writeRegM,aluResultM,LoadValue,InstrM,
wbEnableW,writeRegW,aluResultW,LoadValueW,InstrW);
	input clock;
	input wbEnableM,writeRegM;
	input [31:0] aluResultM,LoadValue,InstrM;
	
	output reg wbEnableW,writeRegW;
	output reg [31:0] aluResultW,LoadValueW,InstrW;
	
	initial begin//initialize output from this register
		wbEnableW = 0;
		writeRegW = 0;
		aluResultW = 0;
		LoadValueW = 0;
		InstrW = 0;
	end
	
	always@(posedge clock)//assign the corresponding input to output
	begin
		wbEnableW <= wbEnableM;
		writeRegW <= writeRegM;
		aluResultW <= aluResultM;
		LoadValueW <= LoadValue;
		InstrW <= InstrM;
	end
	
endmodule	
	
	

	
	
module mux2_bit32(in1,in2,s, mux_32_out);

   input [31:0] in1;
   input [31:0] in2;
   input        s;
   output [31:0] mux_32_out;
   assign mux_32_out = (s==1)? in2:in1;
endmodule//mux2_bit32/

// /
module mux2_bit5(in1,in2,s,mux_5_out);

   input[4:0] in1;
   input [4:0]in2;
   input      s;
   output [4:0] mux_5_out;
   assign mux_5_out=(s==1)?in2:in1;
endmodule//mux2_bit5//

module processor(Clk);

    input Clk;
	

// Instantiate modules making up the processor
	wire [31:0] PC;
	wire [31:0] PC_in;
	wire [31:0] PCF;
	wire [31:0] next_PC;
	wire [31:0] instruct;
	wire [31:0] instrD;
	wire [31:0] ID_read_data_1;
	wire [31:0] ID_read_data_2;
	wire [31:0] ID_sign_ext;
	wire Dest_Reg;
	wire [4:0] ID_Reg_Dest;
	wire [2:0] ID_ALU_op;
	wire ID_memRead;
	wire ID_memWrite;
	wire [25:0] ID_addrInfo;
	wire ID_iTyoe;
	wire ID_wbEnable;
	wire ID_isBranch;
	wire ID_isJump;
	wire [31:0] PCPlus4D;
	wire [31:0] instrE;
	wire [31:0] EX_dataA;
	wire [31:0] EX_dataB;
	wire [31:0] EX_sign_ext_data;
	wire [4:0] EX_Reg_Dest;
	wire [31:0] EX_ALU_SrcBe;
	wire [31:0] EX_ALU_Result;
	wire EX_memWrite;
	wire EX_memWrite;
	wire EX_wbEnable;
	wire[2:0] EX_ALU_op;
	wire EX_iType;
	wire EX_isJump;
	wire EX_isBranch;
	wire [25:0] EX_addrInfo; 		
	wire [31:0] EX_ALU_TargetAddr;	
	wire [31:0] PCPlus4E; 
	wire [31:0] EX_sign_ext; 
	
	// MEM Data Memory
	wire [31:0] instrM;           	    
	wire [31:0] MEMaddr_ALU_OutM;       
	wire [31:0] MEM_WriteDataM;        
	wire [4:0] MEM_Reg_Dest;            
	wire MEMRead;           			
	wire MEMWrite; 						
	wire [31:0] MEM_Read_Data;     
	wire MEM_memWrite; 				
										
	wire MEM_memRead; 				
									
	wire MEM_wbEnable; 				
									
	wire [31:0] MEM_PC_BranchM;
	// WB Write Back into registers
	wire [31:0] instrW;             
	wire [4:0] WB_Reg_Dest;            
	wire [31:0] WB_MuxResult;         
	wire WB_write_enb; 		
	wire [31:0] WB_Read_Data; 		  
	wire [31:0] WB_Pass_Data; 
	wire WB_wbEnable;
	wire WB_memRead;
	initial begin
// Initialize all microarchitectural registers
		assign PC = 0;
		assign circle = 0;
	end
	
   assign PCSrc = ((EX_isBranch ==1)&(EX_ALU_Result == 32'b1))|(EX_isJump ==1 );
   mux2_32bit(.in1(next_PC),
				.in2(EX_ALU_TargetAddr),
				.s(PCSrc),
				.mux_32_out(PC_in));

   register_PC(.clock(clk),
               .inpt(PC_in),
               .clear(clear),
				.outpt(PCF));


   assign next_PC = PCF+4;

   insMemory instruct_mem(.PC(PCF),
						.Instruction(instruct));

   register_IFID(.clock(clk),
                 .PCPlus4F(next_PC),
                 .RD(instruct),
                 .InstrD(instrD),
     .PCPlus4D(PCPlus4D));

   insDecoder decoder(.instruction(instrD),
                      .addrInfo(ID_addrInfo),
					  .ALUop(ID_ALUop),
                      .writeReg(ID_Reg_Dest),
                      .memRead(ID_memRead),
                      .memWrite(ID_memWrite),
                      .iType(ID_iType),
                      .wbEnable(ID_wbEnable),
                      .isBranch(ID_isBranch),
						.isJump(ID_isJump));

   regFile Regfile(.Clk(Clk),
                   .SrcRegA(instrD[25:21]),
                   .SrcRegB(instrD[20:16]),
                   .DestReg(WB_Reg_Dest)
				   .WriteData(WB_MuxResult),
				   .WE(WB_wbEnable),
				   .DataA(ID_read_data_1),
				   .DataB(ID_read_data_2));
	assign ID_sign_ext = {{16{instrD[15]}},instrD[15:0]};

	register_IDEX(.clock(clk),
				.addrInfo_in(ID_addrInfo),
				.ALUop_in(ID_ALUop),
				.writeReg_in(ID_Reg_Dest),
				.memRead_in(ID_memRead),
				.memWrite_in(ID_memWrite),
				.iType_in(ID_iType),
				.wbEnable_in(ID_wbEnable),
				.isBranch_in(ID_isBranch),
				.isJump_in(ID_isJump),
				.RD1(ID_read_data_1),
				.RD2(ID_read_data_2),
				.instrD(instrD),
				.SignExt_in(ID_sign_ext),
				.PCPlus4D(PCPlus4D),
				.addrInfo_out(EX_addrInfo),
				.ALUop_out(Ex_ALUop),
				.writeReg_out(EX_Reg_dest),
				.memRead_out(EX_memRead),
				.memWrite_out(EX_memWrite),
				.iType_out(EX_iType),
				.wbEnable_out(EX_wbEnable),
				.isBranch_out(EX_isBranch),
				.isJump_out(EX_isJump),
				.DataA(EX_dataA),
				.DataB(Ex_dataB),
				.InstrE(instrE),
				.SignExt_out(EX_sign_ext),
				.PCPlus4E(PCPlus4E));
	mux2_bit32(.in1(EX_dataB),
			.in2(EX_sign_ext),
			.s(EX_iType),
			.mux_32_out(EX_ALU_SrcBE));
	alu (.aluOP(EX_ALU_op),
		.operand1(EX_dataA),
		.operand2(EX_ALU_SrcBE),
		.jump(EX_isJump),
		.Branch(EX_isBranch),
		.pc(PCPlus4E),
		.addrInfo(EX_addrInfo),
		.aluResult(EX_ALU_Result),
		.targetAddr(EX_ALU_TargetAddr));
	register(.clock(clk),
				.wbEnableE(EX_wbEnable),
				.memReadE(EX_memRead),
				.memWriteE(EX_memWrite),
				.writeRegE(EX_Reg_Dest),
				.aluResult(EX_aluResult),
				.DataB(EX_dataB),
				.InstrE(instrE),
				.wbmemReadM(MEM_memread),
				.wbEnableM(MEM_wbEnable),
				.memWriteM(MEM_memWrite),
				.writeRegM(MEM_Reg_Dest),
				.aluResultM(MEM_ALU_OutM),
				.InstrM(instrM),
				.DataBM(MEM_WriteDataM));
	dataMemory data_MEM(.MemRead(MEM_memRead),
						.MemWrite(MEM_memWrite),
						.Address(MEM_ALU_OutM),
						.StoreValue(MEM_WriteDataM),
						.LoadValue(MEM_Read_Data));
	register_MEMWB(.clock(clk),
					.wbEnableM(MEM_wbEnable),
					.memReadM(MEM_memRead),
					.aluResultM(MEM_ALU_OutM),
					.writeRegM(MEM_Reg_Dest),
					.LoadValue(MEM_Read_Data),
					.InstrM(instrM),
					.wbEnableW(WB_wbEnable),
					.wbDataReg(WB_Reg_Dest),
					.memReadW(WB_memRead),
					.InstrW(instrW),
					.aluResultW(WB_Pass_Data),
					.LoadValueW(WB_Read_Data));
	mux2_bit32(.in1(WB_Pass_Data),
				.in2(WB_Read_Data),
				.s(WB_memRead),
				.mux_32_out(WB_MuxResult));
				
endmodule //processor
					
				
		
		