----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:24:38 05/05/2014 
-- Design Name: 
-- Module Name:    AVR-Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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



entity AVR-Top is
	port(	 clk, reset: in std_logic;
						pc: inout std_logic_vector(15 downto 0)
						
		  );
end AVR-Top;

architecture Behavioral of AVR-Top is

begin


end Behavioral;

