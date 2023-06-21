library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity final_calculator is
    Port (
        A, B: in std_logic_vector(3 downto 0);
        OP: in std_logic_vector(1 downto 0);
        Equals, Clear: in std_logic;
        
        Anode : out std_logic_vector(7 downto 0);
        Cathode : out std_logic_vector(6 downto 0);

        CLK100MHZ: in std_logic
    );
end final_calculator;


architecture Behavioral of final_calculator is  

-----Component Declaration 
--DISPLAY
component display_output is
    Port (
        CLK100MHZ: in std_logic;
        A, B: in std_logic_vector(3 downto 0);
        Result: in std_logic_vector(3 downto 0);
        Cathode: out std_logic_vector(6 downto 0); 
        Anode: out std_logic_vector(7 downto 0)
        
    );
end component display_output;

--MAIN CALCULATOR
component main_calculator is
    Port (
        A, B: in std_logic_vector(3 downto 0);
        OP: in std_logic_vector(1 downto 0);
        Equals, Clear: in std_logic;
        Result: out std_logic_vector(3 downto 0)
    );
end component; 


--------------SIGNALS
signal signal_Result_to_display: std_logic_vector(3 downto 0);
       
---BEGIN ARCHITECTURE
begin 

--Component Instantiation 

MyCalculator: main_calculator port map(

        A=>A, 
        B=>B,
        OP=>OP,
        Equals=>Equals, 
        Clear=> Clear,
        Result=>signal_Result_to_display

); 

Display: display_output port map( 
        Result=> signal_Result_to_display,
         A=>A, 
         B=>B,
         CLK100MHZ => CLK100MHZ,
         Cathode => Cathode,
         Anode => Anode
) ; 

end architecture; 

