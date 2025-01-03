`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Jackson Clary
// 
// Create Date: 10/01/2024 02:20:25 PM
// Design Name: Carry-Select-Adder
// Module Name: FullAdder_0
// Project Name: EC413 Lab 3
//////////////////////////////////////////////////////////////////////////////////


//module xor_gate (
//    input x,
//    input y,
//    output reg z
//);
//    always @ (x or y) begin
//        if (x == 1'b0 & y == 1'b0) begin
//            z = 1'b0;
//        end
//        if (x == 1'b1 & y == 1'b1) begin
//            z = 1'b0;
//        end
//        else
//            z = 1'b1;
//    end
//endmodule


module and_gate (
    input x,
    input y,
    output reg z
);
    always @ (x or y) begin
        #0;
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
        #0;
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


module FullAdder_0(
    input c_in,
    input a,
    input b,
    output sum,
    output c_out
);
  
wire temp_sum1, temp_sum2, temp_sum3, temp_sum4, q;
wire temp_not1, temp_not2, temp_not3, temp_not4;
wire c1, c2, c3;


// q = (a && !b) || (!a && b)
not_gate NOT1 (
    .x(a),
    .z(temp_not1)
);

not_gate NOT2 (
    .x(b),
    .z(temp_not2)
);

and_gate AND4 (
    .x(a),
    .y(temp_not2),
    .z(temp_sum1)
);

and_gate AND5 (
    .x(temp_not1),
    .y(b),
    .z(temp_sum2)
);

or_gate OR3 (
    .x(temp_sum1),
    .y(temp_sum2),
    .z(q)
);


// sum = (q && !c_in) || (!q && c_in)
not_gate NOT3 (
    .x(q),
    .z(temp_not3)
);

not_gate NOT4 (
    .x(c_in),
    .z(temp_not4)
);

and_gate AND6 (
    .x(q),
    .y(temp_not4),
    .z(temp_sum3)
);

and_gate AND7 (
    .x(temp_not3),
    .y(c_in),
    .z(temp_sum4)
);

or_gate OR4 (
    .x(temp_sum3),
    .y(temp_sum4),
    .z(sum)
);


// c_out = (a && b) || (q && c_in)
and_gate AND1 (
    .x(a),
    .y(b),
    .z(c1)
);

and_gate AND2 (
    .x(q),
    .y(c_in),
    .z(c2)
);

or_gate OR1 (
    .x(c1),
    .y(c2),
    .z(c_out)
);

endmodule
