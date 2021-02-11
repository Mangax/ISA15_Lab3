LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        mux_out : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		b_inv : IN STD_LOGIC;
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

    COMPONENT slt_comparator IS
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
    bmux0 : bmux PORT MAP(b, b_inv, b_muxed);
    adder0 : adder PORT MAP(b_inv, a, b_muxed, adder_result, ovf);
    extender : slt_comparator PORT MAP(ovf, extended_sign);
    xor_result <= a XOR b;
    and_result <= a AND b;
    shifter_result <= STD_LOGIC_VECTOR(shift_right(signed(a), TO_INTEGER(signed(b))));
    outp : out_mux PORT MAP(adder_result, extended_sign, xor_result, and_result, shifter_result, mux_out, res);

END rtl;