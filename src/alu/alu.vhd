LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        ctrl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        res : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END alu;

ARCHITECTURE rtl OF alu IS
    COMPONENT adder IS
        PORT (
           cin : IN STD_LOGIC;
           a, b : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
           s : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
           cout : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT bmux IS
        PORT (
            b : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
            sel : IN STD_LOGIC;
            o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
    END COMPONENT;

    COMPONENT extender IS
        PORT (
            s : IN STD_LOGIC;
            o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
    END COMPONENT;

    COMPONENT out_mux IS
        PORT (
            add, extend, xors, ands, shift : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
        );
    END COMPONENT;
 
    SIGNAL ovf : STD_LOGIC;
    SIGNAL b_muxed, adder_result, extended_sign, xor_result, and_result, shifter_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN
    bmux0 : bmux PORT MAP(b, ctrl(0), b_muxed);
    adder : schifoadder PORT MAP(ctrl(0), a, b_muxed, adder_result, ovf);
    extender0 : extender PORT MAP(adder_result(63), extended_sign);
    xor_result <= a XOR b;
    and_result <= a AND b;
    shifter_result <= STD_LOGIC_VECTOR(shift_right(signed(a), TO_INTEGER(signed(b))));
    outp : out_mux PORT MAP(adder_result, extended_sign, xor_result, and_result, shifter_result, ctrl(2 DOWNTO 0), res);

END rtl;