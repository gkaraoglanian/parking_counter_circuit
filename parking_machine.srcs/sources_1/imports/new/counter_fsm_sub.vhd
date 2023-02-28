----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.06.2022 10:21:16
-- Design Name: 
-- Module Name: counter_fsm_sub - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_sub is
    Port ( clk : in STD_LOGIC;
           ce , we: in std_logic;
           a : in unsigned(1 DOWNTO 0);
           sub_one : out STD_LOGIC_VECTOR( 3 DOWNTO 0) := "0000" );
end fsm_sub;

architecture behav of fsm_sub is

    type state_type is (s0,s1,s2,s3,s4);
    signal current_state , next_state : state_type;
   
begin

p1 : process(clk)
begin
    if rising_edge(clk) then
        if ce = '0' then
            if (we = '1') then
                current_state <= s0;
            else
                current_state <= next_state;
            end if;
        else
            current_state <= s0;
        end if;
    end if;
end process p1;

p2: process(current_state , a)
begin
    next_state <= current_state;
    
    case current_state is
        when s0 =>
            if a = "10" then
                next_state <= s1;
            end if;
        when s1 =>
            if a = "11" then
                next_state <= s2;
            end if;
        when s2 =>
            if a="01" then
                next_state <= s3;
            end if;
        when s3 =>
            if a = "00" then
                next_state <= s4;
            end if;
        when s4 =>
            next_state <= s0;
      end case;
end process;

p3: process(current_state)
begin
    case current_state is
        when s0 =>
            sub_one <= "1111";
        when s1 =>
            sub_one <= "1110";
        when s2 =>
            sub_one <= "1100";
        when s3 =>
            sub_one <= "1000";
        when s4 =>
            sub_one <= "0000";
     end case;
end process p3;

end behav;
