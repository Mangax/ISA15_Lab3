library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity EX_Stage is 
port( 
	ALU_OP : in std_logic_vector(2 downto 0);
	ALU_Src1 : in std_logic;
	ALU_Src2 : in std_logic;
	PC : in std_logic_vector(63 downto 0); 
	Data_Rs1 : in std_logic_vector(63 downto 0);
	Data_Rs2 : in std_logic_vector(63 downto 0);
	Forward_A_cmd : in std_logic_vector(1 downto 0);
	Forward_B_cmd : in std_logic_vector(1 downto 0);
	Immediate : in std_logic_vector(63 downto 0); 
	Extra_bit : in std_logic_vector(3 downto 0);
	Data_forward_MEM : in std_logic_vector(63 downto 0);
	Data_foward_WB : in std_logic_vector(63 downto 0); 
	ALU_Result : out std_logic_vector(63 downto 0)
	);
end entity;
	
architecture bhe of EX_Stage is 

-- COMPONENT definition -------------------------------------------

component alu IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        mux_out : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		b_inv : IN STD_LOGIC;
        res : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END component;

component ALU_CU is 
port (
	ALU_Op : in std_logic_vector(2 downto 0);
	funct3 : in std_logic_vector(2 downto 0);
	B_inv : out std_logic; 
	MUX_out : out std_logic_vector(2 downto 0));
	 
end component;

component mux3to1 is
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		c : in std_logic_vector(63 downto 0); 
		sel : in std_logic_vector(1 downto 0);
		mux_out : out std_logic_vector(63 downto 0));
end component;

component mux2to1 is
port(	a : in std_logic_vector(63 downto 0);
		b : in std_logic_vector(63 downto 0);
		sel : in std_logic;
		mux_out : out std_logic_vector(63 downto 0));
end component;

-- SIGNAL definition ----------------------------------------------
signal alu_cmd : std_logic_vector(2 downto 0);
signal alu_binv : std_logic;
signal alu_in_1, alu_in_2 : std_logic_vector(63 downto 0); 
signal mux2to1_in_1, mux2to1_in_2 : std_logic_vector(63 downto 0); 


begin 

ALU_CU_component : ALU_CU port map(ALU_OP, Extra_bit(2 downto 0), alu_binv, alu_cmd);
ALU_component : alu port map(alu_in_1, alu_in_2, alu_cmd, alu_binv, ALU_Result);
mux2to1_1 : mux2to1 port map(mux2to1_in_1, PC, ALU_Src1, alu_in_1);
mux2to1_2 : mux2to1 port map(mux2to1_in_2, Immediate, ALU_Src2, alu_in_2);
mux3_to1_1 : mux3to1 port map(Data_Rs1, Data_foward_WB, Data_forward_MEM, Forward_A_cmd, mux2to1_in_1);
mux3_to1_2 : mux3to1 port map(Data_Rs2, Data_foward_WB, Data_forward_MEM, Forward_B_cmd, mux2to1_in_2);

end bhe; 

