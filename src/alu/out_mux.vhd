LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY out_mux IS
    PORT (
        add, extend, xors, ands, shift : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
END out_mux;

ARCHITECTURE bhv OF out_mux IS
BEGIN
    WITH sel SELECT
        o <= add WHEN "000",
        extend WHEN "001",
        xors WHEN "010",
        ands WHEN "011",
        shift WHEN "100",
        (OTHERS => '0') WHEN OTHERS;
END bhv; -- bhv