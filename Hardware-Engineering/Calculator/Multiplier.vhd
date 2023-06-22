-- this is the multiplier code which takes in two 4-bit numb+ers and gives a 8-bit output.    

library ieee;
use ieee.std_logic_1164.all;


entity Multiplier is
port(x : in  std_logic_vector(3 downto 0);     --:= ?1010?;
     y : in  std_logic_vector(3 downto 0);     --:= ?1010?;
     Ans : out  std_logic_vector(7 downto 0));
     
end entity;

architecture behavioral of Multiplier is

component Full_adder  is                   -- the Full adder  is used as a component

port(A : in std_logic ;
     B : in std_logic;
     Cin : in std_logic;
     Cout : out std_logic;
     S :out std_logic);
end component;

                     -- signal declaration, these signals are the carries and sums and single output bits from the multiplication process.
signal   s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11 :std_logic;   --3*3=9+2=11
signal   k1,k2,k3,k4,k5,k6: std_logic;                    --3*2=6
signal   p0,p1,p2,p3,p4,p5,p6,p7 :std_logic;

signal x30,x20,x10,x00: std_logic;
signal x31,x21,x11,x01: std_logic;
signal x32,x22,x12,x02: std_logic;
signal x33,x23,x13,x03:std_logic;

begin
 x00<= x(0) and y(0);
 x10<= x(1) and y(0);
 x20<= x(2) and y(0);
 x30<= x(3) and y(0); 
 
 x01<= x(0) and y(1);
 x11<= x(1) and y(1);
 x21<= x(2) and y(1);
 x31<= x(3) and y(1);
 
 x02<= x(0) and y(2);
 x12<= x(1) and y(2);
 x22<= x(2) and y(2);
 x32<= x(3) and y(2);
 
 x03<= x(0) and y(3);
 x13<= x(1) and y(3);
 x23<= x(2) and y(3);
 x33<= x(3) and y(3);
 
 
      -- port mapping them all to make the multiplier

  FA1 : Full_Adder 
	port map(x01,x10,'0',s1,p1);

  FA2 : Full_Adder
	port map(x11,x20,s1,s2,k1);
 
  FA3 : Full_Adder
	port map(x21,x30,s2,s3,k2);
	
  FA4 : Full_Adder
	port map(x31,s3,'0',s4,k3);
    
 --

 FA5 : Full_Adder
	port map(x02,k1,'0',s5,p2);
	
  FA6 : Full_Adder
	port map(x12,k2,s5,s6,k4 );
 
  FA7 : Full_Adder 
	port map(x22,k3,s6,s7,k5);
 
  FA8 : Full_Adder 
	port map(x32,s4,s7,s8,k6);	
	
--	
  FA9 : Full_Adder
	port map(x03,k4,'0',s9,p3);	
	
  FA10 : Full_Adder
	port map(x13,k5,s9,s10,p4);	
	
  FA11 : Full_Adder
	port map(x23,k6,s10,s11,p5);

  FA12 : Full_Adder
	port map(x33,s8,s11,p7,p6); 	
	
	
     Ans(0)<=x00; 	-- simply mapping the individual signals to the 'p' vector which is the final output vector of the multiplier code
     Ans(1)<=p1; 
     Ans(2)<=p2;
     Ans(3)<=p3;
     Ans(4)<=p4;
     Ans(5)<=p5;
     Ans(6)<=p6;
     Ans(7)<=p7;

     
end architecture;
