### For Readers

This repository contain my solution for **EC413 Computer Organization - Lab 5: 4-Stage 32-bit Pipelined Datapath Design**. The objective of this lab is to design, implement, and test a 4-stage 32-bit pipelined datapath to gain a deeper understanding of pipelining concepts and digital design.


### Overview

In this lab, students will construct a 4-stage pipelined datapath that supports R-Type and I-Type instructions. The key learning objectives include:
- Understanding pipeline stages and how data flows through them.
- Implementing a hierarchical design using modular Verilog.
- Developing testbenches to verify functionality and debug potential hazards.
- Working with key components such as registers, multiplexers, and ALUs.


### Pipelined Datapath Structure

The pipeline consists of the following stages:

1. **Instruction Fetch (Stage 1):** Loads instructions into pipeline registers.
2. **Instruction Decode/Register Read (Stage 2):** Decodes instructions and reads register values.
3. **Execution (Stage 3):** Performs arithmetic or logical operations using the ALU.
4. **Write Back (Stage 4):** Writes computed values back to the register file.


### Instruction Format

The pipelined datapath supports two instruction types:

| Type | Format                 |
|------|------------------------|
| R    | `opcode(6) r1(5) r2(5) r3(5)` |
| I    | `opcode(6) r1(5) r2(5) imm(16)` |

The opcode field interpretation:
- Bit 30: Logical/Arithmetic (1 for operations used in lab).
- Bit 29: Immediate operand usage (1 for I-Type, 0 for R-Type).
- Bits 28-26: ALU operation code.


### ALU Operations

The ALU performs the following functions:

| ALUOp | Operation         | Function  |
|-------|------------------|-----------|
| 000   | `R1 = R2`         | MOV       |
| 001   | `R1 = ~R2`        | NOT       |
| 010   | `R1 = R2 + R3`    | ADD       |
| 011   | `R1 = R2 - R3`    | SUB       |
| 100   | `R1 = R2 | R3`    | OR        |
| 101   | `R1 = R2 & R3`    | AND       |
| 110   | `R1 = (R2 < R3)`  | SLT (signed) |


### Data Hazards and Forwarding

Pipelining can introduce data hazards where an instruction depends on a previous instruction's result. For now, we're ignore these cases.


### Sample Instruction Sequence

// ADD r1 with 0x000A => r1 = 0x000A
InstrIn = 32'b011010_00001_00001_0000000000001010;

// OR r2 with 0x0002 => r2 = 0x0002
InstrIn = 32'b011100_00010_00010_0000000000000010;

// ADD r1 + r2 => r3 = 0x000C
InstrIn = 32'b010010_00011_00001_00010_00000000000;

// SUB r1 - r2 => r4 = 0x0008
InstrIn = 32'b010011_00100_00001_00010_00000000000;
