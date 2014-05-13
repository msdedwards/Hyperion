----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:25:55 05/05/2014 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
	port(
		op 				: in std_logic_vector(3 downto 0);
		PCSRC				: out std_logic;
		REGWRITE			: out std_logic;
		MEMOP				: out std_logic;	
		DATWRITE			: out std_logic;	
		REGSRC 			: out std_logic_vector(1 downto 0);
		aluOp				: out std_logic_vector(2 downto 0);
		statusSignals 	: in std_logic_vector(7 downto 0)
	);
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
	main: process(op)
	begin
		case op is
			when "0000" | "0011" | "0100" | "0101" | "0010" | "0110"	=> -- add and eor or sub mov
				PCSRC <= '0';
				REGWRITE <= '1';
				MEMOP <= '0';
				DATWRITE <= '0';
				REGSRC <= "10";
					case op is
						when "0000" => aluOp <= "101"; -- add
						when "0010" => aluOp <= "110"; -- sub
						when "0011" => aluOp <= "000"; -- and
						when "0100" => aluOp <= "011"; -- eor
						when "0101" => aluOp <= "001"; -- or
						when "0110" => aluOp <= "000"; -- mov
						when others => aluOp <= "---";
					end case;
			when "0001" => -- cp
				PCSRC <= '0';
				REGWRITE <= '0';
				MEMOP <= '0';
				DATWRITE <= '0';
				REGSRC <= "--";
			when "0111" => -- ld (z)
				PCSRC <= '0';
				REGWRITE <= '1';
				MEMOP <= '1';
				DATWRITE <= '0';
				REGSRC <= "01";
			when "1000" => -- st (z)
				PCSRC <= '0';
				REGWRITE <= '0';
				MEMOP <= '1';
				DATWRITE <= '1';
				REGSRC <= "01";
			when "1001" => -- LDI
				PCSRC <= '0';
				REGWRITE <= '1';
				MEMOP <= '0';
				DATWRITE <= '0';
				REGSRC <= "00";
			when others =>
				-- cry
		end case;
	end process;
end Behavioral;


