LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bmux IS
    PORT (
        b : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        sel : IN STD_LOGIC;
        o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END bmux;

ARCHITECTURE bhv OF bmux IS
BEGIN
    with sel select
    o <= b WHEN '0',
        NOT b WHEN '1',
        (OTHERS => '0') WHEN OTHERS;
END bhv;