/*
    CS/ECE 552 Spring '19
    Homework #3, Problem 1

    4-1 mux template
*/
module mux_4_1(InA, InB, InC, InD, S, Out);
    input        InA, InB, InC, InD;
    input [1:0]  S;
    output       Out;

    // YOUR CODE HERE
    wire in_bit0, in_bit1;
    mux_2_1 bit_1_is_0(.InA(InA), .InB(InB), .S(S[0]), .Out(in_bit0));
    mux_2_1 bit_1_is_1(.InA(InC), .InB(InD), .S(S[0]), .Out(in_bit1));
    mux_2_1 bit_1(.InA(in_bit0), .InB(in_bit1), .S(S[1]), .Out(Out));
endmodule
