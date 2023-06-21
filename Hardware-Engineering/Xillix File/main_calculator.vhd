library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_calculator is
    Port (
        A, B: in std_logic_vector(3 downto 0);
        OP: in std_logic_vector(1 downto 0);
        Equals, Clear: in std_logic;
        Result: out std_logic_vector(3 downto 0)
    );
end main_calculator;

architecture Behavioral of main_calculator is
begin
    process(A, B, OP, Equals, Clear)
        variable temp: integer;
    begin
        if Clear = '1' then
            temp := 0; -- Reset temp to zero when Clear is active
        elsif Equals = '1' then
            case OP is
                when "00" =>
                    temp := to_integer(unsigned(A)) + to_integer(unsigned(B));
                when "01" =>
                    temp := to_integer(unsigned(A)) - to_integer(unsigned(B));
                when "10" =>
                    temp := to_integer(unsigned(A)) * to_integer(unsigned(B));
                when "11" =>
                    temp := to_integer(unsigned(A)) / to_integer(unsigned(B));
            end case;
        end if;
        
        Result <= std_logic_vector(to_unsigned(temp, 4));
    end process;
end Behavioral;
