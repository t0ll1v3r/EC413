`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 09:25:36 AM
// Design Name: 
// Module Name: reg_Nbit
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


module reg_Nbit#(parameter WIDTH = 32) (
    input clk,                  // clock
    input rst,                  // reset
    input enbl,                 // enable/disable
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 0; //reset the register to 0
        else if (enbl)
            q <= d; //sotre the value of d when enabled
    end
    
endmodule
