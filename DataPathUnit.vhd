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
use Work.Decoderpkg.all;
use work.alupkg.all;
use work.regfilepkg.all;
use work.DataMemorypkg.all;
use work.Componentspkg.all;
use work.imempkg.all;



entity DataPathUnit is 
		port(
			clk							: 	in		std_logic;
			reset							: 	in 	std_logic;
			sw2_n							:	in		std_logic;
			pps							:	out	std_logic_vector(6 downto 3);
			led							: 	out	std_logic_vector(6 downto 0);
			sdram_clock_in_sclkfb 	:	in		std_logic;
			sdram_clock_out_sclk		:	out	std_logic;
			cke     						: 	out	std_logic;                        -- SDRAM clock-enable
			cs_n    						:	out 	std_logic;                        -- SDRAM chip-select
			ras_n   						:	out 	std_logic;                        -- SDRAM RAS
			cas_n   						: 	out 	std_logic;                        -- SDRAM CAS     
			we_n    						: 	out 	std_logic;                        -- SDRAM write-enable
			ba      						: 	out 	std_logic_vector( 1 downto 0);    -- SDRAM bank-address selects one of four banks
			dqmh    						: 	out 	std_logic;                        -- SDRAM DQMH controls upper half of data bus during read
			dqml    						: 	out 	std_logic;
			sAddr							:	out	std_logic_vector(12 downto 0);
			sData							: 	inout	std_logic_vector(15 downto 0);
			PCSRC							: 	in 	std_logic;
			REGWRITE						: 	in 	std_logic;
			MEMOP							: 	in 	std_logic;	
			DATWRITE						: 	in 	std_logic;	
			REGSRC 						: 	in 	std_logic_vector(1 downto 0);
			statusSignals 				: 	inout std_logic_vector(7 downto 0);
			op								: 	out 	std_logic_vector(3 downto 0);
			instr							: 	inout	std_logic_vector(15 downto 0);
			clk_i							:	out	std_logic
			);						

end DataPathUnit;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Work.Decoderpkg.all;
use work.alupkg.all;
use work.regfilepkg.all;
use work.DataMemorypkg.all;
use work.Componentspkg.all;


package DataPathUnitpkg is
	component DataPathUnit
			port(
				clk							: 	in		std_logic;
				reset							: 	in 	std_logic;
				sw2_n							:	in		std_logic;
				pps							:	out	std_logic_vector(6 downto 3);
				led							: 	out	std_logic_vector(6 downto 0);
				sdram_clock_in_sclkfb 	:	in		std_logic;
				sdram_clock_out_sclk		:	out	std_logic;
				cke     						: 	out	std_logic;                        -- SDRAM clock-enable
				cs_n    						:	out 	std_logic;                        -- SDRAM chip-select
				ras_n   						:	out 	std_logic;                        -- SDRAM RAS
				cas_n   						: 	out 	std_logic;                        -- SDRAM CAS     
				we_n    						: 	out 	std_logic;                        -- SDRAM write-enable
				ba      						: 	out 	std_logic_vector( 1 downto 0);    -- SDRAM bank-address selects one of four banks
				dqmh    						: 	out 	std_logic;                        -- SDRAM DQMH controls upper half of data bus during read
				dqml    						: 	out 	std_logic;
				sAddr							:	out	std_logic_vector(12 downto 0);
				sData							: 	inout	std_logic_vector(15 downto 0);
				PCSRC							: 	in 	std_logic;
				REGWRITE						: 	in 	std_logic;
				MEMOP							: 	in 	std_logic;	
				DATWRITE						: 	in 	std_logic;	
				REGSRC 						: 	in 	std_logic_vector(1 downto 0);
				statusSignals 				: 	inout std_logic_vector(7 downto 0);
				op								: 	out 	std_logic_vector(3 downto 0);
				instr							: 	in		std_logic_vector(15 downto 0);
				clk_i							:	out	std_logic
			);
	end component DataPathUnit;
end package DataPathUnitpkg;

architecture Behavioral of DataPathUnit is
	
--	component pc is -- program counter
--		port(clk_in: 	 in std_logic;
--			  pc_in:      in  STD_LOGIC_VECTOR(15 downto 0);
--			  pc_out:      out STD_LOGIC_VECTOR(15 downto 0));
--	end component pc;
--	
--	component imem is -- instruction memory
--	port(a:  in  STD_LOGIC_VECTOR(15 downto 0);
--       rd: out STD_LOGIC_VECTOR(15 downto 0));
--	end component;
	
	signal pc_connector: std_logic_vector(15 downto 0);
	signal imm,srcA,srcB,writeData,memDataIn,memDataOut,result: std_logic_vector(7 downto 0);
	signal iMemSignalOut: std_logic_vector(15 downto 0);
	signal next_pc,pcPlusOne,pcJump,ZeroExtImm,dataMemoryAddr: std_logic_vector(15 downto 0);
	signal addr1,addr2:std_logic_vector(4 downto 0);
	signal aluControl: std_logic_vector(2 downto 0);
	signal clk_internal: std_logic;
	
begin
	clk_i <= clk_internal;
	ZeroExtImm <= "00000000"&imm;
	dataMemoryAddr <= srcA&srcB;
	RegSrcMux: mux4
	generic map(8)
	port map
	(
		d0 => imm,
		d1 => memDataOut, -- will be the out data from the data memory
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
		instr => iMemSignalOut,
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
		clk => clk_internal,
		RegWrite => RegWrite,
		MemOp => MemOp,
		a1 => addr1,
		a2 => addr2,
		wd => writeData,
		rd1 => srcA,
		rd2 => srcB,
		md => memDataIn
	);
	dm : DataMemory
	port map
	(
		clk => clk,				
		reset => reset,				
		sw2_n => sw2_n,			
		pps => pps,			
		sdram_clock_in_sclkfb => sdram_clock_in_sclkfb,
		sdram_clock_out_sclk	=> sdram_clock_out_sclk,
		cke => cke,
		cs_n => cs_n,				
		ras_n => ras_n,				
		cas_n => cas_n,			
		we_n => we_n,			
		ba => ba,				
		dqmh => dqmh,					
		dqml => dqml,				
		sAddr => sAddr,				
		sData => sData,								
		DatWrite => DATWRITE,
		addr => dataMemoryAddr,
		dataIn => memDataIn,
		clk_i => clk_internal,
		dataOut => memDataOut
	);
	instrmem: imem
	port map
	(
		a => pc_connector, -- address from regfile goes here
		rd => iMemSignalOut
	);
	instr <= iMemSignalOut;
	PCounter:pc
	port map
	(
		clk_in => clk_internal,
		pc_in => next_pc,
		pc_out => pc_connector
	);
end Behavioral;

