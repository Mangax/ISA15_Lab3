vlib work

vcom -93 -work ./work ../src/common/*.vhd
vcom -93 -work ./work ../src/Decode/*.vhd
vcom -93 -work ./work ../src/Execute/*.vhd
vcom -93 -work ./work ../src/Fetch/*.vhd
vcom -93 -work ./work ../src/Memories/*.vhd
vcom -93 -work ./work ../src/Pipeline_registers/*.vhd
vcom -93 -work ./work ../src/Special_units/*.vhd
vcom -93 -work ./work ../src/Stages/*.vhd
vcom -93 -work ./work ../src/RISCV.vhd
vcom -93 -work ./work ../tb/clk_gen.vhd
vlog -work ./work ../tb/tb_riscv.v

vsim work.tb_riscv

#add list -decimal clk -notrigger a b c cout sum

run 1.05 us

#write list counter.lst
#quit -f
