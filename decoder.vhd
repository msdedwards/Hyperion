
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Decoderpkg is
	component Decoder
		port(
			instr:		in std_logic_vector(15 downto 0);
			imm:			out std_logic_vector(7 downto 0);
			a1, a2:		out std_logic_vector(4 downto 0);
			op:			out std_logic_vector(3 downto 0)
		);
	end component;
end package Decoderpkg;

architecture Behavioral of decoder is
	signal nib1, nib2, nib3, nib4: std_logic_vector(3 downto 0);
begin
	nib4 <= instr(3 downto 0);
	nib3 <= instr(7 downto 4);
	nib2 <= instr(11 downto 8);
	nib1 <= instr(15 downto 12);
	
	getop: process(nib1, nib2, nib3, nib4)
	begin
		case nib1 is
			when "0000" => op <= "0000"; -- add
			when "0001" =>
				if (nib2(3) = '0') then -- cp
					op <= "0001";
				else
					op <= "0010"; -- sub
				end if;
			when "0010" =>
				case nib2(3 downto 2) is
					when "00" => op <= "0011"; -- and
					when "01" => op <= "0100"; -- eor
					when "10" => op <= "0101"; -- or
					when "11" => op <= "0110"; -- mov
					when others => op <= "----";
				end case;
			when "1000" =>
				if (nib2(1) = '0') then
					op <= "0111"; -- ld (z)
				else
					op <= "1000"; -- st (z)
				end if;
			when "1110" => op <= "1001"; -- LDI
			when "1111" =>
				if (nib2(2) = '0') then
					op <= "1010"; -- breq
				else
					op <= "1011"; -- brne
				end if;
			when others =>
				op <= "----";
		end case;
	end process;
	
	getaddrs: process(nib1,nib2, nib3, nib4)
	begin
		case nib1 is
			when "0000" | "0001" | "0010" => -- add, cp, sub, and, eor, or, mov
				a1 <= nib2(1) & nib4;
				a2 <= nib2(0) & nib3;
			when "1110" => -- LDI 
				a1 <= "-----";
				a2 <= "1" & nib3;
			when "1000" =>
				if (nib2(1) = '1') then -- ST (z)
					a1 <= "-----";
					a2 <= nib2(0) & nib3;
				elsif (nib2(1) = '0') then -- LD (z)
					a1 <= nib2(0) & nib3;
					a2 <= "-----";
				end if;
			when others =>
				a1 <= "-----";
				a2 <= "-----";
			end case;
	end process;
	
	getimm: process(nib1, nib2, nib4)
	begin
		case nib1 is
			when "1110" => imm <= nib2 & nib4;
			when "1111" => 
				if nib2(1) = '0' then
					imm <= '0' & nib2(1 downto 0) & nib3 & nib4(3);
				else
					imm <= '1' & nib2(1 downto 0) & nib3 & nib4(3);
				end if;
			when others => imm <= "--------";
		end case;
	end process;
				 
end Behavioral;