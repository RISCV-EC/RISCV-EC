library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port (
        a1, a2 : in STD_LOGIC_VECTOR (31 downto 0);
        opcode : in std_logic_vector(3 downto 0);
        alu_sal : out STD_LOGIC_VECTOR (31 downto 0)
    );
end alu;

architecture Behavioral of alu is
begin
    process(opcode, a1, a2)
        variable op1_u  : unsigned(31 downto 0);
        variable op2_u  : unsigned(31 downto 0);
        variable op1_s  : signed(31 downto 0);
        variable op2_s  : signed(31 downto 0);
    begin
        -- Conversiones necesarias
        op1_u := unsigned(a1);
        op2_u := unsigned(a2);
        op1_s := signed(a1);
        op2_s := signed(a2);

        case opcode is
            -- ADD
            when "0000" =>
                alu_sal <= std_logic_vector(op1_u + op2_u);

            -- SUB
            when "0001" =>
                alu_sal <= std_logic_vector(op1_u - op2_u);

            -- SLL (shift left logical)
            when "0010" =>
                alu_sal <= std_logic_vector(shift_left(op1_u, to_integer(op2_u)));

            -- SLT signed
            when "0100" =>
                if op1_s < op2_s then
                    alu_sal <= (31 downto 1 => '0') & '1';
                else
                    alu_sal <= (others => '0');
                end if;

            -- SLTU unsigned
            when "0110" =>
                if op1_u < op2_u then
                    alu_sal <= (31 downto 1 => '0') & '1';
                else
                    alu_sal <= (others => '0');
                end if;

            -- XOR
            when "1000" =>
                alu_sal <= a1 xor a2;

            -- SRL
            when "1010" =>
                alu_sal <= std_logic_vector(shift_right(op1_u, to_integer(op2_u)));

            -- SRA
            when "1011" =>
                alu_sal <= std_logic_vector(shift_right(op1_s, to_integer(op2_u)));

            -- OR
            when "1100" =>
                alu_sal <= a1 or a2;

            -- AND
            when "1110" =>
                alu_sal <= a1 and a2;

            -- EQ
            when "1111" =>
                if a1 = a2 then
                    alu_sal <= (31 downto 1 => '0') & '1';
                else
                    alu_sal <= (others => '0');
                end if;

            when others =>
                alu_sal <= (others => '0');
        end case;

    end process;
end Behavioral;
