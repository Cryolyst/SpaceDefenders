// There will be three waves of this debris
// First wave should be with 2x3 debris with 1 space gap between them
// Second wave should be with 2x2 debris with 2 space gap between them
// Third wave is an extra implementation cause it would be 2x3 debris with 2 space gap but they move at the same speed as the player(challenging)

module DebrisLogic(Clk, SlowEnable, MediumEnable, Reset, DebrisX, DebrisY, BulletPos_X, BulletPos_Y,
 ActiveBullet, ActiveDebris, GameOver, WinCondition, WaveCounter, Collision);
 
	input logic Clk, SlowEnable, MediumEnable, Reset;
	input logic ActiveBullet;
	input logic [3:0] BulletPos_X, BulletPos_Y;
	
	output logic [3:0] DebrisX, DebrisY;
	output logic [2:0] ActiveDebris; // Only three Debris are active on the field so 111. 1 = Alive, 0 = Dead
	output logic [2:0] WaveCounter; // Total eight possible waves
	output logic GameOver, WinCondition, Collision;
	
	logic CurrentSpeed; // ExtraImplementation
	
	always_comb begin
		if (WaveCounter >= 3'd3) begin
			CurrentSpeed = MediumEnable;
		end
		else begin
			CurrentSpeed = SlowEnable;
		end
	end
	
	logic [3:0] maxMoveableSpace;
	// Okay so, LISTEN CAREFULLY future Connor, maxMoveableSpace is what sets the boundary of the matrix so that the debris don't fall off
	// Wave 0 will have 5 cause the whole wave is 11 pixels long
	// Wave 1 will have 5 cause the whole wave is 11 pixels long 
	// Wave 2 will have 6 cause the whole wave is 10 pixels long
	// Wave 3 will have 12 casue the whole wave is 4 pixels long
	// Wave 4 will have 8 cause the whole wave is 8 pixels long 2x 3 widths + 2 gap
	// Wave 5 will have 9 cause the whole wave is 7 pixels long 2x 2 widths + 3 gap
	// Wave 6 will have 13 cause the whole wave is 3 pixels long 1x 3 widths 
	// Wave 7 will have 14 1x 2 widths Evil ik
 	
	logic [2:0] Hits;
	logic moving_left;
	
	always_comb begin 
		maxMoveableSpace = 4'd5;
		Hits = 3'b000;	
		
		case (WaveCounter)
			3'd0 : maxMoveableSpace = 4'd5;
			3'd1 : maxMoveableSpace = 4'd5;
			3'd2 : maxMoveableSpace = 4'd6;
			3'd3 : maxMoveableSpace = 4'd12;
			3'd4 : maxMoveableSpace = 4'd8;
			3'd5 : maxMoveableSpace = 4'd9;
			3'd6 : maxMoveableSpace = 4'd13;
			3'd7 : maxMoveableSpace = 4'd14;
		endcase
		
		// Collision Detection
		
		if (ActiveBullet & ((BulletPos_Y == DebrisY) | (BulletPos_Y == DebrisY + 1'b1))) begin
			case (WaveCounter)
				3'd0: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd2)) Hits[0] = 1'b1;
					else if (ActiveDebris[1] & (BulletPos_X >= DebrisX + 4'd4) & (BulletPos_X <= DebrisX + 4'd6)) Hits[1] = 1'b1; // Accounting the gaps 
					else if (ActiveDebris[2] & (BulletPos_X >= DebrisX + 4'd8) & (BulletPos_X <= DebrisX + 4'd10)) Hits[2] = 1'b1;
				end
				3'd1: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd2)) Hits[0] = 1'b1;
					else if (ActiveDebris[1] & (BulletPos_X >= DebrisX + 4'd4) & (BulletPos_X <= DebrisX + 4'd6)) Hits[1] = 1'b1; // Accounting the gaps 
					else if (ActiveDebris[2] & (BulletPos_X >= DebrisX + 4'd8) & (BulletPos_X <= DebrisX + 4'd10)) Hits[2] = 1'b1;
				end
				
				3'd2: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd1)) Hits[0] = 1'b1;
					else if (ActiveDebris[1] & (BulletPos_X >= DebrisX + 4'd4) & (BulletPos_X <= DebrisX + 4'd5)) Hits[1] = 1'b1; // Accounting the gaps 
					else if (ActiveDebris[2] & (BulletPos_X >= DebrisX + 4'd8) & (BulletPos_X <= DebrisX + 4'd9)) Hits[2] = 1'b1;
				end
					
				3'd3: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd3)) Hits[0] = 1'b1;	
				end
				3'd4: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd2)) Hits[0] = 1'b1;
					else if (ActiveDebris[1] & (BulletPos_X >= DebrisX + 4'd4) & (BulletPos_X <= DebrisX + 4'd6)) Hits[1] = 1'b1; // Accounting the gaps
				end
				3'd5: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd1)) Hits[0] = 1'b1;
					else if (ActiveDebris[1] & (BulletPos_X >= DebrisX + 4'd4) & (BulletPos_X <= DebrisX + 4'd6)) Hits[1] = 1'b1; // Accounting the gaps 
				end
				3'd6: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd2)) Hits[0] = 1'b1;
				end
				3'd7: begin
					if (ActiveDebris[0] & (BulletPos_X >= DebrisX) & (BulletPos_X <= DebrisX + 4'd1)) Hits[0] = 1'b1;
				end
			endcase
		end
	end

	assign Collision = (Hits != 3'b000); // Detects a collision to let the bullet know to despawn
					
	// Movement Logic for the Debris

	always_ff @(posedge Clk) begin
		if (Reset) begin
			DebrisX <= 4'd2;
			DebrisY <= 4'd0;
			ActiveDebris <= 3'b111;
			WaveCounter <= 3'd0;
			moving_left <= 1'b0;
			GameOver <= 1'b0;
			WinCondition <= 1'b0;
		end
		else begin
			// Hit register
			if (Hits[0]) ActiveDebris[0] <= 1'b0;
			else if (Hits[1]) ActiveDebris[1] <= 1'b0;
			else if (Hits[2]) ActiveDebris[2] <= 1'b0;
			
			// Movement and Wave Progression
			if (CurrentSpeed & !GameOver & !WinCondition) begin
				// Check for on-going waves
				if (ActiveDebris == 3'b000) begin
					if (WaveCounter == 3'd7) begin
						WinCondition <= 1'b1; // Yay you've won the game
					end
					else begin
						// Spawn Next Wave
						DebrisX <= 4'd2;
						DebrisY <= 4'd0;
						WaveCounter <= WaveCounter + 1'b1;
					if (WaveCounter == 3'd2) begin
						ActiveDebris <= 3'b001;
					end
					else if (WaveCounter == 3'd3) begin
						ActiveDebris <= 3'b011;
					end
					else if (WaveCounter == 3'd4) begin
						ActiveDebris <= 3'b011;
					end
					else if (WaveCounter == 3'd5) begin
						ActiveDebris <= 3'b001;
					end
					else if (WaveCounter == 3'd6) begin
						ActiveDebris <= 3'b001;
					end
					else begin
						ActiveDebris <= 3'b111;
					end
				end
			end
				else begin // If there are still active debris
					// Right Movement
					if (!moving_left) begin
						if (DebrisX == maxMoveableSpace) begin
							moving_left <= 1'b1;
							DebrisY <= DebrisY + 1'b1; // Debris travel down
						end
						else begin
							DebrisX <= DebrisX + 1'b1; // Move to the right
						end
					end
					// Left Movement
					else begin
						if (DebrisX == 4'd0) begin
							moving_left <= 1'b0;
							DebrisY <= DebrisY + 1'b1;
						end
						else begin
							DebrisX <= DebrisX - 1'b1; // Move to the left
						end
					end
				end
				
				// Lose Condition
				if ((DebrisY == 4'd12) & (ActiveDebris != 3'b000)) begin
					GameOver <= 1'b1;
				end
			end
		end
	end
endmodule		
			
module DebrisLogic_testbench();
	logic Clk, SlowEnable, MediumEnable, CurrentSpeed, Reset, ActiveBullet, GameOver, WinCondition, Collision;
	logic [3:0] BulletPos_X, BulletPos_Y, DebrisX, DebrisY;
	logic [2:0] ActiveDebris;
	logic [1:0] WaveCounter;
	logic [3:0] maxMoveableSpace;
	logic [2:0] Hits;
	logic moving_left;
	
	DebrisLogic dut (.*);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		Clk <= 0;
		forever #(CLOCK_PERIOD/2) Clk <= ~Clk; // Forever toggle the clock
	end
	
	initial begin
		 Reset <= 1;
		 SlowEnable <= 0;
		 MediumEnable <= 0;
		 BulletPos_X <= 4'd0;
		 BulletPos_Y <= 4'd0;
		 ActiveBullet <= 0;
		 
		 @(posedge Clk);
		 @(posedge Clk);
		 Reset <= 0;
		 @(posedge Clk);
		 
		 $display("Test: Moving Right"); @(posedge Clk);
		 SlowEnable <= 1; repeat (3) @(posedge Clk);
		 SlowEnable <= 0; @(posedge Clk);
		
		 $display("Test: Firing Bullet at Debris 0"); @(posedge Clk);
		 ActiveBullet <= 1; BulletPos_X <= DebrisX; BulletPos_Y <= DebrisY; @(posedge Clk);
		 
		 $display("Collision : %b, Active Debris : %b", Collision, ActiveDebris);
		 
		 ActiveBullet <= 0; @(posedge Clk);
		 $stop;
	end
endmodule
		 