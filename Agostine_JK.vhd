library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_behave is
    Port ( j : in STD_LOGIC;
           k : in STD_LOGIC;
           clock : in STD_LOGIC;
           clear : in STD_LOGIC;
           Q : out STD_LOGIC);
end jk_behave;

architecture arc of jk_behave is
signal jk : STD_LOGIC_VECTOR(1 downto 0);
signal tq : STD_LOGIC;
begin
    jk <= j&k;
    process(clock, clear)
    begin
        if (clear = '1') then
        tq <= '0';
        elsif (clock'EVENT AND clock='0') then
            CASE jk IS
                WHEN "00" => tq <= tq;
                WHEN "01" => tq <= '0';
                WHEN "10" => tq <= '1';
                WHEN "11" => tq <= NOT tq;
                WHEN OTHERS => tq <= tq;
         END CASE;
     end if;
   end process;
   
   
  q <= tq;

end arc;