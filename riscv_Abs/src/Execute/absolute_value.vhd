library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity absolute_value is 
port (	a : in std_logic_vector(63 downto 0);
		b : out std_logic_vector(63 downto 0));
end absolute_value;

architecture beh of absolute_value is

component mux2to1 is
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		sel : in std_logic;
		mux_out : out std_logic_vector(63 downto 0));
end component;

signal a_inv, a_comp : std_logic_vector(63 downto 0);

begin

a_inv <= not(a);
a_comp <= std_logic_vector(unsigned(a_inv) + to_unsigned(1,64));

mux : mux2to1 port map(a, a_comp, a(63), b);

end beh;