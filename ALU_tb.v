`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 12:23:55 PM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;
    parameter WIDTH = 32;

//inputs
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
reg [2:0] ALUOp;
reg c_in;
reg clk;
reg rst;
reg enbl;

//outputs
wire [WIDTH-1:0] top_result;
wire [WIDTH-1:0] behav_result;
wire top_c_out;

//instantiate ALU_top
ALU_top #(.WIDTH(WIDTH)) uut_top (
    .a(a),
    .b(b),
    .ALUOp(ALUOp),
    .c_in(c_in),
    .clk(clk),
    .rst(rst),
    .enbl(enbl),
    .result(top_result),
    .c_out(top_c_out)
);

//instantiate ALU_behavorial
ALU_behavioral #(.WIDTH(WIDTH)) uut_behav (
    .R2(a),
    .R3(b),
    .ALUOp(ALUOp),
    .R1(behav_result)
);

always #5 clk = ~clk;

initial begin
    // initialize inputs
    clk = 0;
    rst = 1;
    enbl = 1;
    c_in = 0;
    ALUOp = 3'b000;
    
    a = 32'h00000000;
    b = 32'h00000000;
    
    // release reset after a bit
    #5 rst = 0;
    
    //begin actual tests
    #5;
    a = 32'hA5A5A5A5;
    b = 32'h12345678;
    ALUOp = 3'b000;     // test MOV
    #30;
    
    #10;
    a = 32'hAAAAAAAA;
    b = 32'h12345678;
    ALUOp = 3'b001;     // test NOT
    #40;
    
    #10;
    a = 32'hFFFF0000;
    b = 32'h0000FFFF;
    ALUOp = 3'b100;     // test OR
    #40;
    
    #10;
    a = 32'hFFFF0000;
    b = 32'h0000FFFF;
    ALUOp = 3'b101;     // test AND
    #40;
    
    // Addition tests
    #10;
    a = 32'h00004578;
    b = 32'h00003416;
    ALUOp = 3'b010;     // test ADD, big values w/o overflow
    #40;
    
    #10;
    a = 32'h7FFFFFFF;
    b = 32'h00000001;
    ALUOp = 3'b010;     // test ADD, big values w/ overflow 
    #40;
    
    #10;
    a = 32'h00000004;
    b = 32'h00000003;
    ALUOp = 3'b010;     // test ADD, small values
    #40;
    
    #10;
    a = 32'hfffffff4;
    b = 32'h00000008;   // test ADD, negative + positive
    ALUOp = 3'b010;
    #40;

    // subtraction tests    
    #10;
    c_in = 1;
    a = 32'h00004578;
    b = 32'h00003416;
    ALUOp = 3'b011;     // test SUB, same inputs as first ADD test
    #40;
    
    #10;
    c_in = 1;
    a = 32'h00000050;
    b = 32'h00000040;
    ALUOp = 3'b011;     // test SUB w/ positive result
    #40;
    
    #10;
    c_in = 1;
    a = 32'h00000010;
    b = 32'h00000020;
    ALUOp = 3'b011;     // test SUB w/ negative result
    #40;
    
    #10;
    c_in = 1;
    a = 32'h00000008;
    b = 32'h00000000;
    ALUOp = 3'b011;     // test SUB, subtracting 0
    #40;
    
    #10;
    $finish;
end


endmodule
