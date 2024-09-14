library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.env.all;

entity additionneur_test is
    end entity;

architecture additionneur_test_arch of additionneur_test is
    signal x : std_logic_vector(9 downto 0);
    signal y : std_logic_vector(9 downto 0);
    signal sortie : std_logic_vector(9 downto 0);
begin
    add : entity work.additionneur
    port map
    (
        x => x,
        y => y,
        sortie => sortie
    );

    process
    begin
        x <= "1110010110";
        y <= "1100101111";
        wait for 10 ns;
        assert sortie = "1011000101" report "1110010110 + 1100101111 = " & to_string(sortie) severity error;
        wait for 10 ns;

        x <= "0000101111";
        y <= "0010010110";
        wait for 10 ns;
        assert sortie = "0011000101" report "0000101111 + 0010010110 = " & to_string(sortie) severity error;
        wait for 10 ns;

        x <= "0000000000";
        y <= "1111111111";
        wait for 10 ns;
        assert sortie = "1111111111" report "0000000000 + 1111111111 = " & to_string(sortie) severity error;

        x <= "1111111111";
        y <= "1111111111";
        wait for 10 ns;
        assert sortie = "1111111110" report "1111111111 + 1111111111 = " & to_string(sortie) severity error;
 
        x <= "0010001010";
        y <= "0010111010";
        wait for 10 ns;
        assert sortie = "0101000100" report "0010001010 + 0010111010 = " & to_string(sortie)  severity error;
        finish;
    end process;

end architecture;

