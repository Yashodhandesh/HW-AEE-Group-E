library ieee;
use ieee.std_logic_1164.all;

entity Ripple_Carry_Adder_TB is 
end entity;

architecture behavioral of Ripple_Carry_Adder_TB is                                           --declaration of ports

signal A1_TB,A2_TB,B1_TB,B2_TB,Cin_TB  : std_logic;
signal S1_TB,S2_TB,Cout_TB             : std_logic;


component Ripple_Carry_Adder is                                                               --adding the component

port(A1,A2,B1,B2,Cin : in std_logic ;
     S1,S2,Co :out std_logic);
end component;



begin                                                                                        --testing with different values
DUT1: Ripple_Carry_Adder port map (A1=>A1_TB, A2=>A2_TB, B1=>B1_TB, B2=>B2_TB, Cin=>Cin_TB, S1=>S1_TB, S2=>S2_TB, Co=>Cout_TB);
A1_TB<='0','0' after 10 ns, '0' after 20 ns, '1' after 30 ns, '1' after 40 ns, '1' after 50 ns, '1' after 60 ns;
A2_TB<='1','0' after 10 ns, '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 50 ns, '1' after 60 ns;
B1_TB<='0','0' after 10 ns, '0' after 20 ns, '1' after 30 ns, '1' after 40 ns, '1' after 50 ns, '1' after 60 ns;
B2_TB<='1','0' after 10 ns, '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 50 ns, '1' after 60 ns;
Cin_TB<='0';

end behavioral;