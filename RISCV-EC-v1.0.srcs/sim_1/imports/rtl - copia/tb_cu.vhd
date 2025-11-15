library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_cu is
end entity;

architecture sim of tb_cu is
    component CU
        port (
            opcode  : in  std_logic_vector(6 downto 0);
            func7   : in  std_logic_vector(6 downto 0);
            func3   : in  std_logic_vector(2 downto 0);
            wer     : out std_logic;
            alu_scr : out std_logic;
            alu2reg : out std_logic;
            wem     : out std_logic;
            imm_rd  : out std_logic;
            ci_en   : out std_logic;
            men     : out std_logic;
            alu_op  : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Señales
    signal opcode  : std_logic_vector(6 downto 0);
    signal func7   : std_logic_vector(6 downto 0);
    signal func3   : std_logic_vector(2 downto 0);

    signal wer, alu_scr, alu2reg, wem, imm_rd, ci_en, men : std_logic;
    signal alu_op : std_logic_vector(3 downto 0);

begin
    U_CU : CU
        port map (
            opcode  => opcode,
            func7   => func7,
            func3   => func3,
            wer     => wer,
            alu_scr => alu_scr,
            alu2reg => alu2reg,
            wem     => wem,
            imm_rd  => imm_rd,
            ci_en   => ci_en,
            men     => men,
            alu_op  => alu_op
        );

    stim_proc : process
    begin
        ----------------------------------------------------------------
        -- Tipo R (ADD)
        ----------------------------------------------------------------
        opcode <= "0110011";  -- tipo R
        func3  <= "000";
        func7  <= "0000000";  -- ADD
        wait for 20 ns;

        ----------------------------------------------------------------
        -- Tipo R (SUB)
        ----------------------------------------------------------------
        func7  <= "0100000";  -- SUB
        wait for 20 ns;

        ----------------------------------------------------------------
        -- Tipo I (ADDI)
        ----------------------------------------------------------------
        opcode <= "0010011";
        func3  <= "000";
        func7  <= "0000000";
        wait for 20 ns;

        ----------------------------------------------------------------
        -- Tipo S (SW)
        ----------------------------------------------------------------
        opcode <= "0100011";
        func3  <= "010";
        func7  <= "0000000";
        wait for 20 ns;

        ----------------------------------------------------------------
        -- Tipo B (BEQ)
        ----------------------------------------------------------------
        opcode <= "1100011";
        func3  <= "000";
        func7  <= "0000000";
        wait for 20 ns;

        ----------------------------------------------------------------
        -- Tipo L (LW)
        ----------------------------------------------------------------
        opcode <= "0000011";
        func3  <= "010";
        func7  <= "0000000";
        wait for 20 ns;

        wait;
    end process;
end architecture;
