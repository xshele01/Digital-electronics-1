------------------------------------------------------------------------
--
-- Testbench for switch circuit.
-- Arty A7-100T, Vivado v2020.2
--
-- Copyright (c) 2021-Present Pavlo Shelemba
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_switch is
    -- Entity of testbench is always empty
end entity tb_switch;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_switch is

    --Local signals
    signal s_sw_i             : STD_LOGIC_VECTOR (2-1 downto 0);
    signal s_echo_i           : STD_LOGIC_VECTOR (2-1 downto 0);
    signal s_trig_i           : std_logic;
    signal s_echo_o           : std_logic;
    signal s_trig_o           : STD_LOGIC_VECTOR (2-1 downto 0);

begin
    --------------------------------------------------------------------
    -- Connecting testbench signals with switch entity
    --------------------------------------------------------------------
    uut_sw : entity work.switch
        port map(
            sw_i   => s_sw_i,
            echo_i   => s_echo_i,
            trig_i   => s_trig_i,
            echo_o   => s_echo_o,
            trig_o   => s_trig_o
        );
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

		s_sw_i <= "11";
        wait for 50ns;
        s_trig_i <= '1';
        wait for 50ns;
        s_trig_i <= '0';
        wait for 50ns;
        s_echo_i <= "01";
        wait for 100ns;
        s_echo_i <= "00";
        wait for 50ns;
        
        s_sw_i <= "01";
        wait for 50ns;
        s_trig_i <= '1';
        wait for 50ns;
        s_trig_i <= '0';
        wait for 50ns;
        s_echo_i <= "10";
        wait for 100ns;
        s_echo_i <= "00";
        wait for 50ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
