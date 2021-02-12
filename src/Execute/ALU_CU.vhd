library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity ALU_CU is 
port (
	ALU_Op : in std_logic_vector(2 downto 0);
	funct3 : in std_logic_vector(2 downto 0);
	B_inv : out std_logic; 
	MUX_out : out std_logic_vector(2 downto 0));
	 
end entity; 


architecture bhe of ALU_CU is
begin

ALU_decode: process(ALU_Op, funct3)
begin
case ALU_Op is 

	when "000" => 				-- R-type
		if funct3 = "000" then 		--  add
			B_inv <= '0';
			MUX_out <= "000";
 
		elsif funct3 = "100" then 	--  xor
			B_inv <= '0';
			MUX_out <= "010";
		elsif funct3 = "010" then	--  sub
			B_inv <= '1';
			MUX_out <= "001";
		else 
			B_inv <= 'X';
			MUX_out <= "XXX";
		end if;   

	when "001" =>				-- I-type (load) 
		if funct3 = "010" then 
			B_inv <= '0';
			MUX_out <= "000";

		else 
			B_inv <= 'X';
			MUX_out <= "XXX";
		end if; 

	when "010" => 				-- I-type
		if funct3 = "000" then 
			B_inv <= '0';
			MUX_out <= "000";
		elsif funct3 = "101" then -- shift
			B_inv <= '0';
			MUX_out <= "100";
		elsif funct3 = "111" then -- and
			B_inv <= '0';
			MUX_out <= "011";
		else 
			B_inv <= 'X';
			MUX_out <= "XXX";
		end if; 

	when "011" => 				-- S-type
		if funct3 = "010" then 
			B_inv <= '0';
			MUX_out <= "000";
		else 
			B_inv <= 'X';
			MUX_out <= "XXX";
		end if; 


	when "101" =>				-- U-type 
		B_inv <= '0';
		MUX_out <= "000";
		

	when others => 
		B_inv <= '0';
		MUX_out <= "000";

end case;
end process;
end bhe;