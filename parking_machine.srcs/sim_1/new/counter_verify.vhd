----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.07.2022 23:53:02
-- Design Name: 
-- Module Name: counter_verify - Behavioral
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

entity counter_verify is
--  Port ( );
end counter_verify;

architecture Behavioral of counter_verify is
    
        constant t_c : time := 8 ns;
        signal clk , ce , we :  std_logic;
	    signal  din :  std_logic_vector(3 downto 0) := "0000";
		signal  parktotal :  unsigned(3 downto 0) := "1111";
		signal  c_full , c_empty : std_logic := '0';
		signal  c_parkfree : unsigned(3 downto 0) := "1111";
begin

counter: entity work.counter(struct)
    port map (clk , ce , we , din , parktotal , c_full , c_empty , c_parkfree );
    
clock: process is
begin
	wait for t_c/2 ; clk <= '1';
    wait for t_c/2 ; clk <= '0';
end process;
            
	
apply_test_cases: process is
begin
    ce <= '0'; parktotal <= "1111"; din <= "0000"; 
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
    assert ( c_empty = '1' and c_full = '0' ) report "parking is still empty";
    din <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert (c_parkfree = "1110") report "just missed a succesfull entrance";
    ce <= '1';
    for i in 1 to 6 loop
        wait until falling_edge(clk);
    end loop;
    assert ( c_empty = '0' and c_full = '0' and c_parkfree = "0000" ) report "idle not working properly";
    ce <= '0';
    for i in 1 to 3 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0101";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "1111";
     for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "1010";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    din <= "0000";
    for i in 1 to 3 loop
        wait until falling_edge(clk);
    end loop;
    assert ( c_parkfree = "1100" ) report "double entrance not working";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    ce <= '1';
    for i in 1 to 3 loop
        wait until falling_edge(clk);
    end loop;
    assert ( c_empty = '0' and c_full = '0' and c_parkfree = "0000" ) report "idle not working properly";
    din <= "0001";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    ce <= '0';
    for i in 1 to 3 loop
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
    din <= "0000";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    assert ( c_parkfree = "1100" ) report "wrong sequence accepted";
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
    assert ( c_parkfree = "1101" ) report "back/forth confusion";
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
    wait;
end process;


end Behavioral;
