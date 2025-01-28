### For Readers

This repository contains my solution for **EC413 Computer Organization - Lab 3: Verilog Adders Design and Analysis**. The objective of this lab is to gain experience with Structural Verilog, hierarchical design, and performance evaluation of different types of adders.

### Overview

This lab focuses on the design, simulation, and analysis of 64-bit adders using Structural Verilog. The primary goals include:
- Understanding Structural Verilog and hierarchical design
- Creating and using testbenches for automatic verification
- Performing algorithmic performance evaluation through gate-count timing
- Implementing and analyzing Ripple Carry and Carry Select Adders

### Tasks

#### Design Requirements
1. **Adder Implementation**
   - Design and implement the following 64-bit adders:
     - **Ripple Carry Adder (RCA)**
     - **2-stage Carry Select Adder**

2. **Structural Verilog Implementation**
   - Use gate-level Structural Verilog for the RCA.
   - Behavioral Verilog can be used for MUXes in Carry Select Adders.
   - Base the 64-bit adders on 1-bit full adders made up of AND, OR, and NOT gates.

3. **Hierarchical Design**
   - Ensure modularity and reusability by designing reusable blocks.
   - Use `define` directives to simplify timing parameter modifications.

4. **Timing Analysis**
   - Set specific gate delays for analysis:
     - AND, OR gates: 1 gate delay
     - NOT gates: 0 gate delay
     - MUXes used in Carry Select Adders: 0 gate delay

5. **Testbench Development**
   - Implement behavioral verification logic to compare outputs.
   - Include tests for various scenarios:
     - Overall carry-out generation
     - Large and small input values with/without carry
     - Randomized combinations

### Questions to Answer
- What are the gate delay times of the adders? 
- Are they as expected? Explain why or why not.

### Extra Credit (up to 10 points)
- Implement an optimized Carry Select Adder with an optimal number of stages.

### Instructions to Run
1. Save all Verilog files in a project directory.
2. Use Xilinx or ModelSim to simulate the design.
3. Analyze waveform outputs and verify correctness.
