library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity RISCV is 
port(	clk : in std_logic;
		rst_n : in std_logic;
		istruction : in std_logic_vector(31 downto 0);
		data_mem : in std_logic_vector(63 downto 0);
		pc : out std_logic_vector(63 downto 0);
		address : out std_logic_vector(63 downto 0);
		write_data : out std_logic_vector(63 downto 0);
		data_mem_read : out std_logic;
		data_mem_write : out std_logic);
end RISCV;

architecture beh of RISCV is

-- Component definition
component IF_Stage
port(	clk : in std_logic;
		rst_n : in std_logic;
		pc_jump : in std_logic_vector(63 downto 0);
		mux_sel : in std_logic;
		pc_load : in std_logic;
		pc_out : out std_logic_vector(63 downto 0);
		pc4_out : out std_logic_vector(63 downto 0));
end component;

component pipe_if_id
port(	clk : in std_logic;
		rst_n : in std_logic;
		clear : in std_logic;
		load : in std_logic;
		in_pc : in std_logic_vector(63 downto 0);
		in_pc4 : in std_logic_vector(63 downto 0);
		in_istruction : in std_logic_vector(31 downto 0);
		out_pc : out std_logic_vector(63 downto 0);
		out_pc4 : out std_logic_vector(63 downto 0);
		out_istruction : out std_logic_vector(31 downto 0));
end component;

component ID_Stage
port(	clk : in std_logic;
		rst_n : in std_logic;
		pc_in : in std_logic_vector(63 downto 0);
		istruction : std_logic_vector(31 downto 0);
		nop_ctrl : in std_logic;
		add_rd_in : in std_logic_vector(4 downto 0);
		write_data : in std_logic_vector(63 downto 0);
		reg_write_in : in std_logic;
		pc_jump : out std_logic_vector(63 downto 0);
		pc_sel : out std_logic;
		mem_read : out std_logic;
		mem_write : out std_logic;
		mux_memToReg : out std_logic_vector(1 downto 0);
		aluOp : out std_logic_vector(2 downto 0);
		alu_src1 : out std_logic;
		alu_src2 : out std_logic;
		reg_write_out : out std_logic;
		rs1 : out std_logic_vector(63 downto 0);
		rs2 : out std_logic_vector(63 downto 0);
		rs1_add : out std_logic_vector(4 downto 0);
		rs2_add : out std_logic_vector(4 downto 0);
		immediate : out std_logic_vector(63 downto 0));
end component;

component pipe_id_ex
port(	clk : in std_logic;
		rst_n : in std_logic;
		in_pc4 : in std_logic_vector(63 downto 0);
		in_mem_read : in std_logic;
		in_mem_write : in std_logic;
		in_mux_memToReg : in std_logic_vector(1 downto 0);
		in_aluOp : in std_logic_vector(2 downto 0);
		in_alu_src1 : in std_logic;
		in_alu_src2 : in std_logic;
		in_reg_write : in std_logic;
		in_pc : in std_logic_vector(63 downto 0);
		in_rs1 : in std_logic_vector(63 downto 0);
		in_rs2 : in std_logic_vector(63 downto 0);
		in_add_rs1 : in std_logic_vector(4 downto 0);
		in_add_rs2 : in std_logic_vector(4 downto 0);
		in_immediate : in std_logic_vector(63 downto 0);
		in_rd_addr : in std_logic_vector(4 downto 0);
		in_extra_bit : in std_logic_vector(3 downto 0);
		out_pc4 : out std_logic_vector(63 downto 0);
		out_mem_read : out std_logic;
		out_mem_write : out std_logic;
		out_mux_memToReg : out std_logic_vector(1 downto 0);
		out_aluOp : out std_logic_vector(2 downto 0);
		out_alu_src1 : out std_logic;
		out_alu_src2 : out std_logic;
		out_reg_write : out std_logic;
		out_pc : out std_logic_vector(63 downto 0);
		out_rs1 : out std_logic_vector(63 downto 0);
		out_rs2 : out std_logic_vector(63 downto 0);
		out_add_rs1 : out std_logic_vector(4 downto 0);
		out_add_rs2 : out std_logic_vector(4 downto 0);
		out_immediate : out std_logic_vector(63 downto 0);
		out_rd_addr : out std_logic_vector(4 downto 0);
		out_extra_bit : out std_logic_vector(3 downto 0));
