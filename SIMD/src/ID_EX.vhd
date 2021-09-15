-------------------------------------------------------------------------------
--
-- Title       : ID_EX
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\ID_EX.vhd
-- Generated   : Mon May  3 20:41:00 2021
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
--{entity {ID_EX} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;
use work.data_types.all;

entity ID_EX is
	 port(
		 clk : in std_logic;
		 rst : in std_logic;
		 D: in idex;
		 Q: out idex
	     );
end ID_EX;					  

architecture behavioral of ID_EX is
begin
	process(clk, rst)
	begin
		if rst = '1' then
			Q <= idex_clr;  	-- reset
		elsif rising_edge(clk) then
			Q <= D;					-- set
		end if;
	end process;

end behavioral;
