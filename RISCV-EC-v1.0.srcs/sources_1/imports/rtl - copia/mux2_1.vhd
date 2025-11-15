----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2022 18:17:51
-- Design Name: 
-- Module Name: mux2_1 - Behavioral
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

entity mux2_1 is
    Port ( a,b : in STD_LOGIC_VECTOR (31 downto 0);
           cont : in STD_LOGIC;
           sal : out STD_LOGIC_VECTOR (31 downto 0));
end mux2_1;

architecture Behavioral of mux2_1 is

begin
process(cont,a,b)
begin 
if (cont='1') then 
sal<=b;
else 
sal<=a; 
end if; 
end process;

end Behavioral;
