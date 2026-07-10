module Space_Defender(CLOCK_50, KEY, GPIO_1, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, sound_fire, sound_move);
	input logic CLOCK_50;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	output logic [35:0] GPIO_1;
	output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]  LEDR;
	
	// sounds
	output logic sound_fire, sound_move;
	
	// Turn off HEX displays
    assign HEX0 = '1;
    assign HEX1 = '1;
    assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
	
	assign Reset = SW[9];
	
	logic MedWire, SlowWire;
	
	logic [3:0] TurretPos_Wire;
	logic [3:0] BulletX_Wire, BulletY_Wire;
	logic ActiveBullet_Wire, Collision_Wire;
	logic [3:0] DebrisX_Wire, DebrisY_Wire;
	logic [2:0] ActiveDebris_Wire;
	logic [2:0] WaveCounter_Wire;
	logic GameOver_Wire, WinCondition_Wire;
	
	logic [15:0][15:0] RedPixels_Wire;
	logic [15:0][15:0] GrnPixels_Wire;
	
	// Firing button
	logic fire_pulse;
	UserInput FireButton (.Clk(CLOCK_50), .Reset(Reset), .KEY(~KEY[0]), .UserIn(fire_pulse));
	
	// Left | Right buttons
	logic left_pulse;
	UserInput LeftButton (.Clk(CLOCK_50), .Reset(Reset), .KEY(~KEY[2]), .UserIn(left_pulse));
	
	logic right_pulse;
	UserInput RightButton (.Clk(CLOCK_50), .Reset(Reset), .KEY(~KEY[1]), .UserIn(right_pulse));
	
	// Timer
	ClockDivider Timer(.Clk(CLOCK_50), .Reset(Reset), .MediumEnable(MedWire), .SlowEnable(SlowWire));
	
	// TURRET!!
	TurretMovement Turret (.Clk(CLOCK_50), .Reset(Reset), .L(left_pulse), .R(right_pulse), .Position(TurretPos_Wire));
	
	// Interceptor
	BulletLogic Interceptor (.Clk(CLOCK_50), .MediumEnable(MedWire), .Reset(Reset), .Fire(fire_pulse), .TurretPosition(TurretPos_Wire), 
	.BulletPos_X(BulletX_Wire), .BulletPos_Y(BulletY_Wire), .ActiveBullet(ActiveBullet_Wire), .Collision(Collision_Wire));
	
	// Debris
	DebrisLogic Debris (.Clk(CLOCK_50), .SlowEnable(SlowWire), .MediumEnable(MedWire), .Reset(Reset), .ActiveBullet(ActiveBullet_Wire), 
	.DebrisX(DebrisX_Wire), .DebrisY(DebrisY_Wire), .BulletPos_X(BulletX_Wire), .BulletPos_Y(BulletY_Wire),
	.ActiveDebris(ActiveDebris_Wire), .GameOver(GameOver_Wire), .WinCondition(WinCondition_Wire), .WaveCounter(WaveCounter_Wire), .Collision(Collision_Wire));
	
	// Matrix Render
	MatrixRender Render (.TurretPosition(TurretPos_Wire), .RedPixels(RedPixels_Wire), .GrnPixels(GrnPixels_Wire), 
	.BulletPos_X(BulletX_Wire), .BulletPos_Y(BulletY_Wire), .ActiveBullet(ActiveBullet_Wire), 
	.ActiveDebris(ActiveDebris_Wire), .WaveCounter(WaveCounter_Wire), .DebrisX(DebrisX_Wire), .DebrisY(DebrisY_Wire), .GameOver(GameOver_Wire), .WinCondition(WinCondition_Wire));
	
	// LEDs
	LEDDriver #(.FREQDIV(15)) Driver (.CLK(CLOCK_50), .RST(Reset), .EnableCount(1'b1), .RedPixels(RedPixels_Wire), .GrnPixels(GrnPixels_Wire), .GPIO_1(GPIO_1));
	
	// Extra Implemantation Sound
	assign sound_fire = ~KEY[0];
	assign sound_move = ~KEY[2] | ~KEY[1];

endmodule

module Space_Defender_testbench();
	logic CLOCK_50;
	logic [9:0] SW;
	logic [3:0] KEY;
	logic sound_fire, sound_move;
	
	Space_Defender dut (.CLOCK_50(CLOCK_50), .SW(SW), .KEY(KEY), .sound_fire(sound_fire), .sound_move(sound_move));
	
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	initial begin
		SW <= 10'b0000000001; @(posedge CLOCK_50);
		SW <= 10'b0000000000; @(posedge CLOCK_50);
		
		KEY <= 4'b0001; repeat(3) @(posedge CLOCK_50);
		KEY <= 4'b0100; repeat(3) @(posedge CLOCK_50);
		KEY <= 4'b0010; repeat(3) @(posedge CLOCK_50);
		KEY <= 4'b0101; repeat(3) @(posedge CLOCK_50);
		
		$stop;
		
	end
endmodule
	