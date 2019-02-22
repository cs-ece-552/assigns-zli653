/*
    CS/ECE 552 Spring '19
    Homework #4, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the Op() value that is passed in (2 bit number).  It uses these
    shifts to shift the value any number of bits between 0 and 15 bits.
 */
module barrelShifter (In, Cnt, Op, Out);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 16;
   parameter   C = 4;
   parameter   O = 2;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   input [O-1:0]   Op;
   output [N-1:0]  Out;

   /* YOUR CODE HERE */
   wire [N-1:0]  left_out_1, left_out_2, left_out_4, left_out_8;
   wire [N-1:0]  rght_out_1, rght_out_2, rght_out_4, rght_out_8;
   wire [N-1:0]  barr2, barr4, barr8;

   // left shift/rotate input
   // left_out_1 = Op[0] ? In << 1 | In >> 16-1 : In << 1
   // left_out_2 = Op[0] ? In << 2 | In >> 16-2 : In << 2
   // left_out_4 = Op[0] ? In << 4 | In >> 16-4 : In << 4
   // left_out_8 = Op[0] ? In << 8 | In >> 16-8 : In << 8
   left_shifter_1 left0(.In(In), .Op(Op[0]), .Out(left_out_1));
   left_shifter_2 left1(.In(barr2), .Op(Op[0]), .Out(left_out_2));
   left_shifter_4 left2(.In(barr4), .Op(Op[0]), .Out(left_out_4));
   left_shifter_8 left3(.In(barr8), .Op(Op[0]), .Out(left_out_8));

   // right shift/rotate input
   // rght_out_1 = Op[0] ? In >>> 1 : In >> 1
   // rght_out_2 = Op[1] ? In >>> 2 : In >> 2
   // rght_out_4 = Op[2] ? In >>> 4 : In >> 4
   // rght_out_8 = Op[3] ? In >>> 8 : In >> 8   
   rght_shifter_1 rght0(.In(In), .Op(Op[0]), .Out(rght_out_1));
   rght_shifter_2 rght1(.In(barr2), .Op(Op[0]), .Out(rght_out_2));
   rght_shifter_4 rght2(.In(barr4), .Op(Op[0]), .Out(rght_out_4));
   rght_shifter_8 rght3(.In(barr8), .Op(Op[0]), .Out(rght_out_8));

   // using cnt to choose whether using previous shift output
   assign barr2 = Cnt[0] ? (Op[1] ? rght_out_1 : left_out_1) : In;
   assign barr4 = Cnt[1] ? (Op[1] ? rght_out_2 : left_out_2) : barr2;
   assign barr8 = Cnt[2] ? (Op[1] ? rght_out_4 : left_out_4) : barr4;
   // output
   assign Out = Cnt[3] ? (Op[1] ? rght_out_8 : left_out_8) : barr8;
   // mux4_1_16b bit2_in_sel(.InA(In), .InB(In), .InC(left_out_1),. InD(rght_out_1), .S({Cnt[0],Op[1]}), .Out(barr2));
   // mux4_1_16b bit4_in_sel(.InA(barr2), .InB(barr2), .InC(left_out_2),. InD(rght_out_2), .S({Cnt[1],Op[1]}), .Out(barr4));
   // mux4_1_16b bit8_in_sel(.InA(barr4), .InB(barr4), .InC(left_out_4),. InD(rght_out_4), .S({Cnt[2],Op[1]}), .Out(barr8));
   // mux4_1_16b out_sel(.InA(barr8), .InB(barr8), .InC(left_out_8),. InD(rght_out_8), .S({Cnt[3],Op[1]}), .Out(Out));

endmodule
