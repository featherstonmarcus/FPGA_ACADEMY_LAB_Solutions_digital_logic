//Circuit to increment 0-9 on Hex 1 number per second;
module part3 (clk,rst,HEX);
parameter clk_freq =50000000;
localparam WIDTH =26;
input clk, rst;
output [6:0] HEX;

reg [WIDTH-1:0] bigCounter;
reg [3:0] littleCounter;
wire littleCounter_en;

assign littleCounter_en = (bigCounter == clk_freq-1) ? 1 : 0;


always @(posedge clk, negedge rst)
begin
	if(~rst)
	begin
		bigCounter <= 0;
		littleCounter <=0;
	end
	else
	begin
		if(bigCounter == clk_freq-1)
			bigCounter <= 0;
		else
			bigCounter <= bigCounter + 1;
			
		if(littleCounter_en)
			if(littleCounter == 9)
				littleCounter <=0;
			else
				littleCounter <= littleCounter + 1;
	end
end





	sevsegdec(littleCounter, HEX);
	
function integer clog2(input integer val);

	begin
	val = val -1;
	for(clog2=0; val > 0; clog2 = clog2 +1)
	begin
		val = val >> 1;
	end
	end

endfunction

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