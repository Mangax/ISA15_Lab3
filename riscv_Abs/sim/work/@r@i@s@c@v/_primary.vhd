library verilog;
use verilog.vl_types.all;
entity RISCV is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        istruction      : in     vl_logic_vector(31 downto 0);
        data_mem        : in     vl_logic_vector(63 downto 0);
        pc              : out    vl_logic_vector(63 downto 0);
        address         : out    vl_logic_vector(63 downto 0);
        write_data      : out    vl_logic_vector(63 downto 0);
        data_mem_read   : out    vl_logic;
        data_mem_write  : out    vl_logic
    );
end RISCV;
