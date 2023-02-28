--gk - vhdl



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity fsm_verify is
--	port()
end fsm_verify;

-- verify fsm function
architecture verify of fsm_verify is
	
	constant t_c : time := 8 ns;
	signal clk :  std_logic; -- ce , we : std_logic;
	signal ce , we : std_logic := '0';
	signal a , b : unsigned(1 downto 0) := "00";
	signal add_one_a : std_logic_vector(3 downto 0) := "0000";
	signal sub_one_a : std_logic_vector(3 downto 0) := "0000";
	signal add_one_b : std_logic_vector(3 downto 0) := "0000";
	signal sub_one_b : std_logic_vector(3 downto 0) := "0000";
--	signal din : std_logic_vector(3 downto 0):= "0000";
--	signal parktotal : unsigned(3 downto 0) := "0000";
--	signal full , empty : std_logic := '0';
--	signal parkfree : unsigned(3 downto 0) := "0000";

begin
	

--machine: entity work.parking_machine(struct) 
--	port map(clk => clk, ce => ce , we =>we , din => din, full => full , empty => empty, parkfree => parkfree);
	
--counter: entity work.fsm_add(behav)
--    port map(clk , ce , din , parktotal , full , empty , parkfree);

fsm_add_verify_a : entity work.fsm_add(behav)
    port map(clk , ce , we , a , add_one_a);

fsm_sub_verify_a : entity work.fsm_sub(behav)
    port map(clk , ce , we , a , sub_one_a);
    
fsm_add_verify_b : entity work.fsm_add(behav)
    port map(clk , ce , we , b , add_one_b);

fsm_sub_verify_b : entity work.fsm_sub(behav)
    port map(clk , ce , we , b , sub_one_b);

clock: process is
begin
	wait for t_c/2 ; clk <= '1';
    wait for t_c/2 ; clk <= '0';
end process;
            
	
apply_test_cases: process is
begin
    ce <= '0'; 
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    a <= "00";
    b <= "00";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    a <= "01";
    b <= "10";
     for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    a <= "11";
    b <= "11";
    for i in 1 to 2 loop
        wait until falling_edge(clk);
    end loop;
    assert (add_one_a = "0011" and sub_one_b = "1100") report "fsm produce wrong signals";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    a <= "10";
    b <= "01";
    for i in 1 to 5 loop
        wait until falling_edge(clk);
    end loop;
    a <= "00";
    b <= "00";
    wait until falling_edge(clk);
    assert (add_one_a = "1111" and sub_one_b = "0000") report "fsm produce wrong signals with succesful entrance/exit";
    wait;
    -- fsm needs 2 clock cycles to produce correct results.
end process;
end verify;


