library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity reg is
port (	clk : IN std_logic;			-- clock
		rst_n : IN std_logic;
		S_in : IN std_logic;
		S_out : OUT std_logic);
end reg;

architecture bhe of reg is 
begin
-- process for synchronous operation
process(CLK)
begin
	if (rst_n = '0') then
		s_out <= '0';
	elsif (rising_edge(CLK)) then	-- normal operation synchronous with clock
			S_out <= S_in; 
	end if; 
end process;

end bhe;  
