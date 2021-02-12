LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu_tb IS 
END alu_tb;

ARCHITECTURE beh OF alu_tb IS
    
component alu is
PORT (
    a, b : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    mux_out : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	b_inv : IN STD_LOGIC;
    res : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
end component;

signal a,b : std_logic_vector(63 downto 0);
signal mux_ctrl : std_logic_vector(2 downto 0);
signal b_inv : std_logic;
signal result : std_logic_vector(63 downto 0);

begin

process
begin
	a <= std_logic_vector(to_unsigned(14, a'length));
	b <= std_logic_vector(to_unsigned(2, b'length));
	
	-- Addition
	mux_ctrl <= "000";
	b_inv <= '0';
	wait for 10 ns;
	
	-- XOR
	mux_ctrl <= "010";
	b_inv <= '0';
	wait for 10 ns;
	
	-- Slt
	mux_ctrl <= "001";
	b_inv <= '1';
	wait for 10 ns;
	
	-- Shift
	mux_ctrl <= "100";
	b_inv <= '0';
	wait for 10 ns;
	
	-- And
	mux_ctrl <= "011";
	b_inv <= '0';
	wait for 1 us;
end process;

comp: alu port map(a,b,mux_ctrl,b_inv,result);

end beh;