`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 08:14:25 AM
// Design Name: 
// Module Name: ALU_1bit
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


module xor_gate (
    input x,
    input y,
    output reg z
);
    always @ (x or y) begin
        if (x == 1'b0 & y == 1'b0) begin
            z = 1'b0;
        end else if (x == 1'b1 & y == 1'b1) begin
            z = 1'b0;
        end else begin
            z = 1'b1;
        end
    end
endmodule


module and_gate (
    input x,
    input y,
    output reg z
);
    always @ (x or y) begin
        if (x == 1'b1 & y == 1'b1) begin
            z = 1'b1;
        end
        else
            z = 1'b0;
    end
endmodule


module or_gate (
    input x,
    input y,
    output reg z
);
    always @ (x or y) begin
        if (x == 1'b0 & y == 1'b0) begin
            z = 1'b0;
        end
        else
            z = 1'b1;
    end
endmodule


module not_gate (
    input x,
    output reg z
);
    always @ (x) begin
        #0;
        if (x == 1'b0 ) begin
            z = 1'b1;
        end
        else
            z = 1'b0;
        end
endmodule


module ALU_1bit(
    input a,
    input b,
    input c_in,
    input [2:0] ALUOp,
    output reg r,
    output c_out
    );
    
    wire temp1, temp2, temp3;
    wire sum, and_out, or_out, sub_out, not_out, mov_out;
    wire bXORc_in;
    
    
//basic operations

// and_out = a & b (AND)
and_gate AND1 (
    .x(a),
    .y(b),
    .z(and_out)
);

// or_out = a | b (OR)
or_gate OR1 (
    .x(a),
    .y(b),
    .z(or_out)
);

// mov_out = a (MOV)
assign mov_out = a;    

// not_out = ~a (NOT)
not_gate NOT1 (
    .x(a),
    .z(not_out)
);


        // addition and subtractoin
    // sum = a ^ b ^ c_in
// bXORc_in = b ^ ALUOp[2] (XOR)
xor_gate XOR1 (
    .x(b),
    .y(ALUOp[0]),
    .z(bXORc_in)
);

// temp1 = a ^ bXORc_in
xor_gate XOR2 (
    .x(a),
    .y(bXORc_in),
    .z(temp1)
);

// sum = temp1 ^ c_in = a ^ bXORc_in ^ c_in
xor_gate XOR3 (
    .x(temp1),
    .y(c_in),
    .z(sum)
);

    // c_out = (a & bXORc_in) | ((a ^ bXORc_in) & c_in) = (a & bXORc_in) | (temp1 & c_in)
// temp2 = a & bXORc_in
and_gate AND2 (
    .x(a),
    .y(bXORc_in),
    .z(temp2)
);

// temp3 = temp1 & c_in
and_gate AND3 (
    .x(temp1),
    .y(c_in),
    .z(temp3)
);

// c_out = temp1 | temp3 = (a & bXORc_in) | (temp1 & c_in) = (a & bXORc_in) | ((a ^ bXOR_cin) & c_in)
or_gate OR2 (
    .x(temp2),
    .y(temp3),
    .z(c_out)
);


    // MUX to select result
    always @(*) begin
        case (ALUOp)
            3'b000: r = mov_out;    // r = a
            3'b001: r = not_out;    // r = ~a
            3'b010: r = sum;        // r = a + b (ADD)
            3'b011: r = sum;        // r = a - b (SUB)
            3'b100: r = or_out;     // r = a | b
            3'b101: r = and_out;    // r = a & b
            default: r = 0;         // r = 0 (default)
        endcase
    end

endmodule
