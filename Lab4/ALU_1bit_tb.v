`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 08:42:27 AM
// Design Name: 
// Module Name: ALU_1bit_tb
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


module ALU_1bit_tb;

reg a, b, c_in;
reg [2:0] ALUOp;
wire r, c_out;

ALU_1bit uut (
    .a(a),
    .b(b),
    .c_in(c_in),
    .ALUOp(ALUOp),
    .r(r),
    .c_out(c_out)
);

initial begin
    a = 0; // MOV test 1
    b = 0;
    c_in = 0;
    ALUOp = 3'b000; // r = a = 0
    
    #10; // MOV test 2
    a = 1;
    b = 0;
    c_in = 0;
    ALUOp = 3'b000; // r = a = 1
    
    #10; // MOV test 3
    a = 0;
    b = 1;
    c_in = 0;
    ALUOp = 3'b000; // r = a = 0
    
    #10; // MOV test 4
    a = 1;
    b = 0;
    c_in = 1;
    ALUOp = 3'b000; // r = a = 1
    
    #10; //NOT test 1
    a = 1;
    b = 0;
    c_in = 0;
    ALUOp = 3'b001; // r = ~a = 0
    
    #10; // NOT test 2
    a = 0;
    b = 1;
    c_in = 0;
    ALUOp = 3'b001; // r = ~a = 1
    
    #10; // NOT test 3
    a = 0;
    b = 0;
    c_in = 0;
    ALUOp = 3'b001; // r = ~a = 1
    
    #10; // ADD test 1
    a = 1;
    b = 1;
    c_in = 0;
    ALUOp = 3'b010; // r = a + b = 0, c_out = 1 
    
    #10; // ADD test 2
    a = 1;
    b = 1;
    c_in = 1;
    ALUOp = 3'b010; // r = a + b = 1, c_out = 1
    
    #10; // ADD test 3
    a = 0;
    b = 0;
    c_in = 0;
    ALUOp = 3'b010; // r = a + b = 0, c_out = 0
    
    #10; // SUB test 1
    a = 1;
    b = 0;
    c_in = 0;
    ALUOp = 3'b011; // r = a - b = 1, c_out = 0
    
    #10; // SUB test 2
    a = 0;
    b = 1;
    c_in = 1;
    ALUOp = 3'b011; // r = a - b = 0, c_out = 1
    
    #10; // OR test 1
    a = 1;
    b = 0;
    c_in = 0;
    ALUOp = 3'b100; // r = a | b = 1
    
    #10; // OR test2
    a = 1;
    b = 1;
    c_in = 0;
    ALUOp = 3'b100; // r = a | b = 1
    
    #10;
    a = 0;
    b = 0;
    c_in = 0;
    ALUOp = 3'b100; // r = a | b = 0
    
    #10; // AND test 1
    a = 1;
    b = 1;
    c_in = 0;
    ALUOp = 3'b101; // r = a & b = 1
    
    #10; // AND test 2
    a = 0;
    b = 1;
    c_in = 0;
    ALUOp = 3'b101; // r = a & b = 0
    
    #10; // AND test 3
    a = 1;
    b = 0;
    c_in = 0;
    ALUOp = 3'b101; // r = a & b = 0

    #10;
    $finish;
end


endmodule
