module part4(X,Y,c, HEX,err);
input [3:0] X,Y;
input c;
output [13:0]HEX;
output err;

wire [4:0] sum;
wire [7:0] BCD;

wire zX, zY;
assign zX = X[3]&X[2]|X[3]&X[1];
assign zY = Y[3]&Y[2]|Y[3]&Y[1];
assign err = zX | zY;
part3 summer(X,Y,c,sum[3:0], sum[4]);
BCD_encoder b(sum,BCD);


sevsegdec ONES(BCD[3:0],HEX[6:0]);
sevsegdec TENS(BCD[7:4],HEX[13:7]);



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
module part3(A,B, ci, S, co);
	input [3:0] A,B;
	input ci;
	output [3:0] S;
	output co;
	
	wire [4:0]carries;
	assign carries[0] = ci;
	assign co = carries[4];
	
	genvar i;
	generate
		for(i= 0; i<4;i = i + 1)
		begin :FAS
			fa ripple(A[i],B[i],carries[i],S[i],carries[i+1]);		
		end
	endgenerate




endmodule

module fa(a,b,cin, s,cout);
input a,b,cin;
output s, cout;

assign s = a ^ b ^ cin;
assign cout = (a^b)? cin: b;


endmodule

module BCD_encoder(binary, BCD);
input [4:0] binary;
output[7:0] BCD;

assign BCD = {BCD_overflow, BCD_overflow ? BCD_ones:binary[3:0]};


wire [3:0] BCD_overflow; 
reg  [3:0] BCD_ones;
assign BCD_overflow = {3'b000,binary[4]|binary[3]&binary[2]|binary[3]&binary[1]};

	always @(binary)
	begin
		case(binary)
			5'b01010:BCD_ones = 4'b0000;  
			5'b01011:BCD_ones = 4'b0001; 
			5'b01100:BCD_ones = 4'b0010; 
			5'b01101:BCD_ones = 4'b0011; 
			5'b01110:BCD_ones = 4'b0100; 
			5'b01111:BCD_ones = 4'b0101; 
			5'b10000:BCD_ones = 4'b0110; 
			5'b10001:BCD_ones = 4'b0111; 
			5'b10010:BCD_ones = 4'b1000; 
			5'b10011:BCD_ones = 4'b1001;
			default: BCD_ones = 4'bxxxx;
			
		
		
		endcase
	
	
	
	
	end


endmodule