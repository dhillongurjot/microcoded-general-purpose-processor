LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY register8 IS
    PORT (
        A      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);   -- 8-bit input
        Resetn : IN  STD_LOGIC;                      -- active low reset
        Clock  : IN  STD_LOGIC;                      -- clock
        Q      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)    -- 8-bit output
    );
END register8;

ARCHITECTURE Behavior OF register8 IS
BEGIN
    PROCESS (Resetn, Clock)
    BEGIN
        IF Resetn = '0' THEN
            Q <= "00000000";
        ELSIF Clock'EVENT AND Clock = '1' THEN
            Q <= A;
        END IF;
    END PROCESS;
END Behavior;
