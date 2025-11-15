----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 23:44:31
-- Design Name: 
-- Module Name: unidor - Behavioral
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

entity unidor is
    Port ( a1 : in STD_LOGIC_VECTOR (6 downto 0);
           a2 : in STD_LOGIC_VECTOR (4 downto 0);
           sal : out STD_LOGIC_VECTOR (11 downto 0));
end unidor;

architecture Behavioral of unidor is

begin
sal<=a1&a2;

end Behavioral;
