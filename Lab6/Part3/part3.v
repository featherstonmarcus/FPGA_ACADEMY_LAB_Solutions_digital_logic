module part3(A,B,HEX);
localparam WIDTH =4;
	input [WIDTH-1:0] A,B;
	output[7*WIDTH-1:0] HEX;

	wire [2*WIDTH-1:0] Product;


	mult MULTIPLY (A,B,Product);
	defparam MULTIPLY.WIDTH=4;


	sevsegdec(Product[2*WIDTH-1:WIDTH], HEX[27:21]);
	sevsegdec(Product[WIDTH-1:0], HEX[20:14]);
	
	sevsegdec(A, HEX[13:7]);
	sevsegdec(B, HEX[6:0]);
endmodule

module mult(A,B,P); //A*B=P
parameter WIDTH = 4;
	input[WIDTH-1:0] A,B;
	output[2*WIDTH -1: 0] P;
	
	wire[WIDTH:0] partials [WIDTH-1:0];
	
	
	wire[WIDTH:0] carries  [WIDTH:0];
	genvar i;
	genvar j;
	generate
		for(i = 0; i<WIDTH; i = i +1)
		begin : ROWS
			assign carries[i][0] = 1'b0;
			assign partials[i][WIDTH] = carries[i][WIDTH];
			assign P[i] = partials[i][0];
			for(j =0; j <WIDTH; j = j +1)
			begin : COLS
				if( i == 0)
				begin
			
				assign partials[i][j] = A[j]&B[i]; 
					assign carries[i][j+1] = 1'b0;
				end
				else 
					fa FULLADDERS(partials[i-1][j+1],A[j]&B[i],carries[i][j],partials[i][j],carries[i][j+1]);
					
			end
		end
		assign P[2*WIDTH-1] = carries[WIDTH-1][WIDTH];
		for(i=2*WIDTH-2; i>=WIDTH; i = i -1)
		begin: ANSWER
			assign P[i] =partials[WIDTH-1][i-WIDTH+1];
			
		end
	endgenerate

 


endmodule

module fa(a,b,cin, s,co);
	input a,b,cin;
	output s,co;

	assign s = a ^ b ^ cin;
	assign co = a&b | a&cin | b&cin ;




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