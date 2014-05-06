----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:41:35 05/05/2014 
-- Design Name: 
-- Module Name:    AVR - Behavioral 
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
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity AVR is
	port( clk 	: in std_logic;
			reset : in std_logic;
			instr : in std_logic_vector(15 downto 0)
	);
end AVR;

architecture Behavioral of AVR is
	component ControlUnit
		port(
			op 				: in std_logic_vector(3 downto 0);
			PCSRC				: out std_logic;
			REGWRITE			: out std_logic;
			MEMOP				: out std_logic;	
			DATWRITE			: out std_logic;	
			REGSRC 			: out std_logic;
			statusSignals 	: in std_logic_vector(7 downto 0)
		);
	end component;
	component DataPathUnit
			port(
				clk 				: in std_logic;
				PCSRC				: in std_logic;
				REGWRITE			: in std_logic;
				MEMOP				: in std_logic;	
				DATWRITE			: in std_logic;	
				REGSRC 			: in std_logic;
				statusSignals 	: out std_logic_vector(7 downto 0);
				instr 			: in std_logic_vector(15 downto 0)
			);
	end component DataPathUnit;
	component StatusRegister
		port(
			currentValue 	: in std_logic_vector(7 downto 0);
			nextValue		: out std_logic_vector(7 downto 0)
		);
	end component;


	signal op: std_logic_vector(3 downto 0);
	signal PCSRC : std_logic;
	signal REGWRITE: std_logic;
	signal MEMOP	: std_logic;	
	signal DATWRITE: std_logic;	
	signal REGSRC : std_logic;
	signal statusSignalsIn:std_logic_vector(7 downto 0);
	signal statusSignalsOut:std_logic_vector(7 downto 0);
	
	


begin
	cu: ControlUnit port map(op,PCSRC,REGWRITE,MEMOP,DATWRITE,REGSRC,statusSignalsIn);
	dp: DataPathUnit port map(clk,PCSRC,REGWRITE,MEMOP,DATWRITE,REGSRC,statusSignalsOut,instr);
	sr: StatusRegister port map(statusSignalsOut,statusSignalsIn);

end Behavioral;



