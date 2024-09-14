library ieee;
use ieee.std_logic_1164.all;

entity dec7seg is port
    (
        entree : in std_logic_vector(3 downto 0);
        sortie : out std_logic_vector(6 downto 0)
    );
end entity;

architecture dec7seg_archi of dec7seg is
begin
    process(entree) is
    begin
        case entree is
            when x"0" => sortie <= "1000000"; 
            when x"1" => sortie <= "1111001"; 
            when x"2" => sortie <= "0100100"; 
            when x"3" => sortie <= "0110000"; 
            when x"4" => sortie <= "0011001"; 
            when x"5" => sortie <= "0010010"; 
            when x"6" => sortie <= "0000010"; 
            when x"7" => sortie <= "1111000"; 
            when x"8" => sortie <= "0000000"; 
            when x"9" => sortie <= "0010000"; 
            when others => sortie <= "1111111";
        end case;
    end process;
end dec7seg_archi;
