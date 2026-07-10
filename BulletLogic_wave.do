onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /BulletLogic_testbench/Clk
add wave -noupdate /BulletLogic_testbench/MediumEnable
add wave -noupdate /BulletLogic_testbench/Reset
add wave -noupdate /BulletLogic_testbench/Fire
add wave -noupdate /BulletLogic_testbench/Collision
add wave -noupdate /BulletLogic_testbench/ActiveBullet
add wave -noupdate /BulletLogic_testbench/TurretPosition
add wave -noupdate /BulletLogic_testbench/BulletPos_X
add wave -noupdate /BulletLogic_testbench/BulletPos_Y
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
