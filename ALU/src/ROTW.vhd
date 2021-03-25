-------------------------------------------------------------------------------
--
-- Title       : ROTW
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\ROTW.vhd
-- Generated   : Thu Mar 25 11:33:21 2021
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

entity ROTW is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ROTW;										

architecture behavioral of ROTW is
	signal res: std_logic_vector(127 downto 0);
begin			  -- for each word in j, rotate by amount specified by lowest 5 bits i
	res(31 downto 0) <= std_logic_vector(rotate_right(unsigned(j(31 downto 0)), to_integer(unsigned(i(4 downto 0)))));  
	res(63 downto 32) <= std_logic_vector(rotate_right(unsigned(j(63 downto 32)), to_integer(unsigned(i(4 downto 0)))));
	res(95 downto 64) <= std_logic_vector(rotate_right(unsigned(j(95 downto 64)), to_integer(unsigned(i(4 downto 0)))));
	res(127 downto 96) <= std_logic_vector(rotate_right(unsigned(j(127 downto 96)), to_integer(unsigned(i(4 downto 0)))));
	process (op)
	begin
		if (op = "11----1101---------------") then			-- check for right opcode
			r <= res;
		end if;
	end process;

end behavioral;
