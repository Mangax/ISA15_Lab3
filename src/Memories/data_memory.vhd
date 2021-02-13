library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
USE ieee.std_logic_textio.all;
use std.textio.all;

entity data_memory is
port(	address : in std_logic_vector(63 downto 0);
		write_data : in std_logic_vector(63 downto 0);
		mem_read : in std_logic;
		mem_write : in std_logic;
		data : out std_logic_vector(63 downto 0));
end data_memory;

architecture beh of data_memory is

type mem_array is array(0 to 2**7 - 1) of std_logic_vector(63 downto 0);

-- We fill the first cells of the memory by reading the file containing the data of the program in binary form
-- Then we fill the exceeding cells with 0

impure function init_mem return mem_array is
file data_file : text;
variable file_line : line;
variable mem : mem_array;
variable data_tmp : std_logic_vector(31 downto 0);
variable index : integer := 0;

begin
	file_open(data_file, "../src/Memories/data.txt", read_mode);
	while not endfile(data_file) loop
		readline(data_file, file_line);
		read(file_line, data_tmp);
		mem(index)(31 downto 0) := data_tmp;
		mem(index)(63 downto 32) := (others => data_tmp(31));
		index := index + 1;
	end loop;
	file_close(data_file);
	for i in index to mem_array'high loop
		mem(i) := (others => '0');
	end loop;
	return mem;
end init_mem;

signal data_array : mem_array := init_mem;
signal limited_address : std_logic_vector(6 downto 0);

begin

-- The address is characterized by the first bits of the input
limited_address <= address(6 downto 0);

--mem_process : process(mem_read, mem_write)
--begin
	--if(mem_read = '1') then
		data <= data_array(to_integer(unsigned(limited_address)));
	--elsif(mem_write = '1') then
		--data_array(to_integer(unsigned(limited_address))) <= write_data;
	--end if;
--end process;

end beh;




