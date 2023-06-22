library ieee;
use ieee.std_logic_1164.all; 

entity Half_Adder is
end Half_Adder;

architecture behavioral of Half_Adder is
	component Half_Adder
		port(A, B : in std_logic;
		     S, C : out std_logic);
	end component;
	signal A_TB, B_TB : std_logic;
	signal S_TB, C_TB : std_logic;
	begin
	DUT1: Half_Adder port map (A=>A_TB, B=>B_TB, S=>S_TB, C=>C_TB);
	A_TB <= '1','0' after 10 ns, '1' after 20 ns;
	B_TB <= '1','0' after 10 ns, '1' after 20 ns;
end behavioral;