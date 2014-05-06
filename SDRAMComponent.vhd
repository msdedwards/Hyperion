----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:16:49 02/26/2014 
-- Design Name: 
-- Module Name:    SDRAM_Component - Behavioral 
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
use work.common.all;
use WORK.test_dualport_pckg.all;

package SDRAM_Component_pckg is
	component SDRAM_Component 
		generic(
			HADDR_WIDTH 	 :	natural	:= log2(16#FF_FFFF#);
			DATA_WIDTH      : natural 	:= 16
		);
		port(
			 sw2    			: in    		std_logic;           				-- active-low pushbutton input
			 clk    			: in    		std_logic;          					-- main clock input from external clock source
			 sclkfb 			: in    		std_logic;           				-- feedback SDRAM clock with PCB delays
			 sData  			: inout 		std_logic_vector(15 downto 0);  	-- data bus to/from SDRAM
			 sclk   			: out   		std_logic;          					-- clock to SDRAM
			 cke    			: out   		std_logic;          					-- SDRAM clock-enable
			 cs_n   			: out   		std_logic;          					-- SDRAM chip-select
			 ras_n  			: out   		std_logic;          					-- SDRAM RAS
			 cas_n  			: out   		std_logic;          					-- SDRAM CAS
			 we_n   			: out   		std_logic;          					-- SDRAM write-enable
			 ba     			: out   		std_logic_vector( 1 downto 0);  	-- SDRAM bank-address
			 sAddr  			: out   		std_logic_vector(12 downto 0);  	-- SDRAM address bus
			 dqmh   			: out   		std_logic;          					-- SDRAM DQMH
			 dqml   			: out   		std_logic;           				-- SDRAM DQML
			 hdout1			: out 		std_logic_vector(DATA_WIDTH-1 downto 0);
			 done1			: out 		std_logic;
			 done0			: out			std_logic;
			 haddr1			: in	   	std_logic_vector(HADDR_WIDTH-1 downto 0);
			 hdin0			: in  		std_logic_vector(DATA_WIDTH-1 downto 0);
			 haddr0			: in 			std_logic_vector(HADDR_WIDTH-1 downto 0);
			 wr0 				: in			std_logic;
			 rd1				: in			std_logic;
			 earlyBegun0	: out			std_logic;
			 earlyBegun1	: out			std_logic;
			 clk_i			: inout		std_logic
			 );
	end component SDRAM_Component;
end package SDRAM_Component_pckg;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.common.all;
use WORK.test_dualport_pckg.all;


entity SDRAM_Component is
	generic(
		HADDR_WIDTH 	 :			natural	:= log2(16#FF_FFFF#);
		DATA_WIDTH      :       natural  := 16
	);
	port(
		 sw2    				: in    	std_logic;           				-- active-low pushbutton input
		 clk    				: in    	std_logic;          					-- main clock input from external clock source
		 sclkfb 				: in    	std_logic;          					-- feedback SDRAM clock with PCB delays
		 sclk   				: out   	std_logic;          					-- clock to SDRAM
		 cke    				: out   	std_logic;          					-- SDRAM clock-enable
		 cs_n   				: out   	std_logic;          					-- SDRAM chip-select
		 ras_n  				: out   	std_logic;          					-- SDRAM RAS
		 cas_n  				: out   	std_logic;          					-- SDRAM CAS
		 we_n   				: out   	std_logic;          					-- SDRAM write-enable
		 ba     				: out   	std_logic_vector( 1 downto 0); 	-- SDRAM bank-address
		 sAddr  				: out   	std_logic_vector(12 downto 0);  	-- SDRAM address bus
		 sData  				: inout 	std_logic_vector(15 downto 0);  	-- data bus to/from SDRAM
		 dqmh   				: out   	std_logic;           				-- SDRAM DQMH
		 dqml   				: out   	std_logic;           				-- SDRAM DQML
		 hdout1				: out 	std_logic_vector(DATA_WIDTH-1 downto 0);
		 done1				: out 	std_logic;
		 done0				: out		std_logic;
		 haddr1				: in	   std_logic_vector(HADDR_WIDTH-1 downto 0);
		 hdin0				: in  	std_logic_vector(DATA_WIDTH-1 downto 0);
		 haddr0				: in 		std_logic_vector(HADDR_WIDTH-1 downto 0);
		 wr0 					: in		std_logic;
		 rd1					: in 		std_logic;
		 earlyBegun0		: out		std_logic;
		 earlyBegun1		: out		std_logic;
		 clk_i				: inout	std_logic
		 );
end SDRAM_Component;

architecture Behavioral of SDRAM_Component is
begin
	uo :test_dualport
	generic map(
		HADDR_WIDTH 	 => HADDR_WIDTH,
		DATA_WIDTH      => DATA_WIDTH
		)
	  port map(
		 sw2    			=> sw2,
		 clk    			=> clk,
		 sclkfb 			=> sclkfb,
		 sclk   			=> sclk,
		 cke    			=> cke,
		 cs_n   			=> cs_n,
		 ras_n  			=> ras_n,
		 cas_n  			=> cas_n,
		 we_n   			=> we_n,
		 ba     			=> ba,
		 sAddr  			=> sAddr,
		 sData  			=> sData,
		 dqmh   			=> dqmh,
		 dqml   			=> dqml,
		 hdout1 			=> hdout1,
		 done1  			=> done1,	
		 done0  			=> done0,	
		 haddr1 			=> haddr1,	
		 hdin0  			=> hdin0,		
		 haddr0 			=> haddr0,	
		 wr0 	  			=> wr0,
		 rd1	  			=> rd1,
		 earlyBegun0 	=> earlyBegun0,
		 earlyBegun1 	=> earlyBegun1,
		 clk_i			=> clk_i
		 );

end Behavioral;



