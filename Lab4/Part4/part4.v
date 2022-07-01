module part4(clk, rst,SW, HEX );
	input [7:0] SW;
	input rst;
	input clk;
	output [27:0]HEX;
	
	wire [6:0] HX[3:0];
	assign HEX[27:21] = HX[3];
	assign HEX[20:14] = HX[2];
	assign HEX[13:7]  = HX[1];
	assign HEX[6:0]   = HX[0];
	wire [1:0] sel;
	
	part1  #(.WIDTH(2)) COUNT (clk, trigger, rst, sel);
	timer1s TIME(clk,rst,trigger);
	
	
	
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
		part5  DECODE (mux_out[3-i],HX[3-i]);
		end
	endgenerate
	 


endmodule
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

module part5 (c, HEX);
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
module timer1s  #(parameter clk_freq = 50000000)(clk,rst, trigger);
localparam WIDTH = clog2(clk_freq) ;
input clk, rst;
output  trigger;

reg [WIDTH-1:0] bigCounter;
reg [3:0] littleCounter;

assign trigger = (bigCounter == clk_freq-1) ? 1 : 0;


always @(posedge clk, negedge rst)
begin
	if(~rst)
	begin
		bigCounter <= 0;
	end
	else
	begin
		if(bigCounter == clk_freq-1)
			bigCounter <= 0;
		else
			bigCounter <= bigCounter + 1;
			

	end
end



	function integer clog2(input integer val);

	begin
	val = val -1;
	for(clog2=0; val > 0; clog2 = clog2 +1)
	begin
		val = val >> 1;
	end
	end

endfunction

	sevsegdec(littleCounter, HEX);

endmodule

module sevsegdec(in, out);
	input [3:0] in;
	output reg [6:0] out;

	always @(in)
	begin
	
		case(in)
		4'b0000: out = 7'h40;
		4'b0001: out = 7'h79;
		4'b0010: out = 7'h24;
		4'b0011: out = 7'h30;
		4'b0100: out = 7'h19;
		4'b0101: out = 7'h12;
		4'b0110: out = 7'h02;
		4'b0111: out = 7'h78;
		4'b1000: out = 7'h00;
		4'b1001: out = 7'h18;
		4'b1010: out = 7'h08;
		4'b1011: out = 7'h03;
		4'b1100: out = 7'h46;
		4'b1101: out = 7'h21;
		4'b1110: out = 7'h06;
		4'b1111: out = 7'h0E;
		default: out = 7'hXX;
		endcase
	
	
	end
endmodule