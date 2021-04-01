------------------------------------------------------------------------
--
-- Smart traffic light controller using FSM.
-- Based on exercise by prof. Jon Valvano from University of Texas.
-- Nexys A7-50T, Vivado v2020.2
--
-- Copyright (c) 2020-Present Shelemba Pavlo
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for traffic light controller
------------------------------------------------------------------------
entity smart_tlc is
    port(
        clk         : in    std_logic;
        reset       : in    std_logic;
        -- Sensors
        sensor      : in    std_logic_vector(2 - 1 downto 0);
        -- Traffic lights (RGB LEDs) for two directions
        south_o     : out   std_logic_vector(3 - 1 downto 0);
        west_o      : out   std_logic_vector(3 - 1 downto 0)
    );
end entity smart_tlc;

------------------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------------------
architecture Behavioral of smart_tlc is

    -- Define the states
    type   t_state is (STOP1, WEST_GO,  WEST_WAIT,
                       STOP2, SOUTH_GO, SOUTH_WAIT);
    -- Define the signal that uses different states
    signal s_state  : t_state;
    
    -- Internal clock enable
    signal s_en     : std_logic;
    -- Local delay counter
    signal s_cnt    : unsigned(5 - 1 downto 0);

    -- Specific values for local counter
    constant c_DELAY_GO   : unsigned(5 - 1 downto 0) := b"1_0000"; -- 4 sec
    constant c_DELAY_WAIT : unsigned(5 - 1 downto 0) := b"0_1000"; -- 2 sec
    constant c_DELAY_1SEC : unsigned(5 - 1 downto 0) := b"0_0100"; -- 1 sec
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000"; -- zero

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 250 ms (4 Hz). Remember that the frequency of the clock 
    -- signal is 100 MHz.
    --------------------------------------------------------------------
    -- JUST FOR SHORTER/FASTER SIMULATION
    s_en <= '1';
--    clk_en0 : entity work.clock_enable
--        generic map(
--            g_MAX =>        -- g_MAX = 250 ms / (1/100 MHz)
--        )
--        port map(
--            clk   => clk,
--            reset => reset,
--            ce_o  => s_en
--        );

    --------------------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and clock_enable 
    -- entirely controls the s_state signal by CASE statement.
    --------------------------------------------------------------------
    p_smart_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC (1 sec)
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- If cars in South Direction
                            if (sensor = "10") then
                                -- Skip to the SOUTH_GO state
                                s_state <= SOUTH_GO;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            else
                                -- Move to the next state
                                s_state <= WEST_GO;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;

                    when WEST_GO =>
                       -- Count up to c_DELAY_GO (4 sec)
                        if (s_cnt < c_DELAY_GO) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- If No Cars or cars in West Direction only
                            if (sensor = "00" or sensor = "01") then
                                -- Stay on the same state
                                s_state <= WEST_GO;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            -- If cars in South Direction or Both Directions
                            elsif (sensor = "10" or sensor = "11") then
                                -- Move to the next state
                                s_state <= WEST_WAIT;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;
                        
                    when WEST_WAIT =>
                       -- Count up to c_DELAY_WAIT (2 sec)
                        if (s_cnt < c_DELAY_WAIT) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;  
                               
                    when STOP2 =>
                       -- Count up to c_DELAY_1SEC (1 sec)
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- If cars in West Direction
                            if (sensor = "01") then
                                -- Skip to the WEST_GO state
                                s_state <= WEST_GO;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            else
                                -- Move to the next state
                                s_state <= SOUTH_GO;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            end if;
                        end if; 
                        
                    when SOUTH_GO =>
                       -- Count up to c_DELAY_GO (4 sec)
                        if (s_cnt < c_DELAY_GO) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- If No Cars or cars in South Direction only
                            if (sensor = "00" or sensor = "10") then
                                -- Stay on the same state
                                s_state <= SOUTH_GO;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            -- If cars in West Direction or Both Directions
                            elsif (sensor = "01" or sensor = "11") then
                                -- Move to the next state
                                s_state <= SOUTH_WAIT;
                                -- Reset local counter value
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;  
                        
                    when SOUTH_WAIT =>
                       -- Count up to c_DELAY_WAIT (2 sec)
                        if (s_cnt < c_DELAY_WAIT) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;   
                        
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_smart_traffic_fsm;

    --------------------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state changes, and sets
    -- the output signals accordingly. This is an example of a Moore 
    -- state machine because the output is set based on the active state.
    --------------------------------------------------------------------
    p_smart_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "100";   -- Red
            when WEST_GO =>
                south_o <= "100";   -- Red
                west_o  <= "010";   -- Green (RGB = 010)
            when WEST_WAIT =>
                south_o <= "100";   -- Red
                west_o  <= "110";   -- Yellow (RGB = 110)
            when STOP2 =>
                south_o <= "100";   -- Red 
                west_o  <= "100";   -- Red 
            when SOUTH_GO =>
                south_o <= "010";   -- Green 
                west_o  <= "100";   -- Red 
            when SOUTH_WAIT =>
                south_o <= "110";   -- Yellow
                west_o  <= "100";   -- Red
            when others =>
                south_o <= "100";   -- Red
                west_o  <= "100";   -- Red
        end case;
    end process p_smart_output_fsm;

end architecture Behavioral;
