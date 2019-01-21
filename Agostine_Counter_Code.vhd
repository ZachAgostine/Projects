library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter is
    Port ( clock : in STD_LOGIC;
           clear : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (3 downto 0));
end counter;

architecture Behavioral of counter is
    component jk_behave
        Port ( j : in STD_LOGIC;
               k : in STD_LOGIC;
               clear : in STD_LOGIC;
               clock : in STD_LOGIC;
               q : out STD_LOGIC);
    end component;
    signal tq : STD_LOGIC_VECTOR (3 downto 0);
    constant jk : STD_LOGIC_VECTOR (1 downto 0) := "11";
    signal reset : STD_LOGIC;
    
begin
bit0 : jk_behave
        port map (jk(0), jk(1), reset, clock, tq(0));
bit1 : jk_behave
        port map (jk(0), jk(1), reset, tq(0), tq(1));
bit2 : jk_behave
            port map (jk(0), jk(1), reset, tq(1), tq(2));
bit3 : jk_behave
        port map (jk(0), jk(1), reset, tq(2), tq(3));



q(0) <= tq(0);
q(1) <= tq(1);
q(2) <= tq(2);
q(3) <= tq(3);


reset <= (tq(1) AND tq(3)) or clear;

end Behavioral;