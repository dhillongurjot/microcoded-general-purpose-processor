library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;   -- add this

entity seg7 is
    port(
        bcd   : in  std_logic_vector(3 downto 0);   -- S[3..0] from ASU
        sign  : in  std_logic;                      -- 0 = +, 1 = -
        leds1 : out std_logic_vector(6 downto 0);   -- HEXx (magnitude)
        leds2 : out std_logic_vector(6 downto 0)    -- HEXy (minus sign)
    );
end seg7;

architecture behave of seg7 is
    signal mag : std_logic_vector(3 downto 0);
begin
    -- 2’s complement to magnitude when negative
    mag <= (not bcd) + "0001" when sign = '1' else bcd;

    process(mag)
    begin
        case mag is
            when "0000" => leds1 <= "0000001"; -- 0
            when "0001" => leds1 <= "1001111"; -- 1
            when "0010" => leds1 <= "0010010"; -- 2
            when "0011" => leds1 <= "0000110"; -- 3
            when "0100" => leds1 <= "1001100"; -- 4
            when "0101" => leds1 <= "0100100"; -- 5
            when "0110" => leds1 <= "0100000"; -- 6
            when "0111" => leds1 <= "0001111"; -- 7
            when "1000" => leds1 <= "0000000"; -- 8
            when "1001" => leds1 <= "0000100"; -- 9
            when "1010" => leds1 <= "0001000"; -- A
            when "1011" => leds1 <= "1100000"; -- b
            when "1100" => leds1 <= "0110001"; -- C
            when "1101" => leds1 <= "1000010"; -- d
            when "1110" => leds1 <= "0110000"; -- E
            when "1111" => leds1 <= "0111000"; -- F
            when others => leds1 <= "1111111"; -- blank
        end case;
    end process;

    -- minus sign on second HEX
    leds2 <= "1111110" when sign = '1' else "1111111";
end behave;
