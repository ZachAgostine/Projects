library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity Behave is
Port ( clock : in STD_LOGIC;
           clear : in STD_LOGIC;
           stop : in STD_LOGIC;
           dp: out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           a_to_g : out STD_LOGIC_VECTOR (6 downto 0));
end Behave;

architecture Behavioral of Behave is
        component counter is
            Port ( clock : in STD_LOGIC;
                clear : in STD_LOGIC;
                q : out STD_LOGIC_VECTOR (3 downto 0));
        end component;
        signal div_clock :  STD_LOGIC;
        signal display_clock :  STD_LOGIC;
     signal slow_clock: integer RANGE 0 to 16777215;
     signal slow_clock_display: integer RANGE 0 to 16777215;
     signal state : STD_LOGIC_VECTOR (1 downto 0);
     signal hold : STD_LOGIC_VECTOR (3 downto 0);   
    signal q: STD_LOGIC_VECTOR (3 downto 0);
    signal tq: STD_LOGIC_VECTOR (3 downto 0);
    signal A: STD_LOGIC_VECTOR (3 downto 0);
    signal B: STD_LOGIC_VECTOR (3 downto 0);
    signal C: STD_LOGIC_VECTOR (3 downto 0);
    signal D: STD_LOGIC_VECTOR (3 downto 0);

begin
process (clock, clear, stop)
    begin
        if (stop = '1' or clear = '1') then
        div_clock <= div_clock;
    elsif (clock'event and clock='1' ) then
        slow_clock <= slow_clock+1;
        if (slow_clock = 500000) then
            div_clock <= not div_clock;
            slow_clock <= 0;
        
          end if;
          end if;
          
     if (clock'event and clock='1' ) then
        slow_clock_display <= slow_clock_display +1;
        if (slow_clock_display = 50000) then
            display_clock <= not display_clock;
            slow_clock_display <= 0;
        

        end if;
        end if;
end process;

count_A : counter
    port map (div_clock, clear, A);
    
count_B : counter
    port map (A(3), clear, B);
    
count_C : counter
    port map (B(3), clear, C);
    
count_D : counter
    port map (C(3), clear, D);
    

process(display_clock)

begin

if (display_clock'event and display_clock='1') then        
state <= state+1;

case (state) is
when "00" => 
    an <= "0111";
    q <= C;
   dp <= '1';
when "01" => 
    an <= "1011";
  q <= B;
 dp <= '1';    
when "10" => 
    an <= "1101";
 q <= A;
 dp <= '0';        
when "11" => 
    an <= "1110";
 q <= D;
 dp <= '1';
end case;

case (q) is
        when x"0" => a_to_g <= "1000000";
        when x"1" => a_to_g <= "1111001";
        when x"2" => a_to_g <= "0100100";
        when x"3" => a_to_g <= "0110000";
        when x"4" => a_to_g <= "0011001";
        when x"5" => a_to_g <= "0010010";
        when x"6" => a_to_g <= "0000010";
        when x"7" => a_to_g <= "1111000";
        when x"8" => a_to_g <= "0000000";
        when x"9" => a_to_g <= "0010000";
        when others => a_to_g <= "1111111";
    end case;



end if;

end process;
    
    
end Behavioral;
