module part5(SW, HEX );
	input [9:0] SW;
	output [27:0]HEX;
	
	wire [6:0] HX[3:0];
	assign HEX[27:21] = HX[3];
	assign HEX[20:14] = HX[2];
	assign HEX[13:7]  = HX[1];
	assign HEX[6:0]   = HX[0];
	wire [1:0] sel;
	assign sel = SW[9:8];
	wire [1:0] disp_sel[3:0];
	wire [1:0] mux_out[3:0];
	assign disp_sel[3] =SW[1:0];
	assign disp_sel[2] =SW[3:2];
	assign disp_sel[1] =SW[5:4];
	assign disp_sel[0] =SW[7:6];
	
	
	genvar i;
	generate
		for(i=0; i<4; i = i+1)
		begin : DECODERS
		part3  MUX (disp_sel[(i%4)],disp_sel[(i+1)%4],disp_sel[(i+2)%4],disp_sel[(i+3)%4],sel,mux_out[3-i]);
		part4  DECODE (mux_out[3-i],HX[3-i]);
		end
	endgenerate
	 


endmodule

module part4 (c, HEX);
	input [1:0] c;
	output reg [6:0] HEX;


	always@(c)
	begin
	
		case (c)
			2'b00:
				HEX = 7'h21;
			2'b01:
				HEX = 7'h06;
			2'b10:
				HEX = 7'h79;
			2'b11:
				HEX = 7'h40;
		
			default:
				HEX = 7'h7F;
	endcase
	
	
	end
endmodule


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