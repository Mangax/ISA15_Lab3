library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all;

entity WB_Stage is 
port(	pc4 : in std_logic_vector(63 downto 0);
		mux_memToReg : in std_logic_vector(1 downto 0);
		alu_result : in std_logic_vector(63 downto 0);
		immediate : in std_logic_vector(63 downto 0);
		mem_data : in std_logic_vector(63 downto 0);
		wb_data : out std_logic_vector(63 downto 0));
end WB_Stage;

architecture beh of WB_Stage is

component mux4to1
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		c : in std_logic_vector(63 downto 0);
		d : in std_logic_vector(63 downto 0);
		sel : in std_logic_vector(1 downto 0);
		mux_out : out std_logic_vector(63 downto 0));
END component;

begin 

mux : mux4to1 port map(alu_result, mem_data, pc4, immediate, mux_memToReg, wb_data);

end beh;