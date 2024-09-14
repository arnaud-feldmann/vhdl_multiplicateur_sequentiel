library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity bascule_d_test is
    end entity;

architecture bascule_d_test_arch of bascule_d_test is
    signal raz : std_logic;
    signal h : std_logic;
    signal chargement : std_logic;
    signal entree : std_logic;
    signal sortie : std_logic;
begin
    bd_test : entity work.bascule_d
    port map
    (
        raz => raz,
        h => h,
        chargement => chargement,
        entree => entree,
        sortie => sortie
    );

    process
    begin
        h <= '0';
        wait for 50 ns;
        h <= '1';
        wait for 50 ns;
    end process;

    process
    begin
        raz <= '1';
        chargement <= '0';
        entree <= '1';
        wait until h = '1';
        raz <= '0';
        wait until h = '1';
        assert sortie = '0' report "remise a zéro - initialisation" severity error;
        wait until h = '1';
        wait for 2 ns;
        assert sortie = '0' report "ça ne change pas car chargement vaut toujours 0" severity error;
        wait until h = '1';
        wait for 2 ns;
        chargement <= '1';
        wait until h = '1';
        wait for 2 ns;
        assert sortie = '1' report "si on active chargement ça change" severity error;
        wait until h = '1';
        wait for 2 ns;
        entree <= '0';
        wait for 40 ns;
        assert sortie = '1' report "ça ne change pas pendant un cycle" severity error;
        wait until h = '1';
        wait for 2 ns;
        assert sortie = '0' report "mais après le cycle ça change" severity error;
        entree <= '1';
        wait for 20 ns;
        assert sortie = '0' report "ça ne change pas pendant un cycle" severity error;
        wait until h = '1';
        wait for 2 ns;
        assert sortie = '1' report "mais après le cycle ça change" severity error;
        wait for 10 ns;
        chargement <= '0';
        entree <= '0';
        wait for 10 ns;
        assert sortie = '1' report "chargement off ça ne change pas" severity error;
        wait for 100 ns;
        assert sortie = '1' report "chargement off ça ne change pas" severity error;
        finish;
    end process;

end architecture;

