library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all;

entity ID_Stage is 
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
end ID_Stage;

architecture beh of ID_Stage is

component adder
    PORT (
        cin : IN STD_LOGIC;
        a, b : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        s : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
        cout : OUT STD_LOGIC);
END component;

component Branch_check
port (
	data_rs1 : in std_logic_vector(63 downto 0); 
	data_rs2 : in std_logic_vector(63 downto 0); 
	Branch_JAL : in std_logic;
	Branch_BEQ : in std_logic;
	Branch_taken : out std_logic
	);
end component;

component CU
port (
	Opcode : in std_logic_vector(6 downto 0);
	Br_JAL : out std_logic;
	Br_BEQ : out std_logic;
	Mem_rd : out std_logic;
	Mem_wr : out std_logic; 
	MUX_memtoreg : out std_logic_vector(1 downto 0);
	ALU_op : out std_logic_vector(2 downto 0);
	ALU_src1 : out std_logic;
	ALU_src2 : out std_logic; 
	RF_wr : out std_logic); 
end component;

component ImmediateGen
	port(	A : IN std_logic_vector(31 downto 0);
		B : OUT std_logic_vector(63 downto 0));
end component;

component register_file
port(	clk : in std_logic;
	rst_n : in std_logic;
	add_rs1 : in std_logic_vector(4 downto 0);
	add_rs2 : in std_logic_vector(4 downto 0);
	add_rd : in std_logic_vector(4 downto 0);
	write_data : in std_logic_vector(63 downto 0);
	reg_write : in std_logic;
	data_rs1 : out std_logic_vector(63 downto 0);
	data_rs2 : out std_logic_vector(63 downto 0));
end  component;

component mux_controls
port(	a : in std_logic_vector(9 downto 0);
		b : in std_logic_vector(9 downto 0);
		sel : in std_logic;
		mux_out : out std_logic_vector(9 downto 0));
end component;

signal rs1_tmp,rs2_tmp,imm_tmp : std_logic_vector(63 downto 0);
signal mux_memToReg_tmp : std_logic_vector(1 downto 0);
signal aluOp_tmp : std_logic_vector(2 downto 0);
signal mem_read_tmp,mem_write_tmp : std_logic;
signal alu_src1_tmp,alu_src2_tmp,reg_write_out_tmp : std_logic;
signal control_string_in, control_string_out : std_logic_vector(9 downto 0);
signal branch_jal,branch_beq : std_logic;
signal eq : std_logic;

begin

rf : register_file port map(clk, rst_n, istruction(19 downto 15), istruction(24 downto 20), add_rd_in, write_data, reg_write_in, rs1_tmp, rs2_tmp);

imm : immediateGen port map(istruction(31 downto 0), imm_tmp);

control_unit : cu port map(istruction(6 downto 0), branch_jal, branch_beq, mem_read_tmp, mem_write_tmp,mux_memToReg_tmp, aluOp_tmp, alu_src1_tmp, alu_src2_tmp, reg_write_out_tmp);

control_string_in <= mem_read_tmp & mem_write_tmp & mux_memToReg_tmp & aluOp_tmp & alu_src1_tmp & alu_src2_tmp & reg_write_out_tmp;

ctrl_mux : mux_controls port map(control_string_in, "0000000000", nop_ctrl, control_string_out);

br_check : Branch_check port map(rs1_tmp, rs2_tmp, branch_jal, branch_beq, pc_sel);

addr : adder port map('0', pc_in, imm_tmp, pc_jump);


mem_read <= control_string_out(9);
mem_write <= control_string_out(8);
mux_memToReg <= control_string_out(7 downto 6);
aluOp <= control_string_out(5 downto 3);
alu_src1 <= control_string_out(2);
alu_src2 <= control_string_out(1);
reg_write_out <= control_string_out(0);
rs1 <= rs1_tmp;
rs2 <= rs2_tmp;
rs1_add <= istruction(19 downto 15);
rs2_add <= istruction(24 downto 20);
immediate <= imm_tmp;

end beh;