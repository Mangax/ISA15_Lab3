library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity IF_Stage is
port(	clk : in std_logic;
		rst_n : in std_logic;
		pc_jump : in std_logic_vector(63 downto 0);
		mux_sel : in std_logic;
		pc_load : in std_logic;
		pc_out : out std_logic_vector(63 downto 0);
		pc4_out : out std_logic_vector(63 downto 0));
end IF_Stage;

architecture beh of IF_Stage is

component PC
port(	CLK : in std_logic; 
		RST_n : in std_logic; 
		Load : in std_logic;
		Input : in std_logic_vector(63 downto 0);
		Output : out std_logic_vector(63 downto 0));
end component;

component adder
    PORT (
        cin : IN STD_LOGIC;
        a, b : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        s : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
        cout : OUT STD_LOGIC);
end component;

component mux2to1
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		sel : in std_logic;
		mux_out : out std_logic_vector(63 downto 0));
end component;

signal mux_out, pc_tmp, pc_seq : std_logic_vector(63 downto 0);
signal plus4Bytes : std_logic_vector(63 downto 0);
signal cout : std_logic;

begin

plus4Bytes <= std_logic_vector(to_unsigned(4, plus4Bytes'length));

mux : mux2to1 port map(pc_seq, pc_jump, mux_sel, mux_out);
pc_reg : PC port map(clk, rst_n, pc_load, mux_out, pc_tmp);
add : adder port map('0', pc_tmp, plus4Bytes, pc_seq, cout);

pc_out <= pc_tmp;
pc4_out <= pc_seq;

end beh;
