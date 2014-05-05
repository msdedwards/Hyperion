library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity regfile is
  port(clk:           in  STD_LOGIC;
       RegWrite:      in  STD_LOGIC;
		 MemOp:			 in STD_LOGIC;
       a1, a2: 		 in  STD_LOGIC_VECTOR(4 downto 0);
       wd:            in  STD_LOGIC_VECTOR(7 downto 0);
       rd1, rd2, md:  out STD_LOGIC_VECTOR(7 downto 0));
end;

architecture behave of regfile is
	type ramtype is array (31 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
	signal mem: ramtype;
begin

	-- write memory to register on falling clock edge
	process(clk) begin
		if clk'event and clk = '0' then
			if RegWrite = '1' then mem(to_integer( unsigned(a2) )) <= wd;
			end if;
		end if;
	end process;
	
	process(a1, a2, mem, MemOp) begin
		if MemOp = '1' then
			rd1 <= mem(30);
			rd2 <= mem(31);
			md <= mem( to_integer( unsigned(a2)));
		else
			rd1 <= mem(to_integer( unsigned(a1)));
			rd2 <= mem(to_integer( unsigned(a2)));
		end if;
	end process;
end;