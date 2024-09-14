library ieee;
use ieee.std_logic_1164.all;

entity reg_m is
    port
    (
        entree : in std_logic_vector(9 downto 0);
        Re : in std_logic;
        Em  : in std_logic;
        clk : in std_logic;
        sortie : out std_logic_vector(9 downto 0)
    );
end entity;

architecture reg_m_archi of reg_m is
begin
    process (clk, Re)
        variable sortie_temp : std_logic_vector(9 downto 0);
    begin
        if Re then
            sortie_temp := "0000000000";
        elsif rising_edge(clk) and Em = '1' then
            sortie_temp := entree;
        end if;
        sortie <= sortie_temp;
    end process;

end architecture;

