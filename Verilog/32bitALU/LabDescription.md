### For Readers

This folder contains my solution for **EC413 Computer Organization - Lab 4: 32-bit ALU Design**. The objective of this lab is to design, implement, and test a 32-bit ALU with an output register while reinforcing hierarchical design, parameterization, and the development of comprehensive testbenches.


### Overview

This lab focuses on implementing an ALU using Structural Verilog and creating robust testbenches with automatic verification. Key learning objectives include:
- Hierarchical design using reusable modules
- Implementation of an ALU with various arithmetic and logical operations
- Creating and verifying sequential components
- Parameterization using `for`, `generate`, and `parameter` constructs


### ALU Functionality

The ALU supports the following operations based on a 3-bit `ALUOp` signal:

| ALUOp | Operation         | Function        |
|-------|------------------|-----------------|
| 000   | `R1 = R2`         | MOV             |
| 001   | `R1 = ~R2`        | NOT             |
| 010   | `R1 = R2 + R3`    | ADD             |
| 011   | `R1 = R2 - R3`    | SUB             |
| 100   | `R1 = R2 | R3`    | OR              |
| 101   | `R1 = R2 & R3`    | AND             |


### Implementation Requirements

1. **Design Structure:**
   - Utilize a "bit-slice" style design with reusable 1-bit modules.
   - The ALU should be parameterizable to support different word sizes.

2. **Components:**
   - Structural Verilog must be used for the ALU (AND, OR, NOT gates).
   - Behavioral Verilog can be used for the register and multiplexer.

3. **Sequential Logic:**
   - Integrate an output register to store results.
   - Create testbenches to handle sequential logic and multiple functions.

4. **Testing:**
   - Ensure all ALU functions are tested with representative and corner cases, such as:
     - MOV, NOT, OR, AND: random values
     - ADD: large values, small values, positive and negative combinations
     - SUB: handling zero, negative/positive differences
     - SLT: various signed comparisons
