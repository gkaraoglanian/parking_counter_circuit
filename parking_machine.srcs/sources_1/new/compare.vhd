----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.07.2022 01:23:22
-- Design Name: 
-- Module Name: compare - Behavioral
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

entity compare is
  Port (parktotal , taken_spaces: in unsigned(3 downto 0);
        full , empty : out std_logic;
        parkfree : out unsigned( 3 downto 0) );
end compare;

architecture Behavioral of compare is

signal diff : unsigned(3 downto 0) := "0000";

begin

diff <= parktotal - taken_spaces;


--compare: process(diff) is
--begin
--    case taken_spaces is
        
compare: process( diff )
begin
      
       if taken_spaces = "0000" then
           empty <= '1';
           full <= '0';
       else
           empty <= '0';
           if diff = "0000" then
               full <= '1';
           else
               full <= '0';
           end if;
       end if;
     
end process;
parkfree <= diff;
                    

end Behavioral;
