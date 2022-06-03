module part3(Clk, D, Q);
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