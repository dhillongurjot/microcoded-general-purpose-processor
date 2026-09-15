LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dec3to8 IS
    PORT (
        w  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        En : IN  STD_LOGIC;
        y  : OUT STD_LOGIC_VECTOR(0 TO 7)
    );
END dec3to8;

ARCHITECTURE Behavior OF dec3to8 IS
    SIGNAL Enw : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

    -- Combine enable + 3-bit input → 4-bit vector
    Enw <= En & w;

    -- One-hot output based on Enw
    WITH Enw SELECT
        y <= "10000000" WHEN "1000",   -- w = 000
             "01000000" WHEN "1001",   -- w = 001
             "00100000" WHEN "1010",   -- w = 010
             "00010000" WHEN "1011",   -- w = 011
             "00001000" WHEN "1100",   -- w = 100
             "00000100" WHEN "1101",   -- w = 101
             "00000010" WHEN "1110",   -- w = 110
             "00000001" WHEN "1111",   -- w = 111
             "00000000" WHEN OTHERS;   -- En = 0 OR invalid

END Behavior;
