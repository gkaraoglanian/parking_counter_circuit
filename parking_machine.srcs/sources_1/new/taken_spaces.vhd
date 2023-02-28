----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.07.2022 19:39:59
-- Design Name: 
-- Module Name: taken_spaces - Behavioral
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

entity taken_spaces is
  Port (clk ,we: in std_logic;
        add_a , add_b , sub_a , sub_b : in std_logic_vector(3 downto 0);
        -- parktotal : in unsigned(3 downto 0); will not use
        taken_spaces: out unsigned(3 downto 0) );
end taken_spaces;

-- Could check here if taken_spaces > parktotal .
-- Not incrementing taken_spaces while cars inserting parking
-- will lead to faulty subtraction.
-- See documentation for assumptions that were taken.
 
architecture Behavioral of taken_spaces is
    signal add_one_a , add_one_b , sub_one_a , sub_one_b : unsigned(3 downto 0) := "0000";
    signal adder , subber : unsigned(3 downto 0) := "0000";
    signal count : unsigned(3 downto 0);
    signal taken_reg : unsigned(3 downto 0) := "0000";
begin

counting: process(add_a , add_b , sub_a , sub_b) is
begin
--        if ce= '1' then
--            add_one_a <= "0000";
--            add_one_b <= "0000";
--            sub_one_a <= "0000";
--            sub_one_b <= "0000";
--        else
            if add_a = "1111" then
                add_one_a <= "0001";
            else
                add_one_a <= "0000";
            end if;
            if add_b = "1111" then
                add_one_b <= "0001";
            else
                add_one_b <= "0000";
            end if;
            if sub_a = "0000" then
                sub_one_a <= "0001";
            else
                sub_one_a <= "0000";
            end if;
            if sub_b = "0000" then
                sub_one_b <= "0001";
            else
                sub_one_b <= "0000";
            end if;
--        end if;
end process;

count <= add_one_a + add_one_b - sub_one_a - sub_one_b;

taken_spaces_reg : process(clk)
begin
    if rising_edge(clk) then
        if we= '1' then
            taken_reg <= "0000";
        else
            taken_reg <= taken_reg + count;
        end if;
    end if;
end process;
taken_spaces <= taken_reg;
--parkfree <= parktotal - count;
end Behavioral;
