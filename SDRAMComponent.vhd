----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:16:49 02/26/2014 
-- Design Name: 
-- Module Name:    SDRAM_Component - Behavioral 
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
use work.common.all; 	
use WORK.test_dualport_core_pckg.all;
--use Work.SDRAMControl.all;
                     	
                     	
entity SDRAM_Component is
	generic(
			HADDR_WIDTH 	 :	natural	:= log2(16#FF_FFFF#);
			DATA_WIDTH      : natural 	:= 8
		);                	
	port(
		 sw2_n    								: in    	std_logic;           				-- active-low pushbutton input
		 clk    									: in    	std_logic;          					-- main clock input from external clock source
		 sclkfb 									: in    	std_logic;          					-- feedback SDRAM clock with PCB delays
		 sclk   									: out   	std_logic;          					-- clock to SDRAM
		 cke    									: out   	std_logic;          					-- SDRAM clock-enable
		 cs_n   									: out   	std_logic;          					-- SDRAM chip-select
		 ras_n  									: out   	std_logic;          					-- SDRAM RAS
		 cas_n  									: out   	std_logic;          					-- SDRAM CAS
		 we_n   									: out   	std_logic;          					-- SDRAM write-enable
		 ba     									: out   	std_logic_vector( 1 downto 0); 	-- SDRAM bank-address
		 sAddr  									: out   	std_logic_vector(12 downto 0);  	-- SDRAM address bus
		 sData  									: inout 	std_logic_vector(15 downto 0);  	-- data bus to/from SDRAM
		 dqmh   									: out   	std_logic;           				-- SDRAM DQMH
		 dqml   									: out   	std_logic;           				-- SDRAM DQML
		 hdout0									: out		std_logic_vector(7 downto 0);
		 hdout1									: out 	std_logic_vector(7 downto 0);
		 done1									: out 	std_logic;
		 done0									: out		std_logic;
		 haddr0									: in 		std_logic_vector(15 downto 0);
		 haddr1									: in	   std_logic_vector(15 downto 0);
		 hdin0									: in  	std_logic_vector(7 downto 0);
		 hdin1									: in 		std_logic_vector(7 downto 0);
		 wr0 										: in		std_logic;
		 rd1										: in 		std_logic;
		 earlyBegun0							: out		std_logic;
		 earlyBegun1							: out		std_logic;
		 clk_i									: inout	std_logic
		 );
end SDRAM_Component;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.common.all;
use WORK.test_dualport_core_pckg.all;
--use Work.SDRAMControl.all;

package SDRAM_Component_pckg is
	component SDRAM_Component 
		generic(
			HADDR_WIDTH 	 :	natural	:= log2(16#FF_FFFF#);
			DATA_WIDTH      : natural 	:= 8
		);
		port(
		 sw2_n    								: in    	std_logic;           				-- active-low pushbutton input
		 clk    									: in    	std_logic;          					-- main clock input from external clock source
		 sclkfb 									: in    	std_logic;          					-- feedback SDRAM clock with PCB delays
		 sclk   									: out   	std_logic;          					-- clock to SDRAM
		 cke    									: out   	std_logic;          					-- SDRAM clock-enable
		 cs_n   									: out   	std_logic;          					-- SDRAM chip-select
		 ras_n  									: out   	std_logic;          					-- SDRAM RAS
		 cas_n  									: out   	std_logic;          					-- SDRAM CAS
		 we_n   									: out   	std_logic;          					-- SDRAM write-enable
		 ba     									: out   	std_logic_vector( 1 downto 0); 	-- SDRAM bank-address
		 sAddr  									: out   	std_logic_vector(12 downto 0);  	-- SDRAM address bus
		 sData  									: inout 	std_logic_vector(15 downto 0);  	-- data bus to/from SDRAM
		 dqmh   									: out   	std_logic;           				-- SDRAM DQMH
		 dqml   									: out   	std_logic;           				-- SDRAM DQML
		 hdout0									: out		std_logic_vector(7 downto 0);
		 hdout1									: out 	std_logic_vector(7 downto 0);
		 done1									: out 	std_logic;
		 done0									: out		std_logic;
		 haddr0									: in 		std_logic_vector(15 downto 0);
		 haddr1									: in	   std_logic_vector(15 downto 0);
		 hdin0									: in  	std_logic_vector(7 downto 0);
		 hdin1									: in 		std_logic_vector(7 downto 0);
		 wr0 										: in		std_logic;
		 rd1										: in 		std_logic;
		 earlyBegun0							: out		std_logic;
		 earlyBegun1							: out		std_logic;
		 clk_i									: inout	std_logic
			 );         	
	end component SDRAM_Component;
end package SDRAM_Component_pckg;


architecture Behavioral of SDRAM_Component is
	signal hdin016,hdin116: std_logic_vector(15 downto 0);
	signal hdout016,hdout116: std_logic_vector(15 downto 0);
	signal haddr0Ext,haddr1Ext : std_logic_vector(HADDR_WIDTH-1 downto 0);
begin
	hdin016 <= "00000000"&hdin0;
	hdin116 <= "00000000"&hdin1;
	haddr0Ext <= "00000000"&haddr0;
	haddr1Ext <= "00000000"&haddr1;
	u0 : test_dualport_core
    generic map(
      FREQ        => 100_000,
      CLK_DIV     => 1.0,
      PIPE_EN     => true,
      --DATA_WIDTH  => sData'length,
      SADDR_WIDTH => sAddr'length,
		HADDR_WIDTH => HADDR_WIDTH,--haddr0'length,
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
      sw2_n    	=> sw2_n,
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
		hdout0		=> hdout016,
		hdout1		=> hdout116,
		done1			=> done1,
		done0			=> done0,
		haddr0		=> haddr0Ext,
		haddr1		=> haddr1Ext,
		hdin0			=> hdin016,
		hdin1			=> hdin116,
		wr0 			=> wr0,
		wr1			=> '0',
		rd0			=> '0',
		rd1			=> rd1,
		earlyBegun0 => earlyBegun0,
		earlyBegun1 => earlyBegun1,
		clk_i			=> clk_i
      );

end Behavioral;



