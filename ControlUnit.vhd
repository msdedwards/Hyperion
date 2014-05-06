----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:25:55 05/05/2014 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
	port(
		op 				: in std_logic_vector(3 downto 0);
		controlSignals : out std_logic;
		statusSignals 	: in std_logic_vector(7 downto 0)
	);
end ControlUnit;

architecture Behavioral of ControlUnit is

begin


end Behavioral;

