module part1(SW, HEX);
input [7:0] SW;
output [13:0] HEX;

wire [6:0] HX_DIG [1:0];
wire [3:0] SW_DIG [1:0];

	genvar i;
	generate
	for(i =0; i<2; i = i +1)
	begin :SIMPLE
		assign  HEX[6+7*i:7*i] = HX_DIG[i];
		assign SW_DIG[i] = SW[3+4*i:4*i];
	end
	endgenerate

	sevsegdec HEX0 ( SW_DIG[0],HX_DIG[0]);
	sevsegdec HEX1 ( SW_DIG[1],HX_DIG[1]);

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

