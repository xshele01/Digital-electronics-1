------------------------------------------------------------------------
--
-- Testbench for bargraph circuit.
-- Arty A7-100, Vivado v2020.2
--
-- Copyright (c) 2021-Present Pavlo Shelemba
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_bargraph is
    -- Entity of testbench is always empty
end entity tb_bargraph;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_bargraph is

    signal s_cm_i     : STD_LOGIC_VECTOR (8-1 downto 0);
    signal s_bar_o  : STD_LOGIC_VECTOR (4-1 downto 0);
    signal s_rgb_o  : STD_LOGIC_VECTOR (3-1 downto 0);

begin
    --------------------------------------------------------------------
    -- Connecting testbench signals with bargraph entity
    --------------------------------------------------------------------
    uut_bar : entity work.bargraph
        port map(
            cm_i    => s_cm_i,
            bar_o   => s_bar_o,
            rgb_o 	=> s_rgb_o
        );
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        wait for 590 ns;
        s_cm_i <= "00000100"; -- 4 cm
        wait for 40 ns;
        assert ((s_bar_o = "1111") and (s_rgb_o <= "100"))
        -- If false, then report an error
        report "Test failed for input s_cm_i = 00000100" severity error;
        wait for 101700 ns;
        
        s_cm_i <= "00010100"; -- 19 cm
        wait for 40 ns;
        assert ((s_bar_o = "1111") and (s_rgb_o <= "100"))
        -- If false, then report an error
        report "Test failed for input s_cm_i = 00010100" severity error;
        wait for 101700 ns;
        
        s_cm_i <= "00100011"; -- 34 cm
        wait for 30 ns;
        assert ((s_bar_o = "0111") and (s_rgb_o <= "110"))
        -- If false, then report an error
        report "Test failed for input s_cm_i = 00100011" severity error;
        wait for 95900 ns;
        
		s_cm_i <= "10001100"; -- 140 cm
        wait for 30 ns;
        assert ((s_bar_o = "0001") and (s_rgb_o <= "010"))
        -- If false, then report an error
        report "Test failed for input s_cm_i = 00100011" severity error;
        wait for 90000 ns;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
