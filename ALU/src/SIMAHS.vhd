-------------------------------------------------------------------------------
--
-- Title       : SIMAHS
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\SIMAHS.vhd
-- Generated   : Wed Mar 24 23:14:55 2021
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

entity SIMAHS is
	 port(					
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end SIMAHS;											 

architecture behavioral of SIMAHS is
	signal res: std_logic_vector(127 downto 0);
	component MULT_ADD_I is
	 	port(
		 	x : in STD_LOGIC_VECTOR(15 downto 0);
		 	y : in STD_LOGIC_VECTOR(15 downto 0);
		 	z : in STD_LOGIC_VECTOR(31 downto 0);
		 	result : out STD_LOGIC_VECTOR(31 downto 0)
	     	);
	end component;
begin		-- multiply upper halves of i and j words, and add to k words
	SIMAHS_0: MULT_ADD_I port map (x => i(31 downto 16), y => j(31 downto 16), z => k(31 downto 0), result => res(31 downto 0));
	SIMAHS_1: MULT_ADD_I port map (x => i(63 downto 48), y => j(63 downto 48), z => k(63 downto 32), result => res(63 downto 32));
	SIMAHS_2: MULT_ADD_I port map (x => i(95 downto 80), y => j(95 downto 80), z => k(95 downto 64), result => res(95 downto 64));
	SIMAHS_3: MULT_ADD_I port map (x => i(127 downto 112), y => j(127 downto 112), z => k(127 downto 96), result => res(127 downto 96));
	process (op)
	begin
		if (op(24 downto 20) = "10001") then		 -- check for right opcode
			r <= res;
		end if;
	end process;

end behavioral;
