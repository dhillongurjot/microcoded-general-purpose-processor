library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu3 is
    port(
        Clock      : in  std_logic;
        A, B       : in  unsigned(7 downto 0);
        OP         : in  unsigned(15 downto 0);     -- microcode selector
        student_id : in  unsigned(3 downto 0);      -- from FSM
        YN         : out unsigned(3 downto 0)       -- 4-bit output to sseg
    );
end alu3;

architecture calculation of alu3 is

    signal Reg1, Reg2 : unsigned(7 downto 0) := (others => '0');
    signal A_high     : unsigned(3 downto 0);
    signal A_low      : unsigned(3 downto 0);
    signal yn_code    : unsigned(3 downto 0);       -- 4-bit y/n code

begin

    -- Split A into its two digits
    A_high <= A(7 downto 4);
    A_low  <= A(3 downto 0);

    Reg1 <= A;
    Reg2 <= B;


    -- FINAL output is only "y" or "n" (Part F).
    process(Clock)
    begin
        if rising_edge(Clock) then

            -- Part F: y if one of A's digits is less than student_id
            if (A_high < student_id) or (A_low < student_id) then
                yn_code <= "0001";      -- y
            else
                yn_code <= "0000";      -- n
            end if;

        end if;
    end process;

    -- Output the 4-bit code to sseg
    YN <= yn_code;

end calculation;
