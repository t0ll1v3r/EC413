`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 09:28:51 AM
// Design Name: 
// Module Name: ALU_top
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


module ALU_top #(parameter WIDTH = 32) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [2:0] ALUOp,
    input c_in,
    input clk,
    input rst,
    input enbl,
    
    output [WIDTH-1:0] result,
    output c_out
    );
    
    wire [WIDTH-1:0] ALU_result;
    
    ALU_Nbit #(.WIDTH(WIDTH)) alu (
        .a(a),
        .b(b),
        .ALUOp(ALUOp),
        .c_in(c_in),
        .r(ALU_result),
        .c_out(c_out)
    );
    
    reg_Nbit #(.WIDTH(WIDTH)) out_reg (
        .clk(clk),
        .rst(rst),
        .enbl(enbl),
        .d(ALU_result),
        .q(result)
    );
    
endmodule
