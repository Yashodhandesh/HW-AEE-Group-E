library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Final_Calculator is
    port (
	   x : in  std_logic_vector(3 downto 0); 
       y : in  std_logic_vector(3 downto 0);
     sel : inout bit_vector(1 downto 0);
        
        input:      inout   std_logic_vector (15 downto 0);
        ones:       inout  std_logic_vector   (3 downto 0);
        tens:       inout  std_logic_vector   (3 downto 0);
        hundreds:   inout  std_logic_vector   (3 downto 0);
        thousands:  inout  std_logic_vector   (3 downto 0);
LED_out_1,LED_out_2,LED_out_3,LED_out_4 : inout std_logic_vector(6 downto 0 )-----7 bit vector,bcz 7seg_display,dont change to 6 downto 0  xxx
--LED_out_1,LED_out_2,LED_out_3,LED_out_4 : out std_logic_vector(7 downto 0 )
    );
end entity;

architecture behavioral of Final_Calculator is
----------------------------------------------------------------------
component Mux_4_to_1 is                                                 -- this component takes in input from th four different sub components (4 bit adder,subtractor and multiplier and 2 bit selector 
                                                                         --                                               and selects the desired value according to selector input provided by user. 
port(A : in std_logic_vector(3 downto 0 );
     B : in std_logic_vector(3 downto 0 );
     C : in  std_logic_vector(3 downto 0 );
     D : in  std_logic_vector(3 downto 0 );
     Sel : in  bit_vector(1 downto 0 ); 
     F : inout  std_logic_vector(3 downto 0 )
     );
end component;
----------------------------------------------------------------------

component Sub_Calculator is

 port( x : in  std_logic_vector   (3 downto 0); 
       y : in  std_logic_vector   (3 downto 0);
     sel : inout bit_vector       (1 downto 0);              
     Ans : inout  std_logic_vector(15 downto 0)
	 );
end component;
----------------------------------------------------------------------

    alias Hex_Display_Data: std_logic_vector (15 downto 0) is input;  -- 
    alias rpm_1:    std_logic_vector (3 downto 0) is ones;
    alias rpm_10:   std_logic_vector (3 downto 0) is tens;
    alias rpm_100:  std_logic_vector (3 downto 0) is hundreds;
    alias rpm_1000: std_logic_vector (3 downto 0) is thousands;

begin

 sub_cal : Sub_Calculator
           port map (x,y,sel,input);

   
 --  mux1 :   
   --       port map();
--signal input : std_logic_vector (15 downto 0);
  

    process (Hex_Display_Data)
        type fourbits is array (3 downto 0) of std_logic_vector(3 downto 0);
        -- variable i : integer := 0;  -- NOT USED
        -- variable bcd : std_logic_vector(15 downto 0) := (others => '0');
        variable bcd:   std_logic_vector (15 downto 0);
        -- variable bint : std_logic_vector(15 downto 0) := Hex_Display_Data;         
        variable bint:  std_logic_vector (13 downto 0); -- SEE process body
    begin
        bcd := (others => '0');      -- ADDED for EVERY CONVERSION
        bint := Hex_Display_Data (13 downto 0); -- ADDED for EVERY CONVERSION

        for i in 0 to 13 loop                                                      -- this algorithm converts 8 bit binary number to display the correct values on the displays in decimal value, using a shifting and adding method
            bcd(15 downto 1) := bcd(14 downto 0);
            bcd(0) := bint(13);
            bint(13 downto 1) := bint(12 downto 0);
            bint(0) := '0';

            if i < 13 and bcd(3 downto 0) > "0100" then
                bcd(3 downto 0) := 
                    std_logic_vector (unsigned(bcd(3 downto 0)) + 3);
            end if;
            if i < 13 and bcd(7 downto 4) > "0100" then
                bcd(7 downto 4) := 
                    std_logic_vector(unsigned(bcd(7 downto 4)) + 3);
            end if;
            if i < 13 and bcd(11 downto 8) > "0100" then
                bcd(11 downto 8) := 
                    std_logic_vector(unsigned(bcd(11 downto 8)) + 3);
            end if;
            if i < 13 and bcd(15 downto 12) > "0100" then
                bcd(11 downto 8) := 
                    std_logic_vector(unsigned(bcd(15 downto 12)) + 3);
            end if;
        end loop;

        (rpm_1000, rpm_100, rpm_10, rpm_1)  <= 
                  fourbits'( bcd (15 downto 12), bcd (11 downto 8), 
                               bcd ( 7 downto  4), bcd ( 3 downto 0) );
        
