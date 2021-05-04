----------------------------------------------------------------------------------
-- 
-- Switch module for controlling parking assistant
-- Arty A7-100T, Vivado v2020.2
--
-- Copyright (c) 2021 - Present Shelemba Pavlo
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
  Port ( 
        sw_i    : in  STD_LOGIC_VECTOR (2-1 downto 0); -- On-board switches
        echo_i  : in  STD_LOGIC_VECTOR (2-1 downto 0); -- Echo signal from sensors
        trig_i  : in  STD_LOGIC;                       -- Trigger signal from driver
        echo_o  : out STD_LOGIC;                       -- Echo signal to driver
        trig_o  : out STD_LOGIC_VECTOR (2-1 downto 0)  -- Trigger signal to sensors
        );
end switch;

architecture behavioral of switch is

begin
    --------------------------------------------------------------------
    -- p_switch:
    -- Turn parking assistant on and off using sw_i(0).
    -- Select front or rear ultrasonic sensor using sw_i(1), 
    -- as in forward and reverse gear in a real car.
    --------------------------------------------------------------------
    p_switch : process(sw_i, trig_i, echo_i)
    begin    
        if sw_i(0) = '1' then             -- If assistant is on
            -- Redistribute signals from and to the corresponding inputs/outputs
            if sw_i(1) = '1' then         
                trig_o <= '0' & trig_i;
                echo_o <= echo_i(0);
            else 
                trig_o <= trig_i & '0';
                echo_o <= echo_i(1);
            end if;
        else
            trig_o <= "00";
        end if;
    end process p_switch;

end behavioral;
