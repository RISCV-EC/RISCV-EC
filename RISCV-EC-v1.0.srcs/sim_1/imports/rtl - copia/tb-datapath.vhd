library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_datapath is
end entity;

architecture sim of tb_datapath is
    -- Componentes ---------------------------------------------------------
    component reg_b
        port (
            d1  : in  std_logic_vector(31 downto 0);
            a1, a2, ad : in std_logic_vector(4 downto 0);
            we, clk    : in std_logic;
            do1, do2   : out std_logic_vector(31 downto 0)
        );
    end component;

    component alu
        port(
            a1, a2  : in  std_logic_vector(31 downto 0);
            opcode  : in  std_logic_vector(3 downto 0);
            alu_sal : out std_logic_vector(31 downto 0)
        );
    end component;

    component mux2_1
        port(
            a, b   : in  std_logic_vector(31 downto 0);
            cont   : in  std_logic;
            sal    : out std_logic_vector(31 downto 0)
        );
    end component;

    component data_m
        port(
            di   : in  std_logic_vector(31 downto 0);
            a    : in  std_logic_vector(31 downto 0);
            we, clk : in  std_logic;
            dout : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Señales -------------------------------------------------------------
    signal clk : std_logic := '0';
    signal wer, wem, alu2reg : std_logic := '0';
    signal rs1, rs2, rd : std_logic_vector(4 downto 0) := (others => '0');

    --signal data_in, reg_out1, reg_out2, alu_out, mem_out, wb_data : std_logic_vector(31 downto 0);
    signal reg_out1, reg_out2, alu_out, mem_out, wb_data : std_logic_vector(31 downto 0);
    signal data_in : std_logic_vector(31 downto 0) := (others => '0');


    -- Señales de control manual
    signal alu_op : std_logic_vector(3 downto 0) := "0000";  -- ADD

begin
    -- Instancias ----------------------------------------------------------
    U_REG : reg_b
        port map(
            d1  => wb_data,
            a1  => rs1,
            a2  => rs2,
            ad  => rd,
            we  => wer,
            clk => clk,
            do1 => reg_out1,
            do2 => reg_out2
        );

    U_ALU : alu
        port map(
            a1 => reg_out1,
            a2 => reg_out2,
            opcode => alu_op,
            alu_sal => alu_out
        );

    U_MEM : data_m
        port map(
            di => reg_out2,
            a  => alu_out,
            we => wem,
            clk => clk,
            dout => mem_out
        );

    U_MUX : mux2_1
        port map(
            a => alu_out,
            b => mem_out,
            cont => alu2reg,
            sal => wb_data
        );

    -- Generador de reloj (permanente)
    clk_process : process
    begin
        while true loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
    end process;
    
    -- Estímulos
    stim_proc : process
    begin
        wait for 10 ns;  -- 🟢 deja que el reloj arranque
    
        -- Escribir r1 = 5
        wer <= '1';
        rd  <= "00001"; 
        wb_data <= x"00000005";
        wait until rising_edge(clk);
        wer <= '0';
        
        -- Leer r1 inmediatamente
        rs1 <= "00001";
        wait for 10 ns;
        
        -- Escribir r2 = 3
        wer <= '1';
        rd  <= "00010"; 
        wb_data <= x"00000003";
        wait until rising_edge(clk);
        wer <= '0';
        
        -- Leer r2 inmediatamente
        rs2 <= "00010";
        wait for 10 ns;
        
        -- Leer ambos (ya válido)
        rs1 <= "00001";
        rs2 <= "00010";

        
        wait for 10 ns;
    
        wait;
    end process;
        
end architecture;
