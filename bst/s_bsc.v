module s_bsc(in, out, sdi, sdo, shift, update, clock, brk);
   input [2:0] in;
   input       sdi, shift, update, clock, brk;

   output [2:0] out;
   output       sdo;       

   wire         di0, di1;
   
   bsc
     bsc0(sdi, di0, shift, update, clock, in[0], 1'b1, brk, out[0]),
     bsc1(di0, di1, shift, update, clock, in[1], 1'b1, brk, out[1]),
     bsc2(di1, sdo, shift, update, clock, in[2], 1'b1, brk, out[2]);

   
endmodule
