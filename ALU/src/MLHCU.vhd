-------------------------------------------------------------------------------
--
-- Title       : MLHCU
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\MLHCU.vhd
-- Generated   : Thu Mar 25 10:48:32 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MLHCU} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity MLHCU is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end MLHCU;

--}} End of automatically maintained section

architecture behavioral of MLHCU is	 
	signal res: std_logic_vector(127 downto 0);
begin			-- set each word in res to product of lower halfword of each j word and immediate in i field of opcode
	res(31 downto 0) <= "00000000000" & std_logic_vector(unsigned(j(15 downto 0)) * unsigned(op(14 downto 10)));	 
	res(63 downto 32) <= "00000000000" & std_logic_vector(unsigned(j(47 downto 32)) * unsigned(op(14 downto 10)));
	res(95 downto 64) <= "00000000000" & std_logic_vector(unsigned(j(79 downto 64)) * unsigned(op(14 downto 10)));
	res(127 downto 96) <= "00000000000" & std_logic_vector(unsigned(j(111 downto 96)) * unsigned(op(14 downto 10)));
	process (op)
	begin
		if (op = "11----1010---------------") then		   -- check for right opcode
			r <= res;
		end if;
	end process;  
end behavioral;
