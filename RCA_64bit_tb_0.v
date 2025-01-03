`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 07:52:52 AM
// Design Name: 
// Module Name: RCA_64bit_tb
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


module RCA_64bit_0_tb;

    reg [63:0] a, b;
    reg c_in;
    
    wire [63:0] sum;
    wire c_out;
    
    RCA_64bit_0 uut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
    );
    
    integer i;
    initial begin
        
        a = 64'h0000000000000003;
        b = 64'h0000000000000005;
        c_in = 0;
        #10;
        
        a = 64'h0000000000000003;
        b = 64'h0000000000000005;
        c_in = 1;
        #10;
        
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000001;
        c_in = 1;
        #10;
        
        a = 64'h000000000000000A;
        b = 64'hFFFFFFFFFFFFFFF6;
        c_in = 0;
        #10;
        
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'hFFFFFFFFFFFFFFFF;
        c_in = 1;
        #10;
        
        a = 64'b0;
        b = 64'b0;
        c_in = 1'b0;
        

        for (i = 0; i < 10; i = i +1) begin
            a = $random;
            b = $random;
            c_in = $random % 2;
            #10;
        end
        $finish;
    end
endmodule
