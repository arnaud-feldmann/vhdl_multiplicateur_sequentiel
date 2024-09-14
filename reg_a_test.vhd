library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity reg_a_test is
    end entity;

architecture reg_a_test_arch of reg_a_test is
    signal A : std_logic_vector(4 downto 0);
    signal Re : std_logic;
    signal Ea  : std_logic;
    signal Dg : std_logic;
    signal clk : std_logic;
    signal sortie : std_logic_vector(9 downto 0);
begin
    ra_test : entity work.reg_a
    port map
    (
        A => A,
        Re => Re,
        Ea => Ea,
        Dg => Dg,
        clk => clk,
        sortie => sortie
    );

    process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process
    begin
        A <= "11001";
        Re <= '1';
        Ea <= '1';
        Dg <= '0';
        wait until clk = '1';
        wait for 10 ns;
        Re <= '0';
        assert sortie = "0000000000" report "remise à zéro avant set" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0000011001" report "premier dec" severity error;
        Ea <= '0';
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0000011001" report "on n'a pas encore le décalage à gauche" severity error;
        Dg <= '1';
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0000110010" report "premier décalage" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0001100100" report "Deuxième décalage" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0011001000" report "Troisième décalage" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0110010000" report "Quatrième décalage" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "1100100000" report "Cinquième décalage" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "1001000000" report "Sixième décalage" severity error;
        Ea <= '1';
        A <= "00001";
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0000000001" report "Recharge 1 + Ea prioritaire sur Dg" severity error;
        Ea <= '0';
        wait until clk = '1';
        wait for 10 ns;
        assert sortie = "0000000010" report "Recharge 2" severity error;
        finish;
    end process;

end architecture;

