LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu_tb IS END alu_tb;

ARCHITECTURE tb OF alu_tb IS
    SIGNAL a, b, res : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ctrl : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    uut : ENTITY work.alu PORT MAP (a, b, ctrl, res);

    PROCESS IS
    BEGIN
        ctrl <= "1111";
        WAIT FOR 30 ns;
	
	-- test addition
        a <= STD_LOGIC_VECTOR(to_unsigned(0, a'length));
        b <= STD_LOGIC_VECTOR(to_unsigned(1, a'length));
	ctrl <= "0000";
        WAIT FOR 10 ns;

	-- test addition 2
        a <= STD_LOGIC_VECTOR(to_signed(0, a'length));
        b <= STD_LOGIC_VECTOR(to_signed(-1, a'length));
	ctrl <= "0000";
        WAIT FOR 10 ns;

	-- test addition 3
        a <= STD_LOGIC_VECTOR(to_signed(-1, a'length));
        b <= STD_LOGIC_VECTOR(to_signed(-1, a'length));
	ctrl <= "0000";
        WAIT FOR 10 ns;
	
	--todo: test ovf

	-- slt
        a <= STD_LOGIC_VECTOR(to_signed(135, a'length));
        b <= STD_LOGIC_VECTOR(to_signed(17, a'length));
	ctrl <= "1001";
        WAIT FOR 10 ns;
	-- slt 2
        a <= STD_LOGIC_VECTOR(to_signed(17, a'length));
        b <= STD_LOGIC_VECTOR(to_signed(135, a'length));
	ctrl <= "1001";
        WAIT FOR 10 ns;

        -- test and
        a <= STD_LOGIC_VECTOR(to_signed(8, a'length));
        b <= STD_LOGIC_VECTOR(to_signed(8, a'length));
	ctrl <= "0011";
        WAIT FOR 10 ns;

        -- test or
        a <= STD_LOGIC_VECTOR(to_signed(10, a'length));
        b <= STD_LOGIC_VECTOR(to_signed(4, a'length));
	ctrl <= "0010";
        WAIT FOR 10 ns;

        -- test shift
        a <= STD_LOGIC_VECTOR(to_signed(4096, a'length));
        b <= STD_LOGIC_VECTOR(to_signed(4, a'length));
	ctrl <= "0100";

        WAIT FOR 10 ns;
    END PROCESS;
END tb;