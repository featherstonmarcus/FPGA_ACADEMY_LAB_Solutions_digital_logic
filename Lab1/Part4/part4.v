module part4 (c, HEX);
	input [1:0] c;
	output reg [6:0] HEX;


	always@(c)
	begin
	
		case (c)
			2'b00:
				HEX = 7'h21;
			2'b01:
				HEX = 7'h06;
			2'b10:
				HEX = 7'h79;
			2'b11:
				HEX = 7'h40;
		
			default:
				HEX = 7'h7F;
	endcase
	
	
	end
endmodule
