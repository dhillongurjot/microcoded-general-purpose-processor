library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu2 is
    port(
        Clock : in std_logic;
        A, B  : in unsigned(7 downto 0);
        OP    : in unsigned(15 downto 0);   -- one-hot selector
        Neg   : out std_logic;              -- not used
        R1    : out unsigned(3 downto 0);   -- low nibble
        R2    : out unsigned(3 downto 0)    -- high nibble
    );
end alu2;

architecture calculation of alu2 is
    signal Reg1, Reg2 : unsigned(7 downto 0) := (others => '0');
    signal Result     : unsigned(7 downto 0) := (others => '0');
begin

    -- Store inputs
    Reg1 <= A;
    Reg2 <= B;
    Neg  <= '0';

    process(Clock)
    begin
        if rising_edge(Clock) then

            case OP is

                -------------------------------------------------------------------
                -- FUNCTION 1: Increment A by 2
                -------------------------------------------------------------------
                when "0000000000000001" =>
                    Result <= Reg1 + 2;

                -------------------------------------------------------------------
                -- FUNCTION 2: Logical shift right B by 2, input bit = 0
                -------------------------------------------------------------------
                when "0000000000000010" =>
                    Result <= "00" & Reg2(7 downto 2);

                -------------------------------------------------------------------
                -- FUNCTION 3: Shift A right by 4, input bit = 1
                -------------------------------------------------------------------
                when "0000000000000100" =>
                    Result <= "1111" & Reg1(7 downto 4);

                -------------------------------------------------------------------
                -- FUNCTION 4: Min(A, B)
                -------------------------------------------------------------------
                when "0000000000001000" =>
                    if Reg1 < Reg2 then
                        Result <= Reg1;
                    else
                        Result <= Reg2;
                    end if;

                -------------------------------------------------------------------
                -- FUNCTION 5: Rotate A right by 2 bits
                -------------------------------------------------------------------
                when "0000000000010000" =>
                    Result <= Reg1(1 downto 0) & Reg1(7 downto 2);

                -------------------------------------------------------------------
                -- FUNCTION 6: Reverse bit order of B
                -------------------------------------------------------------------
                when "0000000000100000" =>
                    Result <= Reg2(0) & Reg2(1) & Reg2(2) & Reg2(3) &
                              Reg2(4) & Reg2(5) & Reg2(6) & Reg2(7);

                -------------------------------------------------------------------
                -- FUNCTION 7: A XOR B
                -------------------------------------------------------------------
                when "0000000001000000" =>
                    Result <= Reg1 xor Reg2;

                -------------------------------------------------------------------
                -- FUNCTION 8: (A + B) - 4
                -------------------------------------------------------------------
                when "0000000010000000" =>
                    Result <= (Reg1 + Reg2) - 4;

                -------------------------------------------------------------------
                -- FUNCTION 9: Output all 1s (255)
                -------------------------------------------------------------------
                when "0000000100000000" =>
                    Result <= (others => '1');

                -------------------------------------------------------------------
                -- DEFAULT
                -------------------------------------------------------------------
                when others =>
                    Result <= (others => '0');

            end case;

        end if;
    end process;

    -- Split result into 2 nibbles
    R1 <= Result(3 downto 0);
    R2 <= Result(7 downto 4);

end calculation;
