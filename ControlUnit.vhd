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
		PCSRC				: out std_logic;
		REGWRITE			: out std_logic;
		MEMOP				: out std_logic;	
		DATWRITE			: out std_logic;	
		REGSRC 			: out std_logic_vector(1 downto 0);
		statusSignals 	: in std_logic_vector(7 downto 0)
	);
end ControlUnit;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package ControlUnitpkg is
	component ControlUnit
		port(
			op 				: in std_logic_vector(3 downto 0);
			PCSRC				: out std_logic;
			REGWRITE			: out std_logic;
			MEMOP				: out std_logic;	
			DATWRITE			: out std_logic;	
			REGSRC 			: out std_logic_vector(1 downto 0);
			statusSignals 	: in std_logic_vector(7 downto 0)
		);
	end component;
end package ControlUnitpkg;

architecture Behavioral of ControlUnit is

begin


end Behavioral;


