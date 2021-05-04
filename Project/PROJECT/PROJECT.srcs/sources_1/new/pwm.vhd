------------------------------------------------------------------------
--
-- PWM generator.
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

entity pwm is
  port (
    clk   : in  std_logic;                     -- Main clock
    cm_i  : in std_logic_vector(8-1 downto 0); -- Calculated distance 
    pwm_o : out std_logic                      -- Output wave
  );
end pwm;

architecture behavioral of pwm is

    -- Internal pwm signal
    signal s_pwm    : std_logic;
    -- Period of pwm signal
    signal s_length : natural; 
    -- Duty cycle of pwm signal
    signal s_duty   : natural; 
    -- PWM signal enable
    signal s_en     : std_logic;
    
begin
    --------------------------------------------------------------------
    -- p_pwm:
    -- Changes rate of the sound signaling by changing period and duty cycle
    -- of the enable signal depending on the claculated distance. 
    --------------------------------------------------------------------
     p_pwm : process(cm_i)
     begin   
             if (cm_i = "11111111") then     -- if 255 cm or more
                 s_length   <= 0;             
                 s_duty     <= 0;                           
             elsif (cm_i >= "01100100") then -- if more then 100 cm   
                 s_length <= 10000000;       -- 2s
                 s_duty <= 2500000;          -- 25% 
             elsif (cm_i >= "00011110") then -- if more then 30 cm
                 s_length <= 5000000;        -- 1s                     
                 s_duty <= 2500000;          -- 50%
             elsif (cm_i > "00000000") then  -- if less then 30 cm     
                 s_length <= 1;              -- continuous signal  
                 s_duty <= 1;                              
             end if;
     end process p_pwm;
    --------------------------------------------------------------------
    -- p_vaweform:
    -- Generates pwm signal with fixed duty cycle  of 50% (max volume) and
    -- rate (pitch). Resulting pulse produces square wave at A3 note (440 Hz).
    --------------------------------------------------------------------
    p_vaweform : process(clk, s_en)
    	variable cnt : natural := 0;
    begin 
        if rising_edge(clk) then
            if s_en = '0' then
                pwm_o <= '0';
                cnt := 0;
            else
                if cnt <= 113636 then
                    cnt := cnt + 1;
                    pwm_o <= '1';
                elsif cnt > 113636 and cnt < 227273-1 then
                    cnt := cnt + 1;
                    pwm_o <= '0';
                else
                    cnt := 0;   
                end if;
            end if; 
        end if;
    end process p_vaweform;
    --------------------------------------------------------------------
    -- p_enable:
    -- Determines the pulsing rate at which generated square wave is played.
    -- From continuous to once a second.
    -- Based on a period and duty cycle from p_pwm process.
    --------------------------------------------------------------------
    p_enable : process(clk)
        variable cnt : natural := 0;
    begin
        if rising_edge(clk) then           -- Synchronous process
            if s_length > 0 and s_length /= s_duty then
                if (s_en = '0' and cnt >= (s_length - 1)) then
                    cnt  := 0;             -- Clear local counter
                    s_en <= '1';           -- Generate enable pulse
                elsif (s_en = '1' and cnt < (s_duty - 1)) then
                    cnt  := cnt + 1;       -- Advance internal counter
                else
                    cnt  := cnt + 1;
                    s_en <= '0';           -- Clear enable output
                end if;
            elsif s_length = s_duty and s_length /= 0 then
                s_en <= '1';
            else 
                s_en <= '0'; 
            end if;
        end if;
    end process p_enable;
    
end behavioral;
