library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity alu is -- Arithmetic/Logic unit with add/sub, AND, OR, set less than
	 port(a, b:       in  STD_LOGIC_VECTOR(7 downto 0);
		 alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
		 result:     out STD_LOGIC_VECTOR(7 downto 0);
		 statusrego: out STD_LOGIC_VECTOR(7 downto 0);
		 statusregi: in STD_LOGIC_VECTOR(7 downto 0));
end;

architecture behave of alu is
	signal r: std_logic_vector(7 downto 0);
begin
	
	result <= r;
	with alucontrol(2 downto 0) select r <=
		a and b when "010",
		a or b  when "001",
		a xor b when "011",
		a  -  b when "110",
		a  +  b when "101",
		a			when "000",
		"--------" when others;
	 
	 statusRegUpdate:process ( r, alucontrol ) is
			variable i,t,h,s,v,n,z,c: std_logic;
	 begin
		if  alucontrol = "010" or alucontrol = "001" or alucontrol = "011" then
			n := r(7);
			v := '0';
			if r = "00000000" then
				z := '1';
			else 
				z := '0';
			end if;
			s := n xor v;
		elsif  alucontrol = "100" then
			h := (not a(3) and b(3)) or (b(3) and r(3)) or (r(3) and not a(3));

			if r = "00000000" then
				z := '1';
			else 
				z := '0';
			end if;
			v := (a(7) and not b(7)) and (not r(7) or not a(7)) and (b(7) and r(7)); 
			n := r(7);
			s := n xor v;
			c := (not a(7) and b(7)) or (b(7)and r(7)) or (r(7) and not a(7));
		elsif  alucontrol = "101" then
			h := (a(3) and b(3)) or (b(3) and not r(3)) or (not r(3) and a(3));
			n := r(7);
			v := (a(7) and b(7)) and (not r(7) or not a(7)) and (not b(7) and r(7));
			s := n xor v;
			if r = "00000000" then
				z := '1';
			else 
				z := '0';
			end if;
			c := (a(7) and b(7)) or (b(7) and not r(7)) or (not r(7) and a(7));
		else
			i := statusregi(7);
			t := statusregi(6);
			h := statusregi(5);
			s := statusregi(4);
			v := statusregi(3);
			n := statusregi(2);
			z := statusregi(1);
			c := statusregi(0);
		end if;
		statusrego <= i&t&h&s&v&n&z&c;
	 end process;
end;

