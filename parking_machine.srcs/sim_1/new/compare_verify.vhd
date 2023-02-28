----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.07.2022 01:37:02
-- Design Name: 
-- Module Name: compare_verify - verify
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

entity compare_verify is
--  Port ( );
end compare_verify;

architecture verify of compare_verify is

    constant t_c : time := 8ns;
    signal clk  :  std_logic := '0';
    signal parktotal , taken_spaces:  unsigned(3 downto 0);
    signal full , empty : std_logic;
    signal parkfree : unsigned(3 downto 0); 
begin

clock: process is
begin
	wait for t_c/2 ; clk <= '1';
    wait for t_c/2 ; clk <= '0';
end process;

compare: entity work.compare(Behavioral)
    port map(parktotal , taken_spaces , full , empty , parkfree);
duv: process is
begin
    parktotal<="1111";
    taken_spaces <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (empty = '1') report "empty signal not working";
    taken_spaces <= "0001";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (parkfree = "1110") report "parkfree wrong";
    taken_spaces <= "0010";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    taken_spaces <= "1111";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (full = '1') report "full signal not working";
    taken_spaces <= "1100";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (parkfree = "0011") report "parkfree latch";
    taken_spaces <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (empty = '1') report "empty signal not working";
    taken_spaces <= "1111";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (full = '1') report "full signal not working";
    wait;
end process;


end verify;
