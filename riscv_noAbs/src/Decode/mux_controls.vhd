library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity mux_controls is
port(	a : in std_logic_vector(9 downto 0);
		b : in std_logic_vector(9 downto 0);
		sel : in std_logic;
		mux_out : out std_logic_vector(9 downto 0));
end mux_controls;

architecture beh of mux_controls is
begin

with sel select
	mux_out <= 	a when '0',
			b when '1',
			a when others;

end beh;