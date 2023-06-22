library ieee;
use ieee.std_logic_1164.all;

entity Adder_To_Mux is
port(--k : in std_logic ;
      a: in std_logic_vector(3 downto 0);
      b: in std_logic_vector(3 downto 0);
      s_a: out std_logic_vector(3 downto 0);
      co       : out std_logic);
end entity;


architecture behaviour of Adder_To_Mux is 

component Ripple_Carry_Adder is                                 -- component declaration of the ripple carry adder from the previous task
port(A1,A2,A3,A4,B1,B2,B3,B4,Cin : in std_logic ;
     S1,S2,S3,S4,Co :out std_logic);
end component;


signal sig1:std_logic ;
signal sig2 :std_logic ;
signal sig3,sig4 : std_logic;
signal x0 :std_logic;
signal x1 :std_logic;
signal x2,x3,y0,y1,y2,y3 : std_logic;             -- declaration of signals which are from the xor gate in the circuit diagram of adder/subtractor
begin

sig1<=b(0) xor '0';
sig2<=b(1) xor '0';
sig3<=b(2) xor '0';
sig4<=b(3) xor '0';


x0<=a(0);
x1<=a(1);
x2<=a(2);
x3<=a(3);


s_a(0)<=y0;
s_a(1)<=y1;
s_a(2)<=y2;
s_a(3)<=y3;





     xbadder :   Ripple_Carry_Adder
  port map (x0,x1,x2,x3,    sig1,sig2,sig3,sig4,   '0',   y0,y1,y2,y3,co);



end behaviour;