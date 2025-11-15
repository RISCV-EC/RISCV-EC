----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2022 17:07:58
-- Design Name: 
-- Module Name: p - Behavioral
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
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity btog is 
end btog;

architecture behavioral of btog is

signal din: unsigned(3 downto 0):= "1010";
signal llshift: unsigned(3 downto 0):= "0000";
signal lrshift: unsigned(3 downto 0):= "0000";
signal din2: signed(3 downto 0):= "1010";
signal alshift: signed(3 downto 0):="0000";
signal arshift: signed(3 downto 0):="0000";



begin 
llshift <= shift_left(din,1);
lrshift <= shift_right(din,1);


alshift <= shift_left(din2,1);
arshift <= shift_right(din2,1);


end behavioral;
