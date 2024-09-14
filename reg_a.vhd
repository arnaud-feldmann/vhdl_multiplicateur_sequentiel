library ieee;
use ieee.std_logic_1164.all;

entity reg_a is
    port
    (
        A : in std_logic_vector(4 downto 0);
        Re : in std_logic;
        Ea  : in std_logic;
        Dg : in std_logic;
        clk : in std_logic;
        sortie : out std_logic_vector(9 downto 0)
    );
end entity;

architecture reg_a_archi of reg_a is
    signal A_10bit : std_logic_vector(9 downto 0);
    signal entrees : std_logic_vector(9 downto 0);
    signal sorties_bis : std_logic_vector(sortie'high + 1 downto 0); 
begin
    A_10bit <= "00000" & A;
    sorties_bis(sortie'low) <= '0';
    f : for i in sortie'range generate
        entrees(i) <= A_10bit(i) when Ea ='1'  else sorties_bis(i);
        u : entity work.bascule_d
        port map
        (
            raz => Re,
            h => clk,
            chargement => Ea or Dg,
            entree => entrees(i),
            sortie => sorties_bis(i+1)
        );
    end generate;
    sortie <= sorties_bis(sortie'high + 1 downto 1);
end architecture;

