### For Readers

This folder contains my solution for **EC413 Computer Organization - Lab 6: Single-Cycle Processor Design**. The objective of this lab is to design, implement, and test a single-cycle 32-bit processor capable of executing basic arithmetic, logical, memory, and branch instructions.


### Overview

In this lab, students will construct a single-cycle processor that fetches, decodes, executes, and writes back instructions in one clock cycle. Key learning objectives include:
- Understanding processor components such as ALU, registers, memory, and control logic.
- Implementing instruction execution flow within a single cycle.
- Designing a hierarchical Verilog implementation.
- Developing and verifying testbenches with representative instruction sequences.


### Processor Components

The processor includes the following major components:

1. **Program Counter (PC):** Holds the address of the current instruction.
2. **Instruction Memory:** Stores the instruction set to be executed.
3. **Register File:** Stores values of registers used during execution.
4. **ALU (Arithmetic Logic Unit):** Performs operations such as addition, subtraction, and bitwise logic.
5. **Data Memory:** Used to read and write data during memory operations.
6. **Control Unit:** Generates control signals to coordinate data flow across the processor.
7. **Branch Logic:** Handles conditional and unconditional jumps.


### Instruction Set

The processor supports a subset of RISC-like instructions with the following format:

| Type | Format                 |
|------|------------------------|
| R    | `opcode(6) r1(5) r2(5) r3(5) funct(11)` |
| I    | `opcode(6) r1(5) r2(5) imm(16)` |
| J    | `opcode(6) address(26)` |


### Control Signals

The control unit generates the following control signals to direct the data path:

- **RegDst:** Determines the destination register.
- **ALUSrc:** Chooses between register or immediate value for ALU operations.
- **MemToReg:** Chooses between ALU result or memory value for register write-back.
- **RegWrite:** Enables writing to registers.
- **MemRead:** Enables reading from memory.
- **MemWrite:** Enables writing to memory.
- **Branch:** Determines if a branch instruction is being executed.
- **Jump:** Controls unconditional jumps.


### Implementation Requirements

1. **Hierarchical Design:** 
   - Implement the processor using modular Verilog with clear submodules.
   - Design reusable components such as ALU, multiplexer, and registers.

2. **Functional Units:**
   - ALU should support basic arithmetic and logical operations.
   - Register file should support simultaneous read/write operations.
   - Memory should be implemented with simple load/store operations.

3. **Testbenches:**
   - Create comprehensive testbenches to verify correct instruction execution.
   - Include test cases covering arithmetic, logic, memory, and branch operations.
