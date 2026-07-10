onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MatrixRender_testbench/RedPixels
add wave -noupdate /MatrixRender_testbench/GrnPixels
add wave -noupdate /MatrixRender_testbench/TurretPosition
add wave -noupdate /MatrixRender_testbench/BulletPos_X
add wave -noupdate /MatrixRender_testbench/BulletPos_Y
add wave -noupdate /MatrixRender_testbench/DebrisX
add wave -noupdate /MatrixRender_testbench/DebrisY
add wave -noupdate /MatrixRender_testbench/ActiveDebris
add wave -noupdate /MatrixRender_testbench/WaveCounter
add wave -noupdate /MatrixRender_testbench/ActiveBullet
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {36 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {273 ps}
