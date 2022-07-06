module part4(A,B,HEX);
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

module mult (A,B,P);
parameter WIDTH = 4;
	input[WIDTH-1:0] A,B;
	output[2*WIDTH-1:0] P;
	
	wire[WIDTH:0] partials [WIDTH-1:0];
	
	
	genvar i;
	generate
		for(i = 0; i<WIDTH; i = i + 1)
		begin : ROWS
			if(i ==0)
				assign partials[0] = {1'b0,A}& {WIDTH{B[0]}};
			else
			begin
				adder ADDERS (A&{WIDTH{B[i]}},partials[i-1][WIDTH:1],1'b0,partials[i][WIDTH-1:0],partials[i][WIDTH]);
			end
				assign P[i] = partials[i][0];
		end
	
	endgenerate
	
	assign P[2*WIDTH-1:WIDTH] = partials[WIDTH-1][WIDTH:1];


endmodule


module adder(A,B,ci, S, co);
parameter WIDTH = 4;
input [WIDTH-1:0] A,B;
input ci;
output [WIDTH-1:0] S;
output co;

assign {co, S} = {1'b0,A} +B +ci;
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