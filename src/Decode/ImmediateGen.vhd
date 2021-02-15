library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ImmediateGen is
	port(	A : IN std_logic_vector(31 downto 0);
		B : OUT std_logic_vector(63 downto 0));
end ImmediateGen;

architecture beh of ImmediateGen is

signal immI,immS,immB,immJ,immU: std_logic_vector(63 downto 0);

begin

	immI <= (63 downto 12 => A(31)) & A(31 downto 20);
	immS <= (63 downto 12 => A(31)) & A(31 downto 25) & A(11 downto 7);
	immB <= (63 downto 12 => A(31)) & A(7) & A(30 downto 25) & A(11 downto 8) & '0';
	immJ <= (63 downto 20 => A(31)) & A(19 downto 12) & A(20) & A(30 downto 21) & '0';
	immU <= (63 downto 31 => A(31)) & A(30 downto 12) & (11 downto 0 => '0');
   
	with A(6 downto 0) select 
		B 	<=	immI when "0010011",
				immI when "0000011", -- load
				immS when "0100011",
				immB when "1100011",
				immJ when "1101111",
				immU when "0110111", -- lui
				immU when "0010111", -- auipc
				(others => '0') when others;
end beh;
