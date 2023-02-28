----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.07.2022 20:43:20
-- Design Name: 
-- Module Name: adder_verify - Behavioral
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

entity adder_verify is
--  Port ( );
end adder_verify;

architecture Behavioral of adder_verify is

constant t_c : time := 8ns;
signal clk, we : std_logic;
signal add_a , add_b , sub_a , sub_b : std_logic_vector(3 downto 0) := "0000";
--signal parktotal : unsigned(3 downto 0) := "1111";
signal taken_spaces: unsigned(3 downto 0) := "0000";

begin

adder: entity work.taken_spaces(Behavioral)
    port map(clk ,we , add_a , add_b , sub_a , sub_b , taken_spaces);
    
clock: process is
begin
	wait for t_c/2 ; clk <= '1';
    wait for t_c/2 ; clk <= '0';
end process;

duv: process is
begin
--    parktotal <= "1111";
    sub_a <= "1110"; sub_b <= "1111";
    we <= '1';
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (taken_spaces = "0000") report "reset not working";
    add_a <= "0111";
    wait until falling_edge(clk);
    assert (taken_spaces = "0000") report "added wrong entrance";
    add_a <= "1111";
    wait until falling_edge(clk);
    assert (taken_spaces = "0000") report "we is still '1' - reset not working";
    we <= '0';
    add_a <= "0000";
    wait until falling_edge(clk);
    add_a <= "0111";
    wait until falling_edge(clk);
    assert (taken_spaces = "0000") report "added wrong entrance";
    add_a <= "1111";
    wait until falling_edge(clk);
    assert (taken_spaces = "0001") report "should add one to taken_spaces";
    wait;
  end process;
end Behavioral;
