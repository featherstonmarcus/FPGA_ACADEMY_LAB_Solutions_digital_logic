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