library ieee;
use ieee.std_logic_1164.all;

entity Sub_Calculator is
port(x : in  std_logic_vector(3 downto 0); 
     y : in  std_logic_vector(3 downto 0);
     sel : inout bit_vector(1 downto 0);              
     Ans : inout  std_logic_vector(7 downto 0));
     
end entity;

architecture behaviour of Sub_Calculator is
----------------------------------------------------
component Adder_To_Mux  is

port(--k : in std_logic ;
      a: in std_logic_vector(3 downto 0);
      b: in std_logic_vector(3 downto 0);
      s_a: out std_logic_vector(7 downto 0);
      co       : out std_logic);
end component;
----------------------------------------------------
component Subtractor  is

port(
      x: in std_logic_vector(3 downto 0);
      y: in std_logic_vector(3 downto 0);
      s_sub: out std_logic_vector(3 downto 0));
     -- co       : out std_logic);
end component;
----------------------------------------------------

component Multiplier  is

port(x : in  std_logic_vector(3 downto 0);     
     y : in  std_logic_vector(3 downto 0);     
     Ans : out  std_logic_vector(3 downto 0));
end component;

-----------------------------------------------------
component Mux_4_to_1  is

port(A : in std_logic_vector(3 downto 0 );
     B : in std_logic_vector(3 downto 0 );
     C : in  std_logic_vector(3 downto 0 );
     D : in  std_logic_vector(3 downto 0 );
     Sel : in  bit_vector(1 downto 0 ); 
     F : inout  std_logic_vector(7 downto 0 )
     );
end component;
------------------------------------------------------
component Ripple_Carry_Adder  is

port(x,y :in std_logic_vector(3 downto 0) ;
     --Cin : in std_logic ;
     S_ADD : inout std_logic_vector(3 downto 0);
     Co :out std_logic);
end component;
------------------------------------------------------

signal sig_add_out:        std_logic_vector(3 downto 0);
signal sig_sub_out:        std_logic_vector(3 downto 0);
signal sig_div_out:        std_logic_vector(3 downto 0);
signal sig_multiplier_out: std_logic_vector(3 downto 0);


begin 


   FA1 : Ripple_Carry_Adder
	port map(x,y,sig_add_out);

   FA2 : Subtractor
	port map(x,y,sig_sub_out);
  
   FA3 : Ripple_Carry_Adder
	port map(x,y,sig_add_out);

   FA4 : Multiplier
	port map(x,y,sig_multiplier_out);

   FA5 : Mux_4_to_1
	port map( sig_add_out, sig_sub_out , sig_add_out , sig_multiplier_out , sel , ANS );


end architecture;