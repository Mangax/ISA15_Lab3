library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity CU is 
port (
	Opcode : in std_logic_vector(6 downto 0);
	Br_JAL : out std_logic;
	Br_BEQ : out std_logic;
	Mem_rd : out std_logic;
	Mem_wr : out std_logic; 
	MUX_memtoreg : out std_logic_vector(1 downto 0);
	ALU_op : out std_logic_vector(2 downto 0);
	ALU_src1 : out std_logic;
	ALU_src2 : out std_logic; 
	RF_wr : out std_logic); 
end entity; 

architecture bhe of CU is

begin

CU_decode: process(Opcode)
begin

case Opcode is 

	when "0110011" => Br_JAL <= '0'; 	-- add & xor & slt
		   Br_BEQ <= '0';
		   Mem_rd <= '0'; 
		   Mem_wr <= '0'; 
		   MUX_memtoreg <= "00";
		   ALU_op <= "000";
		   ALU_src1 <= '0';
		   ALU_src2 <= '0';
		   RF_wr <= '1';

	
	when "0000011" => Br_JAL <= '0'; 	-- lw
		   Br_BEQ <= '0';
		   Mem_rd <= '1'; 
		   Mem_wr <= '0'; 
		   MUX_memtoreg <= "01";
		   ALU_op <= "001";
		   ALU_src1 <= '0';
		   ALU_src2 <= '1';
		   RF_wr <= '1';

	when "0010011" => Br_JAL <= '0'; 	-- addi & srai & andi
		   Br_BEQ <= '0';
		   Mem_rd <= '0'; 
		   Mem_wr <= '0'; 
		   MUX_memtoreg <= "00";
		   ALU_op <= "010";
		   ALU_src1 <= '0';
		   ALU_src2 <= '1';
		   RF_wr <= '1';

	when "0100011" => Br_JAL <= '0'; 	-- sw
		   Br_BEQ <= '0';
		   Mem_rd <= '0'; 
		   Mem_wr <= '1'; 
		   MUX_memtoreg <= "00";
		   ALU_op <= "011";
		   ALU_src1 <= '0';
		   ALU_src2 <= '1';
		   RF_wr <= '0';

	when "1100111" => Br_JAL <= '0'; 	-- beq
		   Br_BEQ <= '1';
		   Mem_rd <= '0'; 
		   Mem_wr <= '0'; 
		   MUX_memtoreg <= "00";
		   ALU_op <= "100";
		   ALU_src1 <= '0';
		   ALU_src2 <= '0';
		   RF_wr <= '0';

	when "0110111" => Br_JAL <= '0'; 	-- lui
		   Br_BEQ <= '0';
		   Mem_rd <= '0'; 
		   Mem_wr <= '0'; 
		   MUX_memtoreg <= "11";
		   ALU_op <= "101";
		   ALU_src1 <= '0';
		   ALU_src2 <= '0';
		   RF_wr <= '1';

	when "1101111" => Br_JAL <= '1'; 	-- jal
		   Br_BEQ <= '0';
		   Mem_rd <= '0'; 
		   Mem_wr <= '0'; 
		   MUX_memtoreg <= "10";
		   ALU_op <= "110";
		   ALU_src1 <= '0';
		   ALU_src2 <= '0';
		   RF_wr <= '1';

	when "0010111" => Br_JAL <= '0'; 	-- auipc
		   Br_BEQ <= '0';
		   Mem_rd <= '0'; 
		   Mem_wr <= '0'; 
		   MUX_memtoreg <= "00";
		   ALU_op <= "101";
		   ALU_src1 <= '1';
		   ALU_src2 <= '1';
		   RF_wr <= '1';
	
	when others => Br_JAL <= 'X'; 
		       Br_BEQ <= 'X';
		       Mem_rd <= 'X'; 
		       Mem_wr <= 'X'; 
		       MUX_memtoreg <= "XX";
		       ALU_op <= "XXX";
		       ALU_src1 <= 'X';
		       ALU_src2 <= 'X';
		       RF_wr <= 'X';
end case; 
end process;
end bhe; 