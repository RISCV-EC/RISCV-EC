----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2022 18:30:03
-- Design Name: 
-- Module Name: sign_e - Behavioral
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


entity sign_e is
  port ( data_in : in std_logic_vector(11 downto 0);
         data_out : out std_logic_vector(31 downto 0));
end sign_e;


architecture behavioral of sign_e is
begin
  
  data_out(11 downto 0) <= data_in;
  data_out(31 downto 12) <= (31 downto 12 => data_in(11));

end behavioral;