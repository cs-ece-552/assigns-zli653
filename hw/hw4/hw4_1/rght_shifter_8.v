/*
    shift/rotate the input to the right by eight bits
    Op is 1, shift
    Op is 0, rotate
 */
module rght_shifter_8 (In, Op, Out);
    parameter   N = 16;
   	parameter	  B = 8;

   	input[N-1:0]    In;
   	input			      Op;
   	output[N-1:0]   Out;

   	// B bits of 0
   	wire[B-1:0] b0 = {B{1'b0}};
    // shift/rotate the input by B bits
    assign Out = {Op ? b0 : {B{In[N-1]}}, In[N-1:B]};
endmodule   