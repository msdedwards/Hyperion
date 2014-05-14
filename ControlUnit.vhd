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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package ControlUnitpkg is
	component ControlUnit
		port(
			op 				: in std_logic_vector(3 downto 0);
			PCSRC				: out std_logic;
			REGWRITE			: out std_logic;
			MEMOP				: out std_logic;	
			DATWRITE			: out std_logic;	
			REGSRC 			: out std_logic_vector(1 downto 0);
			statusSignals 	: in std_logic_vector(7 downto 0)
		);
	end component;
end package ControlUnitpkg;

architecture Behavioral of ControlUnit is
	signal zflag : std_logic;
begin
	zflag <= statusSignals(1);
	main: process(op, zflag)
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
				aluOp <= "110";
			when "0111" => -- ld (z)
				PCSRC <= '0';
				REGWRITE <= '1';
				MEMOP <= '1';
				DATWRITE <= '0';
				REGSRC <= "01";
				aluOp <= "---";
			when "1000" => -- st (z)
				PCSRC <= '0';
				REGWRITE <= '0';
				MEMOP <= '1';
				DATWRITE <= '1';
				REGSRC <= "01";
				aluOp <= "---";
			when "1001" => -- LDI
				PCSRC <= '0';
				REGWRITE <= '1';
				MEMOP <= '0';
				DATWRITE <= '0';
				REGSRC <= "00";
				aluOp <= "---";
			when "1010" | "1011" => -- breq brne
				REGWRITE <= '0';
				MEMOP <= '0';
				DATWRITE <= '0';
				REGSRC <= "--";
				aluOp <= "---";
				case op is
					when "1010" =>
						if zflag = '1' then
							PCSRC <= '1';
						elsif zflag = '0' then
							PCSRC <= '0';
						end if;
					when "1011" =>
						if zflag = '0' then
							PCSRC <= '1';
						elsif zflag = '1' then
							PCSRC <= '0';
						end if;
					when others =>
						PCSRC <= 'X';
				end case;
			when others =>
				PCSRC <= 'X';
				REGWRITE <= 'X';
				MEMOP <= 'X';
				DATWRITE <= 'X';
				REGSRC <= "XX";
				aluOp <= "XXX";
		end case;
	end process;
end Behavioral;


