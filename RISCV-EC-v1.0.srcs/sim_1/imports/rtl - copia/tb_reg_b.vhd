library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reg_b is
end entity;

architecture sim of tb_reg_b is

    -- Componente bajo prueba (UUT)
    component reg_b
        port (
            d1  : in  std_logic_vector(31 downto 0);
            a1, a2, ad : in std_logic_vector(4 downto 0);
            we, clk : in std_logic;
            do1, do2 : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Señales internas
    signal clk  : std_logic := '0';
    signal we   : std_logic := '0';
    signal a1, a2, ad : std_logic_vector(4 downto 0) := (others => '0');
    signal d1, do1, do2 : std_logic_vector(31 downto 0) := (others => '0');

begin

    ----------------------------------------------------------------
    -- Instancia del módulo bajo prueba
    ----------------------------------------------------------------
    UUT : reg_b
        port map (
            d1  => d1,
            a1  => a1,
            a2  => a2,
            ad  => ad,
            we  => we,
            clk => clk,
            do1 => do1,
            do2 => do2
        );

    ----------------------------------------------------------------
    -- Generador de reloj (10 ns por ciclo)
    ----------------------------------------------------------------
    clk_process : process
    begin
        while true loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
    end process;

    ----------------------------------------------------------------
    -- Estímulos de prueba
    ----------------------------------------------------------------
    stim_proc : process
    begin
        ------------------------------------------------------------
        -- 1. Escribir r1 = 0xAAAA5555
        ------------------------------------------------------------
        we <= '1';
        ad <= "00001"; d1 <= x"AAAA5555";
        wait until rising_edge(clk);
        we <= '0';
        wait for 10 ns;

        ------------------------------------------------------------
        -- 2. Escribir r2 = 0x12345678
        ------------------------------------------------------------
        we <= '1';
        ad <= "00010"; d1 <= x"12345678";
        wait until rising_edge(clk);
        we <= '0';
        wait for 10 ns;

        ------------------------------------------------------------
        -- 3. Escribir r3 = 0x0000ABCD
        ------------------------------------------------------------
        we <= '1';
        ad <= "00011"; d1 <= x"0000ABCD";
        wait until rising_edge(clk);
        we <= '0';
        wait for 10 ns;

        ------------------------------------------------------------
        -- 4. Leer r1 y r2
        ------------------------------------------------------------
        a1 <= "00001";  -- r1
        a2 <= "00010";  -- r2
        wait for 20 ns;

        ------------------------------------------------------------
        -- 5. Leer r2 y r3
        ------------------------------------------------------------
        a1 <= "00010";  -- r2
        a2 <= "00011";  -- r3
        wait for 20 ns;

        ------------------------------------------------------------
        -- 6. Intentar escribir con we=0 (no debe cambiar)
        ------------------------------------------------------------
        we <= '0';
        ad <= "00001"; d1 <= x"FFFFFFFF";
        wait until rising_edge(clk);
        wait for 20 ns;

        wait;  -- fin de simulación
    end process;

end architecture;
