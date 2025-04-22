if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {../../bin2bcd.vhd}
vcom -93 -work work {../../bcd2ssd.vhd}
vcom -93 -work work {../../bloco_soma_mult2.vhd}
vcom -93 -work work {../../top_level.vhd}
vsim work.top_level(ifsc_top)

do wave_top.do

force -freeze sim:/top_level/clk_top 1 0, 0 {50 ps} -r 100
force -freeze sim:/top_level/rst_top 1 0
force -freeze sim:/top_level/rst_top 1 0
force -freeze sim:/top_level/a_in_top 10#5 0
force -freeze sim:/top_level/b_in_top 10#4 0
force -freeze sim:/top_level/ctrl_top 00 0
run
force -freeze sim:/top_level/rst_top 0 0
run
run 1900
force -freeze sim:/top_level/ctrl_top 01 0
run 1900
force -freeze sim:/top_level/ctrl_top 10 0
run 1900
force -freeze sim:/top_level/ctrl_top 11 0
run 1900
force -freeze sim:/top_level/a_in_top 10#4 0
force -freeze sim:/top_level/b_in_top 10#5 0
force -freeze sim:/top_level/ctrl_top 00 0
run 1900
force -freeze sim:/top_level/ctrl_top 01 0
run 1900
force -freeze sim:/top_level/ctrl_top 10 0
run 1900
force -freeze sim:/top_level/ctrl_top 11 0
run 3800
run 1000