end component;

component EX_Stage
port( 
	ALU_OP : in std_logic_vector(2 downto 0);
	ALU_Src1 : in std_logic;
	ALU_Src2 : in std_logic;
	PC : in std_logic_vector(63 downto 0); 
	Data_Rs1 : in std_logic_vector(63 downto 0);
	Data_Rs2 : in std_logic_vector(63 downto 0);
	Forward_A_cmd : in std_logic_vector(1 downto 0);
	Forward_B_cmd : in std_logic_vector(1 downto 0);
	Immediate : in std_logic_vector(63 downto 0); 
	Extra_bit : in std_logic_vector(3 downto 0);
	Data_forward_MEM : in std_logic_vector(63 downto 0);
	Data_foward_WB : in std_logic_vector(63 downto 0); 
	ALU_Result : out std_logic_vector(63 downto 0)
	);
end component;
	
component pipe_ex_mem
port(	clk : in std_logic;
		rst_n : in std_logic;
		in_pc4 : in std_logic_vector(63 downto 0);
		in_mem_read : in std_logic;
		in_mem_write : in std_logic;
		in_mux_memToReg : in std_logic_vector(1 downto 0);
		in_reg_write : in std_logic;
		in_alu_result : in std_logic_vector(63 downto 0);
		in_rs2ToMem : in std_logic_vector(63 downto 0);
		in_immediate : in std_logic_vector(63 downto 0);
		in_rd_addr : in std_logic_vector(4 downto 0);
		out_pc4 : out std_logic_vector(63 downto 0);
		out_mem_read : out std_logic;
		out_mem_write : out std_logic;
		out_mux_memToReg : out std_logic_vector(1 downto 0);
		out_reg_write : out std_logic;
		out_alu_result : out std_logic_vector(63 downto 0);
		out_rs2ToMem : out std_logic_vector(63 downto 0);
		out_immediate : out std_logic_vector(63 downto 0);
		out_rd_addr : out std_logic_vector(4 downto 0));
end component;

component pipe_mem_wb
port(	clk : in std_logic;
		rst_n : in std_logic;
		in_pc4 : in std_logic_vector(63 downto 0);
		in_mux_memToReg : in std_logic_vector(1 downto 0);
		in_reg_write : in std_logic;
		in_alu_result : in std_logic_vector(63 downto 0);
		in_mem_data : in std_logic_vector(63 downto 0);
		in_immediate : in std_logic_vector(63 downto 0);
		in_rd_addr : in std_logic_vector(4 downto 0);
		out_pc4 : out std_logic_vector(63 downto 0);
		out_mux_memToReg : out std_logic_vector(1 downto 0);
		out_reg_write : out std_logic;
		out_alu_result : out std_logic_vector(63 downto 0);
		out_mem_data : out std_logic_vector(63 downto 0);
		out_immediate : out std_logic_vector(63 downto 0);
		out_rd_addr : out std_logic_vector(4 downto 0));
end component;

component WB_Stage
port(	pc4 : in std_logic_vector(63 downto 0);
		mux_memToReg : in std_logic_vector(1 downto 0);
		alu_result : in std_logic_vector(63 downto 0);
		immediate : in std_logic_vector(63 downto 0);
		mem_data : in std_logic_vector(63 downto 0);
		wb_data : out std_logic_vector(63 downto 0));
end component;

