module MatrixRender(TurretPosition, RedPixels, GrnPixels, BulletPos_X, BulletPos_Y, ActiveBullet, ActiveDebris, WinCondition, WaveCounter, DebrisX, DebrisY, GameOver);
	input logic [3:0] TurretPosition, BulletPos_X, BulletPos_Y, DebrisX, DebrisY;
	input logic ActiveBullet, GameOver, WinCondition;
	input logic [2:0] ActiveDebris;
	input logic [2:0] WaveCounter;
	output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
   output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs
	
	always_comb begin
		RedPixels = 0;
		GrnPixels = 0;
	
		// Turret Render
		// Nose of the turret
		GrnPixels[14][TurretPosition] = 1'b1;
		// Body of the turret
		GrnPixels[15][TurretPosition] = 1'b1;
		GrnPixels[15][TurretPosition + 1] = 1'b1;
		GrnPixels[15][TurretPosition - 1] = 1'b1;
		
		// Bullet Render
		if (ActiveBullet) begin
			GrnPixels[BulletPos_Y] [BulletPos_X] = 1'b1;
		end
		
		// Defence line
		GrnPixels[13] = '1; 
		RedPixels[13] = '1;
		
		// Debris Render
		case (WaveCounter)
			3'd0: begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY][DebrisX + 2] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 2] = 1'b1;
				end
				if (ActiveDebris[1]) begin 			
					RedPixels[DebrisY][DebrisX + 4] = 1'b1;
					RedPixels[DebrisY][DebrisX + 5] = 1'b1;
					RedPixels[DebrisY][DebrisX + 6] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 4] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 5] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 6] = 1'b1;
				end
				if (ActiveDebris[2]) begin
					RedPixels[DebrisY][DebrisX + 8] = 1'b1;
					RedPixels[DebrisY][DebrisX + 9] = 1'b1;
					RedPixels[DebrisY][DebrisX + 10] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 8] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 9] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 10] = 1'b1;
				end
			end
			3'd1 : begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY][DebrisX + 2] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 2] = 1'b1;
				end
				if (ActiveDebris[1]) begin 
					RedPixels[DebrisY][DebrisX + 4] = 1'b1;
					RedPixels[DebrisY][DebrisX + 5] = 1'b1;
					RedPixels[DebrisY][DebrisX + 6] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 4] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 5] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 6] = 1'b1;
				end
				if (ActiveDebris[2]) begin
					RedPixels[DebrisY][DebrisX + 8] = 1'b1;
					RedPixels[DebrisY][DebrisX + 9] = 1'b1;
					RedPixels[DebrisY][DebrisX + 10] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 8] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 9] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 10] = 1'b1;
				end
			end
			3'd2: begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
				end
				if (ActiveDebris[1]) begin
					RedPixels[DebrisY][DebrisX + 4] = 1'b1;
					RedPixels[DebrisY][DebrisX + 5] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 4] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 5] = 1'b1;
				end
				if (ActiveDebris[2]) begin
					RedPixels[DebrisY][DebrisX + 8] = 1'b1;
					RedPixels[DebrisY][DebrisX + 9] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 8] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 9] = 1'b1;
				end
			end
			3'd3: begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY][DebrisX + 2] = 1'b1;
					RedPixels[DebrisY][DebrisX + 3] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 2] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 3] = 1'b1;
				end
			end
			3'd4: begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY][DebrisX + 2] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 2] = 1'b1;
				end
				if (ActiveDebris[1]) begin
					RedPixels[DebrisY][DebrisX + 5] = 1'b1;
					RedPixels[DebrisY][DebrisX + 6] = 1'b1;
					RedPixels[DebrisY][DebrisX + 7] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 5] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 6] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 7] = 1'b1;
				end
			end
			3'd5: begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
				end
				if (ActiveDebris[1]) begin
					RedPixels[DebrisY][DebrisX + 6] = 1'b1;
					RedPixels[DebrisY][DebrisX + 7] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 6] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 7] = 1'b1;
				end
			end
			3'd6: begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY][DebrisX + 2] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 2] = 1'b1;
				end
			end
			3'd7: begin
				if (ActiveDebris[0]) begin
					RedPixels[DebrisY][DebrisX] = 1'b1;
					RedPixels[DebrisY][DebrisX + 1] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX] = 1'b1;
					RedPixels[DebrisY + 1][DebrisX + 1] = 1'b1;
					
				end
			end
		endcase
		
		if (GameOver) begin // EXTRA IMPLEMENTATION
			RedPixels = 0;
			GrnPixels = 0;
			
			RedPixels[15] = 16'b1000000000000001;
			RedPixels[14] = 16'b0100000000000010;
			RedPixels[13] = 16'b0010000000000100;
			RedPixels[12] = 16'b0001000000001000;
			RedPixels[11] = 16'b0000100000010000;
			RedPixels[10] = 16'b0000010000100000;
			RedPixels[9]  = 16'b0000001001000000;
			RedPixels[8]  = 16'b0000000110000000;
			RedPixels[7]  = 16'b0000000110000000;
			RedPixels[6]  = 16'b0000001001000000;
			RedPixels[5]  = 16'b0000010000100000;
			RedPixels[4]  = 16'b0000100000010000;
			RedPixels[3]  = 16'b0001000000001000;
			RedPixels[2]  = 16'b0010000000000100;
			RedPixels[1]  = 16'b0100000000000010;
			RedPixels[0]  = 16'b1000000000000001;
		end
		
		if (WinCondition) begin
			RedPixels = 0;
			GrnPixels = 0;
			
			GrnPixels[0]  = 16'b0000000000000000; 
			GrnPixels[1]  = 16'b0000010000010000;
			GrnPixels[2]  = 16'b0000010010010000;
			GrnPixels[3]  = 16'b0000010101010000;
			GrnPixels[4]  = 16'b0000001000100000;
			GrnPixels[5]  = 16'b0000000000000000;
			GrnPixels[6]  = 16'b0000001111100000;
			GrnPixels[7]  = 16'b0000000010000000;
			GrnPixels[8]  = 16'b0000000010000000;
			GrnPixels[9]  = 16'b0000001111100000;
			GrnPixels[10] = 16'b0000000000000000;
			GrnPixels[11] = 16'b0000011000100000;
			GrnPixels[12] = 16'b0000010100100000;
			GrnPixels[13] = 16'b0000010010100000;
			GrnPixels[14] = 16'b0000010001100000;
			GrnPixels[15] = 16'b0000000000000000;
		end
			
	end
endmodule

module MatrixRender_testbench();
	logic [3:0] TurretPosition, BulletPos_X, BulletPos_Y,DebrisX, DebrisY;
	logic [2:0] ActiveDebris;
	logic [1:0] WaveCounter;
	logic [15:0][15:0] RedPixels, GrnPixels;
	logic ActiveBullet, GameOver, WinCondition;
	
	MatrixRender dut (.*);
	
	initial begin
		// Turret Test
		for (int i = 0; i < 13; i++) begin
			TurretPosition = i;
			#10;
		end
		
		// Bullet Test
		for (int i = 13; i > 0; i--) begin
			ActiveBullet = 1'b1;
			BulletPos_X = 4'd6; // Keep this constant
			BulletPos_Y = i;
			#10;
		end
		
		// Debris Test
		for (int i = 0; i < 5; i++) begin
			for (int j = 0; j < 10; j++) begin
				DebrisX = j;
				DebrisY = i;
				#10;
			end
		end
	end
endmodule
