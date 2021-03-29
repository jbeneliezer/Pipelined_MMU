-------------------------------------------------------------------------------
--
-- Title       : AND_128
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\AND_128.vhd
-- Generated   : Thu Mar 25 10:17:35 2021
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

entity AND_128 is
	 port(				   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end AND_128;								  

architecture behavioral of AND_128 is  
	signal res: std_logic_vector(127 downto 0);
begin  
	res <= i and j;											-- compute i and j
	process (op)
	begin
		if (op(24 downto 23) = "11" and op(18 downto 15) = "0101") then			-- check for right opcode
			r <= res;
		end if;
	end process;   
end behavioral;
