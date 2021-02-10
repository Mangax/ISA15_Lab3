LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY schifoadder IS
    PORT (
        cin : IN STD_LOGIC;
        a, b : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        s : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END schifoadder;

ARCHITECTURE bhv OF schifoadder IS
BEGIN
    cout <= '0'; --error!! no carry reported
    s <= std_logic_vector(unsigned(a) + unsigned(b));
END bhv;