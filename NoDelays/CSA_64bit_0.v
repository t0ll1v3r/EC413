`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Jackson Clary
// 
// Create Date: 10/01/2024 02:20:25 PM
// Design Name: Carry-Select-Adder
// Module Name: CSA2_64bit
// Project Name: EC413 Lab 3
//////////////////////////////////////////////////////////////////////////////////


module CSA_64bit_0(
    input [63:0] a,
    input [63:0] b,
    input c_in,
    output [63:0] sum,
    output c_out
);

wire [31:0] sum0, sum1;
wire carry0, carry1;
//wire [7:0] carry0; 
//wire [7:0] carry1;
wire c_out1;
wire [7:0] carry;

// lower 32 bits (right half of sum)

RCA_4bit_0 rca0 (
    .a(a[3:0]),
    .b(b[3:0]),
    .c_in(c_in),
    .sum(sum[3:0]),
    .c_out(carry)
);

genvar i;
generate
    for (i = 1; i < 8; i = i + 1) begin : lower_rca
        RCA_4bit_0 rca (
            .a(a[4*i+3:4*i]),
            .b(b[4*i+3:4*i]),
            .c_in(carry[i-1]),
            .sum(sum[4*i+3:4*i]),
            .c_out(carry[i])
    );
    end
endgenerate

assign c_out1 = carry[7];

// upper 32 bits (left half)
// 2 sets (1 for carry in of 0 and 1 for carry in of 1)

// rca for carry in of 0
RCA_4bit_0 rca1_0 (
    .a(a[35:32]),
    .b(b[35:32]),
    .c_in(1'b0),
    .sum(sum0[3:0]),
    .c_out(carry0)
);

generate
    for (i = 1; i < 8; i = i + 1) begin : upper_rca_0
        wire temp_carry0;
        RCA_4bit_0 rca (
            .a(a[4*i+35:4*i+32]),
            .b(b[4*i+35:4*i+32]),
            .c_in(carry0),
            .sum(sum0[4*i+3:4*i]),
            .c_out(temp_carry0)
        );
        assign carry0 = temp_carry0;
    end
endgenerate
    
// rca for carry in of 1
RCA_4bit_0 rca1_1 (
    .a(a[35:32]),
    .b(b[35:32]),
    .c_in(1'b1),
    .sum(sum1[3:0]),
    .c_out(carry1)
);

generate
    for (i = 1; i < 8; i = i + 1) begin : upper_rca_1
        wire temp_carry1;
        RCA_4bit_0 rca (
            .a(a[4*i+35:4*i+32]),
            .b(b[4*i+35:4*i+32]),
            .c_in(carry1),
            .sum(sum1[4*i+3:4*i]),
            .c_out(temp_carry1)
        );
        assign carry1 = temp_carry1;
    end
endgenerate

// mux to select the correct sum and carry out
assign sum[63:32] = (c_out1) ? sum1 : sum0;
assign c_out = (c_out1) ? carry1 : carry0;

endmodule
