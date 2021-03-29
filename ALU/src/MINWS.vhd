-------------------------------------------------------------------------------
--
-- Title       : MINWS
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\MINWS.vhd
-- Generated   : Thu Mar 25 10:39:25 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------	 

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity MINWS is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end MINWS;									 

architecture behavioral of MINWS is	 
	signal res: std_logic_vector(127 downto 0);
begin		-- set each word of res to min of corresponding	i and j words
	min0: process (i(31 downto 0), j(31 downto 0))
	begin
		if (signed(i(31 downto 0)) < signed(j(31 downto 0))) then
			res(31 downto 0) <= i(31 downto 0);
		else
			res(31 downto 0) <= j(31 downto 0);  
		end if;
	end process;
	
	min1: process(i(63 downto 32), j(63 downto 32))
	begin 
		if (signed(i(63 downto 32)) < signed(j(63 downto 32))) then
			r(63 downto 32) <= i(63 downto 32);
		else
			r(63 downto 32) <= j(63 downto 32);  
		end if;
	end process;
		
	min2: process(i(95 downto 64), j(95 downto 64))
	begin
		if (signed(i(95 downto 64)) < signed(j(95 downto 64))) then
			r(95 downto 64) <= i(95 downto 64);
		else
			r(95 downto 64) <= j(95 downto 64);  
		end if;
	end process;
		
	min3: process(i(127 downto 96), j(127 downto 96))
	begin
		if (signed(i(127 downto 96)) < signed(j(127 downto 96))) then
			r(127 downto 96) <= i(127 downto 96);
		else
			r(127 downto 96) <= j(127 downto 96);  
		end if;	
	end process;
		
	process (op)
	begin
		if (op(24 downto 23) = "11" and op(18 downto 15) = "1000") then		  -- check for right opcode
			r <= res;  
		end if;
	end process;

end behavioral;
