library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sseg3 is
    port(
        bdc : in  std_logic_vector(3 downto 0);   -- 0000 = n, 0001 = y
        hex : out std_logic_vector(6 downto 0)    -- active-low HEX display
    );
end sseg3;

architecture behave of sseg3 is
begin

    process(bdc)
    begin
        case bdc is
            when "0000" => hex <= "0001001";  -- n
            when "0001" => hex <= "1000100";  -- y
            when others => hex <= "1111111";  -- blank
        end case;
    end process;

end behave;
