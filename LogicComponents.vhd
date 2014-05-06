----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:21:44 05/06/2014 
-- Design Name: 
-- Module Name:    LogicComponents - Behavioral 
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

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
entity adder is -- adder
	generic(width: integer);
	port(a, b: in  STD_LOGIC_VECTOR(width-1 downto 0);
       y:    out STD_LOGIC_VECTOR(width-1 downto 0));
end;

library IEEE; 
use IEEE.STD_LOGIC_1164.all;
entity mux2 is -- two-input multiplexer
  generic(width: integer);
  port(d0, d1: in  STD_LOGIC_VECTOR(width-1 downto 0);
       s:      in  STD_LOGIC;
       y:      out STD_LOGIC_VECTOR(width-1 downto 0));
end;

library IEEE; 
use IEEE.STD_LOGIC_1164.all;
entity mux4 is -- four-input multiplexer
  generic(width: integer);
  port(d0, d1, d2, d3: in  STD_LOGIC_VECTOR(width-1 downto 0);
       s:      in  STD_LOGIC_VECTOR(1 downto 0);
       y:      out STD_LOGIC_VECTOR(width-1 downto 0));
end;




architecture behave of adder is
begin
  y <= a + b;
end;

architecture behave of mux2 is
begin
  y <= d0 when s = '0' else d1;
end;

architecture behave of mux4 is
begin
	with s select
		y <= d0 when "00",
			  d1 when "01",
			  d2 when "10",
			  d3 when others;
end;