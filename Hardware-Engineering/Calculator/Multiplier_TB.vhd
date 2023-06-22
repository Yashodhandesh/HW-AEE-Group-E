library ieee;
use ieee.std_logic_1164.all;

entity Multiplier_TB is
end entity;

architecture behavioral of Multiplier_TB is

    signal A_TB, B_TB : std_logic_vector(3 downto 0);
    signal Ans_TB : std_logic_vector(7 downto 0);

    component Multiplier is
        port (
            x : in  std_logic_vector(3 downto 0);
            y : in  std_logic_vector(3 downto 0);
            Ans : out std_logic_vector(7 downto 0)
        );
    end component;

begin

    -- Instantiate the DUT (Design Under Test)
    uut: Multiplier port map (
        x => A_TB,
        y => B_TB,
        Ans => Ans_TB
    );

    -- Stimulus process
    stimulus: process
    begin
        -- Initialize inputs
        A_TB <= "0101";
        B_TB <= "0011";
        wait for 10 ns;

        A_TB <= "0110";
        B_TB <= "1010";
        wait for 10 ns;

        
         A_TB <= "0010";
         B_TB <= "0110";
         wait for 10 ns;

         A_TB <= "1111";
         B_TB <= "0101";
         wait for 10 ns;

        -- End the simulation
        wait;
    end process;

end behavioral;


