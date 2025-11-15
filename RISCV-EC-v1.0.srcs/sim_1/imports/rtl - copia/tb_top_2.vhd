-- tb_top.vhd mejorado: muestra resultados por consola

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
end entity;

architecture sim of tb_top is
  signal clk         : std_logic := '0';
  signal clk_period  : time := 10 ns;

  signal reg1        : std_logic_vector(31 downto 0);
  signal reg2        : std_logic_vector(31 downto 0);
  signal PC          : std_logic_vector(12 downto 0);
  signal alu_out     : std_logic_vector(31 downto 0);

  component top
    port (
      clk      : in  std_logic;
      PC       : out std_logic_vector(12 downto 0);
      alu_out  : out std_logic_vector(31 downto 0);
      reg1     : out std_logic_vector(31 downto 0);
      reg2     : out std_logic_vector(31 downto 0)
    );
  end component;

begin
  dut: top
    port map (
      clk     => clk,
      PC      => PC,
      alu_out => alu_out,
      reg1    => reg1,
      reg2    => reg2
    );

  clk_process: process
  begin
    while now < 500 ns loop
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
      -- Reporte cada flanco de subida
      report "PC=" & integer'image(to_integer(unsigned(PC))) &
             " | reg2(rs1)=" & integer'image(to_integer(signed(reg2))) &
             " | reg1(rs2)=" & integer'image(to_integer(signed(reg1))) &
             " | ALU=" & integer'image(to_integer(signed(alu_out)));
    end loop;
    wait;
  end process;

end architecture;
