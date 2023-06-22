library ieee;
use ieee.std_logic_1164.all;
-----------------------------Sequential Multiplexer-----------------
entity Mux_4_to_1 is
port(A : in std_logic_vector(3 downto 0 );   -- these are the 4 bit inputs to the MUX from the add,sub,multiplier
     B : in std_logic_vector(3 downto 0 );
     C : in  std_logic_vector(3 downto 0 );
     D : in  std_logic_vector(3 downto 0 );
     Sel : in  bit_vector(1 downto 0 ); 
     F : inout  std_logic_vector(3 downto 0 )
     );
end Mux_4_to_1;

architecture behaviour of Mux_4_to_1 is

begin

 pro:  process (Sel)

   begin       
    
   case (sel) is 
     when "00" =>  F<=A ;      -- "00"  for  subtraction.
     when "01" =>  F<=B ;      -- "01"  for  addition.
     when "10" =>  F<=C ;      -- "10"  for  multiplication
     when "11" =>  F<=D ;      -- "10"  for  division
   --  when others =>  F<=D ;
   end case;
end process;

end architecture;

