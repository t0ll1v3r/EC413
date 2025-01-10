`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 01:43:50 PM
// Design Name: 
// Module Name: pipeline
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline(
    input clk,
    input reset,
    input WriteEnable,
    input [31:0] InstrIn,
    output [31:0] ALUOut
);

// Stage 1 (IF)

// 5 bit registers (ReadSelect1, ReadSelect2, WriteSelect)
wire [4:0] S1_RS1 = InstrIn[25:21];
wire [4:0] S1_RS2 = InstrIn[20:16];
//wire [4:0] S1_WS = InstrIn[25:21]; 

// 1 bit registers (DataSource and WriteEnable)
//wire S1_WE = InstrIn[30];
wire S1_WE = WriteEnable;
wire S1_DS = InstrIn[29];

// 3 bit register (ALUOperation)
wire [2:0] S1_ALUOp = InstrIn[28:26];

// 16 bit register (Immediate)
wire [15:0] S1_IMM = InstrIn[15:0];

// Pass everything from Stage 1 to Stage 2

// Pass ReadSelect1
nbit_reg #(5) S1toS2_RS1 (
    .nD(S1_RS1),   // input
    .nQ(S2_RS1),   // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass ReadSelect2
nbit_reg #(5) S1toS2_RS2 (
    .nD(S1_RS2),   // input
    .nQ(S2_RS2),   // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass WriteSelect
nbit_reg #(5) S1toS2_WS (
    .nD(S1_RS1),   // input
    .nQ(S2_WS),   // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass Immediate
nbit_reg #(16) S1toS2_IMM (
    .nD(S1_IMM),    // input
    .nQ(S2_IMM),    // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass ALU Operation
nbit_reg #(3) S1toS2_ALUOp (
    .nD(S1_ALUOp),  // input
    .nQ(S2_ALUOp),  // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass WriteEnable
nbit_reg #(1) S1toS2_WE (
    .nD(S1_WE),    // input
    .nQ(S2_WE),    // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass DataSource
nbit_reg #(1) S1toS2_DS (
    .nD(S1_DS),    // input
    .nQ(S2_DS),    // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Stage 2 (ID)

// ReadData1 & ReadData2
wire [31:0] S2_RD1, S2_RD2;

// register file
nbit_register_file reg_file (
    .WriteData(S4_WD),  // input data
    .ReadData1(S2_RD1), // output RD1
    .ReadData2(S2_RD2), // output RD2
    .ReadSelect1(S2_RS1),   // select for RD1
    .ReadSelect2(S2_RS2),   // select for RD2
    .WriteSelect(S2_WS),
    .WriteEnable(S2_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass everything to Stage 3

// Pass ReadData1
nbit_reg #(32) S2toS3_RD1 (
    .nD(S2_RD1),
    .nQ(S3_RD1),
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass ReadData2
nbit_reg #(32) S2toS3_RD2 (
    .nD(S2_RD2),
    .nQ(S3_RD2),
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);


// Pass Immediate
nbit_reg #(16) S2toS3_IMM (
    .nD(S2_IMM),
    .nQ(S3_IMM),
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass ALU Operation
nbit_reg #(3) S2toS3_ALUOp (
    .nD(S2_ALUOp),
    .nQ(S3_ALUOp),
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass DataSource
nbit_reg #(1) S2toS3_DS (
    .nD(S2_DS),
    .nQ(S3_DS),
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass WriteEnable
nbit_reg #(1) S2toS3_WE (
    .nD(S2_WE),    // input
    .nQ(S3_WE),    // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);


// Stage 3 (EX)

wire [31:0] IMM_32 = { 16'b0, S3_IMM}; // Set IMM to 32 bits

// Mux to decide I-type or R-type
nbit_mux #(32) IorR (
    .MuxIn({IM_32, S3_RD2}),
    .MuxOut(S3_R3),
    .MuxSel(S3_DS)
);

// ALU to compute output
ALU_behavioral #(32) ALUoutput (
    .R2(S3_RD2),
    .R3(S3_R3),
    .ALUOp(S3_ALUOp),
    .R1(ALUOut)
);


// pass everything to stage 4 & out

// Pass WriteData
nbit_reg #(32) S3toS4_WD (
    .nD(ALUOut),    //input
    .nQ(S4_WD),     //output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass WriteSelect
nbit_reg #(5) S3toS4_WS (
    .nD(S3_WS), // input
    .nQ(S4_WS), // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Pass WriteEnable
nbit_reg #(1) S3toS4_WE (
    .nD(S3_WE),    // input
    .nQ(S4_WE),    // output
    .Write(S1_WE),
    .Reset(reset),
    .Clk(clk)
);

// Stage 4 (WR)


endmodule
