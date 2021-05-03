------------------------------------------------------------------------
--
-- Top level for N-bit Up/Down binary counter.
-- Nexys A7-50T, Vivado v2020.2
--
-- Copyright (c) 2021-Present Pavlo Shelemba
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( 
        CLK100MHZ : in  STD_LOGIC;
        BTNC      : in  STD_LOGIC;
        SW        : in  STD_LOGIC_VECTOR (1 - 1 downto 0);

        LED       : out STD_LOGIC_VECTOR (16 - 1 downto 0);
        CA        : out STD_LOGIC;
        CB        : out STD_LOGIC;
        CC        : out STD_LOGIC;
        CD        : out STD_LOGIC;
        CE        : out STD_LOGIC;
        CF        : out STD_LOGIC;
        CG        : out STD_LOGIC;
        AN        : out STD_LOGIC_VECTOR (8 - 1 downto 0)
        );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

    -- Internal clock enable for 250 ms
    signal s_en_250  : std_logic;
    -- Internal clock enable for 10 ms
    signal s_en_10  : std_logic;
    -- Internal 4 bit counter
    signal s_cnt_4 : std_logic_vector(4 - 1 downto 0);
    -- Internal 16 bit counter
    signal s_cnt_16 : std_logic_vector(4 - 1 downto 0);

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity
    --------------------------------------------------------------------
    clk_en : entity work.clock_enable
        generic map(
            g_MAX       => 25_000_000        -- 250 ms
        )
        port map(
            clk         => CLK100MHZ,
            reset       => BTNC,
            ce_o        => s_en_250
        );
        
    clk_en10 : entity work.clock_enable
        generic map(
            g_MAX     => 1_000_000        -- 10 ms
        )
        port map(
            clk       => CLK100MHZ,
            reset     => BTNC,
            ce_o      => s_en_10
        );
        
    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    --------------------------------------------------------------------
    bin_cnt : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 4        -- 4-bit counter
        )
        port map(
            clk         => CLK100MHZ,
            reset       => BTNC,
            en_i        => s_en_250,
            cnt_up_i    => SW(0),
            cnt_o       => s_cnt_4
        );
        
    bin_cnt10 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 16        -- 16-bit counter
        )
        port map(
            clk         => CLK100MHZ,
            reset       => BTNC,
            en_i        => s_en_10,
            cnt_up_i    => SW(0),
            cnt_o       => s_cnt_16
        );

    -- Display input value on LEDs
    LED(16 - 1 downto 0) <= s_cnt_16;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    --------------------------------------------------------------------
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt_4,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";

end architecture Behavioral;
