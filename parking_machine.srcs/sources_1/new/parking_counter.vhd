--gk - vhdl
--parking_machine -> counter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	port(clk , ce , we : in std_logic;
	    din : in std_logic_vector(3 downto 0);
		parktotal : in unsigned(3 downto 0);
		c_full , c_empty : out std_logic;
		c_parkfree : out unsigned(3 downto 0));
end counter;

architecture struct of counter is
	-- sensor input --
signal a,b : unsigned(1 downto 0) := "00";

	-- counter_stop latch registers --
--signal cs_q1 , cs_q2 : std_logic;
--signal c_stop_pulse : std_logic := '0';
--signal counter_stop : std_logic := '0';

	-- fsm control signals --
signal add_a , sub_a , add_b , sub_b : std_logic_vector(3 downto 0) := "0000";
signal add_one_a , sub_one_a , add_one_b , sub_one_b : std_logic := '0';
    -- fsm control registers --
signal add_a_q1 , add_a_q2 , sub_a_q1 , sub_a_q2 , add_b_q1 , add_b_q2 , sub_b_q1 , sub_b_q2 : std_logic := '0';

	-- counting taken spaces --
signal taken_spaces : unsigned(3 downto 0) := "0000";
--signal c_parkfree_signal : unsigned(3 downto 0) := "0000";

    -- compare signals --
signal full , empty : std_logic := '0';
signal parkfree : unsigned(3 downto 0) := "0000";



begin

	a <= unsigned(din(3 downto 2));
	b <= unsigned(din(1 downto 0));

--counter_stop <= ce;

	fsm_add_a: entity work.fsm_add(behav)
		port map (clk , ce , we , a , add_a);
	fsm_sub_a: entity work.fsm_sub(behav)
		port map (clk , ce , we , a , sub_a);
	fsm_add_b: entity work.fsm_add(behav)
		port map (clk , ce , we , b , add_b);
	fsm_sub_b: entity work.fsm_sub(behav)
		port map (clk , ce , we , b , sub_b);
		


--	add_one_a <= '0' & '0' & '0' & (add_a(3) and add_a(2) and add_a(1) and add_a(0));
--	sub_one_a <= '0' & '0' & '0' & (not sub_a(3) and not sub_a(2) and not sub_a(1) and not sub_a(0));
--	add_one_b <= '0' & '0' & '0' & (add_b(3) and add_b(2) and add_b(1) and add_b(0));
--	sub_one_b <= '0' & '0' & '0' & (not sub_b(3) and not sub_b(2) and not sub_b(1) and not sub_b(0));


--	taken_spaces <= taken_spaces + add_one_a - sub_one_b + add_one_b - sub_one_b;
adder: entity work.taken_spaces(Behavioral)
    port map(clk , we , add_a , add_b , sub_a , sub_b , taken_spaces);
    
compare: entity work.compare(Behavioral)
    port map(parktotal , taken_spaces , full , empty , parkfree );
    
    
output: process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
            c_full <= '0';
            c_empty <= '0';
            c_parkfree <= "0000";
        else
            c_full <= full;
            c_empty <= empty;
            c_parkfree <= parkfree;
        end if;
    end if;    
end process;	

end architecture struct;
	











