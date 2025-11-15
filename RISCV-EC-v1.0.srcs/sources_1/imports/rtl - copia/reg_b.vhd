----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2022 18:00:55
-- Design Name: 
-- Module Name: reg_b - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_b is
    Port ( d1 : in STD_LOGIC_VECTOR (31 downto 0);
           a1,a2,ad : in STD_LOGIC_VECTOR (4 downto 0);
           we,clk : in STD_LOGIC;
           do1,do2 : out STD_LOGIC_VECTOR (31 downto 0));
end reg_b;

architecture Behavioral of reg_b is
type ram_type is array(0 to 31) of std_logic_vector(31 downto 0);
signal temp: ram_type:=(x"00000000",x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",x"00000000",x"00000000"
,x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000");
begin
process(clk)
begin
if rising_edge(clk) then 
if (we='1') then 
temp(to_integer(unsigned(ad)))<= d1;
else 
end if;
end if;
end process;

do1<= temp(to_integer(unsigned(a1)));
do2<= temp(to_integer(unsigned(a2)));

end Behavioral;
