library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder is 
port( A, B ,Cin  : in  std_logic;
         S ,Cout : out std_logic);
end Full_Adder;


architecture behavioural of Full_Adder is 

component Half_Adder is 
port(     a , b   : in std_logic;
       Sum, Carry : out std_logic);
end component ;

signal C1 , C2 , S1 : std_logic;

begin 

--Halfadder
 HA1 : Half_Adder
      port map(a , b , C1 , S1); 

--Halfadder
 HA2 : Half_Adder
      port map(S1 , Cin , C2 , S);

--carry out
Cout <= C1 OR C2; 
           
end behavioural;