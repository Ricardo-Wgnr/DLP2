onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_level/clk_top
add wave -noupdate /top_level/rst_top
add wave -noupdate -radix unsigned /top_level/a_in_top
add wave -noupdate -radix unsigned /top_level/b_in_top
add wave -noupdate /top_level/ctrl_top
add wave -noupdate /top_level/SSD0
add wave -noupdate /top_level/SSD1
add wave -noupdate /top_level/SSD2
add wave -noupdate /top_level/SSD3
add wave -noupdate /top_level/SSD4
add wave -noupdate /top_level/SSD5
add wave -noupdate -radix unsigned /top_level/soma_mult_2_bin
add wave -noupdate -radix unsigned /top_level/r_out_top
add wave -noupdate /top_level/bcd0_2_ssd
add wave -noupdate /top_level/bcd1_2_ssd
add wave -noupdate /top_level/bcd2_2_ssd
add wave -noupdate /top_level/bcd3_2_ssd
add wave -noupdate /top_level/bcd4_2_ssd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {13866 ps}
