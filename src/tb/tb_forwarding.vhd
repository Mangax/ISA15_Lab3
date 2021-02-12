library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_forwarding is
end tb_forwarding;

architecture beh of tb_forwarding is

component forwarding_unit
	port(	rs1 : IN std_logic_vector(4 downto 0);
			rs2 : IN std_logic_vector(4 downto 0);
			rd_exe : IN std_logic_vector(4 downto 0);
			rd_mem : IN std_logic_vector(4 downto 0);
			reg_write_exe : IN std_logic;
			reg_write_mem : IN std_logic;
			forward_a : OUT std_logic_vector(1 downto 0);
			forward_b : OUT std_logic_vector(1 downto 0));
end component;

signal s1,s2,d_exe,d_mem : std_logic_vector(4 downto 0);
signal w_exe,w_mem : std_logic;
signal fa,fb : std_logic_vector(1 downto 0);

begin

s1 <= "00000";
s2 <= "11111";

process
begin
d_exe <= "00001";
d_mem <= "00001";
w_exe <= '1';
w_mem <= '0';
wait for 100 ns;
d_exe <= "00000";
w_mem <= '1';
wait for 100 ns;
d_exe <= "11111";
d_mem <= "00000";
wait for 1 us;
end process;

comp: forwarding_unit port map(s1,s2,d_exe,d_mem,w_exe,w_mem,fa,fb);

end beh;