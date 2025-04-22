if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {../../bloco_soma_mult2.vhd}
vsim work.bloco_soma_mult2(ifsc_v1)

do wave_soma_mult.do

force -freeze sim:/bloco_soma_mult2/b_in 10#4 0
force -freeze sim:/bloco_soma_mult2/a_in 10#5 0
force -freeze sim:/bloco_soma_mult2/ctrl 00 0
run
force -freeze sim:/bloco_soma_mult2/ctrl 01 0
run
force -freeze sim:/bloco_soma_mult2/ctrl 10 0
run
force -freeze sim:/bloco_soma_mult2/ctrl 11 0
run
force -freeze sim:/bloco_soma_mult2/b_in 10#5 0
force -freeze sim:/bloco_soma_mult2/a_in 10#4 0
force -freeze sim:/bloco_soma_mult2/ctrl 00 0
run
force -freeze sim:/bloco_soma_mult2/ctrl 01 0
run
force -freeze sim:/bloco_soma_mult2/ctrl 10 0
run
force -freeze sim:/bloco_soma_mult2/ctrl 11 0
run
