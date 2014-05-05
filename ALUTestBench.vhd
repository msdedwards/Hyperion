
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALUTestBench IS
END ALUTestBench;
 
ARCHITECTURE behavior OF ALUTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         b : IN  std_logic_vector(7 downto 0);
         alucontrol : IN  std_logic_vector(2 downto 0);
         result : INOUT  std_logic_vector(7 downto 0);
         statusreg : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal b : std_logic_vector(7 downto 0) := (others => '0');
   signal alucontrol : std_logic_vector(2 downto 0) := (others => '0');

	--BiDirs
   signal result : std_logic_vector(7 downto 0);
   signal statusreg : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          a => a,
          b => b,
          alucontrol => alucontrol,
          result => result,
          statusreg => statusreg
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 
		a <= "11111110"; b <= "00000011"; alucontrol <= "101"; wait for 10 ns; -- -2 + 2 = 0
		a <= "11111111"; b <= "11111111"; alucontrol <= "110"; wait for 10 ns; -- a - b = 0
		a <= "00000001"; b <= "00000001"; alucontrol <= "000"; wait for 10 ns; -- 1 and 1 = 1
		a <= "10101010"; b <= "01010101"; alucontrol <= "001"; wait for 10 ns; -- a or b = 11111111
		a <= "10101010"; b <= "01010101"; alucontrol <= "011"; wait for 10 ns; -- a xor b = ?

      wait;
   end process;

END;
