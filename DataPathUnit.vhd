----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:26:18 05/05/2014 
-- Design Name: 
-- Module Name:    DataPathUnit - Behavioral 
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

entity DataPathUnit is 
		port(
			clk 				: in std_logic;
			controlSignals : in std_logic;
			statusSignals 	: inout std_logic_vector(7 downto 0);
			instr 			: in std_logic_vector(15 downto 0)
		);						
end DataPathUnit;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



architecture Behavioral of DataPathUnit is
	component Decoder
		port(
			instr:		in std_logic_vector(15 downto 0);
			imm:			out std_logic_vector(7 downto 0);
			a1, a2:		out std_logic_vector(4 downto 0);
			op:			out std_logic_vector(3 downto 0)
		);
	end component;
	component alu is
		port (a, b:       in  STD_LOGIC_VECTOR(7 downto 0);
			 alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
			 result:     inout STD_LOGIC_VECTOR(7 downto 0);
			 statusreg:	 inout STD_LOGIC_VECTOR(7 downto 0)
		 );
	end component alu;
	component regfile is
		port(
			clk:           in  STD_LOGIC;
			RegWrite:      in  STD_LOGIC;
			MemOp:			 in STD_LOGIC;
			a1, a2: 		 in  STD_LOGIC_VECTOR(4 downto 0);
			wd:            in  STD_LOGIC_VECTOR(7 downto 0);
			rd1, rd2, md:  out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component regfile;
	
	signal imm,srcA,srcB,writeData,memData,result: std_logic_vector(7 downto 0);
	signal addr1,addr2:std_logic_vector(4 downto 0);
	signal op : std_logic_vector(3 downto 0);
	signal RegWrite,MemOp: std_logic;
	signal aluControl: std_logic_vector(2 downto 0);
begin
	dec: Decoder port map (instr,imm,addr1,addr2,op);
	alu1: ALU port map (srcA,srcB,aluControl,result,statusSignals);
	reg: regfile port map (clk,RegWrite,MemOp,addr1,addr2,writeData,srcA,srcB,memData);

end Behavioral;

