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
--use Work.SDRAMControl.all;
use WORK.common.all;

entity DataMemory is
	port(
		clk							: 	in		std_logic;
		reset							: 	in 	std_logic;
		sw2_n							:	in		std_logic;
		pps							:	out	std_logic_vector(6 downto 3);
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
		sData							: 	inout	std_logic_vector(15 downto 0);
		DatWrite						: 	in 	std_logic;
		addr							: 	in 	std_logic_vector(15 downto 0);
		dataIn						: 	in 	std_logic_vector(7 downto 0)
	);
end DataMemory;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.SDRAM_Component_pckg.all;
--use Work.SDRAMControl.all;
use WORK.common.all;

package DataMemorypkg is 
	component DataMemory is
		port(
			clk							: 	in		std_logic;
			reset							: 	in 	std_logic;
			sw2_n							:	in		std_logic;
			pps							:	out	std_logic_vector(6 downto 3);
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
			sData							: 	inout	std_logic_vector(15 downto 0);
			DatWrite						: 	in 	std_logic;
			addr							: 	in 	std_logic_vector(15 downto 0);
			dataIn						: 	in 	std_logic_vector(7 downto 0)
		);
	end component DataMemory;
end package DataMemorypkg;

architecture Behavioral of DataMemory is
	signal clk_i: std_logic;
	signal earlyBegun1, earlyBegun0, rd1,wr0,done0,done1:std_logic;
	signal hdin0,hdin1,hdout1,hdout0: std_logic_vector(7 downto 0);
	signal haddr1,haddr0:std_logic_vector(15 downto 0);
begin
	
	mem:SDRAM_Component
	generic map(
		HADDR_WIDTH => log2(16#FF_FFFF#),
		DATA_WIDTH => 16
	)
	port map(
		 sw2_n => sw2_n,   	-- active-low pushbutton input
		 clk => clk,   	-- main clock input from external clock source
		 sclkfb => sdram_clock_in_sclkfb, 	-- feedback SDRAM clock with PCB delays
		 sclk => sdram_clock_out_sclk,
		 cke => cke,  	-- SDRAM clock-enable
		 cs_n => cs_n,  	-- SDRAM chip-select
		 ras_n => ras_n, 	-- SDRAM RAS
		 cas_n => cas_n, 	-- SDRAM CAS
		 we_n => we_n,  	-- SDRAM write-enable
		 ba => ba,  -- SDRAM bank-address
		 dqmh => dqmh,  							-- SDRAM DQMH
		 dqml => dqml,  			         				-- SDRAM DQML
		 sAddr => sAddr,	 	-- SDRAM address bus
		 sData => sData,	 	-- data bus to/from SDRAM
		 hdout0 => hdout0,	
		 hdout1 => hdout1,
		 done1 => done1,			
		 done0 => done0,	
		 haddr0 => haddr0, 	
		 haddr1 => haddr1,	
		 hdin0 => hdin0,
		 hdin1 => hdin1,		
		 wr0 => wr0,			
		 rd1 => rd1,		
		 earlyBegun0 => earlyBegun0,		
		 earlyBegun1 => earlyBegun1,
		 clk_i => clk_i	
		 );

end Behavioral;

