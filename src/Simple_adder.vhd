library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all;

entity adder is 
port(
	in1 : in std_logic_vector(63 downto 0); 
	in2 : in std_logic_vector(63 downto 0);
	out1 : out std_logic_vector(63 downto 0)
	);
end entity; 


architecture bhe of adder is 

begin 

process(in1,in2)

begin

out1 <= in1 + in2; 

end process;

end bhe; 
  