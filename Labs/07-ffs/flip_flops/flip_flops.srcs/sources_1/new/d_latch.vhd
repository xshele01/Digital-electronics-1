------------------------------------------------------------------------
--
-- D latch (Transparent latch)
-- Nexys A7-50T, Vivado v2020.2
--
-- Copyright (c) 2021 - Present Shelemba Pavlo
-- This work is licensed under the terms of the MIT license
--
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch is
    Port ( en       : in    STD_LOGIC;
           d        : in    STD_LOGIC;
           arst     : in    STD_LOGIC;
           q        : out   STD_LOGIC;
           q_bar    : out   STD_LOGIC
           );
end entity d_latch;

architecture Behavioral of d_latch is
begin
    p_d_latch : process(en, d, arst)
    begin
        if (arst = '1') then
            q       <= '0';
            q_bar   <= '1';
        elsif (en = '1') then
            q       <= d;
            q_bar   <= not d;
        end if;  
    end process p_d_latch;
end architecture Behavioral;
