library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
package alu_pckg is
	component alu is -- Arithmetic/Logic unit with add/sub, AND, OR, set less than
	  port (a, b:       in  STD_LOGIC_VECTOR(7 downto 0);
			 alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
			 result:     inout STD_LOGIC_VECTOR(7 downto 0);
			 statusreg:	 inout STD_LOGIC_VECTOR(7 downto 0)
			 );
	end component alu;
end package alu_pckg;

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity alu is -- Arithmetic/Logic unit with add/sub, AND, OR, set less than
	 port(a, b:       in  STD_LOGIC_VECTOR(7 downto 0);
		 alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
		 result:     inout STD_LOGIC_VECTOR(7 downto 0);
		 statusreg:	 inout STD_LOGIC_VECTOR(7 downto 0));
end;


architecture behave of alu is
begin
  with alucontrol(2 downto 0) select result <=
    a and b when "000",
    a or b  when "001",
	 a xor b when "011",
	 a  -  b when "110",
	 a  +  b when "101",
	 "--------" when others;
end;