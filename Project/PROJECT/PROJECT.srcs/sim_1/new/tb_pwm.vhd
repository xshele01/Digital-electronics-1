--------------------------------------------------------------------------
----
---- Testbench for PWM generator.
---- Arty A7-100T, Vivado v2020.2
----
---- Copyright (c) 2021 - Present Shelemba Pavlo
---- This work is licensed under the terms of the MIT license.
----
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_pwm is
--Always empty
end entity tb_pwm;

architecture testbench of tb_pwm is

	constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
    signal s_clk_100MHz  : std_logic; 
 	signal s_cm_i        : std_logic_vector(8-1 downto 0);
    signal s_pwm_o       : std_logic;

begin
    ------------------------------------------------------------------------
    -- Connecting testbench signals with trigger entity
    ------------------------------------------------------------------------
    uut_pwm : entity work.pwm
        port map(
            clk 	=> s_clk_100MHz,
 			cm_i    => s_cm_i,
            pwm_o   => s_pwm_o
        );
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------    
    p_clk_gen : process
    begin
        while now < 250000 ns loop
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
            
         wait for 5000 ns;
         s_cm_i <= "00010100"; -- 20 cm
         wait for 30000 ns;
         s_cm_i <= "01000110"; -- 70 cm
         wait for 30000 ns;
         s_cm_i <= "10001100"; -- 140 cm
         wait for 30000 ns;
         s_cm_i <= "00000100"; -- 4 cm
         wait for 30000 ns;
         s_cm_i <= "11111111"; -- 255 cm
         wait for 30000 ns;
         s_cm_i <= "00011000"; -- 17 cm
         wait for 30000 ns;
         s_cm_i <= "10001100"; -- 140 cm
         wait for 30000 ns;
            
         report "Stimulus process finished" severity note;
         wait;
     end process p_stimulus;

end architecture testbench;