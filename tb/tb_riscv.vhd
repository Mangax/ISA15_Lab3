library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity tb_riscv is
end tb_riscv;

architecture beh of tb_riscv is

component RISCV 
port(	clk : in std_logic;
		rst_n : in std_logic;
		istruction : in std_logic_vector(31 downto 0);
		data_mem : in std_logic_vector(63 downto 0);
		pc : out std_logic_vector(63 downto 0);
		address : out std_logic_vector(63 downto 0);
		write_data : out std_logic_vector(63 downto 0);
		data_mem_read : out std_logic;
		data_mem_write : out std_logic);
end component;

signal clock, reset, mem_read, mem_write : std_logic;
signal istr : std_logic_vector(31 downto 0);
signal data_read, data_write : std_logic_vector(63 downto 0);
signal add_istr_mem, add_data_mem : std_logic_vector(63 downto 0);

begin

clk_process : process
begin
clock <= '0';
wait for 10 ns;
clock <= '1';
wait for 10 ns;
end process;

rst_process : process
begin
reset <= '0';
wait for 3 ns;
reset <= '1';
wait for 2 us;
end process;

process
begin
-- load operation : load 15 in the reg5 of the rf
-- imm <= std_logic_vector(to_unsigned(3, imm'length));
-- rs1 <= std_logic_vector(to_unsigned(2, rs1'length));
-- rd <= std_logic_vector(to_unsigned(5, rd'length));
istr <= "00000000001100010010001010000011";
wait for 11 ns;
-- load operation : load 8 in the reg2 of the rf
-- imm <= std_logic_vector(to_unsigned(10, imm'length));
-- rs1 <= std_logic_vector(to_unsigned(6, rs1'length));
-- rd <= std_logic_vector(to_unsigned(2, rd'length));
istr <= "00000000101000110010000100000011";
wait for 20 ns;
-- load operation : load 10 in the reg4 of the rf
-- imm <= std_logic_vector(to_unsigned(1, imm'length));
-- rs1 <= std_logic_vector(to_unsigned(0, rs1'length));
-- rd <= std_logic_vector(to_unsigned(4, rd'length));
istr <= "00000000000100000010001000000011";
wait for 20 ns;
-- add operation : add reg5 and reg2 in reg12
-- rs2 <= std_logic_vector(to_unsigned(5, rs1'length));
-- rs1 <= std_logic_vector(to_unsigned(2, rs1'length));
-- rd <= std_logic_vector(to_unsigned(12, rd'length));
istr <= "00000000010100010000011000110011";
wait for 20 ns;
-- store word : store the content of reg5 in the cell pointed by reg2 + 5
-- imm(11:5) <= "0000000";
-- rs2 (data) <= "00101";
-- rs1 (base addr) <= "00010";
-- imm (4:0) <= "00101";
istr <= "00000000010100010010001010100011";
wait for 1 us;
end process;

 data_mem_process: process
begin
wait for 51 ns;
data_read <= std_logic_vector(to_unsigned(15, data_read'length));
wait for 20 ns;
data_read <= std_logic_vector(to_unsigned(8, data_read'length));
wait for 20 ns;
data_read <= std_logic_vector(to_unsigned(10, data_read'length));
wait for 1 us;
end process;

dut : riscv port map(clock, reset, istr, data_read, add_istr_mem, add_data_mem, data_write, mem_read, mem_write);

end beh;