library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity Hazard_Detection_Unit is 
port (
	Rs1_IF_ID_add : IN std_logic_vector(4 downto 0);
	Rs2_IF_ID_add : IN std_logic_vector(4 downto 0);
	Rd_ID_EX_add : IN std_logic_vector(4 downto 0);
	Mem_read : in std_logic; 
	IF_ID_load : out std_logic;
	PC_load : out std_logic; 
	NOP_mux : out std_logic
	); 
end entity; 

architecture bhe of Hazard_Detection_Unit is

begin

process(Rs1_IF_ID_add,Rs2_IF_ID_add,Rd_ID_EX_add,Mem_read)

begin
-- condizione per risolvere una dependecy di una istruzione dopo una Load dalla Data Memory,
-- aggiunge un ciclo di Stall
if (Mem_read = '1') then 
	if ((Rs1_IF_ID_add = Rd_ID_EX_add) or (Rs2_IF_ID_add = Rd_ID_EX_add)) then 
		IF_ID_load <= '0';
		PC_load <= '0'; 
		Nop_mux <= '0'; 
	else 
		IF_ID_load <= '1';
		PC_load <= '1'; 
		Nop_mux <= '1';
	end if;  
else 
	IF_ID_load <= '1';
	PC_load <= '1'; 
	Nop_mux <= '1';    
end if;

end process; 

end bhe;