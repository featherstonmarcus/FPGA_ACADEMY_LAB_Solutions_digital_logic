module part2(V, HEX);
input [3:0] V;
output [13:0] HEX;

wire c;
wire [3:0] A;
wire [3:0] one_dig;

assign c = V[3]&V[2] | V[3]&V[1];

circA CHECK(V,A);
assign one_dig =  c ? A :V;

sevsegdec TENS ({3'b000,c},HEX[13:7]);
sevsegdec ONES (one_dig, HEX[6:0]);



endmodule

module circA(V, A);
	input [3:0] V;
	output reg [3:0] A;

	always @(V)
	begin
		case (V[2:0])
			3'b010: A=4'd0;
			3'b011: A=4'd1;
			3'b100: A=4'd2;
			3'b101: A=4'd3;
			3'b110: A=4'd4;
			3'b111: A=4'd5;
			default: A=4'hX;
		endcase
	
	end

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
		default: out = 7'hXX;
		endcase
	
	
	end



endmodule

