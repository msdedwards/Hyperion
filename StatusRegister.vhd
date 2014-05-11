----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:26:09 05/05/2014 
-- Design Name: 
-- Module Name:    StatusRegister - Behavioral 
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

entity StatusRegister is
	port(
		currentValue 	: in std_logic_vector(7 downto 0);
		nextValue		: out std_logic_vector(7 downto 0)
	);
end StatusRegister;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package StatusRegisterpkg is
	component StatusRegister
		port(
			currentValue 	: in std_logic_vector(7 downto 0);
			nextValue		: out std_logic_vector(7 downto 0)
		);
	end component;
end package StatusRegisterpkg;

architecture Behavioral of StatusRegister is

begin


end Behavioral;

