`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 09:19:12 AM
// Design Name: 
// Module Name: ALU_Nbit
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


module ALU_Nbit #(parameter WIDTH = 32) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [2:0] ALUOp,
    input c_in,
    output [WIDTH-1:0] r,
    output c_out
);
    
    wire [WIDTH:0] carry;
    
    assign carry[0] = c_in; //initial carry in
    
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : ALU_BITS
            ALU_1bit ALU_slices (
                .a(a[i]),
                .b(b[i]),
                .c_in(carry[i]),
                .ALUOp(ALUOp),
                .r(r[i]),
                .c_out(carry[i+1])
            );
        end
    endgenerate
    
    assign c_out = carry[WIDTH]; //final carry out
    
endmodule
