module tb_riscv ();

	wire clk_i;
	wire rst_n_i;
	wire [31 : 0] istr_i;
	wire [63 : 0] data_mem_i;
	wire [63 : 0] pc_i;
	wire [63 : 0] addr_mem_i;
	wire [63 : 0] write_data_i;
	wire mem_read_i;
	wire mem_write_i;
	
	clk_gen CG (
		.CLK(clk_i),
		.RST_n(rst_n_i)
	);
	
	RISCV UUT (
		.clk(clk_i),
		.rst_n(rst_n_i),
		.istruction(istr_i),
		.data_mem(data_mem_i),
		.pc(pc_i),
		.address(addr_mem_i),
		.write_data(write_data_i),
		.data_mem_read(mem_read_i),
		.data_mem_write(mem_write_i)
	);
	
	istruction_memory IM (
		.pc(pc_i),
		.istruction(istr_i)
	);
	
	data_memory DM (
		.address(addr_mem_i),
		.write_data(write_data_i),
		.mem_read(mem_read_i),
		.mem_write(mem_write_i),
		.data(data_mem_i)
	);
	
	endmodule