library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_prog_m is
end entity;

architecture sim of tb_prog_m is

    component prog_m
        port(
            a      : in  std_logic_vector(12 downto 0);
            funct7 : out std_logic_vector(6 downto 0);
            rs2    : out std_logic_vector(4 downto 0);
            rs1    : out std_logic_vector(4 downto 0);
            func3  : out std_logic_vector(2 downto 0);
            rd     : out std_logic_vector(4 downto 0);
            opcode : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Señales internas
    signal a      : std_logic_vector(12 downto 0) := (others => '0');
    signal funct7 : std_logic_vector(6 downto 0);
    signal rs2    : std_logic_vector(4 downto 0);
    signal rs1    : std_logic_vector(4 downto 0);
    signal func3  : std_logic_vector(2 downto 0);
    signal rd     : std_logic_vector(4 downto 0);
    signal opcode : std_logic_vector(6 downto 0);

begin

    UUT: prog_m
        port map(
            a      => a,
            funct7 => funct7,
            rs2    => rs2,
            rs1    => rs1,
            func3  => func3,
            rd     => rd,
            opcode => opcode
        );

    stim_proc : process
    begin
        ----------------------------------------------------------
        -- Instrucción 0: ADDI x1, x0, 5
        ----------------------------------------------------------
        a <= "0000000000000";  -- PC = 0
        wait for 20 ns;

        ----------------------------------------------------------
        -- Instrucción 1: ADDI x2, x0, 10
        ----------------------------------------------------------
        a <= "0000000000001";  -- PC = 1
        wait for 20 ns;

        ----------------------------------------------------------
        -- Instrucción 2: ADD x3, x1, x2
        ----------------------------------------------------------
        a <= "0000000000010";  -- PC = 2
        wait for 20 ns;

        ----------------------------------------------------------
        -- Instrucción no definida
        ----------------------------------------------------------
        a <= "0000000000011";  -- PC = 3
        wait for 20 ns;

        wait;
    end process;

end architecture;
