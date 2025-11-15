----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2022 20:26:01
-- Design Name: 
-- Module Name: CU - Behavioral
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

entity CU is
    Port ( opcode,func7 : in STD_LOGIC_VECTOR (6 downto 0);
           func3 : in STD_LOGIC_VECTOR (2 downto 0);
           wer,alu_scr,alu2reg,wem,imm_rd,ci_en,men : out STD_LOGIC;
           alu_op : out STD_LOGIC_VECTOR (3 downto 0));
end CU;

architecture Behavioral of CU is
signal opcode2: std_logic_vector(6 downto 0);
signal funct72: std_logic_vector(6 downto 0);
signal funct32: std_logic_vector(2 downto 0);
begin
process (opcode,func3,func7)
begin 
alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0';
imm_rd<='0';ci_en<='0';men<='0';
case opcode is -- case general 

-- operaciones tipo R 
when "0110011"=>
    case func3 is -- case func3 
    
    when "000"=> if func7="0100000" then alu_scr<='1';
    alu_op<="0001";alu2reg<='1';wem<='0';wer<='1';
    
    elsif func7="0000000" then alu_scr<='1';
    alu_op<="0000";alu2reg<='1';wem<='0';wer<='1';
    
    else
      
    alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0';--evadir latch
    end if; -- add, sub 
    
    when "001"=> alu_scr<='1';
    alu_op<="0010";alu2reg<='1';wem<='0';wer<='1'; --sll
    
    when "010" =>  alu_scr<='1';
    alu_op<="0100";alu2reg<='1';wem<='0';wer<='1';--slt
    
    when "011"=> alu_scr<='1';
    alu_op<="0110";alu2reg<='1';wem<='0';wer<='1';--sllu
    
    when "100" => alu_scr<='1';
    alu_op<="1000";alu2reg<='1';wem<='0';wer<='1';--xor
    
    when "101" => if func7 ="0100000" then  alu_scr<='1';
    alu_op<="1011";alu2reg<='1';wem<='0';wer<='1';--sra
    
    
    elsif func7="0000000" then alu_scr<='1';
    alu_op<="1010";alu2reg<='1';wem<='0';wer<='1';--srl
    
    else alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0';-- evadir latch
    end if;
    
    when "110" => alu_op<="1100"; wer<='1';alu_scr<='0';
    alu2reg<='0';wem<='0';-- or 
    
    when "111"=> alu_op<="1110"; wer<='1';alu_scr<='0';
    alu2reg<='0';wem<='0';-- and 
    
    when others =>
    end case;

when "0010011" =>

    case func3 is -- func3 para instrucciones tipo I (constante)
    when "000" => alu_op<="0000";alu2reg<='1'; wer<='1';--addi 
    when "010" => alu_op<="0100";alu2reg<='1'; wer<='1';--slti
    when "011" => alu_op<="0110";alu2reg<='1'; wer<='1';--sltiu  
    when "100" => alu_op<="1000";alu2reg<='1'; wer<='1';--xori
    when "110" => alu_op<="1100";alu2reg<='1'; wer<='1';--ori
    when "111" => alu_op<="1110";alu2reg<='1'; wer<='1';--andi
    when "001" => alu_op<="0010";alu2reg<='1'; wer<='1';--slli
    when "101" => if func7="0100000" then 
        alu_op<="1010";alu2reg<='1'; wer<='1';-- srai
        else 
        alu_op<="1011";alu2reg<='1'; wer<='1';-- srli
        
        end if; 
    when others => alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0';imm_rd<='0';men<='0'; 
    end case;
    when "0100011"=> --instrucciones de tipo s 
        case func3 is 
        when "000"=> alu_op<="0000";imm_rd<='1'; wem<='1';men<='1';--sb
        when "001"=> alu_op<="0000"; imm_rd<='1';wem<='1';men<='1';--sh
        when "010"=> alu_op<="0000"; imm_rd<='1';wem<='1';men<='1';--sw
        
        when others => alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0'; imm_rd<='0';men<='0';
        end case; 
    
    when "0000011" =>-- instucciones de tipo L 
        case func3 is 
        when "000" => alu_op<="0000";wer<='1';men<='1';
        when "001" => alu_op<="0000";wer<='1';men<='1';
        when "010" => alu_op<="0000";wer<='1';men<='1';
        when "100" => alu_op<="0000";wer<='1';men<='1';
        when "101" => alu_op<="0000";wer<='1';men<='1';
        
        when others => alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0'; imm_rd<='0';men<='0';
        end case; 
    when "1100011"=> --instrucciones de tipo B
        case func3 is 
        when "000"=>wer<='0';wem<='0';alu_scr<='1';alu_op<="1111";ci_en<='1';--beq
        
        
        
        when "100"=>wer<='0';wem<='0';alu_scr<='1';alu_op<="0100";ci_en<='1';--blt
        
        
        
        when "110"=> wer<='0';wem<='0';alu_scr<='1';alu_op<="0110";ci_en<='1';--bgtu
        
        
        
        when others => alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0'; imm_rd<='0';
        end case; 
    
    
    
    
when others => alu_op<="0000"; wer<='0';alu_scr<='0';alu2reg<='0';wem<='0'; imm_rd<='0';men<='0';

end case; 
end process;

end Behavioral;
