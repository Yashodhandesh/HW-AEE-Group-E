library ieee;
use ieee.std_logic_1164.all; 

entity Full_Adder_TB is 
end Full_Adder_TB;

architecture Behavioural of Full_Adder is 

 component Full_Adder is 
     port( a , b , Cin  : in std_logic;
             Sum, Carry : out std_logic);
 end component;

 signal aTB , bTB , CinTB ,SumTB, CarryTB : std_logic;

begin 
 DUT1: Full_Adder port map (a=>aTB , b=>bTB , Cin=>CinTB ,Sum=>SumTB, Carry=>CarryTB);
              aTB <=  '0' , '1' after 80 ns;
              bTB <=  '0' , '1' after 40 ns, '0' after 80 ns, '1' after 120 ns ;  
            CinTB <=  '0' , '1' after 20 ns, '0' after 40 ns, '1' after 60  ns, '0' after 80 ns, '1' after 100 ns, '0' after 120 ns, '1' after 140 ns;
end Behavioural ;


