module part1 #(parameter WIDTH =8) (clk, en, clr, count);
	input clk, en, clr;
	output [WIDTH-1 :0] count;
	
	wire [WIDTH : 0] bit_en;
	wire [WIDTH-1 : 0] Q;
	assign bit_en[0] = en;
	assign count = Q;
	
	
	genvar i;
	generate
		for(i=0; i<WIDTH; i = i + 1)
		begin :CASCADED
			tFlip T_FLIPS(clk,clr,bit_en[i],Q[i]);
			assign bit_en[i+1] = bit_en[i] & Q[i];
		
		end
	
	endgenerate
	
	


endmodule

module tFlip(clk,clr, T, Q);
	input clk, clr, T;
	output reg Q;

	wire Qnext;

	assign Qnext = T ? ~Q : Q;

	always @(posedge clk, negedge clr)
	begin
		if( ~clr)
			Q <= 1'b0;
		else
			Q <= Qnext;
	end


endmodule