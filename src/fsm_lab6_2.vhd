library ieee;
use ieee.std_logic_1164.all;

entity fsm_lab6_2 is
    port (
        clk         : in  std_logic;
        resetn      : in  std_logic;                  -- active-low reset
        current_state : out std_logic_vector(3 downto 0);   -- goes to decoder
        student1_id    : out std_logic_vector(3 downto 0)    -- goes to ALU
    );
end entity;

architecture fsm of fsm_lab6_2 is

    -- 9-state FSM for microcode (0 to 8)
    type mc_state_type is (m0, m1, m2, m3, m4, m5, m6, m7, m8);

    -- 9-state FSM for student ID digits
    type id_state_type is (i0, i1, i2, i3, i4, i5, i6, i7, i8);

    signal mc_state : mc_state_type;
    signal id_state : id_state_type;

begin

    -- STATE TRANSITIONS (both FSMs advance together)
    process(clk, resetn)
    begin
        if resetn = '0' then
            mc_state <= m0;
            id_state <= i0;

        elsif rising_edge(clk) then

            -- microcode FSM (0 → 8 → 0)
            case mc_state is
                when m0 => mc_state <= m1;
                when m1 => mc_state <= m2;
                when m2 => mc_state <= m3;
                when m3 => mc_state <= m4;
                when m4 => mc_state <= m5;
                when m5 => mc_state <= m6;
                when m6 => mc_state <= m7;
                when m7 => mc_state <= m8;
                when m8 => mc_state <= m0;
                when others => mc_state <= m0;
            end case;

            -- ID-digit FSM (cycles through the 9 input digits)
            case id_state is
                when i0 => id_state <= i1;
                when i1 => id_state <= i2;
                when i2 => id_state <= i3;
                when i3 => id_state <= i4;
                when i4 => id_state <= i5;
                when i5 => id_state <= i6;
                when i6 => id_state <= i7;
                when i7 => id_state <= i8;
                when i8 => id_state <= i0;
                when others => id_state <= i0;
            end case;

        end if;
    end process;

	 
    -- OUTPUT LOGIC (Moore: depends only on state)

    -- microcode output for decoder
    process(mc_state)
    begin
        case mc_state is
            when m0 => current_state <= "0000";  -- 0
            when m1 => current_state <= "0001";  -- 1
            when m2 => current_state <= "0010";  -- 2
            when m3 => current_state <= "0011";  -- 3
            when m4 => current_state <= "0100";  -- 4
            when m5 => current_state <= "0101";  -- 5
            when m6 => current_state <= "0110";  -- 6
            when m7 => current_state <= "0111";  -- 7
            when m8 => current_state <= "1000";  -- 8
            when others => current_state <= "0000";
        end case;
    end process;


    -- ID-digit output.
    -- NOTE: the original digits were a student number and have been
    -- replaced with a neutral sequence for public release. The FSM
    -- structure and timing are unchanged.
    process(id_state)
    begin
        case id_state is
            when i0 => student1_id <= "0001";  -- 1
            when i1 => student1_id <= "0010";  -- 2
            when i2 => student1_id <= "0011";  -- 3
            when i3 => student1_id <= "0100";  -- 4
            when i4 => student1_id <= "0101";  -- 5
            when i5 => student1_id <= "0110";  -- 6
            when i6 => student1_id <= "0111";  -- 7
            when i7 => student1_id <= "1000";  -- 8
            when i8 => student1_id <= "1001";  -- 9
            when others => student1_id <= "0000";
        end case;
    end process;

end architecture;
