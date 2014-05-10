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



entity AVRTop is
	port(	 clk, reset: in std_logic;
						pc: inout std_logic_vector(15 downto 0)
						
		  );
end AVRTop;

architecture Behavioral of AVRTop is
	component AVR is
		port( 
				clkMaster:out std_logic;
				clk 	: in std_logic;
				reset : in std_logic;
				instr : in std_logic_vector(15 downto 0)
		);
	end component AVR;
	signal instr: std_logic_vector(15 downto 0);
begin
	AVR1: AVR port map(clk,reset,instr);

end Behavioral;

