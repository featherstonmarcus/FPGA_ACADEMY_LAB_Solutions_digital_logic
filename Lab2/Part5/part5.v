module part5(SWA,SWB, cin, HEX, err);
	input [3:0] SWA, SWB;
	input cin;
	output [27:0] HEX;
	output err;

	wire [6:0] a_encd, b_encd, sum1_encd, sum0_encd; //Each of the hex digits encoded;
	wire [3:0] sum1, sum0;
	wire zA, zB;
	
	assign zA = SWA[3]&SWA[2] | SWA[3]&SWA[1]; // A is greater than 9 err
	assign zB = SWB[3]&SWB[2] | SWB[3]&SWB[1]; // B is greater than 9 err
	assign err = zA | zB;

	assign HEX[27:21] = a_encd;
	assign HEX[20:14] = b_encd;
	assign HEX[13:7]  = sum1_encd;
	assign HEX[6:0]    = sum0_encd;





	bcd_alg BCD_ADDER(SWA, SWB, cin, sum1, sum0);
	
	sevsegdec SUM1_S(sum1,sum1_encd);
	sevsegdec SUM0_S(sum0,sum0_encd);
	sevsegdec A_7SEG(SWA, a_encd);
	sevsegdec B_7SEG(SWB, b_encd);



endmodule


module bcd_alg(A, B, cin, sum1, sum0);
	input [3:0] A, B;
	input cin;
	output [3:0] sum1, sum0;
	
	wire [4:0] total_sum;
	wire [4:0] Z;  // used to find sum%10 to get ones position
	wire [4:0] sum_carry;
	
	assign total_sum = {1'b0,A} + {1'b0,B} +cin;
	assign Z = (total_sum > 9) ?  5'b10110 :  5'b00000;
	assign sum1 = (total_sum > 9) ? 4'b0001 : 4'b0000;
	assign sum_carry = (total_sum + Z);
	assign sum0 = sum_carry[3:0];
	



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