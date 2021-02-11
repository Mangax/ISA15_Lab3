LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder IS
    PORT (
        cin : IN STD_LOGIC;
        a, b : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        s : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
        cout : OUT STD_LOGIC);
END adder;

ARCHITECTURE bhv OF adder IS

signal sum : std_logic_vector(63 downto 0);
signal carry : std_logic_vector(63 downto 0);

BEGIN
	carry <= (63 downto 1 => '0') & cin;
    sum <= std_logic_vector(unsigned(a) + unsigned(b) + unsigned(carry));
	s <= sum;
	cout <= sum(63);
END bhv;