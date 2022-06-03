module part6(SW, HEX);
input [5:0] SW;
output [13:0] HEX;

wire [6:0] tens_bcd, ones_bcd;

bcd_6bit BCD_ENCD(SW, tens_bcd, ones_bcd);
sevsegdec ENCD10(tens_bcd, HEX[13:7]);
sevsegdec ENCD1(ones_bcd, HEX[6:0]);




endmodule

module bcd_6bit(A, tens, ones);
	input [5:0] A;
	output reg [3:0] tens;
	output [3:0] ones;
	
	
	reg [7:0] Z;  // used to find sum%10 to get ones position
	wire [7:0] ones_7dig;
	wire [4:0] sum_carry;
	
	always @(A)
	begin
	
	if(A > 29)
		begin
			Z = -30;
			tens = 3;
		end
	else
		if( A > 19)
		begin
			Z=-20;
			tens =2;
		end
	else
		if( A > 9)
		begin
			Z= -10;
			tens = 1;
		end
	else
		begin
			Z = 0;
			tens = 0;
		end
		
	end
	assign ones_7dig = A + Z;
	assign ones = ones_7dig[3:0];

	
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