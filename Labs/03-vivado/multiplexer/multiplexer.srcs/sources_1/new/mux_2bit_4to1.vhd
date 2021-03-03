------------------------------------------------------------------------
--
-- Example of 2-bit 4 to 1 multiplexer using the when/else assignment.
-- Vivado 2020.2
--
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

------------------------------------------------------------------------
-- Entity declaration for mux_2bit_4to1
------------------------------------------------------------------------
entity mux_2bit_4to1 is
    port(
        a_i 			: in  std_logic_vector(2 - 1 downto 0);
		b_i 			: in  std_logic_vector(2 - 1 downto 0);
		c_i 			: in  std_logic_vector(2 - 1 downto 0);
		d_i 			: in  std_logic_vector(2 - 1 downto 0);
		sel_i 			: in  std_logic_vector(2 - 1 downto 0);
		f_o 	        : out std_logic_vector(2 - 1 downto 0)
    );
end mux_2bit_4to1;

------------------------------------------------------------------------
-- Architecture body for mux_2bit_4to1
------------------------------------------------------------------------
architecture behavioral of mux_2bit_4to1 is

begin
    f_o <=  a_i when (sel_i = "00") else 
            b_i when (sel_i = "01") else 
            c_i when (sel_i = "10") else 
            d_i;
 
end architecture behavioral;
