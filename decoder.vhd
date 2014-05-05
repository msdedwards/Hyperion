
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
	port(
			instr:		in std_logic_vector(15 downto 0);
			imm:			out std_logic_vector(7 downto 0);
			a1, a2:		out std_logic_vector(4 downto 0);
			op:			out std_logic_vector(3 downto 0)
		);
end Decoder;


architecture Behavioral of decoder is
	signal nib1, nib2, nib3, nib4: std_logic_vector(3 downto 0);
begin
	nib4 <= instr(3 downto 0);
	nib3 <= instr(7 downto 4);
	nib2 <= instr(11 downto 8);
	nib1 <= instr(15 downto 12);
	
	getimm: process(nib1, nib2, nib4)
	begin
		case nib1 is
			when "1110" => imm <= nib2 & nib4;
			when others => imm <= "--------";
		end case;
	end process;
				 
end Behavioral;