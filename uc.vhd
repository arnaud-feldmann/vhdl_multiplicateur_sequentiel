library ieee;
use ieee.std_logic_1164.all;

entity uc is
    port
    (
        S : in std_logic;
        L : in std_logic;
        clk : in std_logic;
        raz : in std_logic;
        Dd : out std_logic;
        Dg : out std_logic;
        Ea : out std_logic;
        Eb : out std_logic;
        Em : out std_logic;
        Re : out std_logic
    );
end entity;

architecture uc_archi of uc is
    type etat is (ATTENDRE, INIT, CHARGE, LEC0, LEC1ADD0, LEC1NOP0, LEC2ADD1, LEC2NOP1, LEC3ADD2, LEC3NOP2, LEC4ADD3, LEC4NOP3, ADD4, NOP4);
    signal present, futur : etat;
begin
    Re <= '1' when raz = '1' or present = INIT else '0';
    process (present, S, L) is
    begin
        futur <= present;
        case present is
            when ATTENDRE => if S then futur <= INIT; end if;
            when INIT => futur <= CHARGE;
            when CHARGE => futur <= LEC0;
            when LEC0 => if L then futur <= LEC1ADD0; else futur <= LEC1NOP0; end if;
            when LEC1ADD0 |  LEC1NOP0 => if L then futur <= LEC2ADD1; else futur <= LEC2NOP1; end if;
            when LEC2ADD1 |  LEC2NOP1 => if L then futur <= LEC3ADD2; else futur <= LEC3NOP2; end if;
            when LEC3ADD2 |  LEC3NOP2 => if L then futur <= LEC4ADD3; else futur <= LEC4NOP3; end if;
            when LEC4ADD3 |  LEC4NOP3 => if L then futur <= ADD4; else futur <= NOP4; end if;
            when ADD4 | NOP4 => futur <= ATTENDRE;
        end case;
    end process;
    process (raz, clk) is
    begin
        if raz then
            present <= ATTENDRE;
        elsif rising_edge(clk)
        then
            present <= futur;
        end if;
    end process;
    process (present) is
    begin
        Dd <= '0';
        Dg <= '0';
        Ea <= '0';
        Eb <= '0';
        Em <= '0';
        case present is
            when ATTENDRE => null;
            when CHARGE => Ea <= '1'; Eb <= '1';
            when LEC0 => Dd <= '1';
            when LEC1ADD0 | LEC2ADD1 | LEC3ADD2 => Dg <= '1'; Dd <= '1'; Em <= '1';
            when LEC4ADD3 => Dg <= '1' ; Em <= '1';
            when LEC1NOP0 | LEC2NOP1 | LEC3NOP2 => Dg <= '1'; Dd <= '1';
            when LEC4NOP3 => Dg <= '1';
            when ADD4 => Em <= '1';
            when INIT | NOP4 => null;
        end case;
    end process;
end uc_archi;

