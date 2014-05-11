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
			op								: 	out 	std_logic_vector(3 downto 0)
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
				op								: 	out 	std_logic_vector(3 downto 0)
			);
	end component DataPathUnit;
end package DataPathUnitpkg;

architecture Behavioral of DataPathUnit is
	
	signal imm,srcA,srcB,writeData,memData,result: std_logic_vector(7 downto 0);
	signal pc,pcPlusOne,pcJump,ZeroExtImm,dataMemoryAddr,instr: std_logic_vector(15 downto 0);
	signal addr1,addr2:std_logic_vector(4 downto 0);
	signal aluControl: std_logic_vector(2 downto 0);
	
begin

	ZeroExtImm <= "00000000"&imm;
	dataMemoryAddr <= srcA&srcB;

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
		a => pc,
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
		y  => pc
	);
	dec: Decoder 
	port map 
	(
		instr => instr,
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
		dataIn => memData
	);

end Behavioral;

