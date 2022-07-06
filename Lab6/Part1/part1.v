module part1(clk,rst, A, ov,c,Acc,HEX);
	input clk, rst;
	input [7:0] A;
	output ov, c;
	output [7:0] Acc;
	output [27:0] HEX;
	
	wire [7:0] A_REG, SUM;
	wire carry,adder_carry, logic_ov;
	
	
	
	register AREG (clk,rst,A,A_REG);
	defparam AREG.WIDTH = 8;
	register SREG (clk,rst,SUM,Acc);
	defparam SREG.WIDTH = 8;
	register LREG (clk,rst,logic_ov,ov);
	defparam LREG.WIDTH = 1;
	register CREG (clk,rst,adder_carry,c);
	defparam CREG.WIDTH = 1;
	
	ovLogic GLUE (A_REG[7], Acc[7], SUM[7], logic_ov);
	adder ADDER  (A_REG, Acc,1'b0,SUM,adder_carry);
	defparam ADDER.WIDTH=8;
	
	
	sevsegdec ADEC0(A_REG[3:0],HEX[6:0]);
	sevsegdec ADEC1(A_REG[7:4],HEX[13:7]);
	sevsegdec AccDEC0(Acc[3:0],HEX[20:14]);
	sevsegdec AccDEC1(Acc[7:4],HEX[27:21]);
endmodule


module adder(A,B,cin,S,carry);
parameter WIDTH = 4;
	input [WIDTH-1:0]A,B;
	input cin;
	output[WIDTH-1:0]S;
	output carry;

	assign {carry,S} = {1'b0,A} + {1'b0,B}+cin;

endmodule

module register(clk,rst,D,Q);
parameter WIDTH = 4;
	input clk, rst;
	input[WIDTH-1:0]D;
	output reg[WIDTH-1:0]Q;

	always @(posedge clk, negedge rst)
	begin
	if(~rst)
		Q <= 0;
	else
		Q <= D;		
	end
	
endmodule

module ovLogic(A,B,S, ov);
input A,B,S;
output ov;

assign ov = S&(~A&~B) | (~S)&(A&B);

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