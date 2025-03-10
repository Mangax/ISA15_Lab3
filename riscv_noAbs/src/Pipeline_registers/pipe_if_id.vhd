library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity pipe_if_id is
port(	clk : in std_logic;
		rst_n : in std_logic;
		load : in std_logic;
		clear : in std_logic;
		in_pc : in std_logic_vector(63 downto 0);
		in_pc4 : in std_logic_vector(63 downto 0);
		in_istruction : in std_logic_vector(31 downto 0);
		out_pc : out std_logic_vector(63 downto 0);
		out_pc4 : out std_logic_vector(63 downto 0);
		out_istruction : out std_logic_vector(31 downto 0));
end pipe_if_id;

architecture beh of pipe_if_id is

component regN_load
generic(N : integer := 32);
port (	clk : IN std_logic;			-- clock
		rst_n : IN std_logic;
		load : in std_logic;
		clear : in std_logic;
		S_in : IN std_logic_vector (N - 1  downto 0);
		S_out : OUT std_logic_vector (N - 1 downto 0));
end component;

signal clear_int : std_logic := '0';

begin
	
process(clear)
begin
	if(clear = '1') then
		clear_int <= '1';
	else 
		clear_int <= '0';
	end if;
end process;

pc_reg : regN_load generic map(N => 64) port map(clk, rst_n, load, clear_int, in_pc, out_pc);
pc4_reg : regN_load generic map(N => 64) port map(clk, rst_n, load, clear_int, in_pc4, out_pc4);
istr_reg : regN_load generic map(N => 32) port map(clk, rst_n, load, clear_int, in_istruction, out_istruction);

end beh;