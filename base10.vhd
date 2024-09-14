library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity base10 is
    generic
    (
        n : natural := 16
    );
    port
    (
        entree : in std_logic_vector(n - 1 downto 0);
        sortie : out std_logic_vector(n + (n - 4) / 3 downto 0)
    );
end entity;

architecture base10_archi of base10 is
begin
    process(entree)
        variable sortie_temp : std_logic_vector(sortie'range);
        variable pos : integer range sortie'range;
    begin
        sortie_temp(sortie'range) := (others => '0');
        sortie_temp(entree'range) := entree;
        for i in 0 to n - 4 loop
            for j in 0 to i/3 loop
                pos := n - i + 4 * j;
                if unsigned(sortie_temp(pos downto pos - 3)) > 4 then
                    sortie_temp(pos downto pos - 3) := std_logic_vector(unsigned(sortie_temp(pos downto pos - 3)) + 3);
                end if;
            end loop;
        end loop;
        sortie <= sortie_temp;
    end process;
end architecture;

