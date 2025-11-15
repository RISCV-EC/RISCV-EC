----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 22:11:39
-- Design Name: 
-- Module Name: sign_oe - Behavioral
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

entity sign_oe is
    Port ( i1 : in STD_LOGIC_VECTOR (6 downto 0);
           i2 : in STD_LOGIC_VECTOR (4 downto 0);
           sal : out STD_LOGIC_VECTOR (12 downto 0)
           );
end sign_oe;

architecture Behavioral of sign_oe is
signal temp: std_logic_vector(12 downto 0);
begin
temp(12)<=i1(6);
temp(10 downto 5)<=i1(5 downto 0);
temp(11)<= i2(0);
temp(4 downto 1)<=i2(4 downto 1);
temp(0)<='0';

sal<=temp;

end Behavioral;
