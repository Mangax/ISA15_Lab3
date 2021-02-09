library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all;

entity Branch_check is 
port (
	data_rs1 : in std_logic_vector(4 downto 0); 
	data_rs2 : in std_logic_vector(4 downto 0); 
	Branch_JAL : in std_logic;
	Branch_BEQ : in std_logic;
	Branch_taken : out std_logic
	);
end entity;

architecture bhe of Branch_check is 

signal cmp,beq_t : std_logic;

begin 

process(data_rs1,data_rs2,Branch_JAL,Branch_BEQ) 

begin 
	
if (data_rs1 = data_rs2) then 
	cmp <= '1'; 
else 
	cmp <= '0'; 
end if; 

beq_t <= cmp and Branch_BEQ; 

Branch_taken <= beq_t or Branch_JAL; 
	
	
end process;
end bhe; 

	
