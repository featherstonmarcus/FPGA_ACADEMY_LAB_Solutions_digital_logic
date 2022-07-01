module part2(clk,rst,HEX);
parameter digits  =3;  //Number of digits in base 10
localparam base = 4'b1010;
localparam n    = 4;  //Counter bit size 
input clk, rst;
output[7*digits-1:0]HEX;

wire [digits:0] counter_en;
wire [digits:0] counter_en_d;
wire [digits:0] ready_inc;
wire [n-1:0] counts [digits-1:0];

	timer timer_1s (clk,rst, counter_en[0]);
	assign ready_inc[0] = 1'b1;

	genvar i;
	generate
			for(i=0; i<digits; i = i + 1)
			begin :COUNTERS
				modulo_k_counter #(.n(n), .k(base))(counter_en[i], rst, counts[i]);
				assign ready_inc[i+1] = (counts[i] == (base-1'b1)? 1'b1: 1'b0);
				dffp(counter_en[i], rst, ready_inc[i+1]&ready_inc[i],counter_en[i+1]);
				
				
				
				sevsegdec(counts[i], HEX[7*(i+1)-1:7*i]);
			end

	endgenerate



endmodule
module dffp(clk,rst,d,q);
input clk,rst,d;
output reg q;
always @(posedge clk, negedge rst)
begin
	if(~rst)
		q <= 1'b0;
	else
		q <=d;
end


endmodule

module modulo_k_counter (clk,rst_n, Q);
parameter n = 4;
parameter k = 16;

input clk, rst_n;
output reg [n-1:0] Q;

	always @(posedge clk, negedge rst_n)
	begin
		if( ~rst_n)
			Q <=1'd0;
		else
			if( Q == k-1)
				Q <=1'd0;
			else
				Q <= Q + 1'b1;


	end

endmodule

module timer #(parameter clk_freq = 50000000)(clk,rst,Q);
localparam WIDTH = clog2(clk_freq)+1;
input clk, rst;
output Q;

reg [WIDTH-1:0] bigCounter;

assign Q = (bigCounter == clk_freq-1) ? 1'b1 : 1'b0;


always @(posedge clk, negedge rst)
begin
	if(~rst)
	begin
		bigCounter <= 0;
	end
	else
	begin
		if(bigCounter == clk_freq-1)
			bigCounter <= 1'd0;
		else
			bigCounter <= bigCounter + 1'b1;
			
	end
end



	function integer clog2(input integer value);
		begin
		
			for(clog2 =0; value > 1; clog2 = clog2 + 1)
			begin
				value = value >> 1;
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
