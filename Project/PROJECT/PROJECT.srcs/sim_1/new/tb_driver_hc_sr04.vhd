------------------------------------------------------------------------
--
-- Testbench for HC-SR04 Ultrasonic Sensor driver.
-- Arty A7-100T, Vivado v2020.2
--
-- Copyright (c) 2021 - Present Shelemba Pavlo
-- Brno University of Technology, Czech Republic
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_driver_hc_sr04 is
    -- Entity of testbench is always empty
end entity tb_driver_hc_sr04;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_driver_hc_sr04 is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz     :   std_logic;
    signal s_echo_i         :   std_logic;
    signal s_trig_o         :   std_logic;
    signal s_cm_o           :   std_logic_vector(8-1 downto 0);

begin
    --------------------------------------------------------------------
    -- Connecting testbench signals with driver_hc_sr04 entity
    --------------------------------------------------------------------
    uut_driver : entity work.driver_hc_sr04
            port map(
                clk     => s_clk_100MHz,
                echo_i  => s_echo_i,                           
                trig_o  => s_trig_o,                           
                cm_o    => s_cm_o      
            );
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 300 ms loop 
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        wait for 10 us;
         
        s_echo_i <= '1';
        wait for 580 us;
        s_echo_i <= '0';
        wait for 20 us;
        
        --Expected output
        assert (s_cm_o = "00000100")
        -- If false, then report an error
        report "Test failed for input s_echo_i <= '0'" severity error;
        wait for 99400 us;
        
        s_echo_i <= '1';
        wait for 2320 us;
        s_echo_i <= '0';
        wait for 80 us;
        
        --Expected output
        assert (s_cm_o = "00010011")
        -- If false, then report an error
        report "Test failed for input s_echo_i <= '0'" severity error;
        wait for 97600 us;
        
        s_echo_i <= '1';
        wait for 4060 us;
        s_echo_i <= '0';
        wait for 30 us;
        
        --Expected output
        assert (s_cm_o = "00100010")
        -- If false, then report an error
        report "Test failed for input s_echo_i <= '0'" severity error;
        wait for 95900 us;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
