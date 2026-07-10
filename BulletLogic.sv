module BulletLogic(Clk, MediumEnable, Reset, Fire, TurretPosition, BulletPos_X, BulletPos_Y, ActiveBullet, Collision);
	input logic Clk, MediumEnable, Reset, Fire, Collision;
	input logic [3:0] TurretPosition;
	output logic [3:0] BulletPos_X, BulletPos_Y;
	output logic ActiveBullet;
	
	always_ff @(posedge Clk) begin
		if (Reset) begin // Literally deletes the bullet on the field
			ActiveBullet <= 1'b0;
			BulletPos_X <= 4'd0;
			BulletPos_Y <= 4'd0;
		end	
		else if (Collision) begin
			ActiveBullet <= 1'b0; // Bullet has collided with a debris
		end
		else if (Fire & ~ActiveBullet) begin 
				ActiveBullet <= 1'b1; 
				BulletPos_X <= TurretPosition;
				BulletPos_Y <= 4'd13;
			end
		else if (MediumEnable) begin // Bullet is active on the field
			if (ActiveBullet) begin
				if (BulletPos_Y == 4'd0) begin 
					ActiveBullet <= 1'b0; // Bullet has fallen off the matrix
				end
				else begin
					BulletPos_Y <= BulletPos_Y - 1'b1; // Bullet traveling up the matrix
				end
			end
		end
	end
endmodule

module BulletLogic_testbench();
	logic Clk, MediumEnable, Reset, Fire, Collision, ActiveBullet;
	logic [3:0] TurretPosition, BulletPos_X, BulletPos_Y;
	
	BulletLogic dut (.Clk(Clk), .MediumEnable(MediumEnable), .Reset(Reset), .Fire(Fire), .Collision(Collision),
	.ActiveBullet(ActiveBullet), .TurretPosition(TurretPosition), .BulletPos_X(BulletPos_X), .BulletPos_Y(BulletPos_Y));
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clk <= 0;
		forever #(CLOCK_PERIOD/2) Clk <= ~Clk; // Forever toggle the clock
	end
	
	initial begin
		MediumEnable <= 0; Fire <= 0; TurretPosition <= 4'd0; ActiveBullet <= 0; Collision <= 0; @(posedge Clk);
		Reset <= 1; @(posedge Clk);
		Reset <= 0; MediumEnable <= 1; @(posedge Clk);
		
		TurretPosition <= 4'd6; Fire <= 1; repeat(17) @(posedge Clk);
		$stop;
	end
endmodule
