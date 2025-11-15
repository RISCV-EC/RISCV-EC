library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cont is
    Port ( clk    : in STD_LOGIC;
           rst    : in STD_LOGIC;
           ci_en  : in STD_LOGIC;
           sal    : out STD_LOGIC_VECTOR (12 DOWNTO 0));
end cont;

architecture Behavioral of cont is
    signal temp: unsigned(12 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst = '1' then
            temp <= (others => '0');
        elsif rising_edge(clk) then
            if ci_en = '1' then
                temp <= temp + 1;
            end if;
        end if;
    end process;

    sal <= std_logic_vector(temp);
end Behavioral;
