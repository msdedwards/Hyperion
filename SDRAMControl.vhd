----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:34:26 05/08/2014 
-- Design Name: 
-- Module Name:    SDRAMControl - Behavioral 
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

package SDRAMControl is
	type SDRAMControlPinsOut is record
		sclk			: std_logic;
		cke     		: std_logic;                        -- SDRAM clock-enable
		cs_n   		: std_logic;                        -- SDRAM chip-select
		ras_n   		: std_logic;                        -- SDRAM RAS
		cas_n   		: std_logic;                        -- SDRAM CAS     
		we_n    		: std_logic;                        -- SDRAM write-enable
		ba      		: std_logic_vector( 1 downto 0);    -- SDRAM bank-address selects one of four banks
		dqmh    		: std_logic;                        -- SDRAM DQMH controls upper half of data bus during read
		dqml    		: std_logic;                        -- SDRAM DQML controls lower half of data bus during read   
		done0			: std_logic;
		done1			: std_logic;
		earlyBegun0 : std_logic;
		earlyBegun1 : std_logic;
		begun0		: std_logic;
		begun1		: std_logic;
		rdPending0	: std_logic;
		rdPending1	: std_logic;
		rdDone0		: std_logic;
		rdDone1		: std_logic;
		hdout0		: std_logic_vector(7 downto 0);
		hdout1		: std_logic_vector(7 downto 0);
		sAddr			: std_logic_vector(12 downto 0);
	end record SDRAMControlPinsOut;
	
	type SDRAMControlPinsIn is record
		clk			: std_logic;
		sw2_n			: std_logic;
		sclkfb		: std_logic;
		wr0			: std_logic;
		wr1			: std_logic;
		rd0			: std_logic;
		rd1			: std_logic;
		hdin0			: std_logic_vector(7 downto 0);
		hdin1			: std_logic_vector(7 downto 0);
		haddr0		: std_logic_vector(23 downto 0);
		haddr1		: std_logic_vector(23 downto 0);
	end record SDRAMControlPinsIn;
	
	type SDRAMControlPinsInOut is record
		sData			: std_logic_vector(7 downto 0);
		clk_i			: std_logic;
	end record SDRAMControlPinsInOut;
end package SDRAMControl;    
