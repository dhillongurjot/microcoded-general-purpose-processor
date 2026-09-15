library ieee;
use ieee.std_logic_1164.all;

entity fsm_lab6 is
    port (
        clk           : in  std_logic;
        resetn        : in  std_logic;                 -- active low reset
        current_state : out std_logic_vector(3 downto 0)
    );
end entity;

architecture fsm of fsm_lab6 is

    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);

    -- Register to hold the current state
    signal yfsm : state_type;

begin

    process (clk, resetn)
    begin
        if resetn = '0' then               -- when reset is low, go to s0
            yfsm <= s0;

        elsif clk'event and clk = '1' then -- rising edge
            -- Determine the next state 
            case yfsm is
                when s0 => yfsm <= s1;
                when s1 => yfsm <= s2;
                when s2 => yfsm <= s3;
                when s3 => yfsm <= s4;
                when s4 => yfsm <= s5;
                when s5 => yfsm <= s6;
                when s6 => yfsm <= s7;
                when s7 => yfsm <= s8;
                when s8 => yfsm <= s9;     
					 when s9 => yfsm <= s0;   -- wrap back to 0
                when others => yfsm <= s0;
            end case;
        end if;
    end process;


    -- OUTPUT LOGIC (Moore Machine → output depends ONLY on state)
    process (yfsm)
    begin
        case yfsm is
            when s0 => current_state <= "0000";  -- 0
            when s1 => current_state <= "0001";  -- 1
            when s2 => current_state <= "0010";  -- 2
            when s3 => current_state <= "0011";  -- 3
            when s4 => current_state <= "0100";  -- 4
            when s5 => current_state <= "0101";  -- 5
            when s6 => current_state <= "0110";  -- 6
            when s7 => current_state <= "0111";  -- 7
            when s8 => current_state <= "1000";  -- 8
				when s9 => current_state <= "1001";  -- 9
            when others => current_state <= "0000";
        end case;
    end process;

end architecture;
