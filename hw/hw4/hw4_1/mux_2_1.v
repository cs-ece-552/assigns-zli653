/*
    CS/ECE 552 Spring '19
    Homework #3, Problem 1

    2-1 mux template
*/
module mux_2_1(InA, InB, S, Out);
    input   InA, InB;
    input   S;
    output  Out;

    // YOUR CODE HERE
    wire nS, nand_a, nand_b;
    not1 not1_S(.in1(S), .out(nS));
    nand2 nand_1(.in1(nS), .in2(InA), .out(nand_a));
    nand2 nand_2(.in1(S), .in2(InB), .out(nand_b));

    nand2 nand_3(.in1(nand_a), .in2(nand_b), .out(Out));
endmodule
