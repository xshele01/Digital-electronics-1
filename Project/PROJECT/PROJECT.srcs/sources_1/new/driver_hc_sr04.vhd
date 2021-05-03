--------------------------------------------------------------------------------
--
-- Driver for HC-SR04 Ultrasonic Sensor.
-- Arty A7-100T, Vivado v2020.2
--
-- Copyright (c) 2021 - Present Shelemba Pavlo
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity driver_hc_sr04 is
    port(
        clk     : in  std_logic;        -- Main clock
        echo_i  : in  std_logic;        -- Echo signal from the sensor
        trig_o  : out std_logic;        -- Trigger signal to the sensor
        cm_o    : out std_logic_vector (8-1 downto 0) -- Distance in cm
        );
end driver_hc_sr04;

architecture behavioral of driver_hc_sr04 is

    -- Internal trigger
    signal s_trig      : std_logic;
    -- Internal 21-bit counter
    signal pulse_width : std_logic_vector(21-1 downto 0); 
    
begin
    --------------------------------------------------------------------
    -- trigger:
    -- Instance of trigger entity generates a trigger pulse for ultrasonic
    -- sensor, enabling it to start emitting pulses.
    --------------------------------------------------------------------
    trigger : entity work.trigger
        generic map(
            g_MAX       => 10000000,  -- 100 ms
            g_LENGTH    => 1000       -- 10 us
        )
        port map(
            clk         => clk,
            reset       => '0',
            trig_o      => s_trig
        );
        
    --------------------------------------------------------------------
    -- counter:
    -- Instance of cnt_up_down entity counts length of the recieved
    -- echo signal
    --------------------------------------------------------------------
    counter : entity work.cnt_up_down
        generic map(
            g_N_BITS    => 21
        )
        port map(
            clk         => clk,
            reset       => s_trig,
            en_i        => echo_i,
            cnt_up_i    => '1',
            cnt_o       => pulse_width
        );

    --------------------------------------------------------------------
    -- p_distance:
    -- Calculate distance in cm from the length of the recieved echo  
    -- signal (pulse_width). Division in the calculation is replaced by 
    -- multiplication with bit shifting for faster performance.
    -- Resolution of the sensor is redused to 2.5m.
    --------------------------------------------------------------------
    p_distance : process(echo_i)
        constant cnst     : unsigned(6-1 downto 0) := to_unsigned(45,6);
        variable product  : unsigned(27-1 downto 0);
        variable distance : unsigned(8-1 downto 0);
    begin
            if (echo_i = '0') then
                product  := unsigned(pulse_width) * cnst;
                distance := product(27-1 downto 19) + (2**17);
                if (distance > 255) then
                    cm_o <= "11111111";
                else 
                    cm_o <= std_logic_vector(distance);
                end if;
            end if;
    end process p_distance;
    
    -- Assign internal trigger to the output
    trig_o <= s_trig;
    
end behavioral;
