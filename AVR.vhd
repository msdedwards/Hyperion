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
use work.ControlUnitpkg.all;
use work.DataPathUnitpkg.all;
use work.StatusRegisterpkg.all;

entity AVR is
	port( 
				clk							: 	in		std_logic;
				reset							: 	in 	std_logic;
				sw2_n							:	in		std_logic;
				pps							:	out	std_logic_vector(6 downto 3);
				led							: 	out	std_logic_vector(6 downto 0);
				sdram_clock_in_sclkfb 	:	in		std_logic;
				sdram_clock_out_sclk		:	out	std_logic;
				cke     						: 	out	std_logic;                        -- SDRAM clock-enable
				cs_n    						:	out 	std_logic;                        -- SDRAM chip-select
				ras_n   						:	out 	std_logic;                        -- SDRAM RAS
				cas_n   						: 	out 	std_logic;                        -- SDRAM CAS     
				we_n    						: 	out 	std_logic;                        -- SDRAM write-enable
				ba      						: 	out 	std_logic_vector( 1 downto 0);    -- SDRAM bank-address selects one of four banks
				dqmh    						: 	out 	std_logic;                        -- SDRAM DQMH controls upper half of data bus during read
				dqml    						: 	out 	std_logic;
				sAddr							:	out	std_logic_vector(12 downto 0);
				sData							: 	inout	std_logic_vector(15 downto 0)
	);
end AVR;

library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use work.ControlUnitpkg.all;
use work.DataPathUnitpkg.all;
use work.StatusRegisterpkg.all;

package AVRPkg is
	component AVR is
		port( 
				clk							: 	in		std_logic;
				reset							: 	in 	std_logic;
				sw2_n							:	in		std_logic;
				pps							:	out	std_logic_vector(6 downto 3);
				led							: 	out	std_logic_vector(6 downto 0);
				sdram_clock_in_sclkfb 	:	in		std_logic;
				sdram_clock_out_sclk		:	out	std_logic;
				cke     						: 	out	std_logic;                        -- SDRAM clock-enable
				cs_n    						:	out 	std_logic;                        -- SDRAM chip-select
				ras_n   						:	out 	std_logic;                        -- SDRAM RAS
				cas_n   						: 	out 	std_logic;                        -- SDRAM CAS     
				we_n    						: 	out 	std_logic;                        -- SDRAM write-enable
				ba      						: 	out 	std_logic_vector( 1 downto 0);    -- SDRAM bank-address selects one of four banks
				dqmh    						: 	out 	std_logic;                        -- SDRAM DQMH controls upper half of data bus during read
				dqml    						: 	out 	std_logic;
				sAddr							:	out	std_logic_vector(12 downto 0);
				sData							: 	inout	std_logic_vector(15 downto 0)
		);
	end component AVR;
end package AVRPkg;

architecture Behavioral of AVR is

	signal op: std_logic_vector(3 downto 0);
	signal PCSRC : std_logic;
	signal REGWRITE: std_logic;
	signal MEMOP	: std_logic;	
	signal DATWRITE: std_logic;	
	signal REGSRC : std_logic_vector(1 downto 0);
	signal statusSignalsIn:std_logic_vector(7 downto 0);
	signal statusSignalsOut:std_logic_vector(7 downto 0);

begin
	cu: ControlUnit 
	port map
	(
		op => op,
		PCSRC => PCSRC,
		REGWRITE => REGWRITE,
		MEMOP => MEMOP,
		DATWRITE => DATWRITE,
		REGSRC => REGSRC,
		statusSignals => statusSignalsIn
	);
	dp: DataPathUnit 
	port map
	(
		clk => clk,
		reset	=> reset,						
		sw2_n => sw2_n,							
		pps => pps,			
		led => led,				
		sdram_clock_in_sclkfb => sdram_clock_in_sclkfb,	
		sdram_clock_out_sclk	=> sdram_clock_out_sclk,
		cke => cke,
		cs_n => cs_n,				
		ras_n => ras_n,				
		cas_n => cas_n,			
		we_n => we_n,			
		ba => ba,				
		dqmh => dqmh,					
		dqml => dqml,				
		sAddr => sAddr,				
		sData	=> sData,						
		PCSRC => PCSRC,
		REGWRITE => REGWRITE,
		MEMOP => MEMOP,
		DATWRITE => DATWRITE,
		REGSRC => REGSRC,
		statusSignals => statusSignalsOut,
		op => op
		);
	sr: StatusRegister 
	port map
	(
		currentValue => statusSignalsOut,
		nextValue => statusSignalsIn
	);

end Behavioral;



