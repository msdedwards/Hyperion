------------------------------------------------------------------------------
-- Data Memory
------------------------------------------------------------------------------

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;  
use IEEE.NUMERIC_STD.all;

------------------------------------------------------------------------------
-- Instruction Memory
------------------------------------------------------------------------------

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;  
use IEEE.NUMERIC_STD.all;

entity imem is -- instruction memory
  port(a:  in  STD_LOGIC_VECTOR(15 downto 0);
       rd: out STD_LOGIC_VECTOR(15 downto 0)
		 );
end;

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;  
use IEEE.NUMERIC_STD.all;

package imempkg is 
	component imem is -- instruction memory
	  port(a:  in  STD_LOGIC_VECTOR(15 downto 0);
			 rd: out STD_LOGIC_VECTOR(15 downto 0)
			 );
	end component;
end package imempkg;

architecture behave of imem is
    type ramtype is array (63 downto 0) of STD_LOGIC_VECTOR(15 downto 0);

    -- function to initialize the instruction memory from a data file
    impure function InitRamFromFile ( RamFileName : in string ) return RamType is
	      variable ch: character;
         variable index : integer; 
			variable result: signed(15 downto 0);
			variable tmpResult: signed(31 downto 0);
	      file mem_file: TEXT is in RamFileName;
         variable L: line;
			variable RAM : ramtype;
			begin
				 -- initialize memory from a file
				 for i in 0 to 63 loop -- set all contents low
					RAM(i) := std_logic_vector(to_unsigned(0, 16));
				 end loop;
				 index := 0; 
				 while not endfile(mem_file) loop
				   -- read the next line from the file
					readline(mem_file, L);
				
  				   result := to_signed(0,16);
					for i in 1 to 4 loop  
					  -- read character from the line just read
					  read(L, ch);
					  --  convert character to a binary value from a hex value
					  if '0' <= ch and ch <= '9' then 
							tmpResult := result*16 + character'pos(ch) - character'pos('0') ;
							result := tmpResult(15 downto 0);
					  elsif 'a' <= ch and ch <= 'f' then
							tmpResult := result*16 + character'pos(ch) - character'pos('a')+10 ;
							result := tmpResult(15 downto 0);
					  else report "Format error on line " & integer'image(index)
							 severity error;
					  end if;
					end loop;
					
					-- set the 16 bit binary value in ram
					RAM(index) := std_logic_vector(result);
					index := index + 1;
				 end loop;
				 
				 -- return the array of instructions loaded in RAM
	          return RAM; 
	      end function;
begin
  process ( a ) is
    -- use the impure function to read RAM from a file and store in the FPGA's ram memory
  	 variable mem: ramtype := InitRamFromFile("memfile.dat");
  begin
      rd <= mem( to_integer(unsigned(a)) );
  end process;
end behave;
