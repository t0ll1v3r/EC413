module nbit_mux #(parameter N = 32) (
    input [2*N-1:0] MuxIn, // Concatenated 2 inputs, each of N bits
    input MuxSel,          // 1-bit selector
    output [N-1:0] MuxOut  // Output of N bits
);

    assign MuxOut = (MuxSel) ? MuxIn[2*N-1:N] : MuxIn[N-1:0];

endmodule
