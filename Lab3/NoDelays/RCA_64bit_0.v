`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Jackson Clary
// 
// Create Date: 10/01/2024 02:20:25 PM
// Design Name: Carry-Select-Adder
// Module Name: RCA_64bit_0
// Project Name: EC413 Lab 3
//////////////////////////////////////////////////////////////////////////////////


module RCA_64bit_0(
    input [63:0] a,
    input [63:0] b,
    input c_in,
    output [63:0] sum,
    output c_out
);
    
wire [15:0] carry;

RCA_4bit_0 rca0 (
    .a(a[3:0]),
    .b(b[3:0]),
    .c_in(c_in),
    .sum(sum[3:0]),
    .c_out(carry[0])
);

genvar i;
generate
    for (i = 1; i < 16; i = i + 1) begin : rca_blocks
        RCA_4bit_0 rca (
            .a(a[4*i+3:4*i]),
            .b(b[4*i+3:4*i]),
            .c_in(carry[i-1]),
            .sum(sum[4*i+3:4*i]),
            .c_out(carry[i])
        );
    end
endgenerate

assign c_out = carry[15];

endmodule
