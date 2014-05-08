----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:26:09 05/05/2014 
-- Design Name: 
-- Module Name:    StatusRegister - Behavioral 
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

entity StatusRegister is
	port(
		clk				: in std_logic;
		currentValue 	: in std_logic_vector(7 downto 0);
		nextValue		: out std_logic_vector(7 downto 0)
	);
end StatusRegister;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



architecture Behavioral of StatusRegister is
	signal reg: std_logic_vector(7 downto 0);
begin
	-- lock in new value on falling clock
	process(clk) begin
		if clk'event and clk = '0' then
			reg <= nextValue;
		end if;
	end process;
	
	-- output current value
	currentValue <= reg;
end Behavioral;

