`timescale 1ns / 1ns


module tb_cpu;

	// Inputs
	reg rst;
	reg clk;
	reg initialize;
	reg [31:0] instruction_initialize_data;
	reg [31:0] instruction_initialize_address;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.rst(rst), 
		.clk(clk), 
		.initialize(initialize), 
		.instruction_initialize_data(instruction_initialize_data), 
		.instruction_initialize_address(instruction_initialize_address)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		initialize = 1;
		instruction_initialize_data = 0;
		instruction_initialize_address = 0;

		#100;
      
		instruction_initialize_address = 0;
		instruction_initialize_data = 32'b000000_00000_00010_00001_00000_10_0000;      // ADD R1, R0, R2
		#20;
		
		instruction_initialize_address = 4;
		instruction_initialize_data = 32'b000000_00100_00100_01000_00000_10_0010;      // SUB R8, R4, $4
		#20;

		instruction_initialize_address = 8;
		instruction_initialize_data = 32'b000000_00101_00110_00111_00000_10_0101;      // OR R5, R6, 7
		#20;
		
		instruction_initialize_address = 12;
		instruction_initialize_data = 32'b101011_00000_01001_00000_00000_00_1100;      // SW R9, 12(R0)
		#20;
		
		instruction_initialize_address = 16;
		instruction_initialize_data = 32'b100011_00000_01100_00000_00000_00_1100;      // LW R12, 12(R0)
		#20
		
		instruction_initialize_address = 20;
		instruction_initialize_data = 32'b001000_00010_00101_0000000000001101;        // ADDi R5, R2, 13
		#20;
		
		instruction_initialize_address = 24;
		instruction_initialize_data = 32'b001111_00110_00110_0000000000000101;      // LUI R6, 5 
		#20;
		
//		instruction_initialize_address = 28;
//		instruction_initialize_data = 32'b000100_00000_00000_11111_11111_11_1111;      // BEQ R0, R0, -1
//		#20;

//        instruction_initialize_address = 28;
//		instruction_initialize_data = 32'b000101_00000_00100_11111_11111_11_1111;      // BNE R0, R4, -1
//		#20;
		
		instruction_initialize_address = 28;
		instruction_initialize_data = 32'b000000_00101_00100_00001_11111_10_1010;      // SLT R1, R5, R4,
		#20;
		
		instruction_initialize_address = 32;
		instruction_initialize_data = 32'b000000_00100_00101_00001_11111_10_1010;      // SLT R1, R4, R5
		#20;


		instruction_initialize_address = 36;
		instruction_initialize_data = 32'b000010_0000000000_0000_0000_0000_0100;      // J -4 (use absolute address 16/4)
		#20;
		
//        instruction_initialize_address = 36;
//		instruction_initialize_data = 32'b000010_000000_111100_001000_111111_01;      // J  to huge address
//		#20;	
		
		initialize = 0;
		rst = 0;
		
	end
      
always
#5 clk = ~clk;
endmodule

