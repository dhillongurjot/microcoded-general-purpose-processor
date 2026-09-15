LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dec4to16 IS
    PORT (
        S  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);   -- 4-bit select from FSM
        En : IN  STD_LOGIC;                     -- Enable
        OP : OUT STD_LOGIC_VECTOR(0 TO 15)      -- 16 one-hot outputs
    );
END dec4to16;

ARCHITECTURE Behavior OF dec4to16 IS
    SIGNAL EnS : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN

    -- Combine Enable with 4-bit select
    EnS <= En & S;

    -- One-hot 4→16 decoder
    WITH EnS SELECT
        OP <= "1000000000000000" WHEN "100000",   -- S = 0000
              "0100000000000000" WHEN "100001",   -- S = 0001
              "0010000000000000" WHEN "100010",   -- S = 0010
              "0001000000000000" WHEN "100011",   -- S = 0011
              "0000100000000000" WHEN "100100",   -- S = 0100
              "0000010000000000" WHEN "100101",   -- S = 0101
              "0000001000000000" WHEN "100110",   -- S = 0110
              "0000000100000000" WHEN "100111",   -- S = 0111
              "0000000010000000" WHEN "101000",   -- S = 1000
              "0000000001000000" WHEN "101001",   -- S = 1001
              "0000000000100000" WHEN "101010",   -- S = 1010
              "0000000000010000" WHEN "101011",   -- S = 1011
              "0000000000001000" WHEN "101100",   -- S = 1100
              "0000000000000100" WHEN "101101",   -- S = 1101
              "0000000000000010" WHEN "101110",   -- S = 1110
              "0000000000000001" WHEN "101111",   -- S = 1111
              "0000000000000000" WHEN OTHERS;     -- En = 0

END Behavior;
