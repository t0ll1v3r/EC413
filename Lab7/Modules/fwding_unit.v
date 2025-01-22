`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2024 01:43:03 PM
// Design Name: 
// Module Name: fwding_unit
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


module fwding_unit(

ForwardA,
ForwardB,


IDEX_RsReg,
IDEX_RtReg,
EXMEM_RegDest,
MEMWB_WriteBackDest,
EXMEM_RegWrite,
MEMWB_RegWrite

    );
    
output reg [1:0] ForwardA;
output reg [1:0] ForwardB;

input [4:0] IDEX_RsReg;
input [4:0] IDEX_RtReg;
input [4:0] EXMEM_RegDest;
input [4:0] MEMWB_WriteBackDest;
input EXMEM_RegWrite; //WB ctrl 0
input MEMWB_RegWrite;

always @ (*) begin// from lecture
    if (EXMEM_RegWrite && (EXMEM_RegDest != 0) && (EXMEM_RegDest == IDEX_RsReg))
        ForwardA = 2'b10;
    else if (MEMWB_RegWrite && (MEMWB_WriteBackDest != 0) && (MEMWB_WriteBackDest == IDEX_RsReg))
        ForwardA = 2'b01;
    else
        ForwardA = 0;
    
    if (EXMEM_RegWrite && (EXMEM_RegDest != 0) && (EXMEM_RegDest == IDEX_RtReg))
        ForwardB = 2'b10;
    else if (MEMWB_RegWrite && (MEMWB_WriteBackDest != 0) && (MEMWB_WriteBackDest == IDEX_RtReg))
        ForwardB = 2'b01;    
    else
        ForwardB = 0;
end
    
endmodule
