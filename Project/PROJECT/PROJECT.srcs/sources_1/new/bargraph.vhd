------------------------------------------------------------------------
--
-- Bargraph for HC_SR04 Ultrasonic Sensor.
-- Arty A7-100T, Vivado v2020.2
--
-- Copyright (c) 2021 - Present Shelemba Pavlo
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bargraph is
    port (
        cm_i   : in  STD_LOGIC_VECTOR (8-1 downto 0); -- Calculated distance value
        bar_o  : out STD_LOGIC_VECTOR (4-1 downto 0); -- LED output
        rgb_o  : out STD_LOGIC_VECTOR (3-1 downto 0)  -- RGB LED output
        );
end bargraph;

architecture behavioral of bargraph is

begin
    --------------------------------------------------------------------
    -- p_bargraph:
    -- Display calculated distance in cm using on-board LEDs.  
    -- Display safety level of calculated distance using on-board RGB LEDs.
    --------------------------------------------------------------------
    p_bargraph : process(cm_i)
    begin
        if (cm_i = "11111111") then      -- If 255 cm or more
            bar_o <= "0000";             -- Clear output
            rgb_o <= "000";                           
        elsif (cm_i >= "01100100") then  -- If more then 100 cm
            bar_o <= "0001";        
            rgb_o <= "010";              -- Green (RGB = 010)
        elsif (cm_i >= "00111100") then  -- If more then 60 cm
            bar_o <= "0011";
            rgb_o <= "110";              -- Yellow (RGB = 110)
        elsif (cm_i >= "00011110") then  -- If more then 30 cm
            bar_o <= "0111";
            rgb_o <= "110";
        elsif (cm_i > "00000000") then   -- If less then 30 cm
            bar_o <= "1111";
            rgb_o <= "100";              -- Red (RGB = 100)
        else                             -- If no distance detected
            bar_o <= "0000";
            rgb_o <= "000";
        end if;
    end process p_bargraph;

end behavioral;
