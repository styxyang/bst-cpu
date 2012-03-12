module bsc(sdi, sdo, shift, update, clock, dbin, dben, brk, pin_out);
   input sdi, shift, update, clock, dbin, dben, brk;
   output sdo, pin_out;

   reg [2:0] capreg;
   reg [2:0] upreg;
   wire      pin_en;
     
   assign sdo = capreg[2];
   assign pin_en = (capreg[1] & brk) | (dben & (~brk));
   assign pin_out = (pin_en)? ((upreg[0] & brk) | (dbin & (~brk))) : 1'bz;

   initial
     begin
        capreg = 3'b000;
        upreg  = 3'b000;
     end
   
   always @ (posedge clock)
     begin
        capreg[0] = (sdi & shift) | (dbin & (~shift));
        capreg[1] = (capreg[0] & shift) | (dben & (~shift));
        capreg[2] = (capreg[1] & shift) | (pin_out & (~shift));
     end

   always @ (posedge update)
     begin
        upreg = capreg;
     end
   
endmodule
