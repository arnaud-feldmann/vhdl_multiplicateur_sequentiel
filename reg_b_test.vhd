library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity reg_b_test is
    end entity;

architecture reg_b_test_arch of reg_b_test is
    signal b : std_logic_vector(4 downto 0);
    signal Re : std_logic;
    signal Eb  : std_logic;
    signal Dd : std_logic;
    signal clk : std_logic;
    signal L : std_logic;
begin
    rb_test : entity work.reg_b
    port map
    (
        b => b,
        Re => Re,
        Eb => Eb,
        Dd => Dd,
        clk => clk,
        L => L
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
        b <= "11001";
        Re <= '1';
        Eb <= '1';
        Dd <= '0';
        wait until clk = '1';
        wait for 10 ns;
        Re <= '0';
        assert L = '0' report "remise à zéro avant set" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert L = '1' report "premier bit" severity error;
        Eb <= '0';
        wait until clk = '1';
        wait for 10 ns;
        assert L = '1' report "on n'a pas encore le décalage à gauche" severity error;
        Dd <= '1';
        wait until clk = '1';
        wait for 10 ns;
        assert L = '0' report "Le deuxième bit est un 0" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert L = '0' report "Le troisième bit est un 0" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert L = '1' report "Le quatrième bit est un 1" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert L = '1' report "Le cinquième bit est un 1" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert L = '0' report "Que des zéro après 4 - 2" severity error;
        Eb <= '1';
        b <= "00001";
        wait until clk = '1';
        wait for 10 ns;
        assert L = '1' report "Recharge 1 + Eb prioritaire sur Dd" severity error;
        Eb <= '0';
        wait until clk = '1';
        wait for 10 ns;
        assert L = '0' report "Recharge 2" severity error;
        finish;
    end process;

end architecture;

