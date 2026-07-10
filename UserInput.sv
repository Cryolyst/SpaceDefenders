module UserInput(Clk, Reset, KEY, UserIn);
	input logic Clk, Reset, KEY;
	output logic UserIn;
	
	logic Q1, Q2;
	always_ff @(posedge Clk) begin
		Q1 <= KEY;
		Q2 <= Q1; // It has passed through the second flip-flop
	end 
	
	enum logic [1:0] {None, Pulse, Hold} ps, ns;
	
	always_comb begin
	
		UserIn = 1'b0;
		ns = None;
	
		case(ps)
			None : begin
				UserIn = 1'b0;
				
				if (Q2)
					ns = Pulse;
				else
					ns = None;
			end
			
			Pulse : begin
				UserIn = 1'b1;
				
				if (Q2)
					ns = Hold;
				else
					ns = None;
			end
			
			Hold : begin
				UserIn = 1'b0;
				
				if (Q2)
					ns = Hold;
				else
					ns = None;
			end
		endcase
	end
	
	always_ff @(posedge Clk) begin
		if (Reset)
			ps <= None;
		else
			ps <= ns;
	end	
endmodule

module UserInput_testbench();

	logic Clk, Reset, KEY, UserIn;
	
	UserInput dut (.Clk(Clk), .Reset(Reset), .KEY(KEY), .UserIn(UserIn));
	
	parameter CLOCK_PERIOD=100;
	initial begin
		Clk <= 0;
		forever #(CLOCK_PERIOD/2) Clk <= ~Clk; // Forever toggle the clock
	end
	
	initial begin
		KEY <= 0;
					@(posedge Clk);
		Reset <= 1; @(posedge Clk);
		Reset <= 0; @(posedge Clk);
		
		KEY <= 1; repeat(5) @(posedge Clk);
		KEY <= 0; repeat(5) @(posedge Clk);
		$stop;
	end
endmodule
				