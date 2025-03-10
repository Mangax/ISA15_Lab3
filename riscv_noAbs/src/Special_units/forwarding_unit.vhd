library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwarding_unit is
	port(	rs1 : IN std_logic_vector(4 downto 0);
			rs2 : IN std_logic_vector(4 downto 0);
			rs1_beq : in std_logic_vector(4 downto 0);
			rs2_beq : in std_logic_vector(4 downto 0);
			rd_exe : IN std_logic_vector(4 downto 0);			
			rd_mem : IN std_logic_vector(4 downto 0);
			rd_beq : in std_logic_vector(4 downto 0);
			reg_write_exe : IN std_logic;
			reg_write_mem : IN std_logic;
			forward_a : OUT std_logic_vector(1 downto 0);
			forward_a_beq : out std_logic;
			forward_b : OUT std_logic_vector(1 downto 0);
			forward_b_beq : out std_logic);
end forwarding_unit;

architecture beh of forwarding_unit is

signal data_a, data_b : std_logic_vector(1 downto 0);
signal data_a_beq, data_b_beq : std_logic;

begin

process(rs1,rs2,rs1_beq,rs2_beq,rd_exe,rd_mem,rd_beq,reg_write_exe, reg_write_mem)
begin

-- Compare the source register 1 with the destination register out of the mem/wb and the ex/mem phases
-- We also check if the reg_write bit is high and if the destination is no the x0

if(rs1 = rd_mem and reg_write_mem = '1' and not(rd_mem = "00000")) then
	data_a <= "01"; -- Forwarding from the mem/wb pipeline register
elsif(rs1 = rd_exe and reg_write_exe = '1' and not(rd_exe = "00000")) then
	data_a <= "10"; -- Forwarding from the ex/mem pipeline register
else
	data_a <= "00"; -- No forwarding on the source register 1
end if;

-- Compare the source register 2 with the destination register out of the mem/wb and the ex/mem phases 

if(rs2 = rd_mem and reg_write_mem = '1' and not(rd_mem = "00000")) then
	data_b <= "01"; -- Forwarding from the mem/wb pipeline register
elsif(rs2 = rd_exe and reg_write_exe = '1' and not(rd_exe = "00000")) then
	data_b <= "10"; -- Forwarding from the ex/mem pipeline register
else
	data_b <= "00"; -- No forwarding on the source register 2
end if;

-- Compare the source 1 and 2 in input to the rf with the rd out of the ID/EXE pipe for forwarding with the beq

if(rs1_beq = rd_beq) then
	data_a_beq <= '1';
else
	data_a_beq <= '0';
end if;

if(rs2_beq = rd_beq) then
	data_b_beq <= '1';
else
	data_b_beq <= '0';
end if;
	
end process;

forward_a <= data_a;
forward_b <= data_b;
forward_a_beq <= data_a_beq;
forward_b_beq <= data_b_beq;

end beh;