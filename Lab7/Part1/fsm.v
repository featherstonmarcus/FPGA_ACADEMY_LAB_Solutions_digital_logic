module fsm(clk, rst, w, z);
localparam [3:0] A = 4'h0;
localparam [3:0] B = 4'h1;
localparam [3:0] C = 4'h2;
localparam [3:0] D = 4'h3;
localparam [3:0] E = 4'h4;
localparam [3:0] F = 4'h5;
localparam [3:0] G = 4'h6;
localparam [3:0] H = 4'h7;
localparam [3:0] I = 4'h8;

input clk,rst,w;
output reg z;
reg [3:0] state;
reg[3:0] next_state;

always @(posedge clk, negedge rst)
begin
	if(~rst)
		state <= A;
	else
		state <= next_state;

end

always @(state, w)
begin
	next_state = A;
	z = 1'b0;
	
	case(state)
		A:
		begin
			if(w)
				next_state =F;
			else
			    next_state = B;
		end
		B:
		begin		
			if(w)
				next_state = F;
			else
				next_state = C;
		end
		C:
		begin
			if(w)
				next_state = F;
			else
				next_state = D;
		end
		D:
		begin
			if(w)
				next_state = F;
			else
				next_state = E;
		end
		E:
		begin
			z = 1'b1;
			if(w)
				next_state = F;
			else
				next_state = E;
		end
		F:
		begin
			if(w)
				next_state = G;
			else
				next_state = B;
		end
		G:
		begin
			if(w)
				next_state = H;
			else
				next_state = B;
		end
		H:
		begin
			if(w)
				next_state = I;
			else
				next_state = B;
		end
		I:
		begin
			z = 1'b1;
			if(w)
				next_state = I;
			else
				next_state = B;
		end
		default:
			next_state = A;
	endcase
end
endmodule