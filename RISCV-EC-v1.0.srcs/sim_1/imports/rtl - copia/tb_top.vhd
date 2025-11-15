-- Testbench básico para top.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top is
end tb_top;

architecture sim of tb_top is

    -- Componente a testear
    component top
        Port (
            clk     : in  STD_LOGIC;
            PC      : out STD_LOGIC_VECTOR (12 downto 0);
            alu_out : out STD_LOGIC_VECTOR (31 downto 0);
            reg1    : out STD_LOGIC_VECTOR (31 downto 0);
            reg2    : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    -- Señales internas
    signal clk     : STD_LOGIC := '0';
    signal PC      : STD_LOGIC_VECTOR (12 downto 0);
    signal alu_out : STD_LOGIC_VECTOR (31 downto 0);
    signal reg1    : STD_LOGIC_VECTOR (31 downto 0);
    signal reg2    : STD_LOGIC_VECTOR (31 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instanciación del DUT (Device Under Test)
    uut: top
        port map (
            clk     => clk,
            PC      => PC,
            alu_out => alu_out,
            reg1    => reg1,
            reg2    => reg2
        );

    -- Generador de reloj
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Proceso de monitoreo (observación de señales)
    monitor_proc : process
    begin
        wait for 20 ns; -- esperar que inicie
        for i in 0 to 50 loop -- 50 ciclos de reloj
            wait for clk_period;
            report "PC = " & integer'image(to_integer(unsigned(PC))) &
                   ", ALU_OUT = " & integer'image(to_integer(signed(alu_out)));
        end loop;
        wait;
    end process;

end sim;
