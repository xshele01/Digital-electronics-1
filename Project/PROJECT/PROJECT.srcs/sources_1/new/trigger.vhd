------------------------------------------------------------------------
--
-- Generates triggers for HC-SR04 Ultrasonic Sensor.
-- Arty A7-100T, Vivado v2020.2
--
-- Copyright (c) 2021-Present Pavlo Shelemba
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;                -- Standard library
use ieee.std_logic_1164.all; -- Package for data types and logic operations
use ieee.numeric_std.all;    -- Package for arithmetic operations

------------------------------------------------------------------------
-- Entity declaration for trigger
------------------------------------------------------------------------
entity trigger is
    generic(
        g_MAX    : natural := 10; -- Number of clk pulses between triggers
        g_LENGTH : natural := 5   -- Number of trigger clk pulses
    );
    port(
        clk      : in  std_logic;      -- Main clock
        reset    : in  std_logic;      -- Synchronous reset
        trig_o   : out std_logic       -- Trigger pulse signal
    );
end entity trigger;

------------------------------------------------------------------------
-- Architecture body for trigger
------------------------------------------------------------------------
architecture behavioral of trigger is

    -- Local counter
    signal s_cnt_local : natural;
    -- Internal trigger signal
    signal s_trig      : std_logic := '1';
    
begin
    --------------------------------------------------------------------
    -- p_trigger:
    -- Generate trigger signal. By default, trigger signal is low 
    -- and generated pulse is g_LENGTH clocks long.
    --------------------------------------------------------------------
    p_trigger : process(clk)
    begin
        if rising_edge(clk) then                -- Synchronous process
            if (reset = '1') then               -- High active reset
                s_cnt_local <= 0;				-- Clear local counter
                s_trig      <= '0'; 			-- Clear trigger output
            elsif (s_trig = '0' and s_cnt_local >= (g_MAX - 1)) then
                s_cnt_local <= 0;
                s_trig      <= '1';             -- Generate trigger pulse
            elsif (s_trig = '1' and s_cnt_local < (g_LENGTH - 1)) then
            	s_cnt_local <= s_cnt_local + 1; -- Advance internal counter
            	s_trig      <= '1';
            else
                s_cnt_local <= s_cnt_local + 1;
                s_trig      <= '0';             
            end if;
        end if;
    end process p_trigger;
    
    -- Assign internal trigger to the output
    trig_o <= s_trig;
    
end architecture behavioral;
