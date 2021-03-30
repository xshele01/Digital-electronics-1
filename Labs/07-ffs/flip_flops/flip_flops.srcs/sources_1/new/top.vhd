------------------------------------------------------------------------
--                                                                      
-- Shift register                                   
-- Nexys A7-50T, Vivado v2020.2                                         
--                                                                      
-- Copyright (c) 2021 - Present Shelemba Pavlo                          
-- This work is licensed under the terms of the MIT license             
--                                                                      
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( BTNU : in    STD_LOGIC;
           BTNC : in    STD_LOGIC;
           SW   : in    std_logic_vector(1 - 1 downto 0);
           LED  : out   std_logic_vector(4 - 1 downto 0)
           );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

    -- Internal signals between flip-flops
    signal s_q0 : std_logic;
    signal s_q1 : std_logic;
    signal s_q2 : std_logic;
    signal s_q3 : std_logic;

begin

    --------------------------------------------------------------------
    -- Four instances (copies) of D type FF entity
    --------------------------------------------------------------------
    d_ff_0 : entity work.d_ff_rst
        port map(
            clk     => BTNU,
            rst     => BTNC,
            d       => SW(0),
            q       => s_q0
        );

    d_ff_1 : entity work.d_ff_rst
        port map(
            clk     => BTNU,
            rst     => BTNC,
            d       => s_q0,
            q       => s_q1
        );

    d_ff_2 : entity work.d_ff_rst
        port map(
            clk     => BTNU,
            rst     => BTNC,
            d       => s_q1,
            q       => s_q2
        );
        
    d_ff_3 : entity work.d_ff_rst
        port map(
            clk     => BTNU,
            rst     => BTNC,
            d       => s_q2,
            q       => s_q3
        );
        
     LED(0) <= s_q0;
     LED(1) <= s_q1;
     LED(2) <= s_q2;
     LED(3) <= s_q3;

end architecture Behavioral;
