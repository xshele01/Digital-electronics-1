----------------------------------------------------------------------------------
-- 
-- Testbench for LEDs
-- Nexys A7-50T, Vivado 2020.2
-- 
-- Copyright (c) 2021 - Present Shelemba Pavlo
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
               signal s_SW   :    STD_LOGIC_VECTOR (4 - 1 downto 0);      -- Input binary data
               
               signal S_CA   :    STD_LOGIC;                              -- Cathod A
               signal s_CB   :    STD_LOGIC;                              -- Cathod B
               signal s_CC   :    STD_LOGIC;                              -- Cathod C
               signal s_CD   :    STD_LOGIC;                              -- Cathod D
               signal s_CE   :    STD_LOGIC;                              -- Cathod E
               signal s_CF   :    STD_LOGIC;                              -- Cathod F
               signal s_CG   :    STD_LOGIC;                              -- Cathod G
               
               signal s_LED  :    STD_LOGIC_VECTOR (8 - 1 downto 0);      -- LED indicators
               signal s_AN   :    STD_LOGIC_VECTOR (8 - 1 downto 0);       -- Common anode signals to individual displays
               
begin

 -- Connecting testbench signals with hex_7seg entity (Unit Under Test)
    uut_top : entity work.top
        port map(
            SW   => s_SW,
            
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
        
        -- 1st test
        s_SW <= "0000"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '0') and (s_CC = '0') and (s_CD = '0') and (s_CE = '0') and (s_CF = '0') and (s_CG = '1') and (s_LED = "00010000") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0000" severity error;
        
        -- 2nd test
        s_SW <= "0001"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '1') and (s_CB = '0') and (s_CC = '0') and (s_CD = '1') and (s_CE = '1') and (s_CF = '1') and (s_CG = '1') and (s_LED = "10000001") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0001" severity error;
        
        -- 3rd test
        s_SW <= "0010"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '0') and (s_CC = '1') and (s_CD = '0') and (s_CE = '0') and (s_CF = '1') and (s_CG = '0') and (s_LED = "10000010") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0010" severity error;
        
        -- 4th test
        s_SW <= "0011"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '0') and (s_CC = '0') and (s_CD = '0') and (s_CE = '1') and (s_CF = '1') and (s_CG = '0') and (s_LED = "00000011") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0011" severity error;
        
        -- 5th test
        s_SW <= "0100"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '1') and (s_CB = '0') and (s_CC = '0') and (s_CD = '1') and (s_CE = '1') and (s_CF = '0') and (s_CG = '0') and (s_LED = "10000100") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0100" severity error;
        
        -- 6th test
        s_SW <= "0101"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '1') and (s_CC = '0') and (s_CD = '0') and (s_CE = '1') and (s_CF = '0') and (s_CG = '0') and (s_LED = "00000101") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0101" severity error;
        
        -- 7th test
        s_SW <= "0110"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '1') and (s_CC = '0') and (s_CD = '0') and (s_CE = '0') and (s_CF = '0') and (s_CG = '0') and (s_LED = "00000110") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0110" severity error;
        
        -- 8th test
        s_SW <= "0111"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '0') and (s_CC = '0') and (s_CD = '0') and (s_CE = '1') and (s_CF = '1') and (s_CG = '1') and (s_LED = "00000111") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=0111" severity error;
        
        -- 9th test
        s_SW <= "1000"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '0') and (s_CC = '0') and (s_CD = '0') and (s_CE = '0') and (s_CF = '0') and (s_CG = '0') and (s_LED = "10001000") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1000" severity error;
        
        -- 10th test
        s_SW <= "1001"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '0') and (s_CC = '0') and (s_CD = '0') and (s_CE = '1') and (s_CF = '0') and (s_CG = '0') and (s_LED = "00001001") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1001" severity error;
        
        -- 11th test
        s_SW <= "1010"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '0') and (s_CC = '0') and (s_CD = '1') and (s_CE = '0') and (s_CF = '0') and (s_CG = '0') and (s_LED = "00101010") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1010" severity error;
        
        -- 12th test
        s_SW <= "1011"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '1') and (s_CB = '1') and (s_CC = '0') and (s_CD = '0') and (s_CE = '0') and (s_CF = '0') and (s_CG = '0') and (s_LED = "00101011") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1011" severity error;
        
        -- 13th test
        s_SW <= "1100"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '1') and (s_CC = '1') and (s_CD = '0') and (s_CE = '0') and (s_CF = '0') and (s_CG = '1') and (s_LED = "00101100") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1100" severity error;
        
        -- 14th test
        s_SW <= "1101"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '1') and (s_CB = '0') and (s_CC = '0') and (s_CD = '0') and (s_CE = '0') and (s_CF = '1') and (s_CG = '0') and (s_LED = "00101101") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1101" severity error;
        
        -- 15th test
        s_SW <= "1110"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '1') and (s_CC = '1') and (s_CD = '0') and (s_CE = '0') and (s_CF = '0') and (s_CG = '0') and (s_LED = "00101110") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1110" severity error;
        
        -- 16th test
        s_SW <= "1111"; wait for 62.5 ns;
        -- Expected output
        assert ((s_CA = '0') and (s_CB = '1') and (s_CC = '1') and (s_CD = '1') and (s_CE = '0') and (s_CF = '0') and (s_CG = '0') and (s_LED = "00101111") and (s_AN = "11110111"))
        -- If false, then report an error
        report "Test failed for input combination: SW=1111" severity error;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
        
    end process p_stimulus;

end architecture behavioral;
