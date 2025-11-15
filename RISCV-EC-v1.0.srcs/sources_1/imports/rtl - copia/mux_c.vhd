----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 22:11:39
-- Design Name: 
-- Module Name: mux_c - Behavioral
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
-- arithmetic functions with Signed or Unsigned architecture
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_c is
    Port ( a : in STD_LOGIC_VECTOR (12 downto 0);
           c,en: in std_logic;
           sal : out STD_LOGIC_VECTOR (12 downto 0));
end mux_c;

architecture Behavioral of mux_c is
signal temp: std_logic_vector(12 downto 0):=(others=>'0');
begin
process(a,c,en)
begin
if (c ='1'and en ='1') then 
temp<=a; 
else 
temp<="0000000000001";

end if;

end process;
sal<=temp;
end Behavioral;
