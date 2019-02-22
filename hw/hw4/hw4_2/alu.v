/*
    CS/ECE 552 Spring '19
    Homework #4, Problem 2

    A 16-bit ALU module.  It is designed to choose
    the correct operation to perform on 2 16-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the 16-bit result
    of the operation, as well as output a Zero bit and an Overflow
    (OFL) bit.
*/
module alu (A, B, Cin, Op, invA, invB, sign, Out, Zero, Ofl);

   // declare constant for size of inputs, outputs (N),
   // and operations (O)
   parameter    N = 16;
   parameter    O = 3;
   
   input [N-1:0] A;
   input [N-1:0] B;
   input         Cin;
   input [O-1:0] Op;
   input         invA;
   input         invB;
   input         sign;
   output [N-1:0] Out;
   output         Ofl;
   output         Zero;

   /* YOUR CODE HERE */
   wire [N-1:0] A_in, B_in, shft_out, adder_out, and_out, or_out, xor_out;
   wire cout, sign_ofl;

   // convert the input before operation if needed
   assign A_in = invA ? ~A : A;
   assign B_in = invB ? ~B : B;

   // shift input A and the amount of bits is [3:0] of input B
   // using barrelShifter from hw4_1
   barrelShifter s0(.Out(shft_out), .In(A_in), .Cnt(B_in[3:0]), .Op(Op[1:0]));
   
   // using a ripple carry adder from hw3
   rca_16b adder_16b_1(.A(A_in), .B(B_in), .C_in(Cin),.S(adder_out), .C_out(cout));

   // a and b
   assign and_out = A_in & B_in;

   // a or b
   assign or_out = A_in | B_in;

   // a xor b
   assign xor_out = A_in ^ B_in;

   // check if out is exactly zero
   assign Zero = ~|Out;

   // assert Ofl when overflow of add instruction
   // unsigned additiion overflow when cout is 1
   // signed addition overflow 
   assign sign_ofl = (A_in[N-1] & B_in[N-1] & ~adder_out[N-1]) | (~A_in[N-1] & ~B_in[N-1] & adder_out[N-1]);
   assign Ofl = Op == 3'b100 ? (sign ? sign_ofl : cout) : 1'b0;

   // output
   assign Out = Op[2] ? (Op[1] ? (Op[0] ? xor_out : or_out) : (Op[0] ? and_out : adder_out)) : shft_out;
endmodule
