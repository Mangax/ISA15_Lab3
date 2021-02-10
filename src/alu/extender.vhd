LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY extender IS
    PORT (
        s : IN STD_LOGIC;
        o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END extender;

ARCHITECTURE bhv OF extender IS
BEGIN
    o <= (others => not s);
END bhv;