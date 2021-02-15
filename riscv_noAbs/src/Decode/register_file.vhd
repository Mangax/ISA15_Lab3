library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity register_file is 
port(	clk : in std_logic;
	rst_n : in std_logic;
	add_rs1 : in std_logic_vector(4 downto 0);
	add_rs2 : in std_logic_vector(4 downto 0);
	add_rd : in std_logic_vector(4 downto 0);
	write_data : in std_logic_vector(63 downto 0);
	reg_write : in std_logic;
	data_rs1 : out std_logic_vector(63 downto 0);
	data_rs2 : out std_logic_vector(63 downto 0));
end register_file;

architecture beh of register_file is

component mux2to1
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		sel : in std_logic;
		mux_out : out std_logic_vector(63 downto 0));
end component;

signal zeros : std_logic_vector(63 downto 0);
signal data_rs1_int, data_rs2_int : std_logic_vector(63 downto 0);

-- The register file should be able to perform two read operation and a write operation in the same time
-- The read is always performed, the write is managed by the reg_write bit

-- We use 32 register of 64 bits

type register_array is array(0 to 2**5 - 1) of std_logic_vector(63 downto 0);
signal rf : register_array;

begin

zeros <= (others => '0');

process(clk ,rst_n)
begin
	if(rst_n = '0') then
		for i in 0 to 2**5 - 1 loop
			rf(i) <= (others => '0');
		end loop;
	elsif(reg_write = '1' and falling_edge(clk)) then
		rf(to_integer(unsigned(add_rd))) <= write_data;
	end if;	
end process;

data_rs1_int <= rf(to_integer(unsigned(add_rs1)));
data_rs2_int <= rf(to_integer(unsigned(add_rs2)));

mux_rs1 : mux2to1 port map(data_rs1_int, zeros, clk, data_rs1);
mux_rs2 : mux2to1 port map(data_rs2_int, zeros, clk, data_rs2);

end beh;