component Hazard_Detection_Unit
port (
	Rs1_IF_ID_add : IN std_logic_vector(4 downto 0);
	Rs2_IF_ID_add : IN std_logic_vector(4 downto 0);
	Rd_ID_EX_add : IN std_logic_vector(4 downto 0);
	Mem_read : in std_logic; 
	IF_ID_load : out std_logic;
	PC_load : out std_logic; 
	NOP_mux : out std_logic
	); 
end component;

component forwarding_unit
port(	rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd_exe : IN std_logic_vector(4 downto 0);
		rd_mem : IN std_logic_vector(4 downto 0);
		reg_write_exe : IN std_logic;
		reg_write_mem : IN std_logic;
		forward_a : OUT std_logic_vector(1 downto 0);
		forward_b : OUT std_logic_vector(1 downto 0));
end component;

-- Signal definition

-- Fetch
signal pc_if, pc4_if : std_logic_vector(63 downto 0);

-- Pipe IF/ID
signal pc_pipe_if, pc4_pipe_if : std_logic_vector(63 downto 0);
signal istruction_id : std_logic_vector(31 downto 0);

-- Decode
signal reg_write_tmp, pc_mux_sel : std_logic;
signal mem_read_id, mem_write_id, alu_src1_id, alu_src2_id, reg_write_id : std_logic;
signal mux_memToReg_id : std_logic_vector(1 downto 0);
signal aluOp_id : std_logic_vector(2 downto 0);
signal extra_bit_id : std_logic_vector(3 downto 0);
signal rs1_add_id, rs2_add_id : std_logic_vector(4 downto 0);
signal rs1_id, rs2_id, imm_id: std_logic_vector(63 downto 0);

-- Pipe ID/EX
signal mem_read_pipe_id, mem_write_pipe_id, alu_src1_pipe_id, alu_src2_pipe_id, reg_write_pipe_id : std_logic;
signal mux_memToReg_pipe_id : std_logic_vector(1 downto 0);
signal aluOp_pipe_id : std_logic_vector(2 downto 0);
signal pc_jump_tmp, pc4_pipe_id, pc_pipe_id : std_logic_vector(63 downto 0);
signal rs1_pipe_id, rs2_pipe_id, imm_pipe_id: std_logic_vector(63 downto 0);
signal add_rs1_pipe_id, add_rs2_pipe_id, add_rd_pipe_id : std_logic_vector(4 downto 0);
signal extra_bit_pipe_id : std_logic_vector(3 downto 0);

-- Execute
signal alu_result_ex :std_logic_vector(63 downto 0);

-- Pipe EX/Mem
signal mem_read_pipe_ex, mem_write_pipe_ex, alu_src1_pipe_ex, alu_src2_pipe_ex, reg_write_pipe_ex : std_logic;
signal mux_memToReg_pipe_ex : std_logic_vector(1 downto 0);
signal add_rd_pipe_ex : std_logic_vector(4 downto 0);
signal pc4_pipe_ex, alu_result_pipe_ex, rs2_pipe_ex, imm_pipe_ex : std_logic_vector(63 downto 0);

-- Pipe Mem/WB
signal reg_write_pipe_mem : std_logic;
signal mux_memToReg_pipe_mem : std_logic_vector(1 downto 0);
signal add_rd_pipe_mem : std_logic_vector(4 downto 0);
signal pc4_pipe_mem, alu_result_pipe_mem, mem_data_pipe_mem, imm_pipe_mem : std_logic_vector(63 downto 0);

-- Write back
signal write_data_rf : std_logic_vector(63 downto 0);

-- Hazard_Detection_Unit
signal load_tmp, pc_load_tmp, nop_tmp : std_logic;

-- Forwarding
signal forwardA, forwardB : std_logic_vector(1 downto 0);

begin

-- Port map

fetch : IF_Stage port map(clk, rst_n, pc_jump_tmp, pc_mux_sel, pc_load_tmp, pc_if, pc4_if);

