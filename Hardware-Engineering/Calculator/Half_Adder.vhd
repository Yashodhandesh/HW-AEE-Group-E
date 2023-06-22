library ieee;
use ieee.std_logic_1164.all;

entity Half_Adder is
	port (a, b : in std_logic;
		  Sum, Carry : out std_logic);
end Half_Adder;

architecture Behavioral of Half_Adder is
	begin
	Sum <= a xor b;
	Carry <= a and b;
end architecture Behavioral;