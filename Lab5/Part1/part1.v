module part1(clk, rst, LED);
localparam k =20;
localparam n=5;
input clk, rst;
output[n-1:0]LED;

	modulo_k_counter five_bit(clk, rst, LED);
	defparam five_bit.n = n;
	defparam five_bit.k = k;


endmodule

module modulo_k_counter (clk,rst_n, Q);
parameter n = 4;
parameter k = 16;

input clk, rst_n;
output reg [n-1:0] Q;

	always @(posedge clk, negedge rst_n)
	begin
		if( ~rst_n)
			Q <=1'd0;
		else
			if( Q == k-1)
				Q <=1'd0;
			else
				Q <= Q + 1'b1;


	end

endmodule