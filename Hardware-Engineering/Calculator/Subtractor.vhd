library ieee;
use ieee.std_logic_1164.all;

entity Subtractor is                                                --decalration of ports
port(
      x: in std_logic_vector(3 downto 0);
      y: in std_logic_vector(3 downto 0);
      S_SUB: out std_logic_vector(7 downto 0)
	  );
     -- Co       : out std_logic);
end entity;


architecture behaviour of Subtractor is 

component Full_Adder is                                   --adding the components
port(A : in std_logic ;
     B : in std_logic;
     Cin : in std_logic;
     Cout : out std_logic;
     S :out std_logic);
end component;


signal k: bit;
signal sig : std_logic_vector (3 downto 0);              -- from doing xor
signal y_n : std_logic_vector (3 downto 0);
signal s_s : std_logic_vector (3 downto 0);
signal complete :std_logic_vector (3 downto 0):= (others => '0');

begin
k <='1';

    S_SUB <= complete & s_s;

y_n(0)<= y(0) xor '1';
y_n(1)<= y(1) xor '1';
y_n(2)<= y(2) xor '1';
y_n(3)<= y(3) xor '1';


AD1 :  Full_Adder                                            --port mapping to the component
  port map (x(0),y_n(0),'1',sig(0),s_s(0));
AD2:  Full_Adder
  port map (x(1),y_n(1),sig(0),sig(1),s_s(1));
AD3:  Full_Adder
  port map (x(2),y_n(2),sig(1),sig(2),s_s(2));
AD4:  Full_Adder
  port map (x(3),y_n(3),sig(2),sig(3),s_s(3));

end behaviour;