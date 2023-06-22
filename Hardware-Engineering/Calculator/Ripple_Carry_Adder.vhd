library ieee;
use ieee.std_logic_1164.all;


entity Ripple_Carry_Adder is
port( x,y :in std_logic_vector(3 downto 0) ;
      S_ADD : inout std_logic_vector(7 downto 0);
      Co :out std_logic);
end entity;

architecture behavioral of Ripple_Carry_Adder is                               --declaration of signals

signal s1,s2,s3,s4 : std_logic;
signal s_a :std_logic_vector (3 downto 0);
signal complete :std_logic_vector (3 downto 0) := (others => '0');             --For concatination '0000'
 
component Full_Adder is                                                        --adding the component
port(A : in std_logic ;                                                     
     B : in std_logic;
     cin : in std_logic;
     Cout : out std_logic;
     S :out std_logic);
end component;

begin
    
    S_ADD    <=  s_a & complete;                          -- concatination  00,10,20,30                  
     
	 FA1 : Full_Adder 
            port map (x(0),y(0),'0',s1,s_a(0));


     FA2 : Full_Adder 
            port map (x(1),y(1),s1,s2,s_a(1));


     FA3 : Full_Adder 
            port map (x(2),y(2),s2,s3,s_a(2));


     FA4 : Full_Adder 
            port map (x(3),y(3),s3,s4,s_a(3));
   

end behavioral;

