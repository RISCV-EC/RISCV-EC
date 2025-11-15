----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 17:56:10
-- Design Name: 
-- Module Name: mux32 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux32 is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
            c:in std_logic;
           sal : out STD_LOGIC_VECTOR (31 downto 0));
end mux32;

architecture Behavioral of mux32 is



signal temp: std_logic_vector(31 downto 0):=(others=>'0');
begin
process(a,c)
begin
if (c ='1') then 
temp<=a; 
else 
temp<="00000000000000000000000000000001";

end if;

end process;
sal<=temp;

end behavioral;

