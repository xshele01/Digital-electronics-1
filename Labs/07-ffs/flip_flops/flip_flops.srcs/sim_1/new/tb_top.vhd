------------------------------------------------------------------------
--                                                                      
-- Testbench for a shift register                                   
-- Nexys A7-50T, Vivado v2020.2                                         
--                                                                      
-- Copyright (c) 2021 - Present Shelemba Pavlo                          
-- This work is licensed under the terms of the MIT license             
--                                                                      
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is
--  Empty
end tb_top;

architecture Behavioral of tb_top is

       constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
       --Local signals
       signal s_BTNU        :  STD_LOGIC;
       signal s_BTNC        :  STD_LOGIC;
       signal s_SW          :  STD_LOGIC_VECTOR (1 - 1 downto 0);
       signal s_LED         :  STD_LOGIC_VECTOR (3 - 1 downto 0);
       
begin

    -- Connecting testbench signals with hex_7seg entity (Unit Under Test)
    uut_top : entity work.top
        port map(
            SW      => s_SW,
            BTNU    => s_BTNU,
            BTNC    => s_BTNC,
            LED     => s_LED
        );
        
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 300 ns loop         -- 30 periods of 100MHz clock
            s_BTNU <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_BTNU <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_BTNC      <= '0';
        wait for 100 ns;
        s_BTNC      <= '1';
        wait for 100 ns;
        s_BTNC      <= '0';
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
      
        -- Test data input 
        s_SW <= "1"; wait for 150 ns;
        s_SW <= "0"; wait for 150 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
