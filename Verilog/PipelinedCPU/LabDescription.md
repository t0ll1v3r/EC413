### For Readers

This repository contains my solution for **EC413 Computer Organization - Lab 7: Pipelined CPUs**. The objective of this lab is to gain a deeper understanding of pipelined CPU architecture by adding and testing new features to a standard five-stage MIPS CPU.


### Overview

In this lab, students will work with a standard five-stage MIPS CPU without forwarding support and incrementally enhance it by introducing forwarding mechanisms, arbitration logic, and additional control features. Key learning objectives include:
- Understanding data hazards and forwarding techniques.
- Implementing arbitration logic to handle multiple forwarding paths.
- Debugging and testing a pipelined CPU.
- Ensuring correct handling of special register operations.


### Tasks

1. **Prelab: Synthesizing the Project**
   - Synthesize the given CPU design and generate outputs for the provided instruction sequence.

2. **Add “1 Ahead” Forwarding**
   - Implement forwarding logic to resolve data hazards when the next instruction immediately depends on the previous one.

3. **Add “2 Ahead” Forwarding**
   - Extend forwarding logic to resolve hazards that occur two instructions ahead.

4. **Add Arbitration Logic**
   - Implement logic to decide between “1 ahead” and “2 ahead” forwarding based on instruction dependencies.

5. **Add Logic for $0 Write Prevention**
   - Ensure that attempts to write to register `$0` are ignored.

6. **Add No Write Logic**
   - Implement logic to prevent unintended register writes in specific conditions.

7. **Verify Register Bypass**
   - Test and confirm that the bypassing mechanism correctly handles register dependencies.
