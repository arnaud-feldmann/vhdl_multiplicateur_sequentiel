library ieee;
use ieee.std_logic_1164.all;

entity additionneur is
    port
    (
        x : in std_logic_vector(9 downto 0);
        y : in std_logic_vector(9 downto 0);
        sortie : out std_logic_vector(9 downto 0)
    );
end entity;

architecture additionneur_archi of additionneur is
    signal sortie_prec_v, retenue_prec_v : std_logic_vector(x'high + 1 downto 0);
begin
    sortie_prec_v(0) <= '0';
    retenue_prec_v(0) <= '0';
    g : for i in x'range
    generate
        u : entity work.additionneur_unitaire port map
        (
            x => x(i),
            y => y(i),
            retenue_prec => retenue_prec_v(i),
            sortie => sortie_prec_v(i + 1),
            retenue => retenue_prec_v(i + 1)
        );
    end generate;
    sortie <= sortie_prec_v(x'high + 1 downto 1);
end additionneur_archi;
