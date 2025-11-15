library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity;

architecture sim of tb_alu is
    signal a1, a2, alu_sal : std_logic_vector(31 downto 0);
    signal opcode           : std_logic_vector(3 downto 0);
    signal zflag            : std_logic;

begin
    U_ALU : entity work.alu
        port map(
            a1 => a1,
            a2 => a2,
            opcode => opcode,
            alu_sal => alu_sal
        );

    U_SLICER : entity work.slicer
        port map(
            a => alu_sal,
            b => zflag
        );

    stim_proc : process
    begin
        -- Caso 1: ADD = 5 + 3
        a1 <= X"00000005"; a2 <= X"00000003";
        opcode <= "0000";  -- ADD
        wait for 20 ns;

        -- Caso 2: SUB = 5 - 3
        opcode <= "0001";  -- SUB
        wait for 20 ns;

        -- Caso 3: AND
        a1 <= X"0000F0F0"; a2 <= X"00000FF0";
        opcode <= "1110";
        wait for 20 ns;

        -- Caso 4: OR
        opcode <= "1100";
        wait for 20 ns;

        -- Caso 5: XOR
        opcode <= "1000";
        wait for 20 ns;

        -- Caso 6: SLT (set less than)
        a1 <= X"00000005"; a2 <= X"00000009";
        opcode <= "0100";
        wait for 20 ns;

        -- Caso 7: Comparación igualdad (zflag)
        a1 <= X"0000000A"; a2 <= X"0000000A";
        opcode <= "0111";  -- SUB
        wait for 20 ns;

        wait;
    end process;
end architecture;
