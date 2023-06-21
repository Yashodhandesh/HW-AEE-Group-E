library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_output is
    Port (
        CLK100MHZ: in std_logic;
        A, B: in std_logic_vector(3 downto 0);
        Result: in std_logic_vector(3 downto 0);
        Cathode: out std_logic_vector(6 downto 0); 
        Anode: out std_logic_vector(7 downto 0)
        
    );
end display_output;

architecture Behavioral of display_output is
signal DividedClock: std_logic:='0'; 
signal Clock_Divider_Counter: integer range 0 to 1000:=0; 
signal Display_Position_Counter: integer range 0 to 7:=0; 
signal Digit_To_Display: integer range 0 to 9:=0;

signal A_unit_value: integer range 0 to 9:=0;
signal A_tenth_value: integer range 0 to 9:=0;

signal B_unit_value: integer range 0 to 9:=0;
signal B_tenth_value: integer range 0 to 9:=0;

signal Result_unit_value: integer range 0 to 9:=0;
signal Result_tenth_value: integer range 0 to 9:=0;


begin

--Extracting Units and 10ths for display output
DigitProcessing: process(A, B,Result)
begin 
    
         A_unit_value <= to_integer(unsigned(A)) mod 10;
         A_tenth_value <= to_integer(unsigned(A)) / 10; 
         
         B_unit_value <= to_integer(unsigned(B)) mod 10;
         B_tenth_value <= to_integer(unsigned(B)) / 10; 
         
         Result_unit_value <= to_integer(unsigned(Result)) mod 10;
         Result_tenth_value <= to_integer(unsigned(Result)) / 10;    
end process; 

--------------------------------

ClockDivider: process(CLK100MHZ)
begin 
    if rising_edge(CLK100MHZ) then 
        if Clock_Divider_Counter = 999 then 
            Clock_Divider_Counter <= 0; 
            DividedClock <= not DividedClock; 
            else 
                Clock_Divider_Counter <= Clock_Divider_Counter +1; 
         end if;
     end if; 
end process; 

DisplaySelection : process(DividedClock)
begin
    if rising_edge (DividedClock) then 
        if Display_Position_Counter = 7 then 
            Display_Position_Counter <= 0; 
          else 
            Display_Position_Counter <= Display_Position_Counter+1; 
            end if; 
          end if; 
                
end process; 

DisplayController : process(Display_Position_Counter)
begin 
    case Display_Position_Counter is 
        when 0=>  Anode<= "11111110";
                  Digit_To_Display <= Result_unit_value; 
        when 1=>  Anode<= "11111101";
                  Digit_To_Display <= Result_tenth_value; 
        when 2=>  Anode<= "11111111";
        when 3=>  Anode<= "11111111";
        when 4=>  Anode<= "11101111";
                  Digit_To_Display <= B_unit_value; 
        when 5=>  Anode<= "11011111";
                   Digit_To_Display <= B_tenth_value;
        when 6=>  Anode<= "10111111";
                    Digit_To_Display <= A_unit_value;
        when 7=>  Anode<= "01111111";
                  Digit_To_Display <= A_tenth_value;
        
        
    end case; 
    
end process; 



Segment_Control: process(Digit_To_Display)
    begin
        case Digit_To_Display is
    when 0 => Cathode <= "1000000"; -- "0"    
    when 1 => Cathode <= "1111001"; -- "1"
    when 2 => Cathode <= "0100100"; -- "2"
    when 3 => Cathode <= "0110000"; -- "3"
    when 4 => Cathode <= "0011001"; -- "4"
    when 5 => Cathode <= "0010010"; -- "5"
    when 6 => Cathode <= "0000010"; -- "6"
    when 7 => Cathode <= "1111000"; -- "7"
    when 8 => Cathode <= "0000000"; -- "8"    
    when 9 => Cathode <= "0010000"; -- "9"
    when others => Cathode <= "0000110" ;-- E

        end case;
    end process;
end Behavioral;
