library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity prog_m is
    Port (
        a      : in  STD_LOGIC_VECTOR (12 downto 0);
        funct7 : out STD_LOGIC_VECTOR (6 downto 0);
        rs2    : out STD_LOGIC_VECTOR (4 downto 0);
        rs1    : out STD_LOGIC_VECTOR (4 downto 0);
        func3  : out STD_LOGIC_VECTOR (2 downto 0);
        rd     : out STD_LOGIC_VECTOR (4 downto 0);
        opcode : out STD_LOGIC_VECTOR (6 downto 0)
    );
end prog_m;

architecture Behavioral of prog_m is

    type ram is array(0 to 31) of std_logic_vector(31 downto 0);

    -- 🔥 INICIALIZACIÓN COMPLETA (sin UUUU)
    signal temp : ram := (

        -- 0: ADDI x1, x0, 5   → x1 = 5
        0 => "00000000101000000000000100010011",
        --0 => "00000000010100000000000010010011",

        -- 1: ADDI x2, x0, 10  → x2 = 10
        1 => "00000000101000000000000100010011",

        -- 2: ADD x3, x1, x2   → x3 = 15
        2 => "00000000001000001000000110110011",

        -- 3: SW x3, 0(x0)     → MEM[0] = x3
        3 => "00000000001100000010000000100011",

        -- 4: LW x4, 0(x0)     → x4 = MEM[0]
        4 => "00000000000000000010001010000011",

        -- 5: SUB x5, x4, x2   → x5 = x4 - x2
        5 => "01000000001000100000001000110011",

        -- 6: BEQ x5, x1, +2   → si x5 == x1, saltar 2 instrucciones
        6 => "00000000010100101000001001100011",

        -- 7: ADDI x6, x0, 0   → NOP (solo si NO hubo salto)
        7 => "00000000000000000000001100010011",

        -- 8: ADDI x6, x0, 1   → x6 = 1 (solo si hubO salto)
        8 => "00000000000100000000001100010011",

        -- Resto de memoria llena con ceros
        9  => (others => '0'),
        10 => (others => '0'),
        11 => (others => '0'),
        12 => (others => '0'),
        13 => (others => '0'),
        14 => (others => '0'),
        15 => (others => '0'),
        16 => (others => '0'),
        17 => (others => '0'),
        18 => (others => '0'),
        19 => (others => '0'),
        20 => (others => '0'),
        21 => (others => '0'),
        22 => (others => '0'),
        23 => (others => '0'),
        24 => (others => '0'),
        25 => (others => '0'),
        26 => (others => '0'),
        27 => (others => '0'),
        28 => (others => '0'),
        29 => (others => '0'),
        30 => (others => '0'),
        31 => (others => '0')
    );

    signal instr : std_logic_vector(31 downto 0);

begin

    instr <= temp(to_integer(unsigned(a)));

    funct7 <= instr(31 downto 25);
    rs2    <= instr(24 downto 20);
    rs1    <= instr(19 downto 15);
    func3  <= instr(14 downto 12);
    rd     <= instr(11 downto 7);
    opcode <= instr(6 downto 0);

end Behavioral;
