onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_test_top/test/run_n_times
add wave -noupdate /alu_test_top/test/temp
add wave -noupdate /alu_test_top/top_io/clock
add wave -noupdate /alu_test_top/top_io/reset
add wave -noupdate /alu_test_top/top_io/arith
add wave -noupdate /alu_test_top/top_io/shift
add wave -noupdate /alu_test_top/top_io/op
add wave -noupdate /alu_test_top/top_io/sel
add wave -noupdate /alu_test_top/top_io/data_1
add wave -noupdate /alu_test_top/top_io/data_2
add wave -noupdate /alu_test_top/top_io/data_out
add wave -noupdate /alu_test_top/test/flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0} {{Cursor 2} {5826000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {5826 ns}
