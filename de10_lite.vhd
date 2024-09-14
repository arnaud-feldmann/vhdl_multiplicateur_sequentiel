library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de10_lite is port
    (
        sw : in std_logic_vector(9 downto 0);
        key : in std_logic_vector(1 downto 0);
        max10_clk1_50 : in std_logic;
        ledr : out std_logic_vector(9 downto 0);
        hex0 : out std_logic_vector(6 downto 0);
        hex1 : out std_logic_vector(6 downto 0);
        hex2 : out std_logic_vector(6 downto 0)
    );
end entity;

architecture de10_lite_archi of de10_lite is
    signal Dd : std_logic;
    signal Dg : std_logic;
    signal Ea : std_logic;
    signal Eb : std_logic;
    signal Em : std_logic;
    signal Re : std_logic;
    signal sortie_reg_a : std_logic_vector(9 downto 0);
    signal L : std_logic;
    signal sortie_reg_m : std_logic_vector(9 downto 0);
    signal sortie_additionneur : std_logic_vector(9 downto 0);
    signal sortie_bcd : std_logic_vector(12 downto 0);
    signal sortie_dec7seg : std_logic_vector(20 downto 0);
begin
    ra : entity work.reg_a
    port map
    (
        A => sw(9 downto 5),
        Re => Re,
        Ea => Ea,
        Dg => Dg,
        clk => max10_clk1_50,
        sortie => sortie_reg_a
    );
    rb : entity work.reg_b
    port map
    (
        B => sw(4 downto 0),
        Re => Re,
        Eb => Eb,
        Dd => Dd,
        clk => max10_clk1_50,
        L => L
    );
    uc : entity work.uc
    port map
    (
        S => not key(1),
        L => L,
        clk => max10_clk1_50,
        raz => not key(0),
        Dd => Dd,
        Dg => Dg,
        Ea => Ea,
        Eb => Eb,
        Em => Em,
        Re => Re
    );
    ad : entity work.additionneur
    port map
    (
        x => sortie_reg_a,
        y => sortie_reg_m,
        sortie => sortie_additionneur
    );
    rm : entity work.reg_m
    port map
    (
        entree => sortie_additionneur,
        Re => Re,
        Em => Em,
        clk => max10_clk1_50,
        sortie => sortie_reg_m
    );
    ledr(9 downto 0) <= sortie_reg_m;
    u2 : entity work.base10
    generic map
    (
        n => 10
    )
    port map
    (
        entree => sortie_reg_m,
        sortie => sortie_bcd(12 downto 0)
    );

    f : for i in 2 downto 0
    generate
        u : entity work.dec7seg
        port map
        (
            entree => sortie_bcd(i * 4 + 3 downto i * 4),
            sortie => sortie_dec7seg(i * 7 + 6 downto i * 7)
        );
    end generate;

    hex0 <= sortie_dec7seg(6 downto 0);
    hex1 <= sortie_dec7seg(13 downto 7);
    hex2 <= sortie_dec7seg(20 downto 14);

end architecture;

