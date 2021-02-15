library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity PC is 
port( 
	CLK : in std_logic; 
	RST_n : in std_logic; 
	Load : in std_logic;
	Input : in std_logic_vector(63 downto 0);
	Output : out std_logic_vector(63 downto 0)
	);
end entity; 

architecture bhe of PC is 

begin 

process(CLK,RST_n)

begin 	
	if (RST_n = '0') then 
		Output <= (others => '0');
		
	else 
		if (rising_edge(CLK)) then 

			if (Load = '1') then 
				Output <= Input; 
			end if;

		end if;
	end if; 

end process; 
end bhe; 
	 