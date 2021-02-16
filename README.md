# ISA15_Lab3
# GR15

Third practical activity of the course "Integrated System Architecture"

This laboratory was focused on the development of a RISCV-LITE processor with the following instruction set:

• arithmetic: add, addi, auipc, lui
• branches: beq
• loads: lw
• shifts: srai
• logical: andi, xor
• compare: slt
• jump and link: jal
• stores: sw

# FIRST PART
In the first part (directory "risc_noAbs) we implemented the standard processor architecture; the project is organized in the following direcotries:

- src: it contains the different source vhdl files divided in meaninful groups (division based on the stage in which each component will be used);
- tb: it contains the testbench files and some useful materials;
- sim: it contains the simulation files and the waveforms we got at the end of this step;
- syn: it contains the synthesys files and the reports about the timing and the area occupation;
- innovus: it contains the files related to the place and route phase.

# SECOND PART
We improve the efficiency of the processor by including in our project an "absolute value" special unit; this component is stored in the directory "riscv/src/execute" and allows us to take the absolute value of the input data.

We introduce a special instruction in the ISA to manage this operation and we proceed with the simulation.

The resulting files are organized in the same directory of the part one.