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
use IEEE.STD_LOGIC_1164.ALL;

entity AVR is
	port(clk: in std_logic;
			reset: in std_logic;
			instr: in std_logic_vector(15 downto 0)
			);
end AVR;

architecture Behavioral of AVR is
	component datapath
		port(
			clk: in std_logic;
			controlSignals :in std_logic;
			statusSignals : out std_logic;
			instr: in std_logic_vector(15 downto 0)
		);
	end component;
	component controller
		port(
			op : in std_logic_vector(3 downto 0);
			controlSignals : out std_logic;
			statusSignals : in std_logic
		);
	end component;
--	component decoder 
--		port(
--			instr 
--			imm 
--		);
--	end component;
begin


end Behavioral;

