----------------------------------------------------------------------------------
-- 
-- Testbench for the top module of parking assistant.
-- Arty A7-100T Vivado 2020.2
-- 
-- Copyright (c) 2021-Present Pavlo Shelemba
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_top is
-- Entity of testbench is always empty
end tb_top;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture behavioral of tb_top is

    --Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
    --Local signals
    signal s_CLK100MHZ  : STD_LOGIC;                      
    signal s_sw_i       : STD_LOGIC_VECTOR (2-1 downto 0);
    signal s_echo       : STD_LOGIC_VECTOR (2-1 downto 0);
    signal s_trig       : STD_LOGIC_VECTOR (2-1 downto 0);
    --
    signal cm_o         : std_logic_vector (8-1 downto 0);
    --
    signal s_pwm        : STD_LOGIC;     
    signal s_led        : STD_LOGIC_VECTOR (4-1 downto 0);
    signal s_led0_b     : STD_LOGIC;
    signal s_led0_g     : STD_LOGIC;
    signal s_led0_r     : STD_LOGIC;
    signal s_led1_b     : STD_LOGIC;
    signal s_led1_g     : STD_LOGIC;
    signal s_led1_r     : STD_LOGIC;
    signal s_led2_b     : STD_LOGIC;
    signal s_led2_g     : STD_LOGIC;
    signal s_led2_r     : STD_LOGIC;
    signal s_led3_b     : STD_LOGIC;
    signal s_led3_g     : STD_LOGIC;
    signal s_led3_r     : STD_LOGIC;
                            
begin
    --------------------------------------------------------------------
    -- Connecting testbench signals with top entity
    --------------------------------------------------------------------
    uut_top : entity work.top
        port map(
           CLK100MHZ => s_CLK100MHZ,
           sw_i        => s_sw_i,
           echo_i      => s_echo,
           --
           cm_o => cm_o, 
           -- 
           pwm_o => s_pwm,   
           trig_o      => s_trig,    
           led       => s_led,
           led0_b    => s_led0_b,
           led0_g    => s_led0_g,
           led0_r    => s_led0_r,
           led1_b    => s_led1_b,
           led1_g    => s_led1_g,
           led1_r    => s_led1_r,
           led2_b    => s_led2_b,
           led2_g    => s_led2_g,
           led2_r    => s_led2_r,
           led3_b    => s_led3_b,
           led3_g    => s_led3_g,
           led3_r    => s_led3_r
        ); 
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 300 ms loop
            s_CLK100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_CLK100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        s_sw_i <= "11";
        wait for 10 us;
        
        s_echo <= "01";
        wait for 580 us;
        s_echo <= "00";
        wait for 99420 us;
        
        s_echo <= "01";
        wait for 18560 us;
        s_echo <= "00";
        wait for 83160 us;
        
        s_sw_i <= "01";
        wait for 600 us;
        
        s_echo <= "10";
        wait for 4060 us;
        s_echo <= "00";
        wait for 95930 us;
        
        s_sw_i <= "00";
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait; -- Process is suspended forever
        
    end process p_stimulus;

end architecture behavioral;
