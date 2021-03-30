------------------------------------------------------------------------
--                                                                      
-- T-type flip-flop with a sync reset                                    
-- Nexys A7-50T, Vivado v2020.2                                         
--                                                                      
-- Copyright (c) 2021 - Present Shelemba Pavlo                          
-- This work is licensed under the terms of the MIT license             
--                                                                      
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_ff_rst is
    Port ( clk      : in    STD_LOGIC;
           t        : in    STD_LOGIC;
           rst      : in    STD_LOGIC;
           q        : out   STD_LOGIC;
           q_bar    : out   STD_LOGIC
           );
end t_ff_rst;

architecture Behavioral of t_ff_rst is
    signal s_q : STD_LOGIC;
    signal s_q_bar : STD_LOGIC;
begin
    p_t_ff_rst : process(clk)
    begin
        if rising_edge (clk) then
            if (rst = '1') then
                s_q         <= '0';
                s_q_bar     <= '1';
            else
                if (t = '0') then
                   s_q      <= s_q;
                   s_q_bar  <= s_q_bar;
                else 
                   s_q      <= not s_q;
                   s_q_bar  <= not s_q_bar;
                end if;
             end if;
        end if;        
    end process p_t_ff_rst;
    
    q       <= s_q;
    q_bar   <= s_q_bar;
   
end architecture Behavioral;
