-------------------------------------------------------------------------------
--
-- Title       : SLIMSHS
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\SLIMSHS.vhd
-- Generated   : Wed Mar 24 23:42:29 2021
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

entity SLIMSHS is
	 port(					   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end SLIMSHS;								

architecture behavioral of SLIMSHS is
	signal res: std_logic_vector(127 downto 0);
	component MULT_SUB_L is
		 port(
			 x : in STD_LOGIC_VECTOR(31 downto 0);
			 y : in STD_LOGIC_VECTOR(31 downto 0);
			 z : in STD_LOGIC_VECTOR(63 downto 0);
			 result : out STD_LOGIC_VECTOR(63 downto 0)
		     );
	end component;
begin	  	-- multiply upper words of i and j longs, and subtract from k longs
	SLIMSHS_0: MULT_SUB_L port map (x => i(63 downto 32), y => j(63 downto 32), z => k(63 downto 0), result => res(63 downto 0));
	SLIMSHS_1: MULT_SUB_L port map (x => i(127 downto 96), y => j(127 downto 96), z => k(127 downto 64), result => res(127 downto 64)); 
	process (op)
	begin
		if (op(24 downto 20) = "10111") then		  -- check for right opcode
			r <= res;
		end if;
	end process;
							   

end behavioral;
