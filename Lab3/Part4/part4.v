module part4(Clk, D, Qa, Qb, Qc);
input Clk, D;
output Qa,Qb,Qc;

d_latch LATCH(Clk, D, Qa);
d_ff_p  DFFP(Clk,D,Qb);
d_ff_n  DFFN(Clk,D,Qc);
endmodule

module d_ff_n(Clk, D, Q);
input D, Clk;
output Q;

wire Qm, n_Clk ;
assign n_Clk = ~ Clk;

d_latch Master(Clk, D, Qm);
d_latch Slave(n_Clk,Qm,Q);



endmodule

module d_ff_p(Clk, D, Q);
input D, Clk;
output Q;

wire Qm, n_Clk ;
assign n_Clk = ~ Clk;

d_latch Master(n_Clk, D, Qm);
d_latch Slave(Clk,Qm,Q);



endmodule


module d_latch(Clk, D, Q);
input Clk, D;
output Q;

wire S, R;
wire S_g, R_g, Qa, Qb /*synthesis keep*/;

assign S = D;
assign R = ~D;

assign S_g = ~(S & Clk);
assign R_g = ~(R & Clk);

assign Qa = ~(S_g & Qb);
assign Qb = ~(R_g & Qa);

assign Q = Qa;

endmodule