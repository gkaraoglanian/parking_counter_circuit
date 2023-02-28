----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.07.2022 02:56:16
-- Design Name: 
-- Module Name: design_verify - verify
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

entity design_verify is
--  Port ( );
end design_verify;

architecture verify of design_verify is

    constant t_c : time := 8 ns;
    signal clk , ce , we :  std_logic;
	signal din :  std_logic_vector (3 downto 0);
	signal full , empty :  std_logic;
	signal parkfree :  std_logic_vector(3 downto 0);
	
begin

clock: process is
begin
	wait for t_c/2 ; clk <= '1';
    wait for t_c/2 ; clk <= '0';
end process;


duv: entity work.parking_machine(struct)
    port map(clk , ce , we , din , full , empty , parkfree);
    
apply_test_cases: process is
begin
    ce <= '0'; we <= '0'; din <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    we <= '1';
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "1111";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    we <= '0';
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0001";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0011";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0010";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0100";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "1100";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    we <= '1';
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (parkfree = "1110") report "parkfree = din = Parktotal";
    din <= "0011";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    we <= '0';
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "1000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0000";
    assert (parkfree = "0011") report "fault entrance";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    ce <= '1';
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (full = '0' or empty = '0') report "not idle";
    ce <= '0';
    din <= "1000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "1100";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0100";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (parkfree > "0011") report "cannot remove a car from an empty parking!";
    wait;
end process;
    


end verify;
