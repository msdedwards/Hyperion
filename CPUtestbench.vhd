LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CPUtestbench IS
END CPUtestbench;
 
ARCHITECTURE behavior OF CPUtestbench IS 
 
    component AVR is
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
				sData							: 	inout	std_logic_vector(15 downto 0)
		);
	end component AVR;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AVR
	port map( 
				clk => clk,							
				reset	=> reset,						
				sw2_n => '0',							
--				pps => "000",							
--				led => "000000",							
				sdram_clock_in_sclkfb => '0'
--				sdram_clock_out_sclk	=> '0',
--				cke => '0',
--				cs_n => '0',				
--				ras_n => '0',   						
--				cas_n => '0',   						
--				we_n => '0',    						
--				ba => "00",      						
--				dqmh => '0',    						
--				dqml => '0',    						
--				sAddr => "0000000000000",							
--				sData => "0000000000000000"							
		);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