end process;

process(rpm_1,rpm_10,rpm_100,rpm_1000)
begin
 case rpm_1 is
    when "0000" => LED_out_1 <= "0000001"; -- "0"     --   from here on the decoding to the display is shown,it basically converts the binary data from the previous  
    when "0001" => LED_out_1 <= "1001111"; -- "1"                                                                               -- algorithm and helps to display correctly on display
    when "0010" => LED_out_1 <= "0010010"; -- "2" 
    when "0011" => LED_out_1 <= "0000110"; -- "3" 
    when "0100" => LED_out_1 <= "1001100"; -- "4" 
    when "0101" => LED_out_1 <= "0100100"; -- "5" 
    when "0110" => LED_out_1 <= "0100000"; -- "6" 
    when "0111" => LED_out_1 <= "0001111"; -- "7" 
    when "1000" => LED_out_1 <= "0000000"; -- "8"     
    when "1001" => LED_out_1 <= "0000100"; -- "9"
  when others =>LED_out_1<= "0000000";
  end case;

case rpm_10 is
    when "0000" => LED_out_2 <= "0000001"; -- "0"     
    when "0001" => LED_out_2 <= "1001111"; -- "1" 
    when "0010" => LED_out_2 <= "0010010"; -- "2" 
    when "0011" => LED_out_2 <= "0000110"; -- "3" 
    when "0100" => LED_out_2 <= "1001100"; -- "4" 
    when "0101" => LED_out_2 <= "0100100"; -- "5" 
    when "0110" => LED_out_2 <= "0100000"; -- "6" 
    when "0111" => LED_out_2 <= "0001111"; -- "7" 
    when "1000" => LED_out_2 <= "0000000"; -- "8"     
    when "1001" => LED_out_2 <= "0000100"; -- "9"
when others =>LED_out_2<= "0000000";
end case;

case rpm_100 is
    when "0000" => LED_out_3 <= "0000001"; -- "0"     
    when "0001" => LED_out_3 <= "1001111"; -- "1" 
    when "0010" => LED_out_3 <= "0010010"; -- "2" 
    when "0011" => LED_out_3 <= "0000110"; -- "3" 
    when "0100" => LED_out_3 <= "1001100"; -- "4" 
    when "0101" => LED_out_3 <= "0100100"; -- "5" 
    when "0110" => LED_out_3 <= "0100000"; -- "6" 
    when "0111" => LED_out_3 <= "0001111"; -- "7" 
    when "1000" => LED_out_3 <= "0000000"; -- "8"     
    when "1001" => LED_out_3 <= "0000100"; -- "9"
when others =>LED_out_3<= "0000000";
end case;

case rpm_1000 is
    when "0000" => LED_out_4 <= "0000001"; -- "0"     
    when "0001" => LED_out_4 <= "1001111"; -- "1" 
    when "0010" => LED_out_4 <= "0010010"; -- "2" 
    when "0011" => LED_out_4 <= "0000110"; -- "3" 
    when "0100" => LED_out_4 <= "1001100"; -- "4" 
    when "0101" => LED_out_4 <= "0100100"; -- "5" 
    when "0110" => LED_out_4 <= "0100000"; -- "6" 
    when "0111" => LED_out_4 <= "0001111"; -- "7" 
    when "1000" => LED_out_4 <= "0000000"; -- "8"     
    when "1001" => LED_out_4 <= "0000100"; -- "9"
when others =>LED_out_4<= "0000000";
end case;

end process;

end architecture;