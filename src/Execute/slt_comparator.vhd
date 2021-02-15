LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY slt_comparator IS
    PORT (
        s : IN STD_LOGIC;
        o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END slt_comparator;

-- It is used to compare together the two inputs: it takes in input the carry out of the subtractor and emits:
-- 0 if the carry is 1 (the first input is lower than the second one)
-- 1 if the carry is 0 (the first input is grater than the second one) 
ARCHITECTURE bhv OF slt_comparator IS
BEGIN
    o(63 downto 1) <= (others => '0');
	o(0) <= s;
END bhv;