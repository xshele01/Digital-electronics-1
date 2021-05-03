------------------------------------------------------------------------
--
-- Testbench for trigger circuit.
-- Arty A7-100T, Vivado v2020.2
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
entity tb_trigger is
    -- Entity of testbench is always empty
end entity tb_trigger;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_trigger is

    constant c_MAX               : natural := 10;
    constant c_LENGTH 			 : natural := 5;
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz          : std_logic;
    signal s_reset               : std_logic;
    signal s_trig_o              : std_logic;

begin
    -- Connecting testbench signals with trigger entity
    -- (Unit Under Test)
    uut_ce : entity work.trigger
        generic map(
            g_MAX    => c_MAX,
            g_LENGTH => c_LENGTH
        )
        port map(
            clk      => s_clk_100MHz,
            reset    => s_reset,
            trig_o   => s_trig_o
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 1000 ns loop         -- 100 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                           -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 25 ns;
        
        -- Reset activated
        s_reset <= '1';
         wait for 225 ns;
        -- Expected output
        assert (s_trig_o = '0')
        -- If false, then report an error
        report "Test failed for s_reset <= '1'" severity error;

        -- Reset deactivated
        s_reset <= '0';

        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        wait for 10 ns;
        -- Expected output
        assert (s_trig_o = '1')
        -- If false, then report an error
        report "Test failed for s_trig_o = '1'" severity error;
        
        wait for 345 ns;
        -- Expected output
        assert (s_trig_o = '1')
        -- If false, then report an error
        report "Test failed for s_trig_o = '1'" severity error;
        
        wait for 365 ns;
        -- Expected output
        assert (s_trig_o = '0')
        -- If false, then report an error
        report "Test failed for s_trig_o = '0'" severity error;
    
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
