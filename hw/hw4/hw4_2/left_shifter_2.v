/*
    shift/rotate the input to the left by two bits
    Op is 1, shift
    Op is 0, rotate
 */
module left_shifter_2 (In, Op, Out);
	parameter   N = 16;
   	parameter	B = 2;

   	input[N-1:0]    In;
   	input			Op;
   	output[N-1:0]   Out;

   	// B bits of 0
   	wire[B-1:0] b0 = {B{1'b0}};
    // shift/rotate the input by B bits
   	assign Out = {In[N-1-B:0], Op ? b0 : In[N-1:N-B]};
endmodule   