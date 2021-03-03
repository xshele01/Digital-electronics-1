----------------------------------------------------------------------------------
-- 
-- Testbench for seven-segment display decoder
-- Vivado 2020.2
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_hex_7seg is
-- Entity of testbench is always empty
end tb_hex_7seg;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture behavioral of tb_hex_7seg is

    -- Local signals
    signal s_hex : std_logic_vector(4 - 1 downto 0);
    signal s_seg : std_logic_vector(7 - 1 downto 0);
    
begin

    -- Connecting testbench signals with hex_7seg entity (Unit Under Test)
    uut_hex_7seg : entity work.hex_7seg
        port map(
            hex_i   => s_hex,
            seg_o   => s_seg
        );
        
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    
    begin
    
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        -- 1st test
        s_hex <= "0000"; wait for 62.5 ns;
        -- 2nd test
        s_hex <= "0001"; wait for 62.5 ns;
        -- 3rd test
        s_hex <= "0010"; wait for 62.5 ns;
        -- 4th test
        s_hex <= "0011"; wait for 62.5 ns;
        -- 5th test
        s_hex <= "0100"; wait for 62.5 ns;
        -- 6th test
        s_hex <= "0101"; wait for 62.5 ns;
        -- 7th test
        s_hex <= "0110"; wait for 62.5 ns;
        -- 8th test
        s_hex <= "0111"; wait for 62.5 ns;
        -- 9th test
        s_hex <= "1000"; wait for 62.5 ns;
        -- 10th test
        s_hex <= "1001"; wait for 62.5 ns;
        -- 11th test
        s_hex <= "1010"; wait for 62.5 ns;
        -- 12th test
        s_hex <= "1011"; wait for 62.5 ns;
        -- 13th test
        s_hex <= "1100"; wait for 62.5 ns;
        -- 14th test
        s_hex <= "1101"; wait for 62.5 ns;
        -- 15th test
        s_hex <= "1110"; wait for 62.5 ns;
        -- 16th test
        s_hex <= "1111"; wait for 62.5 ns;
            
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
        
    end process p_stimulus;
    
end architecture behavioral;
