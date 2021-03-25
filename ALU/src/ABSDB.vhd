-------------------------------------------------------------------------------
--
-- Title       : ABSDB
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\ABSDB.vhd
-- Generated   : Wed Mar 24 23:51:34 2021
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
--{entity {ABSDB} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity ABSDB is
	 port(
		 clk : in STD_LOGIC;
		 op : in STD_LOGIC_VECTOR(9 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ABSDB;

--}} End of automatically maintained section

architecture behavioral of ABSDB is
begin

	 -- enter your statements here --

end behavioral;
