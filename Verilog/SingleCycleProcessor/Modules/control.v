`timescale 1ns / 1ns

module control(
		input [5:0] instruction,
		output reg [1:0] ALUOp,
		output reg MemRead,
		output reg MemtoReg,
		output reg RegDst,
		output reg Branch, 
		output reg [1:0] ALUSrc,
		output reg MemWrite,
		output reg RegWrite,
		output reg jump
		);


always @(*) begin
		if (instruction == 6'b00_0000) begin				//RType
		ALUOp = 2'b00;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b1;
		Branch = 1'b0;
		ALUSrc = 2'b00;
		MemWrite = 1'b0;
		RegWrite = 1'b1;
		jump = 1'b0;
		
		end else if (instruction == 6'b00_0100) begin   //branch
		ALUOp = 2'b01;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b0;
		Branch = 1'b1;
		ALUSrc = 2'b00;
		MemWrite = 1'b0;
		RegWrite = 1'b0;
		jump = 1'b0;
		
		end else if (instruction == 6'b10_1011) begin   // sw
		ALUOp = 2'b10;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b0;
		Branch = 1'b0;		
	    ALUSrc = 2'b01;
		MemWrite = 1'b1;
		RegWrite = 1'b0;
		jump = 1'b0;
		
		end else if (instruction == 6'b10_0011) begin   // lw
		ALUOp = 2'b10;
		MemRead = 1'b1;
		MemtoReg = 1'b1;
		RegDst = 1'b0;
        Branch = 1'b0;		
	    ALUSrc = 2'b01;
		MemWrite = 1'b0;
		RegWrite = 1'b1;
		jump = 1'b0;
		
		end else if (instruction == 6'b00_1000) begin     // IType
		ALUOp = 2'b10;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b0;
		Branch = 1'b0;
		ALUSrc = 2'b01;
		MemWrite = 1'b0;
		RegWrite = 1'b1;
		jump = 1'b0;
		
		end else if (instruction == 6'b00_1111) begin     // lui
		ALUOp = 2'b11;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b0;
		Branch = 1'b0;
		ALUSrc = 2'b10;
		MemWrite = 1'b1;
		RegWrite = 1'b1;
		jump = 1'b0;
		
		end else if (instruction == 6'b00_0010) begin // J
		ALUOp = 2'b00;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b0;
		Branch = 1'b0;
		ALUSrc = 2'b00;
		MemWrite = 1'b0;
		RegWrite = 1'b0;
		jump = 1'b1;	
		
		end else if (instruction == 6'b00_0101) begin // BNE
		ALUOp = 2'b01;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b1;
		Branch = 1'b1;
		ALUSrc = 2'b00;
		MemWrite = 1'b0;
		RegWrite = 1'b0;
		jump = 1'b0;	
		
		end else begin
		ALUOp = 2'b00;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		RegDst = 1'b0;
        Branch = 1'b0;		
	    ALUSrc = 2'b00;
		MemWrite = 1'b0;
		RegWrite = 1'b0;
		jump = 1'b0;
		end
	
	
end
endmodule
