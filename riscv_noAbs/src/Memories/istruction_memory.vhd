library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
USE ieee.std_logic_textio.all;
use std.textio.all;

entity istruction_memory is
port(	pc : in std_logic_vector(63 downto 0);
		istruction : out std_logic_vector(31 downto 0));
end istruction_memory;

architecture beh of istruction_memory is

type mem_array is array(0 to 2**5 - 1) of std_logic_vector(31 downto 0);

-- We fill the first cells of the istruction memory by reading the file containing the istructions of the program in binary form
-- Then we fill the exceeding cells with NOPS (ADDI x0, x0, 0)

impure function init_mem return mem_array is
file istr_file : text;
variable file_line : line;
variable istr : mem_array;
variable index : integer := 0;

begin
	file_open(istr_file, "../src/Memories/istructions.txt", read_mode);
	while not endfile(istr_file) loop
		readline(istr_file, file_line);
		read(file_line, istr(index));
		index := index + 1;
	end loop;
	file_close(istr_file);
	for i in index to mem_array'high loop
		istr(i) := "00000000000000000000000000010011";
	end loop;
	return istr;
end init_mem;

signal istr_array : mem_array := init_mem;
signal address : std_logic_vector(4 downto 0);

begin

-- The address is characterized by the first bits of the pc
-- We divide th pc by 4 because the istruction has 4 Bytes
address <= pc(6 downto 2);

istruction <= istr_array(to_integer(unsigned(address)));

end beh;




