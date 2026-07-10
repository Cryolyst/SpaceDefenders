module TurretMovement(Clk, Reset, L, R, Position);
	input logic Clk, Reset, L, R;
	output logic [3:0] Position; // Need a 4 bit value as there will be 14 valid positions
	
	always_ff @(posedge Clk) begin
		if (Reset) begin
			Position <= 4'd6;
		end
		else begin
			if (L & ~R & Position < 4'd14) begin // This makes it so that it is bounded at value 13
				Position <= Position + 4'b1;
			end
			
			else if (~L & R & Position > 4'd1) begin // This makes it so that it is bounded at value 1
				Position <= Position - 4'b1;
			end
		end													// So in total this makes it so that 14 valid positions in 16 horizonal matrix, accounting width 3
	end
endmodule

module TurretMovement_testbench();
	logic Clk, Reset, L, R;
	logic [3:0] Position;
	
	TurretMovement dut (.Clk(Clk), .Reset(Reset), .L(L), .R(R), .Position(Position));
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clk <= 0;
		forever #(CLOCK_PERIOD/2) Clk <= ~Clk; // Forever toggle the clock
	end
	
	initial begin
		L <= 0; R <= 0; 							@(posedge Clk);
		Reset <= 1; 								@(posedge Clk);
		Reset <= 0; 								@(posedge Clk);
		
		for (int i = 0; i < 15; i++) begin
			L <= 1; repeat(2) 					@(posedge Clk);
		end
		
		L <= 0; 										@(posedge Clk);
		
		for (int i = 0; i < 15; i++) begin
			R <= 1; repeat(2) 					@(posedge Clk);
		end
		$stop;
	end
endmodule
