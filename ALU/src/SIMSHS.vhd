-------------------------------------------------------------------------------
--
-- Title       : SIMSHS
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\SIMSHS.vhd
-- Generated   : Wed Mar 24 23:24:52 2021
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

entity SIMSHS is
	 port(					 
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end SIMSHS;									 

architecture behavioral of SIMSHS is
	signal res: std_logic_vector(127 downto 0);
	component MULT_SUB_I is
		 port(
			 x : in STD_LOGIC_VECTOR(15 downto 0);
			 y : in STD_LOGIC_VECTOR(15 downto 0);
			 z : in STD_LOGIC_VECTOR(31 downto 0);
			 result : out STD_LOGIC_VECTOR(31 downto 0)
		     );
	end component;
begin		-- multiply upper halves of i and j words, and subtract from k words
	SIMSHS_0: MULT_SUB_I port map (x => i(31 downto 16), y => j(31 downto 16), z => k(31 downto 0), result => res(31 downto 0));
	SIMSHS_1: MULT_SUB_I port map (x => i(63 downto 48), y => j(63 downto 48), z => k(63 downto 32), result => res(63 downto 32));
	SIMSHS_2: MULT_SUB_I port map (x => i(95 downto 80), y => j(95 downto 80), z => k(95 downto 64), result => res(95 downto 64));
	SIMSHS_3: MULT_SUB_I port map (x => i(127 downto 112), y => j(127 downto 112), z => k(127 downto 96), result => res(127 downto 96));	  
	
	process (op)
	begin
		if (op = "10011--------------------") then		 -- check for right opcode
			r <= res;
		end if;
	end process;

end behavioral;
