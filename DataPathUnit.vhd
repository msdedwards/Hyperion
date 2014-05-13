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
			PCSRC				: in std_logic;
			REGWRITE			: in std_logic;
			MEMOP				: in std_logic;	
			DATWRITE			: in std_logic;	
			REGSRC 			: in std_logic_vector(1 downto 0);
			statusSignals 	: inout std_logic_vector(7 downto 0);
			op					: out std_logic_vector(3 downto 0);
			instr 			: out std_logic_vector(15 downto 0);
			aluControl		: in std_logic_vector(2 downto 0)
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
	component mux4 is -- four-input multiplexer
	  generic(width: integer);
	  port(d0, d1, d2, d3: in  STD_LOGIC_VECTOR(width-1 downto 0);
			 s:      in  STD_LOGIC_VECTOR(1 downto 0);
			 y:      out STD_LOGIC_VECTOR(width-1 downto 0));
	end component mux4;
	component mux2 is -- two-input multiplexer
		generic(width: integer);
		port(d0, d1: in  STD_LOGIC_VECTOR(width-1 downto 0);
			 s:      in  STD_LOGIC;
			 y:      out STD_LOGIC_VECTOR(width-1 downto 0));
	end component mux2;
	component adder is -- adder
		generic(width: integer);
		port(a, b: in  STD_LOGIC_VECTOR(width-1 downto 0);
			 y:    out STD_LOGIC_VECTOR(width-1 downto 0));
	end component adder;
	
	component pc is -- program counter
		port(clk_in: 	 in std_logic;
			  pc_in:      in  STD_LOGIC_VECTOR(15 downto 0);
			  pc_out:      out STD_LOGIC_VECTOR(15 downto 0));
	end component pc;
	
	component imem is -- instruction memory
	port(a:  in  STD_LOGIC_VECTOR(15 downto 0);
       rd: out STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	signal pc_connector: std_logic_vector(15 downto 0);
	signal imm,srcA,srcB,writeData,memData,result: std_logic_vector(7 downto 0);
	signal next_pc,pcPlusOne,pcJump,ZeroExtImm, iMemOut: std_logic_vector(15 downto 0);
	signal addr1,addr2:std_logic_vector(4 downto 0);
begin
	ZeroExtImm <= "00000000"&imm;

	RegSrcMux: mux4
	generic map(8)
	port map
	(
		d0 => imm,
		d1 => "XXXXXXXX", -- will be the out data from the data memory
		d2 => result,
		d3 => "XXXXXXXX",
		s  => REGSRC,
		y  => writeData
	);
	PCAdder:adder
	generic map(16)
	port map
	(
		a => pc_connector,
		b => "0000000000000001",
		y => pcPlusOne
	);
	JumpAdder:adder
	generic map(16)
	port map
	(
		a => ZeroExtImm,
		b => pcPlusOne,
		y => pcJump
	);
	PCMux: mux2
	generic map(16)
	port map
	(
		d0 => pcPlusOne,
		d1 => pcJump,
		s  => PCSRC,
		y  => next_pc
	);
	dec: Decoder 
	port map 
	(
		instr => iMemOut,
		imm => imm,
		a1 => addr1,
		a2 => addr2,
		op => op
	);
	alu1: ALU 
	port map 
	(
		a => srcA,
		b => srcB,
		alucontrol => aluControl,
		result => result,
		statusreg => statusSignals
	);
	reg: regfile
	port map 
	(
		clk => clk,
		RegWrite => RegWrite,
		MemOp => MemOp,
		a1 => addr1,
		a2 => addr2,
		wd => writeData,
		rd1 => srcA,
		rd2 => srcB,
		md => memData
	);
	instrmem: imem
	port map
	(
		a => pc_connector, -- address from regfile goes here
		rd => iMemOut
	);
	instr <= iMemOut;
	PCounter:pc
	port map
	(
		clk_in => clk,
		pc_in => next_pc,
		pc_out => pc_connector
	);
end Behavioral;

