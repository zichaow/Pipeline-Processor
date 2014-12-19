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
	
	output reg wbEnableM,memWriteM,memReadM;
	output reg [4:0] writeRegM;
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
	
	

	
	