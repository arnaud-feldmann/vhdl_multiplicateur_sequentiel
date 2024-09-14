library ieee;
use ieee.std_logic_1164.all;

entity reg_b is
    port
    (
        b : in std_logic_vector(4 downto 0);
        Re : in std_logic;
        Eb  : in std_logic;
        Dd : in std_logic;
        clk : in std_logic;
        L : out std_logic
    );
end entity;

architecture reg_b_archi of reg_b is
    signal entrees : std_logic_vector(b'range);
    signal sorties : std_logic_vector(b'high + 1 downto 0); 
begin
    sorties(sorties'high) <= '0';
    f : for i in entrees'range generate
        entrees(i) <= b(i) when Eb = '1' else sorties(i+1);
        u : entity work.bascule_d
        port map
        (
            raz => Re,
            h => clk,
            chargement => Eb or Dd,
            entree => entrees(i),
            sortie => sorties(i)
        );
    end generate;
    L <= sorties(sorties'low);
end architecture;

