`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:33 10/25/2016 
// Design Name: 
// Module Name:    cpu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// 8 bit data
// 4 bit wide address for memories and reg file
// 32 bit wide instruction
// 4 bit immediate

module cpu(
    rst,
    clk,
    initialize,
    instruction_initialize_data,
    instruction_initialize_address
);

input rst;
input clk;
input initialize;
input [31:0] instruction_initialize_data;
input [31:0] instruction_initialize_address;

wire [31:0] PC_out;
wire [31:0] instruction;
wire [31:0] instruction_mem_out;

assign instruction = (initialize) ? 32'hFFFF_FFFF : instruction_mem_out;

InstrMem InstructionMemory (instruction_mem_out , instruction_initialize_data  , (initialize) ? instruction_initialize_address : PC_out , initialize , clk);
	
wire [1:0] ALUOp;
wire MemRead;
wire MemtoReg;
wire RegDst;
wire Branch; 
wire [1:0] ALUSrc;
wire MemWrite;
wire RegWrite;
wire jump;

control Control(
    instruction [31:26],
    ALUOp,
    MemRead,
    MemtoReg,
    RegDst,
    Branch,
    ALUSrc [1:0],
    MemWrite,
    RegWrite,
    jump
);

wire [31:0] write_data;
wire [4:0] write_register;
wire [31:0] read_data_1, read_data_2;
wire [31:0] ALUOut, MemOut;

mux #(5) Write_Reg_MUX (
    RegDst,
    instruction[20:16],
    instruction[15:11],
    write_register
);

// Registers block
nbit_register_file Register_File(
    write_data,
    read_data_1,
    read_data_2,
    instruction[25:21],
    instruction[20:16],
    write_register,
    RegWrite,
    clk
);
    
wire [31:0] immediate;
sign_extend Sign_Extend(
    instruction[15:0],
    immediate
);

wire [31:0] immediate_x_16;
shift_left_16 Shift_Left_Sixteen (
    instruction[15:0],
    immediate_x_16
);

wire [31:0] ALU_input_2;
wire zero_flag;
wire [2:0] ALU_function;

triMux #(32) ALU_Input_2_Mux (
    ALUSrc[1:0],
    read_data_2,
    immediate,
    immediate_x_16,
    ALU_input_2
);

ALU_control ALU_Control(
    instruction[5:0],
    ALUOp,
    ALU_function
);

ALU ALU(
    read_data_1,
    ALU_input_2,
    ALU_function,
    ALUOut,
    zero_flag
);
	 
	 
Memory Data_Memory(
    ALUOut,
    read_data_2,
    MemOut,
    MemRead,
    MemWrite,
    clk
);


mux #(32) ALU_Mem_Select_MUX (
    MemtoReg,
    ALUOut,
    MemOut,
    write_data
);	 
	 
	 
wire [31:0] PC_in;
PC Program_Counter(
    PC_out,
    PC_in,
    clk,
    rst
);

// BEQ Operation (given)
wire [31:0] PC_plus_4;
Adder #(32) PC_Increment_Adder (
    PC_out,
    32'd4,
    PC_plus_4
);


wire [31:0] Branch_target_address;
wire [31:0] immediate_x_4;

shift_left_2 #(32) Shift_Left_Two (
    immediate,
    immediate_x_4
);

Adder #(32) Branch_Target_Adder (
    PC_plus_4,
    immediate_x_4,
    Branch_target_address
);

wire [31:0] PC_preJ;
wire PCSrc;
wire beq;// new wire
wire bne;

and Branch_And (    //added regdst input
    beq,
    Branch,
    zero_flag,
    ~RegDst
);

mux #(32) PC_Input_MUX (    //changed PC_in to PC_preJ
    PCSrc,
    PC_plus_4,
    Branch_target_address,
    PC_preJ
);
	 
	 
//	 /* BNE LOGIC */
or branchor(
    PCSrc,
    beq,
    bne
);

and BNE(    //regdst set to 1 during BNE
    bne,
    Branch,
    ~zero_flag,
    RegDst
);

/*** JUMP LOGIC **/
wire [27:0] jumpamt_x_4;
wire [31:0] Jump_target_address;
	
shift_left_2 #(32) Shiftleftwo(instruction[25:0],jumpamt_x_4);
	
assign Jump_target_address[27:0] = jumpamt_x_4;
assign Jump_target_address[31:28] = PC_plus_4[31:28];
	
mux #(32) PC_Inputjump (    //changed PC_in to PC_preJ
    jump,
    PC_preJ,
    Jump_target_address,
    PC_in
);
				 
endmodule
