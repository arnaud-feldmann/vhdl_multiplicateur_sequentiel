library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity uc_test is
    end entity;

architecture uc_test_arch of uc_test is
    signal S : std_logic;
    signal L : std_logic;
    signal clk : std_logic;
    signal raz : std_logic;
    signal Dd : std_logic;
    signal Dg : std_logic;
    signal Ea : std_logic;
    signal Eb : std_logic;
    signal Em : std_logic;
    signal Re : std_logic;
begin
    u_test : entity work.uc
    port map
    (
        S => S,
        L => L,
        clk => clk,
        raz => raz,
        Dd => Dd,
        Dg => Dg,
        Ea => Ea,
        Eb => Eb,
        Em => Em,
        Re => Re
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
        raz <= '1';
        L <= '0';
        S <= '0';
        wait for 5 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '1' report "Reset asynchrone" severity error;
        wait for 45 ns;
        raz <= '0';
        wait until clk = '1';
        wait for 35 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "ATTENTE - 1" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "ATTENTE - 2" severity error;
        S <= '1';
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '1' report "INIT" severity error;
        wait until clk = '1';
        S <= '0';
        wait for 5 ns;
        assert Dd = '0' and Dg = '0' and Ea = '1' and Eb = '1' and Em = '0' and Re = '0' report "CHARGE" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '1' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC0" severity error;
        L <= '1';
        wait until clk = '1';
        wait for 25 ns;
        assert Dd = '1' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '1' and Re = '0' report "LEC1ADD0" severity error;
        S <= '1';
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '1' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '1' and Re = '0' report "LEC2ADD1" severity error;
        L <= '0';
        S <= '0';
        wait until clk = '1';
        wait for 30 ns;
        assert Dd = '1' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC3NOP2" severity error;
        S <= '1';
        wait until clk = '1';
        wait for 40 ns;
        assert Dd = '0' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC4NOP3" severity error;
        wait until clk = '1';
        wait for 20 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "NOP4" severity error;
        S <= '0';
        wait until clk = '1';
        wait for 15 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "ATTENTE bis - 1" severity error;
        wait until clk = '1';
        wait for 45 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "ATTENTE bis - 2" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "ATTENTE bis - 3" severity error;
        S <= '1';
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '1' report "INIT B" severity error;
        wait until clk = '1';
        S <= '1';
        wait for 5 ns;
        assert Dd = '0' and Dg = '0' and Ea = '1' and Eb = '1' and Em = '0' and Re = '0' report "CHARGE B" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '1' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC0 B" severity error;
        L <= '0';
        wait until clk = '1';
        wait for 25 ns;
        assert Dd = '1' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC1NOP0" severity error;
        S <= '0';
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '1' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC2NOP1" severity error;
        L <= '1';
        S <= '1';
        wait until clk = '1';
        wait for 30 ns;
        assert Dd = '1' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '1' and Re = '0' report "LEC3ADD2" severity error;
        S <= '0';
        wait until clk = '1';
        wait for 40 ns;
        assert Dd = '0' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '1' and Re = '0' report "LEC4ADD3" severity error;
        wait until clk = '1';
        wait for 20 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '1' and Re = '0' report "ADD4" severity error;
        S <= '1';
        wait until clk = '1';
        wait for 15 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "ATTENTE C" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '1' report "INIT C" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '0' and Dg = '0' and Ea = '1' and Eb = '1' and Em = '0' and Re = '0' report "CHARGE C" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '1' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC0 C" severity error;
        L <= '0';
        wait until clk = '1';
        wait for 25 ns;
        assert Dd = '1' and Dg = '1' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC1NOP0" severity error;
        wait for 5 ns;
        raz <= '1';
        wait for 5 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '1' report "Reset asynchrone en plein milieu circuit" severity error;
        wait for 5 ns;
        raz <= '0';
        S <= '1';
        wait until clk = '1';
        wait for 5 ns;
        assert Dd = '0' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '1' report "INIT D" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '0' and Dg = '0' and Ea = '1' and Eb = '1' and Em = '0' and Re = '0' report "CHARGE D" severity error;
        wait until clk = '1';
        wait for 10 ns;
        assert Dd = '1' and Dg = '0' and Ea = '0' and Eb = '0' and Em = '0' and Re = '0' report "LEC0 D" severity error;
        finish;
    end process;

end architecture;

