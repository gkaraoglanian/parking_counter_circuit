--gk- vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity parking_machine is
	port( clk , ce , we : in std_logic;
		din :  in std_logic_vector (3 downto 0);
		full , empty : out std_logic;
		parkfree : out std_logic_vector(3 downto 0));
end parking_machine;

architecture struct of parking_machine is
	signal parktotal : unsigned (3 downto 0) := "1111";
	signal c_full , c_empty : std_logic := '0';
	signal c_parkfree : unsigned (3 downto 0) := "0000";

begin

parktotal_reg:process(clk) is
begin
    if rising_edge(clk) then
        if ce = '0' then
	       if we = '1' then
		      parktotal <= unsigned(din);
		   end if;
	   end if;
	end if;
end process;

counter: entity work.counter(struct)
	port map (clk , ce , we , din , parktotal , c_full , c_empty , c_parkfree);

full <= c_full;
empty <= c_empty;
parkfree <= std_logic_vector(c_parkfree);

end architecture struct;






