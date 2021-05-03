----------------------------------------------------------------------------------
-- 
-- Testbench for the top level of N-bit Up/Down binary counter.
-- Vivado 2020.2
-- 
-- Copyright (c) 2021-Present Pavlo Shelemba
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

        -- Number of bits for testbench counter

        constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
        --Local signals
           signal s_CLK100MHZ   :  STD_LOGIC;
           signal s_BTNC        :  STD_LOGIC;
           signal s_SW          :  STD_LOGIC_VECTOR (1 - 1 downto 0);
           signal s_LED         :  STD_LOGIC_VECTOR (16 - 1 downto 0);
           signal s_CA          :  STD_LOGIC;
           signal s_CB          :  STD_LOGIC;
           signal s_CC          :  STD_LOGIC;
           signal s_CD          :  STD_LOGIC;
           signal s_CE          :  STD_LOGIC;
           signal s_CF          :  STD_LOGIC;
           signal s_CG          :  STD_LOGIC;
           signal s_AN          :  STD_LOGIC_VECTOR (8 - 1 downto 0);
                            
begin

    -- Connecting testbench signals with hex_7seg entity (Unit Under Test)
    uut_top : entity work.top
        generic map(
            
        )
        port map(
            SW   => s_SW,
            BTNC => s_BTNC,
            
            CA   => s_CA,
            CB   => s_CB,
            CC   => s_CC,
            CD   => s_CD,
            CE   => s_CE,
            CF   => s_CF,
            CG   => s_CG,
        
            LED   => s_LED,
            AN   => s_AN
        );
        
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
        
    end process p_stimulus;

end architecture behavioral;
