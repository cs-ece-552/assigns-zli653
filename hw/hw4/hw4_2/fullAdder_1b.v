/*
    CS/ECE 552 Spring '19
    Homework #3, Problem 2
    
    a 1-bit full adder
*/
module fullAdder_1b(A, B, C_in, S, C_out);
    input  A, B;
    input  C_in;
    output S;
    output C_out;

    // YOUR CODE HERE
    wire a_xor_b, a_nand_b;
    xor2 xor_ab(.in1(A),.in2(B), .out(a_xor_b));
    xor2 xor_abc(.in1(a_xor_b),.in2(C_in), .out(S));
    nand2 nand_ab(.in1(A), .in2(B), .out(a_nand_b));
    nand2 nand_p(.in1(a_xor_b), .in2(C_in), .out(ab_nand_c));
    nand2 nand_co(.in1(a_nand_b), .in2(ab_nand_c), .out(C_out));
endmodule
