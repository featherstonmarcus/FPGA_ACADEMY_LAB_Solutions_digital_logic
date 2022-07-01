module part2 #(parameter WIDTH = 16)(clk, rst, HEX);

	localparam  HEX_DIGS = hex_wid(WIDTH); // The number of hex digits needed for counter width

	input clk, rst;
	output[7*HEX_DIGS-1:0] HEX;

	reg [WIDTH-1:0] count;
	
	
	//The actual counter 
	always @(posedge clk, negedge rst)
	begin
		if(~rst)
			count <=0;
		else
		
			count <= count + 1;
	end
	
	//Connecting the count output to 7seg decoders
	genvar i;
	generate
		for(i=0; i< HEX_DIGS; i = i+ 1)
		begin : DECODERS
			sevsegdec(count[4*(i+1)-1:4*i],HEX[7*(i+1)-1:7*i]);
		end
	
	endgenerate




	function integer hex_wid (input integer a);
		hex_wid = (a-1)/4+1;
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

