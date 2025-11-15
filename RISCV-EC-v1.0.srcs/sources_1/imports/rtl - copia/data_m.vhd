library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_m is
    Port (
        di  : in  std_logic_vector(31 downto 0);
        a   : in  std_logic_vector(31 downto 0);
        we  : in  std_logic;
        clk : in  std_logic;
        dout: out std_logic_vector(31 downto 0)
    );
end data_m;

architecture Behavioral of data_m is
    -- Memoria de 256 palabras de 32 bits
    type ram is array (0 to 255) of std_logic_vector(31 downto 0);
    signal temp : ram := (others => (others => '0'));
begin

    -- Escritura síncrona
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                temp(to_integer(unsigned(a(7 downto 0)))) <= di;
            end if;
        end if;
    end process;

    -- Lectura asíncrona
    dout <= temp(to_integer(unsigned(a(7 downto 0))));

end Behavioral;
