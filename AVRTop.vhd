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
use work.AVRpkg.all;



entity AVRTop is
	port(	 	
				clk							: 	in		std_logic;
				rst_n							: 	in 	std_logic;
				ce_n							:	out	std_logic;
				sw2_n							:	in		std_logic;
				pps							:	out	std_logic_vector(6 downto 3);
				led							: 	out	std_logic_vector(6 downto 0);
				sclkfb 						:	in		std_logic;
				sclk							:	out	std_logic;
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
end AVRTop;

architecture Behavioral of AVRTop is
begin
	ce_n <= '1';
	AVR1: AVR
	port map(
			clk => clk,
			reset	=> rst_n,
			sw2_n	=> sw2_n,
			pps => pps,
			led => led,
			sdram_clock_in_sclkfb => sclkfb,
			sdram_clock_out_sclk	=> sclk,
			cke => cke,
			cs_n => cs_n,
			ras_n => ras_n,
			cas_n => cas_n,  
			we_n  => we_n,
			ba => ba,
			dqmh => dqmh,
			dqml => dqml,
			sAddr	=> sAddr,
			sData	=> sData
		);

end Behavioral;

