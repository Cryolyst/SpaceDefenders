module ClockDivider(Clk, Reset, MediumEnable, SlowEnable);
	input logic Clk, Reset;
	output logic MediumEnable;// Bullet Speed
	output logic SlowEnable;  // Debris Speed
	
	logic [31:0] divided_clocks;
	
	always_ff @(posedge Clk) begin
		divided_clocks <= divided_clocks + 1'b1;
	end
	
	`ifdef ALTERA_RESERVED_QIS // For Board
		assign MediumEnable = (divided_clocks[20:0] == 21'd0); // 24Hz
		assign SlowEnable = (divided_clocks[23:0] == 24'd0); // 3Hz
	
	`else // ModelSim Simulation
		assign MediumEnable = (divided_clocks[2:0] == 3'd0);
		assign SlowEnable = (divided_clocks[4:0] == 5'd0);
	`endif
endmodule
		