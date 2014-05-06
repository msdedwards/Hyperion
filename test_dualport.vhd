library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;
use WORK.test_dualport_core_pckg.all;

package test_dualport_pckg is
	component test_dualport is
		generic(
		DATA_WIDTH			: natural	:=16;
		HADDR_WIDTH 	 :			natural								:= log2(16#40_0000#)
		);
	  port(
			sw2    	: in    	std_logic;           -- active-low pushbutton input
			clk    	: in    	std_logic;           -- main clock input from external clock source
			sclkfb 	: in    	std_logic;           -- feedback SDRAM clock with PCB delays
			sclk   	: out   	std_logic;           -- clock to SDRAM
			cke    	: out   	std_logic;           -- SDRAM clock-enable
			cs_n   	: out   	std_logic;           -- SDRAM chip-select
			ras_n  	: out   	std_logic;           -- SDRAM RAS
			cas_n  	: out   	std_logic;           -- SDRAM CAS
			we_n   	: out   	std_logic;           -- SDRAM write-enable
			ba     	: out   	std_logic_vector( 1 downto 0);  -- SDRAM bank-address
			sAddr  	: out   	std_logic_vector(12 downto 0);  -- SDRAM address bus
			sData  	: inout 	std_logic_vector(15 downto 0);  -- data bus to/from SDRAM
			dqmh   	: out   	std_logic;           -- SDRAM DQMH
			dqml   	: out   	std_logic;           -- SDRAM DQML
			hdout1	: out 	std_logic_vector(DATA_WIDTH-1 downto 0);
			done1		: out 	std_logic;
			done0		: out		std_logic;
			haddr1	: in	   std_logic_vector(HADDR_WIDTH-1 downto 0);
			hdin0		: in  	std_logic_vector(DATA_WIDTH-1 downto 0);
			haddr0	: in 		std_logic_vector(HADDR_WIDTH-1 downto 0);
			wr0 		: in		std_logic;
			rd1		: in 		std_logic;
			earlyBegun0		:out		std_logic;
			earlyBegun1		:out		std_logic;
			clk_i		: inout		std_logic
		 );
	end component test_dualport;
end package test_dualport_pckg;

library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;
use WORK.test_dualport_core_pckg.all;

entity test_dualport is
	generic(
		DATA_WIDTH			: natural	:=16;
		HADDR_WIDTH 	 :			natural								:= log2(16#FF_FFFF#)
		);
  port(
		sw2    	: in    	std_logic;           -- active-low pushbutton input
		clk    	: in    	std_logic;           -- main clock input from external clock source
		sclkfb 	: in    	std_logic;           -- feedback SDRAM clock with PCB delays
		sclk   	: out   	std_logic;           -- clock to SDRAM
		cke    	: out   	std_logic;           -- SDRAM clock-enable
		cs_n   	: out   	std_logic;           -- SDRAM chip-select
		ras_n  	: out   	std_logic;           -- SDRAM RAS
		cas_n  	: out   	std_logic;           -- SDRAM CAS
		we_n   	: out   	std_logic;           -- SDRAM write-enable
		ba     	: out   	std_logic_vector( 1 downto 0);  -- SDRAM bank-address
		sAddr  	: out   	std_logic_vector(12 downto 0);  -- SDRAM address bus
		sData  	: inout 	std_logic_vector(15 downto 0);  -- data bus to/from SDRAM
		dqmh   	: out   	std_logic;           -- SDRAM DQMH
		dqml   	: out   	std_logic;           -- SDRAM DQML
		hdout1	: out 	std_logic_vector(DATA_WIDTH-1 downto 0);
		done1		: out 	std_logic;
		done0		: out		std_logic;
		haddr1	: in	   std_logic_vector(HADDR_WIDTH-1 downto 0);
		hdin0		: in  	std_logic_vector(DATA_WIDTH-1 downto 0);
		haddr0	: in 		std_logic_vector(HADDR_WIDTH-1 downto 0);
		wr0 		: in		std_logic;
		rd1		: in 		std_logic;
		earlyBegun0		:out		std_logic;
		earlyBegun1		:out		std_logic;
		clk_i		: inout		std_logic
    );
end entity;

 architecture arch of test_dualport is
begin

  u0 : test_dualport_core
    generic map(
      FREQ        => 100_000,
      CLK_DIV     => 1.0,
      PIPE_EN     => true,
      DATA_WIDTH  => sData'length,
      SADDR_WIDTH => sAddr'length,
      NROWS       => 8192,
      NCOLS       => 512,
      BEG_ADDR    => 16#00_0000#,
      END_ADDR    => 16#FF_FFFF#,
      BEG_TEST_0  => 16#00_0000#,
      END_TEST_0  => 16#7F_FFFF#,
      BEG_TEST_1  => 16#80_0000#,
      END_TEST_1  => 16#FF_FFFF#
      )
    port map(
      sw2_n    	=> sw2,
      clk         => clk,
      sclkfb      => sclkfb,
      sclk        => sclk,
      cke         => cke,
      cs_n        => cs_n,	
      ras_n       => ras_n,
      cas_n       => cas_n,
      we_n        => we_n,
      ba          => ba,
      sAddr       => sAddr,
      sData       => sData,
      dqmh        => dqmh,
      dqml        => dqml,
		hdout1		=> hdout1,
		done1			=> done1,
		done0			=> done0,
		haddr1		=> haddr1,
		hdin0			=> hdin0,
		haddr0		=> haddr0,
		wr0 			=> wr0,
		rd1			=> rd1,
		earlyBegun0 => earlyBegun0,
		earlyBegun1 => earlyBegun1,
		clk_i			=> clk_i
      );

end arch;

