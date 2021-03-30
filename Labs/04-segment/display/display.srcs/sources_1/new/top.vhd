----------------------------------------------------------------------------------
-- 
-- Example of top level for seven-segment display decoder
-- Vivado 2020.2
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( 
               SW   : in    STD_LOGIC_VECTOR (4 - 1 downto 0);      -- Input binary data
               
               CA   : out   STD_LOGIC;                              -- Cathod A
               CB   : out   STD_LOGIC;                              -- Cathod B
               CC   : out   STD_LOGIC;                              -- Cathod C
               CD   : out   STD_LOGIC;                              -- Cathod D
               CE   : out   STD_LOGIC;                              -- Cathod E
               CF   : out   STD_LOGIC;                              -- Cathod F
               CG   : out   STD_LOGIC;                              -- Cathod G
               
               LED  : out   STD_LOGIC_VECTOR (8 - 1 downto 0);      -- LED indicators
               AN   : out   STD_LOGIC_VECTOR (8 - 1 downto 0)       -- Common anode signals to individual displays
           );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture behavioral of top is

begin

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    --------------------------------------------------------------------
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => SW,
            
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_0111";
    
    -- Display input value
    LED(3 downto 0) <= SW;

    -- Turn LED(4) on if input value is equal to 0, ie "0000"
    LED(4) <= '1' when SW = "0000" else '0';
    
    -- Turn LED(5) on if input value is greater than 9
    LED(5) <= '1' when SW > "1001" else '0';
    
    -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    LED(6) <=   '1' when SW = "XX01" else
                '1' when SW = "XX11" else 
                '0';
    
    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
    LED(7) <=   '1' when SW = "0001" else
                '1' when SW = "0010" else 
                '1' when SW = "0100" else 
                '1' when SW = "1000" else 
                '0';
                
end architecture behavioral;
