library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity mux4to1 is
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		c : in std_logic_vector(63 downto 0);
		d : in std_logic_vector(63 downto 0);
		sel : in std_logic_vector(1 downto 0);
		mux_out : out std_logic_vector(63 downto 0));
end mux4to1;

architecture beh of mux4to1 is
begin

with sel select
	mux_out <= 	a when "00",
			b when "01",
			c when "10",
			d when "11",
			a when others;

end beh;