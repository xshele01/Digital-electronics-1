------------------------------------------------------------------------
--
-- Testbench for D latch (Transparent latch)
-- Nexys A7-50T, Vivado v2020.2
--
-- Copyright (c) 2021 - Present Shelemba Pavlo
-- This work is licensed under the terms of the MIT license
--
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_d_latch is
--  Empty
end tb_d_latch;

architecture Behavioral of tb_d_latch is

     signal s_en    :  STD_LOGIC; 
     signal s_d     :  STD_LOGIC; 
     signal s_arst  :  STD_LOGIC; 
     signal s_q     :  STD_LOGIC; 
     signal s_q_bar :  STD_LOGIC;
     
begin

    uut_d_latch : entity work.d_latch
        port map(
                en     =>  s_en,   
                d      =>  s_d,    
                arst   =>  s_arst, 
                q      =>  s_q,    
                q_bar  =>  s_q_bar
                );

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_arst      <= '0';
        wait for 400 ns;
        s_arst      <= '1';
        wait for 125 ns;
        s_arst      <= '0';
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_en        <= '0';
        s_d         <= '0';
        wait for 50 ns;
        
        -- Test data input 
        s_d         <= '1';
        wait for 25 ns;  
        s_d         <= '0';
        wait for 25 ns; 
        s_d         <= '1';
        wait for 25 ns; 
        s_d         <= '0';
        wait for 25 ns; 
        
        -- Test enable
        s_en        <= '1';
        wait for 25 ns;  
        
        s_d         <= '1';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '1') and (s_q_bar = '0'))
        -- If false, then report an error
        report "Test failed for en=1, d=1, arst=0" severity error;
        
        s_d         <= '0';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=1, d=0, arst=0" severity error;
        
        s_d         <= '1';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '1') and (s_q_bar = '0'))
        -- If false, then report an error
        report "Test failed for en=1, d=1, arst=0" severity error;
        
        s_d         <= '0';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=1, d=1, arst=0" severity error;
         
        s_en        <= '0';
        wait for 25 ns;
        
        s_d         <= '1';
        wait for 25 ns;
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=0, d=1, arst=0" severity error;
        
        s_d         <= '0';
        wait for 25 ns;
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=0, d=0, arst=0" severity error;
        
        s_d         <= '1';
        wait for 25 ns;
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=0, d=1, arst=0" severity error;
        
        s_d         <= '0';
        wait for 25 ns;   
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=0, d=0, arst=0" severity error;
        
        -- Test reset
        s_en        <= '1';
        wait for 25 ns;  
        
        s_d         <= '1';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=1, d=1, arst=1" severity error;
        
        s_d         <= '0';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=1, d=0, arst=1" severity error;
        
        s_d         <= '1';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=1, d=1, arst=1" severity error;
        
        s_d         <= '0';
        wait for 25 ns;
        -- Expected output
        assert ((s_q = '0') and (s_q_bar = '1'))
        -- If false, then report an error
        report "Test failed for en=1, d=0, arst=1" severity error;
        
        s_en        <= '0';
        wait for 50 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
