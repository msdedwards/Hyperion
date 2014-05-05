LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY memfiletestbench IS
END memfiletestbench;
 
ARCHITECTURE behavior OF memfiletestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT regfile
    PORT(
         clk : IN  std_logic;
         RegWrite : IN  std_logic;
         MemOp : IN  std_logic;
         a1 : IN  std_logic_vector(4 downto 0);
         a2 : IN  std_logic_vector(4 downto 0);
         wd : IN  std_logic_vector(7 downto 0);
         rd1 : OUT  std_logic_vector(7 downto 0);
         rd2 : OUT  std_logic_vector(7 downto 0);
         md : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal RegWrite : std_logic := '0';
   signal MemOp : std_logic := '0';
   signal a1 : std_logic_vector(4 downto 0) := (others => '0');
   signal a2 : std_logic_vector(4 downto 0) := (others => '0');
   signal wd : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal rd1 : std_logic_vector(7 downto 0);
   signal rd2 : std_logic_vector(7 downto 0);
   signal md : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: regfile PORT MAP (
          clk => clk,
          RegWrite => RegWrite,
          MemOp => MemOp,
          a1 => a1,
          a2 => a2,
          wd => wd,
          rd1 => rd1,
          rd2 => rd2,
          md => md
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
      wait for clk_period*10;
		RegWrite <= '1';
		wd <= "11111111";
		a2 <= "11111";
		
		wait for clk_period;
		RegWrite <= '1';
		wd <= "11111110";
		a2 <= "11110";
		
		wait for clk_period;
		RegWrite <= '1';
		wd <= "11110000";
		a2 <= "00000";
		
		wait for clk_period;
		RegWrite <= '0';
		MemOp <= '1';
		a2 <= "00000";
		wait;
   end process;

END;
