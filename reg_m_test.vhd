library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity reg_m_test is
    end entity;

architecture reg_m_test_arch of reg_m_test is
    signal entree : std_logic_vector(9 downto 0);
    signal Re : std_logic;
    signal Em : std_logic;
    signal clk : std_logic;
    signal sortie : std_logic_vector(9 downto 0);
begin
    rm_test : entity work.reg_m
    port map
    (
        entree => entree,
        Re => Re,
        Em => Em,
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
        Re <= '1';
        Em <= '0';
        entree <= "1110100100";
        wait until clk = '1';
        Re <= '0';
        wait until clk = '1';
        assert sortie = "0000000000" report "remise a zéro - initialisation" severity error;
        wait until clk = '1';
        wait for 2 ns;
        assert sortie = "0000000000" report "ça ne change pas car Em vaut toujours 0" severity error;
        wait until clk = '1';
        wait for 2 ns;
        Em <= '1';
        wait until clk = '1';
        wait for 2 ns;
        assert sortie = "1110100100" report "si on active Em ça change" severity error;
        wait until clk = '1';
        wait for 2 ns;
        entree <= "0000001001";
        wait for 40 ns;
        assert sortie = "1110100100" report "ça ne change pas pendant un cycle" severity error;
        wait until clk = '1';
        wait for 2 ns;
        assert sortie = "0000001001" report "mais après le cycle ça change" severity error;
        entree <= "1110000000";
        wait for 20 ns;
        assert sortie = "0000001001" report "ça ne change pas pendant un cycle" severity error;
        wait until clk = '1';
        wait for 2 ns;
        assert sortie = "1110000000" report "mais après le cycle ça change" severity error;
        wait for 10 ns;
        Em <= '0';
        entree <= "0000000000";
        wait for 10 ns;
        assert sortie = "1110000000" report "Em off ça ne change pas" severity error;
        wait for 100 ns;
        assert sortie = "1110000000" report "Em off ça ne change pas" severity error;
        finish;
    end process;

end architecture;

