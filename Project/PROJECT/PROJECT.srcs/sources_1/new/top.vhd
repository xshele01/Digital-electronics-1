----------------------------------------------------------------------------------
-- 
-- Top module for parking assistant
-- Arty A7-100T, Vivado v2020.2
--
-- Copyright (c) 2021 - Present Shelemba Pavlo
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( 
        CLK100MHZ   : in  STD_LOGIC;                       -- Main clock
        sw_i        : in  STD_LOGIC_VECTOR (2-1 downto 0); -- Switches to operate system
        echo_i      : in  STD_LOGIC_VECTOR (2-1 downto 0); -- PMOD connectors
        --
        cm_o        : out std_logic_vector(8-1 downto 0);  -- Distanсe output (for testbench)
        --
        trig_o      : out STD_LOGIC_VECTOR (2-1 downto 0); -- Triger signals to sensors
        pwm_o       : out STD_LOGIC;
        led         : out STD_LOGIC_VECTOR (4-1 downto 0); -- LEDs for bargrapgh
        -- RGB LEDs
        led0_b      : out STD_LOGIC;
        led0_g      : out STD_LOGIC;
        led0_r      : out STD_LOGIC;
        led1_b      : out STD_LOGIC;
        led1_g      : out STD_LOGIC;
        led1_r      : out STD_LOGIC;
        led2_b      : out STD_LOGIC;
        led2_g      : out STD_LOGIC;
        led2_r      : out STD_LOGIC;
        led3_b      : out STD_LOGIC;
        led3_g      : out STD_LOGIC;
        led3_r      : out STD_LOGIC
        );
end top;

architecture behavioral of top is

    signal s_echo   : std_logic := '0';
    signal s_trig   : std_logic := '0';
    signal s_cm     : std_logic_vector(8-1 downto 0);
    signal s_rgb    : std_logic_vector(3-1 downto 0);
    
begin
    --------------------------------------------------------------------
    -- Instance of driver_hc_sr04 entity
    -------------------------------------------------------------------- 
    driver : entity work.driver_hc_sr04
        port map(
            clk     => CLK100MHZ,
            echo_i  => s_echo, 
            trig_o  => s_trig,
            cm_o    => s_cm
        );
    --------------------------------------------------------------------
    -- Instance of bargraph entity
    -------------------------------------------------------------------- 
    bargraph : entity work.bargraph
        port map(
            cm_i    => s_cm,
            bar_o   => led(4-1 downto 0),
            rgb_o   => s_rgb
        );
    --------------------------------------------------------------------
    -- Instance of switch entity
    -------------------------------------------------------------------- 
    switch : entity work.switch
        port map(
            sw_i    => sw_i,    
            echo_i  => echo_i,
            trig_i  => s_trig,
            echo_o  => s_echo,
            trig_o  => trig_o
        );
    --------------------------------------------------------------------
    -- Instance of pwm entity
    --------------------------------------------------------------------    
    pwm : entity work.pwm
        port map(
            clk     => CLK100MHZ,
            cm_i    => s_cm,
            pwm_o   => pwm_o
        );

-- Connect local signals with on-board RGB LEDs
led0_r <= s_rgb(2);
led0_g <= s_rgb(1);
led0_b <= s_rgb(0);
led1_r <= s_rgb(2);
led1_g <= s_rgb(1);
led1_b <= s_rgb(0);
led2_r <= s_rgb(2);
led2_g <= s_rgb(1);       
led2_b <= s_rgb(0);     
led3_r <= s_rgb(2);
led3_g <= s_rgb(1);       
led3_b <= s_rgb(0); 

-- Distance value for testbench
cm_o <= s_cm;

end behavioral;
