library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity pipe_id_ex is
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
end pipe_id_ex;

architecture beh of pipe_id_ex is

component reg
port (	clk : IN std_logic;			-- clock
		rst_n : IN std_logic;
		S_in : IN std_logic;
		S_out : OUT std_logic);
end component;

component regN
generic(N : integer := 32);
port (	clk : IN std_logic;			-- clock
		rst_n : IN std_logic;
		S_in : IN std_logic_vector (N - 1  downto 0);
		S_out : OUT std_logic_vector (N - 1 downto 0));
end component;

begin

pc4_reg : regN generic map(N => 64) port map(clk, rst_n, in_pc4, out_pc4);
mem_read_reg : reg port map(clk, rst_n, in_mem_read, out_mem_read);
mem_write_reg : reg port map(clk, rst_n, in_mem_write, out_mem_write);
mux_memToReg_reg : regN generic map(N => 2) port map(clk, rst_n, in_mux_memToReg, out_mux_memToReg);
aluOp_reg : regN generic map(N => 3) port map(clk, rst_n, in_aluOp, out_aluOp);
alu_src1_reg : reg port map(clk, rst_n, in_alu_src1, out_alu_src1);
alu_src2_reg : reg port map(clk, rst_n, in_alu_src2, out_alu_src2);
reg_write_reg : reg port map(clk, rst_n, in_reg_write, out_reg_write);
pc_reg : regN generic map(N => 64) port map(clk, rst_n, in_pc, out_pc);
rs1_reg : regN generic map(N => 64) port map(clk, rst_n, in_rs1, out_rs1);
rs2_reg : regN generic map(N => 64) port map(clk, rst_n, in_rs2, out_rs2);
add_rs1_reg : regN generic map(N => 4) port map(clk, rst_n, in_add_rs1, out_add_rs1);
add_rs2_reg : regN generic map(N => 4) port map(clk, rst_n, in_add_rs2, out_add_rs2);
immediate_reg : regN generic map(N => 64) port map(clk, rst_n, in_immediate, out_immediate);
rd_addr_reg : regN generic map(N => 5) port map(clk, rst_n, in_rd_addr, out_rd_addr);
extra_bit_reg : regN generic map(N => 4) port map(clk, rst_n, in_extra_bit, out_extra_bit);

end beh;