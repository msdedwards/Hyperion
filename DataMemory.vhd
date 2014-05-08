----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:12:42 05/06/2014 
-- Design Name: 
-- Module Name:    DataMemory - Behavioral 
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
use work.SDRAM_Component_pckg.all;
use Work.SDRAMControl.all;
--use IEEE.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;
--use IEEE.numeric_std.all;
use WORK.common.all;
--use WORK.xsasdram.all;
--use WORK.sdram.all;
--use Work.SDRAMControl.all;

entity DataMemory is
	port(
		DatWrite: in std_logic;
		addr: in std_logic_vector(15 downto 0);
		dataIn: in std_logic_vector(7 downto 0)
	);
end DataMemory;

architecture Behavioral of DataMemory is
	signal pinsIn: SDRAMControlPinsIn;
	signal pinsOut: SDRAMControlPinsOut;
	signal pinsInout:SDRAMControlPinsInOut;
	signal clk_i: std_logic;
	signal haddr0,haddr1: std_logic_vector(15 downto 0);
	
begin
	mem:SDRAM_Component
	generic map(
		HADDR_WIDTH => 16,
		DATA_WIDTH => 8
	)
	port map(
		 pinsIn => pinsIn,
		 pinsOut => pinsOut,
		 pinsInOut => pinsInOut
--		 sw2    				: in    	std_logic;           				-- active-low pushbutton input
--		 clk    				: in    	std_logic;          					-- main clock input from external clock source
--		 sclkfb 				: in    	std_logic;          					-- feedback SDRAM clock with PCB delays
--		 sclk   				: out   	std_logic;          					-- clock to SDRAM
--		 cke    				: out   	std_logic;          					-- SDRAM clock-enable
--		 cs_n   				: out   	std_logic;          					-- SDRAM chip-select
--		 ras_n  				: out   	std_logic;          					-- SDRAM RAS
--		 cas_n  				: out   	std_logic;          					-- SDRAM CAS
--		 we_n   				: out   	std_logic;          					-- SDRAM write-enable
--		 ba     				: out   	std_logic_vector( 1 downto 0); 	-- SDRAM bank-address
--		 sAddr => sAddr,				--: out   	std_logic_vector(12 downto 0);  	-- SDRAM address bus
--		 sData => sData,				--: inout 	std_logic_vector(15 downto 0);  	-- data bus to/from SDRAM
--		 dqmh   				: out   	std_logic;           				-- SDRAM DQMH
--		 dqml   				: out   	std_logic;           				-- SDRAM DQML
--		 hdout0 => hdout0,			--: out		std_logic_vector(DATA_WIDTH-1 downto 0);
--		 hdout1 => hdout1,				--: out 	std_logic_vector(DATA_WIDTH-1 downto 0);
--		 done1				: out 	std_logic;
--		 done0				: out		std_logic;
--		 haddr0 => haddr0,				--: in 		std_logic_vector(HADDR_WIDTH-1 downto 0);
--		 haddr1 => haddr1,				--: in	   std_logic_vector(HADDR_WIDTH-1 downto 0);
--		 hdin0 => hdin0,				--: in  	std_logic_vector(DATA_WIDTH-1 downto 0);
--		 hdin1 => hdin1,				--: in		std_logic_vector(DATA_WIDTH-1 downto 0);
--		 wr0 					: in		std_logic;
--		 rd1					: in 		std_logic;
--		 earlyBegun0		: out		std_logic;
--		 earlyBegun1		: out		std_logic;
--		 clk_i => clk_i				--: inout	std_logic
		 );

end Behavioral;

