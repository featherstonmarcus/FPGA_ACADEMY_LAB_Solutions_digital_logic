module part3(U, V, W, X, s, M);
	input [1:0] U,V,W,X, s;
	output[1:0] M;

	wire [1:0]uv_out;
	wire [1:0]wx_out;
	
	generic21mux uv_mux(U,V,s[0], uv_out);
	generic21mux wx_mux(W,X,s[0], wx_out);
	generic21mux uvwx_mux(uv_out, wx_out, s[1], M);
endmodule



module generic21mux #(parameter WIDTH = 2) (X, Y, s, M);
	input [WIDTH-1 : 0] X,Y;
	input s;
	output reg [WIDTH-1 :0] M;
	
	always @(X,Y,s)
	begin
		if(s)
			M = Y;
		else
			M = X;
	
	
	end

endmodule