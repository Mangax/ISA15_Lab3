library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity mux2to1 is
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		sel : in std_logic;
		mux_out : out std_logic_vector(63 downto 0));
end mux2to1;

architecture beh of mux2to1 is
begin

with sel select
	mux_out <= 	a when '0',
			b when '1',
			a when others;

end beh;