-------------------------------------------------------------------------------
--
-- Title       : OR_128
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\OR_128.vhd
-- Generated   : Thu Mar 25 11:02:26 2021
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

entity OR_128 is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end OR_128;									  

architecture behavioral of OR_128 is
	signal res: std_logic_vector(127 downto 0);
begin  
	res <= i or j;										    -- compute i or j
	process (op)
	begin
		if (op = "11----1011---------------") then			-- check for right opcode
			r <= res;
		end if;
	end process;
							   
end behavioral;
