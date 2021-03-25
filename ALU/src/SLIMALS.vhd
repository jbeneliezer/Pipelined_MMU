-------------------------------------------------------------------------------
--
-- Title       : SLIMALS
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\SLIMALS.vhd
-- Generated   : Wed Mar 24 23:28:26 2021
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

entity SLIMALS is
	 port(				   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end SLIMALS;									  

architecture behavioral of SLIMALS is
	signal res: std_logic_vector(127 downto 0);
	component MULT_ADD_L is
		 port(
			 x : in STD_LOGIC_VECTOR(31 downto 0);
			 y : in STD_LOGIC_VECTOR(31 downto 0);
			 z : in STD_LOGIC_VECTOR(63 downto 0);
			 result : out STD_LOGIC_VECTOR(63 downto 0)
		     );
	end component;
begin	   -- multiply lower words of i and j longs, and add to k longs
	SLIMALS_0: MULT_ADD_L port map (x => i(31 downto 0), y => j(31 downto 0), z => k(63 downto 0), result => res(63 downto 0));
	SLIMALS_1: MULT_ADD_L port map (x => i(95 downto 64), y => j(95 downto 64), z => k(127 downto 64), result => res(127 downto 64)); 
	
	process (op)
	begin
		if (op = "10100--------------------") then		  -- check for right opcode
			r <= res;
		end if;
	end process;

end behavioral;
