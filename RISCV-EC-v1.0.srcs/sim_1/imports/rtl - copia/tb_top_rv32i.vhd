library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
end entity;

architecture sim of tb_top is

    -- Componente a probar
    component top
        port (
            clk     : in  std_logic;
            PC      : out std_logic_vector(12 downto 0);
            alu_out : out std_logic_vector(31 downto 0);
            reg1    : out std_logic_vector(31 downto 0);
            reg2    : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Señales TB
    signal clk_tb     : std_logic := '0';
    signal PC_tb      : std_logic_vector(12 downto 0);
    signal alu_out_tb : std_logic_vector(31 downto 0);
    signal reg1_tb    : std_logic_vector(31 downto 0);
    signal reg2_tb    : std_logic_vector(31 downto 0);

begin

    --------------------------------------------------------------------
    -- Instancia del procesador
    --------------------------------------------------------------------
    UUT : top
        port map (
            clk     => clk_tb,
            PC      => PC_tb,
            alu_out => alu_out_tb,
            reg1    => reg1_tb,
            reg2    => reg2_tb
        );

    --------------------------------------------------------------------
    -- Generador de reloj: 100 MHz (10 ns periodo)
    --------------------------------------------------------------------
    clk_process : process
    begin
        while true loop
            clk_tb <= '0'; wait for 5 ns;
            clk_tb <= '1'; wait for 5 ns;
        end loop;
    end process;

    --------------------------------------------------------------------
    -- Duración total de la simulación (tú puedes ajustarlo)
    --------------------------------------------------------------------
    end_sim : process
    begin
        wait for 200 ns;   -- ★ Cambia aquí si necesitas más tiempo
        wait;            -- Fin sin reportes
    end process;

end architecture;
