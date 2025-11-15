library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk      : in  STD_LOGIC;
        PC       : out STD_LOGIC_VECTOR (12 downto 0);
        alu_out  : out STD_LOGIC_VECTOR (31 downto 0);
        reg1     : out STD_LOGIC_VECTOR (31 downto 0);
        reg2     : out STD_LOGIC_VECTOR (31 downto 0)
    );
end top;

architecture Structural of top is

    -- Señales internas
    signal opcode, func7 : STD_LOGIC_VECTOR (6 downto 0);
    signal func3         : STD_LOGIC_VECTOR (2 downto 0);
    signal rs1, rs2, rd  : STD_LOGIC_VECTOR (4 downto 0);
    signal imm_12        : STD_LOGIC_VECTOR (11 downto 0);
    signal imm_13        : STD_LOGIC_VECTOR (12 downto 0);
    signal ext_imm       : STD_LOGIC_VECTOR (31 downto 0);

    signal a1_mux, a2_mux, alu_result, mem_out, write_data : STD_LOGIC_VECTOR (31 downto 0);
    signal reg_do1, reg_do2 : STD_LOGIC_VECTOR (31 downto 0);
    signal addr_mux      : STD_LOGIC_VECTOR (31 downto 0);
    signal reg_addr      : STD_LOGIC_VECTOR (4 downto 0);

    signal pc_in, pc_out, pc_sum : STD_LOGIC_VECTOR (12 downto 0);
    signal alu_sel, alu2reg, wem, wer, imm_rd, ci_en : STD_LOGIC;
    signal cmp_bit       : STD_LOGIC;
    signal alu_op        : STD_LOGIC_VECTOR (3 downto 0);

begin

    -- PROGRAM COUNTER
    u_cont : entity work.cont port map (
    clk   => clk,
    rst   => '0',      -- o una señal de reset si tienes una
    ci_en => ci_en,    -- señal de enable (ya declarada en tu top)
    sal   => pc_out
    );
    
    




    -- MEMORIA DE INSTRUCCIONES
    u_prog : entity work.prog_m port map (
        a => pc_out,
        funct7 => func7,
        rs2 => rs2,
        rs1 => rs1,
        func3 => func3,
        rd => rd,
        opcode => opcode
    );

    -- UNIDAD DE CONTROL
    u_cu : entity work.CU port map (
        opcode => opcode,
        func7 => func7,
        func3 => func3,
        wer => wer,
        alu_scr => alu_sel,
        alu2reg => alu2reg,
        wem => wem,
        imm_rd => imm_rd,
        ci_en => ci_en,
        men => open, -- no usado en este top
        alu_op => alu_op
    );

    -- MUX ENTRE rs2 y rd para IMM
    u_mux_4b : entity work.mux_4b port map (
        a => rs2,
        b => rd,
        cont => imm_rd,
        sal => reg_addr
    );

    -- DECODIFICADOR DE INMEDIATOS
    u_unidor : entity work.unidor port map (
        a1 => func7,
        a2 => reg_addr,
        sal => imm_12
    );

    u_sign_e : entity work.sign_e port map (
        data_in => imm_12,
        data_out => ext_imm
    );

    u_sign_oe : entity work.sign_oe port map (
        i1 => func7,
        i2 => rd,
        sal => imm_13
    );

    -- MUX PC
    u_mux_c : entity work.mux_c port map (
        a => imm_13,
        c => cmp_bit,
        en => ci_en,
        sal => pc_in
    );

    -- SUMADOR DE PC
    u_sum : entity work.sum port map (
        a => pc_in,
        b => pc_out,
        dout => pc_sum
    );

    -- BANCOS DE REGISTROS
    u_reg_b : entity work.reg_b port map (
        d1 => write_data,
        a1 => rs2,
        a2 => rs1,
        ad => rd,
        we => wer,
        clk => clk,
        do1 => reg_do1,
        do2 => reg_do2
    );

    -- MUX A1 (IMM o REG)
    u_mux2_1_a1 : entity work.mux2_1 port map (
        a => ext_imm,
        b => reg_do1,
        cont => alu_sel,
        sal => a1_mux
    );

    -- ALU
    u_alu : entity work.alu port map (
        a1 => a1_mux,
        a2 => reg_do2,
        opcode => alu_op,
        alu_sal => alu_result
    );

    -- COMPARADOR (slicer)
    u_slicer : entity work.slicer port map (
        a => alu_result,
        b => cmp_bit
    );

    -- MUX A MEMORIA
    u_mux32 : entity work.mux32 port map (
        a => alu_result,
        c => wem,
        sal => addr_mux
    );

    -- MEMORIA DE DATOS
    u_data : entity work.data_m port map (
        di => reg_do1,
        a => addr_mux,
        we => wem,
        clk => clk,
        dout => mem_out
    );

    -- MUX RESULTADO FINAL
    u_mux2_1_final : entity work.mux2_1 port map (
        a => mem_out,
        b => alu_result,
        cont => alu2reg,
        sal => write_data
    );

    -- Salidas visibles
    alu_out <= alu_result;
    PC      <= pc_out;
    reg1    <= reg_do1;
    reg2    <= reg_do2;

end Structural;
