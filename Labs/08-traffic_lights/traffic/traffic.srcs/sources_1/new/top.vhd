------------------------------------------------------------------------
--
-- Traffic light controller implementation on the Nexys A7 board
-- Nexys A7-50T, Vivado v2020.2
--
-- Copyright (c) 2020-Present Shelemba Pavlo
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( CLK100MHZ    : in STD_LOGIC;
           BTNC         : in STD_LOGIC;
           LED16_R      : out STD_LOGIC;
           LED16_G      : out STD_LOGIC;
           LED16_B      : out STD_LOGIC;
           LED17_R      : out STD_LOGIC;
           LED17_G      : out STD_LOGIC;
           LED17_B      : out STD_LOGIC
           );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

begin
    --------------------------------------------------------------------
    -- Instance (copy) of tlc entity
    --------------------------------------------------------------------
    tlc : entity work.tlc
        port map(
            clk         => CLK100MHZ,
            reset       => BTNC,
            south_o(2)  => LED16_R,
            south_o(1)  => LED16_G,
            south_o(0)  => LED16_B,
            west_o(2)   => LED17_R,
            west_o(1)   => LED17_G,
            west_o(0)   => LED17_B
        );

end architecture Behavioral;