pipeIF : pipe_if_id port map(clk, rst_n, pc_mux_sel, load_tmp, pc_if, pc4_if, istruction, pc_pipe_if, pc4_pipe_if, istruction_id);		

decode : ID_Stage port map(clk, rst_n, pc_pipe_if, istruction_id, nop_tmp, add_rd_pipe_mem, write_data_rf, 
reg_write_pipe_mem, pc_jump_tmp, pc_mux_sel, mem_read_id, mem_write_id, mux_memToReg_id, aluOp_id, alu_src1_id, alu_src2_id, reg_write_id, rs1_id, rs2_id, rs1_add_id, rs2_add_id, imm_id);

extra_bit_id <= (istruction_id(30) & istruction_id(14 downto 12));

pipeID : pipe_id_ex port map(clk, rst_n, pc4_pipe_if, mem_read_id, mem_write_id, mux_memToReg_id, aluOp_id, alu_src1_id,
alu_src2_id, reg_write_id, pc_pipe_if, rs1_id, rs2_id, istruction_id(19 downto 15), istruction_id(24 downto 20), imm_id, 
istruction_id(11 downto 7), extra_bit_id, pc4_pipe_id, mem_read_pipe_id, mem_write_pipe_id, mux_memToReg_pipe_id, aluOp_pipe_id, 
alu_src1_pipe_id, alu_src2_pipe_id, reg_write_pipe_id, pc_pipe_id, rs1_pipe_id, rs2_pipe_id, add_rs1_pipe_id, add_rs2_pipe_id, 
imm_pipe_id, add_rd_pipe_id, extra_bit_pipe_id);

execute : EX_Stage port map(aluOp_pipe_id, alu_src1_pipe_id, alu_src2_pipe_id, pc_pipe_id, rs1_pipe_id, rs2_pipe_id, forwardA,
forwardB, imm_pipe_id, extra_bit_pipe_id, alu_result_pipe_ex, write_data_rf, alu_result_ex);

pipeEX : pipe_ex_mem port map(clk, rst_n, pc4_pipe_id, mem_read_pipe_id, mem_write_pipe_id, mux_memToReg_pipe_id, reg_write_pipe_id,
alu_result_ex, rs2_pipe_id, imm_pipe_id, add_rd_pipe_id, pc4_pipe_ex, mem_read_pipe_ex, mem_write_pipe_ex, mux_memToReg_pipe_ex,
reg_write_pipe_ex, alu_result_pipe_ex, rs2_pipe_ex, imm_pipe_ex, add_rd_pipe_ex);

pc <= pc_if;
address <= alu_result_pipe_ex;
write_data <= rs2_pipe_ex;
data_mem_read <= mem_read_pipe_ex;
data_mem_write <= mem_write_pipe_ex;

pipeMEM : pipe_mem_wb port map(clk, rst_n, pc4_pipe_ex, mux_memToReg_pipe_ex, reg_write_pipe_ex, alu_result_pipe_ex, data_mem, imm_pipe_ex,
add_rd_pipe_ex, pc4_pipe_mem, mux_memToReg_pipe_mem, reg_write_pipe_mem, alu_result_pipe_mem, mem_data_pipe_mem, imm_pipe_mem, add_rd_pipe_mem);

write_back : WB_Stage port map(pc4_pipe_mem, mux_memToReg_pipe_mem, alu_result_pipe_mem, imm_pipe_mem, mem_data_pipe_mem, write_data_rf);

hazards : Hazard_Detection_Unit port map(istruction_id(19 downto 15), istruction_id(24 downto 20), add_rd_pipe_id, mem_read_pipe_id, load_tmp, 
pc_load_tmp, nop_tmp);

forwarding : forwarding_unit port map(add_rs1_pipe_id, add_rs2_pipe_id, add_rd_pipe_ex, add_rd_pipe_mem, reg_write_pipe_ex, reg_write_pipe_mem, forwardA, forwardB);

end beh;