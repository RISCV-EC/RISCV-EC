----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 22:33:50
-- Design Name: 
-- Module Name: sum - Behavioral
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

entity sum is
    Port ( a,b : in STD_LOGIC_VECTOR (12 downto 0);
           dout : out STD_LOGIC_VECTOR (12 downto 0));
end sum;

architecture Behavioral of sum is

begin
dout<=std_logic_vector(signed(a)+signed(b));

end Behavioral;
