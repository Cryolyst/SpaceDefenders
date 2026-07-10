onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DebrisLogic_testbench/Clk
add wave -noupdate /DebrisLogic_testbench/SlowEnable
add wave -noupdate /DebrisLogic_testbench/Reset
add wave -noupdate /DebrisLogic_testbench/ActiveBullet
add wave -noupdate /DebrisLogic_testbench/GameOver
add wave -noupdate /DebrisLogic_testbench/WinCondition
add wave -noupdate /DebrisLogic_testbench/Collision
add wave -noupdate /DebrisLogic_testbench/BulletPos_X
add wave -noupdate /DebrisLogic_testbench/BulletPos_Y
add wave -noupdate /DebrisLogic_testbench/DebrisX
add wave -noupdate /DebrisLogic_testbench/DebrisY
add wave -noupdate /DebrisLogic_testbench/ActiveDebris
add wave -noupdate /DebrisLogic_testbench/WaveCounter
add wave -noupdate /DebrisLogic_testbench/maxMoveableSpace
add wave -noupdate /DebrisLogic_testbench/Hits
add wave -noupdate /DebrisLogic_testbench/moving_left
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
