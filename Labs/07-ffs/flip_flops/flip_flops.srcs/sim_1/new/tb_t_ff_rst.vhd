------------------------------------------------------------------------
--                                                                      
-- Testbench for T-type flip-flop with a sync reset                                    
-- Nexys A7-50T, Vivado v2020.2                                         
--                                                                      
-- Copyright (c) 2021 - Present Shelemba Pavlo                          
-- This work is licensed under the terms of the MIT license             
--                                                                      
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_t_ff_rst is
--  Empty
end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is

        -- Local constants
        constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
        
        --Local signals
        signal s_clk   :  STD_LOGIC; 
        signal s_t     :  STD_LOGIC; 
        signal s_rst   :  STD_LOGIC; 
        signal s_q     :  STD_LOGIC; 
        signal s_q_bar :  STD_LOGIC;
     
begin

    uut_d_latch : entity work.t_ff_rst
        port map(
                clk     =>  s_clk,
                t       =>  s_t,    
                rst     =>  s_rst, 
                q       =>  s_q,    
                q_bar   =>  s_q_bar
                );
            
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 300 ns loop         -- 30 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst      <= '0';
        wait for 5 ns;
        s_rst      <= '1';
        wait for 5 ns;
        s_rst      <= '0';
        wait for 90 ns;
        s_rst      <= '1';
        wait for 100 ns;
        s_rst      <= '0';
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
      
        -- Test data input 
        s_t <= '1'; 
        wait for 20 ns;
        -- Expected output
        assert ((s_q = '1') and (s_q_bar = '0'))
        -- If false, then report an error
        report "Test failed for t=1, rst=0" severity error;

        wait for 10 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for t=1, rst=0" severity error;
        wait for 50 ns;
        
        s_t <= '0'; 
        wait for 30 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for t=0, rst=0" severity error;
        
        -- Test reset
        s_t <= '1'; 
        wait for 10 ns;   
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for t=1, rst=1" severity error;
        
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for t=1, rst=1" severity error;
        
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for t=1, rst=1" severity error;
        wait for 25 ns;
        
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for t=1, rst=1" severity error;
        
        wait for 20 ns;
        assert ((s_q = '1') and (s_q_bar = '0'))
        -- If false, then report an error
        report "Test failed for t=1, rst=0" severity error;
       
        wait for 30 ns; 
        s_t <= '0'; 
        wait for 10 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for t=0, rst=0" severity error;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture Behavioral;
