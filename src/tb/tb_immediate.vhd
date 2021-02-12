library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_immediate is
end tb_immediate;

architecture bhe of tb_immediate is

component ImmediateGen 
	port(	A : IN std_logic_vector(31 downto 0);
		B : OUT std_logic_vector(63 downto 0));
end component;

signal tb_a : std_logic_vector(31 downto 0);
signal tb_b : std_logic_vector(63 downto 0);

begin

process
begin
tb_a <= "01101101011100101000111010010011"; -- I
wait 100 ns;
tb_a <= "01101101011100101000111010000011"; -- I load
wait 100 ns;
tb_a <= "01111110000011111000000011100011"; -- B
wait 100 ns;
tb_a <= "11111110000011111011000000100011"; -- S
wait 100 ns;
tb_a <= "11111111111111111111000000010111"; -- U aiupc
wait 100 ns;
tb_a <= "11111111111111111111000000110111"; -- U lui
wait 10000 ns;
end process;

gen: ImmediateGen port map(tb_a, tb_b);

end bhe;