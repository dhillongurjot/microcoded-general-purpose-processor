library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        Clock : in std_logic;
        A, B  : in unsigned(7 downto 0);
        OP    : in unsigned(15 downto 0);   -- one-hot selector
        Neg   : out std_logic;              -- not used for this table
        R1    : out unsigned(3 downto 0);   -- low nibble
        R2    : out unsigned(3 downto 0)    -- high nibble
    );
end alu;

architecture calculation of alu is
    signal Reg1, Reg2 : unsigned(7 downto 0) := (others => '0');
    signal Result     : unsigned(7 downto 0) := (others => '0');
begin

    -- Store inputs
    Reg1 <= A;
    Reg2 <= B;
    Neg  <= '0';   -- always zero (not used)

    process(Clock)
    begin
        if rising_edge(Clock) then

            case OP is

                -- 1: sum(A,B)
                when "0000000000000001" =>
                    Result <= Reg1 + Reg2;

                -- 2: diff(A,B)
                when "0000000000000010" =>
                    Result <= Reg1 - Reg2;

                -- 3: NOT A
                when "0000000000000100" =>
                    Result <= not Reg1;

                -- 4: complement(A AND B) = NAND
                when "0000000000001000" =>
                    Result <= not (Reg1 and Reg2);

                -- 5: complement(A OR B) = NOR
                when "0000000000010000" =>
                    Result <= not (Reg1 or Reg2);

                -- 6: A AND B
                when "0000000000100000" =>
                    Result <= (Reg1 and Reg2);

                -- 7: A XOR B
                when "0000000001000000" =>
                    Result <= (Reg1 xor Reg2);

                -- 8: A OR B
                when "0000000010000000" =>
                    Result <= (Reg1 or Reg2);

                -- 9: complement(A XOR B) = XNOR
                when "0000000100000000" =>
                    Result <= not (Reg1 xor Reg2);

                when others =>
                    Result <= (others => '0');

            end case;

        end if;
    end process;

    -- Split 8-bit result into two nibbles for HEX displays
    R1 <= Result(3 downto 0);
    R2 <= Result(7 downto 4);

end calculation;
